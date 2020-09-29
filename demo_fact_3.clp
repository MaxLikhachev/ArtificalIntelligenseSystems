(deftemplate person "An example deftemplate"
 (multislot name (type SYMBOL) (cardinality 1 2))
 (slot age (type INTEGER) (range 0 ?VARIABLE))
 (slot eye-color)
 (slot gender (type SYMBOL) (allowed-symbols male female))
 (slot hair-color)
)

(deffacts start-facts
  (person (name Ivan Ivanov) (age 23) (gender male) (eye-color blue) (hair-color brown))
  (person (name Sergey Pentrov) (age 27) (gender male) (eye-color green) (hair-color black))
)