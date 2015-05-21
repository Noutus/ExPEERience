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

	public class StoryBoyScreen extends GameScreen
	{
		private var previousY;
		
		public function StoryBoyScreen()
		{
			
		}
		
		public override function OnEnter() : void
		{
			GlobalValues.instance().gender = false;
			
			this.setBackground("story_comic_placeholder");
			Img.CreateScreenSwitchButtonAt("button_next", Screens.PRESSURE, 520, 1080);
			
			backGround.addEventListener(TouchEvent.TOUCH, OnTouch);
		}
		
		public function OnTouch(e : TouchEvent) : void
		{
			var _touch : Touch = e.getTouch(backGround);
			if (_touch)
			{
				if (_touch.phase == TouchPhase.BEGAN)
				{
					previousY = _touch.globalY;
				}
				
				if (_touch.phase == TouchPhase.MOVED)
				{
					backGround.y += _touch.globalY - previousY;
					previousY = _touch.globalY;
					
					if (backGround.y > 0) backGround.y = 0;
					
					var maxY : Number = -(backGround.height - Capabilities.screenResolutionY);
					if (backGround.y < maxY) backGround.y = maxY;
				}
			}
		}
	}
}
