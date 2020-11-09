(defclass SQUARE
      (is-a USER)
      (slot side-length)
)

(defclass RECTANGLE
      (is-a USER)
      (slot height)
      (slot width)
)

(defclass CIRCLE
      (is-a USER)
      (slot radius)
)

(defmessage-handler SQUARE calc-area()
     (* ?self:side-length ?self:side-length)
)
(defmessage-handler RECTANGLE calc-area()
     (* ?self:height ?self:width)
)

(defmessage-handler CIRCLE calc-area()
     (* (pi) ?self:radius ?self:radius)
)

(defclass SUM
      (is-a USER)
      (slot total)
)

(defrule sum-area-rule
     ?figure <- (object (is-a SQUARE|RECTANGLE|CIRCLE))
     ?sum <- (object (is-a SUM))
     =>
     (bind ?figure-area (send ?figure calc-area))
     (bind ?total (send ?sum get-total))
     (send ?sum put-total (+ ?total ?figure-area))
)

(definstances initial-information
    (of SQUARE (side-length 2))
    (of SQUARE (side-length 3))
    (of RECTANGLE (height 5) (width 2))
    (of RECTANGLE (height 1) (width 10))
	(of CIRCLE (radius 2))
    ([sum] of SUM (total 0))
)
