(deffunction factorialRecursive (?n)
    (if (or (not (integerp ?n)) (< ?n 0))
    then
        (printout t "NOT VALID ARGUMENT" crlf)
    else
        (if (= ?n 0)
        then
            1
        else
            (* ?n (factorialRecursive (- ?n 1)))
        )
    )
)

(deffunction isPositiveInteger(?value)
    (bind ?result (and (integerp ?value) (>= ?value 0)))
    (return ?result)
)

(deffunction factorialNonRecursive (?n)
    (bind ?result NONE)
    (if (isPositiveInteger ?n) 
     then
        (bind ?result 1)
		(loop-for-count (?counter 1 ?n) do
		    (bind ?result (* ?result ?counter ))
		)
    )
    (return ?result)
)

;f(x, y) = {
;(x-y)! + (x+y)!, если x>y>0;
;(y-x)! + (x+y)!, если y=>x>0

(deffunction function(?x ?y)
    (bind ?f NONE)
    (if (and (> ?x 0) (> ?y 0))
    then
        (bind ?f (factorialNonRecursive (+ ?x ?y)))
        (if (> ?x ?y)
        then
            (bind ?f (+ ?f (factorialNonRecursive (- ?x ?y))))
        else
            (bind ?f (+ ?f (factorialNonRecursive (- ?y ?x))))
        )
    else
        (printout t "NOT VALID ARGUMENTS" crlf)
    )
)