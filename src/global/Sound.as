package src.global {
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.media.SoundMixer;
	import src.Game;
	
	
	/**
	* class Sound has a looping sound and a method to play a sound once. If you start a sound once and start a sound
	* once before the other sound has ended it will stop the first started sound
	*/
	public class Sound {
		
		// The SoundChannel of the looping sound
		private static var loopingSoundChannel: SoundChannel = new SoundChannel();
		
		private static var soundTransform: SoundTransform = new SoundTransform(1,0);
		
		/**
		* function playLooping plays the given asset and loops all the time. Only one sound can be looped at a time
		*/
		public static function playLooping(assetName: String) {
			stopLooping();
			loopingSoundChannel = Game.instance().assets.getSound(assetName).play(0, int.MAX_VALUE);
		}
		
		/**
		* function stopLooping stops the currently looping sound
		*/
		public static function stopLooping() {
			loopingSoundChannel.stop();
		}
				
		// The SoundChannel of the once playing sound
		private static var soundChannel: SoundChannel = new SoundChannel();

		/**
		* function play plays the given asset once
		*/
		public static function play(assetName: String) {
			stop();
			soundChannel = Game.instance().assets.getSound(assetName).play();
		}
		
		/**
		* function stop stops the once playing sound
		*/
		public static function stop() {
			soundChannel.stop();
		}
		
		/**
		* function setMute
		* 
		* @param	Boolean	set the mute true or false
		*/
		public static function setMute(muteOn: Boolean) {
			soundTransform.volume = muteOn? 0: 1;
			SoundMixer.soundTransform = soundTransform;
		}
		
		/**
		* function isMuted 
		*
		* @return	Boolean	whether or not the sound is currently muted 
		*/
		public static function isMuted(): Boolean {
			return soundTransform.volume == 0;
		}
	}
	
}
