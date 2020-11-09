(defclass RECTANGLE
      (is-a USER)
	  (role concrete)
      (slot height)
      (slot width)
)

(defmessage-handler RECTANGLE calculate-square-1()
 (* (send ?self get-height) 
    (send ?self get-width))
)

(defmessage-handler RECTANGLE calculate-square-2()
 (bind ?square (* ?self:height ?self:width))
 (return ?square)
)

(defclass SUM
      (is-a USER)
      (role concrete)
	  (slot total (default 0))
	  
)

(deftemplate case
  ;;without-handler, with-get-handler, with-slot
  (slot variant (default without-handler))
)

(definstances initial-information-objects
      (of RECTANGLE (height 5) (width 5))
      (of RECTANGLE (height 7) (width 5))
      (of RECTANGLE (height 6) (width 8))
      (of RECTANGLE (height 2) (width 5))
      (sum of SUM)
)

(deffacts initial-information-facts
   ;;(case (variant with-get-handler))
   (case (variant with-slot))
)

(defrule sum-square-rectangles-rule
   (case (variant without-handler))
   (object (is-a RECTANGLE) (height ?height) (width ?width))
   ?sum <- (object (is-a SUM))
    =>
    (bind ?total (send ?sum get-total))
    (send ?sum put-total (+ ?total (* ?height ?width)))
)

(defrule sum-square-rectangles-rule-1
   (case (variant with-get-handler))
   ?rectangle <- (object (is-a RECTANGLE))
   ?sum <- (object (is-a SUM))
    =>
    (bind ?square (send ?rectangle calculate-square-1))
	(bind ?total (send ?sum get-total))
    (send ?sum put-total (+ ?total ?square))
)


(defrule sum-square-rectangles-rule-2
   (case (variant with-slot))
   ?rectangle <- (object (is-a RECTANGLE))
   ?sum <- (object (is-a SUM))
    =>
    (bind ?square (send ?rectangle calculate-square-2))
	(bind ?total (send ?sum get-total))
    (send ?sum put-total (+ ?total ?square))
)

