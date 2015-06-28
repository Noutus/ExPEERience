package src.screens {
	
	/**
	 * The screen that is shown when the player loses the game.
	 */
	public class LoseScreen extends StoryScreen {
		
		/**
		 * Creates an instance of LoseScreen. 
		 *
		 * @param name Name of the screen background, as specified in the AssetManager.
		 * @param next Reference to the screen that is shown after pressing the next button.
		 */
		public function LoseScreen(name: String, next: * ) {
			super(name, next);
		}

		/**
		 * Override from Screen. Is called when the screen has been successfully entered.
		 */
		public override function OnEnter(): void {
			super.OnEnter();
		}
	}
}