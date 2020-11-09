; Lab_1
; 36. f(x) = x^2 + 1

(deffunction validate (?value)
    (bind ?result (or (integerp ?value) (floatp ?value)))
    (return ?result)
)

(deffunction f (?x)
    (if (validate ?x)
    then 
        (return (+ (* ?x ?x) 1))
    else
        (printout t "ERROR: NOT VALID ARGUMENT" crlf)
    )
)