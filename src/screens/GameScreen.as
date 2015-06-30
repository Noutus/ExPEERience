package src.screens
{
	import starling.display.Sprite;
	import starling.textures.Texture;
	import starling.display.Image;
	import src.display.Img;
	import src.Game;
	
	/**
	* class GameScreen should be extended by all screens in the game
	*/
	public class GameScreen extends Sprite
	{
		/**
		* constructor GameScreen
		*/
		public function GameScreen()
		{
			
		}
	
		// The background of this GameScreen
		protected var backGround: Image;
		
		/**
		* function setBackground sets the background to the asset with the given textureName
		*
		* @param	String	The name of the texture that'll be used as background
		*/
		public function setBackground(textureName: String) {
			// If there's already a background set, remove it first
			if (getChildIndex(backGround) != -1)
				removeChild(backGround, true);
			
			// Make the new background
			var backGroundTexture: Texture = Game.instance().assets.getTexture(textureName);
			backGround = new Image(backGroundTexture);
			
			// Edit the size
			var _newSize : Vector.<Number> = Img.GetScaledVector(backGround.width, backGround.height);
			backGround.width = _newSize[0];
			backGround.height = _newSize[1];
			
			// Add the background behind all other childs
			addChildAt(backGround, 0);
		}
		
		// Called upon entering this screen
		public function OnEnter() : void
		{
			
		}
		
		// Called upon exiting this screen
		public function OnExit() : void
		{
			this.removeFromParent(true);
			this.dispose();
		}
	}
}
