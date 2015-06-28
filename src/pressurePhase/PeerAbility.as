package src.pressurePhase {
	
	import src.*;

	/**
	 * The Peer ability that contains all the modifier he / she will add to the action phase.
	 */
	public class PeerAbility {
		
		/** The message as given in the pressure phase. */
		public var message: String;
		
		/** The modifiers linked to the message. */
		public var modifiers: Array;

		/**
		 * Creates an instance of PeerAbility.
		 *
		 * @param _message The message as given in the pressure phase.
		 * @param _modifiers The modifiers linked to the message.
		 */
		public function PeerAbility(_message: String, _modifiers: Array) {
			this.message = _message;
			this.modifiers = _modifiers;
		}

		/**
		 * Called whenever the ability is chosen. This adds the ability to the action phase modifiers.
		 */
		public function ChooseAbility() {
			for each(var _modifier: ActionModifier in modifiers) {
				_modifier.AddModifier();
			}
		}
	}
}