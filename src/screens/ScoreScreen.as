package src.screens
{
	import src.screens.GameScreen;
	import starling.textures.Texture;
	import src.display.*;
	import starling.core.Starling;
	import src.global.Results;
	import flash.system.Capabilities;
	import starling.text.TextField;
	import src.actionPhase.ActionValues;
	import src.actionPhase.ActionScreen;
	import src.global.*;
	
	/**
	* class ScoreScreen is the screen that shows the scores from the last game and the current total score
	*/
	public class ScoreScreen extends GameScreen
	{
		// The kind of ScoreScreen, there are 3 kinds:
		// ActionScreen. WON, FAILED, or LOST
		var kind: int;
		
		/**
		* constructor ScoreScreen initializes this ScoreScreen
		*
		* @param	int	the kind of ScoreScreen this is
		*/
		public function ScoreScreen(kind: int)
		{
			this.setBackground("main_background_orange");
			this.kind = kind;
			
			var upperText: String;
			var nextLevelText: String;
			
			switch(kind) {
				case ActionScreen.WON:
					upperText = "Succesfull night, next level!";
					if (GlobalValues.instance().level < 11) nextLevelText = "Next level: " + GlobalValues.instance().level;
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
		
		/**
		* function OnEnter called upon entering this ScoreScreen
		*/
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
		
		/**
		* function OnExit called upon exiting this ScoreScreen
		*/
		public override function OnExit() : void
		{
			Results.instance().ResetValues();
			
			super.OnExit();
		}
	}
}
