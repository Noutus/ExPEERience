package src
{
	import flash.net.SharedObject;

	public class GlobalValues
	{
		private static var _instance : GlobalValues;
		
		/**
		* Accesses the instance of <code>GlobalValues</code>.
		* 
		* @return The instance of the <code>GlobalValues</code> class.
		*/
		public static function instance() : GlobalValues
		{
			if (!_instance) _instance = new GlobalValues();
			return _instance;
		}
		
		public var gender : Boolean;
		
		public var babies : int;
		public var level : int;
		
		public var pleasure : Number;
		public var risk : Number;
		
		public function GlobalValues()
		{
			ResetValues();
		}
		
		/**
		* Resets all values back to their base value.
		*/
		public function ResetValues() : void
		{
			gender = false;
			babies = 0;
			level = 1;
			pleasure = 0.50;
			risk = 0.00;
		}
		
		/**
		* Retreives values from an external save file.
		*/
		public function LoadGame() : void
		{
			var _data : SharedObject = SharedObject.getLocal("SaveGame");
			gender = _data.data.gender;
			babies = _data.data.babies;
			level = _data.data.level;
			pleasure = _data.data.pleasure;
			risk = _data.data.risk;
		}
		
		/**
		* Stores the current values to an external save file.
		*/
		public function SaveGame() : void
		{
			var _data : SharedObject = SharedObject.getLocal("SaveGame");
			_data.data.gender = gender;
			_data.data.babies = babies;
			_data.data.level = level;
			_data.data.pleasure = pleasure;
			_data.data.risk = risk;
		}
	}
}
