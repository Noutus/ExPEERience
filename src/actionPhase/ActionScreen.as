package src.actionPhase {
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
	import src.screens.ScoreScreen;
	import src.*;
	import flash.system.Capabilities;
	import src.display.Img;
	
	public class ActionScreen extends GameScreen {
		
		private var gameTimerField: TextField;

		private var activeButtons: Vector.<PopupButton> = new Vector.<PopupButton>();
		
		private var popupController: PopupController;
		

		private var startTime: Number;
		
		// ActionScreen constructor
		public function ActionScreen() {
			super();
			
			setBackground(AssetNames.ACTION_BACKGROUND);
			
			addPauseButton();
			
			addRiskBar();
			
			addPleasureBar();
			
			addTimer();		
			
			addPopupController();

		}

		public override function OnEnter(): void {
			super.OnEnter();
			
			startTime = getTimer();
			
			popupController.startSpawning();
			
			this.addEventListener(Event.ENTER_FRAME, update);
		}
		
		public override function OnExit(): void
		{
			super.OnExit();
			
			if (popupController && popupController.isSpawning()) {
				popupController.stopSpawning();
			}
			
		}
			
		private function addPopupController(): void {
			popupController = new PopupController(this);
			
		}		

		private function addTimer(): void {
			
			var squasize: Number = 100 / 720 * Capabilities.screenResolutionX;
			var textsize: Number = 45 / 720 * Capabilities.screenResolutionX;
			
			gameTimerField = new TextField(squasize, squasize, "", "Arial", textsize, Color.NAVY);
			gameTimerField.border = true;
			gameTimerField.x = (Starling.current.stage.stageWidth - gameTimerField.width) / 1440 * Capabilities.screenResolutionX;
			gameTimerField.y = 10;
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
			
			Img.ChangeSpriteSize(button);
			
			addChild(button);
		}
		
		public function getPleasureRatio(): Number {
			return pleasureFill.getRatio();
		}
		
		public function setPleasureRatio(ratio: Number) {
			pleasureFill.setRatio(ratio);
		}
		
		public function alterPleasure(ratio: Number) {
			pleasureFill.setRatio(getPleasureRatio() + ratio);
			
			if (pleasureFill.getRatio() >= 1) {
				trace("Pleasure full!");
			}
		}
		
		public function getRiskRatio(): Number {
			return riskFill.getRatio();
		}
		
		public function setRiskRatio(ratio: Number) {
			riskFill.setRatio(ratio);
		}
		
		public function alterRisk(ratio: Number) {
			riskFill.setRatio(getRiskRatio() + ratio);
			
			if (riskFill.getRatio() >= 1) {
				trace("Risk full! Pregnant!");
			}
		}
		
		private var pleasureFill: Bar;
		private function addPleasureBar(): void {
			pleasureFill = new Bar(Game.instance().assets.getTexture(AssetNames.ACTION_BAR_PLEASURE_FILL));
			var pleasureImage: Image = new Image(Game.instance().assets.getTexture(AssetNames.ACTION_BAR_PLEASURE_IMG));
			
			Img.ChangeSpriteSize(pleasureFill);
			Img.ChangeSpriteSize(pleasureImage);
			
			addChild(pleasureFill);			
			addChild(pleasureImage);
		}
		
		private var riskFill: Bar;
		private function addRiskBar(): void {
			riskFill = new Bar(Game.instance().assets.getTexture(AssetNames.ACTION_BAR_RISK_FILL));
			var riskImage: Image = new Image(Game.instance().assets.getTexture(AssetNames.ACTION_BAR_RISK_IMG));
			
			Img.ChangeSpriteSize(riskFill);
			Img.ChangeSpriteSize(riskImage);
			
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
				
				if (!isPaused()) {
					pauseStartTime = getTimer();
					
					popupController.pause();
	
				} else {
					pausedTime = getTimer() - pauseStartTime;
					startTime = startTime + pausedTime;
					
					popupController.resume();

				}
				paused = !paused;
			}
		}
		
		public function isPaused(): Boolean {
			return paused;
		}
		
		private var timeLeft: int;
		// Base time limit is 100.
		private var timeLimit: int = 15 * ActionValues.instance().GetModifier(ActionValues.TIME_LIMIT);
		
		private function update(event:Event) {
			if (!isPaused()) {
				timeLeft = Math.ceil(timeLimit - (getTimer() - startTime) / 1000);
				gameTimerField.text = timeLeft.toString();
				
				if (timeLeft <= 0) {
					paused = true;
					trace("Game over!");
					
					Game.instance().SwitchScreen(new ScoreScreen());
				}
			}	
		}

	}
	
}
