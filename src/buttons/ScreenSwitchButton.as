package src.buttons
{
	import flash.utils.getDefinitionByName;
	import src.Game;
	import starling.events.*;
	import starling.textures.Texture;
	import src.screens.*;
	import src.pressurePhase.*;
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
					case Screens.STORY: Game.instance().SwitchScreen(new StoryScreen()); break;
					case Screens.SCORE: Game.instance().SwitchScreen(new ScoreScreen()); break;
					case Screens.MAINMENU: Game.instance().SwitchScreen(new MainMenuScreen()); break;
				}
			}
		}
	}
}
