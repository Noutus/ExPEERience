package src.gui
{
	import starling.display.DisplayObject;
	import starling.display.Sprite;
	import src.display.Img;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	import src.Game;
	import flash.system.Capabilities;
	import starling.events.Event;
	import src.display.Img;
	import starling.core.Starling;
	
	public class PopupWindow extends Sprite
	{
		public static const CLOSE_CLICKED: String = "CLOSE_CLICKED";
		
		var titleText : String;
		var imagePath : String;
		var textText : String;
		
		var bg : DisplayObject;
		var exitButton : DisplayObject;
		var image : DisplayObject;
		var tTitle : TextField;
		var tText : TextField;
		
		public function PopupWindow(_titleText : String, _imagePath : String, _textText : String)
		{
			this.titleText = _titleText;
			this.imagePath = _imagePath;
			this.textText = _textText;
			
			this.addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		public function init(e : Event) : void
		{
			bg = Img.GetNewImageAt("window_popup", 0, 0);
			
			tTitle = Img.CreateTextAt(Game.instance().currentScreen, titleText, 120, 256, 480, 72, 48);
			
			image = Img.GetNewImageAt(imagePath, 360, 350);
			image.x = Img.GetScaledVector((720 - image.width) / 2, 0)[0];
			//image.x -= image.width / 2;
			Game.instance().currentScreen.addChild(image);
			
			tText = Img.CreateTextAt(Game.instance().currentScreen, textText, 133, 526, 465, 443, 32);
			
			exitButton = Img.GetNewImageAt("button_exit", 523, 250);
			Game.instance().currentScreen.addChild(exitButton);
			
			exitButton.addEventListener(TouchEvent.TOUCH, OnTouch);
		}
		
		public function OnTouch(e : TouchEvent) : void
		{
			var _touch : Touch = e.getTouch(exitButton, TouchPhase.ENDED);
			if (_touch)
			{
				bg.removeFromParent(true);
				tTitle.removeFromParent(true);
				image.removeFromParent(true);
				tText.removeFromParent(true);
				exitButton.removeFromParent(true);
				
				dispatchEvent(new Event(PopupWindow.CLOSE_CLICKED));
				
				this.removeFromParent(true);
			}
		}
	}
}
