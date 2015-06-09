package src.global
{
	public class Messages
	{
		private static var _instance : Messages;
		public static function instance() : Messages
		{
			if (!_instance) _instance = new Messages();
			return _instance;
		}
		
		public function getNewLevelTitle(level : int) : String
		{
			var rv : String = "Error";
			
			switch(level)
			{
				case 1: rv = "Hug!"; break;
				case 2: rv = ""; break;
				case 3: rv = "Kiss!"; break;
				case 4: rv = ""; break;
				case 5: rv = "Sex!"; break;
				case 6: rv = ""; break;
				case 7: rv = ""; break;
				case 8: rv = ""; break;
				case 9: rv = ""; break;
				case 10: rv = ""; break;
			}
			
			return rv;
		}
		
		public function getNewLevelImage(level : int) : String
		{
			var rv : String = "babyface";
			
			switch(level)
			{
				case 1: rv = "action_popup_touch"; break;
				case 2: rv = "babyface"; break;
				case 3: rv = "action_popup_kiss"; break;
				case 4: rv = "babyface"; break;
				case 5: rv = "action_popup_sex"; break;
				case 6: rv = "babyface"; break;
				case 7: rv = "babyface"; break;
				case 8: rv = "babyface"; break;
				case 9: rv = "babyface"; break;
				case 10: rv = "babyface"; break;
			}
			
			return rv;
		}
		
		public function getNewLevelText(level : int) : String
		{
			var rv : String = "Cannot find message.";
			
			switch(level)
			{
				case 1: rv = "Tap the 'hug' buttons to increase fun."; break;
				case 2: rv = ""; break;
				case 3: rv = "Tap the 'kiss' buttons to gain more fun."; break;
				case 4: rv = ""; break;
				case 5: rv = "Tap the 'sex' buttons to gain more fun. But beware! Having sex without a condom also increases the risk to have a baby."; break;
				case 6: rv = ""; break;
				case 7: rv = ""; break;
				case 8: rv = ""; break;
				case 9: rv = ""; break;
				case 10: rv = ""; break;
			}
			
			return rv;
		}
	}
}
