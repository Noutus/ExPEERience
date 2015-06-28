package src.screens {

	import src.screens.GameScreen;
	import src.Game;
	import starling.textures.Texture;
	import src.display.ScreenSwitchButton;
	import starling.core.Starling;
	import src.display.Img;
	import src.global.GlobalValues;
	import starling.events.TouchEvent;
	import starling.events.Touch;
	import starling.events.TouchPhase;
	import starling.animation.Tween;
	import flash.system.Capabilities;
	import starling.display.Image;

	/**
	 * Basic class for any screens that contain nothing but a background (story) that can be scrolled through.
	 */
	public class StoryScreen extends GameScreen {

		/** Current Y position of the background. */
		private var currentY = 0;

		/** Y position of the background in the previous frame. */
		private var previousY;

		/** Name of the background, as specified in the AssetManager. */
		public var backgroundName: String;

		/** Reference to the next Screen the player goes to when pressing the next button. */
		public var nextScreen: * ;

		/**
		 * Creates an instance of StoryScreen.
		 *
		 * @param name Name of the background, as specified in the AssetManager.
		 * @param next Reference to the next screen that is loaded when the next button is pressed.
		 */
		public function StoryScreen(name: String, next: * ) {
			this.backgroundName = name;
			this.nextScreen = next;
		}

		/**
		 * Override from Screen. Called when the screen has been succesfully entered.
		 */
		public override function OnEnter(): void {
			this.setBackground(backgroundName);
			backGround.width *= 2;
			backGround.height *= 2;
			Img.CreateScreenSwitchButtonAt("button_next", nextScreen, 520, 1080);
			backGround.addEventListener(TouchEvent.TOUCH, OnTouch);
		}

		/**
		 * Called when the background image is touched.
		 *
		 * @param e TouchEvent.
		 */
		public function OnTouch(e: TouchEvent): void {
			
			//Get touch data.
			var _touch: Touch = e.getTouch(backGround);
			if (_touch) {
				
				// If just starting to press background, start keeping track of previousY.
				if (_touch.phase == TouchPhase.BEGAN) {
					previousY = _touch.globalY;
				}

				// Move the background with the finger touching the screen.
				if (_touch.phase == TouchPhase.MOVED) {
					
					// Set previousY and constrain background position to stay within borders.
					if ((currentY + _touch.globalY - previousY) < (-backGround.height + Starling.current.viewPort.height))
						currentY = -backGround.height + Starling.current.viewPort.height
					else
						currentY += _touch.globalY - previousY;
					previousY = _touch.globalY;
					if (currentY > 0) currentY = 0;
					backGround.y = currentY;
				}
			}
		}
	}
}