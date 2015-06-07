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
				case 3: rv = "Kiss!"; break;
			}
			
			return rv;
		}
		
		public function getNewLevelImage(level : int) : String
		{
			var rv : String = "babyface";
			
			switch(level)
			{
				case 1: rv = "action_popup_touch"; break;
			}
			
			return rv;
		}
		
		public function getNewLevelText(level : int) : String
		{
			var rv : String = "Cannot find message.";
			
			switch(level)
			{
				case 1: rv = "Tap the 'hug' buttons to increase fun."; break;
			}
			
			return rv;
		}
	}
}
