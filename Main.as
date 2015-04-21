package
{
	import flash.display.MovieClip;
	
	import src.GlobalValues;
	
	public class Main extends MovieClip
	{
		public function Main()
		{
			trace(GlobalValues.Instance().GetPleasure());
		}
	}
}
