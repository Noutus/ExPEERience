package src.actionPhase
{
	import flash.utils.*;

	public class ActionValues
	{
		public static const TIME_LIMIT : String = "TIME_LIMIT"; 
		
		public static const BUTTONS_PER_SECOND : String = "BUTTONS_PER_SECOND"; 
		public static const BUTTONS_ALIVE_TIME : String = "BUTTONS_ALIVE_TIME"; 		
		
		public static const PLEASURE_KISS : String = "PLEASURE_KISS";
		public static const PLEASURE_TOUCH : String = "PLEASURE_TOUCH";
		public static const PLEASURE_SEX : String = "PLEASURE_SEX";
		public static const RISK_SEX : String = "RISK_SEX";
		public static const PLEASURE_DECREASE : String = "PLEASURE_DECREASE";
		
		public static const SPAWN_CHANCE_TOUCH : String = "SPAWN_CHANCE_TOUCH";
		public static const SPAWN_CHANCE_KISS : String = "SPAWN_CHANCE_KISS";
		public static const SPAWN_CHANCE_SEX : String = "SPAWN_CHANCE_SEX";
		
		public static const BUTTONS_MAXIMUM_NUMBER_OF_TAPS : String = "BUTTONS_MAXIMUM_NUMBER_OF_TAPS";
		
		// Ideas
		//public static const BUTTONS_MOVEMENT_RATIO : String = "BUTTONS_MOVEMENT_RATIO";
		//public static const BUTTONS_VISIBILITY : String = "BUTTONS_VISIBILITY";
		
		private static var _instance : ActionValues;
		
		/**
		* Accesses the instance of <code>ActionValues</code>.
		* 
		* @return The instance of the <code>ActionValues</code> class.
		*/
		public static function instance() : ActionValues
		{
			if (!_instance) _instance = new ActionValues();
			return _instance;
		}
		
		private var modifiers : Dictionary;
		
		/**
		* Retreives the value for the modifer with a certain name.
		* 
		* @param _name Name of the required modifier.
		* 
		* @return Returns a <code>Number</code> linked to the modifier by _name.
		*/
		public function GetModifier(_name : String) : Number
		{
			var _returnValue : Number = 0;
			for (var _object : Object in modifiers)
			{
				if (_name == _object) _returnValue = modifiers[_object];
			}
			return _returnValue;
		}
		
		/**
		* Sets the value for the modifer with a certain name.
		* 
		* @param _name Name of the required modifier.
		* @param _value Value the modifier by _name is set to.
		*/
		public function SetModifier(_name : String, _value : Number) : void
		{
			modifiers[_name] = _value;
			trace("Set modifier " + _name + " to value " + _value.toString());
		}
		
		// TODO: Rename.
		public function ActionValues()
		{
			modifiers = new Dictionary();
			
			/*
			* Used for shorter code. Takes all const values from this class and puts them in a dictionary linked to value 1.
			* 
			* source: http://stackoverflow.com/questions/11596475/as3-how-can-i-get-an-array-of-constants-of-a-class
			*/
			var _xmlList : XMLList = describeType(ActionValues).child("constant");
			for each(var _key : XML in _xmlList)
			{
				modifiers[_key.attribute("name")] = 1;
			}
		}
		
		/**
		* Resets all modifiers back to their base value.
		*/
		public function ResetModifiers() : void
		{
			for each(var _value : Number in modifiers)
			{
				_value = 1;
			}
		}
	}
}
