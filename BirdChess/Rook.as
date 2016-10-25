package BirdChess
{
	import flash.display.MovieClip;
	
	/**
	 * ...
	 * @author James White
	 */
	public class Rook extends ChessPiece
	{
		
		public function Rook(team:int)
		{
			this.team = team;
			// depending on team, create and assign the graphic to this piece
			switch (team)
			{
				case 1:
					graphic = new FlipRook();
					graphic.x = 0;
					graphic.y = 0;
					
					// set width to 90, and resize height accordingly
					graphic.width = 90 * graphic.width / graphic.height;
					graphic.height = 90;
					this.addChild(graphic);
				break;
				
				case 2:
					graphic = new GreenRook();
					graphic.x = 0;
					graphic.y = 0;
					
					// set width to whataever, and resize height accordingly
					graphic.height = 70 * graphic.height / graphic.width;
					graphic.width = 70;
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
				
				// valid: all squares with the same x, or the same y
				
				var i:int = yy
				// check down
				while (true)
				{
					i++
					// if we're below the bottom of the board, break out of this 'while'
					if (i >= squareArray[xx].length)
					{
						break;
					}
					// if this square has a piece in it, break out of this 'while'
					if (squareArray[xx][i].myPiece)
					{
						if (squareArray[xx][i].myPiece.team == team)
						{
							break;
						}
						// but if the piece is not on the same team, add this square before we break
						highlightedSquares.push(squareArray[xx][i]);
						break;
					}
					
					//otherwise add the square and continue the 'while'
					highlightedSquares.push(squareArray[xx][i]);
				}
				
				// check up
				i = yy
				while (true)
				{
					i--
					// if we're above the top of the board, break
					if (i < 0)
					{
						break;
					}
					// if this square has a piece in it, break
					if (squareArray[xx][i].myPiece)
					{
						if (squareArray[xx][i].myPiece.team == team)
						{
							break;
						}
						// but if the piece is not on the same team, add this square before we break
						highlightedSquares.push(squareArray[xx][i]);
						break;
					}
					
					//otherwise add the square and continue the 'while'
					highlightedSquares.push(squareArray[xx][i]);
				}
				
				// check right
				i = xx;
				while (true)
				{
					i++
					// if we're past the right of the board, break
					if (i >= squareArray.length)
					{
						break;
					}
					// if this square has a piece in it, break
					if (squareArray[i][yy].myPiece)
					{
						if (squareArray[i][yy].myPiece.team == team)
						{
							break;
						}
						// but if the piece is not on the same team, add this square before we break
						highlightedSquares.push(squareArray[i][yy]);
						break;
					}
					
					//otherwise add the square and continue the 'while'
					highlightedSquares.push(squareArray[i][yy]);
				}
				
				// check left
				i = xx;
				while (true)
				{
					i--
					// if we're past the left of the board, break
					if (i < 0)
					{
						break;
					}
					// if this square has a piece in it, break
					if (squareArray[i][yy].myPiece)
					{
						if (squareArray[i][yy].myPiece.team == team)
						{
							break;
						}
						// but if the piece is not on the same team, add this square before we break
						highlightedSquares.push(squareArray[i][yy]);
						break;
					}
					
					//otherwise add the square and continue the 'while'
					highlightedSquares.push(squareArray[i][yy]);
				}
				
				// loop through the newly created square array to highlight them all
				for (i = 0; i < highlightedSquares.length; i++)
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