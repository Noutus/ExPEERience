package src.screens
{	
	import src.screens.*;
	import src.Game;
	import starling.textures.Texture;
	import starling.core.Starling;
	import starling.events.TouchEvent;
	import starling.events.Touch;
	import starling.events.TouchPhase;
	import starling.animation.Tween;
	import flash.system.Capabilities;
	import src.global.*;
	import src.display.*;

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
