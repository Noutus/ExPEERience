package src.pressurePhase
{
	import src.*;
	import starling.display.Button;
	import starling.textures.Texture;
	import flash.net.*;
	import flash.html.script.Package;
	import flash.events.IOErrorEvent;
	import flash.filesystem.File;
	import src.buttons.*;
	import src.screens.Screens;
	import starling.display.Sprite;
	import starling.display.Image;
	import starling.display.DisplayObject;
	import starling.text.TextField;
	import src.display.Img;
	import src.gui.*;
	import src.actionPhase.ActionValues;
	import starling.events.TouchEvent;
	import starling.events.Touch;
	import starling.events.TouchPhase;
	import src.actionPhase.ActionScreen;
	import src.screens.TransitionScreen;
	import starling.core.Starling;
	import starling.events.Event;
	import starling.events.EnterFrameEvent;

	public class PressureScreen extends GameScreen
	{
		private var activePeer : Peer;
		
		private var buttonCondom : DisplayObject;
		private var buttonPeer : DisplayObject;

		private var _badmodifiers : Array;		
		
		public function PressureScreen()
		{
			_badmodifiers = new Array();
			_randomPeer = Math.floor(Math.random() * _peersXML.PEER.length());

			peerName = _peersXML.PEER[_randomPeer].@NAME;
			trace('PressureScreen constructor done');
		}
		
		public override function OnEnter() : void
		{
			super.OnEnter();
			
			trace("Entering Pressure Screen: ");
			trace("Risk sex: " + ActionValues.instance().GetModifier(ActionValues.RISK_SEX));
			trace("Buttons per second: " + ActionValues.instance().GetModifier(ActionValues.BUTTONS_PER_SECOND));
			
			makeScreen();
			
			buttonPeer = Img.GetNewImageAt("button_no", 80, 550);
			buttonPeer.addEventListener(TouchEvent.TOUCH, OnNo);
			buttonCondom = Img.GetNewImageAt("button_condom", 80, 900);
			buttonCondom.addEventListener(TouchEvent.TOUCH, OnCondom);
			
		}
		
		public static var lelflash;
		
		private static var _s : String = Game.APPLICATION_PATH.nativePath + "/data/peers.xml";

		private static var _URLLoader : URLLoader = buildURLLoader();
		
		private static var _peersXML : XML;
	
		public static function buildURLLoader(): URLLoader {
			var loader: URLLoader = new URLLoader();
			
			loader.addEventListener(flash.events.Event.COMPLETE, function (e : flash.events.Event) : void{ 
				_peersXML = new XML(loader.data);
			});
			
			loader.addEventListener(IOErrorEvent.IO_ERROR, loadError);
			loader.load(new URLRequest(_s));

			return loader;
		}

		private var peerName: String;
				
		var _randomPeer : int;
		
		function makeScreen(): void {
			// TODO: Put into static function CreateSpriteAt();
			trace("pressure_peer_placeholder_" + _peersXML.PEER[_randomPeer].@NAME);
			
			this.setBackground("pressure_background_" + _peersXML.PEER[_randomPeer].@NAME);
			Img.CreateImageAt("pressure_peer_placeholder_" + _peersXML.PEER[_randomPeer].@NAME, 410, 480);
			Img.CreateImageAt("pressure_cloud_placeholder", 0, 0);
			
			var _randomPressure : int = Math.floor(Math.random() * _peersXML.PEER[_randomPeer].PRESSURE.length());
			var _modifiers : Array = new Array();
			
			for (var i : int = 0; i < _peersXML.PEER[_randomPeer].PRESSURE[_randomPressure].ABILITY.length(); i++)
			{
				_modifiers.push(new ActionModifier(_peersXML.PEER[_randomPeer].PRESSURE[_randomPressure].ABILITY[i].@NAME,
												   _peersXML.PEER[_randomPeer].PRESSURE[_randomPressure].ABILITY[i].text()));
			}
			
			for (var j : int = 0; j < _peersXML.PEER[_randomPeer].PRESSURE[_randomPressure].BAD.length(); j++)
			{
				_badmodifiers.push(new ActionModifier(_peersXML.PEER[_randomPeer].PRESSURE[_randomPressure].BAD[j].@NAME,
													  _peersXML.PEER[_randomPeer].PRESSURE[_randomPressure].BAD[j].text()));
			}
			
			var _ability : PeerAbility = new PeerAbility(_peersXML.PEER[_randomPeer].PRESSURE[_randomPressure].@MESSAGE, _modifiers);
			
			activePeer = new Peer(_ability);
			
			trace(_randomPeer + " : " + _randomPressure + " : " + activePeer.GetAbility().message);
			
			Img.CreateTextAt(this, activePeer.GetAbility().message, 32, 23, 655, 264, 48);/*
			var v : Vector.<Number> = Img.GetScaledVector(620, 400);
			var _text : TextField = new TextField(v[0], v[1], activePeer.GetAbility().message);
			_text.x = 50 / 720 * Starling.current.viewPort.width;
			_text.fontName = "RoofRunners";
			_text.fontSize = 48 / 720 * Starling.current.viewPort.width;
			addChild(_text);*/  
		}
		
		private static function loadError(e : IOErrorEvent) : void
		{
			trace(e.text);
		}
		
		public function getLocation(): String {
			return peerName; // "PressureScreen.getLocation() (yet to be implemented)";
		}
		
		public function OnNo(e : TouchEvent) : void
		{
			var _touch : Touch = e.getTouch(this, TouchPhase.ENDED);
			if (_touch)
			{
				activePeer.GetAbility().modifiers = _badmodifiers;
				activePeer.GetAbility().ChooseAbility();
				AddLevelModifiers();
				Game.instance().SwitchScreen(new TransitionScreen(TransitionScreen.DAY_TO_NIGHT));
			}
		}
		
		public function OnCondom(e : TouchEvent) : void
		{
			var _touch : Touch = e.getTouch(this, TouchPhase.ENDED);
			if (_touch)
			{
				activePeer.GetAbility().ChooseAbility();
				ActionValues.instance().SetModifier(ActionValues.RISK_SEX, 0.0);
				AddLevelModifiers();
				Game.instance().SwitchScreen(new TransitionScreen(TransitionScreen.DAY_TO_NIGHT));
			}
		}
		
		public function AddLevelModifiers()
		{
			var _URLLoader : URLLoader = new URLLoader();
			var levelXML : XML;
			var _s : String = Game.APPLICATION_PATH.nativePath + "/data/levels.xml";
			
			_URLLoader.addEventListener(flash.events.Event.COMPLETE, loadComplete);
			_URLLoader.addEventListener(IOErrorEvent.IO_ERROR, loadError);
			_URLLoader.load(new URLRequest(_s));
			
			function loadComplete(e : flash.events.Event) : void
			{
				levelXML = new XML(_URLLoader.data);
				
				for(var i : int = 0; i < levelXML.LEVEL[GlobalValues.instance().level].ABILITY.length(); i++)
				{
					ActionValues.instance().AddModifier(levelXML.LEVEL[GlobalValues.instance().level].ABILITY[i].@NAME,
														levelXML.LEVEL[GlobalValues.instance().level].ABILITY[i].text());
					trace("Level " + GlobalValues.instance().level + " : modifier " + levelXML.LEVEL[GlobalValues.instance().level].ABILITY[i].@NAME);
				}
			}
			
			function loadError(e : IOErrorEvent) : void
			{
				trace(e.text);
			}
		}
	}
}
