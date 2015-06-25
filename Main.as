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
	import flash.display.Stage;
	import src.pressurePhase.PressureScreen;
	
	[SWF(backgroundColor="#D07C4A")]
	public class Main extends MovieClip
	{
		private var starling : Starling;
		
		public function Main()
		{
			// Do something in the class so it'll initialize the static things. 
			PressureScreen.lelflash = 1;
			
			starling = new Starling(src.Game, stage);
			starling.start();		
			
			stage.addEventListener(Event.RESIZE, onResizeHandler);
			
			
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
					
		}
		
		
		public function onResizeHandler(e:Event):void{
			var viewPortRectangle:Rectangle = new Rectangle();
			viewPortRectangle.width = stage.stageWidth;
			viewPortRectangle.height = stage.stageHeight;
			Starling.current.viewPort = viewPortRectangle;
		 
				// point :)
			starling.stage.stageWidth = stage.stageWidth;
			starling.stage.stageHeight = stage.stageHeight;
		}
	}
}
