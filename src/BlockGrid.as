package  
{
	import org.flixel.FlxPoint;
	/**
	 * ...
	 * @author Raujinn
	 */
	public class BlockGrid extends Array 
	{
		
		public function BlockGrid(...rest) 
		{
			super();
			
		}
		
		public function updateGrid():void {
			//calculate the array XY from the block true XY and assign them
			
		}
		
		private function getGridXY(block:Block):FlxPoint {
			return(new FlxPoint(Math.ciel(block.x / 16), Math.ciel(block.y / 16)));
		}
	}

}