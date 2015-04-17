package src
{
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class IntroText extends MovieClip
	{
		public var frameCt = 0;
		public var textMessages = ["Israel", "refugee", "space transportation", "airspace bridge", "on hold",
							"flight time", "break", "light barrier", "estimated", "light", "space race", 
							"cuts", "funding", "tri-state", "Palestinian", "roughly", "4 years", "on-craft",
							 "program", "70 years", "relative", "Earth time", "leadership", "safe haven", 
							"technology", "arms-race", "information", "counter intelligence", "above holy",
							"joint effort", "she has agreed", "has agreed", "advanced", "deal", "committee",
							"to protect", "rights", "board", "mission", "people", "sacred"];
		public var introMessageCt = Math.floor(Math.random()*textMessages.length-1);
		public var sceneFinished = false;
		public var introTextDelay:int = 0.1*60; // warning this could change!!!!

		public function IntroText()
		{
			addEventListener(Event.ENTER_FRAME, textLoop, false, 0, false);
		}

		public function textLoop(e:Event)
		{
			if (!sceneFinished)
			{
				// do intro scene text
				if (frameCt >= introTextDelay)
				{
					introMessageCt = Math.floor(Math.random()*textMessages.length);
					this.message.text = textMessages[introMessageCt];
					frameCt = 0;
				}
				frameCt++;
			}
			else
			{
				// go to next scene
				removeEventListener(Event.ENTER_FRAME, textLoop);
				this.message.text = " ";
			}
		}
	}
}