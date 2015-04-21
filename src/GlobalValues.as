package src
{
	public class GlobalValues
	{
		private static var S_Instance : GlobalValues;
		public static function Instance() : GlobalValues
		{
			if (S_Instance == null)
			{
				S_Instance = new GlobalValues();
			}
			
			return S_Instance;
		}
		
		private var gender : Boolean;
		public function GetGender() : Number { return gender; }
		public function SetGender(n : Number) : void { gender = n; }
		
		private var babies : int;
		public function GetBabies() : Number { return babies; }
		public function SetBabies(n : Number) : void { babies = n; }
		
		private var level : int;
		public function GetLevel() : Number { return level; }
		public function SetLevel(n : Number) : void { level = n; }
		
		private var pleasure : Number;
		public function GetPleasure() : Number { return pleasure; }
		public function SetPleasure(n : Number) : void { pleasure = n; }
		
		private var risk : Number;
		public function GetRisk() : Number { return risk; }
		public function SetRisk(n : Number) : void { risk = n; }
		
		public function GlobalValues()
		{
			ResetValues();
		}
		
		public function ResetValues()
		{
			pleasure = 50;
			risk = 0;
		}
		
		public function LoadGame()
		{
			
		}
		
		public function SaveGame()
		{
			
		}
	}
}
