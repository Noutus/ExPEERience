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
	import starling.core.Starling;
	
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
			var loadingScreen: LoadingScreen = new LoadingScreen();
			addChild(loadingScreen);

			assets = new AssetManager();
			assets.enqueue(APPLICATION_PATH.resolvePath("assets"));
			assets.loadQueue(loadingScreen.update);
		}

		public function Initialize()
		{
			if (Capabilities.os.indexOf("Windows") >= 0)
			{
				
			}
			
			else
			{
				if (Capabilities.screenResolutionX > 720)
				{
					Starling.current.stage.stageWidth = Capabilities.screenResolutionX;
					Starling.current.stage.stageHeight = Capabilities.screenResolutionY;
				}
			}
			
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
	}
}