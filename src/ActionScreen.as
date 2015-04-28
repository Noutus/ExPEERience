package src {
	import starling.display.Button;
	import starling.core.Starling;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.events.Touch;
	import flash.desktop.NativeApplication;
	import starling.display.Image;
	import starling.textures.Texture;
	import starling.events.Event;
	import starling.text.TextField;
	import flash.utils.getTimer;
	import starling.utils.Color;
	
	public class ActionScreen extends GameScreen {
		
		private var gameTimerField: TextField;

		
		private var startTime: Number;
		// ActionScreen constructor
		public function ActionScreen() {
			super();
			
			
			setBackground(AssetNames.ACTION_BACKGROUND);
			
			addPauseButton();
			
			addRiskBar();
			
			addPleasureBar();
			
			addTimer();

			
			
			startGame();
		}

		
		public function startGame(): void {
			startTime = getTimer();
			this.addEventListener(Event.ENTER_FRAME, update);
		}
		

		private function addTimer(): void {
			gameTimerField = new TextField(100, 100, "", "Arial", 45, Color.NAVY);
			gameTimerField.border = true;
			gameTimerField.x = (Starling.current.stage.stageWidth - gameTimerField.width) / 2;
			gameTimerField.y = 20;
			addChild(gameTimerField);
			
		}
			
		/*
			Make the pause button and add it to the screen.
		*/
		private function addPauseButton(): void { 
			var button:Button = new Button(Game.instance().assets.getTexture(AssetNames.BUTTON_PAUSE));

			button.x = Starling.current.stage.stageWidth - button.width - 20;
			button.y = 20; 
			button.addEventListener(TouchEvent.TOUCH, pauseTouched);

			addChild(button);
		}
		
		public function getRiskRatio(): Number {
			return riskFill.getRatio();
		}
		
		public function setRiskRatio(ratio: Number) {
			riskFill.setRatio(ratio);
		}
		
		public function getPleasureRatio(): Number {
			return pleasureFill.getRatio();
		}
		
		public function setPleasureRatio(ratio: Number) {
			pleasureFill.setRatio(ratio);
		}
		
		private var pleasureFill: Bar;
		private function addPleasureBar(): void {
			pleasureFill = new Bar(Game.instance().assets.getTexture(AssetNames.ACTION_BAR_PLEASURE_FILL));
			pleasureFill.x = 35;
			pleasureFill.y = 500;
			
			var pleasureImage: Image = new Image(Game.instance().assets.getTexture(AssetNames.ACTION_BAR_PLEASURE_IMG));
			pleasureImage.x = 35;
			pleasureImage.y = 500;
			
			addChild(pleasureFill);			
			addChild(pleasureImage);
		}
		
		private var riskFill: Bar;
		private function addRiskBar(): void {
			riskFill = new Bar(Game.instance().assets.getTexture(AssetNames.ACTION_BAR_RISK_FILL));
			riskFill.x = 35;
			riskFill.y = 350;		
			
			var riskImage: Image = new Image(Game.instance().assets.getTexture(AssetNames.ACTION_BAR_RISK_IMG));
			riskImage.x = 35;			
			riskImage.y = 350;
						
			addChild(riskFill);			
			addChild(riskImage);
		}
		
		private var pauseStartTime: Number;
		private var paused: Boolean = false;
		private var pausedTime: Number;
		
		/*
			What happens when the pause button is touched
		*/	
		private function pauseTouched(event:TouchEvent):void {
			var touch: Touch = event.touches[0];
			if (touch.phase == TouchPhase.ENDED) {
				trace("Pause button clicked");
				paused = !paused;
				
				if (paused) {
					pauseStartTime = getTimer();
					
				} else {
					pausedTime = getTimer() - pauseStartTime;
					startTime = startTime + pausedTime;
					
				}
			}
		}
		
		private var timeLeft: int;
		private var timeLimit: int = 10;
		
		private function update(event:Event) {
			if (!paused) {
				timeLeft = Math.ceil(timeLimit - (getTimer() - startTime) / 1000);
				gameTimerField.text = timeLeft.toString();
				
				if (timeLeft <= 0) {
					paused = true;
					trace("Game over!");
				}
			}	
		}

	}
	
}
