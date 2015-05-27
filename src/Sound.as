package src {
	import flash.media.Sound;
	import flash.media.SoundChannel;
	
	
	/**
	*	Has a looping sound and a method to play a sound once. If you start a sound once and start a sound
	*	once before the other sound has ended it will stop the first started sound
	*/
	public class Sound {
		
		public static var loopingSoundChannel: SoundChannel = new SoundChannel();
		
		public static function playLooping(assetName: String) {
			stopLooping();
			loopingSoundChannel = Game.instance().assets.getSound(assetName).play(0, int.MAX_VALUE);
		}
		
		public static function stopLooping() {
			loopingSoundChannel.stop();
		}
				
		
		public static var soundChannel: SoundChannel = new SoundChannel();

		public static function play(assetName: String) {
			stop();
			soundChannel = Game.instance().assets.getSound(assetName).play();
		}
		
		public static function stop() {
			soundChannel.stop();
		}

	}
	
}
