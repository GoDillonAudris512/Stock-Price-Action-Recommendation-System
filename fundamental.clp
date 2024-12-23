; Ask for investment term value
( defrule ask_investment_term 
    =>
    (printout t crlf "Enter the investment term value: " crlf "0: Short term" crlf "1: Medium term" crlf "2: Long term" crlf "Enter your choice: ")
    (bind ?term (read)) 
    (if (= ?term 0) 
        then (assert (investment_term short))
        else (if (= ?term 1) 
            then (assert (investment_term medium))
            else (assert (investment_term long))
             ) 
    )
)

; Determine fundamental decision for long term investment
(defrule determineFundamentalInLongTerm1
    (and (investment_term long) (financial_statement bad))
    =>
    (assert (fundamental_decision sell))
)

(defrule determineFundamentalInLongTerm2
    (and (investment_term long) (financial_statement good) (or (companyRatioOverall good) (companyRatioOverall neutral)))
    =>
    (assert (fundamental_decision buy))
)

(defrule determineFundamentalInLongTerm3
    (and (investment_term long) (financial_statement good) (companyRatioOverall bad))
    =>
    (assert (fundamental_decision hold))
)

(defrule determineFundamentalInLongTerm4
    (and (investment_term long) (financial_statement neutral) (or (companyRatioOverall good) (companyRatioOverall neutral)))
    =>
    (assert (fundamental_decision hold))
)

(defrule determineFundamentalInLongTerm5
    (and (investment_term long) (financial_statement neutral) (companyRatioOverall bad))
    =>
    (assert (fundamental_decision sell))
)

; Determine fundamental decision for medium term investment
(defrule determineFundamentalInMediumTerm1
    (and (investment_term medium) (companyRatioOverall bad))
    =>
    (assert (fundamental_decision sell))
)

(defrule determineFundamentalInMediumTerm2
    (and (investment_term medium) (or (financial_statement good) (financial_statement neutral)) (companyRatioOverall good))
    =>
    (assert (fundamental_decision buy))
)
(defrule determineFundamentalInMediumTerm3
    (and (investment_term medium) (financial_statement bad) (companyRatioOverall good))
    =>
    (assert (fundamental_decision hold))
)

(defrule determineFundamentalInMediumTerm4
    (and (investment_term medium) (or (financial_statement good) (financial_statement neutral)) (companyRatioOverall neutral))
    =>
    (assert (fundamental_decision hold))
)

(defrule determineFundamentalInMediumTerm5
    (and (investment_term medium) (financial_statement bad) (companyRatioOverall neutral))
    =>
    (assert (fundamental_decision sell))
)

; Determine fundamental decision for short term investment
(defrule determineFundamentalInShortTerm1
    (and (investment_term short) (or (companyRatioOverall good) (companyRatioOverall neutral)) (macroEconomicOverall good))
    =>
    (assert (fundamental_decision buy))
)

(defrule determineFundamentalInShortTerm2
    (and (investment_term short) (or (and (companyRatioOverall bad) (macroEconomicOverall good)) (and (companyRatioOverall good) (macroEconomicOverall bad))))
    =>
    (assert (fundamental_decision hold))
)

(defrule determineFundamentalInShortTerm3
    (and (investment_term short) (or (companyRatioOverall bad) (companyRatioOverall neutral)) (macroEconomicOverall bad))
    =>
    (assert (fundamental_decision sell))
)

; Print fundamental_decision
(defrule declareFundamentalDecisionBuy
    (fundamental_decision buy)
    =>
    (printout t crlf "Fundamental decision: BUY" crlf)
)

(defrule declareFundamentalDecisionHold
    (fundamental_decision hold)
    =>
    (printout t crlf "Fundamental decision: HOLD" crlf)
)

(defrule declareFundamentalDecisionSell
    (fundamental_decision sell)
    =>
    (printout t crlf "Fundamental decision: SELL" crlf)
)