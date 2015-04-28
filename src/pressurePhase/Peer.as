package src.pressurePhase
{
	public class Peer
	{
		private var ability : PeerAbility;
		public function GetAbility() : PeerAbility
		{
			return ability;
		}
		
		public function Peer(_ability : PeerAbility)
		{
			this.ability = _ability;
		}
	}
}
