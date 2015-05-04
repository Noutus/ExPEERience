package src
{
	import starling.display.*;
	import starling.utils.*;
	import flash.filesystem.File;
	import src.pressurePhase.PressureScreen;
	import src.buttons.ScreenSwitchButton;
	import starling.textures.Texture;
	import src.screens.*;

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
			var _texture : Texture = Game.instance().assets.getTexture(_imagePath);
			var _button : ScreenSwitchButton = new ScreenSwitchButton(_texture, _texture, _screen);
			
			_button.x = _x;
			_button.y = _y;
			
			Game.instance().currentScreen.addChild(_button);
		}
		
		public static function CreateImageAt(_imagePath : String, _x : Number, _y : Number) : void
		{
			var _texture : Texture = Game.instance().assets.getTexture(_imagePath);
			var _image : Image = new Image(_texture);
			
			_image.x = _x;
			_image.y = _y;
			
			Game.instance().currentScreen.addChild(_image);
		}
	}
}