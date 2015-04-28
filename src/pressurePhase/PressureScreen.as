﻿package src.pressurePhase
{
	import src.*;
	import starling.display.Button;
	import flash.events.Event;
	import flash.net.*;
	import flash.html.script.Package;
	import flash.events.IOErrorEvent;
	import flash.filesystem.File;

	public class PressureScreen extends GameScreen
	{
		private var activePeer : Peer;
		
		private var buttonCondom : Button;
		private var buttonPeer : Button;
		
		public function PressureScreen()
		{
			
		}
		
		public override function OnEnter() : void
		{
			super.OnEnter();
			
			CreateRandomPeer();
		}
		
		private function CreateRandomPeer() : void
		{
			var _URLLoader : URLLoader = new URLLoader();
			var _peersXML : XML;
			var _s : String = Game.APPLICATION_PATH.nativePath + "\\data\\peers.xml";
			
			_URLLoader.addEventListener(Event.COMPLETE, loadComplete);
			_URLLoader.addEventListener(IOErrorEvent.IO_ERROR, loadError);
			_URLLoader.load(new URLRequest(_s));
			
			function loadComplete(e : Event) : void
			{
				_peersXML = new XML(_URLLoader.data);
				
				var _randomPeer : int = Math.floor(Math.random() * _peersXML.PEER[_randomPeer].length());
				var _randomPressure : int = Math.floor(Math.random() * _peersXML.PEER[_randomPeer].PRESSURE.length());
				var _modifiers : Array = new Array();
				
				for (var i : int = 0; i < _peersXML.PEER[_randomPeer].PRESSURE[_randomPressure].ABILITY.length(); i++)
				{
					_modifiers.push(new ActionModifier(_peersXML.PEER[_randomPeer].PRESSURE[_randomPressure].ABILITY[i].@NAME,
													   _peersXML.PEER[_randomPeer].PRESSURE[_randomPressure].ABILITY[i].text()));
				}
				
				var _ability : PeerAbility = new PeerAbility(_peersXML.PEER[_randomPeer].PRESSURE[_randomPressure].@MESSAGE, _modifiers);
				
				activePeer = new Peer(_ability);
				
				trace(activePeer.GetAbility().message);
			}
			
			function loadError(e : IOErrorEvent) : void
			{
				trace(e.text);
			}
		}
	}
}
