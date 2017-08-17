import java.util.Collections;

class Deck{


  public ArrayList<Card> newDeck(){
   ArrayList<Card> cards = new ArrayList<Card>();
   for(int i = 1; i < 14; i++){
    for(int j = 0; j < 4; j++){
      cards.add(new Card(i));
    } 
   }
   Collections.shuffle(cards);
    return cards;
  }
  
  public ArrayList<Card> alteredDeck(){
   ArrayList<Card> cards = new ArrayList<Card>();
   for(int i = 1; i < 14; i++){
    for(int j = 0; j < 4; j++){
      cards.add(new Card(i));
    } 
   }

   cards.remove(7*4-1);
   cards.remove(1-1);

   Collections.shuffle(cards);
    return cards;

  }
  




}