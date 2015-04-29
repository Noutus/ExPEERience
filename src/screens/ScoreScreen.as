package src.screens
{
	import src.GameScreen;
	import src.Game;
	import starling.textures.Texture;
	import src.buttons.ScreenSwitchButton;
	import starling.core.Starling;
	
	public class ScoreScreen extends GameScreen
	{
		public function ScoreScreen()
		{
			
		}
		
		public override function OnEnter() : void
		{
			var _texture : Texture = Game.instance().assets.getTexture("button_next");
			var _button : ScreenSwitchButton = new ScreenSwitchButton(_texture, _texture, Screens.PRESSURE);
			
			_button.x = 720 - _button.width;
			_button.y = 900 - _button.height;
			
			this.addChild(_button);
			
			var _texture : Texture = Game.instance().assets.getTexture("button_back");
			var _button : ScreenSwitchButton = new ScreenSwitchButton(_texture, _texture, Screens.MAINMENU);
			
			_button.x = 0;
			_button.y = 900 - _button.height;
			
			this.addChild(_button);
		}
	}
}
