package  
{
	import org.flixel.*;
	/**
	 * ...
	 * @author Raujinn
	 */
	public class BlockBomb extends Block
	{
		[Embed(source = "assets/images/block_bomb.png")] private var ImgBlock:Class;
		public function BlockBomb(X:Number, Y:Number) 
		{
			super(X, Y);
			loadGraphic(ImgBlock, false);
		}
		
		override public function killBlock():void {
			//hitbox array
			var hitbox_1:HitBox = (FlxG.state as PlayState).hitBoxes.recycle() as HitBox;
			var hitbox_2:HitBox = (FlxG.state as PlayState).hitBoxes.recycle() as HitBox;
			var hitbox_3:HitBox = (FlxG.state as PlayState).hitBoxes.recycle() as HitBox;
			var hitbox_4:HitBox = (FlxG.state as PlayState).hitBoxes.recycle() as HitBox;
			var hitbox_5:HitBox = (FlxG.state as PlayState).hitBoxes.recycle() as HitBox;
			var center_hitboxSize = 48;
			var side_hitboxSize = 16;
			var hbOriginX = x - center_hitboxSize / 2 + width / 2;
			var hbOriginY = y - center_hitboxSize / 2 + width / 2;
			
			hitbox_1.resetHitBox(hbOriginX, hbOriginY, center_hitboxSize, center_hitboxSize, 5);
			hitbox_2.resetHitBox(hbOriginX-side_hitboxSize, hbOriginY+side_hitboxSize, side_hitboxSize, side_hitboxSize, 5);
			hitbox_3.resetHitBox(hbOriginX+center_hitboxSize, hbOriginY+side_hitboxSize, side_hitboxSize, side_hitboxSize, 5);
			hitbox_4.resetHitBox(hbOriginX+side_hitboxSize, hbOriginY-side_hitboxSize, side_hitboxSize, side_hitboxSize, 5);
			hitbox_5.resetHitBox(hbOriginX+side_hitboxSize, hbOriginY+center_hitboxSize, side_hitboxSize, side_hitboxSize, 5);
			kill();
		}
	}
}