(defclass CATEGORY
   (is-a USER)
   (role concrete)
   (slot kind)
   (multislot materials)
)

(defclass A
   (is-a CATEGORY)
)

(defclass B
   (is-a CATEGORY)
)

(defclass C
   (is-a CATEGORY)
)

(defclass D
   (is-a CATEGORY)
)

(defmessage-handler CATEGORY contains-material(?material)
   (bind ?index (member$ ?material (send ?self get-materials)))
   (return (numberp ?index))
)

(defmessage-handler CATEGORY action()
   (printout t "Actions during the fire materials: " (send ?self get-materials) " of category " (send ?self get-kind) crlf)
)

(defmessage-handler B action after()
   (printout t "Additional actions of category " (send ?self get-kind) crlf)
)


(definstances initial-information-objects
  (a of A (kind A) (materials a1 a2 a3))
  (b of B (kind B) (materials b1 b2 b3 b4))
  (c of C (kind C) (materials c1 c2))
  (d of D (kind D) (materials d1))
)

(deffacts initial-information-facts
  (material a3)
  (material b2)
)

(defrule fire-action-rule
   (material ?material)
   ?category <- (object (is-a A|B|C|D))
   (test (eq (send ?category contains-material ?material) TRUE))
    =>
   (send ?category action)
)