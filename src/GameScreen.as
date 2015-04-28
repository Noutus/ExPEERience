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
