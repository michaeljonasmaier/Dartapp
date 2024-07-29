//
//  mainmenu.swift
//  test
//
//  Created by Michael Maier on 30.04.24.
//

import UIKit


class ViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var legsTextField: UITextField!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var textFieldName1: UITextField!
    @IBOutlet weak var textFieldName2: UITextField!
    
    @IBOutlet weak var janineButton: UIButton!
    
    @IBOutlet weak var stepper: UIStepper!
        @IBOutlet weak var label: UILabel!
    
    var numberOfLegs: Int = 0
    var name1: String?
    var name2: String?
    
   

    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       
        
        // Hintergrundfarbe des Startmenüs festlegen
        view.backgroundColor = UIColor.white
        // Start-Button hinzufügen
       
        
        
        
        // Initialisierung des Stepper-Werts
        stepper.addTarget(self, action: #selector(stepperPressed), for: .allTouchEvents)
        stepper.value = 1
        label.text = "\(Int(stepper.value))"
        
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Überprüfe, ob die Eingabe nur aus Zahlen besteht oder leer ist
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet) || string.isEmpty
    }
    
    
    
    @IBAction func openGameController(_ sender: UIButton){
        print("iuafsihufd")
        numberOfLegs = Int(stepper.value)
        
        if textFieldName1.text?.isEmpty == false {
            name1=textFieldName1.text
        } else {
            name1="Player 1"
        }
        
        if textFieldName2.text?.isEmpty == false {
            name2=textFieldName2.text
        } else {
            name2="Player 2"
        }
       
        
        if let gameVC = storyboard?.instantiateViewController(withIdentifier: "ViewControllerGame") as? ViewControllerGame {
            gameVC.numberoflegs = numberOfLegs
            gameVC.namePlayer1 = name1!
            gameVC.namePlayer2 = name2!
            navigationController?.pushViewController(gameVC, animated: true)
            
            present(gameVC, animated: true)
        }
        
       
        
    }
    
    @IBAction func stepperPressed(_ sender: UIStepper) {
           // Aktualisierung des Labels mit dem neuen Wert des Steppers
           label.text = "\(Int(sender.value))"
       }
    
    
    
    
   
    
    
    

    
    
}
