//
//  ViewController.swift
//  fc_practica5
//
//  Created by Carlos Villa on 23/11/2017.
//  Copyright © 2017 Carlos Fernando. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "Visitas Totales"{
            if let visitasDestination = segue.destination as? VisitsTableViewController{
                    visitasDestination.extensionUrl = "visits/flattened"
                    visitasDestination.navegationBar.title = "Todas las visitas"
            }
        }else if segue.identifier == "Mis Visitas"{
            if let visitasDestination = segue.destination as? VisitsTableViewController{
                visitasDestination.extensionUrl = "users/tokenOwner/visits/flattened"
                visitasDestination.navegationBar.title = "Mis visitas"
            }
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "Visitas Totales"{
           
        }else if identifier == "Mis Visitas"{
            
        }
        return true
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
