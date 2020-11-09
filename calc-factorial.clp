(deffunction is-positive-integer (?value)
   (bind ?result (and (numberp ?value) 
                      (>= ?value 0)))
   (return ?result)
)


(deffunction factorial (?n)
    (bind ?result NONE)
	;проверка параметра ?n, что он является целым положительным числом
    (if (is-positive-integer ?n) 
     then
	      ;вычисление факториала от параметра ?n
          (bind ?result 1)
		  (loop-for-count (?counter 1 ?n) do
		    (bind ?result (* ?result ?counter ))
		  )
    )
    (return ?result)
)

(deffunction demo-factorial (?n)
  (bind ?demo-value (factorial ?n))
  (if(eq ?demo-value NONE)
   then
       (printout t "The factorial of the " ?n " is not defined" crlf)
   else
       (printout t "The factorial of the " ?n " is " ?demo-value crlf)   
  )
)

(deftemplate in
   (slot value (type INTEGER) (range 0 ?VARIABLE) (default 0))
)

(deftemplate out
   (slot in-value (type INTEGER) (range 0 ?VARIABLE) (default 0))
   (slot out-value (type INTEGER) (range 0 ?VARIABLE) (default 0))
)

(deffacts start-facts
  (in )
  (in (value 1))
  (in (value 2))
  (in (value 3))
)

(defrule calc-factorial-rule
  ?in-value-address <- (in (value ?in-value))
  =>
  (bind ?result (factorial ?in-value))
  (retract ?in-value-address)
  (assert (out (in-value ?in-value) (out-value ?result)))
)