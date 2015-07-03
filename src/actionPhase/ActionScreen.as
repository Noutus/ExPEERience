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
	import src.*;
	import starling.display.Quad;
	import flash.geom.Rectangle;
	import flash.events.TimerEvent;
	import src.actionPhase.Baby;
	import starling.display.DisplayObject;
	import starling.display.Sprite;
	import src.screens.*;
	import src.display.*;
	import src.global.*;

	/**
	 * class ActionScreen contains the complete ActionScreen
	 */
	public class ActionScreen extends GameScreen {

		// The bottom layer of display objects (everything except the babies)
		public var bottomLayer: Sprite = new Sprite();

		// The top layer of display objects (babies)
		public var topLayer: Sprite = new Sprite();

		// The timer that shows how much time there's left
		private var gameTimerField: TextField;

		// The timer used to make the pleasure decrease over time
		private var pleasureTimer: PauseTimer;

		// A list of the currently active PopupButtons
		private var activeButtons: Vector.< PopupButton > = new Vector.< PopupButton > ();

		private var popupController: PopupController;
		private var babyController: BabyController;

		// The area in which PopupButtons will be spawned
		public static var popupArea: Rectangle = new
		Rectangle(
			0,
			Img.GetScaledVector(0, 130)[1],
			Starling.current.viewPort.width,
			Img.GetScaledVector(0, 890)[1]
		);

		// The time at which the game is started
		private var startTime: Number = getTimer();

		/**
		 * ActionScreen constructor, builds most of the screen
		 */
		public function ActionScreen() {
			super();

			// Place the layers
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
		}

		/**
		 * OnEnter function, gets called once the screen is entered. It starts everything inside the screen.
		 */
		public override function OnEnter(): void {
			super.OnEnter();

			trace("Entering Action Screen: ");
			trace("Risk sex: " + ActionValues.instance().GetModifier(ActionValues.RISK_SEX));

			popupController.startSpawning();

			// Start decreasing pleasure over time
			pleasureTimer.start();

			this.addEventListener(Event.ENTER_FRAME, update);

			if (GlobalValues.instance().LevelChanged()) {
				if (Messages.instance().getNewLevelTitle(GlobalValues.instance().level) != "") {
					pause();
					var popupWindow: PopupWindow = new PopupWindow(Messages.instance().getNewLevelTitle(GlobalValues.instance().level),
						Messages.instance().getNewLevelImage(GlobalValues.instance().level),
						Messages.instance().getNewLevelText(GlobalValues.instance().level));
					this.addChild(popupWindow);

					popupWindow.addEventListener(PopupWindow.CLOSE_CLICKED, function (e: Event): void {
						resume();
					});
				}
			}
		}

		/**
		 * OnExit function, called when the screen is exited. Stops everything in the screen.
		 */
		public override function OnExit(): void {
			super.OnExit();

			if (popupController && popupController.isSpawning()) {
				trace('Stopping the popupController');
				popupController.stopSpawning();
			}

			if (pleasureTimer) {
				pleasureTimer.stop();
				pleasureTimer.removeEventListener('timer', pleasureDecrease);
			}

			this.dispose();
		}

		// The amount of time between pleasure decreases, which depends on the difficulty:
		// hard   =	100	= 10x per second
		// medium = 130	= 7.6x per second
		// easy   =	160	= 6.25x per second
		private var pauseTimerMS: int = 190 - (30 * GlobalValues.instance().difficulty);
		
		/**
		 * function AddPleasureTimer initializes the pleasureTimer
		 */
		private function addPleasureTimer(): void {
			pleasureTimer = new PauseTimer(pauseTimerMS);

			pleasureTimer.addEventListener("timer", pleasureDecrease);
		}

		
		
		/**
		 * function pleasureDecrease called all the time by the pleasureTimer, slightly decreases the pleasure.
		 *
		 * @param	event	The TimerEvent that is being dispatched
		 */
		private function pleasureDecrease(event: TimerEvent): void {
			alterPleasure(-0.005 * ActionValues.instance().GetModifier(ActionValues.PLEASURE_DECREASE));
		}

		/**
		 * function addPopupController initializes the PopupController
		 */
		private function addPopupController(): void {
			popupController = new PopupController(this);
		}

		/**
		 * function addBabyController initializes the BabyController
		 */
		private function addBabyController(): void {
			babyController = new BabyController(this);
		}

		/**
		 * function addTimer initializes the main game timer and adds it to the screen
		 */
		private function addTimer(): void {

			var squasize: Number = 100 / 720 * Starling.current.viewPort.width;
			var textsize: Number = 45 / 720 * Starling.current.viewPort.width;

			gameTimerField = new TextField(squasize, squasize, getTimeLeft().toString(), "RoofRunners", textsize, Color.NAVY);
			gameTimerField.border = true;
			gameTimerField.x = (Starling.current.viewPort.width - gameTimerField.width) / 2;
			gameTimerField.y = 10;
			bottomLayer.addChild(gameTimerField);
		}

		/**
		 * function addPauseButton initializes the pause button and adds it to the screen
		 */
		private function addPauseButton(): void {
			var button: Button = new Button(Game.instance().assets.getTexture(AssetNames.BUTTON_PAUSE));

			Img.ChangeSpriteSize(button);

			button.x = Starling.current.viewPort.width - button.width - 20;
			button.y = 20;
			button.addEventListener(TouchEvent.TOUCH, pauseTouched);

			bottomLayer.addChild(button);
		}

		/**
		 * function setPleasureRatio sets the ratio of the pleasurebar
		 *
		 * @param	ratio	The new pleasure ratio
		 */
		private function setPleasureRatio(ratio: Number) {
			ratio = Math.max(0.0, Math.min(1.0, ratio));

			GlobalValues.instance().pleasure = ratio;
			pleasureFill.setRatio(ratio);
		}

		// The ways in which the game can be ended
		public static const WON: int = 0; // Won the game, next level
		public static const FAILED: int = 1; // Failed the game, same level
		public static const LOST: int = 2; // Lost the game, completely game over

		/**
		 * function gameOver ends the game
		 *
		 * @param	kind	The kind of game-over it is
		 */
		public function gameOver(kind: int) {
			if (kind == WON) {
				GlobalValues.instance().level++;
				switch (GlobalValues.instance().level) {
					case 2: GlobalValues.instance().unlockBadge(StatisticsScreen.BADGE_LEVEL_2); break;
					case 3: GlobalValues.instance().unlockBadge(StatisticsScreen.BADGE_LEVEL_3); break;
					case 5: GlobalValues.instance().unlockBadge(StatisticsScreen.BADGE_LEVEL_5); break;
					case 7: GlobalValues.instance().unlockBadge(StatisticsScreen.BADGE_LEVEL_7); break;
					case 9: GlobalValues.instance().unlockBadge(StatisticsScreen.BADGE_LEVEL_9); break;
					case 10: GlobalValues.instance().unlockBadge(StatisticsScreen.BADGE_FINISHED); break;					
				}
			}
			Game.instance().SwitchScreen(new ScoreScreen(kind));
		}

		/**
		 * function alterPleasure alters the pleasure by the specified amount
		 *
		 * @param	ratio	The amount of ratio that the pleasure is altered by. Can be negative.
		 */
		public function alterPleasure(ratio: Number) {

			setPleasureRatio(GlobalValues.instance().pleasure + ratio);

			if (GlobalValues.instance().pleasure >= 1) {
				trace("Pleasure full, next level!");
				gameOver(WON);
				GlobalValues.instance().pleasure = 0.50;
			}
			if (GlobalValues.instance().pleasure <= 0) {
				trace("Pleasure empty, lost the game!");
				gameOver(LOST);
				GlobalValues.instance().pleasure = 0.50;
			}

		}

		/**
		 * function setRiskRatio sets the risk ratio to the specified amount
		 *
		 * @param	ratio	The ratio it is set to
		 */
		public function setRiskRatio(ratio: Number) {
			ratio = Math.max(0.0, Math.min(1.0, ratio));

			GlobalValues.instance().risk = ratio;
			riskFill.setRatio(ratio);
		}

		/**
		 * function addBaby increases the amount of babies by one
		 */
		public function addBaby(): void {
			GlobalValues.instance().babies++;
			babyController.newBaby();
		}

		/**
		 * function alterBars alters both the bars (risk and pleasure), and creates a new baby if the risk is full.
		 *
		 * @param	riskRatio		The amount of ratio the risk bar is altered by
		 * @param 	pleasureRatio	The amount of ratio the pleasure bar is altered by
		 */
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

		// The fill of the pleasure-bar
		private var pleasureFill: Bar;

		/**
		 * function addPleasureBar initializes the pleasure bar (including the fill), and adds it to the screen.
		 */
		private function addPleasureBar(): void {
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

		// The fill of the risk-bar
		private var riskFill: Bar;

		/**
		 * function addRiskBar initializes the risk bar (including the fill), and adds it to the screen.
		 */
		private function addRiskBar(): void {
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

		/**
		 * function getLocation
		 *
		 * @return	String	the story-line location of the ActionScreen
		 */
		public static function getLocation(): String {
			return "Partner";
		}

		// The time at which the ActionScreen is paused
		private var pauseStartTime: Number;
		// Whether the ActionScreen is paused or not
		private var paused: Boolean = false;

		/**
		 * function pause pauses everything in the ActionScreen
		 */
		public function pause(): void {
			pauseStartTime = getTimer();

			pleasureTimer.pause();

			popupController.pause();

			babyController.pause();

			paused = true;
		}

		/**
		 * function resume resumes everything in the ActionScreen
		 */
		public function resume(): void {
			pleasureTimer.resume();

			// Add the amount of time the ActionScreen was paused from the startTime
			startTime = startTime + getTimer() - pauseStartTime;

			popupController.resume();

			babyController.resume();

			paused = false;
		}

		// The pausedWindow used and shown when the game is paused
		var pausedWindow: PopupWindow;

		/**
		 * function pauseTouched called when the pauseButton is touched
		 *
		 * @param	event	The event that is being dispatched
		 */
		private function pauseTouched(event: TouchEvent): void {
			var touch: Touch = event.touches[0];
			if (touch.phase == TouchPhase.BEGAN) {

				if (!isPaused()) {
					pause();

					pausedWindow = new PopupWindow('Game Paused', AssetNames.LOGO, "", true);
					addChild(pausedWindow);
					pausedWindow.setImageSizeMultiplier(2);

					pausedWindow.addEventListener(PopupWindow.CLOSE_CLICKED, function (e: Event): void {
						resume();
					});
				}
			}
		}

		/**
		 * function isPaused
		 *
		 * @return	Boolean	Whether or not the ActionScreen is currently paused
		 */
		public function isPaused(): Boolean {
			return paused;
		}

		/**
		 * function moveBabies tells the babyController to move the babies a step
		 */
		public function moveBabies(): void {
			babyController.moveBabies();
		}

		// The time limit 
		private var timeLimit: int = 15 * ActionValues.instance().GetModifier(ActionValues.TIME_LIMIT);

		/**
		 * function getTimeLeft
		 *
		 * @return	int	The time that is left until the current game is finished
		 */
		private function getTimeLeft(): int {
			return Math.ceil(timeLimit - (getTimer() - startTime) / 1000);
		}

		/**
		 * function update, called with every frame.
		 *
		 * @param	event	The event that is being dispatched
		 */
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