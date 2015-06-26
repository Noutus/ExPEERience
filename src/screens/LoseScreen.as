package src.screens
{	
	import src.screens.GameScreen;
	import src.Game;
	import starling.textures.Texture;
	import src.display.ScreenSwitchButton;
	import starling.core.Starling;
	import src.display.Img;
	import src.global.GlobalValues;
	import starling.events.TouchEvent;
	import starling.events.Touch;
	import starling.events.TouchPhase;
	import starling.animation.Tween;
	import flash.system.Capabilities;
	import starling.display.Image;

	public class LoseScreen extends StoryScreen
	{
		public function LoseScreen(name : String, next : *)
		{
			super(name, next);
		}
		
		public override function OnEnter() : void
		{
			super.OnEnter();
		}
	}
}
