package src.screens {

	import src.Game;
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
		
		// Badges index.
		public static var BADGE_LEVEL_2: int = 0;
		public static var BADGE_LEVEL_3: int = 1;
		public static var BADGE_LEVEL_5: int = 2;
		public static var BADGE_LEVEL_7: int = 3;
		public static var BADGE_LEVEL_9: int = 4;
		public static var BADGE_FINISHED: int = 5;
		public static var BADGE_ONE_BABY: int = 6;
		public static var BADGE_NO_BABIES: int = 7;
		public static var BADGE_HUG: int = 8;
		public static var BADGE_KISS: int = 9;
		public static var BADGE_SEX: int = 10;
		public static var BADGE_BUTTON: int = 11;
		public static var BADGE_5_CONDOMS: int = 12;
		public static var BADGE_10_CONDOMS: int = 13;
		public static var BADGE_EXTRA1: int = 14;
		public static var BADGE_EXTRA2: int = 15;

		/** Title of the selected badge. */
		private var titleText: TextField;
		
		/** Description of the selected badge. */
		private var descriptionText: TextField;
		
		/** Requirements of the selected badge. */
		private var requirementText: TextField;

		/** Array that holds all badge information. */
		private static var badges: Array = new Array(
			new Array("badge_gold", "First Kiss", "You have kissed your partner for the first time", "Reach level 2"),
			new Array("badge_gold", "First Time", "You have had sex for the first time", "Reach level 3"),
			new Array("badge_gold", "I love you!", "You and your partner are officially lovers!", "Reach level 5"),
			new Array("badge_gold", "Commitment", "Nothing can break you and your partner apart!", "Reach level 7"),
			new Array("badge_gold", "Engagement", "You are a perfect fit with your partner!", "Reach level 9"),
			new Array("badge_black", "Perfect Relationship", "You managed to obtain the perfect relationship!", "Finish the game"),
			new Array("badge_gold", "Family Planning 1", "Plan to have a great relationship with a child. Finish the game with exactly one baby.", GlobalValues.instance().babies.toString() + " / 1 baby"),
			new Array("badge_black", "Family Planning 2", "Wait to have a baby until you are sure to have one.", GlobalValues.instance().babies.toString() + " / 0 babies"),
			new Array("badge_gold", "Teddy Bear", "You love to cuddle. You pressed the hug button 1000 times.", GlobalValues.instance().hugPressed.toString() + " / 1000 hugs"),
			new Array("badge_gold", "Kisser", "You are a great kisser! You pressed the kiss button 1000 times.", GlobalValues.instance().kissPressed.toString() + " / 1000 kisses"),
			new Array("badge_gold", "Heat of the Moment", "You managed to press the sex button 1000 times.", GlobalValues.instance().sexPressed.toString() + " / 1000 sex buttons"),
			new Array("badge_black", "Loyal", "You are loyal to your partner and pressed 5000 action buttons.", (GlobalValues.instance().hugPressed + GlobalValues.instance().kissPressed + GlobalValues.instance().sexPressed).toString() + " / 5000 actions"),
			new Array("badge_gold", "Safe Sex", "Protection is key!", GlobalValues.instance().condomUsed.toString() + " / 5"),
			new Array("badge_black", "Safer Sex", "Always use protection!", GlobalValues.instance().condomUsed.toString() + " / 10"));
			
		/** Array that holds all badge images. */
		private var badgeObjects: Array = new Array();

		/** sprite that holds all images and text to display the currently active badge. */
		private var sprite:Sprite;
		
		/** Image object that shows the last clicked badge. */
		private var activeBadge: DisplayObject;

		/**
		 * Creates an instance of StatisticsScreen.
		 */
		public function StatisticsScreen() {
			this.setBackground("main_background_orange");
		}

		/**
		 * Override from Screen. Is called upon entering the screen. Creates the basic buttons and text.
		 */
		public override function OnEnter(): void {
			Img.CreateTextAt(this, "HI-SCORE: " + GlobalValues.instance().highScore, 0, 0, 720, 200, 64);
			Img.CreateScreenSwitchButtonAt("button_back", Screens.MAINMENU, 0, 1100);
			createTextArea();
			changeText(0);
			for (var i: int = 0; i < badges.length; i++) {
				badgeObjects[i] = Img.GetNewImageAt(badges[i][0], 85 + ((150 * i) % 600), 220 + 150 * Math.floor(i / 4)) as Image;
				badgeObjects[i].width /= 3;
				badgeObjects[i].height /= 3;
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

		/**
		 * Creates the area in the bottom of the screen, where information of the currently selected badge is shown.
		 */
		public function createTextArea() {
			
			// Create a sprite for the text area.
			sprite = new Sprite();
			sprite.x = 50;
			sprite.y = 820;
			
			// Create a square.
			var color: uint = 0xffffff;
			var quad: Quad = new Quad(620, 250, color);
			sprite.addChild(quad);
			
			// Add a title.
			titleText = new TextField(580, 50, "Title", "RoofRunners", 48);
			sprite.addChild(titleText);
			
			// Add a description.
			descriptionText = new TextField(580, 144, "Description Description Description Description Description Description Description Description Description Description ", "RoofRunners", 32);
			descriptionText.y = 50;
			sprite.addChild(descriptionText);
			
			// Add a requirement.
			requirementText = new TextField(580, 36, "Requirements", "RoofRunners", 32, 0x44AA44);
			requirementText.y = 194;
			sprite.addChild(requirementText);
			
			// Add text area to the screen.
			Img.ChangeSpriteSize(sprite);
			addChild(sprite);
		}

		/**
		 * Shows all information from the selected badge.
		 *
		 * @param i Index of the badge you want to show the information from.
		 */
		public function changeText(i: int) {
			/*if (activeBadge) {
				activeBadge.removeFromParent(true);
				activeBadge = null;
			}
			activeBadge = Img.AddDisplayObject(new Image(Game.instance().assets.getTexture(badges[i][0])), 350, 190);
			sprite.addChild(activeBadge);*/
			titleText.text = badges[i][1];
			descriptionText.text = badges[i][2];
			requirementText.text = badges[i][3];
			
			if (GlobalValues.instance().badgesUnlocked.charAt(i) == "f") {
				for (var i = 0; i < sprite.numChildren; i++) {
					var s = sprite.getChildAt(i) as Quad;
					if (s) {
						s.setVertexColor(0, 0x888888);
						s.setVertexColor(1, 0x888888);
						s.setVertexColor(2, 0x666666);
						s.setVertexColor(3, 0x666666);
					}
				}
			} else {
				for (i = 0; i < sprite.numChildren; i++) {
					s = sprite.getChildAt(i) as Quad;
					if (s) {
						s.setVertexColor(0, 0xFFFFFF);
						s.setVertexColor(1, 0xFFFFFF);
						s.setVertexColor(2, 0xFFFFFF);
						s.setVertexColor(3, 0xFFFFFF);
					}
				}
			}
		}

		/**
		 * Called when a badge is pressed.
		 *
	     * @param e TouchEvent.
		 */
		public function onTouch(event: TouchEvent): void {
			var d: DisplayObject = event.target as DisplayObject;
			var touch: Touch = event.getTouch(d, TouchPhase.ENDED);
			if (touch) {
				changeText(parse(d.name));
			}
		}

		/**
		 * Converts a string to a Number.
		 *
		 * @param str The string you want to convert.
		 * 
		 * @return Returns the number generated from the string.
		 */
		function parse(str: String): Number {
			for (var i = 0; i < str.length; i++) {
				var c: String = str.charAt(i);
				if (c != "0") break;
			}
			return Number(str.substr(i));
		}
	}
}