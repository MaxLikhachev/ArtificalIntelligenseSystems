(defclass song 
    (is-a USER)

    (multislot title)
    (multislot album-name)
    (slot year
    (type NUMBER)
    (storage local)
    (default 2020) 
    (create-accessor read-write) 
    (propagation inherit)
    )

    (slot genre
    (allowed-symbols studio classical jazz rock metal blues pop rap) 
    (storage local)
    (default studio) 
    (create-accessor read-write) 
    (propagation inherit)
    )
)