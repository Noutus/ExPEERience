package src.screens {
	import src.Game;
	import starling.display.Sprite;
	import src.global.AssetNames;
	import starling.display.Image;
	import starling.text.TextField;
	import starling.core.Starling;
	import src.screens.GameScreen;
	import src.display.Img;
	import starling.textures.Texture;
	import flash.display.BitmapData;
	
	/**
	* class LoadingScreen contains the complete loading-screen
	*/
	public class LoadingScreen extends GameScreen {
		
		// The textfield that contains the current progress
		var progress: TextField;
		
		/**
		* Constructor LoadingScreen builds this loading-screen
		*/
		public function LoadingScreen() {
			// Build the logo
			var texture: Texture = Texture.fromBitmapData(new Logo());
			var logo: Image = new Image(texture);
			
			logo.y = 300;
			Img.ChangeSpriteSize(logo);
			logo.x = (Starling.current.viewPort.width - logo.width) / 2;

			this.addChild(logo); // Add the logo to the screen
			
			// Create the progress text
			progress = Img.CreateTextAt(this, "", 0, 0, 720, 1280, 55);
			
			setProgress(0); // Start without progress
		}
		
		/**
		* function setProgress sets the current progress to the given ratio
		*
		* @param	Number	The progress as ratio
		*/
		public function setProgress(ratio: Number): void {
			progress.text = "Loading... " + Math.floor(ratio * 100).toString() + "%";
		}

		/**
		* function update updates the progress of this LoadingScreen with the given ratio
		*
		* @param	Number	The new progress as ratio 
		*/
		public function update(ratio: Number): void {
			if (ratio < 1.0) 
				setProgress(ratio);
			else
				Game.instance().Initialize();
		}

	}
	
}
