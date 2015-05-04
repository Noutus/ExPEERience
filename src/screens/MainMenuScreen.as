package src.screens
{	
	import src.GameScreen;
	import starling.textures.Texture;
	import src.buttons.ScreenSwitchButton;
	import src.Game;
	import starling.core.Starling;

	public class MainMenuScreen extends GameScreen
	{
		public function MainMenuScreen()
		{
			
		}
		
		public override function OnEnter() : void
		{
			this.setBackground("main_background_orange");
			
			Game.CreateScreenSwitchButtonAt("main_button_play", Screens.STORY, 120, 300);
			Game.CreateScreenSwitchButtonAt("main_button_rules", Screens.STORY, 120, 600);
			Game.CreateScreenSwitchButtonAt("main_button_options", Screens.STORY, 120, 900);
		}
	}
}
