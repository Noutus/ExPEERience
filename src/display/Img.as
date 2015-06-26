package src.display
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
	import starling.text.TextField;
	import starling.core.Starling;
	import flash.geom.Point;
	
	public class Img
	{
		public static function CreateScreenSwitchButtonAt(imagePath : String, screen : *, positionX : Number, positionY : Number) : DisplayObject
		{
			var texture : Texture = Game.instance().assets.getTexture(imagePath);
			var button : ScreenSwitchButton = new ScreenSwitchButton(texture, texture, screen);

			var obj = AddDisplayObject(button, positionX, positionY);
			return obj;
		}

		public static function CreateImageAt(imagePath : String, positionX : Number, positionY : Number):void
		{
			var texture:Texture = Game.instance().assets.getTexture(imagePath);
			var image:Image = new Image(texture);

			var obj = AddDisplayObject(image, positionX , positionY);
		}
		
		public static function GetNewImageAt(imagePath : String, positionX : Number, positionY : Number) : DisplayObject
		{
			var texture:Texture = Game.instance().assets.getTexture(imagePath);
			var image:Image = new Image(texture);

			return AddDisplayObject(image, positionX , positionY);
		}
		
		public static function CreateTextAt(boxParent : Sprite, boxText : String, boxX : Number, boxY : Number, boxWidth : Number, boxHeight : Number, fontSize : int) : TextField
		{
			var position : Vector.<Number> = Img.GetScaledVector(boxX, boxY);
			var scale : Vector.<Number> = Img.GetScaledVector(boxWidth, boxHeight);
			
			var field : TextField = new TextField(scale[0], scale[1], boxText);
				field.fontName = "RoofRunners";
				field.fontSize = fontSize / 720 * Starling.current.viewPort.width;
				field.x = position[0];
				field.y = position[1];
				boxParent.addChild(field);
				
			return field;
		}
		
		public static function GetScaledVector(_x : Number, _y : Number) : Vector.<Number> 
		{
			/*if (Capabilities.os.indexOf("Windows") >= 0)
			{
				var v : Vector.<Number> = new Vector.<Number>(2);
				v[0] = _x;
				v[1] = _y;
				return v;
			}
			
			else*/
			{
				var _v : Vector.<Number >  = new Vector.<Number > (2);
	
				_v[0] = _x / 720 * Starling.current.viewPort.width;
				_v[1] = _y / 1280 * Starling.current.viewPort.height;
	
				return _v;
			}
		}
		
		public static function getScaledPoint(x: Number, y: Number): Point {
			var vect: Vector.<Number> = GetScaledVector(x, y); 
			return new Point(vect[0], vect[1]);
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
		
		public static function AddDisplayObject(displayObject : DisplayObject, x : Number, y : Number) : DisplayObject
		{
			displayObject.x = x;
			displayObject.y = y;
			
			ChangeSpriteSize(displayObject);
			
			Game.instance().currentScreen.addChild(displayObject);
			
			return displayObject;
		}
	}
}