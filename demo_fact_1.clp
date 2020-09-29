(deftemplate person "An example deftemplate"
 (multislot name)
 (slot age)
 (slot eye-color)
 (slot hair-color)
)

(deffacts start-facts
  (person (name Ivan Ivanov) (age 23) (eye-color blue) (hair-color brown))
  (person (name Sergey Pentrov) (age 27) (eye-color green) (hair-color black))
)