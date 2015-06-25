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
	import starling.display.Image;

	public class StoryBoyScreen extends GameScreen
	{
		private var currentY = 0;
		private var previousY;
		
		public function StoryBoyScreen()
		{
			
		}
		
		public override function OnEnter() : void
		{
			GlobalValues.instance().ResetValues();
			GlobalValues.instance().gender = false;
			
			this.setBackground("comic_start");
			var img : Image = new Image(Game.instance().assets.getTexture("comic_start"));
			backGround.width *= 2;
			backGround.height *= 2;
			//Img.AddDisplayObject(backGround, Starling.current.stage.width, backGround.height); 
			
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
					currentY += _touch.globalY - previousY;
					previousY = _touch.globalY;
					
					trace(currentY);
					
					if (currentY > 0) currentY = 0;
					
					backGround.y = currentY;
				}
			}
		}
	}
}
