package  
{
	import BlockSpike;
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;
	/**
	 * ...
	 * @author Raujinn
	 */
	public class PlayState extends FlxState
	{
		[Embed(source = "assets/images/tiles.png")] private var ImgTiles:Class;
		
		protected var _level:FlxTilemap;
		protected var _testPlayer:FlxSprite;
		protected var _testBlock:Block;
		protected var _testBlock2:Block;
		protected var _testBlockRow:Array = new Array();
		protected var player:Player;
		
		public var blockBoundaryLeft:Number = 32;
		public var blockBoundaryRight:Number = 272;
		public var numBlockRows:Number = 14;
		public var blocksPerRow:Number = blockBoundaryLeft - blockBoundaryRight / 16 + 1;
		public var blocksPerColumn:Number = 8;
		public var blocks:FlxGroup;
		public var blockRow:FlxGroup;
		public var backRowRef:FlxGroup;
		public var backRowBlock:FlxSprite;
		public var frontRowRef:FlxGroup;
		public var frontRowBlock:FlxSprite;
		
		public var currentRowRef:Array = new Array();
		public var groundLevel:int = 192;
		public var groundReached:Boolean = false;
		public var blockSpeed:Number = 0.10; //0.15
		public var blockMoveCounter:Number = 0;
		
		public var playerBullets:FlxGroup;
		public var playerBulletsSize:int = 16;
		public var bulletExplosions:FlxGroup;
		public var bulletExplosionsSize:int = 16;
		public var rocketExplosions:FlxGroup;
		public var rocketExplosionsSize:int = 16;
		public var activeSpikeBalls:FlxGroup;
		public var activeSpikeBallsSize:int = 16;
		public var hitBoxes:FlxGroup;
		public var hitBoxesSize:int = 256;
		public var drawHitBoxes:Boolean = true; 
		public var _testBullet;
		
		public var _drawDebug:Boolean = true;
		public var debugText:FlxText = new FlxText(0,0,340,"Debug Mode on");
		
		override public function create():void
		{
				
				//MAP
				var tiles:Array = new Array()
				tiles = [
					6, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 6, 6,
					7, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 7, 7,
					7, 7, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 4, 0, 3, 0, 0, 4, 7, 7,
					7, 7, 0, 0, 0, 5, 0, 3, 0, 0, 5, 5, 0, 0, 3, 0, 0, 0, 7, 7,
					7, 7, 0, 0, 0, 4, 0, 3, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 7, 7,
					7, 7, 1, 1, 1, 1, 0, 3, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 7, 7,
					7, 7, 2, 2, 2, 2, 0, 3, 0, 0, 0, 0, 0, 0, 3, 4, 0, 0, 7, 7,
					7, 7, 2, 2, 2, 2, 0, 3, 0, 0, 3, 0, 5, 0, 3, 0, 0, 0, 7, 7,
					7, 7, 2, 2, 2, 2, 1, 1, 1, 0, 3, 0, 0, 0, 3, 0, 0, 0, 7, 7,
					7, 7, 2, 2, 2, 2, 2, 2, 2, 0, 3, 0, 0, 4, 3, 0, 5, 0, 7, 7,
					7, 7, 2, 2, 2, 2, 2, 2, 2, 0, 3, 0, 3, 0, 3, 0, 0, 0, 7, 7,
					7, 7, 2, 2, 2, 2, 2, 2, 2, 0, 3, 0, 3, 0, 1, 1, 1, 1, 7, 7,
					7, 7, 2, 2, 2, 2, 2, 2, 2, 0, 3, 0, 3, 0, 2, 2, 2, 2, 7, 7,
					6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6,
					7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7
				]
				_level = new FlxTilemap();
				_level.loadMap(FlxTilemap.arrayToCSV(tiles, 20), ImgTiles, 16, 16, NaN, 0, 1, 6);
				add(_level);
				
				//PLAYER
				player = new Player(FlxG.width / 2, 128);
				add(player);
				
				//BULLETS
				playerBullets = new FlxGroup(playerBulletsSize);
				for (var i:int = 0; i < playerBulletsSize; i++ ) {
					var newBullet:PlayerBullet = new PlayerBullet(0, 0);
					newBullet.exists = false;
					playerBullets.add(newBullet);
				}
				add(playerBullets);
				
				//BLOCKS
				blocks = new FlxGroup();
				for (var i:int = 0; i < numBlockRows; i++) {
					var newColumn:BlockColumn = new BlockColumn(32 + (i * 16));
					blocks.add(newColumn);
					/*
					if (i == 0) {
						frontRowRef = newColumn;
					}
					if (i == numBlockRows - 1) {
						backRowRef = newColumn;
					}
					*/
				}
				add(blocks);
				
				//bullet explosions
				bulletExplosions = new FlxGroup(bulletExplosionsSize);
				for (var i:int = 0; i < bulletExplosionsSize; i++ ) {
					var newExplosion:BulletExplosion = new BulletExplosion(0, 0);
					newExplosion.exists = false;
					bulletExplosions.add(newExplosion);
				}
				add(bulletExplosions);
				
				//rocket explosions
				rocketExplosions = new FlxGroup(rocketExplosionsSize);
				for (var i:int = 0; i < bulletExplosionsSize; i++ ) {
					var newRocketExplosion:RocketExplosion = new RocketExplosion(0, 0);
					newRocketExplosion.exists = false;
					rocketExplosions.add(newRocketExplosion);
				}
				add(rocketExplosions);
				
				//bullet explosions
				hitBoxes = new FlxGroup(hitBoxesSize);
				for (var i:int = 0; i < hitBoxesSize; i++ ) {
					var newHitBox:HitBox = new HitBox(drawHitBoxes);
					newHitBox.exists = false;
					hitBoxes.add(newHitBox);
				}
				add(hitBoxes);
				
				//spikeballs/active objects
				activeSpikeBalls = new FlxGroup(activeSpikeBallsSize);
				for (var i:int = 0; i < activeSpikeBallsSize; i++) {
					var newSpikeBall:ActiveSpikeBall = new ActiveSpikeBall(0, 0);
					newSpikeBall.exists = false;
					activeSpikeBalls.add(newSpikeBall);
				}
				add(activeSpikeBalls);
				//generateBlockRow();
				//DEBUG
				debugStuff();
				if (_drawDebug) {
					add(debugText);
				}
		}
		
		override public function update():void
		{
			super.update();
			
			processBlocks();
			
			playerBullets.callAll("testYboundary", true);
			
			//collisions
			FlxG.collide(player, _level);
			FlxG.collide(player, blocks);
			FlxG.overlap(playerBullets, blocks, bulletHitBlocks);
			FlxG.overlap(playerBullets, _level, bulletHitLevel);
			FlxG.overlap(hitBoxes, blocks, hitBoxBlockCollide);
			/*
			if (backRowRef.countLiving() > 0) {
				backRowBlock = backRowRef.getFirstAlive() as FlxSprite;
			}
			
			if (frontRowRef.countLiving() > 0) {
				frontRowBlock = frontRowRef.getFirstAlive() as FlxSprite;
			}else {
				var backRowY:Number = backRowBlock.y;
				frontRowRef.kill();
				frontRowRef = blocks.getFirstAlive() as FlxGroup;
				backRowRef = blocks.recycle() as FlxGroup;
				backRowRef.clear();
				backRowRef = generateBlockRow(backRowY - 16);
				add(backRowRef);
				blocks.add(backRowRef);
			}
			if (frontRowBlock.y >= groundLevel) {
				 groundReached = true;
			}
			*/
			if(_drawDebug){
				debugStuff();
			}
		}
		
		public function processBlocks():void {
			//determine when to add a new row of blocks
			//if (currentRow[0].y >= 0) {
				//add new row
				//generateBlockRow();
			//}
			blockMoveCounter += FlxG.elapsed; //timer! the value keeps track of the amount of time passed since the last frame
			if((blockMoveCounter > blockSpeed) && !groundReached){
				moveBlocks();
				blockMoveCounter = 0;
			}
			//stop the blocks
			//if (blocks[0][0].y >= groundLevel) {
			//	stopBlocks();
			//}
		}
		
		public function generateBlockColumn(X:Number):FlxGroup {
			var column:FlxGroup = new FlxGroup(blocksPerColumn);
			
			for (var i:int = 0; i <= blocksPerColumn; i++) {
				var rand:int = FlxG.random() * 100;
				var newblock;
				var blockY:Number;
				
				blockY = 128 - (16 * i);
				
				if(rand <= 3){
					newblock = new BlockBomb(X, blockY);
				}else if(rand <= 20){
					newblock = new BlockSpike(X, blockY);
				}else if(rand <= 21){
					newblock = new BlockLineExplosionHor(X, blockY);
				}else if(rand <= 22){
					newblock = new BlockLineExplosionVer(X, blockY);
				}else {
					newblock = new Block(X, blockY);
				}
				
				newblock.immovable = true;
				column.add(newblock);
			}
			return column;
		}
		
		public function generateBlockRow(Y:Number):FlxGroup {
			var row:FlxGroup = new FlxGroup(blocksPerRow);
			
			for (var i:int = 0; i <= blocksPerRow; i++)
			{
				var rand:int = FlxG.random() * 100;
				var newblock;
				var blockX:Number;
				
				blockX = 32 + 16 * i;
				
				if(rand <= 3){
					newblock = new BlockBomb(blockX, Y);
				}else if(rand <= 20){
					newblock = new BlockSpike(blockX, Y);
				}else if(rand <= 21){
					newblock = new BlockLineExplosionHor(blockX, Y);
				}else if(rand <= 22){
					newblock = new BlockLineExplosionVer(blockX, Y);
				}else{
					newblock = new Block(blockX, Y);
				}
				
				newblock.immovable = true;
				row.add(newblock);
			}
			//set as current row
			//currentRow = row;
			//add the row to the blocks array
			trace("Row generated");
			return row;
		}
		
		public function stopBlocks():void {
			groundReached = true;
		}
		
		public function moveBlocks():void {
			blockMoveCounter--;
			if(blockMoveCounter <= 0){
				blocks.callAll("moveBlock", true);
				blockMoveCounter = blockSpeed;
			}
		}
		
		public function bulletHitBlocks(bullet:PlayerBullet, block:Block) {
			bullet.destroyBullet();
			if (block.y > -16) {
				trace(block.getBlockColor());
				block.killBlock();
			}
		}
		
		public function bulletHitLevel(bullet:PlayerBullet, level:FlxObject) {
			if (bullet.x < blockBoundaryLeft - 4 || bullet.x > blockBoundaryRight + 8) {
				bullet.destroyBullet();
			} 
		}
		
		public function hitBoxBlockCollide(hitbox:HitBox, block:Block) {
			if(block.y > -16){
				block.killBlock();
			}
		}
		
		
		public function debugStuff():void
		{
			var debugString:String = "";
			var yvalue:String = "";
			for (var i = 0; i < blocks.length; i++) {
				if(blocks.members[i].countLiving() > 0){
					yvalue = String(blocks.members[i].getHighestY());
					debugString += String(i) + ": y: " + yvalue + "\n";
				}
			}
			debugText.text = debugString;
		}
	}
}