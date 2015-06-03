package  
{
	import org.flixel.*;
	
	/**
	 * ...
	 * @author Raujinn
	 * This object takes care of managing the blocks in a row
	 * as well as what to do when blocks within the row are destroyed.
	 */
	public class BlockColumn extends FlxGroup 
	{
		
		private var blocksPerColumn = 8;
		private var xpos = 0;
		
		public function BlockColumn(X:Number = 0, MaxSize:uint = 0) 
		{
			super(MaxSize);
			xpos = X;
			initialiseColumn();
		}
		
		override public function update():void {
			super.update();
			
			//check number
			if (countLiving() < blocksPerColumn){
				generateNewBlock();
			}
		}
		
		private function generateNewBlock():void {
			/*
			 * Find the current y of the highest block in this column
			 * then make a new block at -16 of it
			*/
			createBlock(getHighestY() - 16);
		}
		
		private function initialiseColumn():void {
			for (var i:int = 0; i <= blocksPerColumn; i++) {
				createBlock(i * 16);
			}
		}
		
		private function createBlock(Ypos):Block {
			var rand:int = FlxG.random() * 100;
			var newblock:Block;
			var blockY:Number;
			
			var blockY = Ypos;
				
			if(rand <= 3){
				newblock = new BlockBomb(xpos, blockY);
			}else if(rand <= 20){
				newblock = new BlockSpike(xpos, blockY);
			}else if(rand <= 21){
				newblock = new BlockLineExplosionHor(xpos, blockY);
			}else if(rand <= 22){
				newblock = new BlockLineExplosionVer(xpos, blockY);
			}else{
				newblock = new Block(xpos, blockY);
			}
				
			newblock.immovable = true;
			newblock.alive = true;
			add(newblock);
			
			return newblock;
		}
		
		public function getHighestY():Number {
			var highestY = 1024;
			
			for (var i in members) {
				if (members[i].y < highestY) {
					highestY = members[i].y;
				}
			}
			return highestY;
		}
	}

}