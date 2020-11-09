(deftemplate figure
    (slot type)
    (slot side)
    (slot side2)
)
(deftemplate responce (slot solutions))

(deffunction is-positive-number(?value)
    (bind ?result (and (numberp ?value) (> ?value 0)))
    (return ?result)
)

(deffunction circle-area (?radius)
    (bind ?result NONE)
    (if (is-positive-number ?radius)
    then
        (bind ?result (* (pi) ?radius ?radius))
    )
    (return ?result)
)

(deffunction rectangle-area (?side1 ?side2)
    (bind ?result NONE)
    (if (and(is-positive-number ?side1) (is-positive-number ?side2))
    then 
        (bind ?result (* ?side1 ?side2))
    )
    (return ?result)
)

(deffunction square-area (?side)
    (bind ?result NONE)
    (if (is-positive-number ?side)
    then 
        (bind ?result (** ?side 2))
    )
    (return ?result)
)

(deffunction square-area2 (?side)
    (bind ?result (rectangle-area ?side ?side))
    (return ?result)
)

(defrule square
    ?figure-address <- (figure (type square) (side ?value))
    =>
    (bind ?result (square-area ?value))
    (retract ?figure-address)
    (assert (responce (solutions ?result)))
    (printout t "Square area: " ?result crlf)
)

(defrule circle
    ?figure-address <- (figure (type circle) (side ?value))
    =>
    (bind ?result (circle-area ?value))
    (retract ?figure-address)
    (assert (responce (solutions ?result)))
    (printout t "Circle area: " ?result crlf)
)

(defrule rectangle
    ?figure-address <- (figure (type rectangle) (side ?value) (side2 ?value2))
    =>
    (bind ?result (rectangle-area ?value  ?value2))
    (retract ?figure-address)
    (assert (responce (solutions ?result)))
    (printout t "Rectangle area: " ?result crlf)
)

; type: cicrle, rectangle, square
(deffunction figure-area (?type $?values)
    (bind ?result NONE)
    (if (and (eq circle ?type) (= 1 (length$ ?values)))
    then
        (bind ?radius (nth$ 1 $?values))
        (bind ?result (circle-area ?radius))
    else
        (if (and (eq rectangle ?type) (= 2 (length$ ?values)))
        then
            (bind ?side1 (nth$ 1 $?values))
            (bind ?side2 (nth$ 2 $?values))
            (bind ?result (rectangle-area ?side1 ?side2))
        else
            (if (and (eq square ?type) (= 1 (length $?values)))
            then 
                (bind ?side (nth$ 1 $?values))
                (bind ?result (square-area ?side))
            )
        )
    )
    (return ?result)
)
