package src.screens
{	
	import src.GameScreen;
	import src.Game;
	import starling.textures.Texture;
	import src.buttons.ScreenSwitchButton;
	import starling.core.Starling;
	import src.display.Img;

	public class StoryScreen extends GameScreen
	{
		public function StoryScreen()
		{
			
		}
		
		public override function OnEnter() : void
		{
			this.setBackground("story_comic_placeholder");
			Img.CreateScreenSwitchButtonAt("button_next", Screens.PRESSURE, 520, 1080);
		}
	}
}
