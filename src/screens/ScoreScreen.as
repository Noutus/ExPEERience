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
		var won: Boolean;
		
		public function ScoreScreen(won: Boolean)
		{
			this.won = won;
			
			var pleasure : int = Results.instance().GetPleasure();
			var risk : int = Results.instance().GetRisk();
			
			var levelScore: int = (pleasure - risk);
			
			GlobalValues.instance().totalScore += levelScore;
			
			var wonText : TextField = Img.CreateTextAt(this, won? "Succesfull night, next level!": "Bad night, game over!", 0, 200, 720, 200, 50);
			var levelText : TextField = Img.CreateTextAt(this, won? "Next level: " + GlobalValues.instance().level: "Got to level: " + GlobalValues.instance().level, 0, 400, 720, 200, 50);

			Img.CreateTextAt(this, "Pleasure Gained: " + pleasure.toString(), 0, 540, 720, 100, 32);
			Img.CreateTextAt(this, "Risk Gained: " + risk.toString(), 0, 668, 720, 100, 32);
			Img.CreateTextAt(this, "Level Score: " + levelScore.toString(), 0, 796, 720, 100, 48);
			
			Img.CreateTextAt(this, "Total Score: " + GlobalValues.instance().totalScore.toString(), 0, 924, 720, 100, 48);
		}
		
		public override function OnEnter() : void
		{
			trace("Entering Score Screen: ");
			trace("Risk sex: " + ActionValues.instance().GetModifier(ActionValues.RISK_SEX));
			trace("Buttons per second: " + ActionValues.instance().GetModifier(ActionValues.BUTTONS_PER_SECOND));
			
			GlobalValues.instance().SaveGame();
			ActionValues.instance().ResetModifiers();
			
			Img.CreateScreenSwitchButtonAt("button_next", won? Screens.NIGHTTODAY: Screens.MAINMENU, 520, 1100);
			Img.CreateScreenSwitchButtonAt("button_back", Screens.MAINMENU, 0, 1100);
		}
		
		public override function OnExit() : void
		{
			Results.instance().ResetValues();
			
			super.OnExit();
		}
	}
}
