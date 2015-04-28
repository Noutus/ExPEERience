package src
{
	import starling.display.*;
	import starling.utils.*;
	import flash.filesystem.File;
	import src.pressurePhase.PressureScreen;
	
	public class Game extends Sprite
	{
		private static var _instance : Game;
		
		/**
		* Accesses the instance of <code>Game</code>.
		* 
		* @return The instance of the <code>Game</code> class.
		*/
		public static function instance() : Game
		{
			if (!_instance) _instance = new Game();
			return _instance;
		}
		
		public static const APPLICATION_PATH : File = File.applicationDirectory;
		
		public var assets : AssetManager;
		
		private var currentScreen : GameScreen;
		
		public function Game()
		{
			assets = new AssetManager();
			assets.enqueue(APPLICATION_PATH.resolvePath("assets"));
			assets.loadQueue(function (ratio : Number) : void
			{
				if (ratio == 1.0) Initialize();
			});
		}
		
		public function Initialize()
		{
			SwitchScreen(new PressureScreen());
		}
		
		public function SwitchScreen(_newScreen : GameScreen) : void
		{
			if (currentScreen) currentScreen.OnExit();
			currentScreen = _newScreen;
			this.addChild(currentScreen);
			currentScreen.OnEnter();
		}
	}
}
