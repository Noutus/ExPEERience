package src.screens
{
	import src.GameScreen;
	import src.display.Img;
	import starling.textures.Texture;
	import src.buttons.ScreenSwitchButton;
	import starling.core.Starling;
	
	public class ScoreScreen extends GameScreen
	{
		public function ScoreScreen()
		{
			
		}
		
		public override function OnEnter() : void
		{
			Img.CreateScreenSwitchButtonAt("button_next", Screens.PRESSURE, 520, 700);
			Img.CreateScreenSwitchButtonAt("button_back", Screens.MAINMENU, 0, 700);
		}
	}
}
