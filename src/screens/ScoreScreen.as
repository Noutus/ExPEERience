package src.screens
{
	import src.GameScreen;
	import src.Game;
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
			Game.CreateScreenSwitchButtonAt("button_next", Screens.PRESSURE, 520, 700);
			Game.CreateScreenSwitchButtonAt("button_back", Screens.MAINMENU, 0, 700);
		}
	}
}
