package src.actionPhase {
	import flash.display.Sprite;
	import starling.textures.Texture;
	import starling.utils.AssetManager;
	import src.Game;
	import starling.display.Button;
	import starling.events.TouchEvent;
	import starling.events.Touch;
	import starling.events.Event;
	import starling.events.TouchPhase;
	import src.actionPhase.PopupController;
	import starling.core.Starling;
	import starling.animation.DelayedCall;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.geom.Rectangle;
	import flash.system.Capabilities;
	import starling.display.DisplayObject;
	import starling.text.TextField;
	import starling.display.Sprite;
	import starling.display.Image;
	import src.global.*;
	import src.display.*;
	import src.actionPhase.PauseTimer;
	
	/**
	* class PopupButton is a popup-button in the actionScreen. There are three kinds of PopupButtons:
	* - Touch
	* - Kiss
	* - Sex
	*/
	public class PopupButton extends BasicButton {
		
		// Enum values
		public static const POPUP_TOUCH: int = 0;
		public static const POPUP_KISS: int = 1;
		public static const POPUP_SEX: int = 2;

		// Base values, altered by the ActionValues modifiers upon creation of the button
		public static const RISK_SEX: Number = 0.20;
		public static const PLEASURE_SEX: Number = 0.03;
		public static const PLEASURE_KISS: Number = 0.02;
		public static const PLEASURE_TOUCH: Number = 0.015;
		
		// The popupController that controls this popupButton
		private var popupController: PopupController;
		// The kind of popup this is
		private var popupKind: int;
		
		// The risk that's given when clicking this PopupButton
		private var risk: Number = 0.00;
		// The pleasure that's given when clicking this PopupButton
		private var pleasure: Number = 0.00;
		
		// The timer that handles the time until this PopupButton is removed after creation
		private var removeTimer: PauseTimer;
		
		// Values used for display of the amount of times this popupButton has to be clicked
		private var field : TextField;
		private var circle : Image;
		
		// The maximum amount of times it will generate a random spot in the popupArea before just removing this popupButton
		// (if all tries fail. A try fails when the popup would clash with another popup.
		private static const maxRandomSpotTries: int = 100;
		
		
		/**
		* Constructor PopupButton
		*
		* @param	PopupController	The popupController this popup will be a part of
		* @param	popupKind	The kind of popup this should be
		*/
		public function PopupButton(popupController: PopupController, popupKind: int) {
			
			this.popupController = popupController;
			this.popupKind = popupKind;
						
			var textureName: String; 
			switch (popupKind) {
				case POPUP_TOUCH:
					textureName = AssetNames.ACTION_POPUP_TOUCH;
					pleasure = PLEASURE_SEX * ActionValues.instance().GetModifier(ActionValues.PLEASURE_TOUCH);
				
				break;
				case POPUP_KISS:
					textureName = AssetNames.ACTION_POPUP_KISS;
					pleasure = PLEASURE_SEX * ActionValues.instance().GetModifier(ActionValues.PLEASURE_KISS);
				break;
				case POPUP_SEX:
					textureName = AssetNames.ACTION_POPUP_SEX;
					pleasure = PLEASURE_SEX * ActionValues.instance().GetModifier(ActionValues.PLEASURE_SEX);
					risk = RISK_SEX * ActionValues.instance().GetModifier(ActionValues.RISK_SEX);
				break;			
			}
			
			super(Game.instance().assets.getTexture(textureName), null);
			
			// Create the text indicating the amount of times this popup has to be touched
			if (maxTouches > 1)
			{
				var texture : Texture = Game.instance().assets.getTexture("number");
				circle = new Image(texture);
				circle.x = 116;
				addChild(circle);
				
				field = new TextField(64, 64, (maxTouches - touches).toString());
				field.fontName = "RoofRunners";
				field.fontSize = 40;
				field.x = 116;
				addChild(field);			
			}

			Img.ChangeSpriteSize(this);
			
			// Set the size according to the BUTTON_SIZE value.
			this.width *= ActionValues.instance().GetModifier(ActionValues.BUTTON_SIZE);
			this.height *= ActionValues.instance().GetModifier(ActionValues.BUTTON_SIZE);
			
			// Initialize the removeTimer
			removeTimer = new PauseTimer(1000 * ActionValues.instance().GetModifier(ActionValues.BUTTONS_ALIVE_TIME), 1);
			removeTimer.addEventListener(TimerEvent.TIMER_COMPLETE, 
				function (event: TimerEvent): void {
					remove();
				});
				
			removeTimer.start();		
		}
		
		/**
		* function pause resumes all the timers in this PopupButton
		*/
		public function pause() {
			if (removeTimer)
				removeTimer.pause();
		}
		
		/**
		* function resume pauses all the timers in this PopupButton
		*/
		public function resume() {
			if (removeTimer)
				removeTimer.resume();
		}
		
		/**
		* Places this PopupButton on a random spot in the popupArea 
		* and makes sure it doesn't place it on another button (will recalculate a position otherwise).
		*
		*@return	Boolean	whether it succeeded in placing the button or not.
		*/
		public function placeAtRandomSpot(depth: int = 0): Boolean {		
			
			var popupArea: Rectangle = ActionScreen.popupArea;
						
			x = popupArea.x + Math.floor(Math.random() * (popupArea.width - this.width)); 
			y = popupArea.y + Math.floor(Math.random() * (popupArea.height - this.height));
					
			var popups: Vector.<PopupButton> = popupController.getPopups();

			for each (var button: PopupButton in popups) {

				if ((x + this.width >= button.x) && 
					(x <= button.x + button.width) && 
					(y + this.height >= button.y) && 
					(y <= button.y + button.height)) {
						
					trace("Chosen position overlaps other button. Picking a new spot.");
					if (depth <= maxRandomSpotTries) {
						return placeAtRandomSpot(depth + 1);
					} else {
						trace("Couldn't place button " + maxRandomSpotTries + " times, will now let the popupController decide what to do with me..");
						return false;
					}
				}	
			}
			return true;
		}

		// Amount of times this button has been touched so far
		var touches: int = 0;
		
		// Set the maximum number of taps for this button as it is now
		var maxTouches: int = ActionValues.instance().GetModifier(ActionValues.BUTTONS_MAXIMUM_NUMBER_OF_TAPS);
		
		/**
		* function increaseTouches increases the amount of times this popup has been touched and changes the text
		* that indicates how many times this popup still has to be touched before it's removed
		*/
		public function increaseTouches(): void {
			touches++;
			if (maxTouches - touches > 1)
			{
				field.text = (maxTouches - touches).toString();
			}
			
			else if (circle != null)
			{
				field.removeFromParent(true);
				circle.removeFromParent(true);
			}
		}
		
		/**
		* function touchedEnough 
		*
		* @return	Boolean	Whether or not this popup has been clicked enough times to be removed
		*/
		public function touchedEnough(): Boolean {
			trace('touches: ' + touches + ', maxtouches: ' + maxTouches);
			return (touches >= maxTouches);			
		}
				
		/**
		* function OnTouch is called whenever this popup is touched, checks if the touch is an actual click and if so, hands it to the popupController
		* 
		* @see PopupController.popupClicked()
		*/
		public override function OnTouch(event: TouchEvent): void {
			var touch:Touch = event.touches[0];
			if (touch.phase == TouchPhase.BEGAN) {
				popupController.popupClicked(this);
			}
		}
		
		/**
		* function remove tells the PopupController to completely remove this PopupButton
		*/
		private function remove() {
			popupController.removeButton(this);
		}
		
		/**
		* function getRisk 
		*
		* @return	Number	The amount of risk being given upon clicking this popup
		*/
		public function getRisk(): Number {
			return this.risk;
		}
		
		/**
		* function getPleasure 
		*
		* @return	Number	The amount of pleasure being given upon clicking this popup
		*/
		public function getPleasure(): Number {
			return this.pleasure;
		}

	}
	
}
