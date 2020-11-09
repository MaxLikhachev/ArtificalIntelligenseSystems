(deftemplate in
  (slot object (type SYMBOL) (allowed-symbols robot box))
  (slot location (type SYMBOL) (allowed-symbols room-A room-B))
)

(deftemplate goal
  (slot object (type SYMBOL) (allowed-symbols box)) 
  (slot from (type SYMBOL) (allowed-symbols room-B)) 
  (slot to (type SYMBOL) (allowed-symbols room-A ))
)


(deffacts start-facts
  (in (object robot) (location room-A))
  (in (object box) (location room-B))
  (goal (object box) (from room-B) (to room-A))
)


(defrule move-robot-rule
  (goal (object ?X) (from ?Y))
  (in (object ?X) (location ?Y))
  ?robot-position <- (in (object robot) (location ~?Y))
   =>
  (modify ?robot-position (location ?Y))
)


(defrule move-robot-box-rule
  (goal (object ?X) (from ?Y) (to ?Z))
  ?box-position <- (in (object ?X) (location ?Y))
  ?robot-position <- (in (object robot) (location ?Y))
   =>
  (modify ?robot-position (location ?Z))
  (modify ?box-position (location ?Z))
)


(defrule stop-rule
  (goal (object ?X) (to ?Y))
  (in (object ?X) (location ?Y))
   =>
  (halt)
)
