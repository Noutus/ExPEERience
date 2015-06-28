package src.events
{
	import flash.events.Event;
	import flash.display.Loader;
	import flash.events.IEventDispatcher;
	import flash.display.BitmapData;
	import src.Game;
	import src.screens.MainMenuScreen;
	import starling.core.Starling;

	/**
	 * Loads in the cry and sleep images for the floating baby head. When they are succesfully loaded, dispatch the BitmapEvent.
	 */
	public class BitmapLoader extends Loader implements IEventDispatcher
	{
		/**
		 * On cry load complete.
		 */
		public function onCryLoadComplete(b : BitmapData) : void {
			dispatchEvent(new BitmapEvent(BitmapEvent.GOT_RESULT, "cry", b, true));
		}
		
		/**
		 * On sleep load complete.
		 */
		public function onSleepLoadComplete(b : BitmapData) : void {
			dispatchEvent(new BitmapEvent(BitmapEvent.GOT_RESULT, "sleep", b, true));
		}
	}
}