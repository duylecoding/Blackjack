ArrayList<Card> deck;
int AIRecord = 0;
int ThorpRecord = 0;
int ThorpRecord2 = 0;
int headToHead = 0;
Deck d;

int[] deckCheck = new int[13];

void setup (){
  size(640, 500);
  background(0);
  stroke(255);
  d = new Deck();
  //deck = d.newDeck();
  deck = d.alteredDeck();
 
}

int lastscore = 0;
int game = 0;
int gameCount = 0;
int prevAi = 0;
int prevThorp2 = 0;
int prevThorp = 0;

void draw(){
  
  //println(deck.get(i).get_value(false) +" "+ deck.get(i).card_name()); 
  //headToHead = 0;
  stroke(255);
  //line(0, height/2, width, height/2);
  if(game > width) {
    game = 0;
    background(0);
  }
    playAI();
    playThorp();
    //playThorp2();
       
   if((AIRecord - prevAi) > 0 && (ThorpRecord - prevThorp) < 0)  headToHead++;
   else if((AIRecord - prevAi) < 0 && (ThorpRecord - prevThorp) > 0) headToHead--;
    
    stroke(155,344,156);
    //line(game, (height/2)-lastscore*5, game+1, (height/2)-headToHead*5);
    stroke(255,0,0);
    //line(game, (height/2)-prevAi/10, game+1, (height/2)-AIRecord/10);
    stroke(0,0,255);
   // line(game, (height/2)-prevThorp2/10, game+1, (height/2)-ThorpRecord2/10);
    stroke(0,255,0);
   // line(game, (height/2)-prevThorp/10, game+1, (height/2)-ThorpRecord/10);
    
   // deck = d.newDeck();
   deck = d.alteredDeck();
    //make sure decks are shuffled
    //check(deck.get(0).card_num);
    
    lastscore = headToHead;
    game++;
    gameCount++;
    
    if(gameCount % 1 == 0){
    println("AI: " + (AIRecord));
    println("Thorp: " + (ThorpRecord));
    //println("Thorp2: " + (ThorpRecord2));
    //println("HeadtoHead: " + headToHead);
    println("# of games: " + gameCount);
    println();
    }
    
    prevAi = AIRecord;
    prevThorp2 = ThorpRecord2;
    prevThorp = ThorpRecord;
}

void check(int c){
    deckCheck[c-1] = deckCheck[c-1]+1;
  for(int i = 0; i < deckCheck.length; i++){
   print(deckCheck[i] + "| "); 
  }
  println();
}
  int count = 0;
  int player = 0;
  int dealer = 0;

void playAI(){
  player = 0;
  dealer = 0;
  count = -1;
  boolean canplay = true;
  
  while(canplay){
    dealer = 0;
    player = 0;
    
     if(count < deck.size()-1) count++;
     else break;
     Card d1 = deck.get(count);
     if(count < deck.size()-1) count++;
     else break;
    // Card p1 = deck.get(count);
     Card p1 = new Card(1);
     if(count < deck.size()-1) count++;
     else break;
     Card d2 = deck.get(count);
     if(count < deck.size()-1) count++;
     else break;
     //Card p2 = deck.get(count);
     Card p2 = new Card(7);
     

     dealer += d1.getValue() + d2.getValue();
     player += p1.getValue() + p2.getValue();
     
     //finding aces
     boolean pAce = false;
     if(p1.getValue() == 11 || p2.getValue() == 11) pAce = true;
     boolean dAce = false;
     if(d1.getValue() == 11 || d2.getValue() == 11) dAce = true;
     
     //double aces
     if(dealer == 22) dealer -= 10;
     if(player == 22) player -= 10;
     //instant wins
     if(player == 21 && dealer == 21) continue;
     else if(player == 21){
        AIRecord += 1;
        continue;
     } else if(dealer == 21){
       AIRecord -= 1;
        continue;
     }
     
    // println("D: " + d1.getName()+ " " + d2.getName() + ": " + dealer);
     //println("P: " + p1.getName()+ " " + p2.getName() + ": " + player);
    
     boolean deducted = false;
     for(int i = 0; i < 6; i++){
     if(AIPolicy(player, pAce, d2.getValue())) {
       if(count < deck.size()-1) count++;
       else break;  
       Card c = deck.get(count);
       player += c.getValue(); 
       if(c.getValue() == 11){
         pAce = true;
         deducted = true;  
       }
       if(pAce && player > 21 && !deducted) {
          player -=10; // drawing an ace
          deducted = true;
     }
       //println("Player hits: " + c.getName() + " " + player);

     }
  }

      if(pAce && player > 21) player -= 10;
      int score = evaluate(player, dealer, pAce, dAce);
      AIRecord += score;
      //println("Score: " + score);

     // println("\n");
}
      //println("AIRecord: " + AIRecord);
}

void playThorp(){
  player = 0;
  dealer = 0;
  count = -1;
  boolean canplay = true;
  
  while(canplay){
    dealer = 0;
    player = 0;
    
     if(count < deck.size()-1) count++;
     else break;
     Card d1 = deck.get(count);
     if(count < deck.size()-1) count++;
     else break;
     //Card p1 = deck.get(count);
     Card p1 = new Card(1);
     if(count < deck.size()-1) count++;
     else break;
     Card d2 = deck.get(count);
     if(count < deck.size()-1) count++;
     else break;
     //Card p2 = deck.get(count);
     Card p2 = new Card(7);
     

     dealer += d1.getValue() + d2.getValue();
     player += p1.getValue() + p2.getValue();
     
     //finding aces
     boolean pAce = false;
     if(p1.getValue() == 11 || p2.getValue() == 11) pAce = true;
     boolean dAce = false;
     if(d1.getValue() == 11 || d2.getValue() == 11) dAce = true;
     
     //double aces
     if(dealer == 22) dealer -= 10;
     if(player == 22) player -= 10;
     //instant wins
     if(player == 21 && dealer == 21) continue;
     else if(player == 21){
        ThorpRecord += 1;
        continue;
     } else if(dealer == 21){
       ThorpRecord -= 1;
        continue;
     }
     
    // println("D: " + d1.getName()+ " " + d2.getName() + ": " + dealer);
     //println("P: " + p1.getName()+ " " + p2.getName() + ": " + player);
    
     boolean deducted = false;
     for(int i = 0; i < 6; i++){
     if(ThorpPolicy(player, pAce, d2.getValue())) {
       if(count < deck.size()-1) count++;
       else break;  
       Card c = deck.get(count);
       player += c.getValue(); 
       if(c.getValue() == 11){
         pAce = true;
         deducted = true;  
       }
       if(pAce && player > 21 && !deducted) {
          player -=10; // drawing an ace
          deducted = true;
     }
       //println("Player hits: " + c.getName() + " " + player);

     }
  }

      if(pAce && player > 21) player -= 10;
      int score = evaluate(player, dealer, pAce, dAce);
      ThorpRecord += score;
      //println("Score: " + score);

     // println("\n");
}
      //println("AIRecord: " + AIRecord);
}

void playThorp2(){
  
 
  player = 0;
  dealer = 0;
  count = -1;
  boolean canplay = true;
  
  while(canplay){
    dealer = 0;
    player = 0;
    
     if(count < deck.size()-1) count++;
     else break;
     Card d1 = deck.get(count);
     if(count < deck.size()-1) count++;
     else break;
     Card p1 = deck.get(count);
     if(count < deck.size()-1) count++;
     else break;
     Card d2 = deck.get(count);
     if(count < deck.size()-1) count++;
     else break;
     Card p2 = deck.get(count);
     

     dealer += d1.getValue() + d2.getValue();
     player += p1.getValue() + p2.getValue();
     
     //finding aces
     boolean pAce = false;
     if(p1.getValue() == 11 || p2.getValue() == 11) pAce = true;
     boolean dAce = false;
     if(d1.getValue() == 11 || d2.getValue() == 11) dAce = true;
     
     //double aces
     if(dealer == 22) dealer -= 10;
     if(player == 22) player -= 10;
     if(player == 21 && dealer == 21) continue;
     else if(player == 21){
        ThorpRecord2 += 1;
        continue;
     } else if(dealer == 21){
       ThorpRecord2 -= 1;
        continue;
     }
     
     //println("D: " + d1.getName()+ " " + d2.getName() + ": " + dealer);
    // println("P: " + p1.getName()+ " " + p2.getName() + ": " + player);
    
     boolean deducted = false;
     boolean doubled = false;
     loop:
     for(int i = 0; i < 6; i++){
     int policy = ThorpPolicy2(player, pAce, d2.getValue());
     if(policy == 1 || policy == 2) {
       if(count < deck.size()-1) count++;
       else break;  
       Card c = deck.get(count);
       player += c.getValue(); 
       if(c.getValue() == 11){
         pAce = true;
         deducted = true;  
       }
       if(pAce && player > 21 && !deducted) {
          player -=10; // drawing an ace
          deducted = true;
       }

       //println("Player hits: " + c.getName() + " " + player);
       if(policy == 2){
       doubled = true;
       break loop;
       }
     }
  }
      if(pAce && player > 21) player -= 10;
      int score = evaluate(player, dealer, pAce, dAce);
      
      if(doubled) ThorpRecord2 += 2 * score;
      else ThorpRecord2 += score;
      
      //println("Score: " + score + " " + doubled + "\n");

}
      //println("ThorpRecord: " + ThorpRecord);
}

  boolean AIPolicy(int player, boolean pAce, int dcardval){
    if(player < 11) return true;
    switch(player){
         case 11:
           return true;
         case 12:
           if(pAce) return true;
           else if(dcardval < 4 || dcardval > 6) return true;
         break;
         case 13:
          if(pAce) return true;
          else if(dcardval > 6) return true;
         break;
         case 14:
          if(pAce) return true;
          else if(dcardval > 6) return true;
         break;
         case 15:
          if(pAce) return true;
          else if(dcardval > 6) return true;
         break;
         case 16:
          if(pAce) return true;
          else if(dcardval > 6) return true;
         break;
         case 17:
          if(pAce) return true;
         break;
         case 18:
         if(pAce && dcardval > 8) return true;
         break;
         default:
         return false;
        } 
       
    return false;
  }
  
    boolean ThorpPolicy(int player, boolean pAce, int dcardval){
    if(player < 11) return true;
    switch(player){
         case 11:
           return true;
         case 12:
           if(pAce) return true;
           else if(dcardval < 4 || dcardval > 6) return true;
         break;
         case 13:
          if(pAce) return true;
          else if(dcardval > 6) return true;
         break;
         case 14:
          if(pAce) return true;
          else if(dcardval > 6) return true;
         break;
         case 15:
          if(pAce) return true;
          else if(dcardval > 6) return true;
         break;
         case 16:
          if(pAce) return true;
          else if(dcardval > 6) return true;
         break;
         case 17:
          if(pAce) return true;
         break;
         case 18:
         if(pAce && dcardval > 8 && dcardval < 11) return true;
         break;
         default:
         return false;
        } 
       
    return false;
  }
  
  // 1 == hit, 0 == stand, 2 == double, 3 == split
    int ThorpPolicy2(int player, boolean pAce, int dcardval){
    if(player < 9) return 1;
      switch(player){
         case 9:
           if(dcardval >= 3 && dcardval <= 6 ) return 2;
           else return 1;
         case 10:
           if(dcardval <= 9) return 2;
           else return 1;
         case 11:
           if(dcardval <= 10) return 2;
           else return 1;
         case 12:
           if(pAce) return 1;
           else if(dcardval < 4 || dcardval > 6) return 1;
         break;
         case 13:
          if(pAce && (dcardval == 5 || dcardval == 6)) return 2;
          else if(pAce) return 1;
          else if(dcardval > 6) return 1;
         break;
         case 14:
          if(pAce && (dcardval == 5 || dcardval == 6)) return 2;
          else if(pAce) return 1;
          else if(dcardval > 6) return 1;
         break;
         case 15:
          if(pAce && (dcardval >= 4 && dcardval <= 6)) return 2;
          else if(pAce) return 1;
          else if(dcardval > 6) return 1;
         break;
         case 16:
          if(pAce && (dcardval >= 4 && dcardval <= 6)) return 2;
          else if(pAce) return 1;
          else if(dcardval > 6) return 1;
         break;
         case 17:
          if(pAce && (dcardval >= 3 && dcardval <= 6)) return 2;
          else if(pAce) return 1;
         break;
         case 18:
          if(pAce && (dcardval >= 3 && dcardval <= 6)) return 2;
          else if(pAce && dcardval >= 9) return 1;
          else return 0;
         default:
         return 0;
        } 
       
    return 0;
  }
  
  // win: 1, lose: -1, draw: 0
  int evaluate(int player, int dealer, boolean pAce, boolean dAce){
      if(player > 21) {
        if(pAce) player -= 10;
        else return -1;
      }
      
      boolean deducted = false;
      while(dealer < 17 || dealer == 17 && dAce){
        if(count < deck.size()-1) count++;
        else break;
        Card c = deck.get(count++);
        dealer += c.getValue();
        if(c.getValue() == 11) dAce = true;
        count++;
            if(dealer > 21) {
              if(dAce && !deducted){
              dealer -= 10;
              deducted = true;
            } else return 1;
        }

        //println("dealer hits: " + c.getName() + " " + dealer);
    
      }
      //println("Player: " + player + "vs. Dealer: " + dealer);
      if(player > dealer) return 1;
      if(player == dealer) return 0;
      if(dealer > player) return -1;
      
      //if you get this i messed up earlier ^
      println("check evaluate... you goofed");
      return 9999999;
  }