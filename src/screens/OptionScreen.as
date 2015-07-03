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

	/**
	* class OptionScreen can be accessed from the main menu and contains options that the user should be able to change
	*/
	public class OptionScreen extends GameScreen
	{
		
		// The difficulties in the game
		private static var difficulties: Array = [1, 2, 3];
		// The names of the difficulties
		private static var difficultyNames: Array = ["easy", "medium", "hard"];
	
		/**
		* constructor OptionScreen
		*/
		public function OptionScreen()
		{
			
		}
		
		// Text showing the sound status
		var soundText : TextField;
		// Text showing the current difficulty
		var difficultyText: TextField;
		
		/**
		* function OnEnter builds the screen 
		*/
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
		
		/**
		* function setSoundText sets the text of the Sound-TextField to represent the current state of the mute
		*/
		public function setSoundText() {
			soundText.text = "Sound: " + (Sound.isMuted()? "OFF": "ON");
			GlobalValues.instance().saveOptions();
		}
		
		/**
		* function setDifficultyText sets the text of the difficulty-TextField to show the current difficulty
		*/
		public function setDifficultyText() {
			difficultyText.text = "difficulty: " + difficultyNames[difficulties.indexOf(GlobalValues.instance().difficulty)];
			GlobalValues.instance().saveOptions();
		}
		
		/**
		* function onSoundTouch is called when the sound is touched, changes the mute to the opposite of what it was
		*/
		public function onSoundTouch(event: TouchEvent): void {
			var touch: Touch = event.touches[0];
			if (touch.phase == TouchPhase.ENDED) {
				Sound.setMute(!Sound.isMuted());
				
				// Update the text that shows the current mute status
				setSoundText();
			}
		}
		
		/**
		* function increaseDifficulty() increases the difficulty.
		*/
		private function increaseDifficulty() {		
			var i: int = difficulties.indexOf(GlobalValues.instance().difficulty);
			i++;
			i %= difficulties.length;
			GlobalValues.instance().difficulty = difficulties[i];
		}
		
		/**
		* function onDifficultyTouch is called when the difficulty is touched, sets the difficulty one value harder if
		* it is an actual click
		*/
		public function onDifficultyTouch(event: TouchEvent): void {
			var touch: Touch = event.touches[0];
			if (touch.phase == TouchPhase.ENDED) {
				// 1, 2, or 3
				increaseDifficulty();
			
				// Update the text that shows the current difficulty
				setDifficultyText();
			}

		}
		
	}
}
