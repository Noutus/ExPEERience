package src.pressurePhase {

	import src.actionPhase.ActionValues;

	/**
	 * The modifiers that are applied in the action phase based on the decision made in the pressure phase.
	 */
	public class ActionModifier {

		/** Name of the modifier. */
		public var modifierName;

		/** Value for the modifier. */
		public var modifierValue;

		/**
		 * Creates an instance of ActionModifier.
		 *
		 * @param _name Name of the modifier.
		 * @param _value Value for the modifier.
		 */
		public function ActionModifier(_name: String, _value: Number) {
			this.modifierName = _name;
			this.modifierValue = _value;
		}

		/**
		 * Apply this modifier to the next action phase.
		 */
		public function AddModifier(): void {
			ActionValues.instance().SetModifier(modifierName, modifierValue);
		}
	}
}