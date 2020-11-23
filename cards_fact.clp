(defglobal
    ?*total-cards* = 13

    ?*ace-rate* = 4
    ?*king-rate* = 3
    ?*queen-rate* = 2
    ?*jack-rate* = 1

    ?*empty-suit-rate* = 3
    ?*one-suit-rate* = 2
    ?*two-suit-rate* = 1
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

(defrule validate
    (declare (salience 100))
    =>
    (if (neq (length$ (find-all-facts ((?card card)) TRUE)) ?*total-cards*) 
    then  
        (printout t "VALIDATION ERROR: cards less or more than " ?*total-cards* crlf) 
        (halt)
    else (printout t "VALIDATION OK" crlf)
    )
)

(deffunction count-all-by-rank(?rank)
    (return (length$ (find-all-facts ((?card card)) (eq ?card:rank ?rank))))
)

(deffunction count-all-by-suit(?suit)
    (return (length$ (find-all-facts ((?card card)) (eq ?card:suit ?suit))))
)

(deffunction rate-suit(?suit)
    (bind ?rating 0)
    (bind ?count (count-all-by-suit ?suit))
    (switch ?count
        (case 2 then (bind ?rating ?*two-suit-rate*))
        (case 1 then (bind ?rating ?*one-suit-rate*))
        (case 0 then (bind ?rating ?*empty-suit-rate*))
    )
    (return ?rating)
)

(defrule count-all
    =>
    (bind ?rating 0)

    (bind ?rating (+ ?rating (* (count-all-by-rank J) ?*jack-rate*)))
    (bind ?rating (+ ?rating (* (count-all-by-rank Q) ?*queen-rate*)))
    (bind ?rating (+ ?rating (* (count-all-by-rank K) ?*king-rate*)))
    (bind ?rating (+ ?rating (* (count-all-by-rank A) ?*ace-rate*)))

    (bind ?rating (+ ?rating (rate-suit ♦)))
    (bind ?rating (+ ?rating (rate-suit ♥︎)))
    (bind ?rating (+ ?rating (rate-suit ♠︎)))
    (bind ?rating (+ ?rating (rate-suit ♣︎)))

    (printout t "rating: " ?rating crlf)
) 