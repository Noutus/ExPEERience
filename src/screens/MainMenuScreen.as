package src.screens {
	
	import src.screens.GameScreen;
	import starling.textures.Texture;
	import src.display.ScreenSwitchButton;
	import src.Game;
	import starling.core.Starling;
	import starling.events.Event;
	import starling.events.TouchEvent;
	import src.display.Img;
	import src.global.GlobalValues;
	import src.global.Sound;
	import src.display.AnimatedObject;
	import starling.events.Touch;
	import starling.events.TouchPhase;
	import starling.display.DisplayObject;

	public class MainMenuScreen extends GameScreen {
		
		/** Exit button. */
		var exitButton: DisplayObject;
		
		/** Creates an instance of MainMenuScreen. */
		public function MainMenuScreen() {}

		/**
		 * Override from Screen. Is called when succesfully entered the screen.
		 */
		public override function OnEnter(): void {
			
			// Set the background.
			this.setBackground("main_background_orange");

			// Load game.
			GlobalValues.instance().LoadGame();
			GlobalValues.instance().loadOptions();

			// If there is a saved game, show the continue button.
			if (GlobalValues.instance().totalScore > 0) {
				Img.CreateScreenSwitchButtonAt("main_button_continue", Screens.PRESSURE, 170, 10);
			} else GlobalValues.instance().ResetValues();

			// Add other buttons.
			Img.CreateScreenSwitchButtonAt("main_button_play", Screens.GENDER, 170, 220);
			Img.CreateScreenSwitchButtonAt("main_button_rules", Screens.RULES, 170, 430);
			Img.CreateScreenSwitchButtonAt("main_button_options", Screens.OPTION, 170, 640);
			Img.CreateScreenSwitchButtonAt("main_button_achievements", Screens.STATISTICS, 170, 850);
			exitButton = Img.GetNewImageAt("main_button_exit", 170, 1060);
			exitButton.addEventListener(TouchEvent.TOUCH, onTouch);

			// Play music.
			Sound.playLooping("HANZE GAME");
		}

		/**
		 * Called when the exit button is pressed. Closes the game.
		 *
		 * event TouchEvent.
		 */
		public function onTouch(event: TouchEvent): void {
			var touch: Touch = event.getTouch(exitButton, TouchPhase.ENDED);
			if (touch) Game.instance().exit();
		}
	}
}