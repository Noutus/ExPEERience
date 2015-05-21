package src.screens {
	import src.Game;
	import starling.display.Sprite;
	import src.AssetNames;
	import starling.display.Image;
	import starling.text.TextField;
	import starling.core.Starling;
	import src.GameScreen;
	import src.display.Img;
	
	public class LoadingScreen extends GameScreen {
		
		var progress: TextField;
		
		public function LoadingScreen() {
			
			progress = Img.CreateTextAt(this, "", 0, 0, 720, 1280, 55);
			
			setProgress(0);
			
			//progress = new TextField(600, 200, "");
			//progress.fontSize = 55;
			//progress.x = (Starling.current.stage.stageWidth - progress.width ) / 2;
			//progress.y = (Starling.current.stage.stageHeight - progress.height) / 2;
			//this.addChild(progress);
			
			/*progress = new TextField(200, 200, "0%");
			progress.fontSize = text.fontSize;
			progress.x = text.x ;//+ text.width + 10;
			progress.y = text.y ;//+ text.height + 10;
			
			this.addChild(progress);*/
		}
		
		public function setProgress(ratio: Number): void {
			progress.text = "Loading... " + Math.floor(ratio * 100).toString() + "%";
		}

		public function update(ratio: Number): void {
			if (ratio < 1.0) 
				setProgress(ratio);
			else
				Game.instance().Initialize();
		}

	}
	
}
