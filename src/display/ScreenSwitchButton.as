package src.display
{
	import flash.utils.getDefinitionByName;
	
	import starling.events.*;
	import starling.textures.Texture;
	
	import src.Game;
	import src.screens.*;
	import src.pressurePhase.*;
	import src.actionPhase.*;
	import src.*;

	/**
	 * Button used to switch screens in ExPEERience.
	 */
	public class ScreenSwitchButton extends BasicButton {
		
		/** Reference to the screen thsi button sends the player to. */
		private var id : String;
		
		/**
		 * Creates an instance of ScreenSwitchButton.
		 *
		 * @param _upState Idle texture for the button.
		 * @param _downState Texture for when the button is pressed.
		 * @param _id The screen to which this button will send the player.
		 */
		public function ScreenSwitchButton(_upState : Texture, _downState : Texture, _id : String) {
			super(_upState, _downState);
			this.id = _id;
		}
		
		/**
		 * Overrides the OnTouch function of BasicButton. This is called whenever the button is touched.
		 * OnTouch sends the player to the next Screen, based on the reference name.
		 * 
		 * @param e TouchEvent.
		 */
		public override function OnTouch(e : TouchEvent) : void {
			var _touch : Touch = e.getTouch(this, TouchPhase.ENDED);
			if (_touch) {
				switch(id) {
					case Screens.ACTION: Game.instance().SwitchScreen(new ActionScreen()); break;
					case Screens.PRESSURE: Game.instance().SwitchScreen(new PressureScreen()); break;
					case Screens.MAINMENU: Game.instance().SwitchScreen(new MainMenuScreen()); break;
					case Screens.GENDER: Game.instance().SwitchScreen(new GenderScreen()); break;
					case Screens.STORYGIRL: Game.instance().SwitchScreen(new GirlScreen("comic_start", Screens.NIGHTTODAY)); break;
					case Screens.STORYBOY: Game.instance().SwitchScreen(new BoyScreen("comic_start", Screens.NIGHTTODAY)); break;
					case Screens.OPTION: Game.instance().SwitchScreen(new OptionScreen()); break;
					case Screens.DAYTONIGHT: Game.instance().SwitchScreen(new TransitionScreen(TransitionScreen.DAY_TO_NIGHT)); break;
					case Screens.NIGHTTODAY: Game.instance().SwitchScreen(new TransitionScreen(TransitionScreen.NIGHT_TO_DAY)); break;
					case Screens.RULES: Game.instance().SwitchScreen(new RulesScreen()); break;
					case Screens.LOSE: Game.instance().SwitchScreen(new LoseScreen("comic_lose", Screens.MAINMENU)); break;
					case Screens.WIN: Game.instance().SwitchScreen(new WinScreen("comic_win", Screens.MAINMENU)); break;
					case Screens.STATISTICS: Game.instance().SwitchScreen(new StatisticsScreen()); break;
				}
			}
		}
	}
}
