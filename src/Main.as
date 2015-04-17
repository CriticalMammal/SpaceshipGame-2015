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
	import flash.display.SimpleButton;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.media.SoundMixer;
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
			var textBunch:Vector.<IntroText> = new Vector.<IntroText>();
			var audioHandler:AudioHandler = new AudioHandler();

			for (var i=0; i<30; i++)
			{
				var introText:IntroText = new IntroText();
				introText.x = Math.floor(Math.random()*500);
				introText.y = Math.floor(Math.random()*500);

				while (introText.x < 400 && introText.x > 100)
				{
					introText.x = Math.floor(Math.random()*500);
				}
				while (introText.y < 400 && introText.y > 200)
				{
					introText.y = Math.floor(Math.random()*500);
				}
				textBunch.push(introText);
				addChild(introText);
			}

			var introTextMessage:IntroText = new IntroText();
			introTextMessage.x = 180;
			introTextMessage.y = 300;
			addChild(introTextMessage);

			var introTextDelay:int = 11*stageRef.frameRate; // 11
			var switchTextDelay:int = 0.1*stageRef.frameRate;
			var introTextStuff = "Break The Speed Of Light";
			/*
			var completeMessages = ["Israel cuts funding on tri-state refugee space transportation to enter light speed race", 
								"Flight time to break light barrier is estimated roughly 4 years on-craft",
								"70 years relative Earth time",
								"Palestinian-Israel sacred airspace bridge program on hold",
								" "];
			*/
			/*
			var textMessages = ["Israel", "cuts", "funding", "tri-state", "refugee", "space transportation", "light", "space race", 
								"flight time", "break", "light barrier", "estimated", "roughly", "4 years", "on-craft",
								"70 years", "relative", "Earth time",
								"Palestinian", "Israel", "sacred", "airspace bridge", "program", "on hold",
								" "];
								*/
			var frameCt = 0;
			var switchCt = 0;
			//var introMessageCt = 0;
			audioHandler.playIntroTextSound();

			addEventListener(Event.ENTER_FRAME, introLoop, false, 0, false);

			function introLoop(event:Event)
			{
				if (!sceneFinished)
				{
					if (switchCt >= switchTextDelay)
					{
						for (i=0; i<textBunch.length; i++)
						{
							textBunch[i].x = Math.floor(Math.random()*450);
							textBunch[i].y = Math.floor(Math.random()*550);

							while (textBunch[i].x < 340 && textBunch[i].x > 10)
							{
								textBunch[i].x = (Math.floor(Math.random()*550))-(100);
							}
							while (textBunch[i].y < 400 && textBunch[i].y > 200)
							{
								textBunch[i].y = Math.floor(Math.random()*550);
							}
						}
						switchCt = 0;
					}

					if (frameCt >= introTextDelay*0.55)
					{
						introTextMessage.message.text = introTextStuff;
					}

					// do intro scene text
					if (frameCt >= introTextDelay)
					{
						sceneFinished = true;
						for (var i=0; i<textBunch.length; i++)
						{
							textBunch[i].sceneFinished = true;
						}
						frameCt = 0;
					}
					frameCt++;
					switchCt++;
				}
				else
				{
					// go to next scene
					removeChild(introTextMessage);

					for (i=0; i<textBunch.length; i++)
					{
						removeChild(textBunch[i]);
					}
					removeEventListener(Event.ENTER_FRAME, introLoop);
					lightBarrier();
				}
			}
		}
		
		// Gameplay - break light barrier
		public function lightBarrier()
		{
			sceneFinished = false;

			// add stars
			var starSpeed = 0.02;
			var starGoalSpeed = 0.02;
			var starField:Starfield = new Starfield();
			addChild(starField);
			starField.updateStarSpeed(starSpeed);

			// add shakeholder
			var shakeBaseVal = 0; //non boost shaking
			var shake = 0;
			var shakeGoal = 0;
			var screenShakeHolder = new Sprite();
			addChild(screenShakeHolder);

			// add cockpit and button listeners
			var cockpit:Cockpit = new Cockpit();
			cockpit.getChildByName("engineButton").addEventListener(MouseEvent.CLICK, engineButtonPress);
			cockpit.getChildByName("coolantButton").addEventListener(MouseEvent.CLICK, coolantButtonPress);
			cockpit.getChildByName("homeButton").addEventListener(MouseEvent.CLICK, homeButtonPress);
			screenShakeHolder.addChild(cockpit);

			var blackoutFilter:BlackScreen = new BlackScreen();
			blackoutFilter.alpha = 0;
			blackoutFilter.mouseEnabled = false;
			addChild(blackoutFilter);

			var audioHandler:AudioHandler = new AudioHandler();

			addEventListener(Event.ENTER_FRAME, lightBarrierLoop, false, 0, false);
			
			function lightBarrierLoop()
			{
				if (!sceneFinished)
				{
					screenShakeHolder.x = 0 - Math.random() * (shake*2+shake) - shake;
					screenShakeHolder.y = 0 - Math.random() * (shake*2+shake) - shake;
					
					//starSpeedLerp(); //update star speeds
					starSpeed = doLerp(starSpeed, starGoalSpeed, 0.007);
					cockpit.currentSpeed = starSpeed;
					starField.updateStarSpeed(starSpeed);
					shake = doLerp(shake, shakeGoal, 0.0065);

					var newVol = starSpeed/25;
					if (newVol>1)
						newVol = 1;

					audioHandler.setVolOfShipAmbience(newVol);


					blackoutFilter.alpha = cockpit.blackoutStatus;

					if (starSpeed >= 5000)
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

			function engineButtonPress(e:MouseEvent):void
			{
				starGoalSpeed += 10;
				shakeBaseVal += 0.2;
				shakeGoal = 5 + shakeBaseVal;
				audioHandler.playEngineSound();
				buttonCooldown(e.currentTarget);
			}

			function coolantButtonPress(e:MouseEvent):void
			{
				audioHandler.playCoolantSound();
				buttonCooldown(e.currentTarget);
			}

			function homeButtonPress(e:MouseEvent):void
			{
				cockpit.powerOn = !cockpit.powerOn;
			}

			function buttonCooldown(button:SimpleButton):void
			{
				button.mouseEnabled = false;
				var cooldownWait = 8 * stageRef.frameRate; //seconds
				var currentCooldown = 0;
				addEventListener(Event.ENTER_FRAME, cooldownTimer, false, 0, false);

				function cooldownTimer():void
				{
					if (currentCooldown >= cooldownWait)
					{
						button.mouseEnabled = true;
						shakeGoal = shakeBaseVal;
						removeEventListener(Event.ENTER_FRAME, cooldownTimer);
					}
					else if (currentCooldown == cooldownWait*0.5)
					{
						// set shakeGoal to base val;
						shakeGoal = shakeBaseVal;
					}

					if (button.name == "engineButton")
					{
						cockpit.engineHeat += 2;
					}
					else if (button.name == "coolantButton")
					{
						cockpit.engineHeat -= 5;
					}

					currentCooldown ++;
				}
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

			function removeLightBarrierStuff()
			{
				removeEventListener(Event.ENTER_FRAME, lightBarrierLoop);
				removeChild(starField);
				removeChild(screenShakeHolder);
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

		public function lerp(x:Number, t:Number, y:Number):Number
		{
			return x * (1-t) + y*t;
		}
	} //end of class
} //end of package