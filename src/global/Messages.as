package src.global {

	import src.actionPhase.ActionValues;
	
	public class Messages {
		
		/** Holds the instance of Messages. */
		private static var _instance : Messages;
		
		/**
		 * Returns the instance of Messages.
		 *
		 * @return Returns the instance of Messages.
		 */
		public static function instance() : Messages
		{
			if (!_instance) _instance = new Messages();
			return _instance;
		}
		
		/**
		 * Get the title for the pop-up window that appear when a new level is entered.
		 *
		 * @param level The level that has just been entered.
		 *
		 * @return Returns the String for the title.
		 */
		public function getNewLevelTitle(level : int) : String {
			var rv : String = "Error";
			switch(level) {
				case 1: rv = "Hug"; break;
				case 2: rv = "Kiss"; break;
				case 3: rv = "Sex"; break;
				case 4: rv = ""; break;
				case 5: rv = "Button Size"; break;
				case 6: rv = ""; break;
				case 7: rv = "Double Tap"; break;
				case 8: rv = ""; break;
				case 9: rv = ""; break;
				case 10: rv = "Good job!"; break;
			}
			return rv;
		}
		
		/**
		 * Get the image for the pop-up window that appear when a new level is entered.
		 *
		 * @param level The level that has just been entered.
		 *
		 * @return Returns the string for the image, as it is found in the AssetManager.
		 */
		public function getNewLevelImage(level : int) : String {
			var rv : String = "babyface";
			switch(level) {
				case 1: rv = "action_popup_touch"; break;
				case 2: rv = "action_popup_kiss"; break;
				case 3: rv = "action_popup_sex"; break;
				case 4: rv = ""; break;
				case 5: rv = ""; break;
				case 6: rv = ""; break;
				case 7: rv = ""; break;
				case 8: rv = ""; break;
				case 9: rv = ""; break;
				case 10: rv = ""; break;
			}
			return rv;
		}
		
		/**
		 * Get the text for the pop-up window that appear when a new level is entered.
		 *
		 * @param level The level that has just been entered.
		 *
		 * @return Returns the string for the pop-up window text.
		 */
		public function getNewLevelText(level : int) : String {
			var rv : String = "Cannot find message.";
			switch(level) {
				case 1: rv = "Tap the 'hug' buttons to increase pleasure."; break;
				case 2: rv = "Tap the 'kiss' buttons to gain more pleasure."; break;
				case 3: rv = "Tap the 'sex' buttons to gain more pleasure. But beware! Having sex without a condom also increases the risk to have a baby."; break;
				case 4: rv = ""; break;
				case 5: rv = "The game just got harder! Buttons are now smaller and more difficult to tap."; break;
				case 6: rv = ""; break;
				case 7: rv = "Some buttons require multiple taps. Tap the buttons equal to the amount displayed on the top right corner."; break;
				case 8: rv = ""; break;
				case 9: rv = ""; break;
				case 10: rv = "You have reached the final level! Just a few more steps until you have reached the perfect relationship. Have you thought about family planning?"; break;
			}
			return rv;
		}
		
		/**
		 * Get the text for abilities.
		 *
		 * @param s The string of the ability.
		 *
		 * @return Returns the text for the ability as a String.
		 */
		public static function getAbilityString(s: String): String {
			switch(s) {
				case ActionValues.TIME_LIMIT: return "Time Limit";
				case ActionValues.BUTTONS_PER_SECOND: return "Buttons per Second";
				case ActionValues.BUTTONS_ALIVE_TIME: return "Button Alive Time";
				case ActionValues.BUTTON_SIZE: return "Button Size";
				case ActionValues.BUTTONS_MAXIMUM_NUMBER_OF_TAPS: return "";
				case ActionValues.PLEASURE_KISS: return "Pleasure";
				case ActionValues.PLEASURE_TOUCH: return "Pleasure";
				case ActionValues.PLEASURE_SEX: return "Pleasure";
				case ActionValues.RISK_SEX: return "Risk";
				case ActionValues.PLEASURE_DECREASE: return "Pleasure Decrease";
				case ActionValues.SPAWN_CHANCE_KISS: return "Kiss Chance";
				case ActionValues.SPAWN_CHANCE_TOUCH: return "Hug Chance";
				case ActionValues.SPAWN_CHANCE_SEX: return "Sex Chance";
				default: return "";
			}
		}
	}
}
