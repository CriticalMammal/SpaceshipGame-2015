package src
{
	import flash.display.ColorCorrection;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.KeyboardEvent;
	import flash.events.TimerEvent;
	import flash.utils.getQualifiedClassName;
	import flash.geom.Point;
	import flash.geom.ColorTransform;
	import flash.utils.Timer;
	import src.*;
	

	public class Main extends Sprite
	{
		private var stageRef:Stage;
		private var sceneFinished = false;
		private var quit = false;
		public var gameRateMultiplier:Number = 1;
		public var worldSpeed:Number = 60 * gameRateMultiplier;

		
		// Constructor
		public function Main(stageRef:Stage = null)
		{
			this.stageRef = stageRef;
			stageRef.frameRate = worldSpeed;
			intro();
		}

		// Intro
		public function intro()
		{
			sceneFinished = false;
			addEventListener(Event.ENTER_FRAME, introLoop, false, 0, false);

			function introLoop(event:Event)
			{
				if (!sceneFinished)
				{
					// do intro scene text
					// cut to black
					// remove content
					sceneFinished = true;
				}
				else
				{
					// go to next scene
					removeEventListener(Event.ENTER_FRAME, introLoop);
					lightBarrier();
				}
			}
		}
		
		// Gameplay - break light barrier
		public function lightBarrier()
		{
			sceneFinished = false;
			var cockpit:Cockpit = new Cockpit();
			addChild(cockpit);

			addEventListener(Event.ENTER_FRAME, lightBarrierLoop, false, 0, false);
			
			function lightBarrierLoop()
			{
				if (!sceneFinished)
				{
					cockpit.x ++;
					//trace(cockpit.x);
					
					if (cockpit.x > 500)
					{
						sceneFinished = true;
					}
				}
				else
				{
					removeLightBarrierStuff();
					goHome();
				}
			}

			function removeLightBarrierStuff()
			{
				removeEventListener(Event.ENTER_FRAME, lightBarrierLoop);
				removeChild(cockpit);
			}
		}

		// Gameplay - Go Home
		public function goHome()
		{
			sceneFinished = false;
			addEventListener(Event.ENTER_FRAME, homeLoop, false, 0, false);

			function homeLoop()
			{
				if (!sceneFinished)
				{
					sceneFinished = true;
				}
				else
				{
					removeEventListener(Event.ENTER_FRAME, homeLoop);
					outro();
				}
			}
		}

		// Outro
		public function outro()
		{
			sceneFinished = false;
			addEventListener(Event.ENTER_FRAME, outroLoop, false, 0, false);

			function outroLoop()
			{
				if (!sceneFinished)
				{
					sceneFinished = true;
				}
				else
				{
					removeEventListener(Event.ENTER_FRAME, outroLoop);
					intro();
				}
			}
		}
	} //end of class
} //end of package