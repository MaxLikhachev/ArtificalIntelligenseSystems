(deftemplate emergency (slot type))

(deftemplate response (slot action))

(deffacts initial-facts
    (emergency (type fire))
)

(defrule fire-emergency 
    (emergency (type fire))
    =>
    (assert (response(action activate-sprinkler-system)))
)

(defrule power-outage-emergency 
    (emergency (type power-outage))
    =>
    (assert (response(action turn-on-backup-power)))
)

(defrule flood-emergency 
    (emergency (type flood))
    =>
    (assert (response(action turn-off-electricity)))
)