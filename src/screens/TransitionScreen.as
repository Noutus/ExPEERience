package src.screens {
	import src.screens.GameScreen;
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
	
	/**
	* class TransitionScreen shows the transition from day to night or night to day
	*/
	public class TransitionScreen extends GameScreen {
	
		// Between the PressureScreen and the ActionScreen 
		public static const DAY_TO_NIGHT: int = 0
		
		// Between the ScoreScreen and the PressureScreen
		public static const NIGHT_TO_DAY: int = 1;
		
		// The kind of transition this is (DAY_TO_NIGHT or NIGHT_TO_DAY)
		private var transitionKind: int;

		/**
		* Constructor TransitionScreen
		*
		* @param	int	The kind of TransitionScreen to create
		*/
		public function TransitionScreen(transitionKind: int) {
			this.transitionKind = transitionKind;
		}
		
		// The animation to show moving on the screen (the person walking)
		var movieClip: AnimatedObject;
		// Start and end-positions of the animation
		var movieStart, movieEnd: Point;
		
		// Images of the sun and moon
		var sun, moon: Image; 
		
		// Start and end-positions of the sun
		var sunStart, sunEnd: Point;
		// Start and end-positions of the moon
		var moonStart, moonEnd: Point;
		
		/**
		* function OnEnter called upon entering this TransitionScreen
		*/
		public override function OnEnter(): void {		
			
			this.setBackground("background_transition");			
			
			if (transitionKind == TransitionScreen.NIGHT_TO_DAY) 
				pressureScreen = new PressureScreen();
			
			// Show the location this TransitionScreen moves to
			Img.CreateTextAt(this, "Going to: " + getNextLocation().replace('Female_', '').replace('Male_', ''), 0, 0, 720, 360, 48);
			
			sun = new Image(Game.instance().assets.getTexture("sun"));
			moon = new Image(Game.instance().assets.getTexture("moon"));
			
			Img.ChangeSpriteSize(sun);
			Img.ChangeSpriteSize(moon);
			
			// Calculate the starting and ending points of the sun and the moon
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
		
			sun.x = sunStart.x;
			sun.y = sunStart.y;
			addChild(sun);
		
			moon.x = moonStart.x;
			moon.y = moonStart.y;
			addChild(moon);
			
			movieClip = new AnimatedObject("walk", 17);
			
			// Calculate the starting point of the animation
			movieStart = new Point(
				(transitionKind == TransitionScreen.DAY_TO_NIGHT)? -movieClip.width: Starling.current.viewPort.width + movieClip.width, 
				Img.GetScaledVector(0, 800)[1]
			);
			
			movieClip.x = movieStart.x;
			movieClip.y = movieStart.y;

			
			if (transitionKind == TransitionScreen.NIGHT_TO_DAY) // Then the animation comes from the right to the left and should be mirrored
				movieClip.scaleX = -1;
			
			// Calculate the ending point of the animation
			movieEnd = new Point(
				(transitionKind == TransitionScreen.DAY_TO_NIGHT)? (Starling.current.viewPort.width): -movieClip.width,
				movieStart.y
			);
			
			addChild(movieClip);
			
			this.addEventListener(Event.ENTER_FRAME, update);
		}
		
		/**
		* function getNextLocation
		*
		* @return	String	The location this TransitionScreen is moving to
		*/
		private function getNextLocation(): String {
			if (transitionKind == TransitionScreen.NIGHT_TO_DAY) {
				return pressureScreen.getLocation();
			} else {
				return ActionScreen.getLocation();
			}
		}
		
		// PressureScreen that has been made already to find out what the position will be, if 
		var pressureScreen: PressureScreen;
		
		/**
		* function moveOn continues the game to the next screen
		*/
		private function moveOn() {
			Game.instance().SwitchScreen((transitionKind == TransitionScreen.DAY_TO_NIGHT)? new ActionScreen(): pressureScreen);
		}
	
		// Amount of frames this TransitionScreen is going to exist for, the game runs at 24 fps so 48 frames = two seconds
		var frames: int = 48
		// Time to wait until continuing to the next screen after the animations are done
		var timeToWait: int = 1.0;
		
		/**
		* function update is called on every frame and moves everything in the screen that should be moved
		*/
		private function update(event: Event) {			
			//if (transitionKind == TransitionScreen.DAY_TO_NIGHT) {
				
			if ((transitionKind == TransitionScreen.DAY_TO_NIGHT)? movieClip.x <= movieEnd.x: movieClip.x >= movieEnd.x) {
				
				movieClip.x += (movieEnd.x - movieStart.x) / frames; 
				
				sun.x += (sunEnd.x - sunStart.x) / frames;
				sun.y += (sunEnd.y - sunStart.y) / frames;
				
				moon.x += (moonEnd.x - moonStart.x) / frames;
				moon.y += (moonEnd.y - moonStart.y) / frames;
			} else {
				this.removeEventListener(Event.ENTER_FRAME, update);
				
				Starling.juggler.delayCall(function() {
					moveOn();
				}, timeToWait);
			}

		}
	}
	
}
