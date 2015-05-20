package src.screens
{
	import src.GameScreen;
	import src.display.Img;
	import starling.textures.Texture;
	import src.buttons.ScreenSwitchButton;
	import starling.core.Starling;
	import src.global.Results;
	import flash.system.Capabilities;
	import starling.text.TextField;
	
	public class ScoreScreen extends GameScreen
	{
		public function ScoreScreen()
		{
			var pleasure : int = Results.instance().GetPleasure();
			var risk : int = Results.instance().GetRisk();
			
			var position : Vector.<Number> = Img.GetScaledVector(0, 640);
			var scale : Vector.<Number> = Img.GetScaledVector(720, 100);
			
			var pleasureText : TextField = new TextField(scale[0], scale[1], "Pleasure Gained: " + pleasure.toString());
				pleasureText.fontSize = 32 / 720 * Capabilities.screenResolutionX;
				pleasureText.x = position[0];
				pleasureText.y = position[1];
				addChild(pleasureText);
				
			position[1] += 128 / 1280 * Capabilities.screenResolutionY;
				
			var riskText : TextField = new TextField(scale[0], scale[1], "Risk Gained: " + risk.toString());
				riskText.fontSize = 32 / 720 * Capabilities.screenResolutionX;
				riskText.x = position[0];
				riskText.y = position[1];
				addChild(riskText);
				
			position[1] += 128 / 1280 * Capabilities.screenResolutionY;
				
			var riskText : TextField = new TextField(scale[0], scale[1], "Total Score: " + (pleasure - risk).toString());
				riskText.fontSize = 48 / 720 * Capabilities.screenResolutionX;
				riskText.x = position[0];
				riskText.y = position[1];
				addChild(riskText);
		}
		
		public override function OnEnter() : void
		{
			Img.CreateScreenSwitchButtonAt("button_next", Screens.PRESSURE, 520, 1100);
			Img.CreateScreenSwitchButtonAt("button_back", Screens.MAINMENU, 0, 1100);
		}
		
		public override function OnExit() : void
		{
			Results.instance().ResetValues();
			
			super.OnExit();
		}
	}
}
