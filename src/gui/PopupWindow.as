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
	
	public class PopupWindow extends Sprite
	{
		var background : DisplayObject;
		var exitButton : DisplayObject;
		var title : TextField;
		var text : TextField;
		
		public function PopupWindow(titleText : String, textText : String)
		{
			background = Img.GetNewImageAt("window_popup", 0, 0);
			
			title = new TextField(480, 72, titleText);
			title.x = 120;
			title.y = 256;
			title.fontSize = 48 / 720 * Capabilities.screenResolutionX;
			Img.ChangeSpriteSize(title);
			Game.instance().currentScreen.addChild(title);
			
			text = new TextField(480, 720, textText);
			text.x = 120;
			text.y = 320;
			text.fontSize = 32 / 720 * Capabilities.screenResolutionX;
			Img.ChangeSpriteSize(text);
			Game.instance().currentScreen.addChild(text);
			
			exitButton = Img.GetNewImageAt("button_exit", 532, 272);
			exitButton.addEventListener(TouchEvent.TOUCH, OnTouch);
		}
		
		public function OnTouch(e : TouchEvent) : void
		{
			var _touch : Touch = e.getTouch(exitButton, TouchPhase.ENDED);
			if (_touch)
			{
				trace("Exit Button clicked.");
				
				background.removeFromParent(true);
				title.removeFromParent(true);
				text.removeFromParent(true);
				exitButton.removeFromParent(true);
				this.removeFromParent(true);
			}
		}
	}
}
