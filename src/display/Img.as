package src.display {
	
	import flash.filesystem.File;
	import flash.geom.Point;
	import flash.system.Capabilities;
	
	import starling.core.Starling;
	import starling.display.*;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.utils.*;
	
	import src.Game;
	import src.display.ScreenSwitchButton;
	import src.pressurePhase.PressureScreen;
	import src.screens.*;

	/**
	 * Contains static functions to create images on the screen with responsive sizes.
	 * Also contains the functions to scale images according to the display of the device the game in played on.
	 */
	public class Img {
		
		/**
		 * Creates a ScreenSwitchButton at the specified position and adds it to the current screen.
		 *
		 * @param imagePath Name for the image as loaded in the AssetManager.
		 * @param screen Screen to which this button sends you to.
		 * @param positionX X position for the button.
		 * @param positionY Y position for the button.
		 *
		 * @return Returns the ScreenSwitchButton added to the Screen.
		 */
		public static function CreateScreenSwitchButtonAt(imagePath: String, screen: * , positionX: Number, positionY: Number): DisplayObject {
			var texture: Texture = Game.instance().assets.getTexture(imagePath);
			var button: ScreenSwitchButton = new ScreenSwitchButton(texture, texture, screen);
			return AddDisplayObject(button, positionX, positionY);
		}

		/**
		 * Creates a static image at the specified position and adds it to the current screen.
		 *
		 * @param imagePath Name for the image as loaded in the AssetManager.
		 * @param positionX X position for the button.
		 * @param positionY Y position for the button.
		 */
		public static function CreateImageAt(imagePath: String, positionX: Number, positionY: Number): void {
			var texture: Texture = Game.instance().assets.getTexture(imagePath);
			var image: Image = new Image(texture);
			var obj = AddDisplayObject(image, positionX, positionY);
		}

		/**
		 * Creates a static image at the specified position and adds it to the current screen.
		 *
		 * @param imagePath Name for the image as loaded in the AssetManager.
		 * @param positionX X position for the button.
		 * @param positionY Y position for the button.
		 *
		 * @return Returns the image added to the Screen.
		 */
		public static function GetNewImageAt(imagePath: String, positionX: Number, positionY: Number): DisplayObject {
			var texture: Texture = Game.instance().assets.getTexture(imagePath);
			var image: Image = new Image(texture);
			return AddDisplayObject(image, positionX, positionY);
		}

		/**
		 * Creates a static image at the specified position and adds it to the current screen.
		 *
		 * @param boxParent The parent object to which this textfield is added.
		 * @param boxText The text displayed on the screen.
		 * @param boxX X position for the text area.
		 * @param boxY Y position for the text area.
		 * @param boxWidth Width for the text area.
		 * @param boxHeight Height for the text area.
		 * @param fontSize Size for the displayed text.
		 *
		 * @return Returns the TextField created and added to boxParent.
		 */
		public static function CreateTextAt(boxParent: Sprite, boxText: String, boxX: Number, boxY: Number, boxWidth: Number, boxHeight: Number, fontSize: int): TextField {
			var position: Vector.<Number> = Img.GetScaledVector(boxX, boxY);
			var scale: Vector.<Number> = Img.GetScaledVector(boxWidth, boxHeight);
			var field: TextField = new TextField(scale[0], scale[1], boxText);
				field.fontName = "RoofRunners";
				field.fontSize = fontSize / 720 * Starling.current.viewPort.width;
				field.x = position[0];
				field.y = position[1];
			boxParent.addChild(field);
			return field;
		}

		/**
		 * Transforms a normal vector to a vector based on the display of the device.
		 *
		 * @param x X.
		 * @param y Y.
		 *
		 * @return Returns the transformed vector.
		 */
		public static function GetScaledVector(x: Number, y: Number): Vector.<Number> {
			var v: Vector.<Number> = new Vector.<Number>(2);
			v[0] = x / 720 * Starling.current.viewPort.width;
			v[1] = y / 1280 * Starling.current.viewPort.height;
			return v;
		}

		/**
		 * Transforms an x and y position to a point based on the display of the device.
		 *
		 * @param x X.
		 * @param y Y.
		 *
		 * @return Returns the point created from the x and y value.
		 */
		public static function getScaledPoint(x: Number, y: Number): Point {
			var vect: Vector.<Number> = GetScaledVector(x, y);
			return new Point(vect[0], vect[1]);
		}

		/**
		 * Changes the size of a sprite according to the display of the device.
		 *
		 * @param obj The object that is scaled.
		 */
		public static function ChangeSpriteSize(obj: DisplayObject): void {
			var position: Vector.<Number> = GetScaledVector(obj.x, obj.y);
			var scale: Vector.<Number> = GetScaledVector(obj.width, obj.height);
			obj.x = position[0];
			obj.y = position[1];
			obj.width = scale[0];
			obj.height = scale[1];
		}

		/**
		 * Adds specified DisplayObject to the current Screen.
		 * 
		 * @param displayObject The DisplayObject to add to the screen.
		 * @param x X position.
		 * @param y Y position.
		 * 
		 * @return Returns the DisplayObject added to the Screen.
		 */
		public static function AddDisplayObject(displayObject: DisplayObject, x: Number, y: Number): DisplayObject {
			displayObject.x = x;
			displayObject.y = y;
			ChangeSpriteSize(displayObject);
			Game.instance().currentScreen.addChild(displayObject);
			return displayObject;
		}
	}
}