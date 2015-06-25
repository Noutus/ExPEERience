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
	import src.actionPhase.ActionScreen;
	
	public class ScoreScreen extends GameScreen
	{
		var kind: int;
		
		// kind = ActionScreen. WON/FAILED/LOST
		public function ScoreScreen(kind: int)
		{
			this.setBackground("main_background_orange");
			this.kind = kind;
			
			var upperText: String;
			var nextLevelText: String;
			
			switch(kind) {
				case ActionScreen.WON:
					upperText = "Succesfull night, next level!";
					nextLevelText = "Next level: " + GlobalValues.instance().level;
				break;
				case ActionScreen.FAILED:
					upperText = "Could have gone better, try again!";
					nextLevelText = "Repeating level: " + GlobalValues.instance().level;
				break;
				case ActionScreen.LOST:
					upperText = "Bad night, game over!";
					nextLevelText = "Got to level: " + GlobalValues.instance().level;
				break;
			}
			
			var pleasure : int = Results.instance().GetPleasure();
			var risk : int = Results.instance().GetRisk();
			
			var levelScore: int = (pleasure - risk);
			
			GlobalValues.instance().totalScore += levelScore;
			
			var wonText : TextField = Img.CreateTextAt(this, upperText, 0, 200, 720, 200, 50);
			var levelText : TextField = Img.CreateTextAt(this, nextLevelText, 0, 400, 720, 200, 50);

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
			
			GlobalValues.instance().SetNewScore();
			
			if (kind == ActionScreen.WON) {
				GlobalValues.instance().pleasure = 0.5;
			} else if (kind == ActionScreen.LOST) {
				GlobalValues.instance().ResetValues();
			}
			
			GlobalValues.instance().SaveGame();
			ActionValues.instance().ResetModifiers();
			
			if (GlobalValues.instance().level > 10)
			{
				Img.CreateScreenSwitchButtonAt("button_next", Screens.WIN, 520, 1100);
			}
			else
			{
				Img.CreateScreenSwitchButtonAt("button_next", (kind == ActionScreen.LOST)? Screens.LOSE: Screens.NIGHTTODAY, 520, 1100);
			}
			
			if (kind != ActionScreen.LOST) Img.CreateScreenSwitchButtonAt("button_back", Screens.MAINMENU, 0, 1100);
		}
		
		public override function OnExit() : void
		{
			Results.instance().ResetValues();
			
			super.OnExit();
		}
	}
}
