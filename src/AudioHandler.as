package src
{
	import flash.display.Sprite;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.media.SoundMixer;
	
	public class AudioHandler extends Sprite
	{
		public var shipAmbience:Sound = new ShipAmbienceSound();
		public var shipAmbienceChannel:SoundChannel = new SoundChannel();
		public var shipAmbienceTransform = new SoundTransform();

		public var fastShipAmbience:Sound = new FastShipAmbienceSound();
		public var fastShipAmbienceChannel:SoundChannel = new SoundChannel();
		public var fastShipAmbienceTransform = new SoundTransform();

		public var shipEngine:Sound = new EngineSound();
		public var shipEngineChannel:SoundChannel = new SoundChannel();
		public var shipEngineTransform = new SoundTransform();

		public var coolant:Sound = new CoolantSound();
		public var coolantChannel:SoundChannel = new SoundChannel();
		public var coolantTransform = new SoundTransform();

		public var introText:Sound = new IntroTextSound();
		public var introTextChannel:SoundChannel = new SoundChannel();
		public var introTextTransform = new SoundTransform();

		public function AudioHandler()
		{
			shipAmbienceTransform.volume = 1;
			shipAmbienceChannel.soundTransform = shipAmbienceTransform;
			shipAmbienceChannel = shipAmbience.play(0, int.MAX_VALUE, shipAmbienceTransform);

			fastShipAmbienceTransform.volume = 0;
			fastShipAmbienceChannel.soundTransform = fastShipAmbienceTransform;
			fastShipAmbienceChannel = fastShipAmbience.play(0, int.MAX_VALUE, fastShipAmbienceTransform);

			shipAmbienceTransform.volume = 1;
			shipAmbienceChannel.soundTransform = shipAmbienceTransform;
			//shipAmbienceChannel = shipAmbience.play(0, int.MAX_VALUE, shipAmbienceTransform);

			coolantTransform.volume = 1;
			coolantChannel.soundTransform = coolantTransform;

			introTextTransform.volume = 1;
			introTextChannel.soundTransform = introTextTransform;
		}

		public function playEngineSound():void
		{
			shipEngineChannel = shipEngine.play(0, 1, shipEngineTransform);
		}

		public function playCoolantSound():void
		{
			coolantChannel = coolant.play(0, 1, coolantTransform);
		}

		public function playIntroTextSound():void
		{
			introTextChannel = introText.play(0, 1, introTextTransform);
		}

		public function setVolOfShipAmbience(newVol:Number):void
		{
			fastShipAmbienceTransform.volume = newVol;
			fastShipAmbienceChannel.soundTransform = fastShipAmbienceTransform;
			//fastShipAmbienceChannel = fastShipAmbience.play(0, int.MAX_VALUE, fastShipAmbienceTransform);
		}
	}
}