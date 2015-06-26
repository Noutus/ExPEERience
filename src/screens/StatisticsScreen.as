package src.screens {
	
	import src.global.GlobalValues;
	import src.display.Img;
	
	public class StatisticsScreen extends GameScreen {
		
		public function StatisticsScreen() {
			
			this.setBackground("main_background_orange");
			
		}

		public override function OnEnter(): void {
			
			Img.CreateTextAt(this, "HI-SCORE: " + GlobalValues.instance().highScore, 0, 0, 720, 100, 32);
			
			Img.CreateScreenSwitchButtonAt("button_back", Screens.MAINMENU, 0, 1100);
		}

		public override function OnExit(): void {
			
		}
	}
}