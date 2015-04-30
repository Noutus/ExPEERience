package src.pressurePhase
{
	import src.actionPhase.ActionValues;
	
	public class ActionModifier
	{
		private var modifierName;
		private var modifierValue;
		
		public function ActionModifier(_name : String, _value : Number)
		{
			this.modifierName = _name;
			this.modifierValue = _value;
		}
		
		public function AddModifier() : void
		{
			ActionValues.instance().SetModifier(modifierName, modifierValue);
		}
	}
}
