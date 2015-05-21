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
	import src.display.Img;
	import src.GlobalValues;
	import src.actionPhase.ActionValues;
	
	public class ScoreScreen extends GameScreen
	{
		public function ScoreScreen()
		{
			var pleasure : int = Results.instance().GetPleasure();
			var risk : int = Results.instance().GetRisk();
			
			var pleasureText : TextField = Img.CreateTextAt(this, "Pleasure Gained: " + pleasure.toString(), 0, 640, 720, 100, 32);
			var riskText : TextField = Img.CreateTextAt(this, "Risk Gained: " + risk.toString(), 0, 768, 720, 100, 32);
			var scoreText : TextField = Img.CreateTextAt(this, "Total Score: " + (pleasure - risk).toString(), 0, 896, 720, 100, 48);
		}
		
		public override function OnEnter() : void
		{
			trace("Entering Score Screen: ");
			trace("Risk sex: " + ActionValues.instance().GetModifier(ActionValues.RISK_SEX));
			trace("Buttons per second: " + ActionValues.instance().GetModifier(ActionValues.BUTTONS_PER_SECOND));
			
			GlobalValues.instance().SaveGame();
			ActionValues.instance().ResetModifiers();
			
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
