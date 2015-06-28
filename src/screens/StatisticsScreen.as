﻿package src.screens {

	import src.global.GlobalValues;
	import src.display.Img;
	import starling.display.DisplayObject;
	import starling.display.Quad;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.text.TextField;
	import starling.events.TouchEvent;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchPhase;

	public class StatisticsScreen extends GameScreen {
		
		public static var BADGE_LEVEL_2 : int = 0;
		public static var BADGE_LEVEL_3 : int = 1;
		public static var BADGE_LEVEL_4 : int = 2;
		public static var BADGE_LEVEL_5 : int = 3;
		public static var BADGE_LEVEL_6 : int = 4;
		public static var BADGE_LEVEL_7 : int = 5;
		public static var BADGE_LEVEL_8 : int = 6;
		public static var BADGE_LEVEL_9 : int = 7;
		public static var BADGE_FINISHED : int = 8;
		
		private var titleText: TextField;
		private var descriptionText : TextField;
		private var requirementText : TextField;

		private static var badges : Array = new Array(
			new Array("badge1", "First Kiss", "", "Reach level 2"),
			new Array("badge2", "", "", "Reach level 3"),
			new Array("badge3", "", "", "Reach level 4"),
			new Array("badge4", "", "", "Reach level 5"),
			new Array("badge5", "", "", "Reach level 6"),
			new Array("badge6", "", "", "Reach level 7"),
			new Array("badge7", "", "", "Reach level 8"),
			new Array("badge8", "", "", "Reach level 9"),
			new Array("badge9", "", "", "Finish the game"));
		private var badgeObjects : Array = new Array();
		
		public function StatisticsScreen() {

			this.setBackground("main_background_orange");
		}

		public override function OnEnter(): void {

			Img.CreateTextAt(this, "HI-SCORE: " + GlobalValues.instance().highScore, 0, 0, 720, 100, 64);

			Img.CreateScreenSwitchButtonAt("button_back", Screens.MAINMENU, 0, 1100);

			createTextArea();
			
			changeText(0);
			
			for (var i : int = 0; i < badges.length; i++) {
				badgeObjects[i] = Img.GetNewImageAt(badges[i][0], 85 + ((200 * i) % 600), 300 + 200 * Math.floor(i / 3)) as Image;
				badgeObjects[i].name = i;
				badgeObjects[i].addEventListener(TouchEvent.TOUCH, onTouch);
				if (GlobalValues.instance().badgesUnlocked.charAt(i) == "f") {
					badgeObjects[i].setVertexColor(0, 0x888888);
					badgeObjects[i].setVertexColor(1, 0x888888);
					badgeObjects[i].setVertexColor(2, 0x666666);
					badgeObjects[i].setVertexColor(3, 0x666666);
				}
			}
		}

		public override function OnExit(): void {

		}

		public function createTextArea() {
			var sprite: Sprite = new Sprite();
			sprite.x = 50;
			sprite.y = 1030;
			var color: uint = 0xffffff;
			var quad: Quad = new Quad(620, 200, color);
			sprite.addChild(quad);
			titleText = new TextField(580, 50, "Title", "RoofRunners", 48);
			sprite.addChild(titleText);
			descriptionText = new TextField(580, 94, "Description Description Description Description Description Description Description Description Description Description ", "RoofRunners", 32);
			descriptionText.y = 50;
			sprite.addChild(descriptionText);
			requirementText = new TextField(580, 36, "Requirements", "RoofRunners", 32, 0x44AA44);
			requirementText.y = 144;
			sprite.addChild(requirementText);
			Img.ChangeSpriteSize(sprite);
			addChild(sprite);
		}

		public function changeText(i : int) {
			titleText.text = badges[i][1];
			descriptionText.text = badges[i][2];
			requirementText.text = badges[i][3];
		}
		
		public function onTouch(event : TouchEvent) : void {
			var d : DisplayObject = event.target as DisplayObject;
			var touch : Touch = event.getTouch(d, TouchPhase.ENDED);
			if (touch) {
				changeText(parse(d.name));
			}
		}
		
		function parse(str:String):Number {
			for(var i = 0; i < str.length; i++) {
				var c : String = str.charAt(i);
				if(c != "0") break;
			}
			return Number(str.substr(i));
		}
	}
}