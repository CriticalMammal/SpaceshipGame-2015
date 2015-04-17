package src
{
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class Cockpit extends MovieClip
	{
		// ship variables
		public var engineHeat = 0;
		public var blackoutStatus = 0;
		public var blackoutFadeGoal = 0;
		public var currentSpeed = 0.02;
		public var oldSpeed = currentSpeed;
		public var powerOn = true;
		private var justPoweredOn = false;

		public function Cockpit()
		{
			shipBottomShadow.visible = false;
			shipCanopyShadow.visible = false;
			addEventListener(Event.ENTER_FRAME, update, false, 0, false);
		}

		public function update(e:Event):void
		{
			var speedDifference = currentSpeed - oldSpeed;
			blackoutFadeGoal -= 0.0015;
			blackoutFadeGoal += speedDifference/11;

			if (blackoutFadeGoal <= 0)
			{
				blackoutFadeGoal = 0;
			}

			if (engineHeat > 0)
			{
				engineHeat -= 0.2;
				if (engineHeat <= 0)
				{
					engineHeat = 0;
				}
				else if (engineHeat >= 3000)
				{
					blackoutFadeGoal += 0.002;
				}
			}
			else
			{
				blackoutFadeGoal += 0.002;
			}

			blackoutStatus = doLerp(blackoutStatus, blackoutFadeGoal, 0.007);

			var tempDisplay = int((currentSpeed)*100)/100;
			engineHeatDisplay.text = Math.floor(engineHeat).toString();
			currentSpeedDisplay.text = tempDisplay.toString() + " Sp";

			if (powerOn == false)
			{
				shipBottomShadow.visible = true;
				shipCanopyShadow.visible = true;
				engineButton.mouseEnabled = false;
				coolantButton.mouseEnabled = false;
				justPoweredOn = true;
			}
			else
			{
				shipBottomShadow.visible = false;
				shipCanopyShadow.visible = false;
				if (justPoweredOn == true)
				{
					engineButton.mouseEnabled = true;
					coolantButton.mouseEnabled = true;
					justPoweredOn = false;
				}
			}

			oldSpeed = currentSpeed;
		}

		function doLerp(value:Number, goal:Number, lerpSpeed:Number):Number
		{
			var lerpValue:Number = 0.0;

			// Update
			if (value != goal)
			{
				lerpValue = 0.0;
			}

			if (lerpValue < 1.0)
			{
				lerpValue += lerpSpeed;
			}

			var newVal:Number = lerp(value, lerpValue, goal);
			value = newVal;
			return value;
		}

		function lerp(x:Number, t:Number, y:Number):Number
		{
			return x * (1-t) + y*t;
		}
	}
}