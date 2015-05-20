package src.actionPhase {
	
	import src.Game;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import src.PauseTimer;
	import src.global.Results;
	
	public class PopupController {
		
		//public static const TIMER_BASE_DELAY: Number = 0.7;
		
		private var actionScreen: ActionScreen;
		private var popupTimer: PauseTimer;
		
		private var popups: Vector.<PopupButton> = new Vector.<PopupButton>;		
		
		public function PopupController(actionScreen: ActionScreen) {
			// constructor code
			this.actionScreen = actionScreen;
			
			popupTimer = new PauseTimer(getTimeBetweenSpawns());

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
				
				popupButton.increaseTouches();

				if (popupButton.touchedEnough()) {
					
					if (popupButton.getPleasure() > 0)
					{
						actionScreen.alterPleasure(popupButton.getPleasure());
						Results.instance().AddPleasure(100);
					}
					
					if (popupButton.getRisk() > 0)
					{
						actionScreen.alterRisk(popupButton.getRisk());
						Results.instance().AddRisk(100);
					}
					
					removeButton(popupButton);
				}
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
		
		private function randomNumber(max: Number): Number {
			return Math.random() * max;
		}
		
		private function getTimeBetweenSpawns(): Number {
			return 1000 / ActionValues.instance().GetModifier(ActionValues.BUTTONS_PER_SECOND);
		}
		
		private function spawnRandomButton(event: TimerEvent): void {
			
			var popupKind: int;
			
			var touchChance: Number = ActionValues.instance().GetModifier(ActionValues.SPAWN_CHANCE_TOUCH);
			var kissChance: Number = ActionValues.instance().GetModifier(ActionValues.SPAWN_CHANCE_KISS);
			var sexChance: Number = ActionValues.instance().GetModifier(ActionValues.SPAWN_CHANCE_SEX);
			
			var rand: Number = randomNumber(touchChance + kissChance + sexChance);
			
			popupKind = (rand <= touchChance) ? PopupButton.POPUP_TOUCH : 
				((rand <= touchChance + kissChance) ? PopupButton.POPUP_KISS : 
				PopupButton.POPUP_SEX);
			
			var popupButton: PopupButton = new PopupButton(this, popupKind);
			
			if (popupButton.placeAtRandomSpot()) { 
				popups.push(popupButton);

				actionScreen.addChild(popupButton);
			} else
				popupButton.dispose();
			
		
			popupTimer.delay = getTimeBetweenSpawns();
			trace("popupTimer.delay: " + popupTimer.delay);

			//var popupButton: PopupButton = new PopupButton(Game.instance().assets.getTexture(ActionValues.PLEASURE_TOUCH null);
			//actionScreen.addChild();
		}

	}
	
}
