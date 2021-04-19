(deftemplate patient
  (slot age (type INTEGER) (range 0 120))
  (slot anaemia (type INTEGER) (range 0 1))
  (slot creatininePhosphokinase (type INTEGER) (range 20 8000))
  (slot diabetes (type INTEGER) (range 0 1))
  (slot ejectionFraction (type INTEGER) (range 10 80))
  (slot highBloodPressure (type INTEGER) (range 0 1))
  (slot platelets (type INTEGER) (range 20000 850000))
  (slot serumCreatinine (type FLOAT) (range 0.5 10.0))
  (slot serumSodium (type INTEGER) (range 100 150))
  (slot sex (type INTEGER) (range 0 1))
  (slot smoking (type INTEGER) (range 0 1))
)

(deffacts menu
(menu)
)

(defrule menu
  ?delete<-(menu)
=>
  (retract ?delete)
  (printout t " " crlf)
  (printout t "-----<MENU>-----" crlf)
  (printout t "Search.........S" crlf)
  (printout t "Test data......T" crlf)
  (printout t "Quit...........Q" crlf)
  (printout t "----------------" crlf)
  (printout t "Enter your choice" crlf)

  (bind ?choise (read))
  (assert (choise ?choise))
)

(defrule search
  ?delete<-(choise S)
=>
  (printout t "Age (0-120):" crlf)
  (bind ?age (read))
  (printout t "Anaemia (0-1):" crlf)
  (bind ?anaemia (read))
  (printout t "CreatininePhosphokinase (20-8,000):" crlf)
  (bind ?creatininePhosphokinase (read))
  (printout t "Diabetes (0-1):" crlf)
  (bind ?diabetes (read))
  (printout t "EjectionFraction (10-80):" crlf)
  (bind ?ejectionFraction (read))
  (printout t "HighBloodPressure (0-1):" crlf)
  (bind ?highBloodPressure (read))
  (printout t "Platelets (20,000-850,000):" crlf)
  (bind ?platelets (read))
  (printout t "SerumCreatinine (0.5-10.0):" crlf)
  (bind ?serumCreatinine (read))
  (printout t "SerumSodium (100-150):" crlf)
  (bind ?serumSodium (read))
  (printout t "Sex (0-Woman 1-Man):" crlf)
  (bind ?sex (read))
  (printout t "Smoking (0-1):" crlf)
  (bind ?smoking (read))

  (assert (patient (age ?age) (anaemia ?anaemia) (creatininePhosphokinase  ?creatininePhosphokinase) (diabetes ?diabetes) (ejectionFraction ?ejectionFraction) (highBloodPressure ?highBloodPressure) (platelets ?platelets) (serumCreatinine ?serumCreatinine) (serumSodium ?serumSodium) (sex ?sex) (smoking ?smoking)))
  (retract ?delete)
)

(defrule resultLive
  ?delete<-(patient (age ?age) (anaemia ?anaemia) (creatininePhosphokinase  ?creatininePhosphokinase) (diabetes ?diabetes) (ejectionFraction ?ejectionFraction) (highBloodPressure ?highBloodPressure) (platelets ?platelets) (serumCreatinine ?serumCreatinine) (serumSodium ?serumSodium) (sex ?sex) (smoking ?smoking))
  (test (or 
  (and (<= ?serumCreatinine 1.81) 
       (<= ?serumCreatinine 0.85)
       (> ?ejectionFraction 22.50)
       (<= ?serumCreatinine 0.65)) 

  (and (<= ?serumCreatinine 1.81) 
       (<= ?serumCreatinine 0.85)
       (> ?ejectionFraction 22.50)
       (> ?serumCreatinine 0.65))

  (and (<= ?serumCreatinine 1.81) 
       (> ?serumCreatinine 0.85)
       (> ?ejectionFraction 32.50)
       (> ?serumSodium 132.50))
))
=>
  (printout t "Pacient pravdepodobne prezije" crlf)
  (retract ?delete)
  (assert (menu))
)

(defrule resultDeath
  ?delete<-(patient (age ?age) (anaemia ?anaemia) (creatininePhosphokinase  ?creatininePhosphokinase) (diabetes ?diabetes) (ejectionFraction ?ejectionFraction) (highBloodPressure ?highBloodPressure) (platelets ?platelets) (serumCreatinine ?serumCreatinine) (serumSodium ?serumSodium) (sex ?sex) (smoking ?smoking))
  (test (or 
  (and (<= ?serumCreatinine 1.81) 
       (> ?serumCreatinine 0.85)
       (> ?ejectionFraction 32.50)
       (<= ?serumSodium 132.50)) 

  (and (<= ?serumCreatinine 1.81) 
       (<= ?serumCreatinine 0.85)
       (<= ?ejectionFraction 22.50))

  (and (<= ?serumCreatinine 1.81) 
       (> ?serumCreatinine 0.85)
       (<= ?ejectionFraction 32.50))

  (and (> ?serumCreatinine 1.81) 
       (<= ?platelets 211000.00))

  (and (> ?serumCreatinine 1.81) 
       (> ?platelets 211000.00))
))
=>
  (printout t "Pacient pravdepodobne zomrie" crlf)
  (retract ?delete)
  (assert (menu))
)

(defrule testData
  ?delete<-(choise T)
=>
  (printout t "Dead patient......D" crlf)
  (printout t "Alive patient.....A" crlf)
  (bind ?testDataChoise (read))
  (assert (testDataChoise ?testDataChoise))
  (retract ?delete)
)

(defrule testDataDead
  ?delete<-(testDataChoise D)
=>
  (retract ?delete)
  (printout t "Assert patient: Age: 75, Anaemia: 0, CreatininePhosphokinase: 582, Diabetes: 0, EjectionFraction 20, HighBloodPressure 1, Platelets 265000, SerumCreatinine 1.9, SerumSodium 130, Sex 1, Smoking 0" crlf)
  (assert (patient (age 75) (anaemia 0) (creatininePhosphokinase  582) (diabetes 0) (ejectionFraction 20) (highBloodPressure 1) (platelets 265000) (serumCreatinine 1.9) (serumSodium 130) (sex 1) (smoking 0)))
)

(defrule testDataAlive
  ?delete<-(testDataChoise A)
=>
  (retract ?delete)
  (printout t "Assert patient: Age: 55, Anaemia: 0, CreatininePhosphokinase: 109, Diabetes: 0, EjectionFraction 35, HighBloodPressure 0, Platelets 254000, SerumCreatinine 1.1, SerumSodium 139, Sex 1, Smoking 1" crlf)
  (assert (patient (age 55) (anaemia 0) (creatininePhosphokinase  109) (diabetes 0) (ejectionFraction 35) (highBloodPressure 0) (platelets 254000) (serumCreatinine 1.1) (serumSodium 139) (sex 1) (smoking 1)))
)

(defrule testDataWrongChoise
  (declare (salience -50))
  ?delete<-(testDataChoise ?c)
=>
  (retract ?delete)
  (printout t "Wrong symbol!" crlf)
  (assert (menu))
)


(defrule quit
  ?delete<-(choise Q)
=>
  (retract ?delete)
  (printout t "Quit!" crlf)
)

(defrule wrongChoise
  (declare (salience -50))
  ?delete<-(choise ?c)
=>
  (retract ?delete)
  (printout t "Wrong symbol!" crlf)
  (assert (menu))
)
	