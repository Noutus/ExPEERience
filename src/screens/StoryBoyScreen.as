package src.screens
{	
	import src.GameScreen;
	import src.Game;
	import starling.textures.Texture;
	import src.buttons.ScreenSwitchButton;
	import starling.core.Starling;
	import src.display.Img;
	import src.GlobalValues;

	public class StoryBoyScreen extends GameScreen
	{
		public function StoryBoyScreen()
		{
			
		}
		
		public override function OnEnter() : void
		{
			GlobalValues.instance().gender = false;
			
			this.setBackground("story_comic_placeholder");
			Img.CreateScreenSwitchButtonAt("button_next", Screens.PRESSURE, 520, 1080);
		}
	}
}
