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
	import starling.display.Quad;
	import flash.geom.Rectangle;
	
	public class ActionScreen extends GameScreen {
		
		private var gameTimerField: TextField;

		private var activeButtons: Vector.<PopupButton> = new Vector.<PopupButton>();
		
		private var popupController: PopupController;
		
		public static var popupArea: Rectangle = 
		new Rectangle(0, 130, Starling.current.stage.stageWidth, Starling.current.stage.stageHeight - 500);	

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

			// Only to show the area, for testing! Should not be in the final game.
			addPopupArea(); 
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
		
		// Only for testing to show where this area is.
		private function addPopupArea(): void {			
			var areaTest: Quad = new Quad(popupArea.width, popupArea.height);
			areaTest.x = popupArea.x;
			areaTest.y = popupArea.y;
			
			addChild(areaTest);
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
			
			Game.ChangeSpriteSize(button);
			
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
			var v : Vector.<Number> = Game.GetScaledVector(35, 920);
			
			pleasureFill = new Bar(Game.instance().assets.getTexture(AssetNames.ACTION_BAR_PLEASURE_FILL));
			pleasureFill.x = v[0];
			pleasureFill.y = v[1];
			
			var pleasureImage: Image = new Image(Game.instance().assets.getTexture(AssetNames.ACTION_BAR_PLEASURE_IMG));
			pleasureImage.x = v[0];
			pleasureImage.y = v[1];
			
			var s : Vector.<Number> = Game.GetScaledVector(650, 120);
			
			pleasureFill.width = s[0];
			pleasureFill.height = s[1];
			pleasureImage.width = s[0];
			pleasureImage.height = s[1];
			
			addChild(pleasureFill);			
			addChild(pleasureImage);
		}
		
		private var riskFill: Bar;
		private function addRiskBar(): void {
			var v : Vector.<Number> = Game.GetScaledVector(35, 1100);
			
			riskFill = new Bar(Game.instance().assets.getTexture(AssetNames.ACTION_BAR_RISK_FILL));
			riskFill.x = v[0];
			riskFill.y = v[1];		
			
			var riskImage: Image = new Image(Game.instance().assets.getTexture(AssetNames.ACTION_BAR_RISK_IMG));
			riskImage.x = v[0];			
			riskImage.y = v[1];
			
			var s : Vector.<Number> = Game.GetScaledVector(650, 120);
			
			riskFill.width = s[0];
			riskFill.height = s[1];
			riskImage.width = s[0];
			riskImage.height = s[1];
			
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
