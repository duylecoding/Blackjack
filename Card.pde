class Card{
// A = 1, 2=2, 3=3, J= 11, K = 13
int card_num;

   Card(int card){
    this.card_num = card;
  
  }
  
 public int getValue(){
    
      switch(card_num){
        case 1:
          return 11;
        case 11:
          return 10;
        case 12:
          return 10;
        case 13:
          return 10;
        default:
        return card_num;
      }
    }
    
  public String getName(){
      switch(card_num){
        case 1:
           return "Ace";
        case 11:
          return "Jack";
        case 12:
          return "Queen";
        case 13:
          return "King";
        default:
        return "" + card_num;
      }
  }
    
  
}