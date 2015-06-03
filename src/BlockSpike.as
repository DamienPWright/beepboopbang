package  {
	import org.flixel.*;
	/**
	 * ...
	 * @author Raujinn
	 */
	public class BlockSpike extends Block
	{
		[Embed(source = "assets/images/block_spikeball.png")] private var ImgBlock:Class;
		public function BlockSpike(X:Number, Y:Number) 
		{
			super(X, Y);
			loadGraphic(ImgBlock, false);
		}
		
		override public function killBlock():void {
			//hitbox array
			var spikeball:ActiveSpikeBall = (FlxG.state as PlayState).activeSpikeBalls.recycle() as ActiveSpikeBall;
			spikeball.reset(x, y);
			kill();
		}
	}
}