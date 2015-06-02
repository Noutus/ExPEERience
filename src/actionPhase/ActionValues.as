package src.actionPhase
{
	import flash.utils.*;
	import src.GlobalValues;

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
		* Retreives the __value for the modifer with a certain name.
		* 
		* @param modifierName Name of the required modifier.
		* 
		* @return Returns a <code>Number</code> linked to the modifier by modifierName.
		*/
		public function GetModifier(modifierName : String) : Number
		{
			var returnValue : Number = 0.0;
			for (var object : Object in modifiers)
			{
				if (modifierName == object) returnValue = modifiers[object];
			}
			return returnValue;
		}
		
		public function toString(): String {
			
			var rv: String = 'MODIFIERS: ';
			for (var object : Object in modifiers)
			{
				rv += 'name: ' + object + ', _value: ' + modifiers[object] + '. ';
			}
			
			return rv;
		}
		
		/**
		* Sets the _value for the modifer with a certain name.
		* 
		* @param modifierName Name of the required modifier.
		* @param _value Value the modifier by modifierName is set to.
		*/
		public function SetModifier(modifierName : String, _value : Number) : void
		{
			for (var object : Object in modifiers)
			{
				if (modifierName == object) modifiers[object] = (0.8 + 0.2 * GlobalValues.instance().level) * _value;
			}
			
			trace("Set modifier " + modifierName + " to _value " + _value.toString());
		}
		
		public function AddModifier(modifierName : String, _value : Number) : void
		{
			for (var object : Object in modifiers)
			{
				if (modifierName == object) modifiers[object] += _value * 0.2 * GlobalValues.instance().level;
				if (modifiers[object] < 0) modifiers[object] = 0;
			}
		}
		
		// TODO: Rename.
		public function ActionValues()
		{
			if (!_instance) _instance = this;
			
			modifiers = new Dictionary();
			
			/*
			* Used for shorter code. Takes all const _values from this class and puts them in a dictionary linked to _value 1.
			* 
			* source: http://stackoverflow.com/questions/11596475/as3-how-can-i-get-an-array-of-constants-of-a-class
			*/
			var _xmlList : XMLList = describeType(ActionValues).child("constant");
			for each(var _key : XML in _xmlList)
			{
				modifiers[_key.attribute("name")] = 1.0;
			}
		}
		
		/**
		* Resets all modifiers back to their base _value.
		*/
		public function ResetModifiers() : void
		{
			for (var object : Object in modifiers)
			{
				modifiers[object] = 0.8 + 0.2 * GlobalValues.instance().level;
			}
		}
	}
}
