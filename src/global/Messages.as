package src.global {
	
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
				case 1: rv = "Hug!"; break;
				case 2: rv = ""; break;
				case 3: rv = "Kiss!"; break;
				case 4: rv = ""; break;
				case 5: rv = "Sex!"; break;
				case 6: rv = ""; break;
				case 7: rv = "Twice!"; break;
				case 8: rv = ""; break;
				case 9: rv = ""; break;
				case 10: rv = ""; break;
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
				case 2: rv = "babyface"; break;
				case 3: rv = "action_popup_kiss"; break;
				case 4: rv = "babyface"; break;
				case 5: rv = "action_popup_sex"; break;
				case 6: rv = "babyface"; break;
				case 7: rv = "action_popup_sex"; break;
				case 8: rv = "babyface"; break;
				case 9: rv = "babyface"; break;
				case 10: rv = "babyface"; break;
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
				case 1: rv = "Tap the 'hug' buttons to increase fun."; break;
				case 2: rv = ""; break;
				case 3: rv = "Tap the 'kiss' buttons to gain more fun."; break;
				case 4: rv = ""; break;
				case 5: rv = "Tap the 'sex' buttons to gain more fun. But beware! Having sex without a condom also increases the risk to have a baby."; break;
				case 6: rv = ""; break;
				case 7: rv = "Some buttons require multiple taps. Tap the buttons equal to the amount displayed on the top right corner."; break;
				case 8: rv = ""; break;
				case 9: rv = ""; break;
				case 10: rv = ""; break;
			}
			return rv;
		}
	}
}
