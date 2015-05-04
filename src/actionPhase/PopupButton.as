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
	
	public class PopupButton extends BasicButton {
		
		public static const POPUP_PLEASURE_TOUCH: int = 0;
		public static const POPUP_PLEASURE_KISS: int = 1;
		public static const POPUP_PLEASURE_SEX: int = 2;
		public static const POPUP_RISK_SEX: int = 3;

		public static const RISK_SEX: Number = 0.20;
		public static const PLEASURE_SEX: Number = 0.20;
		public static const PLEASURE_KISS: Number = 0.05;
		public static const PLEASURE_TOUCH: Number = 0.03;
		
		private var popupController: PopupController;
		private var popupKind: int;
		
		private var risk: Number = 0.00;
		private var pleasure: Number = 0.00;
		
		private var removeTimer: PauseTimer;
		
		
		// a popupbutton can have a sex, kiss, touch or risk_sex texture
		public function PopupButton(popupController: PopupController, popupKind: int) {
			
			this.popupController = popupController;
			this.popupKind = popupKind;
			//ActionScreen.addButton();
			//ActionScreen.removeButton();
						
			var textureName: String; 
			switch (popupKind) {
				case POPUP_PLEASURE_TOUCH:
					textureName = AssetNames.ACTION_POPUP_TOUCH;
					pleasure = PLEASURE_SEX * ActionValues.instance().GetModifier(ActionValues.PLEASURE_TOUCH);
				
				break;
				case POPUP_PLEASURE_KISS:
					textureName = AssetNames.ACTION_POPUP_KISS;
					pleasure = PLEASURE_SEX * ActionValues.instance().GetModifier(ActionValues.PLEASURE_KISS);
				break;
				case POPUP_PLEASURE_SEX:
					textureName = AssetNames.ACTION_POPUP_SEX;
					pleasure = PLEASURE_SEX * ActionValues.instance().GetModifier(ActionValues.PLEASURE_SEX);
				break;
				case POPUP_RISK_SEX:
					textureName = AssetNames.ACTION_POPUP_RISK_SEX;
					risk = RISK_SEX * ActionValues.instance().GetModifier(ActionValues.RISK_SEX);
				break;				
			}
			
			
			super(Game.instance().assets.getTexture(textureName), null);
			
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
			Places this PopupButton on a random spot on the screen.
		
			TODO: Make sure this popup isn't placed on top of another popup, or placed on top of a different button/bar
		*/
		public function placeAtRandomSpot() {
			x = Math.random() * (Starling.current.stage.stageWidth - this.width); 
			y = Math.random() * (Starling.current.stage.stageHeight - this.height);
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
