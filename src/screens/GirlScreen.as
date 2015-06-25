package src.screens
{	
	import src.GameScreen;
	import src.Game;
	import starling.textures.Texture;
	import src.buttons.ScreenSwitchButton;
	import starling.core.Starling;
	import src.display.Img;
	import src.GlobalValues;
	import starling.events.TouchEvent;
	import starling.events.Touch;
	import starling.events.TouchPhase;
	import starling.animation.Tween;
	import flash.system.Capabilities;

	public class GirlScreen extends StoryScreen
	{
		public function GirlScreen(name : String, next : *)
		{
			super(name, next);
		}
		
		public override function OnEnter() : void
		{
			GlobalValues.instance().ResetValues();
			GlobalValues.instance().gender = true;
			
			super.OnEnter();
		}
	}
}
