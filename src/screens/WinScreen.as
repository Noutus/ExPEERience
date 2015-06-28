package src.screens {

	import src.global.GlobalValues;
	
	/**
	 * The screen that is shown when the player wins the game.
	 */
	public class WinScreen extends StoryScreen {
		
		/**
		 * Creates an instance of WinScreen. 
		 *
		 * @param name Name of the screen background, as specified in the AssetManager.
		 * @param next Reference to the screen that is shown after pressing the next button.
		 */
		public function WinScreen(name: String, next: * ) {
			super(name, next);
		}

		/**
		 * Override from Screen. Is called when the screen has been successfully entered.
		 * Resets the current run, because the player has won.
		 */
		public override function OnEnter(): void {
			GlobalValues.instance().ResetValues();
			GlobalValues.instance().SaveGame();
			super.OnEnter();
		}
	}
}