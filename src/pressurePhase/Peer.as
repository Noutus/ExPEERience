package src.pressurePhase {

	/**
	 * Represents the peer and all its abilities.
	 */
	public class Peer {
		
		/** Ability of the peer. */
		private var ability: PeerAbility;
		
		/**
		 * Get the peer ability.
		 *
		 * @return Returns the peer ability.
		 */
		public function GetAbility(): PeerAbility {
			return ability;
		}

		/**
		 * Creates an instance of Peer.
		 *
		 * @param _ability The ability for the Peer.
		 */
		public function Peer(_ability: PeerAbility) {
			this.ability = _ability;
		}
	}
}