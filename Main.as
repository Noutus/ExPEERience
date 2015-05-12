package
{
	import flash.display.MovieClip;
	import starling.core.*;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import starling.utils.ScaleMode;
	import flash.geom.*;
	import flash.events.*;
	import starling.events.ResizeEvent;
	import flash.display.Screen;
	import starling.utils.RectangleUtil;
	
	import src.GlobalValues;
	
	public class Main extends MovieClip
	{
		private var starling : Starling;
		
		public function Main()
		{
			starling = new Starling(src.Game, stage);
			starling.start();		
		}
	}
}
