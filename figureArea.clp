(deffunction isPositiveNumber(?value)
    (bind ?result (and (numberp ?value) (> ?value 0)))
    (return ?result)
)

(deffunction circleArea (?radius)
    (bind ?result NONE)
    (if (isPositiveNumber ?radius)
    then
        (bind ?result (* (pi) ?radius ?radius))
    )
    (return ?result)
)

(deffunction rectangleArea (?side1 ?side2)
    (bind ?result NONE)
    (if (and(isPositiveNumber ?side1) (isPositiveNumber ?side2))
    then 
        (bind ?result (* ?side1 ?side2))
    )
    (return ?result)
)

(deffunction squareArea (?side)
    (bind ?result NONE)
    (if (isPositiveNumber ?side)
    then 
        (bind ?result (** ?side 2))
    )
    (return ?result)
)

(deffunction squareArea2 (?side)
    (bind ?result (rectangleArea ?side ?side))
    (return ?result)
)

; type: cicrle, rectangle, square
(deffunction figureArea (?type $?values)
    (bind ?result NONE)
    (if (and (eq circle ?type) (= 1 (length$ ?values)))
    then
        (bind ?radius (nth$ 1 $?values))
        (bind ?result (circleArea ?radius))
    else
        (if (and (eq rectangle ?type) (= 2 (length$ ?values)))
        then
            (bind ?side1 (nth$ 1 $?values))
            (bind ?side2 (nth$ 2 $?values))
            (bind ?result (rectangleArea ?side1 ?side2))
        else
            (if (and (eq square ?type) (= 1 (length $?values)))
            then 
                (bind ?side (nth$ 1 $?values))
                (bind ?result (squareArea ?side))
            )
        )
    )
    (return ?result)
)
