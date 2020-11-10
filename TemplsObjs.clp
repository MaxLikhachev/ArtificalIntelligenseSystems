(defclass RECTANGLE
      (is-a USER)
      (role concrete)
      (slot height)
      (slot width)
)

(defclass SUM
      (is-a USER)
      (role concrete)
      (slot total (default 0))
)

(definstances initial-information
      (of RECTANGLE (height 5) (width 5))
      (of RECTANGLE (height 7) (width 5))
      (of RECTANGLE (height 6) (width 8))
      (of RECTANGLE (height 2) (width 5))
      (sum of SUM (total 0))
)

(defrule sum-rectangles-rule-2
      (object (is-a RECTANGLE) (height ?height) (width ?width))
      ?sum <- (object (is-a SUM))
      =>
      (bind ?total (send ?sum get-total))
      (send ?sum put-total (+ ?total (* ?height ?width)))
)
