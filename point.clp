(defclass POINT 
    (is-a USER)
    (role abstract)
)

(defclass POINT-1D 
    (is-a POINT)
    (role concrete)
    (slot x (default 0) (storage local) (access read-write) (propagation inherit) (create-accessor read-write) (visibility public))
)

(defclass POINT-2D 
    (is-a POINT-1D) 
    (role concrete)
    (slot y (default 0) (storage local) (access read-write) (propagation inherit) (create-accessor read-write) (visibility public))
)

(defclass POINT-3D 
    (is-a POINT-2D) 
    (role concrete)
    (slot z (default 0) (storage local) (access read-write) (propagation inherit) (create-accessor read-write) (visibility public))
)

(definstances point-1d-objects 
    (point-1 of POINT-1D) 
    (point-2 of POINT-1D (x 1)) 
    (of POINT-1D (x 2))
)

(definstances point-2d-objects 
    (point-3 of POINT-2D)
    (point-4 of POINT-2D (x 3) (y 4)) 
    (of POINT-2D (x 5) (y 6))
)

(definstances point-3d-objects
    (point-5 of POINT-3D)
    (point-6 of POINT-3D (x 7) (y 8) (z 9)) 
    (of POINT-3D (x 9) (y 10) (z 11))
)

(defmessage-handler POINT-1D print() 
    (printout t "point ( " ?self:x " )" crlf)
)

(defmessage-handler POINT-2D print()
    (printout t "point ( " ?self:x " ; " ?self:y " )" crlf)
)

(defmessage-handler POINT-3D print()
    (printout t "point ( " ?self:x " ; " ?self:y " ; " ?self:z " )" crlf)
)

(defmessage-handler POINT-1D put-value (?x) 
    (bind ?self:x ?x)
)

(defmessage-handler POINT-2D put-value (?x ?y) 
    (bind ?self:x ?x)
    (bind ?self:y ?y)
)

(defmessage-handler POINT-3D put-value (?x ?y ?z) 
    (bind ?self:x ?x)
    (bind ?self:y ?y)
    (bind ?self:z ?z)
)