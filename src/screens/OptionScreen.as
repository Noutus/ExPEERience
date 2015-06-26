package src.screens
{	
	import src.screens.GameScreen;
	import starling.text.TextField;
	import flash.system.Capabilities;
	import src.display.Img;
	import starling.display.Button;
	import starling.textures.Texture;
	import starling.core.Starling;
	import starling.events.TouchEvent;
	import starling.display.Sprite;
	import src.global.*;
	import starling.events.Touch;
	import starling.events.TouchPhase;

	public class OptionScreen extends GameScreen
	{
		public function OptionScreen()
		{
			
		}
		
		var soundText : TextField;
		var difficultyText: TextField;
		
		public override function OnEnter() : void
		{
			this.setBackground("main_background_orange");
			
			Img.CreateScreenSwitchButtonAt("button_back", Screens.MAINMENU, 100, 1100);
			
			Img.CreateTextAt(this, "Options", 0, 0, 720, 360, 48);
					
			
			soundText = Img.CreateTextAt(this, "", 0, 300, 720, 200, 40); 
			
			setSoundText();
			
			soundText.addEventListener(TouchEvent.TOUCH, onSoundTouch);
			
			
			difficultyText = Img.CreateTextAt(this, "", 0, 600, 720, 200, 40); 
			
			setDifficultyText();
			
			difficultyText.addEventListener(TouchEvent.TOUCH, onDifficultyTouch);
			
		}
		
		public function setSoundText() {
			soundText.text = "Sound: " + (Sound.isMuted()? "OFF": "ON");
			GlobalValues.instance().saveOptions();
		}
		
		public function setDifficultyText() {
			
			var text: String;
			switch (GlobalValues.instance().difficulty) {
				case 1:
					text = "easy";
				break;
				case 2:
					text = "medium";
				break;
				case 3: 
					text = "hard";
				break;
			}
			difficultyText.text = "difficulty: " + text;
			GlobalValues.instance().saveOptions();
		}
		
		public function onSoundTouch(event: TouchEvent): void {
			var touch: Touch = event.touches[0];
			if (touch.phase == TouchPhase.ENDED) {
				Sound.setMute(!Sound.isMuted());
				setSoundText();
			}
		
		}
		
		public function onDifficultyTouch(event: TouchEvent): void {
			var touch: Touch = event.touches[0];
			if (touch.phase == TouchPhase.ENDED) {
				
				// 1, 2, or 3
				GlobalValues.instance().difficulty = 1 + (GlobalValues.instance().difficulty++ % 3);
			
				setDifficultyText();
			}

		}
		
	}
}
