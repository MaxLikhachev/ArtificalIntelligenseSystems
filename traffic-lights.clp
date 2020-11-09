(deftemplate traffic-lights
   (slot value (type SYMBOL) (allowed-symbols red yellow green) (default red))
)

(deftemplate action
   (slot value (type SYMBOL) (allowed-symbols stop wait go) (default stop))
)

(deffunction get-action(?light)
  (bind ?result stop)
  (if(eq ?light yellow)
   then
       (bind ?result wait)
   else
       (if(eq ?light green)
        then
           (bind ?result go)
       )
  )
  (return ?result)
)


(deffacts start-facts
  (traffic-lights)
  (traffic-lights (value yellow))
  (traffic-lights (value green))
)

(defrule action-rule
  ?traffic-lights-address <- (traffic-lights (value ?light))
  =>
  (retract ?traffic-lights-address)
  (bind ?action-value (get-action ?light))
  (assert (action (value ?action-value)))
  (printout t "The traffic lights=" ?light ", action=" ?action-value crlf)   
)