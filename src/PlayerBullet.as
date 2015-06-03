package  
{
	import org.flixel.*;
	/**
	 * ...
	 * @author Raujinn
	 */
	public class PlayerBullet extends FlxSprite
	{	
		[Embed(source = "assets/images/playerBullet.png")] private var ImgBullet:Class;
		public function PlayerBullet(X:Number, Y:Number) 
		{
			super(X, Y);
			//solid = false;
			//allowCollisions = 0x0011;
			loadGraphic(ImgBullet,true);
		}
		
		override public function update():void {
			super.update();
			if (isTouching(WALL)) {
				destroyBullet();
			}
		}
		
		public function testYboundary():void {
			if (y < -10) {
				kill();
			}
		}
		/*
		public function destroyBullet():void {
			var explode:FlxSprite = (FlxG.state as PlayState).bulletExplosions.recycle() as FlxSprite;
			explode.reset(x, y);
			explode.play("explode");
			kill();
		}
		*/
		public function destroyBullet():void {
			var explode:FlxSprite = (FlxG.state as PlayState).bulletExplosions.recycle() as FlxSprite;
			explode.reset(x-explode.width/2 +width/2, y-explode.height/2+width/2);
			explode.play("explode");
			/*
			var hitbox:HitBox = (FlxG.state as PlayState).hitBoxes.recycle() as HitBox;
			var hitboxSize:Number = 16;
			var hbOriginX = x - hitboxSize / 2 + width / 2;
			var hbOriginY = y - hitboxSize / 2 + width / 2
			hitbox.resetHitBox(hbOriginX,hbOriginY,hitboxSize,hitboxSize,1,true);
			*/
			
			
			kill();
		}
	}
}