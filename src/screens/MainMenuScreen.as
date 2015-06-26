package src.screens
{	
	import src.screens.GameScreen;
	import starling.textures.Texture;
	import src.display.ScreenSwitchButton;
	import src.Game;
	import starling.core.Starling;
	import starling.events.Event;
	import starling.events.TouchEvent;
	import src.display.Img;
	import src.global.GlobalValues;
	import src.global.Sound;
	import src.display.AnimatedObject;
	import starling.events.Touch;
	import starling.events.TouchPhase;
	import starling.display.DisplayObject;

	public class MainMenuScreen extends GameScreen
	{
		var exitButton : DisplayObject;
		
		public function MainMenuScreen()
		{
			
		}
		
		public override function OnEnter() : void
		{
			this.setBackground("main_background_orange");
			
			GlobalValues.instance().LoadGame();
			
			if (GlobalValues.instance().totalScore > 0)
			{
				Img.CreateScreenSwitchButtonAt("main_button_continue", Screens.PRESSURE, 170, 10); 
			}
			
			else GlobalValues.instance().ResetValues();
			
			Img.CreateScreenSwitchButtonAt("main_button_play", Screens.GENDER, 170, 220);
			Img.CreateScreenSwitchButtonAt("main_button_rules", Screens.RULES, 170, 430);
			Img.CreateScreenSwitchButtonAt("main_button_options", Screens.OPTION, 170, 640);
			Img.CreateScreenSwitchButtonAt("main_button_achievements", Screens.STATISTICS, 170, 850);
			exitButton = Img.GetNewImageAt("main_button_exit", 170, 1060);
			exitButton.addEventListener(TouchEvent.TOUCH, onTouch);
			
			Sound.playLooping("HANZE GAME");
		}
		
		public function onTouch(event : TouchEvent) : void {
			var touch : Touch = event.getTouch(exitButton, TouchPhase.ENDED);
			if (touch) Game.instance().exit();
		}
	}
}
