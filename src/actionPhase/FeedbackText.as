package src.actionPhase {
	
	import starling.text.TextField;
	import starling.utils.Color;
	import starling.events.Event;
	import src.display.Img;
	
	public class FeedbackText extends TextField {
		
		private var direction : Vector.<Number>;
		private static const speed : Number = 10;
		private var distance : Number = 0;
		
		public function FeedbackText(score : Number, xPos : Number, yPos : Number, risk : Boolean = false) {
			
			trace("Feedback created!");
			
			var color = Color.GREEN;			
			var text = Math.round(score * 100).toString();
			
			if (risk) {
				color = Color.RED;
				text = "-" + text;
			}
			
			else text = "+" + text;
			
			super(180, 180, text, "RoofRunners", 64, color);
			
			direction = new Vector.<Number>(2);
			direction[0] = Math.random() - 0.5;
			direction[1] = Math.random() - 0.5;
			
			this.x = xPos;
			this.y = yPos;
			
			this.touchable = false;
			
			this.addEventListener(Event.ENTER_FRAME, update);
			
			Img.ChangeSpriteSize(this);
		}
		
		public function update(e : Event) : void {
			x += direction[0] * speed;
			y += direction[1] * speed;
			distance += 1;
			if (distance > 20) {
				this.removeEventListener(Event.ENTER_FRAME, update);
				this.removeFromParent(true);
			}
		}
	}
}