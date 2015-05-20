package src.actionPhase {
	import flash.display.Sprite;
	import src.buttons.BasicButton;
	import starling.textures.Texture;
	import src.AssetNames;
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
	import src.PauseTimer;
	import flash.geom.Rectangle;
	import flash.system.Capabilities;
	import src.display.Img;
	
	public class PopupButton extends BasicButton {
		
		public static const POPUP_TOUCH: int = 0;
		public static const POPUP_KISS: int = 1;
		public static const POPUP_SEX: int = 2;

		// Base values, altered by the ActionValues modifiers upon creation of the button
		public static const RISK_SEX: Number = 0.20;
		public static const PLEASURE_SEX: Number = 0.20;
		public static const PLEASURE_KISS: Number = 0.05;
		public static const PLEASURE_TOUCH: Number = 0.03;
		
		private var popupController: PopupController;
		private var popupKind: int;
		
		private var risk: Number = 0.00;
		private var pleasure: Number = 0.00;
		
		private var removeTimer: PauseTimer;
		
		// The maximum amount of times it will generate a random spot in the popupArea before just removing this popupButton
		// (if all tries fail. A try fails when the popup would clash with another popup.
		private static const maxRandomSpotTries: int = 100;
		
		
		// a popupbutton can have a sex, kiss, or touch texture
		public function PopupButton(popupController: PopupController, popupKind: int) {
			
			this.popupController = popupController;
			this.popupKind = popupKind;
			//ActionScreen.addButton();
			//ActionScreen.removeButton();
						
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
			
			Img.ChangeSpriteSize(this);

			removeTimer = new PauseTimer(1000 * ActionValues.instance().GetModifier(ActionValues.BUTTONS_ALIVE_TIME), 1);
			removeTimer.addEventListener(TimerEvent.TIMER_COMPLETE, 
				function (event: TimerEvent): void {
					remove();
				});
				
			removeTimer.start();		
		}
		
		public function pause() {
			removeTimer.pause();
		}
		
		public function resume() {
			removeTimer.resume();
		}
		
		/*
			Places this PopupButton on a random spot in the popupArea 
			and makes sure it doesn't place it on another button (will recalculate a position otherwise).
		
			@return Boolean whether it succeeded in placing the button or not.
		*/
		public function placeAtRandomSpot(depth: int = 0): Boolean {		
			
			var popupArea: Rectangle = ActionScreen.popupArea;
						
			x = popupArea.x + Math.floor(Math.random() * (popupArea.width - this.width)); 
			y = popupArea.y + Math.floor(Math.random() * (popupArea.height - this.height));
					
			var popups: Vector.<PopupButton> = popupController.getPopups();

			for each (var button: PopupButton in popups) {
				trace("This button: " + x + ", " + y + ", " + this.width + ", " + this.height + ", checking button: " +button.x + ", " + button.y + ", " + button.width + ", " + button.height);
				// if overlap
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
		
				
		public function increaseTouches(): void {
			touches++; 
		}
		
		public function touchedEnough(): Boolean {
			trace('touches: ' + touches + ', maxtouches: ' + maxTouches);
			return (touches >= maxTouches);			
		}
				
		public override function OnTouch(event: TouchEvent): void {
			var touch:Touch = event.touches[0];
			if (touch.phase == TouchPhase.BEGAN) {
				popupController.popupClicked(this);
				//gameScreen.addPoints(pointsReward);
			}
		}
		
		private function remove() {
			popupController.removeButton(this);
		}
		
		public function getRisk() {
			return this.risk;
		}
		
		public function getPleasure() {
			return this.pleasure;
		}

	}
	
}
