; Start Assessment
( defrule start =>
    (printout t "Welcome to Stock Price Action Recommendation System" crlf)
    (printout t "We will ask you several questions to help you make decision." crlf)
    (printout t "Questions will cover financial statement, company ratio, macro economy, technical indicator, and investment term." crlf)
    (printout t "Let's start!" crlf)
)

; Financial Statement Assessment
( defrule assessFinancialStatement =>
    (printout t crlf "Assessing Financial Statement...")

    ; Assess Company Balance Sheet
    (printout t crlf "Is company balance sheet data exist?" crlf "0: no" crlf "1: yes" crlf "Enter your choice: ")
    (bind ?balanceSheetExist (read))
    ( if (= ?balanceSheetExist 1)
        then
            (assert (balanceSheetAssessment yes))
        else
            (assert (balanceSheetAssessment no))
            (assert (balance_sheet unknown))
    )

    ; Assess Company Income Statement
    (printout t crlf "Is company income statement data exist?" crlf "0: no" crlf "1: yes" crlf "Enter your choice: ")
    (bind ?incomeStatementExist (read))
    ( if (= ?incomeStatementExist 1)
        then
            (assert (incomeStatementAssessment yes))
        else
            (assert (incomeStatementAssessment no))
            (assert (income_statement unknown))
    )

    ; Assess Company Cash Flow
    (printout t crlf "Is company cash flow data exist?" crlf "0: no" crlf "1: yes" crlf "Enter your choice: ")
    (bind ?cashFlowExist (read))
    ( if (= ?cashFlowExist 1)
        then
            (assert (cashFlowAssessment yes))
        else
            (assert (cashFlowAssessment no))
            (assert (cash_flow unknown))
    )

    ; Assess Company Management Effectiveness
    (printout t crlf "Is company management effectiveness data exist?" crlf "0: no" crlf "1: yes" crlf "Enter your choice: ")
    (bind ?managementEffectivenessExist (read))
    ( if (= ?managementEffectivenessExist 1)
        then
            (assert (managementEffectivenessAssessment yes))
        else
            (assert (managementEffectivenessAssessment no))
            (assert (management_effectiveness unknown))
    )
)

; Balance Sheet Assessment
( defrule balanceSheetAssessment (declare (salience 100)) (balanceSheetAssessment yes) =>
    (printout t crlf "Assessing Company Balance Sheet...")

    ; Assess Equity
    (printout t crlf "Is company equity increasing? " crlf "0: no" crlf "1: yes" crlf "2: no information" crlf "Enter your choice: ")
    (bind ?equity (read))

    ; Assess Liability
    (printout t crlf "Is company liability not increasing? " crlf "0: no" crlf "1: yes" crlf "2: no information" crlf "Enter your choice: ")
    (bind ?liability (read))

    ; Assess Balance Sheet Overall
    (if (or (= ?equity 1) ; Equity increasing, any liability
            (and (= ?equity 2) (= ?liability 1))) ; Unknown equity, liability not increasing
      then
      (assert (balance_sheet good))
      (printout t crlf "Balance Sheet Assessment Completed. Result: Good" crlf)
    )

    (if (or (= ?equity 0) ; Equity not increasing, any liability
            (and (= ?equity 2) (= ?liability 0))) ; Unknown equity, liability increasing
      then
      (assert (balance_sheet bad))
      (printout t crlf "Balance Sheet Assessment Completed. Result: Bad" crlf)
    )

    (if (and (= ?equity 2) (= ?liability 2)) ; Unknown equity, liability
      then
      (assert (balance_sheet unknown))
      (printout t crlf "Balance Sheet Assessment Completed. Result: No information" crlf)
    )
)

; Income Statement Assessment
( defrule incomeStatementAssessment (declare (salience 90)) (incomeStatementAssessment yes) =>
    (printout t crlf "Assessing Company Income Statement...")

    ; Assess Net Income
    (printout t crlf "Is company net income increasing? " crlf "0: no" crlf "1: yes" crlf "2: no information" crlf "Enter your choice: ")
    (bind ?net_income (read))

    ; Assess Revenue
    (printout t crlf "Is company revenue increasing? " crlf "0: no" crlf "1: yes" crlf "2: no information" crlf "Enter your choice: ")
    (bind ?revenue (read))

    ; Assess EBITDA
    (printout t crlf "Is company EBITDA increasing? " crlf "0: no" crlf "1: yes" crlf "2: no information" crlf "Enter your choice: ")
    (bind ?ebitda (read))

    ; Assess Gross Profit
    (printout t crlf "Is company gross profit increasing? " crlf "0: no" crlf "1: yes" crlf "2: no information" crlf "Enter your choice: ")
    (bind ?gross_profit (read))

    ; Assess Income Statement Overall
    (if (or (= ?net_income 1) ; Net income increasing, any other variables
            (and (= ?net_income 2) (= ?revenue 1)) ; Unknown net income, revenue increasing, any other variables
            (and (= ?net_income 2) (= ?revenue 2) (= ?ebitda 1)) ; Unknown net income, revenue, EBITDA increasing, any other variables
            (and (= ?net_income 2) (= ?revenue 2) (= ?ebitda 2) (= ?gross_profit 1))) ; Unknown net income, revenue, EBITDA, gross profit increasing
      then
      (assert (income_statement good))
      (printout t crlf "Income Statement Assessment Completed. Result: Good" crlf)
    )

    (if (or (= ?net_income 0) ; Net income not increasing, any other variables
            (and (= ?net_income 2) (= ?revenue 0)) ; Unknown net income, revenue not increasing, any other variables
            (and (= ?net_income 2) (= ?revenue 2) (= ?ebitda 0)) ; Unknown net income, revenue, EBITDA not increasing, any other variables
            (and (= ?net_income 2) (= ?revenue 2) (= ?ebitda 2) (= ?gross_profit 0))) ; Unknown net income, revenue, EBITDA, gross profit not increasing
      then
      (assert (income_statement bad))
      (printout t crlf "Income Statement Assessment Completed. Result: Bad" crlf)
    )

    (if (and (= ?net_income 2) (= ?revenue 2) (= ?ebitda 2) (= ?gross_profit 2)) ; Unknown net income, revenue, EBITDA, gross profit
      then
      (assert (income_statement unknown))
      (printout t crlf "Income Statement Assessment Completed. Result: No information" crlf)
    )
)

; Cash Flow Assessment
( defrule cashFlowAssessment (declare (salience 80)) (cashFlowAssessment yes) =>
    (printout t crlf "Assessing Company Cash Flow...")

    ; Assess Operating Cash Flow
    (printout t crlf "Is company operating cash flow increasing? " crlf "0: no" crlf "1: yes" crlf "2: no information" crlf "Enter your choice: ")
    (bind ?operating_cash_flow (read))

    ; Assess Free Cash Flow
    (printout t crlf "Is company free cash flow increasing? " crlf "0: no" crlf "1: yes" crlf "2: no information" crlf "Enter your choice: ")
    (bind ?free_cash_flow (read))

    ; Assess Cash Flow Overall
    (if (or (= ?operating_cash_flow 1) ; Operating cash flow increasing, any free cash flow
            (and (= ?operating_cash_flow 2) (= ?free_cash_flow 1))) ; Unknown operating cash flow, free cash flow increasing
      then
      (assert (cash_flow good))
      (printout t crlf "Cash Flow Assessment Completed. Result: Good" crlf)
    )

    (if (or (= ?operating_cash_flow 0) ; Operating cash flow not increasing, any free cash flow
            (and (= ?operating_cash_flow 2) (= ?free_cash_flow 0))) ; Unknown operating cash flow, free cash flow not increasing
      then
      (assert (cash_flow bad))
      (printout t crlf "Cash Flow Assessment Completed. Result: Bad" crlf)
    )

    (if (and (= ?operating_cash_flow 2) (= ?free_cash_flow 2)) ; Unknown operating cash flow, free cash flow
      then
      (assert (cash_flow unknown))
      (printout t crlf "Cash Flow Assessment Completed. Result: No information" crlf)
    )
)

; Management Effectiveness Assessment
( defrule managementEffectivenessAssessment (declare (salience 70)) (managementEffectivenessAssessment yes) =>
    (printout t crlf "Assessing Management Effectiveness...")

    ; Assess Return on Equity Ratio
    (printout t crlf "Is Return on Equity Ratio (ROE) >= 15%? " crlf "0: no" crlf "1: yes" crlf "2: no information" crlf "Enter your choice: ")
    (bind ?roe (read))

    ; Assess Return on Asset Ratio
    (printout t crlf "Is Return on Asset Ratio (ROA) >= 5%? " crlf "0: no" crlf "1: yes" crlf "2: no information" crlf "Enter your choice: ")
    (bind ?roa (read))

    ; Assess Management Effectiveness Overall
    (if (or (= ?roe 1) ; ROE >= 15%, any ROA
            (and (= ?roe 2) (= ?roa 1))) ; Unknown ROE, ROA >= 5%
      then
      (assert (management_effectiveness good))
      (printout t crlf "Management Effectiveness Assessment Completed. Result: Good" crlf)
    )

    (if (or (= ?roe 0) ; ROE < 15%, any ROA
            (and (= ?roe 2) (= ?roa 0))) ; Unknown ROE, ROA < 5%
      then
      (assert (management_effectiveness bad))
      (printout t crlf "Management Effectiveness Assessment Completed. Result: Bad" crlf)
    )

    (if (and (= ?roe 2) (= ?roa 2)) ; Unknown ROE, ROA
      then
      (assert (management_effectiveness unknown))
      (printout t crlf "Management Effectiveness Assessment Completed. Result: No information" crlf)
    )
)

; Determine company financial statement condition based on 1 variable known
(defrule determineFinancialStatement1
  (and (balance_sheet good) (income_statement unknown) (cash_flow unknown) (management_effectiveness unknown))
  =>
  (assert (financial_statement good))
  (printout t crlf "Assessing Financial Statement... " crlf "Financial Statement Assessment Completed. Result: Good" crlf)
)

(defrule determineFinancialStatement2
  (and (balance_sheet bad) (income_statement unknown) (cash_flow unknown) (management_effectiveness unknown))
  =>
  (assert (financial_statement bad))
  (printout t crlf "Assessing Financial Statement... " crlf "Financial Statement Assessment Completed. Result: Bad" crlf)
)

(defrule determineFinancialStatement3
  (and (balance_sheet unknown) (income_statement good) (cash_flow unknown) (management_effectiveness unknown))
  =>
  (assert (financial_statement good))
  (printout t crlf "Assessing Financial Statement... " crlf "Financial Statement Assessment Completed. Result: Good" crlf)
)

(defrule determineFinancialStatement4
  (and (balance_sheet unknown) (income_statement bad) (cash_flow unknown) (management_effectiveness unknown))
  =>
  (assert (financial_statement bad))
  (printout t crlf "Assessing Financial Statement... " crlf "Financial Statement Assessment Completed. Result: Bad" crlf)
)

(defrule determineFinancialStatement5
  (and (balance_sheet unknown) (income_statement unknown) (cash_flow good) (management_effectiveness unknown))
  =>
  (assert (financial_statement good))
  (printout t crlf "Assessing Financial Statement... " crlf "Financial Statement Assessment Completed. Result: Good" crlf)
)

(defrule determineFinancialStatement6
  (and (balance_sheet unknown) (income_statement unknown) (cash_flow bad) (management_effectiveness unknown))
  =>
  (assert (financial_statement bad))
  (printout t crlf "Assessing Financial Statement... " crlf "Financial Statement Assessment Completed. Result: Bad" crlf)
)

(defrule determineFinancialStatement7
  (and (balance_sheet unknown) (income_statement unknown) (cash_flow unknown) (management_effectiveness good))
  =>
  (assert (financial_statement good))
  (printout t crlf "Assessing Financial Statement... " crlf "Financial Statement Assessment Completed. Result: Good" crlf)
)

(defrule determineFinancialStatement8
  (and (balance_sheet unknown) (income_statement unknown) (cash_flow unknown) (management_effectiveness bad))
  =>
  (assert (financial_statement bad))
  (printout t crlf "Assessing Financial Statement... " crlf "Financial Statement Assessment Completed. Result: Bad" crlf)
)

; Determine company financial statement condition based on 2 variables known
(defrule determineFinancialStatement9
  (and (balance_sheet good) (income_statement good) (cash_flow unknown) (management_effectiveness unknown))
  =>
  (assert (financial_statement good))
  (printout t crlf "Assessing Financial Statement... " crlf "Financial Statement Assessment Completed. Result: Good" crlf)
)

(defrule determineFinancialStatement10
  (and (balance_sheet good) (income_statement bad) (cash_flow unknown) (management_effectiveness unknown))
  =>
  (assert (financial_statement neutral))
  (printout t crlf "Assessing Financial Statement... " crlf "Financial Statement Assessment Completed. Result: Neutral" crlf)
)

(defrule determineFinancialStatement11
  (and (balance_sheet bad) (income_statement good) (cash_flow unknown) (management_effectiveness unknown))
  =>
  (assert (financial_statement neutral))
  (printout t crlf "Assessing Financial Statement... " crlf "Financial Statement Assessment Completed. Result: Neutral" crlf)
)

(defrule determineFinancialStatement12
  (and (balance_sheet bad) (income_statement bad) (cash_flow unknown) (management_effectiveness unknown))
  =>
  (assert (financial_statement bad))
  (printout t crlf "Assessing Financial Statement... " crlf "Financial Statement Assessment Completed. Result: Bad" crlf)
)

(defrule determineFinancialStatement13
  (and (balance_sheet good) (income_statement unknown) (cash_flow good) (management_effectiveness unknown))
  =>
  (assert (financial_statement good))
  (printout t crlf "Assessing Financial Statement... " crlf "Financial Statement Assessment Completed. Result: Good" crlf)
)

(defrule determineFinancialStatement14
  (and (balance_sheet good) (income_statement unknown) (cash_flow bad) (management_effectiveness unknown))
  =>
  (assert (financial_statement neutral))
  (printout t crlf "Assessing Financial Statement... " crlf "Financial Statement Assessment Completed. Result: Neutral" crlf)
)

(defrule determineFinancialStatement15
  (and (balance_sheet bad) (income_statement unknown) (cash_flow good) (management_effectiveness unknown))
  =>
  (assert (financial_statement neutral))
  (printout t crlf "Assessing Financial Statement... " crlf "Financial Statement Assessment Completed. Result: Neutral" crlf)
)

(defrule determineFinancialStatement16
  (and (balance_sheet bad) (income_statement unknown) (cash_flow bad) (management_effectiveness unknown))
  =>
  (assert (financial_statement bad))
  (printout t crlf "Assessing Financial Statement... " crlf "Financial Statement Assessment Completed. Result: Bad" crlf)
)

(defrule determineFinancialStatement17
  (and (balance_sheet good) (income_statement unknown) (cash_flow unknown) (management_effectiveness good))
  =>
  (assert (financial_statement good))
  (printout t crlf "Assessing Financial Statement... " crlf "Financial Statement Assessment Completed. Result: Good" crlf)
)

(defrule determineFinancialStatement18
  (and (balance_sheet good) (income_statement unknown) (cash_flow unknown) (management_effectiveness bad))
  =>
  (assert (financial_statement neutral))
  (printout t crlf "Assessing Financial Statement... " crlf "Financial Statement Assessment Completed. Result: Neutral" crlf)
)

(defrule determineFinancialStatement19
  (and (balance_sheet bad) (income_statement unknown) (cash_flow unknown) (management_effectiveness good))
  =>
  (assert (financial_statement neutral))
  (printout t crlf "Assessing Financial Statement... " crlf "Financial Statement Assessment Completed. Result: Neutral" crlf)
)

(defrule determineFinancialStatement20
  (and (balance_sheet bad) (income_statement unknown) (cash_flow unknown) (management_effectiveness bad))
  =>
  (assert (financial_statement bad))
  (printout t crlf "Assessing Financial Statement... " crlf "Financial Statement Assessment Completed. Result: Bad" crlf)
)

(defrule determineFinancialStatement21
  (and (balance_sheet unknown) (income_statement good) (cash_flow good) (management_effectiveness unknown))
  =>
  (assert (financial_statement good))
  (printout t crlf "Assessing Financial Statement... " crlf "Financial Statement Assessment Completed. Result: Good" crlf)
)

(defrule determineFinancialStatement22
  (and (balance_sheet unknown) (income_statement good) (cash_flow bad) (management_effectiveness unknown))
  =>
  (assert (financial_statement neutral))
  (printout t crlf "Assessing Financial Statement... " crlf "Financial Statement Assessment Completed. Result: Neutral" crlf)
)

(defrule determineFinancialStatement23
  (and (balance_sheet unknown) (income_statement bad) (cash_flow good) (management_effectiveness unknown))
  =>
  (assert (financial_statement neutral))
  (printout t crlf "Assessing Financial Statement... " crlf "Financial Statement Assessment Completed. Result: Neutral" crlf)
)

(defrule determineFinancialStatement24
  (and (balance_sheet unknown) (income_statement bad) (cash_flow bad) (management_effectiveness unknown))
  =>
  (assert (financial_statement bad))
  (printout t crlf "Assessing Financial Statement... " crlf "Financial Statement Assessment Completed. Result: Bad" crlf)
)

(defrule determineFinancialStatement25
  (and (balance_sheet unknown) (income_statement good) (cash_flow unknown) (management_effectiveness good))
  =>
  (assert (financial_statement good))
  (printout t crlf "Assessing Financial Statement... " crlf "Financial Statement Assessment Completed. Result: Good" crlf)
)

(defrule determineFinancialStatement26
  (and (balance_sheet unknown) (income_statement good) (cash_flow unknown) (management_effectiveness bad))
  =>
  (assert (financial_statement neutral))
  (printout t crlf "Assessing Financial Statement... " crlf "Financial Statement Assessment Completed. Result: Neutral" crlf)
)

(defrule determineFinancialStatement27
  (and (balance_sheet unknown) (income_statement bad) (cash_flow unknown) (management_effectiveness good))
  =>
  (assert (financial_statement neutral))
  (printout t crlf "Assessing Financial Statement... " crlf "Financial Statement Assessment Completed. Result: Neutral" crlf)
)

(defrule determineFinancialStatement28
  (and (balance_sheet unknown) (income_statement bad) (cash_flow unknown) (management_effectiveness bad))
  =>
  (assert (financial_statement bad))
  (printout t crlf "Assessing Financial Statement... " crlf "Financial Statement Assessment Completed. Result: Bad" crlf)
)

(defrule determineFinancialStatement29
  (and (balance_sheet unknown) (income_statement unknown) (cash_flow good) (management_effectiveness good))
  =>
  (assert (financial_statement good))
  (printout t crlf "Assessing Financial Statement... " crlf "Financial Statement Assessment Completed. Result: Good" crlf)
)

(defrule determineFinancialStatement30
  (and (balance_sheet unknown) (income_statement unknown) (cash_flow good) (management_effectiveness bad))
  =>
  (assert (financial_statement neutral))
  (printout t crlf "Assessing Financial Statement... " crlf "Financial Statement Assessment Completed. Result: Neutral" crlf)
)

(defrule determineFinancialStatement31
  (and (balance_sheet unknown) (income_statement unknown) (cash_flow bad) (management_effectiveness good))
  =>
  (assert (financial_statement neutral))
  (printout t crlf "Assessing Financial Statement... " crlf "Financial Statement Assessment Completed. Result: Neutral" crlf)
)

(defrule determineFinancialStatement32
  (and (balance_sheet unknown) (income_statement unknown) (cash_flow bad) (management_effectiveness bad))
  =>
  (assert (financial_statement bad))
  (printout t crlf "Assessing Financial Statement... " crlf "Financial Statement Assessment Completed. Result: Bad" crlf)
)

; Determine company financial statement condition based on 3 variables known
(defrule determineFinancialStatement33
  (and (balance_sheet good) (income_statement good) (cash_flow good) (management_effectiveness unknown))
  =>
  (assert (financial_statement good))
  (printout t crlf "Assessing Financial Statement... " crlf "Financial Statement Assessment Completed. Result: Good" crlf)
)

(defrule determineFinancialStatement34
  (and (balance_sheet good) (income_statement good) (cash_flow bad) (management_effectiveness unknown))
  =>
  (assert (financial_statement good))
  (printout t crlf "Assessing Financial Statement... " crlf "Financial Statement Assessment Completed. Result: Good" crlf)
)

(defrule determineFinancialStatement35
  (and (balance_sheet good) (income_statement bad) (cash_flow good) (management_effectiveness unknown))
  =>
  (assert (financial_statement neutral))
  (printout t crlf "Assessing Financial Statement... " crlf "Financial Statement Assessment Completed. Result: Neutral" crlf)
)

(defrule determineFinancialStatement36
  (and (balance_sheet good) (income_statement bad) (cash_flow bad) (management_effectiveness unknown))
  =>
  (assert (financial_statement bad))
  (printout t crlf "Assessing Financial Statement... " crlf "Financial Statement Assessment Completed. Result: Bad" crlf)
)

(defrule determineFinancialStatement37
  (and (balance_sheet bad) (income_statement good) (cash_flow good) (management_effectiveness unknown))
  =>
  (assert (financial_statement neutral))
  (printout t crlf "Assessing Financial Statement... " crlf "Financial Statement Assessment Completed. Result: Neutral" crlf)
)

(defrule determineFinancialStatement38
  (and (balance_sheet bad) (income_statement good) (cash_flow bad) (management_effectiveness unknown))
  =>
  (assert (financial_statement neutral))
  (printout t crlf "Assessing Financial Statement... " crlf "Financial Statement Assessment Completed. Result: Neutral" crlf)
)

(defrule determineFinancialStatement39
  (and (balance_sheet bad) (income_statement bad) (cash_flow good) (management_effectiveness unknown))
  =>
  (assert (financial_statement bad))
  (printout t crlf "Assessing Financial Statement... " crlf "Financial Statement Assessment Completed. Result: Bad" crlf)
)

(defrule determineFinancialStatement40
  (and (balance_sheet bad) (income_statement bad) (cash_flow bad) (management_effectiveness unknown))
  =>
  (assert (financial_statement bad))
  (printout t crlf "Assessing Financial Statement... " crlf "Financial Statement Assessment Completed. Result: Bad" crlf)
)

(defrule determineFinancialStatement41
  (and (balance_sheet good) (income_statement good) (cash_flow unknown) (management_effectiveness good))
  =>
  (assert (financial_statement good))
  (printout t crlf "Assessing Financial Statement... " crlf "Financial Statement Assessment Completed. Result: Good" crlf)
)

(defrule determineFinancialStatement42
  (and (balance_sheet good) (income_statement good) (cash_flow unknown) (management_effectiveness bad))
  =>
  (assert (financial_statement good))
  (printout t crlf "Assessing Financial Statement... " crlf "Financial Statement Assessment Completed. Result: Good" crlf)
)

(defrule determineFinancialStatement43
  (and (balance_sheet good) (income_statement bad) (cash_flow unknown) (management_effectiveness good))
  =>
  (assert (financial_statement neutral))
  (printout t crlf "Assessing Financial Statement... " crlf "Financial Statement Assessment Completed. Result: Neutral" crlf)
)

(defrule determineFinancialStatement44
  (and (balance_sheet good) (income_statement bad) (cash_flow unknown) (management_effectiveness bad))
  =>
  (assert (financial_statement bad))
  (printout t crlf "Assessing Financial Statement... " crlf "Financial Statement Assessment Completed. Result: Bad" crlf)
)

(defrule determineFinancialStatement45
  (and (balance_sheet bad) (income_statement good) (cash_flow unknown) (management_effectiveness good))
  =>
  (assert (financial_statement neutral))
  (printout t crlf "Assessing Financial Statement... " crlf "Financial Statement Assessment Completed. Result: Neutral" crlf)
)

(defrule determineFinancialStatement46
  (and (balance_sheet bad) (income_statement good) (cash_flow unknown) (management_effectiveness bad))
  =>
  (assert (financial_statement neutral))
  (printout t crlf "Assessing Financial Statement... " crlf "Financial Statement Assessment Completed. Result: Neutral" crlf)
)

(defrule determineFinancialStatement47
  (and (balance_sheet bad) (income_statement bad) (cash_flow unknown) (management_effectiveness good))
  =>
  (assert (financial_statement bad))
  (printout t crlf "Assessing Financial Statement... " crlf "Financial Statement Assessment Completed. Result: Bad" crlf)
)

(defrule determineFinancialStatement48
  (and (balance_sheet bad) (income_statement bad) (cash_flow unknown) (management_effectiveness bad))
  =>
  (assert (financial_statement bad))
  (printout t crlf "Assessing Financial Statement... " crlf "Financial Statement Assessment Completed. Result: Bad" crlf)
)

(defrule determineFinancialStatement49
  (and (balance_sheet good) (income_statement unknown) (cash_flow good) (management_effectiveness good))
  =>
  (assert (financial_statement good))
  (printout t crlf "Assessing Financial Statement... " crlf "Financial Statement Assessment Completed. Result: Good" crlf)
)

(defrule determineFinancialStatement50
  (and (balance_sheet good) (income_statement unknown) (cash_flow good) (management_effectiveness bad))
  =>
  (assert (financial_statement good))
  (printout t crlf "Assessing Financial Statement... " crlf "Financial Statement Assessment Completed. Result: Good" crlf)
)

(defrule determineFinancialStatement51
  (and (balance_sheet good) (income_statement unknown) (cash_flow bad) (management_effectiveness good))
  =>
  (assert (financial_statement neutral))
  (printout t crlf "Assessing Financial Statement... " crlf "Financial Statement Assessment Completed. Result: Neutral" crlf)
)

(defrule determineFinancialStatement52
  (and (balance_sheet good) (income_statement unknown) (cash_flow bad) (management_effectiveness bad))
  =>
  (assert (financial_statement bad))
  (printout t crlf "Assessing Financial Statement... " crlf "Financial Statement Assessment Completed. Result: Bad" crlf)
)

(defrule determineFinancialStatement53
  (and (balance_sheet bad) (income_statement unknown) (cash_flow good) (management_effectiveness good))
  =>
  (assert (financial_statement neutral))
  (printout t crlf "Assessing Financial Statement... " crlf "Financial Statement Assessment Completed. Result: Neutral" crlf)
)

(defrule determineFinancialStatement54
  (and (balance_sheet bad) (income_statement unknown) (cash_flow good) (management_effectiveness bad))
  =>
  (assert (financial_statement neutral))
  (printout t crlf "Assessing Financial Statement... " crlf "Financial Statement Assessment Completed. Result: Neutral" crlf)
)

(defrule determineFinancialStatement55
  (and (balance_sheet bad) (income_statement unknown) (cash_flow bad) (management_effectiveness good))
  =>
  (assert (financial_statement bad))
  (printout t crlf "Assessing Financial Statement... " crlf "Financial Statement Assessment Completed. Result: Bad" crlf)
)

(defrule determineFinancialStatement56
  (and (balance_sheet bad) (income_statement unknown) (cash_flow bad) (management_effectiveness bad))
  =>
  (assert (financial_statement bad))
  (printout t crlf "Assessing Financial Statement... " crlf "Financial Statement Assessment Completed. Result: Bad" crlf)
)

(defrule determineFinancialStatement57
  (and (balance_sheet unknown) (income_statement good) (cash_flow good) (management_effectiveness good))
  =>
  (assert (financial_statement good))
  (printout t crlf "Assessing Financial Statement... " crlf "Financial Statement Assessment Completed. Result: Good" crlf)
)

(defrule determineFinancialStatement58
  (and (balance_sheet unknown) (income_statement good) (cash_flow good) (management_effectiveness bad))
  =>
  (assert (financial_statement good))
  (printout t crlf "Assessing Financial Statement... " crlf "Financial Statement Assessment Completed. Result: Good" crlf)
)

(defrule determineFinancialStatement59
  (and (balance_sheet unknown) (income_statement good) (cash_flow bad) (management_effectiveness good))
  =>
  (assert (financial_statement neutral))
  (printout t crlf "Assessing Financial Statement... " crlf "Financial Statement Assessment Completed. Result: Neutral" crlf)
)

(defrule determineFinancialStatement60
  (and (balance_sheet unknown) (income_statement good) (cash_flow bad) (management_effectiveness bad))
  =>
  (assert (financial_statement bad))
  (printout t crlf "Assessing Financial Statement... " crlf "Financial Statement Assessment Completed. Result: Bad" crlf)
)

(defrule determineFinancialStatement61
  (and (balance_sheet unknown) (income_statement bad) (cash_flow good) (management_effectiveness good))
  =>
  (assert (financial_statement neutral))
  (printout t crlf "Assessing Financial Statement... " crlf "Financial Statement Assessment Completed. Result: Neutral" crlf)
)

(defrule determineFinancialStatement62
  (and (balance_sheet unknown) (income_statement bad) (cash_flow good) (management_effectiveness bad))
  =>
  (assert (financial_statement neutral))
  (printout t crlf "Assessing Financial Statement... " crlf "Financial Statement Assessment Completed. Result: Neutral" crlf)
)

(defrule determineFinancialStatement63
  (and (balance_sheet unknown) (income_statement bad) (cash_flow bad) (management_effectiveness good))
  =>
  (assert (financial_statement bad))
  (printout t crlf "Assessing Financial Statement... " crlf "Financial Statement Assessment Completed. Result: Bad" crlf)
)

(defrule determineFinancialStatement64
  (and (balance_sheet unknown) (income_statement bad) (cash_flow bad) (management_effectiveness bad))
  =>
  (assert (financial_statement bad))
  (printout t crlf "Assessing Financial Statement... " crlf "Financial Statement Assessment Completed. Result: Bad" crlf)
)

; Determine company financial statement condition based on 4 variables known
(defrule determineFinancialStatement65
  (and (balance_sheet good) (income_statement good) (cash_flow good) (management_effectiveness good))
  =>
  (assert (financial_statement good))
  (printout t crlf "Assessing Financial Statement... " crlf "Financial Statement Assessment Completed. Result: Good" crlf)
)

(defrule determineFinancialStatement67
  (and (balance_sheet good) (income_statement good) (cash_flow good) (management_effectiveness bad))
  =>
  (assert (financial_statement good))
  (printout t crlf "Assessing Financial Statement... " crlf "Financial Statement Assessment Completed. Result: Good" crlf)
)

(defrule determineFinancialStatement68
  (and (balance_sheet good) (income_statement good) (cash_flow bad) (management_effectiveness good))
  =>
  (assert (financial_statement good))
  (printout t crlf "Assessing Financial Statement... " crlf "Financial Statement Assessment Completed. Result: Good" crlf)
)

(defrule determineFinancialStatement69
  (and (balance_sheet good) (income_statement good) (cash_flow bad) (management_effectiveness bad))
  =>
  (assert (financial_statement neutral))
  (printout t crlf "Assessing Financial Statement... " crlf "Financial Statement Assessment Completed. Result: Neutral" crlf)
)

(defrule determineFinancialStatement70
  (and (balance_sheet good) (income_statement bad) (cash_flow good) (management_effectiveness good))
  =>
  (assert (financial_statement good))
  (printout t crlf "Assessing Financial Statement... " crlf "Financial Statement Assessment Completed. Result: Good" crlf)
)

(defrule determineFinancialStatement71
  (and (balance_sheet good) (income_statement bad) (cash_flow good) (management_effectiveness bad))
  =>
  (assert (financial_statement neutral))
  (printout t crlf "Assessing Financial Statement... " crlf "Financial Statement Assessment Completed. Result: Neutral" crlf)
)

(defrule determineFinancialStatement72
  (and (balance_sheet good) (income_statement bad) (cash_flow bad) (management_effectiveness good))
  =>
  (assert (financial_statement neutral))
  (printout t crlf "Assessing Financial Statement... " crlf "Financial Statement Assessment Completed. Result: Neutral" crlf)
)

(defrule determineFinancialStatement73
  (and (balance_sheet good) (income_statement bad) (cash_flow bad) (management_effectiveness bad))
  =>
  (assert (financial_statement bad))
  (printout t crlf "Assessing Financial Statement... " crlf "Financial Statement Assessment Completed. Result: Bad" crlf)
)

(defrule determineFinancialStatement74
  (and (balance_sheet bad) (income_statement good) (cash_flow good) (management_effectiveness good))
  =>
  (assert (financial_statement good))
  (printout t crlf "Assessing Financial Statement... " crlf "Financial Statement Assessment Completed. Result: Good" crlf)
)

(defrule determineFinancialStatement75
  (and (balance_sheet bad) (income_statement good) (cash_flow good) (management_effectiveness bad))
  =>
  (assert (financial_statement neutral))
  (printout t crlf "Assessing Financial Statement... " crlf "Financial Statement Assessment Completed. Result: Neutral" crlf)
)

(defrule determineFinancialStatement76
  (and (balance_sheet bad) (income_statement good) (cash_flow bad) (management_effectiveness good))
  =>
  (assert (financial_statement neutral))
  (printout t crlf "Assessing Financial Statement... " crlf "Financial Statement Assessment Completed. Result: Neutral" crlf)
)

(defrule determineFinancialStatement77
  (and (balance_sheet bad) (income_statement good) (cash_flow bad) (management_effectiveness bad))
  =>
  (assert (financial_statement bad))
  (printout t crlf "Assessing Financial Statement... " crlf "Financial Statement Assessment Completed. Result: Bad" crlf)
)

(defrule determineFinancialStatement78
  (and (balance_sheet bad) (income_statement bad) (cash_flow good) (management_effectiveness good))
  =>
  (assert (financial_statement neutral))
  (printout t crlf "Assessing Financial Statement... " crlf "Financial Statement Assessment Completed. Result: Neutral" crlf)
)

(defrule determineFinancialStatement79
  (and (balance_sheet bad) (income_statement bad) (cash_flow good) (management_effectiveness bad))
  =>
  (assert (financial_statement bad))
  (printout t crlf "Assessing Financial Statement... " crlf "Financial Statement Assessment Completed. Result: Bad" crlf)
)

(defrule determineFinancialStatement80
  (and (balance_sheet bad) (income_statement bad) (cash_flow bad) (management_effectiveness good))
  =>
  (assert (financial_statement bad))
  (printout t crlf "Assessing Financial Statement... " crlf "Financial Statement Assessment Completed. Result: Bad" crlf)
)

(defrule determineFinancialStatement81
  (and (balance_sheet bad) (income_statement bad) (cash_flow bad) (management_effectiveness bad))
  =>
  (assert (financial_statement bad))
  (printout t crlf "Assessing Financial Statement... " crlf "Financial Statement Assessment Completed. Result: Bad" crlf)
)

; Determine company financial statement condition if no variables known
(defrule determineFinancialStatement66
  (and (balance_sheet unknown) (income_statement unknown) (cash_flow unknown) (management_effectiveness unknown))
  =>
  (assert (financial_statement neutral))
  (printout t crlf "Assessing Financial Statement... " crlf "Financial Statement Assessment Completed. Result: No information" crlf)
)