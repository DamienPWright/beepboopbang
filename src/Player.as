package  
{
	import org.flixel.*;
	/**
	 * ...
	 * @author Raujinn
	 */
	public class Player extends FlxSprite
	{
		[Embed(source = "assets/images/player.png")] private var ImgPlayer:Class;
		private var jumpvel:Number;
		private var currentFacing:String;
		private var anim:String;
		private var lookingUp:Boolean;
		
		private var timeBetweenShots:Number = 0.14;
		private var shootTimer:Number = 0;
		
		private var bulletColor:int = 0;
		
		public function Player(X:Number, Y:Number) 
		{
			super(X, Y);
			loadGraphic(ImgPlayer, true);
			maxVelocity.x = 100;
			maxVelocity.y = 400;
			acceleration.y = 300;
			jumpvel = 175;
			drag.x = maxVelocity.x * 4;
			currentFacing = "right";
			
			addAnimation("idle_right", [0], 0, false);
			addAnimation("idle_left", [1], 0, false);
			addAnimation("idle_right_up", [6], 0, false);
			addAnimation("idle_left_up", [13], 0, false);
			addAnimation("walk_right", [2, 0, 3, 0], 10, true);
			addAnimation("walk_left", [4, 1, 5, 1], 10, true);
			addAnimation("walk_right_up", [9, 6, 10, 6], 10, true);
			addAnimation("walk_left_up", [11, 13, 12, 13], 10, true);
			addAnimation("jump_right", [7], 0, false);
			addAnimation("jump_left", [8], 0, false);
			addAnimation("jump_right_up", [14], 0, false);
			addAnimation("jump_left_up", [15], 0, false);
		}
		
		override public function update():void
		{
			processControls();
			processAnimation();
		}
		
		private function processControls():void
		{
			acceleration.x = 0;
			shootTimer += FlxG.elapsed;
			if (FlxG.keys.A){
				acceleration.x -= drag.x;
				currentFacing = "left";
			}
			if (FlxG.keys.D){
				acceleration.x += drag.x;
				currentFacing = "right";
			}
			if (FlxG.keys.W)
			{
				lookingUp = true;
			}else 
			{
				lookingUp = false;
			}
			
			if (isTouching(FLOOR))
			{
				if (FlxG.keys.justPressed("SPACE"))
				{
					velocity.y = -jumpvel;
				}
			}
			
			if (FlxG.keys.SHIFT || FlxG.keys.justPressed("SHIFT")) {
				if(shootTimer >= timeBetweenShots){
					var bullet:FlxSprite = (FlxG.state as PlayState).playerBullets.recycle() as FlxSprite;
					shootTimer = 0;
					shootBullet(bullet);
				}
			}
		}
		
		private function shootBullet(bullet) {
			if (lookingUp) {
						bullet.frame = 0;
						if (currentFacing == "right") {
							bullet.reset(x + 6, y - 4);
							bullet.velocity.y = -200;
						}else {
							bullet.reset(x - 2, y - 4);
							bullet.velocity.y = -200;
						}
					}else {
						bullet.frame = 1;
						if (currentFacing == "right") {
							bullet.reset(x+8, y + 3);
							bullet.velocity.x = 200;
						}else {
							bullet.reset(x-4, y + 3);
							bullet.velocity.x = -200;
						}
					}
		}
		
		private function processAnimation():void
		{
			var onGround:Boolean = isTouching(FLOOR);
			
			if(!lookingUp){
				if ((acceleration.x == 0) && onGround) {
					if (currentFacing == "right") anim = "idle_right";
					if (currentFacing == "left") anim = "idle_left";
				}
				if ((acceleration.x != 0) && onGround) {
					if (currentFacing == "right") anim = "walk_right";
					if (currentFacing == "left") anim = "walk_left";
				}
				if (!onGround) {
					if (currentFacing == "right") anim = "jump_right";
					if (currentFacing == "left") anim = "jump_left";
				}
			}else {
				if ((acceleration.x == 0) && onGround) {
					if (currentFacing == "right") anim = "idle_right_up";
					if (currentFacing == "left") anim = "idle_left_up";
				}
				if ((acceleration.x != 0) && onGround) {
					if (currentFacing == "right") anim = "walk_right_up";
					if (currentFacing == "left") anim = "walk_left_up";
				}
				if (!onGround) {
					if (currentFacing == "right") anim = "jump_right_up";
					if (currentFacing == "left") anim = "jump_left_up";
				}
			}
			play(anim);
		}
		
		public function getIsLookingUp():Boolean {
			return lookingUp;
		}
	}

}