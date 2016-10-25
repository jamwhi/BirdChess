package BirdChess
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author James White
	 */
	public class PawnPromote extends MovieClip
	{
		private var theBoard:ChessBoard;
		private var thePiece:ChessPiece;
		
		public function PawnPromote(board:ChessBoard, piece:ChessPiece)
		{
			theBoard = board;
			thePiece = piece;
			
			var pic:MovieClip;
			
			pic = new PromotePawn();
			this.addChild(pic);
			
			switch (piece.team)
			{
				case 1: // flip
					pic = new FlipRook();
					pic.x = -150;
					pic.y = 0;
					// set width to 90, and resize height accordingly
					pic.width = 90 * pic.width / pic.height;
					pic.height = 90;
					this.addChild(pic);
					pic.addEventListener(MouseEvent.CLICK, clickRook);
					
					pic = new FlipKnight();
					pic.x = -50;
					// set width to 90, and resize height accordingly
					pic.height = 90 * pic.height / pic.width;
					pic.width = 90;
					this.addChild(pic);
					pic.addEventListener(MouseEvent.CLICK, clickKnight);
					
					pic = new FlipBishop();
					pic.x = 50;
					// set width to 90, and resize height accordingly
					pic.width = 90 * pic.width / pic.height;
					pic.height = 90;
					this.addChild(pic);
					pic.addEventListener(MouseEvent.CLICK, clickBishop);
					
					pic = new FlipQueen();
					pic.x = 150;
					// set width to 90, and resize height accordingly
					pic.width = 90 * pic.width / pic.height;
					pic.height = 90;
					this.addChild(pic);
					pic.addEventListener(MouseEvent.CLICK, clickQueen);
				break;
				
				case 2: // green
					pic = new GreenRook();
					pic.x = -150;
					pic.y = 0;
					// set width to whataever, and resize height accordingly
					pic.height = 70 * pic.height / pic.width;
					pic.width = 70;
					this.addChild(pic);
					pic.addEventListener(MouseEvent.CLICK, clickRook);
					
					pic = new GreenKnight();
					pic.x = -50;
					// set width to whataever, and resize height accordingly
					pic.width = 80 * pic.width / pic.height;
					pic.height = 80;
					this.addChild(pic);
					pic.addEventListener(MouseEvent.CLICK, clickKnight);
					
					pic = new GreenBishop();
					pic.x = 50;
					// set width to whataever, and resize height accordingly
					pic.width = 80 * pic.width / pic.height;
					pic.height = 80;
					this.addChild(pic);
					pic.addEventListener(MouseEvent.CLICK, clickBishop);
					
					pic = new GreenQueen();
					pic.x = 150;
					// set width to whataever, and resize height accordingly
					pic.width = 80 * pic.width / pic.height;
					pic.height = 80;
					this.addChild(pic);
					pic.addEventListener(MouseEvent.CLICK, clickQueen);
				break;
			}
		}
		
		private function clickRook(e:MouseEvent) : void
		{
			var newPiece:Rook = Rook(theBoard.createRookAtSquare(new Square( -1, -50, -50, 10, 10), thePiece.team));
			thePiece.currentSquare.validMove = true;
			theBoard.movePieceToSquare(newPiece, thePiece.currentSquare, 1);
			this.parent.removeChild(this);
		}
		private function clickKnight(e:MouseEvent) : void
		{
			var newPiece:Knight = Knight(theBoard.createKnightAtSquare(new Square( -1, -50, -50, 10, 10), thePiece.team));
			thePiece.currentSquare.validMove = true;
			theBoard.movePieceToSquare(newPiece, thePiece.currentSquare, 1);
			this.parent.removeChild(this);
		}
		private function clickBishop(e:MouseEvent) : void
		{
			var newPiece:Bishop = Bishop(theBoard.createBishopAtSquare(new Square( -1, -50, -50, 10, 10), thePiece.team));
			thePiece.currentSquare.validMove = true;
			theBoard.movePieceToSquare(newPiece, thePiece.currentSquare, 1);
			this.parent.removeChild(this);
		}
		private function clickQueen(e:MouseEvent) : void
		{
			var newPiece:Queen = Queen(theBoard.createQueenAtSquare(new Square( -1, -50, -50, 10, 10), thePiece.team));
			thePiece.currentSquare.validMove = true;
			theBoard.movePieceToSquare(newPiece, thePiece.currentSquare, 1);
			this.parent.removeChild(this);
		}
	}
	
}