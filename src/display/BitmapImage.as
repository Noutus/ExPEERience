package src.display {
	
	import flash.display.Bitmap;
	import flash.geom.Point;

	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.textures.Texture;
	import starling.utils.Color;

	/**
	 * Class used for pixel perfect touch detection.
	 *
	 * Source: http://forum.starling-framework.org/topic/click-through-a-texture-image
	 */
	public class BitmapImage extends Image {
		
		/** Holds the bitmap data for the image. */
		private var mBitmap: Bitmap;

		/**
		 * Creates an instance of BitmapImage.
		 *
		 * @param bitmap The bitmap that will be displayed for this image.
		 */
		public function BitmapImage(bitmap: Bitmap) {
			mBitmap = bitmap;
			super(Texture.fromBitmap(bitmap));
		}

		/**
		 * Test if the touched position on the image is transparent. If it is, return the image below this.
		 *
		 * @param localPoint X and Y coordinates of the touched point.
		 * @param forTouch Default value is false.
		 *
		 * @return Returns the image on a successfull hit. Returns null on transparent pixels.
		 */
		public override function hitTest(localPoint: Point, forTouch: Boolean = false): DisplayObject {
			// on a touch test, invisible or untouchable objects cause the test to fail
			if (forTouch && (!visible || !touchable)) return null;

			// otherwise, check bounding box ...
			if (getBounds(this).containsPoint(localPoint)) {
				// ... and bitmap alpha.
				var clr: uint = mBitmap.bitmapData.getPixel32(localPoint.x, localPoint.y);

				if (Color.getAlpha(clr) > 10) return this;
				else return null;
			} else return null;
		}
	}
}