package  
{
	import org.flixel.*;
	/**
	 * ...
	 * @author Raujinn
	 */
	public class ActiveSpikeBall extends FlxSprite
	{
		[Embed(source = "assets/images/active_spikeball.png")] private var ImgActive:Class;
		public function ActiveSpikeBall(X:Number, Y:Number) 
		{
			super(X, Y);
			loadGraphic(ImgActive, false);
			velocity.y = 200;
			acceleration.y = 200;
			maxVelocity.y = 300;
		}
		
		public function getY():Number {
			return y;
		}
		
		public function killBlock():void {
			kill();
		}
	}
}