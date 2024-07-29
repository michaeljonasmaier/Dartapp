//
//  ViewControllerGame.swift
//  dartcounter
//
//  Created by Michael Maier on 30.04.24.
//

import Foundation

import UIKit

class ViewControllerGame: UIViewController {
    
    
    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var scoreLabel1: UILabel!
    var score1 = 501
    @IBOutlet weak var scoreLabel2: UILabel!
    var score2 = 301
    @IBOutlet weak var legLabel1: UILabel!
    var legCount1 = 0
    @IBOutlet weak var legLabel2: UILabel!
    var legCount2 = 0
    var activePlayer = 1 // Aktiver Spieler (1 oder 2)
    var winner = 0
    
    var averagePlayer1: Double = 0.000
    var averagePlayer2: Double = 0.000
    var visitsPlayer1: Double = 0
    var visitsPlayer2: Double = 0
    var fullScorePlayer1: Double = 0
    var fullScorePlayer2: Double = 0
    var checkoutrate1: Double = 0.000
    var checkoutrate2: Double = 0.000
    var isvalid = true
    @IBOutlet weak var averageLabel1: UILabel!
    @IBOutlet weak var averageLabel2: UILabel!
    
    @IBOutlet weak var enterButton: UIButton!
    @IBOutlet weak var oneButton: UIButton!
    @IBOutlet weak var twoButton: UIButton!
    @IBOutlet weak var threeButton: UIButton!
    @IBOutlet weak var fourButton: UIButton!
    @IBOutlet weak var fiveButton: UIButton!
    @IBOutlet weak var sixButton: UIButton!
    @IBOutlet weak var sevenButton: UIButton!
    @IBOutlet weak var eightButton: UIButton!
    @IBOutlet weak var nineButton: UIButton!
    @IBOutlet weak var zeroButton: UIButton!
    
    @IBOutlet weak var labelNamePlayer1: UILabel!
    @IBOutlet weak var labelNamePlayer2: UILabel!
    
    @IBOutlet weak var gamemodelabel: UILabel!
    
    @IBOutlet weak var lastVisitLabel1: UILabel!
    @IBOutlet weak var lastVisitLabel2: UILabel!
    
    
    var numberoflegs = 0
    
    var namePlayer1 = "peter"
    var namePlayer2 = ""
    
    var lastVisit1 = 0
    var lastVisit2 = 0
    
    var dartsOnDouble1 = 0
    var dartsOnDouble2 = 0
    
  
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //Rahmen der score label
        scoreLabel1.layer.borderWidth = 4.0 // Dicke des Rahmens in Punkten
        scoreLabel1.layer.borderColor = UIColor.systemYellow.cgColor
        scoreLabel2.layer.borderWidth = 4.0 // Dicke des Rahmens in Punkten
        scoreLabel2.layer.borderColor = UIColor.white.cgColor
        gamemodelabel.text = ""
        gamemodelabel.text = "First to \(numberoflegs) legs"
        
        scoreLabel1.text = "\(score1)"
        legLabel1.text = "\(legCount1)"
        scoreLabel2.text = "\(score2)"
        legLabel2.text = "\(legCount2)"
        numberTextField.placeholder = "Eingegebene Zahlen"
        
        
        labelNamePlayer1.text = "\(namePlayer1)"
        labelNamePlayer2.text = "\(namePlayer2)"
        
        lastVisitLabel1.text = ""
        lastVisitLabel2.text = ""
        
        // DEL-Button
        let deleteButton = UIButton(type: .system)
        deleteButton.frame = CGRect(x: numberTextField.frame.maxX + 10, y: numberTextField.frame.origin.y, width: 60, height: 40)
        deleteButton.setTitle("DEL", for: .normal)
        deleteButton.addTarget(self, action: #selector(deleteButtonTapped(_:)), for: .touchUpInside)
        view.addSubview(deleteButton)
        
        
        
        //Zahlen-Buttons
        oneButton.addTarget(self, action: #selector(numberButtonTapped(_:)), for: .touchUpInside)
        twoButton.addTarget(self, action: #selector(numberButtonTapped(_:)), for: .touchUpInside)
        threeButton.addTarget(self, action: #selector(numberButtonTapped(_:)), for: .touchUpInside)
        fourButton.addTarget(self, action: #selector(numberButtonTapped(_:)), for: .touchUpInside)
        fiveButton.addTarget(self, action: #selector(numberButtonTapped(_:)), for: .touchUpInside)
        sixButton.addTarget(self, action: #selector(numberButtonTapped(_:)), for: .touchUpInside)
        sevenButton.addTarget(self, action: #selector(numberButtonTapped(_:)), for: .touchUpInside)
        eightButton.addTarget(self, action: #selector(numberButtonTapped(_:)), for: .touchUpInside)
        nineButton.addTarget(self, action: #selector(numberButtonTapped(_:)), for: .touchUpInside)
        zeroButton.addTarget(self, action: #selector(numberButtonTapped(_:)), for: .touchUpInside)
        
        enterButton.addTarget(self, action: #selector(enterButtonTapped(_:)), for: .touchUpInside)
        
    }
    
    var enteredDigits = ""
    
    @objc func numberButtonTapped(_ sender: UIButton) {
        // Zurücksetzen des Textfelds und Ändern der Schriftfarbe auf Schwarz
        
        numberTextField.text = ""
        numberTextField.textColor = UIColor.black
        
        guard let digitString = sender.titleLabel?.text, let digit = Int(digitString) else {
            return
        }
        
        if enteredDigits.count < 3 {
            enteredDigits.append(digitString)
            numberTextField.text = enteredDigits
        }
    }
    
    @objc func deleteButtonTapped(_ sender: UIButton) {
        if !enteredDigits.isEmpty {
            enteredDigits.removeLast()
            numberTextField.text = enteredDigits
        }
    }
    
    @objc func enterButtonTapped(_ sender: UIButton) {
        guard let enteredNumber = Int(numberTextField.text ?? "") else {
            return
        }
        
        checkifscorevalid()
        if isvalid{
            if activePlayer == 1 {
                score1 -= enteredNumber
                if score1 <= 50 {
                    
                    showCheckoutAlert(enteredNumberC: enteredNumber)
                    
                    
                }
                else if score1 <= 170 && enteredNumber == 0 {
                    showCheckoutAlert(enteredNumberC: enteredNumber)
                } else {
                    doTheMathsPl1(enteredNumber: enteredNumber)
                }
                
                    
            
                
                
            } else {
                score2 -= enteredNumber
                
                if score2 <= 50 {
                    showCheckoutAlert(enteredNumberC: enteredNumber)
                }
                else if score2 <= 170 && enteredNumber == 0 {
                    showCheckoutAlert(enteredNumberC: enteredNumber)
                } else {
                    doTheMathsPl2(enteredNumber: enteredNumber)
                }
                
                
            }
        }
        
        
        
        // Sieger Pop Up
        func showPopup() {
            // Erstelle ein UIAlertController
            let alertController = UIAlertController(title: "Popup", message: "Spieler \(winner) gewinnt!", preferredStyle: .alert)
            
            // Füge eine Aktion zum Schließen des Popups hinzu
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okAction)
            
            // Zeige das Popup-Fenster an
            present(alertController, animated: true, completion: nil)
        }
        
        
        
        
        
        func checkifscorevalid(){
            
            if enteredNumber > 180 {
                isvalid = false
            }
            
            
            var invalidNumbersToCheck: [Int] = [159, 162, 163, 165, 166, 168, 169]
            var invalidNumbersToScore: [Int] = [163, 166, 169, 172, 173, 175, 176, 178, 179]
            var invalidNumbersAbove170: [Int] = [171, 174, 177, 180]
            
            for number in invalidNumbersToScore {
                if enteredNumber==number{
                    isvalid = false
                }
            }
            
            if activePlayer == 1 {
                
                //nicht in minus bereich
                if enteredNumber>score1{
                    isvalid = false
                }
                //bogey zahlen
                if score1 <= 170{
                    for number in invalidNumbersToCheck {
                        if enteredNumber==number{
                            isvalid = false
                        }
                    }
                }//nicht auf 1 rest
                if score1-enteredNumber == 1{
                    isvalid = false
                    
                }
                //nicht über scoring checken
                if score1 > 170 && score1 < 181 {
                    for number in invalidNumbersAbove170 {
                        if enteredNumber==number{
                            isvalid = false
                        }
                    }
                }
                
                
            } else {
                //nicht in minus bereich
                if enteredNumber>score2{
                    isvalid = false
                }
                //bogey zahlen
                if score2 <= 170{
                    for number in invalidNumbersToCheck {
                        if enteredNumber==number{
                            isvalid = false
                        }
                    }
                }
                //nicht auf 1 rest
                if score2-enteredNumber == 1{
                    isvalid = false
                    
                }
                //nicht über scoring checken
                if score2 > 170 && score2 < 181 {
                    for number in invalidNumbersAbove170 {
                        if enteredNumber==number{
                            isvalid = false
                        }
                    }
                }
            }
            
            
        }
        
        
        
        
        
        // Zurücksetzen des Textfelds und Ändern der Schriftfarbe auf Schwarz
        if isvalid {
            enteredDigits = ""
            numberTextField.text = ""
            numberTextField.textColor = UIColor.black
        } else {
            numberTextField.text = "no valid score"
            numberTextField.textColor = UIColor.red
            enteredDigits = ""
            isvalid = true
        }
        
    }
    
    func average(){
        if visitsPlayer1 != 0 {
            averagePlayer1 = fullScorePlayer1/visitsPlayer1
        }
        if visitsPlayer2 != 0 {
            averagePlayer2 = fullScorePlayer2/visitsPlayer2
        }
        var averageTextPlayer1 = String(format: "%.2f", averagePlayer1)
        var averageTextPlayer2 = String(format: "%.2f", averagePlayer2)
        
        averageLabel1.text = "⌀ \(averageTextPlayer1)"
        averageLabel2.text = "⌀ \(averageTextPlayer2)"
        
    }
    
    
    func changePlayerTo1 (){
        activePlayer = 1
        scoreLabel1.layer.borderWidth = 4.0
        scoreLabel1.layer.borderColor = UIColor.systemYellow.cgColor
        
        scoreLabel2.layer.borderWidth = 4.0
        scoreLabel2.layer.borderColor = UIColor.white.cgColor
        
        
    }
    
    func changePlayerTo2 (){
        activePlayer = 2
        scoreLabel2.layer.borderWidth = 4.0
        scoreLabel2.layer.borderColor = UIColor.systemYellow.cgColor
        
        scoreLabel1.layer.borderWidth = 4.0
        scoreLabel1.layer.borderColor = UIColor.white.cgColor
        
        
    }
    
    
    func doTheMathsPl1(enteredNumber: Int){
        scoreLabel1.text = "\(score1)"
        lastVisit1 = enteredNumber
        lastVisitLabel1.text = "\(lastVisit1)"
        
        changePlayerTo2()
        
        visitsPlayer1 += 1
        fullScorePlayer1 += Double(enteredNumber)
        average()
        
        if score1 == 0 {
            legCount1 += 1
            legLabel1.text = "\(legCount1)"
            score1 = 501 // Setze Score 1 auf 501 zurück
            scoreLabel1.text = "\(score1)"
            score2 = 301 // Setze Score 2 auf 501 zurück
            scoreLabel2.text = "\(score2)"
            
            
            if legCount1 == numberoflegs {
                winner = 1
                changePlayerTo1()
                //showPopup()
            } else {
                if (legCount1 + legCount2) % 2 == 0 {
                    changePlayerTo1()
                } else {
                    changePlayerTo2()
                    
                }
                
            }
        }
        
    }
    
    func doTheMathsPl2(enteredNumber: Int) {
        scoreLabel2.text = "\(score2)"
        lastVisit2 = enteredNumber
        lastVisitLabel2.text = "\(lastVisit2)"
        changePlayerTo1()
        
        visitsPlayer2 += 1
        fullScorePlayer2 += Double(enteredNumber)
        average()
        
        if score2 == 0 {
            legCount2 += 1
            legLabel2.text = "\(legCount2)"
            score1 = 501 // Setze Score 1 auf 501 zurück
            scoreLabel1.text = "\(score1)"
            score2 = 301 // Setze Score 2 auf 501 zurück
            scoreLabel2.text = "\(score2)"
           
            
            if legCount2 == numberoflegs {
                winner = 2
                changePlayerTo2()
                //showPopup()
            } else {
                if (legCount1 + legCount2) % 2 == 0 {
                    changePlayerTo1()
                } else {
                    changePlayerTo2()
                }
                
            }
            
            
        }
    }
    
    
    
    func checkoutPlayer1(){
        print("Legcount von pl 1 = \(legCount1)")
        print("dartsondouble von pl 1 = \(dartsOnDouble1)")
        if dartsOnDouble1 != 0 {
            checkoutrate1 = (Double(legCount1)/Double(dartsOnDouble1))*100.00
        }
            
            print("Checkout von pl 1 = \(checkoutrate1)")
        
        
    }
    func checkoutPlayer2(){
        if dartsOnDouble2 != 0 {
            checkoutrate2 = (Double(legCount2)/Double(dartsOnDouble2))*100.00
        }
            
            print("Checkout von pl 2 = \(checkoutrate2)")
        
    }
    
    func navigateToStats(){
        if legCount1>0{
            checkoutPlayer1()
        } else {
            checkoutrate1 = 0.00
        }
        
        if legCount2>0{
            checkoutPlayer2()
        } else {
            checkoutrate2 = 0.00
        }
        
        if let statsVC = storyboard?.instantiateViewController(withIdentifier: "ViewControllerStats") as? ViewControllerStats {
            statsVC.name1 = namePlayer1
            statsVC.name2 = namePlayer2
            statsVC.average1 = averagePlayer1
            statsVC.average2 = averagePlayer2
            statsVC.endstand1 = legCount1
            statsVC.endstand2 = legCount2
            statsVC.check1 = checkoutrate1
            statsVC.check2 = checkoutrate2
            navigationController?.pushViewController(statsVC, animated: true)
            
            present(statsVC, animated: true)
        }
        
    }
    
    func showCheckoutAlert(enteredNumberC: Int) {
            // Erstelle eine UIAlertController
            let alertController = UIAlertController(title: "Titel des Popups", message: "Nachricht des Popups", preferredStyle: .alert)

            // Erstelle die Aktionen für die Buttons
            let button1Action = UIAlertAction(title: "Kein Wurf auf Doppel", style: .default) { (action) in
                // Aktion ausführen, wenn Button 1 gedrückt wird
                
            }
            let button2Action = UIAlertAction(title: "1 Wurf auf Doppel", style: .default) { (action) in
                // Aktion ausführen, wenn Button 2 gedrückt wird
           
                self.button2Action(enteredNumberB: enteredNumberC)
            }
            let button3Action = UIAlertAction(title: "2 Würfe auf Doppel", style: .default) { (action) in
                // Aktion ausführen, wenn Button 3 gedrückt wird
                
                self.button3Action(enteredNumberB: enteredNumberC)
            }
        let button4Action = UIAlertAction(title: "3 Würfe auf Doppel", style: .default) { (action) in
            // Aktion ausführen, wenn Button 4 gedrückt wird
          
            self.button4Action(enteredNumberB: enteredNumberC)
        }

            // Buttons zu der UIAlertController hinzufügen
            alertController.addAction(button1Action)
            alertController.addAction(button2Action)
            alertController.addAction(button3Action)
            alertController.addAction(button4Action)

            // Popup-Fenster anzeigen
            self.present(alertController, animated: true, completion: nil)
        }
    
       
    func button2Action(enteredNumberB: Int) {
           if activePlayer == 1 {
               dartsOnDouble1 += 1
               doTheMathsPl1(enteredNumber: enteredNumberB)
           } else {
               dartsOnDouble2 += 1
               doTheMathsPl2(enteredNumber: enteredNumberB)
           }
           
           if winner != 0 {
               navigateToStats()
           }
       }
       
       func button3Action(enteredNumberB: Int) {
           if activePlayer == 1 {
               print("wir fügen dazu, dartsondouble ist \(dartsOnDouble1)")
               dartsOnDouble1 += 2
               doTheMathsPl1(enteredNumber: enteredNumberB)
               print("wir fügen dazu, dartsondouble ist danach \(dartsOnDouble1)")
           } else {
               print("wir fügen bei 2 dazu")
               dartsOnDouble2 += 2
               doTheMathsPl2(enteredNumber: enteredNumberB)
           }
           
           if winner != 0 {
               navigateToStats()
           }
       }
    func button4Action(enteredNumberB: Int) {
        if activePlayer == 1 {
            dartsOnDouble1 += 3
            doTheMathsPl1(enteredNumber: enteredNumberB)
        } else {
            dartsOnDouble2 += 3
            doTheMathsPl2(enteredNumber: enteredNumberB)
        }
        
        if winner != 0 {
            navigateToStats()
        }
    }
    
    
    
}




    
        // Do any additional setup after loading the view.
    




