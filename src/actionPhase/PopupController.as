package src.actionPhase {
	
	import src.Game;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import src.actionPhase.PauseTimer;
	import src.global.Results;
	
	/**
	* class PopupController contains and controls PopupButton
	*/
	public class PopupController {
		
		
		private var actionScreen: ActionScreen;
		private var popupTimer: PauseTimer;
		
		// The list of PopupButtons this PopupController holds
		private var popups: Vector.<PopupButton> = new Vector.<PopupButton>;		
		
		/**
		* Constructor PopupController initializes the popupTimer
		*
		* @param	ActionScreen	The actionScreen this PopupController controls popups for
		*/
		public function PopupController(actionScreen: ActionScreen) {
			this.actionScreen = actionScreen;
			
			popupTimer = new PauseTimer(getTimeBetweenSpawns());

			popupTimer.addEventListener("timer", spawnRandomButton);
		}
		
		/**
		* function getPopups
		*
		* @return	Vector.<PopupButton>	The list of popups this PopupController holds
		*/
		public function getPopups(): Vector.<PopupButton> {
			return popups;
		}

		/**
		* function startSpawning starts spawning buttons	
		*/
		public function startSpawning(): void {
			if (!isSpawning()) 
				popupTimer.start();
		}
        /**
		* function stopSpawning stops spawning buttons	
		*/
		public function stopSpawning(): void {
			if (isSpawning())
				popupTimer.stop();
		}
		
		/**
		* function pause pauses the spawner and pauses all popups this PopupController holds
		*/
		public function pause(): void {
			if (isSpawning())
				popupTimer.pause();
			for each(var popupButton: PopupButton in popups) {
				popupButton.pause();
			}
		}
		
		/**
		* function resumme resumes the spawner and resumes all popups this PopupController holds
		*/
		public function resume(): void {
			if (!isSpawning())
				popupTimer.resume();
			for each(var popupButton: PopupButton in popups) {
				popupButton.resume();
			}
		}		
		
		/**
		* function isSpawning
		*
		* @return	Boolean	whether or not this popupController is currently spawning buttons
		*/
		public function isSpawning(): Boolean {
			return popupTimer.running;
		}

		/**
		* function ratioToPoints converts a ratio to points
		*
		* @param	Number	the ratio to be converted
		* @return	int		the amount of points for the given ratio
		*/
		public function ratioToPoints(ratio: Number): int {
			return Math.floor(ratio * 100);
		}
		
		/**
		* function popupClicked called when the user has clicked a button 
		*
		* @param	PopupButton	The popupButton that has been clicked
		*/
		public function popupClicked(popupButton: PopupButton) {
			if (!actionScreen.isPaused()) {
				
				popupButton.increaseTouches();

				if (popupButton.touchedEnough()) {
					
					Results.instance().AddRisk(ratioToPoints(popupButton.getRisk()));
					Results.instance().AddPleasure(ratioToPoints(popupButton.getPleasure()));
					
					// Show the risk & pleasure feedback
					if (popupButton.getRisk() != 0) {
						var feedbackRisk : FeedbackText = new FeedbackText(popupButton.getRisk(), popupButton.x, popupButton.y, true);					
						actionScreen.bottomLayer.addChild(feedbackRisk);
					}
					if (popupButton.getPleasure() != 0) {
						var feedbackPleasure : FeedbackText = new FeedbackText(popupButton.getPleasure(), popupButton.x, popupButton.y);
						actionScreen.bottomLayer.addChild(feedbackPleasure);
					}
					
					// Alter the bars in the actionScreen
					actionScreen.alterBars(popupButton.getRisk(), popupButton.getPleasure());	
					
					removeButton(popupButton);
				}
			}
		}
		
		/**
		* function removeButton completely removes the button if it is on the actionScreen
		*
		* @param	PopupButton	the popupButton that should be removed
		*/
		public function removeButton(popupButton: PopupButton) {
			if (actionScreen.contains(popupButton)) {
				popups.splice(popups.indexOf(popupButton), 1);
				actionScreen.bottomLayer.removeChild(popupButton, true);
			}
		}
		
		/**
		* function random picks a random int between 0 (including) and max (excluding).
		*
		* @param	int	the maximum 
		* @return	int	the random int	
		*/
		private function random(max: int): int {
			return Math.floor(Math.random() * max);
		}
		
		/**
		* function randomNumber picks a random Number between 0 (including) and max (excluding).
		*
		* @param	Number	the maximum 
		* @return	Number	the random Number	
		*/
		private function randomNumber(max: Number): Number {
			return Math.random() * max;
		}
		
		/**
		* function getTimeBetweenSpawns
		*
		* @return	Number	The amount of time to wait after spawning a button
		*/
		private function getTimeBetweenSpawns(): Number {
			return 1000 / (ActionValues.instance().GetModifier(ActionValues.BUTTONS_PER_SECOND) * 2);
		}
		
		/**
		* function spawnRandomButton spawns a random kind of button somewhere on the screen
		*/
		private function spawnRandomButton(event: TimerEvent): void {
			
			var popupKind: int;
			
			// Get the chances for the individual kinds of PopupButtons
			var touchChance: Number = ActionValues.instance().GetModifier(ActionValues.SPAWN_CHANCE_TOUCH);
			var kissChance: Number = ActionValues.instance().GetModifier(ActionValues.SPAWN_CHANCE_KISS);
			var sexChance: Number = ActionValues.instance().GetModifier(ActionValues.SPAWN_CHANCE_SEX);
			
			// Define the popupKind by picking a random one using the chances
			var rand: Number = randomNumber(touchChance + kissChance + sexChance);
			popupKind = (rand <= touchChance) ? PopupButton.POPUP_TOUCH : 
				((rand <= touchChance + kissChance) ? PopupButton.POPUP_KISS : 
				PopupButton.POPUP_SEX);
			
			// Create the actual popupButton
			var popupButton: PopupButton = new PopupButton(this, popupKind);
			
			// Place the button at a spot on the screen and add it to the list
			if (popupButton.placeAtRandomSpot()) { 
				popups.push(popupButton);

				actionScreen.bottomLayer.addChild(popupButton);
			} else
				popupButton.dispose(); // Dispose the button if it could not be added to the screen
			
			// Set the time until the next spawn happens
			popupTimer.delay = getTimeBetweenSpawns();
		}
	}
}
