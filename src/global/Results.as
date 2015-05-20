package src.global
{
	import flash.net.SharedObject;

	public class Results
	{
		private static var _instance : Results;
		
		public static function instance() : Results
		{
			if (!_instance) _instance = new Results();
			return _instance;
		}
		
		private var gainedPleasure : int;
		private var gainedRisk : int;
		
		public function Results()
		{
			ResetValues();
		}
		
		public function ResetValues() : void
		{
			gainedPleasure = 0;
			gainedRisk = 0;
		}
		
		public function AddPleasure(i : int)
		{
			gainedPleasure += i;
		}
		
		public function GetPleasure() : int
		{
			return gainedPleasure;
		}
		
		public function AddRisk(i : int)
		{
			gainedRisk += i;
		}
		
		public function GetRisk() : int
		{
			return gainedRisk;
		}
	}
}
