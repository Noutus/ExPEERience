package src.screens {
	import src.GameScreen;
	import src.screens.Screens;
	import src.display.Img;
	import starling.text.TextField;
	import flash.system.Capabilities;
	import src.Game;
	import src.actionPhase.ActionScreen;
	import src.pressurePhase.PressureScreen;
	import starling.display.MovieClip;
	import starling.core.Starling;
	import starling.textures.Texture;
	import starling.events.Event;
	
	public class TransitionScreen extends GameScreen {
	
		// Between the PressureScreen and the ActionScreen 
		public static const DAY_TO_NIGHT: int = 0
		
		// Between the ScoreScreen and the PressureScreen
		public static const NIGHT_TO_DAY: int = 1;
		
		private var transitionKind: int;

		public function TransitionScreen(transitionKind: int) {
			this.transitionKind = transitionKind;
			
			
		}
		
		var movieClip: MovieClip;
		
		public override function OnEnter(): void {		
			var position : Vector.<Number> = Img.GetScaledVector(0, 0);
			var scale : Vector.<Number> = Img.GetScaledVector(720, 360);
			
			var text : TextField = new TextField(scale[0], scale[1], "Transition: " + ((transitionKind == TransitionScreen.DAY_TO_NIGHT)? "Day to night": "Night to day"));
				text.fontSize = 48 / 720 * Capabilities.screenResolutionX;
				text.x = position[0];
				text.y = position[1];
				addChild(text);
			
			Img.CreateScreenSwitchButtonAt("button_next", (transitionKind == TransitionScreen.DAY_TO_NIGHT)? Screens.ACTION: Screens.PRESSURE , 500, 1100);

			
			
			var textures: Vector.<Texture> = Game.instance().assets.getTextures("MoleWhacked"); //"MoleWhacked": "MoleOK"
			movieClip = new MovieClip(textures, 24);
			//movieClip.addEventListener(TouchEvent.TOUCH, MoleTouched);
			movieClip.x = (transitionKind == TransitionScreen.DAY_TO_NIGHT)? -movieClip.width: Starling.current.stage.stageWidth + movieClip.width;
			movieClip.y = Img.GetScaledVector(0, 900)[1];
			addChild(movieClip);
			Starling.juggler.add(movieClip);
			
			this.addEventListener(Event.ENTER_FRAME, update);


		}
		
		
		private function moveOn() {
			//Img.CreateScreenSwitchButtonAt("button_next", (transitionKind == TransitionScreen.DAY_TO_NIGHT)? Screens.ACTION: Screens.PRESSURE , 500, 1100);
			Game.instance().SwitchScreen((transitionKind == TransitionScreen.DAY_TO_NIGHT)? new ActionScreen(): new PressureScreen());
		}
		
		

		private function update(event: Event) {
			if (transitionKind == TransitionScreen.DAY_TO_NIGHT) {
				if (movieClip.x <= (Starling.current.stage.stageWidth)) {
					movieClip.x += (Starling.current.stage.stageWidth / 48); // 24 fps, 48 = 2 seconds
				} else {
					moveOn();
				}
			} else {
				if (movieClip.x >= -movieClip.width) {
					movieClip.x -= (Starling.current.stage.stageWidth / 48); // 24 fps, 48 = 2 seconds
				} else {
					moveOn();
				}
			}
		}
	}
	
}
