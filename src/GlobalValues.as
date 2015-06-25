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
		public function addLevel() : void
		{
			previousLevel = level;
			level++;
		}
		
		public var pleasure : Number;
		public var risk : Number;
		
		public var totalScore: int;
		
		public var previousLevel : int;
		
		public function GlobalValues()
		{
			ResetValues();
		}
		
		public var highScore : int;
		
		/**
		* Resets all values back to their base value.
		*/
		public function ResetValues() : void
		{
			gender = false;
			babies = 0;
			level = 1;
			previousLevel = 0;
			pleasure = 0.50;
			risk = 0.00;
			totalScore = 0;
			highScore = highScore;
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
			previousLevel = _data.data.previousLevel;
			pleasure = _data.data.pleasure;
			risk = _data.data.risk;
			totalScore = _data.data.totalScore;
			highScore = _data.data.highScore;
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
			_data.data.previousLevel = previousLevel;
			_data.data.pleasure = pleasure;
			_data.data.risk = risk;
			_data.data.totalScore = totalScore;
			_data.data.highScore = highScore;
		}
		
		public function LevelChanged() : Boolean
		{
			return !(level == previousLevel);
		}
		
		public function SetNewScore() : void
		{
			if (totalScore > highScore) highScore = totalScore;
		}
	}
}
