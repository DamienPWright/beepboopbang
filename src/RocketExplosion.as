package  
{
	import org.flixel.*;
	/**
	 * ...
	 * @author Raujinn
	 */
	public class RocketExplosion extends FlxSprite
	{
		[Embed(source = "assets/images/rocketExplode.png")] private var ImgExplode:Class;
		private var lifespan:Number = 0.5;
		private var timeAlive:Number = 0;
		public function RocketExplosion(X:Number, Y:Number) 
		{
			super(X, Y);
			solid = false;
			loadGraphic(ImgExplode, true);
			addAnimation("explode", [0, 1, 2, 3, 4], 30, false);
		}
		
		override public function update():void {
			super.update();
			timeAlive += FlxG.elapsed;
			if (frame == 4) {
				frame = 0;
				timeAlive = 0;
				kill();
			}
		}
		
		public function resetAnim():void {
			play("explode");
		}
	}

}