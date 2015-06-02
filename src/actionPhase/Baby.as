package src.actionPhase {
	import src.actionPhase.ActionValues;
	import src.AssetNames;
	import starling.display.Sprite;
	import src.Game;
	import starling.display.Image;
	import src.GlobalValues;
	import starling.core.Starling;
	import flash.geom.Rectangle;
	
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
		
		public function Baby(babyController: BabyController) {
			this.babyController = babyController;
			
			addChild(new Image(Game.instance().assets.getTexture(AssetNames.ACTION_BABY)));
			placeAtRandomSpot();
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
		

	}
	
}
