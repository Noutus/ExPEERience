package src.screens
{	
	import src.GameScreen;
	import starling.text.TextField;
	import flash.system.Capabilities;
	import src.display.Img;
	import starling.display.Button;
	import starling.textures.Texture;
	import starling.core.Starling;
	import starling.events.TouchEvent;
	import starling.display.Sprite;
	import src.Sound;
	import starling.events.Touch;
	import starling.events.TouchPhase;

	public class OptionScreen extends GameScreen
	{
		public function OptionScreen()
		{
			
		}
		
		var soundText : TextField;
		
		public override function OnEnter() : void
		{
			this.setBackground("main_background_orange");
			
			Img.CreateScreenSwitchButtonAt("button_back", Screens.MAINMENU, 100, 1100);
			
			Img.CreateTextAt(this, "Options", 0, 0, 720, 360, 48);
					
			soundText = Img.CreateTextAt(this, "", 0, 0, 720, 1000, 40); 
			
			setSoundText();
				
			soundText.addEventListener(TouchEvent.TOUCH, onSoundTouch);
			
		}
		
		public function setSoundText() {
			soundText.text = "Sound: " + (Sound.isMuted()? "OFF": "ON");
		}
		
		public function onSoundTouch(event: TouchEvent): void {
			
			var touch: Touch = event.touches[0];
			if (touch.phase == TouchPhase.ENDED) {
				Sound.setMute(!Sound.isMuted());
				setSoundText();
			}

		}
	}
}
