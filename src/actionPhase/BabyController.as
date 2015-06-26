package src.actionPhase {
	import src.actionPhase.ActionScreen;
	import src.actionPhase.Baby;
	import src.global.GlobalValues;
	
	public class BabyController {
				
		
		private var babies: Vector.<Baby> = new Vector.<Baby>;		


		private var actionScreen: ActionScreen;
		public function BabyController(actionScreen: ActionScreen) {
			this.actionScreen = actionScreen;
			
			trace('starting with adding babies');
			for (var i: int = 0; i < GlobalValues.instance().babies; i++) {
				newBaby();
				trace('Added a baby');
			}
			trace('done adding babies');

		}
		
		public function newBaby(): void {
			
			var baby: Baby = new Baby(this, actionScreen);
			if (baby.placeAtRandomSpot()) { 
				babies.push(baby);

				actionScreen.topLayer.addChild(baby);
			} else
				baby.dispose();
		}

		public function getBabies(): Vector.<Baby> {
			return this.babies;
		}

		public function moveBabies(): void {
			for each(var baby: Baby in babies) {
				baby.move();
			}
		}
		
		public function pause(): void {
			for each(var baby: Baby in babies) {
				baby.pause();
			}
		}
		
		public function resume(): void {
			for each(var baby: Baby in babies) {
				baby.resume();
			}
		}
	}
	
}
