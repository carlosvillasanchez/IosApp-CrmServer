//
//  VisitaViewController.swift
//  fc_practica5
//
//  Created by Carlos Villa on 23/11/2017.
//  Copyright © 2017 Carlos Fernando. All rights reserved.
//

import UIKit

class VisitaViewController: UIViewController {

    @IBOutlet weak var imagen: UIImageView!
    var info: Visit?
    var idSalesmen = ""
    var idCostumer = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let salesman = info!["Salesman"] as? [String:Any], let id = salesman["id"]{
            idSalesmen = String(describing: id)
            print(id)
        }
       // imagen = UIImage(named: "no face")
        putPhoto()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func putPhoto(){
        if let salesman = info!["Salesman"] as? [String:Any], let photo = salesman["Photo"] as? [String:Any], let strurl = photo["url"] as? String {
            
            if let img = imgCache[strurl] {
                imagen.image = img
            }else{
                updatePhoto(strurl)
            }
            //imagen.setNeedsDisplay()
           // imagen.reloadInputViews()
        }
    }
  

    
    func updatePhoto(_ strurl: String){
        //Cola global
        DispatchQueue.global().async {
            if let url = URL(string: strurl), let data = try? Data(contentsOf: url), let img = UIImage(data: data){
                self.imagen.image = img

                //propiedades o interfaz de usuario, para acceder a las propiedades -> self
                DispatchQueue.main.async {
                    imgCache[strurl] = img
                    
                }
        
            }
        }
        
        
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
