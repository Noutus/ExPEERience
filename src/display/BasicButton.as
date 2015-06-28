package src.display {

	import starling.display.Button;
	import starling.events.TouchEvent;
	import starling.textures.Texture;

	/**
	 * BasicButton is the base for all buttons used in ExPEERience. Extend this class when creating a new button class.
	 */
	public class BasicButton extends Button {

		/**
		 * Creates an instance of BasicButton.
		 *
		 * @param upState Texture for when the button is not pressed.
		 * @param downState Texture for when the button is pressed.
		 */
		public function BasicButton(_upState: Texture, _downState: Texture) {
			super(_upState, "", _downState);
			this.addEventListener(TouchEvent.TOUCH, OnTouch);
		}

		/**
		 * Called when the button is touched. Override to use.
		 *
		 * @param event Event.
		 */
		public function OnTouch(event: TouchEvent): void {}
	}
}