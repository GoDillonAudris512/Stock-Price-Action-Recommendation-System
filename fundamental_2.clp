; Company Ratio Assessment
( defrule assessCompanyRatio =>
    (printout t crlf "Assessing Company Ratio...")

    ; Assess Valuation Ratios
    (printout t crlf "Is Valuation ratios data exist?" crlf "0: no" crlf "1: yes" crlf "Enter your choice: ")
    (bind ?valuationDataExist (read))
    ( if (= ?valuationDataExist 1)
        then
            ; Assess Solvency Ratios
            (printout t crlf "Is Solvency ratios data exist?" crlf "0: no" crlf "1: yes" crlf "Enter your choice: ")
            (bind ?solvencyDataExist (read))
            ( if (= ?solvencyDataExist 1)
                then
                    ; Assess Dividend 
                    (printout t crlf "Is Dividend data exist?" crlf "0: no" crlf "1: yes" crlf "Enter your choice: ")
                    (bind ?dividendDataExist (read))
                    ( if (= ?dividendDataExist 1)
                        then
                            (assert (dividendAssessment yes))
                        else
                            (assert (dividendAssessment no))
                            (assert (dividendOverall nil))
                    )
                    (assert (solvencyRatiosAssessment yes))
                else
                    ; Assess Dividend 
                    (printout t crlf "Is Dividend data exist?" crlf "0: no" crlf "1: yes" crlf "Enter your choice: ")
                    (bind ?dividendDataExist (read))
                    ( if (= ?dividendDataExist 1)
                        then
                            (assert (dividendAssessment yes))
                        else
                            (assert (dividendAssessment no))
                            (assert (dividendOverall nil))
                    )
                    (assert (solvencyRatiosAssessment no))
                    (assert (solvencyRatiosOverall nil))
            )

            (assert (valuationRatiosAssessment yes))
        else
            ; Assess Solvency Ratios
            (printout t crlf "Is Solvency ratios data exist?" crlf "0: no" crlf "1: yes" crlf "Enter your choice: ")
            (bind ?solvencyDataExist (read))
            ( if (= ?solvencyDataExist 1)
                then
                    ; Assess Dividend 
                    (printout t crlf "Is Dividend data exist?" crlf "0: no" crlf "1: yes" crlf "Enter your choice: ")
                    (bind ?dividendDataExist (read))
                    ( if (= ?dividendDataExist 1)
                        then
                            (assert (dividendAssessment yes))
                        else
                            (assert (dividendAssessment no))
                            (assert (dividendOverall nil))
                    )
                    (assert (solvencyRatiosAssessment yes))
                else
                    ; Assess Dividend 
                    (printout t crlf "Is Dividend data exist?" crlf "0: no" crlf "1: yes" crlf "Enter your choice: ")
                    (bind ?dividendDataExist (read))
                    ( if (= ?dividendDataExist 1)
                        then
                            (assert (dividendAssessment yes))
                        else
                            (assert (dividendAssessment no))
                            (assert (dividendOverall nil))
                    )
                    (assert (solvencyRatiosAssessment no))
                    (assert (solvencyRatiosOverall nil))
            )
            (assert (valuationRatiosAssessment no))
            (assert (valuationRatiosOverall nil))
    )
)

(defrule companyRatioOverallAssessment
   ;; Ensure required facts exist
   (valuationRatiosOverall ?valuation)
   (solvencyRatiosOverall ?solvency)
   (dividendOverall ?dividend)
   =>
   (printout t crlf "Assessing Company Ratios Overall...")

   ;; Assess Company Ratios Overall
   (if (or (and (eq ?valuation good) (eq ?solvency good)) ;; Valuation and Solvency Ratios good
           (and (eq ?valuation good) (eq ?solvency nil)) ;; Valuation good, no Solvency
           (and (eq ?valuation nil) (eq ?solvency good)) ;; No Valuation, Solvency good
           (and (eq ?valuation nil) (eq ?solvency nil) (eq ?dividend good))) ;; No Valuation, no Solvency, Dividend good
      then
      (assert (companyRatioOverall good))
      (printout t crlf "Company Ratios Overall Assessment Completed. Result: Good" crlf))

   (if (or (eq ?solvency bad) ;; Solvency bad
           (and (eq ?valuation bad) (eq ?solvency nil)) ;; Valuation bad, no Solvency
           (and (eq ?valuation nil) (eq ?solvency nil) (eq ?dividend bad))) ;; No Valuation, no Solvency, Dividend bad
      then
      (assert (companyRatioOverall bad))
      (printout t crlf "Company Ratios Overall Assessment Completed. Result: Bad" crlf))

   (if (or (and (eq ?valuation bad) (eq ?solvency good)) ;; Valuation bad, Solvency good
           (and (eq ?valuation nil) (eq ?solvency nil) (eq ?dividend nil))) ;; No Valuation, Solvency bad
      then
      (assert (companyRatioOverall neutral))
      (printout t crlf "Company Ratios Overall Assessment Completed. Result: Neutral" crlf)))



; Valuation Ratios Assessment
( defrule valuationRatiosAssessment (valuationRatiosAssessment yes) =>
    (printout t crlf "Assessing Valuation Ratios...")

    ; Assess Price to Earnings Ratio
    (printout t crlf "Is Price to Earnings Ratio (PER) <= 15? " crlf "0: no" crlf "1: yes" crlf "2: no information" crlf "Enter your choice: ")
    (bind ?per (read))

    ; Assess Price to Book Value Ratio
    (printout t crlf "Is Price to Book Value Ratio (PBV) <= 1.0? " crlf "0: no" crlf "1: yes" crlf "2: no information" crlf "Enter your choice: ")
    (bind ?pbv (read))

    ; Assess Valuation Ratios Overall
    (if (or (and (= ?per 1) (>= ?pbv 0)) ; PER ≤ 15, any PBV
           (and (>= ?per 0) (= ?pbv 1))) ; Any PER, PBV ≤ 1
      then
      (assert (valuationRatiosOverall good))
      (printout t crlf "Valuation Ratios Assessment Completed. Result: Good" crlf)
    )

    (if (or (and (= ?per 0) (= ?pbv 2)) ; PER > 15, no PBV information
        (and (= ?per 2) (= ?pbv 0)) ; no PER information, PBV > 1
        (and (= ?per 0) (= ?pbv 0))) ; PER > 15, PBV > 1
      then
      (assert (valuationRatiosOverall bad))
      (printout t crlf "Valuation Ratios Assessment Completed. Result: Bad" crlf)
    )

    (if (and (= ?per 2) (= ?pbv 2)) ; no PER information, no PBV information
      then
      (assert (valuationRatiosOverall nil))
      (printout t crlf "Valuation Ratios Assessment Completed. Result: No Information" crlf)
    )

)

; Solvency Ratios Assessment
( defrule solvencyRatiosAssessment (solvencyRatiosAssessment yes) =>
    (printout t crlf "Assessing Solvency Ratios...")

    ; Assess Quick Ratio
    (printout t crlf "Is Quick Ratio >= 1.0? " crlf "0: no" crlf "1: yes" crlf "2: no information" crlf "Enter your choice: ")
    (bind ?qr (read))

    ; Assess Debt to Equity Ratio
    (printout t crlf "Is Debt to Equity Ratio <= 1.0? " crlf "0: no" crlf "1: yes" crlf "2: no information" crlf "Enter your choice: ")
    (bind ?der (read))

    ; Assess Solvency Ratios Overall
    (if (or (and (= ?qr 1) (= ?der 1)) ; QR ≥ 1, DER ≤ 1
            (and (= ?qr 2) (= ?der 1)) ; no QR information, DER ≤ 1
            (and (= ?qr 1) (= ?der 2))) ; QR ≥ 1, no DER information
        then
        (assert (solvencyRatiosOverall good))
        (printout t crlf "Solvency Ratios Assessment Completed. Result: Good" crlf)
    )

    (if (or (and (= ?qr 0) (>= ?der 0)) ; QR < 1, any DER
            (and (>= ?qr 0) (= ?der 0))) ; Any QR, DER > 1
        then
        (assert (solvencyRatiosOverall bad))
        (printout t crlf "Solvency Ratios Assessment Completed. Result: Bad" crlf)
    ) 

    (if (and (= ?qr 2) (= ?der 2)) ; no QR information, no DER information
        then
        (assert (solvencyRatiosOverall nil))
        (printout t crlf "Solvency Ratios Assessment Completed. Result: No Information" crlf)
    )
)

; Dividend Assessment
( defrule dividendAssessment (dividendAssessment yes) =>
    (printout t crlf "Assessing Dividend...")
    (printout t crlf "Is Dividend Yield >= 3.0%? " crlf "0: no" crlf "1: yes" crlf "2: no information" crlf "Enter your choice: ")
    (bind ?dy (read))

    (printout t crlf "Is 35% <= Dividend Payout Ratio <= 50%? " crlf "0: no" crlf "1: yes" crlf "2: no information" crlf "Enter your choice: ")
    (bind ?dpr (read))

    ; Assess Dividend Overall
    (if (or (and (= ?dy 1) (>= ?dpr 0)) ; DY ≥ 3%, any DPR
            (and (= ?dy 2) (= ?dpr 1))) ; no DY information, 35% ≤ DPR ≤ 50%
           
        then
        (assert (dividendOverall good))
        (printout t crlf "Dividend Assessment Completed. Result: Good" crlf)
    )

    (if (or (and (= ?dy 0) (>= ?dpr 0)) ; DY < 3%, any DPR
            (and (= ?dy 2) (= ?dpr 0))) ; no DY information, DPR < 35% or > 50%
        then
        (assert (dividendOverall bad))
        (printout t crlf "Dividend Assessment Completed. Result: Bad" crlf)
    )

    (if (and (= ?dy 2) (= ?dpr 2)) ; no DY information, no DPR information
        then
        (assert (dividendOverall nil))
        (printout t crlf "Dividend Assessment Completed. Result: No Information" crlf)
    )
)


; Macro Economic Assessment
( defrule assessMacroEconomic =>
    (printout t crlf "Assessing Macro Economic...")

    ; Assess Interest Rate
    (printout t crlf "Is Interest Rate Raise? " crlf "0: no" crlf "1: yes" crlf "2: no information" crlf "Enter your choice: ") 
    (bind ?interestRaise (read))
    
    ; Assess Regulatory Environment
    (printout t crlf "Is Regulatory Environment Favorable? " crlf "0: no" crlf "1: yes" crlf "2: no information" crlf "Enter your choice: ")
    (bind ?regulatoryFavorable (read))

    ; Assess Buying Power
    (printout t crlf "Is Buying Power Increase? " crlf "0: no" crlf "1: yes" crlf "2: no information" crlf "Enter your choice: ")
    (bind ?buyingPowerIncrease (read))

    ; Assess Macro Economic Overall
    (if (or (and (= ?regulatoryFavorable 1) (= ?interestRaise 0) (>= ?buyingPowerIncrease 0)) ; Regulatory Environment favorable, Interest Rate not raise, any Buying Power
            (and (= ?regulatoryFavorable 1) (= ?interestRaise 2) (>= ?buyingPowerIncrease 0)) ; Regulatory Environment favorable, no Interest Rate information, any Buying Power
            (and (= ?regulatoryFavorable 2) (= ?interestRaise 0) (>= ?buyingPowerIncrease 0)) ; no Regulatory Environment information, Interest Rate not raise, any Buying Power
            (and (= ?regulatoryFavorable 2) (= ?interestRaise 2) (= ?buyingPowerIncrease 1)) ; no Regulatory Environment information, no Interest Rate information, Buying Power increase
            (and (= ?regulatoryFavorable 2) (= ?interestRaise 2) (= ?buyingPowerIncrease 2))) ; no Regulatory Environment information, no Interest Rate information, no Buying Power information
        then
        (assert (macroEconomicOverall good))
        (printout t crlf "Macro Economic Assessment Completed. Result: Good" crlf)
    )

    (if (or (and (= ?regulatoryFavorable 0) (>= ?interestRaise 0) (>= ?buyingPowerIncrease 0)) ; Regulatory Environment not favorable, any Interest Rate, any Buying Power
            (and (= ?regulatoryFavorable 1) (= ?interestRaise 1) (>= ?buyingPowerIncrease 0)) ; Regulatory Environment favorable, Interest Rate Raise, any Buying Power
            (and (= ?regulatoryFavorable 2) (= ?interestRaise 1) (>= ?buyingPowerIncrease 0)) ; no Regulatory Environment information, Interest Rate Raise, any Buying Power
            (and (= ?regulatoryFavorable 2) (= ?interestRaise 2) (= ?buyingPowerIncrease 0))) ; no Regulatory Environment information, no Interest Rate information, Buying Power not increase
        then
        (assert (macroEconomicOverall bad))
        (printout t crlf "Macro Economic Assessment Completed. Result: Bad" crlf)
    )  
)