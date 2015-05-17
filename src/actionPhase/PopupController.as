package src.actionPhase {
	
	import src.Game;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import src.PauseTimer;
	
	public class PopupController {
		
		//public static const TIMER_BASE_DELAY: Number = 0.7;
		
		private var actionScreen: ActionScreen;
		private var popupTimer: PauseTimer;
		
		private var popups: Vector.<PopupButton> = new Vector.<PopupButton>;		
		
		public function PopupController(actionScreen: ActionScreen) {
			// constructor code
			this.actionScreen = actionScreen;
			
			popupTimer = new PauseTimer(1000 / ActionValues.instance().GetModifier(ActionValues.BUTTONS_PER_SECOND));

			popupTimer.addEventListener("timer", spawnRandomButton);
		}
		
		public function getPopups(): Vector.<PopupButton> {
			return popups;
		}

		public function startSpawning(): void {
			if (!isSpawning()) 
				popupTimer.start();
		}

		public function stopSpawning(): void {
			if (isSpawning())
				popupTimer.stop();
		}
		
		public function pause(): void {
			if (isSpawning())
				popupTimer.pause();
			for each(var popupButton: PopupButton in popups) {
				popupButton.pause();
			}
		}
		
		public function resume(): void {
			if (!isSpawning())
				popupTimer.resume();
			for each(var popupButton: PopupButton in popups) {
				popupButton.resume();
			}
		}
		
		public function isSpawning(): Boolean {
			return popupTimer.running;
		}

		
		public function popupClicked(popupButton: PopupButton) {
			if (!actionScreen.isPaused()) {
				actionScreen.alterPleasure(popupButton.getPleasure());
				actionScreen.alterRisk(popupButton.getRisk());
				
				removeButton(popupButton);
			}
		}
		
		public function removeButton(popupButton: PopupButton) {
			if (actionScreen.contains(popupButton)) {
				popups.splice(popups.indexOf(popupButton), 1);
				actionScreen.removeChild(popupButton, true);
			}
		}
		
		/*
			Returns a number between 0 (including) and max (excluding). Just like it works in Java.
		*/
		private function random(max: int): int {
			return Math.floor(Math.random() * max);
		}
		
		private function spawnRandomButton(event: TimerEvent): void {
			
			var popupKind: int;
			
			// switch vervangen door if (verkort)
			
			
			switch (random(3)) { // getmodifier van alle 3 & popup_none_chance
				case 0: // getmodifier(popup_touch_chance
					trace("POPUP_TOUCH");
					popupKind = PopupButton.POPUP_TOUCH;
					
				break;
				case 1: // modifier touch .. modifier touch + modifier kiss
					trace("POPUP_KISS");
					popupKind = PopupButton.POPUP_KISS;
					
				break;
				case 2: 
					trace("POPUP_SEX");
					popupKind = PopupButton.POPUP_SEX;
					
				break;
			}
			
			var popupButton: PopupButton = new PopupButton(this, popupKind);
			
			if (popupButton.placeAtRandomSpot()) { 
				popups.push(popupButton);

				actionScreen.addChild(popupButton);
			} else
				popupButton.dispose();
			
		
			popupTimer.delay = 1000 / ActionValues.instance().GetModifier(ActionValues.BUTTONS_PER_SECOND);
			trace("popupTimer.delay: " + popupTimer.delay);

			//var popupButton: PopupButton = new PopupButton(Game.instance().assets.getTexture(ActionValues.PLEASURE_TOUCH null);
			//actionScreen.addChild();
		}

	}
	
}
