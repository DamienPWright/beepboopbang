package  
{
	import org.flixel.*;
	/**
	 * ...
	 * @author Raujinn
	 */
	public class BlockLineExplosionVer extends Block
	{
		[Embed(source = "assets/images/verlineexplodeblock.png")] private var ImgBlock:Class;
		public function BlockLineExplosionVer(X:Number, Y:Number) 
		{
			super(X, Y);
			loadGraphic(ImgBlock, false);
		}
		
		override public function killBlock():void {
			//hitbox array
			var hitbox_1:HitBox = (FlxG.state as PlayState).hitBoxes.recycle() as HitBox;
			var hb_w = 12;
			var hb_h = (FlxG.state as PlayState).groundLevel + 16;
			var hb_x = x + 2;
			var hb_y = 0;
			
			hitbox_1.resetHitBox(hb_x, hb_y, hb_w, hb_h, 5);

			kill();
		}
	}
}