; 1.8. Напишите программу для вычисления стоимости 13 карт, находящихся на руках игрока в бридж, с помощью метода подсчета очков. 
; Тузы стоят 4 очка; 
; короли – 3 очка; 
; дамы – 2 очка;
; валеты – 1 очко. 
; Пустая масть (отсутствие карт одной масти) стоит 3 очка; 
; масть с одной картой (одна карта определенной масти) – 2 очка; 
; масть с двумя картами (две карты определенной масти) – 1 очко.

; Diamonds (Бубны) Hearts (Червы/черви) Spades (Пики) Clubs (Трефы)
; Ace (Туз) King Queen Jack Joker

(defclass CARD
    (is-a USER)
    (role concrete)
    (slot suit (allowed-symbols ♦ ♥︎ ♠︎ ♣︎))
    (multislot rank (allowed-symbols J Q K A)) ; 2 3 4 5 6 7 8 9 10 
)

(defmessage-handler CARD count-card-by-rank()
    (bind ?counter 0)
    (if (= (?self:rank A)) then (bind ?counter 4))
    (if (= (?self:rank Q)) then (bind ?counter 3))
    (if (= (?self:rank K)) then (bind ?counter 2))
    (if (= (?self:rank J)) then (bind ?counter 1))
    (printout t "counter: " ?counter crlf)
    (return ?counter)
)

(defmessage-handler CARD print()
    (printout t "card: "  ?self:rank ?self:suit crlf)
)

(definstances init-cards
    (card-1 of CARD (suit ♦) (rank Q))
)

