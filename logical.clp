(deftemplate person
    (slot name (type SYMBOL))
    (slot education (type SYMBOL)) 
)

(assert (education junior))

(defrule logical-rule 
    (logical (person (education junior)) (education junior))
    => 
    (assert (result true))
)

(assert (person (name Ivan) (education junior)))
(modify 2 (education middle))