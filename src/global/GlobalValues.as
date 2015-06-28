package src.global {
	
	import flash.net.SharedObject;

	public class GlobalValues {
		
		/** Holds the instance of GlobalValues */
		private static var _instance: GlobalValues;

		/**
		 * Accesses the instance of <code>GlobalValues</code>.
		 *
		 * @return The instance of the <code>GlobalValues</code> class.
		 */
		public static function instance(): GlobalValues {
			if (!_instance) _instance = new GlobalValues();
			return _instance;
		}

		/** Selected gender. */
		public var gender: Boolean;

		/** Selected difficulty. Easy = 1, medium = 2, hard = 3. */
		public var difficulty: int = 2;

		/** Hold the amount of babies in the current run. */
		public var babies: int;

		/** Holds the current level. */
		public var level: int;

		/** Adds a level to the current level. */
		public function addLevel(): void {
			previousLevel = level;
			level++;
		}

		/** Current pleasure value. */
		public var pleasure: Number;

		/** Current risk value. */
		public var risk: Number;

		/** Total score obtained in current run. */
		public var totalScore: int;

		/** To remember what the previous level was for the player. */
		public var previousLevel: int;

		/** Keeps track of the badges unlocked by the player. */
		public var badgesUnlocked: String;

		/** Keeps track of the highest score obtained. */
		public var highScore: int;

		/**
		 * Creates an instance of GlobalValues.
		 */
		public function GlobalValues() {
			ResetValues();
		}

		/**
		 * Resets all values back to their base value.
		 */
		public function ResetValues(): void {
			gender = false;
			babies = 0;
			level = 1;
			previousLevel = 0;
			pleasure = 0.50;
			risk = 0.00;
			totalScore = 0;
			badgesUnlocked = "fffffffffffffffffffffffff";
		}

		/**
		 * Retreives values from an external save file.
		 */
		public function LoadGame(): void {
			var _data: SharedObject = SharedObject.getLocal("SaveGame");
			gender = _data.data.gender;
			babies = _data.data.babies;
			level = _data.data.level;
			previousLevel = _data.data.previousLevel;
			pleasure = _data.data.pleasure;
			risk = _data.data.risk;
			totalScore = _data.data.totalScore;
			highScore = _data.data.highScore;
			if (_data.data.badgesUnlocked) badgesUnlocked = _data.data.badgesUnlocked;
		}

		/**
		 * Stores the current values to an external save file.
		 */
		public function SaveGame(): void {
			var _data: SharedObject = SharedObject.getLocal("SaveGame");
			_data.data.gender = gender;
			_data.data.babies = babies;
			_data.data.level = level;
			_data.data.previousLevel = previousLevel;
			_data.data.pleasure = pleasure;
			_data.data.risk = risk;
			_data.data.totalScore = totalScore;
			_data.data.highScore = highScore;
			_data.data.badgesUnlocked = badgesUnlocked;
		}

		/**
		 * Checks if the player has advanced his level in the previous action phase.
		 *
		 * @return Returns true if the level has been changed.
		 */
		public function LevelChanged(): Boolean {
			return !(level == previousLevel);
		}

		/**
		 * Saves the options to an external save file.
		 */
		public function saveOptions(): void {
			var _data: SharedObject = SharedObject.getLocal("SaveGame");
			_data.data.muted = Sound.isMuted();
			_data.data.difficulty = difficulty;
		}

		/**
		 * Loads the options settings from an external save file.
		 */
		public function loadOptions(): void {
			var _data: SharedObject = SharedObject.getLocal("SaveGame");
			Sound.setMute(_data.data.muted);
			difficulty = _data.data.difficulty;
		}

		/**
		 * Checks if the current score is above the current hi-score. If so, set the new hi-score!
		 */
		public function SetNewScore(): void {
			if (totalScore > highScore) highScore = totalScore;
		}

		/**
		 * Unlocks a badge with the specified index.
		 *
		 * @param Badge index as found in the StatisticsScreen class.
		 */
		public function unlockBadge(index: int) {
			badgesUnlocked = badgesUnlocked.substr(0, index) + "t" + badgesUnlocked.substr(index + 1);
		}
	}
}