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
		public function Block(X:Number, Y:Number) 
		{
			super(X, Y);
			loadGraphic(ImgBlock, false);
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
	}
}