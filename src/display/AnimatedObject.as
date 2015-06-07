package src.display
{
	import starling.display.Sprite;
	import starling.events.Event;
	import src.Game;
	import starling.display.Image;
	import starling.textures.Texture;
	import src.display.Img;
	
	/*
		Use as following:
	
		var a : AnimatedObject = new AnimatedObject("walk", 54);
		addChild(a);
	*/
	
	public class AnimatedObject extends Sprite
	{
		var texture : Texture;
		var image : Image;
		var images : Array = new Array();
		var index : int = 0;
		var maxIndex : int;		
		
		public function AnimatedObject(name : String, size : int)
		{
			maxIndex = size;
			
			for (var i : int = 0; i < size; i++)
			{
				var s : String = name + i.toString();
				trace(s);
				images.push(Game.instance().assets.getTexture(s));
			}
			
			texture = images[0];
			image = new Image(texture);
			addChild(image);
			
			addEventListener(Event.ENTER_FRAME, update);
			
			Img.ChangeSpriteSize(this);
		}
		
		public function update(e : Event) : void
		{
			image.texture = images[index];
			
			index++;
			if (index >= maxIndex) index = 0;
		}
	}
}