; LONG TERM

(defrule determineLongTermDecision1
    (investment_term long) 
    (fundamental_decision buy)
    (technical_decision)
    =>
    (assert (final_decision buy))
)

(defrule determineLongTermDecision2
    (investment_term long) 
    (fundamental_decision sell)
    (technical_decision ?decision)
    =>
    (assert (final_decision sell))
)

(defrule determineLongTermDecision3
    (investment_term long) 
    (fundamental_decision hold) 
    (technical_decision buy)
    =>
    (assert (final_decision buy))
)

(defrule determineLongTermDecision4
    (investment_term long) 
    (fundamental_decision hold) 
    (technical_decision hold)
    =>
    (assert (final_decision hold))
)

(defrule determineLongTermDecision5
    (investment_term long) 
    (fundamental_decision hold) 
    (technical_decision sell)
    =>
    (assert (final_decision sell))
)

; MEDIUM TERM

(defrule determineMediumTermDecision1
    (investment_term medium)
    (fundamental_decision sell)
    (technical_decision ?decision)
    =>
    (assert (final_decision sell))
)

(defrule determineMediumTermDecision2
    (investment_term medium)
    (fundamental_decision buy)
    (technical_decision buy)
    =>
    (assert (final_decision buy))
)

(defrule determineMediumTermDecision3
    (investment_term medium)
    (fundamental_decision buy)
    (technical_decision hold)
    =>
    (assert (final_decision buy))
)

(defrule determineMediumTermDecision4
    (investment_term medium)
    (fundamental_decision buy)
    (technical_decision sell)
    =>
    (assert (final_decision hold))
)

(defrule determineMediumTermDecision5
    (investment_term medium)
    (fundamental_decision hold)
    (technical_decision buy)
    =>
    (assert (final_decision buy))
)

(defrule determineMediumTermDecision6
    (investment_term medium)
    (fundamental_decision hold)
    (technical_decision hold)
    =>
    (assert (final_decision hold))
)

(defrule determineMediumTermDecision7
    (investment_term medium)
    (fundamental_decision hold)
    (technical_decision sell)
    =>
    (assert (final_decision sell))
)

; SHORT TERM

(defrule determineShortTermDecision1
    (investment_term short)
    (technical_decision buy)
    =>
    (assert (final_decision buy))
)

(defrule determineShortTermDecision2
    (investment_term short)
    (technical_decision hold)
    =>
    (assert (final_decision hold))
)

(defrule determineShortTermDecision3
    (investment_term short)
    (technical_decision sell)
    =>
    (assert (final_decision sell))
)

(defrule declareDecisionBuy
    (final_decision buy)
    (investment_term ?investment_term)
    (fundamental_decision ?fundamental_decision)
    (technical_decision ?technical_decision)
    =>
    (printout t crlf (str-cat "Investment term: " ?investment_term) crlf)
    (printout t (str-cat "Fundamental decision: " ?fundamental_decision) crlf)
    (printout t (str-cat "Technical decision: " ?technical_decision) crlf)
    (printout t crlf "===================")
    (printout t crlf "Final decision: BUY")
    (printout t crlf "===================" crlf)
)

(defrule declareDecisionHold
    (final_decision hold)
    (investment_term ?investment_term)
    (fundamental_decision ?fundamental_decision)
    (technical_decision ?technical_decision)
    =>
    (printout t crlf (str-cat "Investment term: " ?investment_term) crlf)
    (printout t (str-cat "Fundamental decision: " ?fundamental_decision) crlf)
    (printout t (str-cat "Technical decision: " ?technical_decision) crlf)
    (printout t crlf "===================")
    (printout t crlf "Final decision: HOLD")
    (printout t crlf "===================" crlf)
)

(defrule declareDecisionSell
    (final_decision sell)
    (investment_term ?investment_term)
    (fundamental_decision ?fundamental_decision)
    (technical_decision ?technical_decision)
    =>
    (printout t crlf (str-cat "Investment term: " ?investment_term) crlf)
    (printout t (str-cat "Fundamental decision: " ?fundamental_decision) crlf)
    (printout t (str-cat "Technical decision: " ?technical_decision) crlf)
    (printout t crlf "===================")
    (printout t crlf "Final decision: SELL")
    (printout t crlf "===================" crlf)
)