package src.screens {
	import src.GameScreen;
	import src.screens.Screens;
	import src.display.Img;
	import starling.text.TextField;
	import src.Game;
	import src.actionPhase.ActionScreen;
	import src.pressurePhase.PressureScreen;
	import starling.display.MovieClip;
	import starling.core.Starling;
	import starling.textures.Texture;
	import starling.events.Event;
	import starling.display.Image;
	import flash.geom.Point;
	import src.display.AnimatedObject;
	
	public class TransitionScreen extends GameScreen {
	
		// Between the PressureScreen and the ActionScreen 
		public static const DAY_TO_NIGHT: int = 0
		
		// Between the ScoreScreen and the PressureScreen
		public static const NIGHT_TO_DAY: int = 1;
		
		private var transitionKind: int;

		public function TransitionScreen(transitionKind: int) {
			this.transitionKind = transitionKind;
			trace(Starling.current.viewPort.width + ', ' + Starling.current.viewPort.height);
			
		}
		
		var movieClip: AnimatedObject;
		var movieStart, movieEnd: Point;
		
		var sun, moon: Image; // sun/moon
		
		var sunStart, sunEnd: Point;
		var moonStart, moonEnd: Point;
		
		public override function OnEnter(): void {		
			
			this.setBackground("background_transition");			
			
			if (transitionKind == TransitionScreen.NIGHT_TO_DAY) {
				pressureScreen = new PressureScreen();
				
			}
			
			Img.CreateTextAt(this, "Going to: " + getNextLocation().replace('_', ' '), 0, 0, 720, 360, 48);
			
			//Img.CreateScreenSwitchButtonAt("button_next", (transitionKind == TransitionScreen.DAY_TO_NIGHT)? Screens.ACTION: Screens.PRESSURE , 500, 1100);
			
			
			sun = new Image(Game.instance().assets.getTexture("sun"));
			moon = new Image(Game.instance().assets.getTexture("moon"));
			
			Img.ChangeSpriteSize(sun);
			Img.ChangeSpriteSize(moon);
			
			
			
			if (transitionKind == TransitionScreen.DAY_TO_NIGHT) {
	
				sunStart = new Point((Starling.current.viewPort.width - sun.width) / 2, Img.GetScaledVector(0, 300)[1]);
				sunEnd = new Point(Starling.current.viewPort.width + sun.width, Img.GetScaledVector(0, 500)[1]);
				
				moonStart = new Point(-moon.width, Img.GetScaledVector(0, 500)[1]);
				moonEnd = new Point((Starling.current.viewPort.width - sun.width) / 2, Img.GetScaledVector(0, 300)[1]);
			} else {
				moonStart = new Point((Starling.current.viewPort.width - sun.width) / 2, Img.GetScaledVector(0, 300)[1]);
				moonEnd = new Point(Starling.current.viewPort.width + sun.width, Img.GetScaledVector(0, 500)[1]);
				
				sunStart = new Point(-moon.width, Img.GetScaledVector(0, 500)[1]);
				sunEnd = new Point((Starling.current.viewPort.width - sun.width) / 2, Img.GetScaledVector(0, 300)[1]);
			}
			//"Sun" "Moon"
		
			trace('Sun initialized');
			sun.x = sunStart.x;
			sun.y = sunStart.y;
			addChild(sun);
		
			moon.x = moonStart.x;
			moon.y = moonStart.y;
			addChild(moon);
			
			movieClip = new AnimatedObject("walk", 17);
			
			movieStart = new Point(
				(transitionKind == TransitionScreen.DAY_TO_NIGHT)? -movieClip.width: Starling.current.viewPort.width + movieClip.width, 
				Img.GetScaledVector(0, 800)[1]
			);
			
			movieClip.x = movieStart.x;
			movieClip.y = movieStart.y;

			if (transitionKind == TransitionScreen.NIGHT_TO_DAY)
				movieClip.scaleX = -1;
			
			movieEnd = new Point(
				(transitionKind == TransitionScreen.DAY_TO_NIGHT)? (Starling.current.viewPort.width): -movieClip.width,
				movieStart.y
			);
			
			addChild(movieClip);
			//Starling.juggler.add(movieClip);
			
			this.addEventListener(Event.ENTER_FRAME, update);


		}
		
		private function getNextLocation(): String {
			if (transitionKind == TransitionScreen.NIGHT_TO_DAY) {
				return pressureScreen.getLocation();
			} else {
				return ActionScreen.getLocation();
			}
		}
		
		var pressureScreen: PressureScreen;
		private function moveOn() {
			//Img.CreateScreenSwitchButtonAt("button_next", (transitionKind == TransitionScreen.DAY_TO_NIGHT)? Screens.ACTION: Screens.PRESSURE , 500, 1100);
			Game.instance().SwitchScreen((transitionKind == TransitionScreen.DAY_TO_NIGHT)? new ActionScreen(): pressureScreen);
		}
	
		var frames: int = 48
		private function update(event: Event) {			
			//if (transitionKind == TransitionScreen.DAY_TO_NIGHT) {
				
			if ((transitionKind == TransitionScreen.DAY_TO_NIGHT)? movieClip.x <= movieEnd.x: movieClip.x >= movieEnd.x) {
				
				movieClip.x += (movieEnd.x - movieStart.x) / frames; // 24 fps, 48 = 2 seconds
				
				sun.x += (sunEnd.x - sunStart.x) / frames;
				sun.y += (sunEnd.y - sunStart.y) / frames;
				
				moon.x += (moonEnd.x - moonStart.x) / frames;
				moon.y += (moonEnd.y - moonStart.y) / frames;
			} else {
				this.removeEventListener(Event.ENTER_FRAME, update);
				
				Starling.juggler.delayCall(function() {
					moveOn();
				}, 1);
				//moveOn();
			}

		}
	}
	
}
