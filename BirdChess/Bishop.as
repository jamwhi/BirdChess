package BirdChess
{
	import flash.display.MovieClip;
	
	/**
	 * ...
	 * @author James White
	 */
	public class Bishop extends ChessPiece
	{
		
		public function Bishop(team:int)
		{
			this.team = team;
			// depending on team, create and assign the graphic to this piece
			switch (team)
			{
				case 1:
					graphic = new FlipBishop();
					graphic.x = 0;
					graphic.y = 0;
					
					// set width to 90, and resize height accordingly
					graphic.width = 90 * graphic.width / graphic.height;
					graphic.height = 90;
					this.addChild(graphic);
				break;
				
				case 2:
					graphic = new GreenBishop();
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
				
				
				
				// valid: all squares with the same increased or decreased x and y
				// i.e. x+1 y+1, x+2 y+2, x+3 y+3, etc.
				
				var X:int = xx;
				var Y:int = yy;
				// check down and right
				while (true)
				{
					X++
					Y++
					
					// if we're below the bottom or further right of the board, break out of this 'while'
					if (X >= 8 || Y >= 8)
					{
						break;
					}
					// if this square has a piece in it, break out of this 'while'
					if (squareArray[X][Y].myPiece)
					{
						if (squareArray[X][Y].myPiece.team == team)
						{
							break;
						}
						// but if the piece is not on the same team, add this square before we break
						highlightedSquares.push(squareArray[X][Y]);
						break;
					}
					
					//otherwise add the square and continue the 'while'
					highlightedSquares.push(squareArray[X][Y]);
				}
				
				// check up and right
				X = xx
				Y = yy
				while (true)
				{
					X++
					Y--
					// if we're above the top of the board, break
					if (Y < 0 || X >= 8)
					{
						break;
					}
					// if this square has a piece in it, break
					if (squareArray[X][Y].myPiece)
					{
						if (squareArray[X][Y].myPiece.team == team)
						{
							break;
						}
						// but if the piece is not on the same team, add this square before we break
						highlightedSquares.push(squareArray[X][Y]);
						break;
					}
					
					//otherwise add the square and continue the 'while'
					highlightedSquares.push(squareArray[X][Y]);
				}
				
				// check down and left
				X = xx
				Y = yy
				while (true)
				{
					X--
					Y++
					// if we're past the right of the board, break
					if (X < 0 || Y >= 8)
					{
						break;
					}
					// if this square has a piece in it, break
					if (squareArray[X][Y].myPiece)
					{
						if (squareArray[X][Y].myPiece.team == team)
						{
							break;
						}
						// but if the piece is not on the same team, add this square before we break
						highlightedSquares.push(squareArray[X][Y]);
						break;
					}
					
					//otherwise add the square and continue the 'while'
					highlightedSquares.push(squareArray[X][Y]);
				}
				
				// check up and left
				X = xx
				Y = yy
				while (true)
				{
					X--
					Y--
					// if we're past the left of the board, break
					if (X < 0 || Y < 0)
					{
						break;
					}
					// if this square has a piece in it, break
					if (squareArray[X][Y].myPiece)
					{
						if (squareArray[X][Y].myPiece.team == team)
						{
							break;
						}
						// but if the piece is not on the same team, add this square before we break
						highlightedSquares.push(squareArray[X][Y]);
						break;
					}
					
					//otherwise add the square and continue the 'while'
					highlightedSquares.push(squareArray[X][Y]);
				}
				
				
				
				
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