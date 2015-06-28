package src.global {
	
	import flash.net.SharedObject;

	/**
	 * Holds the results for the current / previous Action phase.
	 */
	public class Results {
		
		/** Holds the instance of Results. */
		private static var _instance: Results;

		/**
		 * Returns the instance of Results.
		 *
		 * @return Returns the instance of Results.
		 */
		public static function instance(): Results {
			if (!_instance) _instance = new Results();
			return _instance;
		}

		/** Pleasure gained in the action phase. */
		private var gainedPleasure: int;
		
		/** Risk gained in the action phase. */
		private var gainedRisk: int;

		/**
		 * Creates an instance of Results.
		 */
		public function Results() {
			ResetValues();
		}

		/**
		 * Sets the values of Results back to their original value.
		 */
		public function ResetValues(): void {
			gainedPleasure = 0;
			gainedRisk = 0;
		}

		/**
		 * Add an X amount of pleasure.
		 *
		 * @param The amount of pleasure added.
		 */
		public function AddPleasure(i: int) {
			gainedPleasure += i;
		}

		/** 
		 * Get the current amount of pleasure.
		 *
		 * @return Returns the current amount of pleasure.
		 */
		public function GetPleasure(): int {
			return gainedPleasure;
		}

		/**
		 * Add an X amount of risk.
		 *
		 * @param The amount of risk added.
		 */
		public function AddRisk(i: int) {
			gainedRisk += i;
		}

		/** 
		 * Get the current amount of risk.
		 *
		 * @return Returns the current amount of risk.
		 */
		public function GetRisk(): int {
			return gainedRisk;
		}
	}
}