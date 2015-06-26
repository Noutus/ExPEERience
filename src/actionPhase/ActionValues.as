package src.actionPhase {

	import flash.utils.Dictionary;
	import flash.utils.describeType;

	/**
	 * ActionValues keeps track of the modifiers applied in the action phase.
	 */
	public class ActionValues {

		// Amount of time the player has.
		public static const TIME_LIMIT: String = "TIME_LIMIT";

		// Amount of buttons appearing each second.
		public static const BUTTONS_PER_SECOND: String = "BUTTONS_PER_SECOND";

		// Amount of time the buttons stay on screen.
		public static const BUTTONS_ALIVE_TIME: String = "BUTTONS_ALIVE_TIME";

		// Size modifier for the buttons.
		public static const BUTTON_SIZE: String = "BUTTON_SIZE";

		// Amount of times the buttons need to be tapped before collecting.
		public static const BUTTONS_MAXIMUM_NUMBER_OF_TAPS: String = "BUTTONS_MAXIMUM_NUMBER_OF_TAPS";

		// Amount of pleasure gained from the button types.
		public static const PLEASURE_KISS: String = "PLEASURE_KISS";
		public static const PLEASURE_TOUCH: String = "PLEASURE_TOUCH";
		public static const PLEASURE_SEX: String = "PLEASURE_SEX";

		// Amount of risk gained from the sex button.
		public static const RISK_SEX: String = "RISK_SEX";

		// The rate at which the pleasure bar decreases.
		public static const PLEASURE_DECREASE: String = "PLEASURE_DECREASE";

		// Spawn chances for each button type.
		public static const SPAWN_CHANCE_TOUCH: String = "SPAWN_CHANCE_TOUCH";
		public static const SPAWN_CHANCE_KISS: String = "SPAWN_CHANCE_KISS";
		public static const SPAWN_CHANCE_SEX: String = "SPAWN_CHANCE_SEX";

		// The movement ratio for all buttons.
		//public static const BUTTONS_MOVEMENT_RATIO: String = "BUTTONS_MOVEMENT_RATIO";

		// The visibility of the button types.
		//public static const BUTTONS_VISIBILITY: String = "BUTTONS_VISIBILITY";

		// Holds the singleton for this class.
		private static var _instance: ActionValues;

		// Holds all modifiers with their respective values.
		private var modifiers: Dictionary;

		/** 
		 * Creates an instance of ActionValues.
		 */
		public function ActionValues() {
			if (!_instance) _instance = this;

			createModifierDictionary();
		}

		/**
		 * Creates a Dictionary object that holds all modifier types. The modifiers are stored in modifier.
		 */
		private function createModifierDictionary(): void {

			modifiers = new Dictionary();

			/* Used for shorter code. Takes all const values from this class and puts them in a dictionary linked to value 1.
			 * source: http://stackoverflow.com/questions/11596475/as3-how-can-i-get-an-array-of-constants-of-a-class
			 */
			var _xmlList: XMLList = describeType(ActionValues).child("constant");
			for each(var _key: XML in _xmlList) {
				modifiers[_key.attribute("name")] = 1.0;
			}
		}

		/**
		 * Accesses the instance of ActionValues.
		 *
		 * @return The instance of the ActionValues class.
		 */
		public static function instance(): ActionValues {
			if (!_instance) _instance = new ActionValues();
			return _instance;
		}

		/**
		 * Retreives the value for the modifer with a certain name.
		 *
		 * @param modifierName Name of the required modifier.
		 *
		 * @return Returns a Number linked to the modifier by modifierName.
		 */
		public function GetModifier(modifierName: String): Number {
			var returnValue: Number = 0.0;
			for (var object: Object in modifiers) {
				if (modifierName == object) returnValue = modifiers[object];
			}
			return returnValue;
		}

		/**
		 * Sets the value for the modifer with the specified name.
		 *
		 * @param modifierName Name of the required modifier.
		 * @param value Value the modifier by modifierName is set to.
		 */
		public function SetModifier(modifierName: String, value: Number): void {
			for (var object : Object in modifiers)
			{
				if (modifierName == object) {
					modifiers[object] = value;
					trace("Set modifier " + modifierName + " to value " + value.toString());
				}
			}
		}

		/**
		 * Multiplies the current value by value.
		 * 
		 * @param modifierName Name of the modifier this function will apply to.
		 * @param value Multiplier for the value of modifierName.
		 */
		public function AddModifier(modifierName: String, value: Number): void {
			for (var object : Object in modifiers)
			{
				if (modifierName == object) {
					modifiers[object] *= value;
					trace("Adding modifier " + modifierName + " value " + value.toString());
				}
			}
		}

		/**
		 * Resets all modifiers back to their base value 1.
		 */
		public function ResetModifiers(): void {
			for (var object: Object in modifiers) {
				modifiers[object] = 1;
			}
		}
	}
}