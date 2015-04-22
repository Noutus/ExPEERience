package
{
	import flash.display.MovieClip;
	import starling.core.*;
	
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
