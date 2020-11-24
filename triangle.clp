(defglobal
    ?*eps* = 0.00001
)

(deftemplate coordinates
    (multislot point-a (type NUMBER) (default 0 0))
    (multislot point-b (type NUMBER) (default 0 0))
    (multislot point-c (type NUMBER) (default 0 0))
)

(deftemplate sides
    (slot side-a (type NUMBER) (default 0))
    (slot side-b (type NUMBER) (default 0))
    (slot side-c (type NUMBER) (default 0))
)

(deftemplate type
    (slot value (allowed-symbols undefined oblique isosceles equilateral) (default undefined))
)

(deffunction get-side(?point-a-x ?point-a-y ?point-b-x ?point-b-y)
    (return (sqrt (+ (** (- ?point-b-x ?point-a-x) 2) (** (- ?point-b-y ?point-a-y) 2))))
)

(deffunction equal (?a ?b)
    (bind ?result TRUE)
    (if (> (abs (- ?b ?a)) ?*eps*) then (bind ?result FALSE))
    (return ?result)
)

(deffunction init-fact-type(?side-a ?side-b ?side-c)
    (bind ?equals-counter 0)
    (if (equal ?side-a ?side-b) then (bind ?equals-counter (+ ?equals-counter 1)))
    (if (equal ?side-b ?side-c) then (bind ?equals-counter (+ ?equals-counter 1)))
    (if (equal ?side-a ?side-c) then (bind ?equals-counter (+ ?equals-counter 1)))
    (switch ?equals-counter
        (case 0 then (assert (type (value oblique))))
        (case 1 then (assert (type (value isosceles))))
        (case 3 then (assert (type (value equilateral))))
    )
)

(defrule analyse
    ?triangle <- (coordinates (point-a ?point-a-x ?point-a-y) (point-b ?point-b-x ?point-b-y) (point-c ?point-c-x ?point-c-y))
    =>
    (bind ?side-a (get-side ?point-a-x ?point-a-y ?point-b-x ?point-b-y))
    (bind ?side-b (get-side ?point-a-x ?point-a-y ?point-c-x ?point-c-y))
    (bind ?side-c (get-side ?point-b-x ?point-b-y ?point-c-x ?point-c-y))
    (assert (sides (side-a ?side-a) (side-b ?side-b) (side-c ?side-c)))
    (init-fact-type ?side-a ?side-b ?side-c)
)

(deffacts init-triangles
    (coordinates (point-a 0 0) (point-b 2 4) (point-c 6 0))
    (coordinates (point-a 1 2) (point-b 4 5) (point-c 7 2))
    (coordinates (point-a 0 0) (point-b 3 5.196152) (point-c 6 0))
)
