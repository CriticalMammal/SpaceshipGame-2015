package src
{
	import flash.display.Sprite;
	import flash.events.Event;
	import src.*;
	
	public class Starfield extends Sprite
	{
 		public var starContainer:Vector.<Star>;
 		public var starCt = 1000;

		public function Starfield()
		{
			starContainer = new Vector.<Star>();
			
			// Make stars one each frame for a while.
			//addEventListener(Event.ENTER_FRAME, update);
			update();
		}
 
		private function update():void
		{
			for (var i=0; i<starCt; i++)
			{
				var s:Star = new Star();
				starContainer.push(s);
				addChild(s);
			}

			//removeEventListener(Event.ENTER_FRAME, update);
			/*
			// Make one star each time, until there are 150.
			if (this.numChildren < 200) 
			{
				var s:Star = new Star();
				//s.x = Math.random() * 1000;
				//s.y = Math.random() * 650;
				addChild(s);
			} 
			else 
			{
				removeEventListener(Event.ENTER_FRAME, update);
			}
			*/
		}

		public function updateStarSpeed(speed:Number):void
		{
			for (var i=0; i<starContainer.length; i++)
			{
				starContainer[i].zSpeed = Math.random() *speed;
			}
		}
 
	}
 
}