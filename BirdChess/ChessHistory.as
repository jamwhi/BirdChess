package BirdChess
{
	
	/**
	 * ...
	 * @author James White
	 */
	public class ChessHistory
	{
		private var moveHistory:Array
		
		public function ChessHistory()
		{
			moveHistory = new Array();
		}
		
		public function recordMove(newMove:ChessMove)
		{
			// a move was made - record the move into the moveHistory array
			moveHistory.push(newMove);
			
			trace(newMove.pieceMoved + " was moved from " + newMove.squareFrom.place + " to " + newMove.squareTo.place + ".");
		}
		
		public function backMove(theBoard:ChessBoard)
		{
			// make sure there are moves to take back!
			if (moveHistory.length >= 1)
			{
				var lastMove:ChessMove = moveHistory[moveHistory.length - 1];
				
				if (lastMove.specialMove == 0)
				{
					// reverse the move
					lastMove.pieceMoved.movePiece(lastMove.squareFrom)
					if (lastMove.pieceTaken)
						lastMove.pieceTaken.movePiece(lastMove.squareTo);
					
					// pop this move off the array
					moveHistory.pop();
				}
				else
				{
					// special move code here
					switch (lastMove.specialMove)
					{
						case 1:      // case 1 is a pawn promotion
							lastMove.pieceMoved.parent.removeChild(lastMove.pieceMoved);
							lastMove.pieceTaken.movePiece(lastMove.squareTo);
							moveHistory.pop();
							
							lastMove = moveHistory[moveHistory.length - 1];
							lastMove.pieceMoved.movePiece(lastMove.squareFrom)
							if (lastMove.pieceTaken)
								lastMove.pieceTaken.movePiece(lastMove.squareTo);
								
							moveHistory.pop();
						break;
					}
				}
				
				theBoard.team1turn = !theBoard.team1turn;
			}
		}
		
		public function highlightLastMove()
		{
			// make sure there is a move to highlight
			if (moveHistory.length >= 1)
			{
				var lastMove:ChessMove = moveHistory[moveHistory.length - 1];
				
				if (lastMove.specialMove == 0)
				{
					lastMove.squareFrom.highlight("Red");
					lastMove.squareTo.highlight("Red");
				}
				else
				{
					// special move code here
					lastMove = moveHistory[moveHistory.length - 2];
					lastMove.squareFrom.highlight("Red");
					lastMove.squareTo.highlight("Red");
				}
			}
		}
		
		public function unHighlightLastMove()
		{
			// make sure there is a move to un-highlight
			if (moveHistory.length >= 1)
			{
				var lastMove:ChessMove = moveHistory[moveHistory.length - 1];
				
				if (lastMove.specialMove == 0)
				{
					lastMove.squareFrom.unHighlight()
					lastMove.squareTo.unHighlight()
				}
				else
				{
					// special move code here
					lastMove = moveHistory[moveHistory.length - 2];
					lastMove.squareFrom.unHighlight()
					lastMove.squareTo.unHighlight()
				}
			}
		}
	}
	
}