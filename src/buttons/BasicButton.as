package src.buttons
{	
	import starling.display.Button;
	import starling.events.TouchEvent;
	import starling.textures.Texture;

	public class BasicButton extends Button
	{
		public function BasicButton(_upState : Texture, _downState : Texture)
		{
			super(_upState, "", _downState);
			this.addEventListener(TouchEvent.TOUCH, OnTouch); 
		}
		
		public function OnTouch(e : TouchEvent) : void
		{
			
		}
	}
}
