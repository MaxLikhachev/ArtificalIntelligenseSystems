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

(defclass CARD
    (is-a USER)
    (role concrete)
    (slot suit (type SYMBOL) (allowed-symbols ♦ ♥︎ ♠︎ ♣︎) (visibility private) (create-accessor read-write) (access initialize-only) (storage local))
    (slot rank (type SYMBOL) (allowed-symbols J Q K A) (visibility private) (create-accessor read-write) (access initialize-only) (storage local))
)

(defmessage-handler CARD print()
    (printout t "card: "  ?self:rank ?self:suit crlf)
)

(definstances init-cards
    (card-1 of CARD (suit ♦) (rank A))
    (card-2 of CARD (suit ♥︎) (rank A))
    (card-3 of CARD (suit ♠︎) (rank A))
    (card-4 of CARD (suit ♣︎) (rank A))

    (card-5 of CARD (suit ♦) (rank K))
    (card-6 of CARD (suit ♥︎) (rank K))
    (card-7 of CARD (suit ♠︎) (rank K))
    (card-8 of CARD (suit ♣︎) (rank K))

    (card-9 of CARD (suit ♦) (rank Q))
    (card-10 of CARD (suit ♥︎) (rank Q))
    (card-11 of CARD (suit ♠︎) (rank Q))
    (card-12 of CARD (suit ♣︎) (rank Q))

    (card-13 of CARD (suit ♦) (rank J))
)

(defclass RATING
    (is-a USER)
    (role concrete)
    (slot rating (type INTEGER) (visibility private) (create-accessor read-write) (access read-write) (storage local) (default 0))
)

(defmessage-handler RATING validate()
    (if (neq (length$ (find-all-instances ((?card CARD)) TRUE)) ?*total-cards*) 
    then  
        (printout t "VALIDATION ERROR: cards less or more than " ?*total-cards* crlf) 
        (halt)
    else (printout t "VALIDATION OK" crlf)
    )
)

(defmessage-handler RATING count-all-by-rank(?rank)
    (return (length$ (find-all-instances ((?card CARD)) (eq ?card:rank ?rank))))
)

(defmessage-handler RATING count-all-by-suit(?suit)
    (return (length$ (find-all-instances ((?card CARD)) (eq ?card:suit ?suit))))
)

(defmessage-handler RATING rate-suit(?suit)
    (bind ?rating 0)
    (bind ?count (send ?self count-all-by-suit ?suit))
    (switch ?count
        (case 2 then (bind ?rating ?*two-suit-rate*))
        (case 1 then (bind ?rating ?*one-suit-rate*))
        (case 0 then (bind ?rating ?*empty-suit-rate*))
    )
    (return ?rating)
)

(defmessage-handler RATING init-rating()
    (bind ?rating 0)

    (bind ?rating (+ ?rating (* (send ?self count-all-by-rank J) ?*jack-rate*)))
    (bind ?rating (+ ?rating (* (send ?self count-all-by-rank Q) ?*queen-rate*)))
    (bind ?rating (+ ?rating (* (send ?self count-all-by-rank K) ?*king-rate*)))
    (bind ?rating (+ ?rating (* (send ?self count-all-by-rank A) ?*ace-rate*)))

    (bind ?rating (+ ?rating (send ?self rate-suit ♦)))
    (bind ?rating (+ ?rating (send ?self rate-suit ♥︎)))
    (bind ?rating (+ ?rating (send ?self rate-suit ♠︎)))
    (bind ?rating (+ ?rating (send ?self rate-suit ♣︎)))
    
    (return ?rating)
)


(defmessage-handler RATING init()
    (send ?self validate)
    (bind ?self:rating (send ?self init-rating))
    (send ?self print)
)

(defmessage-handler RATING print()
    (printout t "rating: "  ?self:rating crlf)
)

(defrule init-rule
    =>
    (make-instance rating of RATING)
)