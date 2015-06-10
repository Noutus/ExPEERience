package src.pressurePhase
{
	import src.*;
	
	public class PeerAbility
	{
		public var message : String;
		public var modifiers : Array;
		
		public function PeerAbility(_message : String, _modifiers : Array)
		{
			this.message = _message;
			this.modifiers = _modifiers;
		}
		
		public function ChooseAbility()
		{
			for each (var _modifier : ActionModifier in modifiers)
			{
				_modifier.AddModifier();
			}
		}
	}
}
