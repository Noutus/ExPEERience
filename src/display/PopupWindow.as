package src.display {
	
	import flash.system.Capabilities;

	import src.Game;
	import src.display.Img;
	import src.display.ScreenSwitchButton;
	import src.screens.Screens;

	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;

	/**
	 * Basic pop-up window to use for in-game feedback or messages.
	 */
	public class PopupWindow extends Sprite {
		
		/** Used for an event that is triggered when the pop-up window is closed. */
		public static const CLOSE_CLICKED: String = "CLOSE_CLICKED";

		/** Title displayed in the pop-up window. */
		private var titleText: String;
		
		/** Name of the image shown as stored in the AssetManager. */
		private var imagePath: String;
		
		/** Text displayed in the pop-up window. */
		private var textText: String;

		/** Background image of the pop-up window. */
		private var bg: DisplayObject;
		
		/** Exit button. */
		private var exitButton: DisplayObject;
		
		/** Image displayed. */
		private var image: DisplayObject;
		
		/** Width and height for the image. */
		private var baseWidth, baseHeight: int;
		
		/** TextField containing the title text. */
		private var tTitle: TextField;
		
		/** TextField containing the text. */
		private var tText: TextField;
		
		/** Continue button. */
		private var continueButton: DisplayObject;
		
		/** Main menu button. */
		private var mainMenuButton: DisplayObject;

		/** Are the Continue and Main Menu buttons shown? */
		private var showMainMenuButton: Boolean;

		/**  */
		private var imageMultiplier: Number;

		/**
		 * Creates an instance of PopupWindow.
		 * 
		 * @param _titleText The title that will be displayed on top of the pop-up window.
		 * @param _imagePath The name of the image that will be displayed as stored in the AssetManager.
		 * @param _textText The text displayed in the pop-up window.
		 * @param showMainMenuButton Are the main menu and continue button shown in the pop-up window?
		 */
		public function PopupWindow(_titleText: String, _imagePath: String, _textText: String, showMainMenuButton: Boolean = false) {
			this.titleText = _titleText;
			this.imagePath = _imagePath;
			this.textText = _textText;
			this.showMainMenuButton = showMainMenuButton;
			this.addEventListener(Event.ADDED_TO_STAGE, init);
		}

		/**
		 * Function is called when the object is added to the stage.
		 *
		 * @param e Event.
		 */
		public function init(e: Event): void {
			
			// Set the background.
			bg = Img.GetNewImageAt("window_popup", 0, 0);

			// Add the title.
			tTitle = Img.CreateTextAt(Game.instance().currentScreen, titleText, 120, 256, 480, 72, 48);

			// Add the image.
			if (imagePath != "") {
				image = Img.GetNewImageAt(imagePath, 360, 350);
				image.x = Img.GetScaledVector((720 - image.width) / 2, 0)[0];
				baseWidth = image.width;
				baseHeight = image.height;
				Game.instance().currentScreen.addChild(image);
			}

			// Add the text.
			tText = Img.CreateTextAt(Game.instance().currentScreen, textText, 133, 526, 465, 443, 32);

			// Add the exit button.
			exitButton = Img.GetNewImageAt("button_exit", 523, 250);
			Game.instance().currentScreen.addChild(exitButton);
			exitButton.addEventListener(TouchEvent.TOUCH, OnTouch);

			// If the main menu button is shown, add the continue and main menu buttons.
			if (this.showMainMenuButton) {
				continueButton = Img.GetNewImageAt("popup_continue", 210, 700);
				mainMenuButton = Img.CreateScreenSwitchButtonAt("popup_mainmenu", Screens.MAINMENU, 210, 850);
				continueButton.addEventListener(TouchEvent.TOUCH, OnTouch);
			}
		}

		/**
		 * Sets the image size multiplier.
		 *
		 * @param multiplier Multiplier.
		 */
		public function setImageSizeMultiplier(multiplier: Number) {
			this.imageMultiplier = multiplier;
			image.width = baseWidth *= imageMultiplier;
			image.height = baseHeight *= imageMultiplier;
			image.x = Img.GetScaledVector((720 - image.width) / 2, 0)[0];
		}
		
		/**
		 * Event triggered when the exit or continue buttons are touched.
		 *
		 * @param e Event.
		 */
		public function OnTouch(e: TouchEvent): void {
			var _touch: Touch = e.getTouch(exitButton, TouchPhase.ENDED);
			var _touch2: Touch = e.getTouch(continueButton, TouchPhase.ENDED);
			if (_touch || _touch2) {
				
				// Destroy all objects related to the pop-up window.
				bg.removeFromParent(true);
				tTitle.removeFromParent(true);
				if (image != null) image.removeFromParent(true);
				tText.removeFromParent(true);
				exitButton.removeFromParent(true);
				if (continueButton != null) continueButton.removeFromParent(true);
				if (mainMenuButton != null) mainMenuButton.removeFromParent(true);

				// Dispatch event that the window is closed. Used for unpausing the game for example.
				dispatchEvent(new Event(PopupWindow.CLOSE_CLICKED));

				// Destroy this object.
				this.removeFromParent(true);
			}
		}
	}
}