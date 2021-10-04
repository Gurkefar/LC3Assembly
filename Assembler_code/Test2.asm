;Initialize players

.ORIG x3000
LD R0, HUNDRED
LEA R1, Player1
ADD R1, R1, #10
STR R0, R1, #0

LEA R1, Player1
ADD R1, R1, #10
STR R0, R1, #0

LEA R1, Player2
ADD R1, R1, #10
STR R0, R1, #0

LEA R1, Player3
ADD R1, R1, #10
STR R0, R1, #0

LEA R1, Player4
ADD R1, R1, #10
STR R0, R1, #0

LEA R1, Player5
ADD R1, R1, #10
STR R0, R1, #0

BR Step1

ASCII .FILL #0
End .FILL #0
PARTICIPANTSASCII .FILL #0
End1 .FILL #0
MINUS48 .FILL #-48
HUNDRED .FILL #100

Newline .STRINGZ "\n"


Step1 LEA R0, Welcome
PUTS
GETC
ST R0, ASCII
ST R0, PARTICIPANTSASCII
LEA R0, ASCII
PUTS
LEA R0, NewLine
PUTS
LD R1, ASCII
LD R2, MINUS48
ADD R1, R2, R1
ST R1, PARTICIPANTS

LEA R0, PROMPTNAME
PUTS
BR step2


Player1 .BLKW 21
e1 .FILL #0
Player2 .BLKW 21
e2 .FILL #0

Player3 .BLKW 21
e3 .FILL #0

Player4 .BLKW 21
e4 .FILL #0

Player5 .BLKW 21
e5 .FILL #0



PARTICIPANTS .FILL #0

Player1PTR .FILL Player1

step2  LD R3, Player1PTR ; Starting address for first player
       BR Step3

Step3 AND R7, R7, #0
LD R6, PARTICIPANTSASCII

LOOP      LEA R0, Player
          PUTS
          LEA R0, PARTICIPANTSASCII
          PUTS
          LEA R0, NewLine
          PUTS
          AND R4, R4, #0 ;R4 = pointer for player names in memory
          LD R5, TWENTYTWO
          ADD R4, R4, R5
INPUT     GETC
          ST R0, ASCII
          ADD R7, R0, #-10 ;Enter has ascii value 10
          BRz NEWPLAYER
          STR R0, R3 , #0
          ADD R3, R3, #1 ; move pointer
          ADD R4, R4, #-1
          LEA R0, ASCII
          PUTS ; output typed char
          BR INPUT
NEWPLAYER LEA R0, NewLine
          PUTS
          ADD R6, R6, #-1 ; decrement ASCII value of number of players
          ADD R1, R1, #-1 ; R1 contains number of participants
          BRZ PLAYERBET
          ST R6, PARTICIPANTSASCII ; Update ascii value, so new player can input name
          ADD R3, R3, R4
          BR LOOP
     
PLAYER .STRINGZ "Player "

PROMPTNAME .STRINGZ "Please enter your names\n"    

PLAYERBET  LEA R3, Player1 ; Starting address for first player to print when prompted for bet
           LD R4, PARTICIPANTS
           AND R5, R5, #0
           AND R6, R6, #0
           BR START

TWENTYTWO .FILL #22
Welcome .STRINGZ "Welcome to Priapus' Wheel of Fortune, how many participants are gonna play the game?\n"        

; R1 = number of participants
; R2 = pointer to players name in memory
; R3 contains bet for current player

; R6 = temporary data register
; R5 = temporary data register
START       LEA R0, STARTGAME
            PUTS
            BR BEFORETURN
      
BEFORETURN  LD R1, PARTICIPANTS ; number of participants
            LD R2, Player1Ptr2 ; starting adress for first player
            BR TURN
           
Player1Ptr2 .FILL Player1         

STARTGAME .STRINGZ "The game can now start, all players will start with 100$\n"


TOGGLE .STRINGZ "Toggle switches to place your bet (rightmost for 10$ - leftmost for 80$) and press leftmost button\n"
TURNPROMPT .STRINGZ "It is your turn "    
Newline1 .STRINGZ "\n"

TURN        ADD R1, R1, #0
            BRz ROUNDOVER
            LEA R0, TURNPROMPT
            PUTS
            AND R0, R0, #0
            ADD R0, R0, R2
            PUTS
            LEA R0, Newline1
            PUTS
            BR BET
     


NEXTPLAYER  LD R5, TWENTY2
            ADD R2, R2, R5 ; Move pointer to next player
            ADD R1, R1, #-1 ; Participants = Participants - 1
            BR TURN

ROUNDOVER   LEA R0, ENDGAMEPROMPT ; end game or continue?
            PUTS
            LD R3, ROUNDCOUNTER
            AND R4, R4, #0
            ADD R4, R3, #1 ; increment round counter
            ST R4, ROUNDCOUNTER ; store in memory
BEFORENEXTROUND1 LDI R0, BUTTONS1
                 AND R5, R5, #0
                 ADD R5, R0, #-2
                 BRz ENDGAME
                 AND R5, R5, #0
                 ADD R5, R0, #-4
                 BRz BEFORETURN
                 BR BEFORENEXTROUND1 ; wait for input

ENDGAME JSR STOPGAME
        HALT

ENDGAMEPROMPT .STRINGZ "Round is over - press button nr. 2 to end game, or nr. 3 to play another round\n"
TWENTY2 .FILL #22

ROUNDCOUNTER .FILL #1
SSEG2 .FILL xFE12
     
BET LEA R0, BETOPTIONS
    PUTS
    LEA R0, OPTIONS
    PUTS
    LEA R0, TOGGLE
    PUTS
WAIT LDI R0, BUTTONS1     
     ADD R0, R0, #-8
     BRz DisplayBet
     BR WAIT
     
BUTTONS1 .FILL xFE0F
BETOPTIONS .STRINGZ "Your betting options are:\n"  
OPTIONS .STRINGZ "10$\n20$\n40$\n80$\n"

SAVER1PTR .FILL SAVER1
SAVER2PTR .FILL SAVER2

CONTINUETONEXTPLAYER    LDI R1, SAVER1PTR
                        LDI R2, SAVER2PTR
                        BR Nextplayer


SpinModePrompt .STRINGZ "Press button nr. 2 for normal spin - nr. 3 for turbo mode\n\n"

MASK1PTR .FILL MASK1
MASK2PTR .FILL MASK2
MASK3PTR .FILL MASK3

LIMIT1PTR .FILL LIMIT1
LIMIT2PTR .FILL LIMIT2
LIMIT3PTR .FILL LIMIT3

NORMALSPIN1 .FILL #240
NORMALSPIN2 .FILL #3840
NORMALSPIN3 .FILL #61440

TURBOSPIN1 .FILL #15
TURBOSPIN2 .FILL #3840
TURBOSPIN3 .FILL #61440

MTENTHOUSAND .FILL #-10000
MTHOUSAND .FILL #-1000
MHUNDRED .FILL #-100
MTEN .FILL #-10

SpinModePrompt1 .STRINGZ "Hold and release button nr. 1 to start spin\n\n"

SpinWheel  ST R1, SAVER1
           ST R2, SAVER2
           LEA R0, SpinModePrompt
           PUTS
SpinWheel1 LDI R0, BUTTONS1
           AND R1, R1, #0
           ADD R1, R0, #-2
           BRz NORMALSPIN
           
           AND R1, R1, #0
           ADD R1, R0, #-4
           BRz TURBOSPIN
           BR SpinWheel1
           
           ;BR PlaceBet

NORMALSPIN LEA R0, SpinModePrompt1
           PUTS
           
           LD R0, MTHOUSAND
           STI R0, LIMIT1PTR
           
           LD R0, MHUNDRED
           STI R0, LIMIT2PTR
           
           LD R0, MTEN
           STI R0, LIMIT3PTR
           
           LD R0, NORMALSPIN1
           STI R0, MASK1PTR
           
           LD R0, NORMALSPIN2
           STI R0, MASK2PTR
           
           LD R0, NORMALSPIN3
           STI R0, MASK3PTR
           BR PlaceBet
           
TURBOSPIN  LEA R0, SpinModePrompt1
           PUTS
           
           LD R0, MTENTHOUSAND
           STI R0, LIMIT1PTR
           
           LD R0, MHUNDRED
           STI R0, LIMIT2PTR
           
           LD R0, MTEN
           STI R0, LIMIT3PTR
           
           LD R0, TURBOSPIN1
           STI R0, MASK1PTR
           
           LD R0, TURBOSPIN2
           STI R0, MASK2PTR
           
           LD R0, TURBOSPIN3
           STI R0, MASK3PTR
           BR PlaceBet           
           
           
 



DisplayBet    LDI R3, SWITCHES1 ; Switches data register
              AND R5, R5, #0
              ADD R5, R3, #-1
              BRz first
              AND R5, R5, #0
              ADD R5, R3, #-2
              BRz second
              AND R5, R5, #0
              ADD R5, R3, #-4
              BRz third
              AND R5, R5, #0
              ADD R5, R3, #-8
              BRz fourth

MINUS32 .FILL #-32

CURRENTBET .BLKW 1


SAVER1 .BLKW 1
SAVER2 .BLKW 1


; Before next Player
HOP14  LD R1, SAVER1
       LD R2, SAVER2
       
       
       AND R4, R4, #0
       ADD R2, R2, #10
       LDR R4, R2, #0
       
       AND R5, R5, #0
       ADD R5, R4, R0 ; R5 conatins current balance for player 
       STR R5, R2, #0 ; save current balance of player
       
       LD R3, ROUNDCOUNTER
       AND R4, R4, #0 
       ADD R4, R2, R3
       STR R0, R4, #0 ; Save betting history - R0 contains current earnings/losings
       
       LD R2, SAVER2
       
       LEA R0, BEFORENEXTTURN
       PUTS
       
BEFORENEXTROUND LDI R0, BUTTONS1
       
       AND R4, R4, #0
       ADD R4, R0, #-8
       BRz DISPLAYBALANCE
       AND R4, R4, #0
       ADD R4, R0, #-1
       BRz CONTINUETONEXTPLAYER
       
       BR BEFORENEXTROUND
DISPLAYBALANCE  STI R5, SSEG1
                LDI R0, BUTTONS1
                AND R4, R4, #0
                ADD R4, R0, #-1
                BRz CONTINUETONEXTPLAYER
                
                BR DISPLAYBALANCE
                

       


CURRENTEARNINGS .BLKW 1
EOL .FILL #0

BEFORENEXTTURN .STRINGZ "\n\nPress leftmost button to see balance or rightmost to continue\n\n"

HOP13 BR HOP14

SSEG1 .FILL xFE12
FourtyEight .FILL #48
ASCII1
SWITCHES1 .FILL xFE0B

first LD R5, #10
    ST R5, CURRENTBET
    LEA R0, BET10
    PUTS
    BR SpinWheel
BET10 .STRINGZ "You have bet 10$\n"    
second LD R5, #20
    ST R5, CURRENTBET
    LEA R0, BET20
    PUTS
    BR SpinWheel
BET20 .STRINGZ "You have bet 20$\n"    
third LD R5, #40
    ST R5, CURRENTBET
    LEA R0, BET40
    PUTS
    BR SpinWheel
BET40 .STRINGZ "You have bet 40$\n"    
fourth LD R5, #80
    ST R5, CURRENTBET
    LEA R0, BET80
    PUTS
    BR SpinWheel
BET80 .STRINGZ "You have bet 80$\n"    



PLACEBET LDI R0, SWITCHES
         
         AND R1, R1, #0  
         ADD R1, R0, #-1
         BRz BETTEN
         
         AND R1, R1, #0
         ADD R1, R0, #-2
         BRz BETTWENTY
         AND R1, R1, #0
         ADD R1, R0, #-4
         BRz BETFOURTY
         AND R1, R1, #0
         ADD R1, R0, #-8
         BRz BETEIGHTY
         BR PLACEBET


;ten      LEA R5, ARRAY10
 ;        LDI R0, BUTTONS
  ;       ADD R0, R0, #-1
   ;      BRz SPIN
    ;     BRnp ten
    
BETTEN LEA R5, ARRAY10
       BR OFFSET

BETTWENTY LEA R5, ARRAY20
          BR OFFSET

BETFOURTY LEA R5, ARRAY40
          BR OFFSET

BETEIGHTY LEA R5, ARRAY80
          BR OFFSET


OFFSET   LDI R0, BUTTONS
         ADD R0, R0, #-1
         BRz spinInitial
         BRnp OFFSET
spinInitial  LDR R0, R2, #0
             ST R0, PROFIT
             LDI R0, BUTTONS
             ADD R0, R0, #0
             BRz SPIN
             LDR R1, R5, #0
             STI R1, SSEG
             JSR StartOver
             ADD R5, R5, #1
             BR spinInitial
             
StartOver    AND R0, R0, #0
             NOT R0, R5
             ADD R0, R0, #1
          
             AND R1, R1, #0
             LEA R2, END10
             ADD R1, R0, R2
             BRz LOADTEN
          
             AND R1, R1, #0
             LEA R2, END20
             ADD R1, R0, R2
             BRz LOADTWENTY
          
             AND R1, R1, #0
             LEA R2, END40
             ADD R1, R0, R2
             BRz LOADFOURTY
          
             AND R1, R1, #0
             LEA R2, END80
             ADD R1, R0, R2
             BRz LOADEIGHTY
          
             RET



LOADTEN LEA R5, ARRAY10
        RET

LOADTWENTY LEA R5, ARRAY20
          RET

LOADFOURTY LEA R5, ARRAY40
          RET

LOADEIGHTY LEA R5, ARRAY80
          RET


ARRAY10 .FILL #-10
        .FILL #20
        .FILL #-10
        .FILL #5
        .FILL #-5
        .FILL #5
        .FILL #-10
        .FILL #10
        .FILL #-5
        .FILL #10
        .FILL #-10
        .FILL #5
        .FILL #-5
        .FILL #5
        .FILL #-5
END10   .FILL #0     
     
     
ARRAY20 .FILL #-20
        .FILL #40
        .FILL #-20
        .FILL #10
        .FILL #-10
        .FILL #10
        .FILL #-20
        .FILL #20
        .FILL #-10
        .FILL #20
        .FILL #-20
        .FILL #10
        .FILL #-10
        .FILL #10
        .FILL #-10
END20   .FILL #0


ARRAY40 .FILL #-40
        .FILL #80
        .FILL #-40
        .FILL #20
        .FILL #0
        .FILL #20
        .FILL #-40
        .FILL #40
        .FILL #-20
        .FILL #40
        .FILL #-40
        .FILL #20
        .FILL #-20
        .FILL #20
        .FILL #-20
END40   .FILL #0

ARRAY80 .FILL #-80
        .FILL #160
        .FILL #-80
        .FILL #-40
        .FILL #-40
        .FILL #40
        .FILL #-80
        .FILL #80
        .FILL #-40
        .FILL #80
        .FILL #-80
        .FILL #40
        .FILL #-40
        .FILL #40
        .FILL #-40
END80   .FILL #0

SPIN	BR SPINFAST


	
HOP12 BR HOP13

SPINFAST ADD R4, R4, #1
	     AND R0, R0, #0
	     LD R1, LIMIT1
	     ADD R0, R4, R1
	     BRz SPINMEDIUM
	     
	     
	     JSR StartOver
	      
	     LDR R0, R5, #0
	     ST R0, PROFIT
	     STI R0, SSEG
	     ADD R5, R5, #1
	     
	     LDI R0, TIKCOUNTER
	     LD R1, MASK1
	     AND R0, R0, R1
SPINFASTLOOP AND R3, R3, #0
		     LDI R2, TIKCOUNTER
	     	 AND R3, R2, R1
	         NOT R3, R3
	         ADD R3, R3, #1
		     AND R2, R2, #0
		     ADD R2, R3, R0
		     BRz SPINFASTLOOP
		     BRnp SPINFAST

SPINMEDIUM  AND R4, R4, #0
	        BR Next

Next	   ADD R4, R4, #1
	       AND R0, R0, #0
	       LD R1, LIMIT2 
	       ADD R0, R4, R1
	       BRz SPINSLOW
	       
	       JSR StartOver
	       
	       LDR R0, R5, #0
	       ST R0, PROFIT
	       STI R0, SSEG
	       ADD R5, R5, #1
	       
	       LDI R0, TIKCOUNTER
	       LD R1, MASK2
	       AND R0, R0, R1
SPINMEDIUMLOOP 	AND R3, R3, #0
	    	    LDI R2, TIKCOUNTER
	     	    AND R3, R2, R1
	            NOT R3, R3
	            ADD R3, R3, #1
		        AND R2, R2, #0
	     	    ADD R2, R3, R0
		        BRz SPINMEDIUMLOOP 
		        BRnp Next

SPINSLOW   AND R4, R4, #0
	       BR Next1

Next1	   ADD R4, R4, #1
	       AND R0, R0, #0
	       LD R1, LIMIT3 
	       ADD R0, R4, R1
	       BRz DONE
	       
	       JSR StartOver
	       
	       LDR R0, R5, #0
	       ST R0, PROFIT
	       STI R0, SSEG
	       ADD R5, R5, #1
	       
	       LDI R0, TIKCOUNTER
	       LD R1, MASK3
	       AND R0, R0, R1
SPINSLOWLOOP 	AND R3, R3, #0
		        LDI R2, TIKCOUNTER
	     	    AND R3, R2, R1
	            NOT R3, R3
	            ADD R3, R3, #1
		        AND R2, R2, #0
		        ADD R2, R3, R0
		        BRz SPINSLOWLOOP 
		        BRnp Next1
         
         
SWITCHES .FILL xFE0B
BUTTONS .FILL xFE0F
SSEG .FILL xFE12
PROFIT .BLKW 1

LIMIT1 .BLKW 1 ;MINUS5THOUSAND .FILL #-1000
LIMIT2 .BLKW 1 ;MINUSHUNDRED .FILL #-100
LIMIT3 .BLKW 1;MINUSTEN .FILL #-10

MASK1 .BLKW 1 ; mask = 0000000011110000
MASK2 .BLKW 1 ; mask = 0000111100000000
MASK3 .BLKW 1 ; 1111000000000000



MAX .FILL #-30000
TIKCOUNTER .FILL xFE18

PLAYER1PTR1 .FILL PLAYER1
PLAYER2PTR .FILL PLAYER2
PLAYER3PTR .FILL PLAYER3
PLAYER4PTR .FILL PLAYER4
PLAYER5PTR .FILL PLAYER5

STOPGAME LD R0, ENDOFGAMEPROMPTPTR
         PUTS
LOADPLAYER LDI R0, SWITCHES5
           ST R0, CURRENTPLAYER
           AND R1, R1, #0
           ADD R1, R0, #-1
           BRz LOADPLAYER1
           AND R1, R1, #0
           ADD R1, R0, #-2
           BRz LOADPLAYER2          
           AND R1, R1, #0
           ADD R1, R0, #-4
           BRz LOADPLAYER3
           AND R1, R1, #0
           ADD R1, R0, #-8
           BRz LOADPLAYER4
           AND R1, R1, #0
           ADD R1, R0, #-16
           BRz LOADPLAYER5
           BR LOADPLAYER
           
LOADPLAYER1 LD R0, PLAYER1PTR1
            JSR DISPLAYENDBALANCE
            
LOADPLAYER2 LD R0, PLAYER2PTR
            JSR DISPLAYENDBALANCE
            

LOADPLAYER3 LD R0, PLAYER3PTR
            JSR DISPLAYENDBALANCE

LOADPLAYER4 LD R0, PLAYER4PTR
            JSR DISPLAYENDBALANCE

LOADPLAYER5 LD R0, PLAYER5PTR
            JSR DISPLAYENDBALANCE


DISPLAYENDBALANCE AND R1, R1, #0
                  ADD R1, R0, #10
                  LDR R2, R1, #0
                  STI R2, SSEG
                  PUTS
                  LEA R0, BALANCE
                  PUTS
                  LEA R0, NEWLINE4
                  PUTS
                  BR RETURN

RETURN  LD R0, CURRENTPLAYER
        LDI R1, SWITCHES5
        AND R2, R2, #0
        NOT R2, R0
        ADD R2, R2, #1
        AND R0, R0, #0
        ADD R0, R2, R1
        BRnp LOADPLAYER
        BR RETURN                  
               
               
CURRENTPLAYER .BLKW 1

ENDOFGAMEPROMPTPTR .FILL ENDOFGAMEPROMPT
NEWLINE4 .STRINGZ "\n"
BALANCE .STRINGZ " balance"

PARTICIANTSPTR .FILL PARTICIPANTS


SWITCHES5 .FILL xFE0A

DONE1 BR HOP12       

DONE LD R0, PROFIT
     
     AND R1, R1, #0
     ADD R1, R0, #10
     BRz LOSTTEN
     BR Hop
     
     LOSTTEN LEA R0, LOSTTENS
             PUTS
             LD R0, MINUSTENNUMBER
             BR DONE1
    LOSTTENS .STRINGZ "You have lost 10$\n"
    MINUSTENNUMBER .FILL #-10 
     
Hop  AND R1, R1, #0
     LD R2, MINUSTWENTY
     ADD R1, R0, R2
     BRz EARNEDTWENTY
     BR Hop1
     
     EARNEDTWENTY LEA R0, EARNEDTWENTYS
             PUTS
             LD R0, TWENTYNUMBER
             BR DONE1
    EARNEDTWENTYS .STRINGZ "You have won 20$\n"
    MINUSTWENTY .FILL #-20 
    TWENTYNUMBER .FILL #20

     
Hop1 AND R1, R1, #0
     ADD R1, R0, #-5
     BRz EARNEDFIVE
     BR Hop2
     
     EARNEDFIVE LEA R0, EARNEDFIVES
           PUTS
           LD R0, #5
           BR DONE1
     EARNEDFIVES .STRINGZ "You have won 5$\n"
     
FIVE .FILL #5     
     
Hop2 AND R1, R1, #0
     ADD R1, R0, #5
     BRz LOSTFIVE
     BR Hop3
     
     LOSTFIVE LEA R0, LOSTFIVES
        PUTS
        LD R0, MINUSFIVE
        BR DONE1
    LOSTFIVES .STRINGZ "You have lost 5$\n"

MINUSFIVE .FILL #-5
     
Hop3     AND R1, R1, #0
     ADD R1, R0, #-10
     BRz EARNEDTEN
     BR Hop4
     
     EARNEDTEN LEA R0, EARNEDTENS
          PUTS
          LD R0, TEN
          BR DONE1
     EARNEDTENS .STRINGZ "You have won 10$\n"
TEN .FILL #10
     
Hop4     AND R1, R1, #0
     ADD R1, R0, #0
     BRz BREAKEVEN
     BR Hop5
     
     BREAKEVEN LEA R0, BREAKEVENS
           PUTS
           LD R0, #0
           BR DONE1
     BREAKEVENS .STRINGZ "You break even\n"

Hop5     AND R1, R1, #0
     LD R2, TWENTY
     ADD R1, R0, R2
     BRz LOSTTWENTY
     BR Hop6
     
     
     LOSTTWENTY LEA R0, LOSTTWENTYS
                PUTS
                LD R0, MINUSTWENTY
                BR DONE1
     LOSTTWENTYS .STRINGZ "You have lost 20$\n"

Hop6     AND R1, R1, #0
     LD R2, MINUSFOURTY
     ADD R1, R0, R2
     BRz EARNEDFOURTY
     BR Hop7
    
    EARNEDFOURTY LEA R0, EARNEDFOURTYS
             PUTS
             LD R0, FOURTY
             BR DONE1
    EARNEDFOURTYS .STRINGZ "You have won 40$\n"

Hop7    AND R1, R1, #0
    LD R2, FOURTY
    ADD R1, R0, R2
    BRz LOSTFOURTY
    BR Hop8
    
    LOSTFOURTY LEA R0, LOSTFOURTYS
               PUTS
               LD R0, MINUSFOURTY
               BR DONE1
    LOSTFOURTYS .STRINGZ "You have lost 40$\n"
    
Hop8    AND R1, R1, #0
    LD R2, MINUSEIGHTY
    ADD R1, R0, R2
    BRz EARNEDEIGHTY
    BR Hop9


HOP11 BR DONE1

    
    EARNEDEIGHTY LEA R0, EARNEDEIGHTYS
                 PUTS
                 LD R0, EIGHTY
                 BR DONE1
    EARNEDEIGHTYS .STRINGZ "You have won 80$\n"
    
Hop9    AND R1, R1, #0
    LD R2, EIGHTY
    ADD R1, R0, R2
    BRz LOSTEIGHTY
    BR Hop10

    
    LOSTEIGHTY LEA R0, LOSTEIGHTYS
               PUTS
               LD R0, MINUSEIGHTY
               BR HOP11
    LOSTEIGHTYS .STRINGZ "You have lost 80$\n"
    
Hop10    AND R1, R1, #0
    LD R2, MINUSHUNDREDSIXTY
    ADD R1, R0, R2
    BRz EARNEDHUNDREDSIXTY
    
    EARNEDHUNDREDSIXTY LEA R0, EARNEDHUNDREDSIXTYS
                       PUTS
                       LD R0, HUNDREDSIXTY
                       BR HOP11
    EARNEDHUNDREDSIXTYS .STRINGZ "You have won 160$\n"




ZERO .FILL #0
TWENTY .FILL #20
MINUSFOURTY .FILL #-40
FOURTY .FILL #40
MINUSEIGHTY .FILL #-80
EIGHTY .FILL #80
MINUSHUNDREDSIXTY .FILL #-160
HUNDREDSIXTY .FILL #160


ENDOFGAMEPROMPT .STRINGZ "You have now reached the end of the game. \nYou can view the current balance of any player by toggling switches 1-5 (player 1-5)\nand determine amongst yourselves who the real winner is :)\n"













.END