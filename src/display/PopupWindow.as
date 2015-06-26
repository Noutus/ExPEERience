package src.display
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
	import src.display.ScreenSwitchButton;
	import src.screens.Screens;
	
	public class PopupWindow extends Sprite
	{
		public static const CLOSE_CLICKED: String = "CLOSE_CLICKED";
		
		var titleText : String;
		var imagePath : String;
		var textText : String;
		
		var bg : DisplayObject;
		var exitButton : DisplayObject;
		var image : DisplayObject;
		var baseWidth, baseHeight: int;
		var tTitle : TextField;
		var tText : TextField;
		var continueButton : DisplayObject;
		var mainMenuButton : DisplayObject;
		
		var showMainMenuButton : Boolean;
		
		public function PopupWindow(_titleText : String, _imagePath : String, _textText : String, showMainMenuButton : Boolean = false)
		{
			this.titleText = _titleText;
			this.imagePath = _imagePath;
			this.textText = _textText;
			this.showMainMenuButton = showMainMenuButton;
			
			this.addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		var imageMultiplier: Number;
		public function init(e : Event) : void
		{
			bg = Img.GetNewImageAt("window_popup", 0, 0);
			
			tTitle = Img.CreateTextAt(Game.instance().currentScreen, titleText, 120, 256, 480, 72, 48);
			
			image = Img.GetNewImageAt(imagePath, 360, 350);
			image.x = Img.GetScaledVector((720 - image.width) / 2, 0)[0];
			
			baseWidth = image.width;
			baseHeight = image.height;
			//image.x -= image.width / 2;
			Game.instance().currentScreen.addChild(image);
			
			tText = Img.CreateTextAt(Game.instance().currentScreen, textText, 133, 526, 465, 443, 32);
			
			exitButton = Img.GetNewImageAt("button_exit", 523, 250);
			Game.instance().currentScreen.addChild(exitButton);
			
			exitButton.addEventListener(TouchEvent.TOUCH, OnTouch);
			
			if (this.showMainMenuButton)
			{
				continueButton = Img.GetNewImageAt("popup_continue", 210, 700);
				mainMenuButton = Img.CreateScreenSwitchButtonAt("popup_mainmenu", Screens.MAINMENU, 210, 850);
				continueButton.addEventListener(TouchEvent.TOUCH, OnTouch);
			}
		}
		
		public function setImageSizeMultiplier(multiplier: Number) {
			this.imageMultiplier = multiplier;
			image.width = baseWidth *= imageMultiplier;
			image.height = baseHeight *= imageMultiplier;
			image.x = Img.GetScaledVector((720 - image.width) / 2, 0)[0];
		}
		
		public function OnTouch(e : TouchEvent) : void
		{
			var _touch : Touch = e.getTouch(exitButton, TouchPhase.ENDED);
			var _touch2 : Touch = e.getTouch(continueButton, TouchPhase.ENDED);
			if (_touch || _touch2)
			{
				bg.removeFromParent(true);
				tTitle.removeFromParent(true);
				image.removeFromParent(true);
				tText.removeFromParent(true);
				exitButton.removeFromParent(true);
				if (continueButton != null) continueButton.removeFromParent(true);
				if (mainMenuButton != null) mainMenuButton.removeFromParent(true);
				
				dispatchEvent(new Event(PopupWindow.CLOSE_CLICKED));
				
				this.removeFromParent(true);
			}
		}
	}
}
