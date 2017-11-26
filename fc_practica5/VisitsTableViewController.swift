//
//  VisitsTableViewController.swift
//  fc_practica5
//
//  Created by Carlos Villa on 23/11/2017.
//  Copyright © 2017 Carlos Fernando. All rights reserved.
//



import UIKit
public typealias Visit = [String:Any]
public var imgCache = [String:UIImage]()
class VisitsTableViewController: UITableViewController {
    
    @IBOutlet weak var navegationBar: UINavigationItem!
    var extensionUrl: String?
    var argumentosAdicionales: String?
    let token = "232a6ff08c235306c577"
    
    
    var visits = [Visit]() //() para llamar al constructor
    
    var sesion = URLSession.shared
    
    //Tengo que enviarlo con una cola al main thread porque sino se ejecuta todo a la vez y puede haber conflicto
    private func downloadVisits(){
        var strUrl = ""
        if (argumentosAdicionales == nil){
            strUrl = "https://dcrmt.herokuapp.com/api/" + extensionUrl! + "?token=\(token)"
        }else{
            strUrl = "https://dcrmt.herokuapp.com/api/" + extensionUrl! + "?token=\(token)" + argumentosAdicionales!
        }
        if let url = URL(string: strUrl){
            print(strUrl)
            let t = sesion.dataTask(with: url){ (data, response, error) in
                if error != nil {
                    print("Error1", error!.localizedDescription)
                    return
                }

                if (response as! HTTPURLResponse).statusCode != 200 {
                    print("error tipo 2")
                    return
                }

                if let visits =  (try? JSONSerialization.jsonObject(with: data!)) as? [Visit]{
                    DispatchQueue.main.async{//preguntar
                        self.visits = visits
                        self.tableView.reloadData()
                    }
                    
                    
                    
                }
                
            }
            t.resume()
        }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        //metodo asincrono
        downloadVisits()
        //La tabla esta vacia pero tengo qu hacer reload para meterlas
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return visits.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Visit Cell", for: indexPath)
        
        let visit = visits[indexPath.row]
        cell.textLabel?.text = "nombre"
        cell.detailTextLabel?.text = "fecha"
        cell.imageView?.image = UIImage(named: "no face")
        
        
        if let customer = visit["Customer"] as? [String:Any], let name = customer["name"] as? String {
            cell.textLabel?.text = name
        }
        
        if let plannedFor = visit["plannedFor"] as? String {
            
            //copiar del codigo del foro
            
            let df = ISO8601DateFormatter()
            df.formatOptions = [.withFullDate, .withTime, .withDashSeparatorInDate, .withColonSeparatorInTime]
            if let d = df.date(from: plannedFor){
                let str3 = ISO8601DateFormatter.string(from: d, timeZone: .current, formatOptions: [.withFullDate])
                
                cell.detailTextLabel?.text = str3
            }
            
            
            
        }
        
        
        if let salesman = visit["Salesman"] as? [String:Any], let photo = salesman["Photo"] as? [String:Any], let strurl = photo["url"] as? String {
            
            if let img = imgCache[strurl] {
                cell.imageView?.image = img
                
            }else{
                //me la descargo
                
                updatePhoto(strurl,for: indexPath)
            }
            
        }
        
        
        
        return cell
    }
    
    func updatePhoto(_ strurl: String, for indexPath: IndexPath){
        //Cola global
        DispatchQueue.global().async {
            if let url = URL(string: strurl), let data = try? Data(contentsOf: url), let img = UIImage(data: data){
                
                //propiedades o interfaz de usuario, para acceder a las propiedades -> self
                DispatchQueue.main.async {
                    imgCache[strurl] = img
                    self.tableView.reloadRows(at : [indexPath], with: .left)
                    
                    
                    
                }
                
            }
        }
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Show Visit" {
            if let visitDestination = segue.destination as? VisitaViewController{
                if let ip = tableView.indexPathForSelectedRow?.row {
                    visitDestination.info = visits[ip]
                }
            }
        }
        
    }
    
    @IBAction func exit(_ segue: UIStoryboardSegue){
        guard let visita = segue.source as? VisitaViewController else{
            return
        }
        extensionUrl = "salesmen/\(visita.idSalesmen)/visits/flattened"
        downloadVisits()
        tableView.reloadData()

    }

  /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
