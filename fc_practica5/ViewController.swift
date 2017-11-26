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
        
        if segue.identifier == "all"{
            if let visitasDestination = segue.destination as? DatesViewController{
                    visitasDestination.extensionUrl = "visits/flattened"
                    visitasDestination.titulo = "Todas las visitas"
            }
        }else if segue.identifier == "mine"{
            if let visitasDestination = segue.destination as? DatesViewController{
                visitasDestination.extensionUrl = "users/tokenOwner/visits/flattened"
                visitasDestination.titulo = "Mis visitas"
            }
        }else if segue.identifier == "fav"{
            if let visitasDestination = segue.destination as? DatesViewController{
                visitasDestination.extensionUrl = ""
                visitasDestination.titulo = "Favoritas"
            }
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
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
