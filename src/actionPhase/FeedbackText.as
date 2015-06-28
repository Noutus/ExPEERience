package src.actionPhase {

	import starling.text.TextField;
	import starling.utils.Color;
	import starling.events.Event;
	import src.display.Img;

	/**
	 * Shows feedback scores on the screen when an action button is collected.
	 */
	public class FeedbackText extends TextField {

		/** Direction the image floats into. */
		private var direction: Vector.<Number> ;

		/** Speed of the feedback images */
		private static const speed: Number = 10;
		
		/** Distance the image has flown since birth. */
		private var distance: Number = 0;

		/**
		 * Creates an instance of FeedbackText.
		 *
		 * @param score Amount of pleasure or risk gained.
		 * @param xPos X position of the feedback text.
		 * @param yPos Y position of the feedback text.
		 * @param risk Is the feedback for risk or pleasure?
		 */
		public function FeedbackText(score: Number, xPos: Number, yPos: Number, risk: Boolean = false) {
			
			// Set basic values.
			var color = Color.GREEN;
			var text = Math.round(score * 100).toString();

			// If the feedback is risk, change color to red and add a dash before it.
			if (risk) {
				color = Color.RED;
				text = "-" + text;
			}

			// Or add a plus sign before it.
			else text = "+" + text;

			// Set direction.
			direction = new Vector.<Number> (2);
			direction[0] = Math.random() - 0.5;
			direction[1] = Math.random() - 0.5;

			// Create image.
			super(180, 180, text, "RoofRunners", 64, color);
			this.x = xPos;
			this.y = yPos;
			this.touchable = false;
			this.addEventListener(Event.ENTER_FRAME, update);
			Img.ChangeSpriteSize(this);
		}

		/**
		 * Is called every frame. Changes the position of the feedback text and destroys it after some time.
		 * 
		 * @param e Event.
		 */
		public function update(e: Event): void {
			x += direction[0] * speed;
			y += direction[1] * speed;
			distance += 1;
			if (distance > 15) {
				this.removeEventListener(Event.ENTER_FRAME, update);
				this.removeFromParent(true);
			}
		}
	}
}