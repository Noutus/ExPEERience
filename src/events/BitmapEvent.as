package src.events
{
	import flash.events.Event;
	import flash.display.BitmapData;
	
	/**
	 * Custom event used for loading Bitmap images. With this event, we can check if the bitmap image is successfully loaded.
	 */
	public class BitmapEvent extends Event
	{
		/** Use this for when a bitmap is found. */
		public static const GOT_RESULT:String = "gotResult";		
		
		/** Name of the image. */
		public var imageName : String;
		
		/** Data for the bitmap. */
		public var result : BitmapData;
		
		/**
		 * Creates an instance of BitmapEvent.
		 *
		 * @param type Event type.
		 * @param imageName Name of the image as declared in the AssetManager.
		 * @param result The bitmapdata as succesfully loaded.
		 * @param bubbles Bubbles.
		 * @param cancelable Is the event cancelable?
		 */
		public function BitmapEvent(type:String, imageName: String, result:BitmapData, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			this.imageName = imageName;
			this.result = result;
			super(type, bubbles, cancelable);
		}
	}
}