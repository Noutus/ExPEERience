package src
{
	import starling.display.Sprite;
	import starling.textures.Texture;
	import starling.display.Image;
	
	public class GameScreen extends Sprite
	{
		
		public function GameScreen()
		{
			
		}
	
		private var backGround: Image;
		public function setBackground(textureName: String) {
			if (getChildIndex(backGround) != -1)
				removeChild(backGround, true);
			
			var backGroundTexture: Texture = Game.instance().assets.getTexture(textureName);
			backGround = new Image(backGroundTexture);
			
			var _newSize : Vector.<Number> = Game.GetScaledVector(backGround.width, backGround.height);
			
			backGround.width = _newSize[0];
			backGround.height = _newSize[1];
			
			addChild(backGround);
		}
		
		public function OnEnter() : void
		{
			
		}
		
		public function OnExit() : void
		{
			this.removeFromParent(true);
		}
	}
}
