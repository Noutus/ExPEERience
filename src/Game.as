package src
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

	public class Game extends Sprite
	{
		private static var _instance:Game;

		/**
		* Accesses the instance of <code>Game</code>.
		* 
		* @return The instance of the <code>Game</code> class.
		*/
		public static function instance() : Game
		{
			if (! _instance)
			{
				_instance = new Game();
			}
			return _instance;
		}

		public static const APPLICATION_PATH:File = File.applicationDirectory;

		public var assets : AssetManager;

		public var currentScreen : GameScreen;

		public function Game()
		{
			_instance = this;

			assets = new AssetManager();
			assets.enqueue(APPLICATION_PATH.resolvePath("assets"));
			assets.loadQueue(function (ratio : Number) : void
			{
			if (ratio == 1.0) Initialize();
			});
		}

		public function Initialize()
		{
			SwitchScreen(new MainMenuScreen());
		}

		public function SwitchScreen(_newScreen : GameScreen):void
		{
			if (currentScreen)
			{
				currentScreen.OnExit();
			}
			currentScreen = _newScreen;
			this.addChild(currentScreen);
			currentScreen.OnEnter();
		}
		
		public static function CreateScreenSwitchButtonAt(_imagePath : String, _screen : *, _x : Number, _y : Number) : void
		{
			var _v : Vector.<Number> = new Vector.<Number>(2);
			_v = Game.GetScaledVector(_x, _y);
			
			var _texture : Texture = Game.instance().assets.getTexture(_imagePath);
			var _button : ScreenSwitchButton = new ScreenSwitchButton(_texture, _texture, _screen);
			
			_button.x = _v[0];
			_button.y = _v[1];
			
			_v = Game.GetScaledVector(_button.width, _button.height);
			
			_button.width = _v[0];
			_button.height = _v[1];
			
			Game.instance().currentScreen.addChild(_button);
		}
		
		public static function CreateImageAt(_imagePath : String, _x : Number, _y : Number) : void
		{
			var _v : Vector.<Number> = new Vector.<Number>(2);
			_v = Game.GetScaledVector(_x, _y);
			
			var _texture : Texture = Game.instance().assets.getTexture(_imagePath);
			var _image : Image = new Image(_texture);
			
			_image.x = _v[0];
			_image.y = _v[1];
			
			_v = Game.GetScaledVector(_image.width, _image.height);
			
			_image.width = _v[0];
			_image.height = _v[1];
			
			Game.instance().currentScreen.addChild(_image);
		}
		
		public static function GetScaledVector(_x : Number, _y : Number) : Vector.<Number>
		{
			var _v : Vector.<Number> = new Vector.<Number>(2);
			
			_v[0] = _x / 720 * Capabilities.screenResolutionX;
			_v[1] = _y / 1280 * Capabilities.screenResolutionY;
			
			return _v;
		}
		
		public static function ChangeSpriteSize(_s : DisplayObject) : void
		{
			var position : Vector.<Number> = Game.GetScaledVector(_s.x, _s.y);
			var scale : Vector.<Number> = Game.GetScaledVector(_s.width, _s.height);
			
			_s.x = position[0];
			_s.y = position[1];
			
			_s.width = scale[0];
			_s.height = scale[1];
		}
	}
}