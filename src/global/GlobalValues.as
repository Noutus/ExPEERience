package src.global {
	
	import flash.net.SharedObject;
	import src.actionPhase.PopupButton;
	import src.screens.StatisticsScreen;

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
		public var badgesUnlocked: String = "ffffffffffffffffffffffffffffffffffffffffff";

		/** Keeps track of the highest score obtained. */
		public var highScore: int;
		
		/** Amount of hug buttons pressed since new game. */
		public var hugPressed: int;
		
		/** Amount of kiss buttons pressed since new game. */
		public var kissPressed: int;
		
		/** Amount of sex buttons pressed since new game. */
		public var sexPressed: int;
		
		/** Amount of condom uses in a row. */
		public var condomUsed: int;

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
			_data.data.hugPressed = hugPressed;
			_data.data.kissPressed = kissPressed;
			_data.data.sexPressed = sexPressed;
			_data.data.condomUsed = condomUsed;
			_data.data.badgesUnlocked = badgesUnlocked;
		}

		/**
		 * Loads the options settings from an external save file.
		 */
		public function loadOptions(): void {
			var _data: SharedObject = SharedObject.getLocal("SaveGame");
			Sound.setMute(_data.data.muted);
			difficulty = _data.data.difficulty;
			hugPressed = _data.data.hugPressed;
			kissPressed = _data.data.kissPressed;
			sexPressed = _data.data.sexPressed;
			condomUsed = _data.data.condomUsed;
			if (_data.data.badgesUnlocked) badgesUnlocked = _data.data.badgesUnlocked;
			if (difficulty == 0)
				difficulty = 2;
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
			saveOptions();
		}
		
		public function addButtonTouched(i: int): void {
			switch(i)
			{
				case PopupButton.POPUP_TOUCH: {
					hugPressed++;
					saveOptions();
					trace("hug!" + hugPressed);
					if (hugPressed > 1000) unlockBadge(StatisticsScreen.BADGE_HUG);
					break;
				}
				case PopupButton.POPUP_KISS: {
					kissPressed++;
					saveOptions();
					if (kissPressed > 1000) unlockBadge(StatisticsScreen.BADGE_KISS);
					break;
				}
				case PopupButton.POPUP_SEX: {
					sexPressed++;
					saveOptions();
					if (sexPressed > 1000) unlockBadge(StatisticsScreen.BADGE_SEX);
					break;
				}
			}
			if (hugPressed + kissPressed + sexPressed > 5000) unlockBadge(StatisticsScreen.BADGE_BUTTON);
		}
		
		public function addCondomUsed(b: Boolean): void {
			if (b) {
				condomUsed++;
				if (condomUsed >= 5) unlockBadge(StatisticsScreen.BADGE_5_CONDOMS);
				if (condomUsed >= 10) unlockBadge(StatisticsScreen.BADGE_10_CONDOMS);
			} else {
				condomUsed = 0;
			}
			saveOptions();
		}
	}
}