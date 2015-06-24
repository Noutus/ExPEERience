package src.actionPhase
{
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
	import starling.display.Quad;
	import flash.geom.Rectangle;
	import src.display.Img;
	import flash.events.TimerEvent;
	import src.gui.PopupWindow;
	import src.actionPhase.Baby;
	import starling.display.DisplayObject;
	import starling.display.Sprite;
	import src.global.Messages;
	
	public class ActionScreen extends GameScreen {

		public var bottomLayer: Sprite = new Sprite();
		public var topLayer: Sprite = new Sprite();

		private var gameTimerField: TextField;

		private var babyField: TextField;

		private var pleasureTimer: PauseTimer;

		private var activeButtons: Vector.<PopupButton> = new Vector.<PopupButton>();

		private var popupController: PopupController;

		private var babyController: BabyController;

		public static var popupArea: Rectangle = new 
		Rectangle(
			0, 
			Img.GetScaledVector(0, 130)[1], 
			Starling.current.viewPort.width, 
			Img.GetScaledVector(0, 890)[1]
		);

		private var startTime: Number = getTimer();

		// ActionScreen constructor
		public function ActionScreen()
		{
			super();

			addChildAt(bottomLayer, 0)
			addChild(topLayer);

			setBackground(AssetNames.ACTION_BACKGROUND);

			addPauseButton();

			addRiskBar();

			addPleasureBar();

			addTimer();

			addPopupController();

			addBabyController();

			addPleasureTimer();


			// Only to show the area, for testing! Should not be in the final game.
			//addPopupArea(); 
			//this.setRiskRatio(1.0);
			//this.setPleasureRatio(1.0);

			// test
			//trace('Changing maximum number of taps to 3');
			//ActionValues.instance().SetModifier(ActionValues.BUTTONS_MAXIMUM_NUMBER_OF_TAPS, 3);
		}

		public override function OnEnter(): void {
			super.OnEnter();

			trace("Entering Action Screen: ");
			trace("Risk sex: " + ActionValues.instance().GetModifier(ActionValues.RISK_SEX));

			popupController.startSpawning();

			pleasureTimer.start();

			this.addEventListener(Event.ENTER_FRAME, update);

			// TODO: Add check if certain level has just been reached and show message
			if (GlobalValues.instance().LevelChanged())
			{
				if (Messages.instance().getNewLevelTitle(GlobalValues.instance().level) != "")
				{
					pause();
					var popupWindow : PopupWindow = new PopupWindow(Messages.instance().getNewLevelTitle(GlobalValues.instance().level),
																  Messages.instance().getNewLevelImage(GlobalValues.instance().level),
																  Messages.instance().getNewLevelText(GlobalValues.instance().level));
					this.addChild(popupWindow);

					popupWindow.addEventListener(PopupWindow.CLOSE_CLICKED, function(e: Event): void {
						resume();
					});
				}
			}
		}

		public override function OnExit():void
		{
			super.OnExit();

			if (popupController && popupController.isSpawning())
			{
				trace('Stopping the popupController');
				popupController.stopSpawning();
			}

			if (pleasureTimer) {
				pleasureTimer.stop();
				pleasureTimer.removeEventListener('timer', pleasureDecrease);
			}

			this.dispose();
		}

		// In de tweede level pauzeert hij niet fatsoenlijk, hij telt door maar de bar wordt pas geupdate als hij verder gaat
		private function addPleasureTimer():void
		{
			pleasureTimer = new PauseTimer(100);

			pleasureTimer.addEventListener("timer", pleasureDecrease);
		}


		private function pleasureDecrease(event: TimerEvent): void {
			alterPleasure(-0.005 * ActionValues.instance().GetModifier(ActionValues.PLEASURE_DECREASE));
		}

		// Only for testing to show where this area is.
		private function addPopupArea(): void {
			var areaTest: Quad = new Quad(popupArea.width, popupArea.height);
			areaTest.x = popupArea.x;
			areaTest.y = popupArea.y;

			bottomLayer.addChild(areaTest);

		}

		private function addPopupController():void
		{
			popupController = new PopupController(this);


		}

		private function addBabyController(): void {
			babyController = new BabyController(this);
		}

		private function addTimer(): void {

			var squasize: Number = 100 / 720 * Starling.current.viewPort.width;
			var textsize: Number = 45 / 720 * Starling.current.viewPort.width;

			gameTimerField = new TextField(squasize, squasize, getTimeLeft().toString(), "RoofRunners", textsize, Color.NAVY);
			gameTimerField.border = true;
			gameTimerField.x = (Starling.current.viewPort.width - gameTimerField.width) / 2;
			gameTimerField.y = 10;
			bottomLayer.addChild(gameTimerField);
		}

		/*
		Make the pause button and add it to the screen.
		*/

		private function addPauseButton(): void {
			var button: Button = new Button(Game.instance().assets.getTexture(AssetNames.BUTTON_PAUSE));

			Img.ChangeSpriteSize(button);
			
			button.x = Starling.current.viewPort.width - button.width - 20;
			button.y = 20;
			button.addEventListener(TouchEvent.TOUCH, pauseTouched);

			

			bottomLayer.addChild(button);
		}

		private function setPleasureRatio(ratio: Number) {
			ratio = Math.max(0.0, Math.min(1.0, ratio));

			GlobalValues.instance().pleasure = ratio;
			pleasureFill.setRatio(ratio);
		}

		// Make it finishGame() with 3 options
		// ActionScren.won, ActionScreen.failed, ActionScreen.lost (?)
		public static const WON: int = 0;
		public static const FAILED: int = 1;
		public static const LOST: int = 2;
		
		public function gameOver(kind: int) {
			if (kind == WON) {
				GlobalValues.instance().level++;
			}
			Game.instance().SwitchScreen(new ScoreScreen(kind));
		}

		// AS3 isn't multithreaded, so this code will not be interrupted. (no race conditions)
		public function alterPleasure(ratio: Number) {

			setPleasureRatio(GlobalValues.instance().pleasure + ratio);

			if (GlobalValues.instance().pleasure >= 1)
			{
				trace("Pleasure full, next level!");
				gameOver(WON);
				GlobalValues.instance().pleasure = 0.50;
			}
			if (GlobalValues.instance().pleasure <= 0)
			{
				trace("Pleasure empty, lost the game!");
				gameOver(LOST);
				GlobalValues.instance().pleasure = 0.50;
			}

		}

		public function setRiskRatio(ratio: Number) {
			ratio = Math.max(0.0, Math.min(1.0, ratio));

			GlobalValues.instance().risk = ratio;
			riskFill.setRatio(ratio);
		}

		public function addBaby(): void {
			GlobalValues.instance().babies++;
			babyController.newBaby();
		}

		public function alterBars(riskRatio: Number, pleasureRatio: Number) {
			setRiskRatio(GlobalValues.instance().risk + riskRatio);

			if (GlobalValues.instance().risk >= 1) {
				addBaby();

				pause();

				var popupWindow: PopupWindow = new PopupWindow('Baby!', AssetNames.ACTION_BABY_SLEEPING, "You've made a baby!");
				trace("Risk full! Baby!");
				addChild(popupWindow);

				popupWindow.addEventListener(PopupWindow.CLOSE_CLICKED, function (e: Event): void {
					setRiskRatio(0.0);
					resume();
					alterPleasure(pleasureRatio);
				});

			} else {
				alterPleasure(pleasureRatio);
			}
		}

		private var pleasureFill: Bar;
		private function addPleasureBar(): void {

			/*var squasize: Number = 100 / 720 * Capabilities.screenResolutionX;
			var textsize: Number = 22 / 720 * Capabilities.screenResolutionX;
			
			var pleasureField: TextField = new TextField(squasize, squasize/2, "Pleasure", "Arial", textsize, Color.NAVY);
			pleasureField.border = true;
			pleasureField.x = 35
			pleasureField.y = 1080;//1030;
			
			addChild(pleasureField);*/


			pleasureFill = new Bar(Game.instance().assets.getTexture(AssetNames.ACTION_BAR_PLEASURE_FILL));

			var pleasureImage: Image = new Image(Game.instance().assets.getTexture(AssetNames.ACTION_BAR_PLEASURE_IMG));

			pleasureImage.x = 35;
			pleasureImage.y = 1020;

			pleasureFill.x = pleasureImage.x + 10;
			pleasureFill.y = pleasureImage.y + 10;

			Img.ChangeSpriteSize(pleasureFill);
			Img.ChangeSpriteSize(pleasureImage);

			bottomLayer.addChild(pleasureFill);
			bottomLayer.addChild(pleasureImage);

			setPleasureRatio(GlobalValues.instance().pleasure);
		}

		private var riskFill: Bar;
		private function addRiskBar(): void {
			/*var squasize: Number = 100 / 720 * Capabilities.screenResolutionX;
			var textsize: Number = 22 / 720 * Capabilities.screenResolutionX;
			
			var riskField: TextField = new TextField(squasize, squasize/2, "Risk", "Arial", textsize, Color.NAVY);
			riskField.border = true;
			riskField.x = 35
			riskField.y = 1200;//1150;
			
			addChild(riskField);*/


			riskFill = new Bar(Game.instance().assets.getTexture(AssetNames.ACTION_BAR_RISK_FILL));
			var riskImage: Image = new Image(Game.instance().assets.getTexture(AssetNames.ACTION_BAR_RISK_IMG));

			riskImage.x = 35;
			riskImage.y = 1150;

			riskFill.x = riskImage.x + 10;
			riskFill.y = riskImage.y + 10;

			Img.ChangeSpriteSize(riskFill);
			Img.ChangeSpriteSize(riskImage);

			bottomLayer.addChild(riskFill);
			bottomLayer.addChild(riskImage);

			setRiskRatio(GlobalValues.instance().risk);
		}
		
		public static function getLocation(): String {
			return "Partner";
		}


		private var pauseStartTime: Number;
		private var paused: Boolean = false;
		private var pausedTime: Number;


		public function pause(): void {
			pauseStartTime = getTimer();

			pleasureTimer.pause();

			popupController.pause();
			
			babyController.pause();
			
			paused = true;
		}

		public function resume():void
		{
			pleasureTimer.resume();

			pausedTime = getTimer() - pauseStartTime;
			startTime = startTime + pausedTime;

			popupController.resume();
			
			babyController.resume();

			paused = false;
		}


		var pausedWindow: PopupWindow;
		/*
			What happens when the pause button is touched
		*/
		private function pauseTouched(event: TouchEvent): void {
			var touch: Touch = event.touches[0];
			if (touch.phase == TouchPhase.BEGAN) {
				trace("Pause button clicked");

				
				if (!isPaused()) {
					pause();

					pausedWindow = new PopupWindow('Paused!', AssetNames.LOGO, "You have paused the game.");
					addChild(pausedWindow);
					pausedWindow.setImageSizeMultiplier(2);

					pausedWindow.addEventListener(PopupWindow.CLOSE_CLICKED, function (e: Event): void {
						resume();
					});
					
				}
			}
		}

		public function isPaused(): Boolean {
			return paused;
		}

		public function moveBabies(): void {
			babyController.moveBabies();
		}

		// Base time limit is 100.
		private var timeLimit: int = 15 * ActionValues.instance().GetModifier(ActionValues.TIME_LIMIT);

		private function getTimeLeft(): int {
			return Math.ceil(timeLimit - (getTimer() - startTime) / 1000);
		}

		private function update(event: Event) {
			if (!isPaused()) {
				
				gameTimerField.text = getTimeLeft().toString();

				if (getTimeLeft() <= 0) {
					paused = true;
					trace("Game over!");

					gameOver(FAILED);

				}

				moveBabies();
			}
		}

	}

}