package src.pressurePhase {
	
	import flash.net.*;
	import flash.html.script.Package;
	import flash.events.IOErrorEvent;
	import flash.filesystem.File;
	import flash.text.TextFormat;
	
	import src.*;
	import src.actionPhase.ActionScreen;
	import src.actionPhase.ActionValues;
	import src.display.Img;
	import src.global.GlobalValues;
	import src.screens.*;

	import starling.display.Button;
	import starling.textures.Texture;
	import starling.display.Sprite;
	import starling.display.Image;
	import starling.display.DisplayObject;
	import starling.text.TextField;
	import starling.events.TouchEvent;
	import starling.events.Touch;
	import starling.events.TouchPhase;
	import starling.core.Starling;
	import starling.events.Event;
	import starling.events.EnterFrameEvent;
	
	/**
	 * The pressure screen in which the player gets peer pressure from a character and has to choose whether to use a condom or not.
	 */
	public class PressureScreen extends GameScreen {
		
		/** Current character talking to the player. */
		private var activePeer: Peer;

		/** Condom button. */
		private var buttonCondom: DisplayObject;
		
		/** No Condom button. */
		private var buttonPeer: DisplayObject;

		/** modifiers for choosing no condom. */
		private var _badmodifiers: Array;

		/**
		 * Creates an instance of PressureScreen.
		 */
		public function PressureScreen() {
			_badmodifiers = new Array();
			
			// Random peer is generated.
			_randomPeer = Math.floor(Math.random() * _peersXML.PEER.length());
			peerName = _peersXML.PEER[_randomPeer].@NAME;
		}

		/**
		 * Overrides the function from Screen. Is called when the screen has been successfully entered.
		 */
		public override function OnEnter(): void {
			super.OnEnter();
			makeScreen();
		}

		/** Lel Flash! */
		public static var lelflash;

		/** Contains a string pointing to the XML file for the peers. */
		private static var _s: String = Game.APPLICATION_PATH.nativePath + "/data/peers.xml";

		/** URLLoader needed to load in the XML data. */
		private static var _URLLoader: URLLoader = buildURLLoader();

		/** XML file that can be used in the code when loaded in. */
		private static var _peersXML: XML;

		/**
		 * Create an URLLoader to load the XML data.
		 *
		 * @return Returns the URLLoader object.
		 */
		public static function buildURLLoader(): URLLoader {
			var loader: URLLoader = new URLLoader();

			loader.addEventListener(flash.events.Event.COMPLETE, function (e: flash.events.Event): void {
				_peersXML = new XML(loader.data);
			});

			loader.addEventListener(IOErrorEvent.IO_ERROR, loadError);
			loader.load(new URLRequest(_s));

			return loader;
		}

		/** Name of the active peer. */
		private var peerName: String;

		/** Index of the active peer. */
		var _randomPeer: int;

	    /**
		 * Builds the screen and displays it on the stage.
		 */
		function makeScreen(): void {
			
			// If the peer is your partner, change the name accordingly to the selected gender.
			if (peerName == "Partner") {
				if (GlobalValues.instance().gender) peerName = "Male";
				else peerName = "Female";
			}

			// Create the background, character and speech cloud.
			this.setBackground("pressure_background_" + _peersXML.PEER[_randomPeer].@NAME);
			Img.CreateImageAt("pressure_peer_placeholder_" + peerName, 410, 480);
			Img.CreateImageAt("pressure_cloud_placeholder", 0, 0);

			// Get a random pressure message from the active peer.
			var _randomPressure: int = Math.floor(Math.random() * _peersXML.PEER[_randomPeer].PRESSURE.length());
			
			// Fill good and bad modifiers.
			var _modifiers: Array = new Array();
			for (var i: int = 0; i < _peersXML.PEER[_randomPeer].PRESSURE[_randomPressure].ABILITY.length(); i++) {
				_modifiers.push(new ActionModifier(_peersXML.PEER[_randomPeer].PRESSURE[_randomPressure].ABILITY[i].@NAME,
					_peersXML.PEER[_randomPeer].PRESSURE[_randomPressure].ABILITY[i].text()));
			}
			
			for (var j: int = 0; j < _peersXML.PEER[_randomPeer].PRESSURE[_randomPressure].BAD.length(); j++) {
				_badmodifiers.push(new ActionModifier(_peersXML.PEER[_randomPeer].PRESSURE[_randomPressure].BAD[j].@NAME,
					_peersXML.PEER[_randomPeer].PRESSURE[_randomPressure].BAD[j].text()));
			}

			// Add modifiers to the peer's ability.
			var _ability: PeerAbility = new PeerAbility(_peersXML.PEER[_randomPeer].PRESSURE[_randomPressure].@MESSAGE, _modifiers);

			//Set the active peer.
			activePeer = new Peer(_ability);

			// Display the active message on the screen.
			Img.CreateTextAt(this, activePeer.GetAbility().message, 32, 23, 655, 264, 48);

			// Create condom and no condom buttons.
			buttonPeer = Img.GetNewImageAt("button_no", 30, 550);
			buttonPeer.addEventListener(TouchEvent.TOUCH, OnNo);
			buttonCondom = Img.GetNewImageAt("button_condom", 30, 900);
			buttonCondom.addEventListener(TouchEvent.TOUCH, OnCondom);

			// Display the abilities on the screen.
			var myPattern: RegExp = /_/g;
			for (i = 0; i < _modifiers.length; i++) {
				var n: Number = _peersXML.PEER[_randomPeer].PRESSURE[_randomPressure].ABILITY[i].text();
				var s: String = _modifiers[i].modifierName;
				var tf: TextField = Img.CreateTextAt(this, s.replace(myPattern, " ") + " " + GetModStatus(n), 0, 1137 + 30 * i, 360, 29, 24);
				if (n > 1) tf.color = 0x00AA00;
				else tf.color = 0xAA0000;
			}
			
			for (j = 0; j < _badmodifiers.length; j++) {
				n = _peersXML.PEER[_randomPeer].PRESSURE[_randomPressure].BAD[j].text();
				s = _badmodifiers[j].modifierName;
				var tf2: TextField = Img.CreateTextAt(this, s.replace(myPattern, " ") + " " + GetModStatus(n), 0, 770 + 30 * j, 360, 29, 24);
				if (n > 1) tf2.color = 0x00AA00;
				else tf2.color = 0xAA0000;
			}
		}

		/**
		 * Function that is called when the URLLoader encounters an error when loading in data.
		 *
		 * @param e IOErrorEvent.
		 */
		private static function loadError(e: IOErrorEvent): void {
			trace(e.text);
		}

		/**
		 * Get the location of the active peer.
		 *
		 * @return Returns the name of the location as a String.
		 */
		public function getLocation(): String {
			return peerName; // "PressureScreen.getLocation() (yet to be implemented)";
		}

		/**
		 * The function that is called when the player selects the No Condom option.
		 * 
		 * @param e TouchEvent.
		 */
		public function OnNo(e: TouchEvent): void {
			var _touch: Touch = e.getTouch(this, TouchPhase.ENDED);
			if (_touch) {
				activePeer.GetAbility().modifiers = _badmodifiers;
				activePeer.GetAbility().ChooseAbility();
				AddLevelModifiers();
				Game.instance().SwitchScreen(new TransitionScreen(TransitionScreen.DAY_TO_NIGHT));
			}
		}

		/**
		 * The function that is called when the player selects the Condom option.
		 * 
		 * @param e TouchEvent.
		 */
		public function OnCondom(e: TouchEvent): void {
			var _touch: Touch = e.getTouch(this, TouchPhase.ENDED);
			if (_touch) {
				activePeer.GetAbility().ChooseAbility();
				ActionValues.instance().AddModifier(ActionValues.RISK_SEX, 0);
				AddLevelModifiers();
				Game.instance().SwitchScreen(new TransitionScreen(TransitionScreen.DAY_TO_NIGHT));
			}
		}

		/**
		 * Adds the modifiers so that they are applied in the action phase.
		 */
		public function AddLevelModifiers() {
			
			// Load the XML data.
			var _URLLoader: URLLoader = new URLLoader();
			var levelXML: XML;
			var _s: String = Game.APPLICATION_PATH.nativePath + "/data/levels.xml";
			_URLLoader.addEventListener(flash.events.Event.COMPLETE, loadComplete);
			_URLLoader.addEventListener(IOErrorEvent.IO_ERROR, loadError);
			_URLLoader.load(new URLRequest(_s));

			// When the data is successfully loaded, run the loadComplete function.
			function loadComplete(e: flash.events.Event): void {
				levelXML = new XML(_URLLoader.data);

				// Add the modifies.
				for (var i: int = 0; i < levelXML.LEVEL[GlobalValues.instance().level].ABILITY.length(); i++) {
					ActionValues.instance().AddModifier(levelXML.LEVEL[GlobalValues.instance().level].ABILITY[i].@NAME,
						levelXML.LEVEL[GlobalValues.instance().level].ABILITY[i].text());
				}
			}

			// When the data loading is a failure, display the loading error.
			function loadError(e: IOErrorEvent): void {
				trace(e.text);
			}
		}

		/**
		 * Check if a modifier makes the gameplay easier or harder.
		 *
		 * @param n Value of the modifier.
		 *
		 * @return Returns a string showing if the value is positive or negative.
		 */
		public static function GetModStatus(n: Number): String {
			if (n > 1) return "++";
			if (n < 1) return "--";
			return "";
		}
	}
}