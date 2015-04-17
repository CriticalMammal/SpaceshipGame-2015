package src
{
	import flash.geom.Point;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.display.Stage; // Used to pass the main stage to the constructor
	
	public class Star extends Sprite
	{
		// Class properties
		public var zSpeed:Number;
		
		// Class variables
		public static var maxX:int = 200;
		public static var minX:int = 100;
		public static var maxY:int = 200;
		public static var minY:int = 100;
		public static var maxZ:int = 1000;
		public static var minZ:int = 0;
		public static var midStageX:int;
		public static var midStageY:int;
		
		// Constructor
		public function Star():void
		{
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}

		private function onAddedToStage(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);

			// Get the middle of the stage
			var center:Point = new Point(stage.stageWidth / 2, stage.stageHeight / 2);
			midStageX = center.x;
			midStageY = center.y;
			
			// Randomise x, y and z position for each star
			this.x = ((Math.random() * maxX) - minX) + midStageX;
			this.y = ((Math.random() * maxY) - minY) + midStageY;
			if ((Math.random() > .5) ? true : false)
			{
				this.z = (Math.random()  * maxZ) - minZ;
			}
			else
			{
				this.z = -(Math.random()  * maxZ) - minZ;
			}
			
			// Set random z speed and rotation for each star
			this.zSpeed = (Math.random() * 0.1);

			this.graphics.clear();
			this.graphics.beginFill(0x9E9E9E);
			this.graphics.drawCircle(0, 0, 100); //zSpeed/10
			this.scaleX = 0.003;
			this.scaleY = 0.003;
			
			// Bind each star to update once per frame
			this.addEventListener(Event.ENTER_FRAME, updateStar);
		}
		
		// Function to unbind the event listener of the star
		public function starDestructor():void
		{
			this.removeEventListener(Event.ENTER_FRAME, updateStar);
		}
		
		// Function to update the star each frame
		private function updateStar(e:Event):void
		{
			// Move star closer...
			this.z -= this.zSpeed;	
					
			// If we're getting really close start to fade the star out
			if (this.z < -600)
			{
				//this.scaleX /= 1.03;
				//this.scaleY /= 1.03;
				
				// If the star is super-close reset it
				if (this.z < -1500)
				{
					// Re-randomise x, y and z locations
					this.x = ((Math.random() * maxX) - minX) + midStageX;
					this.y = ((Math.random() * maxY) - minY) + midStageY;
					this.z = (Math.random()  * maxZ) - minZ;

					//this.scaleX = 0.003;
					//this.scaleY = 0.003;
					
				} // End of reset if statement
				
			} // End of if star is close statement
			
		} // End of updateStar function
		
	} // End of class
	
} // End of package