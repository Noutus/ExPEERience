﻿package src.buttons
{
	import flash.utils.getDefinitionByName;
	import src.Game;
	import starling.events.*;
	import starling.textures.Texture;
	import src.screens.*;
	import src.pressurePhase.*;
	import src.actionPhase.*;
	import src.*;

	public class ScreenSwitchButton extends BasicButton
	{
		private var id : String;
		
		public function ScreenSwitchButton(_upState : Texture, _downState : Texture, _id : String)
		{
			super(_upState, _downState);
			this.id = _id;
		}
		
		public override function OnTouch(e : TouchEvent) : void
		{
			var _touch : Touch = e.getTouch(this, TouchPhase.ENDED);
			if (_touch)
			{
				trace("Switching screen to: " + id);
			
				switch(id)
				{
					case Screens.ACTION: Game.instance().SwitchScreen(new ActionScreen()); break;
					case Screens.PRESSURE: Game.instance().SwitchScreen(new PressureScreen()); break;
					// Commented this line below out because the ScoreScreen now requires the parameter "won: Boolean".
					// Passing of that parameter could eventually be moved to GlobalVars but that is not necessary 
					// right now.
					//case Screens.SCORE: Game.instance().SwitchScreen(new ScoreScreen()); break;
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
				}
			}
		}
	}
}
