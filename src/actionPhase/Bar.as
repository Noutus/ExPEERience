package src.actionPhase {
    import flash.geom.Point;
    
    import starling.display.Image;
    import starling.display.Sprite;
    import starling.textures.Texture;
	import flash.system.Capabilities;
	import starling.core.Starling;

	/**
	* class Bar is a horizontal bar that has a ratio of it visible
	*/
    public class Bar extends Sprite {
		
		// The image that's used for this bar, set in the constructor
        private var image:Image;
		// This bar's ratio, getRatio() should be used to access this
        private var ratio:Number;
        
		/**
		* constructor creates the image with the given texture and adds it to the screen with a ratio of 0.0
		*/
        public function Bar(texture: Texture){
            ratio = 0.0;
            image = new Image(texture);
            addChild(image);
			update();
        }
        
		/**
		* function update updates this Bar with the current ratio
		*/
        private function update(): void {
            image.scaleX = ratio / 720 * Starling.current.viewPort.width;
            image.setTexCoords(1, new Point(ratio, 0.0));
            image.setTexCoords(3, new Point(ratio, 1.0));
        }
        
		/**
		* function getRatio 
		* 
		* @return the current ratio of this bar
		*/
        public function getRatio(): Number { 
			return ratio; 
		}
		
		/**
		* function setRatio sets the new ratio and updates the image
		* 
		* @param	value	the new ratio
		*/
        public function setRatio(value: Number): void {
            ratio = Math.max(0.0, Math.min(1.0, value));
            update();
        }
    }
}