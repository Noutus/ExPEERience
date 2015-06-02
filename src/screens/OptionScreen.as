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
			Img.CreateScreenSwitchButtonAt("button_back", Screens.MAINMENU, 100, 1100);
			
			var position : Vector.<Number> = Img.GetScaledVector(0, 0);
			var scale : Vector.<Number> = Img.GetScaledVector(720, 360);
			
			var pleasureText : TextField = new TextField(scale[0], scale[1], "Options");
				pleasureText.fontSize = 48 / 720 * Capabilities.screenResolutionX;
				pleasureText.x = position[0];
				pleasureText.y = position[1];
				addChild(pleasureText);
			
						
			
			position = Img.GetScaledVector(0, 0);
			scale = Img.GetScaledVector(720, 1000);
			
			soundText = new TextField(scale[0], scale[1], "");
			soundText.fontSize = 30 / 720 * Capabilities.screenResolutionX;
			soundText.x = position[0];
			soundText.y = position[1];
			setSoundText();
			addChild(soundText);
				
			soundText.addEventListener(TouchEvent.TOUCH, onSoundTouch);
			
			
			
				/*
				
			var button: Button = new Button(new Texture, "Sound");

			button.x = Starling.current.stage.stageWidth - button.width - 20;
			button.y = 20;
			button.addEventListener(TouchEvent.TOUCH, soundTouched);

			Img.ChangeSpriteSize(button);

			addChild(button);
			
			*/
			
			
			
			/*
			
			tMessages.text=" Pick your favorite color" ;

			//Labels the button at runtime
			bRed.label = " Turn Red" ;
			//sets the toggle mode
			bRed.toggle = true;

			//Click listener
			bRed.addEventListener(MouseEvent.CLICK, fRed);

			function fRed(event:MouseEvent):void {
			trace(event.target.selected);
			//Checks to see if button is toggled down
				if (event.target.selected==true) {
					//changes the text color
					pleasureText.textColor = 0xFF0000;
					//changes the button label
					event.target.label = " Turn White" ;
				} else {
					tMessages.textColor = 0xFFFFFF;
					event.target.label = " Turn Red" ;
				}
			}
			
			*/
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
