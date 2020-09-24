(deffunction factorialDemo (?n)
    (if (or (not (integerp ?n)) (< ?n 0))
    then
        (printout t "NOT VALID ARGUMENT" crlf)
    else
        (if (= ?n 0)
        then
            1
        else
            (* ?n (factorialDemo (- ?n 1)))
        )
    )
)

(deffunction isPositiveInteger(?value)
    (bind ?result (and (integerp ?value) (>= ?value 0)))
    (return ?result)
)

(deffunction factorial (?n)
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