//
//  ViewControllerStats.swift
//  dartcounter
//
//  Created by Michael Maier on 03.05.24.
//

import Foundation
import UIKit

class ViewControllerStats: UIViewController {
    
    @IBOutlet weak var mainButton: UIButton!
    @IBOutlet weak var endstandLabel1: UILabel!
    @IBOutlet weak var endstandLabel2: UILabel!
    @IBOutlet weak var averageLabel1: UILabel!
    @IBOutlet weak var averageLabel2: UILabel!
    @IBOutlet weak var checkLabel1: UILabel!
    @IBOutlet weak var checkLabel2: UILabel!
    @IBOutlet weak var nameLabel1: UILabel!
    @IBOutlet weak var nameLabel2: UILabel!
    
    var endstand1 = 0
    var endstand2 = 0
    var average1 = 0.00
    var average2 = 0.00
    var check1 = 0.00
    var check2 = 0.00
    var name1 = ""
    var name2 = ""
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        nameLabel1.text = "\(name1)"
        nameLabel2.text = "\(name2)"
        endstandLabel1.text = "\(endstand1)"
        endstandLabel2.text = "\(endstand2)"
        averageLabel1.text = "\(average1)"
        averageLabel2.text = "\(average2)"
        checkLabel1.text = "\(check1)"
        checkLabel2.text = "\(check2)"
        
    }
    
   
    
    @IBAction func openMainController(_ sender: UIButton){
        
       
        
        if let mainVC = storyboard?.instantiateViewController(withIdentifier: "ViewController") as? ViewController {
            navigationController?.pushViewController(mainVC, animated: true)
            
            present(mainVC, animated: true)
        }
        
       
        
    }
    

    
    
}
