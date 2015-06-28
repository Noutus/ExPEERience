package src.display {
	
	import src.Game;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;

	/**
	 * An AnimatedObject is a sprite that has basic animation features. An instance of this class shows a looping animation of the specified image.
	 */
	public class AnimatedObject extends Sprite {
		
		/** Holds the current image shown. */
		var image: Image;
		
		/** Holds all images needed to play the animation. */
		var images: Array = new Array();
		
		/** Current index. */
		var index: int = 0;
		
		/** Maximum index. */
		var maxIndex: int;

		/**
		 * Creates an instance of AnimatedObject.
		 *
		 * @param name Name of the image in the AssetManager. This is the same name as used in the XML file for the sprite sheet.
		 * @param size Number of images the animation exists of.
		 */
		public function AnimatedObject(name: String, size: int) {
			
			maxIndex = size;

			// Create an array containing all textures for the animation.
			for (var i: int = 0; i < size; i++) {
				var s: String = name + i.toString();
				trace(s);
				images.push(Game.instance().assets.getTexture(s));
			}

			image = new Image(images[0]);
			addChild(image);

			addEventListener(Event.ENTER_FRAME, update);

			Img.ChangeSpriteSize(this);
		}

		/**
		 * Changes the texture for the animation on each frame.
		 *
		 * @param event Event.
		 */
		public function update(event: Event): void {
			index = (index + 1) % maxIndex;
			image.texture = images[index];
		}
	}
}