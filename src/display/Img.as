﻿package src.display
{
	import starling.display.*;
	import starling.utils.*;
	import flash.filesystem.File;
	import src.pressurePhase.PressureScreen;
	import src.buttons.ScreenSwitchButton;
	import starling.textures.Texture;
	import src.screens.*;
	import starling.utils.ScaleMode;
	import flash.system.Capabilities;
	import src.Game;
	
	public class Img
	{
		public static function CreateScreenSwitchButtonAt(imagePath : String, screen : *, positionX : Number, positionY : Number)
		{
			var texture : Texture = Game.instance().assets.getTexture(imagePath);
			var button : ScreenSwitchButton = new ScreenSwitchButton(texture, texture, screen);

			AddDisplayObject(button, positionX, positionY);
		}

		public static function CreateImageAt(imagePath : String, positionX : Number, positionY : Number):void
		{
			var texture:Texture = Game.instance().assets.getTexture(imagePath);
			var image:Image = new Image(texture);

			AddDisplayObject(image, positionX , positionY);
		}
		
		public static function GetScaledVector(_x : Number, _y : Number):Vector.<Number > 
		{
			if (Capabilities.os.indexOf("Windows") >= 0)
			{
				var v : Vector.<Number> = new Vector.<Number>(2);
				v[0] = _x;
				v[1] = _y;
				return v;
			}
			
			else
			{
				var _v : Vector.<Number >  = new Vector.<Number > (2);
	
				_v[0] = _x / 720 * Capabilities.screenResolutionX;
				_v[1] = _y / 1280 * Capabilities.screenResolutionY;
	
				return _v;
			}
		}

		public static function ChangeSpriteSize(_s : DisplayObject) : void
		{
			var position:Vector.<Number >  = GetScaledVector(_s.x,_s.y);
			var scale:Vector.<Number >  = GetScaledVector(_s.width,_s.height);

			_s.x = position[0];
			_s.y = position[1];

			_s.width = scale[0];
			_s.height = scale[1];
		}
		
		private static function AddDisplayObject(displayObject : DisplayObject, x : Number, y : Number) : void
		{
			displayObject.x = x;
			displayObject.y = y;
			
			ChangeSpriteSize(displayObject);
			
			Game.instance().currentScreen.addChild(displayObject);
		}
	}
}