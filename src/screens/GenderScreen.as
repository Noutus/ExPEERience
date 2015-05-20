package src.screens
{	
	import src.GameScreen;
	import starling.text.TextField;
	import flash.system.Capabilities;
	import src.display.Img;

	public class GenderScreen extends GameScreen
	{
		public function GenderScreen()
		{
			
		}
		
		public override function OnEnter() : void
		{
			Img.CreateScreenSwitchButtonAt("button_gender_female", Screens.STORYGIRL, 70, 256);
			Img.CreateScreenSwitchButtonAt("button_gender_male", Screens.STORYBOY, 360, 256);
			
			var position : Vector.<Number> = Img.GetScaledVector(0, 0);
			var scale : Vector.<Number> = Img.GetScaledVector(720, 360);
			
			var pleasureText : TextField = new TextField(scale[0], scale[1], "Select your Gender");
				pleasureText.fontSize = 48 / 720 * Capabilities.screenResolutionX;
				pleasureText.x = position[0];
				pleasureText.y = position[1];
				addChild(pleasureText);
		}
	}
}
