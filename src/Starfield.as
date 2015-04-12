package src
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class Starfield extends Sprite
	{
 
		public function Starfield()
		{
			// Make stars one each frame for a while.
			addEventListener(Event.ENTER_FRAME, update);
		}
 
		private function update(e:Event):void
		{
			// Make one star each time, until there are 150.
			if (this.numChildren &lt; 150) {
				var s:Star = new Star();
				s.x = Math.random() * 1000;
				s.y = Math.random() * 650;
				addChild(s);
			} else {
				removeEventListener(Event.ENTER_FRAME, update);
			}
		}
 
	}
 
}