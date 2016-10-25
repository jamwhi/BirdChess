package BirdChess
{
	import flash.display.MovieClip;
	
	/**
	 * ...
	 * @author James White
	 */
	public class King extends ChessPiece
	{
		
		public function King(team:int)
		{
			this.team = team;
			// depending on team, create and assign the graphic to this piece
			switch (team)
			{
				case 1:
					graphic = new FlipKing();
					graphic.x = 0;
					graphic.y = 0;
					
					// set width to 90, and resize height accordingly
					graphic.width = 90 * graphic.width / graphic.height;
					graphic.height = 90;
					this.addChild(graphic);
				break;
				
				case 2:
					graphic = new GreenKing();
					graphic.x = 0;
					graphic.y = 0;
					
					// set width to whataever, and resize height accordingly
					graphic.width = 80 * graphic.width / graphic.height;
					graphic.height = 80;
					this.addChild(graphic);
				break;
				
			}
			
			defaultWidth = graphic.width
			defaultHeight = graphic.height
		}
		
		private function movable(sq:Square):Boolean
		{
			// returns true if there is a piece in this square and it is not on the same team
			// returns false if it is the same team
			// also returns true if there is no piece
			if (sq.myPiece)
			{
				if (sq.myPiece.team != team)
				{
					return true;
				}
				return false;
			}
			return true;
		}
		
		override public function highlightValidSquares(squareArray:Array, pieceArray:Array):Array
		{
			// create an array to store which squares are valid, and will be highlighted.
			// this is so they can be easily used to determine a valid move, and also to be un-highlighted later.
			var highlightedSquares:Array = new Array();
			
			// make sure this pawn is on a square
			if (currentSquare)
			{
				var xx:int = currentSquare.place.x;
				var yy:int = currentSquare.place.y;
				
				// valid: any adjacent square
				
				var X:int = xx;
				var Y:int = yy;
				
				//////////////////////////////////////////////////////////
				
				// check middle x
				
				// check down
				Y = yy + 1
				if (Y < 8)
				{
					if (movable(squareArray[X][Y]))
					{
						highlightedSquares.push(squareArray[X][Y]);
					}
				}
				Y = yy - 1
				// check up
				if (Y >= 0)
				{
					if (movable(squareArray[X][Y]))
					{
						highlightedSquares.push(squareArray[X][Y]);
					}
				}
				
				//////////////////////////////////////////////////////////
				
				// check right
				X = xx + 1
				if (X < 8)
				{
					// check middle y
					Y = yy
					if (movable(squareArray[X][Y]))
					{
						highlightedSquares.push(squareArray[X][Y]);
					}
					// check down
					Y = yy + 1
					if (Y < 8)
					{
						if (movable(squareArray[X][Y]))
						{
							highlightedSquares.push(squareArray[X][Y]);
						}
					}
					Y = yy - 1
					// check up
					if (Y >= 0)
					{
						if (movable(squareArray[X][Y]))
						{
							highlightedSquares.push(squareArray[X][Y]);
						}
					}
				}
				
				//////////////////////////////////////////////////////////
				
				// check left
				X = xx - 1
				if (X >= 0)
				{
					// check middle y
					Y = yy
					if (movable(squareArray[X][Y]))
					{
						highlightedSquares.push(squareArray[X][Y]);
					}
					// check down
					Y = yy + 1
					if (Y < 8)
					{
						if (movable(squareArray[X][Y]))
						{
							highlightedSquares.push(squareArray[X][Y]);
						}
					}
					Y = yy - 1
					// check up
					if (Y >= 0)
					{
						if (movable(squareArray[X][Y]))
						{
							highlightedSquares.push(squareArray[X][Y]);
						}
					}
				}
				
				//////////////////////////////////////////////////////////
			
				// loop through the newly created square array to highlight them all
				for (var i:int = 0; i < highlightedSquares.length; i++)
				{
					highlightedSquares[i].highlight("Green");
				}
			}
			
			// return the array
			return highlightedSquares;
		}
		
		override public function isValidMove(square:Square):Boolean
		{
			if (square.validMove)
			{
				return true;
			}
			return false;
		}
	}
	
}