package  
{
	import org.flixel.*;
	/**
	 * ...
	 * @author Raujinn
	 */
	public class BlockLineExplosionHor extends Block
	{
		[Embed(source = "assets/images/horlineexplodeblock.png")] private var ImgBlock:Class;
		public function BlockLineExplosionHor(X:Number, Y:Number) 
		{
			super(X, Y);
			loadGraphic(ImgBlock, false);
		}
		
		override public function killBlock():void {
			//hitbox array
			var hitbox_1:HitBox = (FlxG.state as PlayState).hitBoxes.recycle() as HitBox;
			var hb_w = (FlxG.state as PlayState).blocksPerRow * 16;
			var hb_h = 12;
			var hb_x = (FlxG.state as PlayState).blockBoundaryLeft;
			var hb_y = y + 2;
			
			hitbox_1.resetHitBox(hb_x, hb_y, hb_w, hb_h, 5);

			kill();
		}
	}
}