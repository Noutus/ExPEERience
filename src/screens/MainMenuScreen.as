package src.screens
{	
	import src.GameScreen;
	import starling.textures.Texture;
	import src.buttons.ScreenSwitchButton;
	import src.Game;
	import starling.core.Starling;
	import src.display.Img;
	import src.GlobalValues;
	import src.Sound;
	import src.display.AnimatedObject;

	public class MainMenuScreen extends GameScreen
	{
		public function MainMenuScreen()
		{
			
		}
		
		public override function OnEnter() : void
		{
			this.setBackground("main_background_orange");
			
			GlobalValues.instance().LoadGame();
			
			if (GlobalValues.instance().totalScore > 0)
			{
				Img.CreateScreenSwitchButtonAt("main_button_continue", Screens.PRESSURE, 170, 300); 
			}
			
			else GlobalValues.instance().ResetValues();
			
			Img.CreateScreenSwitchButtonAt("main_button_play", Screens.GENDER, 170, 510);
			Img.CreateScreenSwitchButtonAt("main_button_rules", Screens.RULES, 170, 720);
			Img.CreateScreenSwitchButtonAt("main_button_options", Screens.OPTION, 170, 930);
			
			Sound.playLooping("HANZE GAME");
		}
	}
}
