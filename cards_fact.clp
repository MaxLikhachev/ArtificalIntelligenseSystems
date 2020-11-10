; 1.8. Напишите программу для вычисления стоимости 13 карт, находящихся на руках игрока в бридж, с помощью метода подсчета очков. 
; Тузы стоят 4 очка; 
; короли – 3 очка; 
; дамы – 2 очка;
; валеты – 1 очко. 
; Пустая масть (отсутствие карт одной масти) стоит 3 очка; 
; масть с одной картой (одна карта определенной масти) – 2 очка; 
; масть с двумя картами (две карты определенной масти) – 1 очко.

(defglobal
    ?*ace-rate* = 4
    ?*king-rate* = 3
    ?*queen-rate* = 2
    ?*jack-rate* = 1

    ?*empty-suit-rate* = 3
    ?*one-suit-rate* = 2
    ?*two-suit-rate* = 1

    ?*diamonds-count* = 0
    ?*hearts-count* = 0
    ?*spades-count* = 0
    ?*clubs-count* = 0

    ?*rating* = 0
)

(deftemplate card
    (slot suit (type SYMBOL) (allowed-symbols ♦ ♥︎ ♠︎ ♣︎))
    (slot rank (type SYMBOL) (allowed-symbols J Q K A)) 
)

(deffacts init-facts
    (card (suit ♦) (rank A))
    (card (suit ♥︎) (rank A))
    (card (suit ♠︎) (rank A))
    (card (suit ♣︎) (rank A))

    (card (suit ♦) (rank K))
    (card (suit ♥︎) (rank K))
    (card (suit ♠︎) (rank K))
    (card (suit ♣︎) (rank K))

    (card (suit ♦) (rank Q))
    (card (suit ♥︎) (rank Q))
    (card (suit ♠︎) (rank Q))
    (card (suit ♣︎) (rank Q))

    (card (suit ♦) (rank J))
)

(defrule diamonds-find-and-count-rule
    ?diamonds-address <- (card (suit ♦) (rank ?))
    =>
    (printout t "found diamonds card" crlf)
    (bind ?*diamonds-count* (+ ?*diamonds-count* 1))
)

(defrule hearts-find-and-count-rule
    ?hearts-address <- (card (suit ♥︎) (rank ?))
    =>
    (printout t "found hearts card" crlf)
    (bind ?*hearts-count* (+ ?*hearts-count* 1))
)

(defrule spades-find-and-count-rule
    ?spades-address <- (card (suit ♠︎) (rank ?))
    =>
    (printout t "found spades card" crlf)
    (bind ?*spades-count* (+ ?*spades-count* 1))
)

(defrule clubs-find-and-count-rule
    ?club-address <- (card (suit ♣︎) (rank ?))
    =>
    (printout t "found clubs card" crlf)
    (bind ?*clubs-count* (+ ?*clubs-count* 1))
)

(defrule ace-find-and-rate-rule
    ?ace-address <- (card (suit ?) (rank A))
    =>
    (printout t "found ace card" crlf)
    (bind ?*rating* (+ ?*rating* ?*ace-rate*))
)

(defrule king-find-and-rate-rule
    ?king-address <- (card (suit ?) (rank K))
    =>
    (printout t "found king card" crlf)
    (bind ?*rating* (+ ?*rating* ?*king-rate*))
)

(defrule queen-find-and-rate-rule
    ?queen-address <- (card (suit ?) (rank Q))
    =>
    (printout t "found queen card" crlf)
    (bind ?*rating* (+ ?*rating* ?*queen-rate*))
)

(defrule jack-find-and-rate-rule
    ?jack-address <- (card (suit ?) (rank J))
    =>
    (printout t "found jack card" crlf)
    (bind ?*rating* (+ ?*rating* ?*jack-rate*))
)

(defrule diamonds-rate-rule
    =>
    (printout t "total diamonds cards: " ?*diamonds-count* crlf)
    (if (= ?*diamonds-count* 2) then (bind ?*rating* (+ ?*rating* ?*two-suit-rate*)))
    (if (= ?*diamonds-count* 1) then (bind ?*rating* (+ ?*rating* ?*one-suit-rate*)))
    (if (= ?*diamonds-count* 0) then (bind ?*rating* (+ ?*rating* ?*empty-suit-rate*)))
)

(defrule hearts-rate-rule
    =>
    (printout t "total hearts cards: " ?*hearts-count* crlf)
    (if (= ?*hearts-count* 2) then (bind ?*rating* (+ ?*rating* ?*two-suit-rate*)))
    (if (= ?*hearts-count* 1) then (bind ?*rating* (+ ?*rating* ?*one-suit-rate*)))
    (if (= ?*hearts-count* 0) then (bind ?*rating* (+ ?*rating* ?*empty-suit-rate*)))
)

(defrule spades-rate-rule
    =>
    (printout t "total spades cards: " ?*spades-count* crlf)
    (if (= ?*spades-count* 2) then (bind ?*rating* (+ ?*rating* ?*two-suit-rate*)))
    (if (= ?*spades-count* 1) then (bind ?*rating* (+ ?*rating* ?*one-suit-rate*)))
    (if (= ?*spades-count* 0) then (bind ?*rating* (+ ?*rating* ?*empty-suit-rate*)))
)

(defrule clubs-rate-rule
    =>
    (printout t "total clubs cards: " ?*clubs-count* crlf)    
    (if (= ?*clubs-count* 2) then (bind ?*rating* (+ ?*rating* ?*two-suit-rate*)))
    (if (= ?*clubs-count* 1) then (bind ?*rating* (+ ?*rating* ?*one-suit-rate*)))
    (if (= ?*clubs-count* 0) then (bind ?*rating* (+ ?*rating* ?*empty-suit-rate*)))
)

(defrule init-rule
    =>
    (printout t "rating: " ?*rating* crlf)
)
