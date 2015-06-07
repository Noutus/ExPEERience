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
			
			Img.CreateScreenSwitchButtonAt("main_button_play", Screens.GENDER, 120, 210);
			Img.CreateScreenSwitchButtonAt("main_button_rules", Screens.GENDER, 120, 510);
			Img.CreateScreenSwitchButtonAt("main_button_options", Screens.OPTION, 120, 810);
			
			GlobalValues.instance().ResetValues();
			
			Sound.playLooping("HANZE GAME");
		}
	}
}
