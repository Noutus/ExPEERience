package src.screens
{	
	import src.GameScreen;
	import starling.textures.Texture;
	import src.buttons.ScreenSwitchButton;
	import src.Game;
	import starling.core.Starling;

	public class MainMenuScreen extends GameScreen
	{
		public function MainMenuScreen()
		{
			
		}
		
		public override function OnEnter() : void
		{
			var _texture : Texture = Game.instance().assets.getTexture("button_next");
			var _button : ScreenSwitchButton = new ScreenSwitchButton(_texture, _texture, Screens.STORY);
			
			_button.x = 720 - _button.width;
			_button.y = 900 - _button.height;
			
			trace(_button.x);
			
			this.addChild(_button);
		}
	}
}
