package src {
    import flash.geom.Point;
    
    import starling.display.Image;
    import starling.display.Sprite;
    import starling.textures.Texture;
    
    public class Bar extends Sprite {
		
        private var image:Image;
        private var ratio:Number;
        
        public function Bar(texture: Texture){
            ratio = 0.0;
            image = new Image(texture);
            addChild(image);
			update();
        }
        
        private function update(): void {
            image.scaleX = ratio;
            image.setTexCoords(1, new Point(ratio, 0.0));
            image.setTexCoords(3, new Point(ratio, 1.0));
        }
        
        public function getRatio(): Number { 
			return ratio; 
		}
		
        public function setRatio(value: Number): void {
            ratio = Math.max(0.0, Math.min(1.0, value));
            update();
        }
    }
}