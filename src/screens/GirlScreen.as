package src.screens {
	
	import src.global.GlobalValues;

	/**
	 * Screen that shows the story for the Girl character.
	 */
	public class GirlScreen extends StoryScreen {
		
		/**
		 * Creates an instance of GirlScreen. 
		 *
		 * @param name Name of the screen background, as specified in the AssetManager.
		 * @param next Reference to the screen that is shown after pressing the next button.
		 */
		public function GirlScreen(name: String, next: * ) {
			super(name, next);
		}

		/**
		 * Override from Screen. Is called when the screen has been successfully entered.
		 */
		public override function OnEnter(): void {
			GlobalValues.instance().ResetValues();
			GlobalValues.instance().gender = true; // Sets gender to female.
			super.OnEnter();
		}
	}
}