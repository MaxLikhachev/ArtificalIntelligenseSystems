(deffunction isPalindrome (?str)
    (bind ?result FALSE)
    (if (stringp ?str)
    then
        (bind ?stringLength (str-length ?str))
        (bind ?result TRUE)
        (bind ?middleIndex (+ (div ?stringLength 2) 1))
        (bind ?strBeginIndex 1)
        (bind ?strEndIndex ?stringLength)
        (while (and (< ?strBeginIndex ?middleIndex) ?result) do
            (bind ?leftChar (sub-string ?strBeginIndex ?strBeginIndex ?str))
            (bind ?rightChar (sub-string ?strEndIndex ?strEndIndex ?str))
            (if (= (str-compare ?leftChar ?rightChar) 0)
            then				 
                (bind ?strBeginIndex (+ ?strBeginIndex 1))
                (bind ?strEndIndex (- ?strEndIndex 1))
                else
                (bind ?result FALSE)
            )
        )
    )
    (return ?result)
)