//
//  ViewController.swift
//  Firebase_Connect
//
//  Created by Bononya on 23/01/2020.
//  Copyright © 2020 Bononya. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ViewController: UIViewController, UITableViewDataSource {
    
    var prueba:NSDictionary = [:]
    var tabla = Array(repeating: Array(repeating: "", count: 4), count: 5)
    var hijo:[String] = ["0001","0002","0003","0004","0005"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let ref = Database.database().reference()
        
        for i in 0...4{
            ref.child("Juguetes").child(hijo[i]).observeSingleEvent(of: .value) {
                (snapshot) in
                self.prueba = snapshot.value as! NSDictionary
                
                for j in 0...3{
                    switch j {
                    case 0:
                        self.tabla[i][j] = self.prueba["Nombre"] as! String
                    case 1:
                        self.tabla[i][j] = String(self.prueba["Precio"] as! Double)
                    case 2:
                        self.tabla[i][j] = self.prueba["Descripcion"] as! String
                    case 3:
                        self.tabla[i][j] = self.prueba["ImgURL"] as! String
                    default:
                        print("Error inesperado")
                    }
                    print(self.tabla[i][j])
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tabla.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell=tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CellController

            cell.label.text=tabla[indexPath.row][0]
            print(tabla[indexPath.row][0])

            do {
                let url = URL(string: tabla[indexPath.row][3])
                let data = try Data(contentsOf: url!)
                cell.imagen.image = UIImage(data: data)
            }
            catch{
                print(error)
            }
    return cell
  }
}
