package src.actionPhase {
	import src.actionPhase.ActionValues;
	import src.global.AssetNames;
	import starling.display.Sprite;
	import src.Game;
	import starling.display.Image;
	import src.global.GlobalValues;
	import starling.core.Starling;
	import flash.geom.Rectangle;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.events.Touch;
	import starling.animation.IAnimatable;
	import src.actionPhase.PauseTimer;
	import flash.events.TimerEvent;
	import src.display.BitmapImage;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.net.URLRequest;
	import flash.globalization.LastOperationStatus;
	import src.events.BitmapEvent;
	import src.events.BitmapLoader;
	import src.screens.MainMenuScreen;
	import src.display.Img;
	
	/**
	* class Baby
	*/
	public class Baby extends Sprite {

		private static var minBabySpeed: int = 1;
		private static var maxBabySpeed: int = 6;
		
		private var speedX: int = calcSpeed();
		private var speedY: int = calcSpeed();
		
		/**
		* calculates a speed for the baby, between minBabySpeed and maxBabySpeed in any direction
		* 
		* @return	int	Calculated speed
		*/
		private static function calcSpeed(): int {
			var speed: int;
			do {
				speed = -maxBabySpeed + Math.random() * (maxBabySpeed * 2 + 1);
			} while (speed >= -minBabySpeed && speed <= minBabySpeed);
			return speed;
		}
		
		private var babyController: BabyController;
		private var actionScreen: ActionScreen;
		
		/**
		* Constructor Baby
		* 
		* @param	BabyController	The BabyController this baby is part of
		* @param	ActionScreen	The ActionScreen this baby is part ofs
		*/
		public function Baby(babyController: BabyController, actionScreen: ActionScreen) {
			this.babyController = babyController;
			this.actionScreen = actionScreen;
			
			createCryingImage();
			createSleepingImage();
		}
		
		// Maximum amount of times it may try to put this baby somewhere on the screen where no other babies are.
		private static const maxRandomSpotTries: int = 30;
				
		/**
		* function spotOK checks if it's okay to put the baby at the given x, y -coordinates
		* 
		* @param	x	The X-position to be checked
		* @param	y	The Y-position to be checked
		* @return	Boolean	Whether it's okay to put the baby at the given position or not
		*/
		public function spotOK(x: int, y: int): Boolean {

			// All babies on the screen
			var babies: Vector.<Baby> = babyController.getBabies();
			
			// Go through them all
			for each (var baby: Baby in babies) {
				// Except this baby itself
				if (!(baby == this)) {
					// If the x and y position is a position inside the baby that's being checked, then return false (spot not OK)
					if ((x + this.width >= baby.x) && 
						(x <= baby.x + baby.width) && 
						(y + this.height >= baby.y) && 
						(y <= baby.y + baby.height)) {
						
						return false;
					}
				}
			}
			// Looped through all babies and the x, y-position is in none of them
			return true;
		}

		/**
		* function placeAtRandomSpot places this baby on a spot on the screen
		* 
		* @param	int		the amount of times it already tried to put this baby on-screen, should only be used internally by this function
		* @return	Boolean	Whether it has put the baby on screen or not
		*/
		public function placeAtRandomSpot(depth: int = 0): Boolean {

			this.x = Math.floor(Math.random() * (Starling.current.stage.stageWidth - this.width)); 
			this.y = Math.floor(Math.random() * (Starling.current.stage.stageHeight - this.height));
			
			if (!spotOK(x, y)) {
				trace("Chosen position overlaps other baby. Picking a new spot.");
				if (depth <= maxRandomSpotTries) {
					return placeAtRandomSpot(depth + 1);
				} else {
					trace("Couldn't place baby " + maxRandomSpotTries + " times, now just placing it");
					return true;
				}
			}
			return true;
		}
		
		/**
		* function move moves this baby in it's own speed-direction and makes it go the other way if it hits the wall 
		*/
		public function move() {
			this.x += speedX;
			this.y += speedY;
	
			
			if(this.x <= 0){ // Hit the left wall
				this.x = 0; 
				speedX *= -1; 
		 
			} else if(this.x >= Starling.current.stage.stageWidth - this.width){ // Hit the right wall
				this.x = Starling.current.stage.stageWidth - this.width; 
				speedX *= -1; 
		 
			}
			
			if(this.y <= 0){ // Hit the upper wall
				this.y = 0; 
				speedY *= -1; 
		 
			} else if(this.y >= Starling.current.stage.stageHeight - this.height){ // Hit the bottom wall
				this.y = Starling.current.stage.stageHeight - this.height; 
				speedY *= -1; 
		 
			}
		}
		
		// Is this baby crying
		private var crying: Boolean = false;
		
		// Images for the states of the baby
		private var img_crying: BitmapImage;
		private var img_sleeping: BitmapImage;

		/**
		* function move createCryingImage just initializes the BitmapImage img_crying
		*/
		private function createCryingImage() : void {
			var bitmapData:BitmapData;
			var loader:BitmapLoader = new BitmapLoader();
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onCryLoadComplete);
				loader.load(new URLRequest(Game.APPLICATION_PATH.nativePath + "/assets/action_baby_crying.png"));
				loader.addEventListener(BitmapEvent.GOT_RESULT, onBitmapLoaded);
			
			function onCryLoadComplete(event : Event)
			{
				bitmapData = Bitmap(LoaderInfo(event.target).content).bitmapData;
				loader.onCryLoadComplete(bitmapData);
			}
		}

		/**
		* function move createSleepingImage just initializes the BitmapImage img_sleeping
		*/
		private function createSleepingImage() : void {
			var bitmapData: BitmapData;
			var loader:BitmapLoader = new BitmapLoader();
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onSleepLoadComplete);
				loader.load(new URLRequest(Game.APPLICATION_PATH.nativePath + "/assets/action_baby_sleeping.png"));
				loader.addEventListener(BitmapEvent.GOT_RESULT, onBitmapLoaded);
			
			function onSleepLoadComplete(event : Event)
			{
				bitmapData = Bitmap(LoaderInfo(event.target).content).bitmapData;
				loader.onSleepLoadComplete(bitmapData);
			}
		}
		
		private var newSize: Vector.<Number>;
		public function onBitmapLoaded(e : BitmapEvent) : void {
			if (e.imageName == "sleep") {
				img_sleeping = new BitmapImage(new Bitmap(e.result));
				LoadComplete();
				
				newSize = Img.GetScaledVector(img_sleeping.width, img_sleeping.height);
				img_sleeping.width = newSize[0] * 2;
				img_sleeping.height = newSize[1] * 2;
			}
			
			if (e.imageName == "cry") {
				img_crying = new BitmapImage(new Bitmap(e.result));
				img_crying.width = img_crying.width;
				img_crying.height = img_crying.height;
				
				newSize = Img.GetScaledVector(img_crying.width, img_crying.height);
				img_crying.width = newSize[0] * 4;
				img_crying.height = newSize[1] * 4;
			}
		}
		
		// Time the baby will cry for in ms, once it gets hit
		public static var cryTime: Number = 3000; 
		
		// The timer that handles the wait-time until it sleeps again
		private var backToSleepTimer: PauseTimer;

		/**
		* function clicked is called when the baby has been clicked and will make the baby cry if it isn't already
		*/
		public function clicked() {
			if (crying) {
				// Maybe put the time until it sleeps again to cryTime again here?
				trace('clicked on the crying baby.');
			} else {
				trace('GOING TO CRY');
				crying = true;
				removeChild(img_sleeping);
				addChild(img_crying);
				
				backToSleepTimer = new PauseTimer(cryTime, 1);
				backToSleepTimer.addEventListener(TimerEvent.TIMER_COMPLETE, backToSleep);
					
				backToSleepTimer.start();
				//var backToSleepTimer: IAnimatable = Starling.current.juggler.delayCall(backToSleep, cryTime);
			}

		}

		/**
		* function pause pauses any running timers in this baby
		*/
		public function pause() {
			trace('pausing a baby');
			if (backToSleepTimer)
				backToSleepTimer.pause();
		}
		
		/**
		* function resume resumes any paused timers in this baby
		*/
		public function resume() {
			trace('resuming a baby');
			if (backToSleepTimer)
				backToSleepTimer.resume();
		}

		public function backToSleep(event: TimerEvent) {
			removeChild(img_crying);
			addChild(img_sleeping);
			crying = false;
		}

		/**
		* function OnTouch invoked when this baby is touched, checks if the touch is enough to call the clicked() function
		* 
		* @See	function Clicked()
		*/
		public function OnTouch(event: TouchEvent): void {
			var touch:Touch = event.touches[0];
			if (touch.phase == TouchPhase.BEGAN)
				if (!actionScreen.isPaused())
					clicked();
		}		
		
		/**
		* function LoadComplete called when the images are loaded
		*/
		public function LoadComplete()
		{
			addChild(img_sleeping);
			placeAtRandomSpot();			
			this.addEventListener(TouchEvent.TOUCH, OnTouch);
		}
	}
}

