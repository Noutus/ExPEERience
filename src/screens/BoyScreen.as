package src.screens {
	
	import src.global.GlobalValues;

	/**
	 * Screen that shows the story for the boy character.
	 */
	public class BoyScreen extends StoryScreen {
		
		/**
		 * Creates an instance of BoyScreen. 
		 *
		 * @param name Name of the screen background, as specified in the AssetManager.
		 * @param next Reference to the screen that is shown after pressing the next button.
		 */
		public function BoyScreen(name: String, next: * ) {
			super(name, next);
		}

		/**
		 * Override from Screen. Is called when the screen has been successfully entered.
		 */
		public override function OnEnter(): void {
			GlobalValues.instance().ResetValues();
			GlobalValues.instance().gender = false; // Sets gender to male.
			super.OnEnter();
		}
	}
}