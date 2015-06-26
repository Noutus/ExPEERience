package src.display {
	
	import src.Game;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;

	/**
	 * An AnimatedObject is a sprite that has basic animation features. An instance of this class shows a looping animation of the specified image.
	 */
	public class AnimatedObject extends Sprite {
		
		// Holds the current image shown.
		var image: Image;
		
		// Holds all images needed to play the animation.
		var images: Array = new Array();
		
		// Current index 
		var index: int = 0;
		var maxIndex: int;

		public function AnimatedObject(name: String, size: int) {
			maxIndex = size;

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

		public function update(e: Event): void {
			image.texture = images[index];

			index++;
			if (index >= maxIndex) index = 0;
		}
	}
}