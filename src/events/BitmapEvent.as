package src.events
{
	import flash.events.Event;
	import flash.display.BitmapData;
	
	public class BitmapEvent extends Event
	{
		public static const GOT_RESULT:String = "gotResult";		
		
		public var imageName : String;
		public var result : BitmapData;

		public function BitmapEvent(type:String, imageName: String, result:BitmapData, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			this.imageName = imageName;
			this.result = result;
			super(type, bubbles, cancelable);
		}
	}
}