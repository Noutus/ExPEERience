package src.screens
{	
	import src.GameScreen;
	import src.Game;
	import starling.textures.Texture;
	import src.buttons.ScreenSwitchButton;
	import starling.core.Starling;

	public class StoryScreen extends GameScreen
	{
		public function StoryScreen()
		{
			
		}
		
		public override function OnEnter() : void
		{
			var _texture : Texture = Game.instance().assets.getTexture("button_next");
			var _button : ScreenSwitchButton = new ScreenSwitchButton(_texture, _texture, Screens.PRESSURE);
			
			_button.x = 720 - _button.width;
			_button.y = 900 - _button.height;
			
			this.addChild(_button);
		}
	}
}
