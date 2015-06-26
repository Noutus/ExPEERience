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

	public class StoryScreen extends GameScreen
	{
		private var currentY = 0;
		private var previousY;
		
		public var backgroundName : String;
		public var nextScreen : *;
		
		public function StoryScreen(name : String, next : *)
		{
			this.backgroundName = name;
			this.nextScreen = next;
		}
		
		public override function OnEnter() : void
		{
			this.setBackground(backgroundName);
			backGround.width *= 2;
			backGround.height *= 2;
			
			Img.CreateScreenSwitchButtonAt("button_next", nextScreen, 520, 1080);
			
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
					if ((currentY + _touch.globalY - previousY) < (- backGround.height + Starling.current.viewPort.height)) 
						currentY = -backGround.height + Starling.current.viewPort.height
					else
						currentY += _touch.globalY - previousY;
					
					previousY = _touch.globalY;
	
					if (currentY > 0) currentY = 0;
					
					backGround.y = currentY;
				}
			}
		}
	}
}
