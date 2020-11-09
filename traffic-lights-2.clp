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


(defrule start-rule
  =>
  (assert (traffic-lights ))
  (assert (traffic-lights (value yellow)))
  (assert (traffic-lights (value green)))
)

(defrule action-rule
  (traffic-lights (value ?light))
  =>
  (bind ?action-value (get-action ?light))
  (assert (action (value ?action-value)))
  (printout t "The traffic lights=" ?light ", action=" ?action-value crlf)   
)
