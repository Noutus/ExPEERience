package src.buttons
{
	import flash.utils.getDefinitionByName;
	import src.Game;
	import starling.events.*;
	import starling.textures.Texture;

	public class ScreenSwitchButton extends BasicButton
	{
		private var screenName : String;
		
		public function ScreenSwitchButton(_upState : Texture, _downState : Texture, _screenName : String)
		{
			super(_upState, _downState);
			this.screenName = _screenName;
		}
		
		public override function OnTouch(e : TouchEvent) : void
		{
			var _touch : Touch = e.getTouch(this, TouchPhase.ENDED);
			if (_touch)
			{
				var _c : Class = getDefinitionByName(screenName) as Class;
				Game.instance().SwitchScreen(new _c());
			}
		}
	}
}
