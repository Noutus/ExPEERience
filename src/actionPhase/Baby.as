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
	
	public class Baby extends Sprite {

		private static var minBabySpeed: int = 1;
		private static var maxBabySpeed: int = 6;
		
		private var speedX: int = calcSpeed();
		private var speedY: int = calcSpeed();
		
		private static function calcSpeed(): int {
			var speed: int;
			do {
				speed = -maxBabySpeed + Math.random() * (maxBabySpeed * 2 + 1);
			} while (speed >= -minBabySpeed && speed <= minBabySpeed);
			return speed;
		}
		
		private var babyController: BabyController;
		private var actionScreen: ActionScreen;
		
		public function Baby(babyController: BabyController, actionScreen: ActionScreen) {
			this.babyController = babyController;
			this.actionScreen = actionScreen;
			
			createCryingImage();
			createSleepingImage();
		}
		
		private static const maxRandomSpotTries: int = 30;
		
		/*public function placeAtFirstAvailableSpot(): Boolean {
			for (var x: int = 0; x <= Starling.current.stage.stageWidth - this.width; x++) {
				for (var y: int = 0; y <= Starling.current.stage.stageHeight - this.height; y++) {
					if (spotOK(x, y)) {
						this.x = x;
						this.y = y;
						return true;
					}
				}
			}
			return false;
		}*/
		
		public function spotOK(x: int, y: int): Boolean {

			var babies: Vector.<Baby> = babyController.getBabies();


			for each (var baby: Baby in babies) {
				if (!(baby == this)) {

				//trace("This button: " + x + ", " + y + ", " + this.width + ", " + this.height + ", checking button: " +button.x + ", " + button.y + ", " + button.width + ", " + button.height);
				// if overlap
					if ((x + this.width >= baby.x) && 
						(x <= baby.x + baby.width) && 
						(y + this.height >= baby.y) && 
						(y <= baby.y + baby.height)) {
						
						return false;
					}
				}
			}
			return true;
		}

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
		
		public function move() {
			this.x += speedX;
			this.y += speedY;
		 

			if(this.x <= 0){ 
				this.x = 0; 
				speedX *= -1; 
		 
			} else if(this.x >= Starling.current.stage.stageWidth - this.width){ 
				this.x = Starling.current.stage.stageWidth - this.width; 
				speedX *= -1; 
		 
			}
		 
			
			if(this.y <= 0){ 
				this.y = 0; 
				speedY *= -1; 
		 
			} else if(this.y >= Starling.current.stage.stageHeight - this.height){ 
				this.y = Starling.current.stage.stageHeight - this.height; 
				speedY *= -1; 
		 
			}
			
			/*var babies: Vector.<Baby> = babyController.getBabies();
			
			for each (var baby: Baby in babies) {

				
				
				// if overlap
				if (!(baby == this)) {
					if ((x + this.width >= baby.x) && 
						(x <= baby.x + baby.width) && 
					
						(y + this.height >= baby.y) && 
						(y <= baby.y + baby.height)) {
							
						trace("Hit a baby");
						this.speedX *= -1;
						this.speedY *= -1;
							
						baby.speedX *= -1;
						baby.speedY *= -1;
					}	
				}
			}*/
		}
		
		private var crying: Boolean = false;
		
		private var img_crying: BitmapImage;
		private var img_sleeping: BitmapImage;
		
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
				img_sleeping.width = newSize[0];
				img_sleeping.height = newSize[1];
			}
			
			if (e.imageName == "cry") {
				img_crying = new BitmapImage(new Bitmap(e.result));
				img_crying.width = img_crying.width * 1.5;
				img_crying.height = img_crying.height * 1.5;
				
				newSize = Img.GetScaledVector(img_crying.width, img_crying.height);
				img_crying.width = newSize[0];
				img_crying.height = newSize[1];
			}
		}
		
		// Time the baby will cry for in ms, once it gets hit (don't hit babies you bastard!)
		public static var cryTime: Number = 3000; 
		
		private var backToSleepTimer: PauseTimer;

		public function clicked() {
			trace('clicked');
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

		
		public function pause() {
			trace('pausing a baby');
			if (backToSleepTimer)
				backToSleepTimer.pause();
		}
		
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

		public function OnTouch(event: TouchEvent): void {
			var touch:Touch = event.touches[0];
			if (touch.phase == TouchPhase.BEGAN) {
				if (!actionScreen.isPaused())
					clicked();
			}
		}		
		
		public function LoadComplete()
		{
			addChild(img_sleeping);
			placeAtRandomSpot();			
			this.addEventListener(TouchEvent.TOUCH, OnTouch);
		}
	}
}

