(defrule push-value-rule
     ?push-value <- (push-value ?value)
     ?stack <- (stack $?rest)
     =>
    (retract ?push-value ?stack)
    (assert (stack ?value $?rest))
    (printout t "Pushing value " ?value crlf)
)

(defrule pop-value-valid-rule
     ?pop-value <- (pop-value)
     ?stack <- (stack ?value $?rest)
     =>
    (retract ?pop-value ?stack)
    (assert (stack $?rest))
    (printout t "Popping value " ?value crlf)
)

(defrule pop-value-invalid-rule
     ?pop-value <- (pop-value)
     (stack)
     =>
     (retract ?pop-value)
     (printout t "Popping from empty stack" crlf)
)

(deffacts init
   (stack)
   (push-value 1)
   (push-value 2)
   (push-value 3)
)