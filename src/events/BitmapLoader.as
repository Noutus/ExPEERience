package src.events
{
	import flash.events.Event;
	import flash.display.Loader;
	import flash.events.IEventDispatcher;
	import flash.display.BitmapData;
	import src.Game;
	import src.screens.MainMenuScreen;
	import starling.core.Starling;

	public class BitmapLoader extends Loader implements IEventDispatcher
	{
		public function onCryLoadComplete(b : BitmapData) : void {
			dispatchEvent(new BitmapEvent(BitmapEvent.GOT_RESULT, "cry", b, true));
		}
		
		public function onSleepLoadComplete(b : BitmapData) : void {
			dispatchEvent(new BitmapEvent(BitmapEvent.GOT_RESULT, "sleep", b, true));
		}
	}
}