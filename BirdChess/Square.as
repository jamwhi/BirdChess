package BirdChess
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author James White
	 */
	
	public class Square extends MovieClip 
	{
		private var graphic:Sprite; // the graphic of the square background
		
		private var lastCol:String; // the last colour this square was
		private var currentCol:String; // the current colour of this square
		
		public var place:Point; // where on the chessboard this square is
		public var type:int;
		
		public var validMove:Boolean; // whether this is a valid square to move to for the currently selected piece
		public var myPiece:ChessPiece; // what piece is contained in this square
		
		// constructor
		
		public function Square(type:int, xPos:Number, yPos:Number, j:int, k:int, size:Number = 100) 
		{
			//this.boardRef = boardRef;
			
			graphic = new Sprite(); // initializing the sprite graphic of this square
			this.type = type;
			lastCol = "Neutral";
			currentCol = "Neutral";
			validMove = false;
			
			switch(type)
			{
				case 0: // White
					graphic.graphics.beginFill(0xFFFFFF); // white square
					break;
					
				case 1: // Black
					graphic.graphics.beginFill(0x000000); // black square
					break;
			}
			
			place = new Point(j, k);
			
			// create and draw the square at this place
			this.x = xPos;
			this.y = yPos;
			this.addChild(graphic); // adds the rectangle to the stage
			graphic.graphics.drawRect(-size/2 ,-size/2 , size, size);
			graphic.graphics.endFill();
			
		}
		
		public function placePiece(thePiece:ChessPiece)
		{
			myPiece = thePiece;
			myPiece.x = x;
			myPiece.y = y;
		}
		
		public function losePiece()
		{
			myPiece = null;
		}
		
		public function highlight(col:String = "Grey")
		{
			lastCol = currentCol;
			currentCol = col;
			
			switch (col)
			{
				case "Red":
					graphic.transform.colorTransform = new ColorTransform(0.7, 0.7, 0.7, 1, 100, 0, 0);
				break;
				
				case "Green":
					validMove = true;
					graphic.transform.colorTransform = new ColorTransform(0.7, 0.7, 0.7, 1, 0, 100, 0);
				break;
				
				case "Grey":
				
					switch (type)
					{
						case 0: // White square
							graphic.transform.colorTransform = new ColorTransform(0.7, 0.7, 0.7);
							break;
							
						case 1: // Black square
							graphic.transform.colorTransform = new ColorTransform(1, 1, 1, 1, 80, 80, 80);
							break;
					}
					
				break;
			}
			
		}
		
		public function unHighlight()
		{
			validMove = false;
			
			if (lastCol == "Red" && (currentCol == "Grey" || currentCol == "Green") )
			{
				highlight(lastCol)
			}
			else 
			{
				colourNormal();
			}
		}
		
		private function colourNormal()
		{
			lastCol = "Neutral";
			currentCol = "Neutral";
			graphic.transform.colorTransform = new ColorTransform(1, 1, 1, 1, 0, 0, 0, 0);
		}
	}
	
}