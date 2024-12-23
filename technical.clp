(defrule ask-pattern
  "Ask the user to select the observed pattern by number and set the trend."
  =>
  (printout t crlf "What pattern are you seeing? Select the corresponding number:" crlf)
  (printout t "1. Ascending Triangle" crlf)
  (printout t "2. Inverted Head & Shoulder" crlf)
  (printout t "3. Cup & Handle" crlf)
  (printout t "4. Double Bottom" crlf)
  (printout t "5. Bullish Flag" crlf)
  (printout t "6. Bullish Penant" crlf)
  (printout t "7. Falling Wedge" crlf)
  (printout t "8. Descending Triangle" crlf)
  (printout t "9. Head & Shoulder" crlf)
  (printout t "10. Inverted Cup & Handle" crlf)
  (printout t "11. Double Top" crlf)
  (printout t "12. Bearish Flag" crlf)
  (printout t "13. Bearish Penant" crlf)
  (printout t "14. Symmetrical Triangle" crlf)
  (printout t "15. Rectangle" crlf)
  (printout t "16. No information" crlf)
  (printout t "Enter your choice: ")
  (bind ?choice (read))
  (if (or (= ?choice 1) (= ?choice 2) (= ?choice 3) (= ?choice 4)
          (= ?choice 5) (= ?choice 6) (= ?choice 7))
      then
        (assert (trend Bullish))
        (printout t "Trend detected: Bullish" crlf))
  (if (or (= ?choice 8) (= ?choice 9) (= ?choice 10) (= ?choice 11)
          (= ?choice 12) (= ?choice 13))
      then
        (assert (trend Bearish))
        (printout t "Trend detected: Bearish" crlf))
  (if (or (= ?choice 14) (= ?choice 15))
      then
        (assert (trend Sideways))
        (printout t "Trend detected: Sideways" crlf))
  (if (and (neq ?choice 1) (neq ?choice 2) (neq ?choice 3) (neq ?choice 4)
           (neq ?choice 5) (neq ?choice 6) (neq ?choice 7) (neq ?choice 8)
           (neq ?choice 9) (neq ?choice 10) (neq ?choice 11) (neq ?choice 12)
           (neq ?choice 13) (neq ?choice 14) (neq ?choice 15))
      then
        (assert (trend None))
        (printout t "Trend detected: None. The selection is unrecognized." crlf))
)

(defrule ask-sectoral
  =>
  (printout t crlf "What is the condition of the sectoral market?" crlf)
  (printout t "1. Bullish" crlf)
  (printout t "2. Bearish" crlf)
  (printout t "3. Sideways" crlf)
  (printout t "Enter your choice: " )

  (bind ?choice (read))
  (if (= ?choice 1)
      then 
        (assert (sectoral Bullish))
        (printout t "Sectoral detected: Bullish" crlf))

  (if (= ?choice 2)
      then 
        (assert (sectoral Bearish))
        (printout t "Sectoral detected: Bearish" crlf))

  (if (= ?choice 3)
      then 
        (assert (sectoral Sideways))
        (printout t "Sectoral detected: Sideways" crlf))
)
        

(defrule ask-position
  "Ask the user to select the position of market relative to the last support and resistance line."
  (trend None)
  =>
  (printout t crlf "Where is the current market position? Select the corresponding number:" crlf)
  (printout t "1. Above and close to the resistance" crlf)
  (printout t "2. Below and close to the support" crlf)
  (printout t "3. In the middle of support and resistance" crlf)
  (printout t "Enter your choice: ")
  (bind ?choice (read))
  (if (= ?choice 1)
      then 
        (assert (position Above)))
  (if (= ?choice 2)
      then 
        (assert (position Below)))
  (if (= ?choice 3)
      then 
        (assert (position Middle)))
  (if (and (neq ?choice 1) (neq ?choice 2) (neq ?choice 3))
      then
        (assert (position Unknown))
        (printout t "Position unrecognized." crlf))
)


(defrule ask-candle-color
  "Ask the user to select the color of the last candle."
  (trend None)
  =>
  (printout t crlf "What is the color of the last candle? Select the corresponding number:" crlf)
  (printout t "1. Green" crlf)
  (printout t "2. Red" crlf)
  (printout t "Enter your choice: ")
  (bind ?choice (read))
  (if (= ?choice 1)
      then 
        (assert (candle-color Green)))
  (if (= ?choice 2)
      then 
        (assert (candle-color Red)))
  (if (and (neq ?choice 1) (neq ?choice 2))
      then
        (assert (candle-color Unknown))
        (printout t "Candle color unrecognized." crlf))
)


(defrule ask-transaction-volume
  "Ask the user to select the current volume of transaction in the market."
  (trend None)
  =>
  (printout t crlf "What is the current volume of transaction in the market? Select the corresponding number:" crlf)
  (printout t "1. High" crlf)
  (printout t "2. Low" crlf)
  (printout t "Enter your choice: ")
  (bind ?choice (read))
  (if (= ?choice 1)
      then 
        (assert (volume High)))
  (if (= ?choice 2)
      then 
        (assert (volume Low)))
  (if (and (neq ?choice 1) (neq ?choice 2))
      then
        (assert (volume Unknown))
        (printout t "Volume unrecognized." crlf))
)


(defrule breakout-rule
  "Rule for breakout"
  (position Above)
  (candle-color Green)
  (volume High)
  =>
  (assert (market-transaction breakout))
  (printout t "Market Transaction: Breakout" crlf))

(defrule resistance-consolidation-rule-high-volume
  "Rule for resistance consolidation with high volume"
  (position Above)
  (candle-color Green)
  (volume Low)
  =>
  (assert (market-transaction resistance_consolidation))
  (printout t "Market Transaction: Resistance Consolidation" crlf))

(defrule bearish-reversal-rule
  "Rule for bearish reversal"
  (position Above)
  (candle-color Red)
  (volume High)
  =>
  (assert (market-transaction bearish_reversal))
  (printout t "Market Transaction: Bearish Reversal" crlf))

(defrule resistance-consolidation-rule-low-volume
  "Rule for resistance consolidation with low volume"
  (position Above)
  (candle-color Red)
  (volume Low)
  =>
  (assert (market-transaction resistance_consolidation))
  (printout t "Market Transaction: Resistance Consolidation" crlf))

(defrule bullish-reversal-rule
  "Rule for bullish reversal"
  (position Below)
  (candle-color Green)
  (volume High)
  =>
  (assert (market-transaction bullish_reversal))
  (printout t "Market Transaction: Bullish Reversal" crlf))

(defrule support-consolidation-rule-high-volume
  "Rule for support consolidation with high volume"
  (position Below)
  (candle-color Green)
  (volume Low)
  =>
  (assert (market-transaction support_consolidation))
  (printout t "Market Transaction: Support Consolidation" crlf))

(defrule breakdown-rule
  "Rule for breakdown"
  (position Below)
  (candle-color Red)
  (volume High)
  =>
  (assert (market-transaction breakdown))
  (printout t "Market Transaction: Breakdown" crlf))

(defrule support-consolidation-rule-low-volume
  "Rule for support consolidation with low volume"
  (position Below)
  (candle-color Red)
  (volume Low)
  =>
  (assert (market-transaction support_consolidation))
  (printout t "Market Transaction: Support Consolidation" crlf))


; Technical Analysis Decision Making:

(defrule trend-bullish-sektoral-bullish-buy
  "Trend is bullish and sectoral is bullish, decision is to buy"
  (trend Bullish)
  (sectoral Bullish)
  =>
  (assert (technical_decision buy))
  (printout t crlf "Technical Decision: Buy" crlf))

(defrule trend-bullish-sektoral-bearish-hold
  "Trend is bullish and sectoral is bearish, decision is to hold"
  (trend Bullish)
  (sectoral Bearish)
  =>
  (assert (technical_decision hold))
  (printout t crlf "Technical Decision: Hold" crlf))

(defrule trend-bullish-sektoral-sideways-buy
  "Trend is bullish and sectoral is sideways, decision is to buy"
  (trend Bullish)
  (sectoral Sideways)
  =>
  (assert (technical_decision buy))
  (printout t crlf "Technical Decision: Buy" crlf))

(defrule trend-bearish-sektoral-bullish-hold
  "Trend is bearish and sectoral is bullish, decision is to hold"
  (trend Bearish)
  (sectoral Bullish)
  =>
  (assert (technical_decision hold))
  (printout t crlf "Technical Decision: Hold" crlf))

(defrule trend-bearish-sektoral-bearish-sell
  "Trend is bearish and sectoral is bearish, decision is to sell"
  (trend Bearish)
  (sectoral Bearish)
  =>
  (assert (technical_decision sell))
  (printout t crlf "Technical Decision: Sell" crlf))

(defrule trend-bearish-sektoral-sideways-sell
  "Trend is bearish and sectoral is sideways, decision is to sell"
  (trend Bearish)
  (sectoral Sideways)
  =>
  (assert (technical_decision sell))
  (printout t crlf "Technical Decision: Sell" crlf))

(defrule trend-sideways-sektoral-bullish-buy
  "Trend is sideways and sectoral is bullish, decision is to buy"
  (trend Sideways)
  (sectoral Bullish)
  =>
  (assert (technical_decision buy))
  (printout t crlf "Technical Decision: Buy" crlf))

(defrule trend-sideways-sektoral-bearish-sell
  "Trend is sideways and sectoral is bearish, decision is to sell"
  (trend Sideways)
  (sectoral Bearish)
  =>
  (assert (technical_decision sell))
  (printout t crlf "Technical Decision: Sell" crlf))

(defrule trend-sideways-sektoral-sideways-hold
  "Trend is sideways and sectoral is sideways, decision is to hold"
  (trend Sideways)
  (sectoral Sideways)
  =>
  (assert (technical_decision hold))
  (printout t crlf "Technical Decision: Hold" crlf))

(defrule trend-none-breakout-sektoral-bullish-buy
  "Trend is none, breakout, sectoral is bullish, decision is to buy"
  (trend None)
  (market-transaction breakout)
  (sectoral Bullish)
  =>
  (assert (technical_decision buy))
  (printout t crlf "Technical Decision: Buy" crlf))

(defrule trend-none-breakout-sektoral-bearish-sell
  "Trend is none, breakout, sectoral is bearish, decision is to sell"
  (trend None)
  (market-transaction breakout)
  (sectoral Bearish)
  =>
  (assert (technical_decision sell))
  (printout t crlf "Technical Decision: Sell" crlf))

(defrule trend-none-breakout-sektoral-sideways-buy
  "Trend is none, breakout, sectoral is sideways, decision is to buy"
  (trend None)
  (market-transaction breakout)
  (sectoral Sideways)
  =>
  (assert (technical_decision buy))
  (printout t crlf "Technical Decision: Buy" crlf))

(defrule trend-none-breakdown-sektoral-bullish-buy
  "Trend is none, breakdown, sectoral is bullish, decision is to buy"
  (trend None)
  (market-transaction breakdown)
  (sectoral Bullish)
  =>
  (assert (technical_decision buy))
  (printout t crlf "Technical Decision: Buy" crlf))

(defrule trend-none-breakdown-sektoral-bearish-sell
  "Trend is none, breakdown, sectoral is bearish, decision is to sell"
  (trend None)
  (market-transaction breakdown)
  (sectoral Bearish)
  =>
  (assert (technical_decision sell))
  (printout t crlf "Technical Decision: Sell" crlf))

(defrule trend-none-breakdown-sektoral-sideways-sell
  "Trend is none, breakdown, sectoral is sideways, decision is to sell"
  (trend None)
  (market-transaction breakdown)
  (sectoral Sideways)
  =>
  (assert (technical_decision sell))
  (printout t crlf "Technical Decision: Sell" crlf))

(defrule trend-none-support-consolidation-sektoral-bullish-buy
  "Trend is none, support consolidation, sectoral is bullish, decision is to buy"
  (trend None)
  (market-transaction support_consolidation)
  (sectoral Bullish)
  =>
  (assert (technical_decision buy))
  (printout t crlf "Technical Decision: Buy" crlf))

(defrule trend-none-support-consolidation-sektoral-bearish-sell
  "Trend is none, support consolidation, sectoral is bearish, decision is to sell"
  (trend None)
  (market-transaction support_consolidation)
  (sectoral Bearish)
  =>
  (assert (technical_decision sell))
  (printout t crlf "Technical Decision: Sell" crlf))

(defrule trend-none-support-consolidation-sektoral-sideways-hold
  "Trend is none, support consolidation, sectoral is sideways, decision is to hold"
  (trend None)
  (market-transaction support_consolidation)
  (sectoral Sideways)
  =>
  (assert (technical_decision hold))
  (printout t crlf "Technical Decision: Hold" crlf))

(defrule trend-none-resistance-consolidation-sektoral-bullish-buy
  "Trend is none, resistance consolidation, sectoral is bullish, decision is to buy"
  (trend None)
  (market-transaction resistance_consolidation)
  (sectoral Bullish)
  =>
  (assert (technical_decision buy))
  (printout t crlf "Technical Decision: Buy" crlf))

(defrule trend-none-resistance-consolidation-sektoral-bearish-sell
  "Trend is none, resistance consolidation, sectoral is bearish, decision is to sell"
  (trend None)
  (market-transaction resistance_consolidation)
  (sectoral Bearish)
  =>
  (assert (technical_decision sell))
  (printout t crlf "Technical Decision: Sell" crlf))

(defrule trend-none-resistance-consolidation-sektoral-sideways-hold
  "Trend is none, resistance consolidation, sectoral is sideways, decision is to hold"
  (trend None)
  (market-transaction resistance_consolidation)
  (sectoral Sideways)
  =>
  (assert (technical_decision hold))
  (printout t crlf "Technical Decision: Hold" crlf))

(defrule trend-none-bullish-reversal-sektoral-bullish-buy
  "Trend is none, bullish reversal, sectoral is bullish, decision is to buy"
  (trend None)
  (market-transaction bullish_reversal)
  (sectoral Bullish)
  =>
  (assert (technical_decision buy))
  (printout t crlf "Technical Decision: Buy" crlf))

(defrule trend-none-bullish-reversal-sektoral-bearish-sell
  "Trend is none, bullish reversal, sectoral is bearish, decision is to sell"
  (trend None)
  (market-transaction bullish_reversal)
  (sectoral Bearish)
  =>
  (assert (technical_decision sell))
  (printout t crlf "Technical Decision: Sell" crlf))

(defrule trend-none-bullish-reversal-sektoral-sideways-buy
  "Trend is none, bullish reversal, sectoral is sideways, decision is to buy"
  (trend None)
  (market-transaction bullish_reversal)
  (sectoral Sideways)
  =>
  (assert (technical_decision buy))
  (printout t crlf "Technical Decision: Buy" crlf))

(defrule trend-none-bearish-reversal-sektoral-bullish-buy
  "Trend is none, bearish reversal, sectoral is bullish, decision is to buy"
  (trend None)
  (market-transaction bearish_reversal)
  (sectoral Bullish)
  =>
  (assert (technical_decision buy))
  (printout t crlf "Technical Decision: Buy" crlf))

(defrule trend-none-bearish-reversal-sektoral-bearish-sell
  "Trend is none, bearish reversal, sectoral is bearish, decision is to sell"
  (trend None)
  (market-transaction bearish_reversal)
  (sectoral Bearish)
  =>
  (assert (technical_decision sell))
  (printout t crlf "Technical Decision: Sell" crlf))

(defrule trend-none-bearish-reversal-sektoral-sideways-sell
  "Trend is none, bearish reversal, sectoral is sideways, decision is to sell"
  (trend None)
  (market-transaction bearish_reversal)
  (sectoral Sideways)
  =>
  (assert (technical_decision sell))
  (printout t crlf "Technical Decision: Sell" crlf))