package  
{
	import org.flixel.*;
	/**
	 * ...
	 * @author Raujinn
	 */
	public class Block extends FlxSprite
	{
		[Embed(source = "assets/images/block.png")] private var ImgBlock:Class;
		[Embed(source = "assets/images/blockred.png")] private var ImgBlockRed:Class;
		[Embed(source = "assets/images/blockcyan.png")] private var ImgBlockCyan:Class;
		[Embed(source = "assets/images/blockturq.png")] private var ImgBlockTurq:Class;
		[Embed(source = "assets/images/blockyellow.png")] private var ImgBlockYellow:Class;
		
		private var blockcolor:int = 0;
		
		public function Block(X:Number, Y:Number, C:int=0) 
		{
			super(X, Y);
			
			var c:int = 0;
			
			if (C != 0){
				c = C;
			}else {
				c = FlxG.random() * 5;
			}
				
			switch(c) {
				case 0:
					loadGraphic(ImgBlock, false);
					break;
				case 1:
					loadGraphic(ImgBlockRed, false);
					break;
				case 2:
					loadGraphic(ImgBlockCyan, false);
					break;
				case 3:
					loadGraphic(ImgBlockTurq, false);
					break;
				case 4: 
					loadGraphic(ImgBlockYellow, false);
					break;
				default:
					loadGraphic(ImgBlock, false);
			}
			
			blockcolor = c;
		}
		
		public function moveBlock():void {
			y += 1;
		}
		
		public function getY():Number {
			return y;
		}
		
		public function killBlock():void {
			kill();
		}
		
		public function getBlockColor():int {
			return blockcolor;
		}
	}
}