package src.pressurePhase
{
	import src.*;
	import starling.display.Button;
	import starling.textures.Texture;
	import flash.events.Event;
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
	import flash.system.Capabilities;
	import src.display.Img;
	import src.gui.*;

	public class PressureScreen extends GameScreen
	{
		private var activePeer : Peer;
		
		private var buttonCondom : Button;
		private var buttonPeer : Button;
		
		public function PressureScreen()
		{
			setBackground("pressure_background_placeholder");
		}
		
		public override function OnEnter() : void
		{
			super.OnEnter();
			
			CreateRandomPeer();
			
			Img.CreateScreenSwitchButtonAt("button_no", Screens.ACTION, 80, 550);
			Img.CreateScreenSwitchButtonAt("button_condom", Screens.ACTION, 80, 900);
		}
		
		private function CreateRandomPeer() : void
		{
			var _URLLoader : URLLoader = new URLLoader();
			var _peersXML : XML;
			var _s : String = Game.APPLICATION_PATH.nativePath + "/data/peers.xml";
			
			_URLLoader.addEventListener(Event.COMPLETE, loadComplete);
			_URLLoader.addEventListener(IOErrorEvent.IO_ERROR, loadError);
			_URLLoader.load(new URLRequest(_s));
			
			function loadComplete(e : Event) : void
			{
				_peersXML = new XML(_URLLoader.data);
				
				var _randomPeer : int = Math.floor(Math.random() * _peersXML.PEER.length());
				
				// TODO: Put into static function CreateSpriteAt();
				trace("pressure_peer_placeholder_" + _peersXML.PEER[_randomPeer].@NAME);
				
				Img.CreateImageAt("pressure_peer_placeholder_" + _peersXML.PEER[_randomPeer].@NAME, 410, 480);
				Img.CreateImageAt("pressure_cloud_placeholder", 0, 0);
				
				var _randomPressure : int = Math.floor(Math.random() * _peersXML.PEER[_randomPeer].PRESSURE.length());
				var _modifiers : Array = new Array();
				
				for (var i : int = 0; i < _peersXML.PEER[_randomPeer].PRESSURE[_randomPressure].ABILITY.length(); i++)
				{
					_modifiers.push(new ActionModifier(_peersXML.PEER[_randomPeer].PRESSURE[_randomPressure].ABILITY[i].@NAME,
													   _peersXML.PEER[_randomPeer].PRESSURE[_randomPressure].ABILITY[i].text()));
				}
				
				var _ability : PeerAbility = new PeerAbility(_peersXML.PEER[_randomPeer].PRESSURE[_randomPressure].@MESSAGE, _modifiers);
				
				activePeer = new Peer(_ability);
				
				trace(_randomPeer + " : " + _randomPressure + " : " + activePeer.GetAbility().message);
				
				var v : Vector.<Number> = Img.GetScaledVector(620, 400);
				
				var _text : TextField = new TextField(v[0], v[1], activePeer.GetAbility().message);
				_text.fontSize = 48 / 720 * Capabilities.screenResolutionX;
				_text.x = 10;
				Game.instance().currentScreen.addChild(_text);
				
				var o = new PopupWindow("Title", "Imput text here. Talk about random stuff and give information about reproductive health.");
			}
			
			function loadError(e : IOErrorEvent) : void
			{
				trace(e.text);
			}
		}
	}
}
