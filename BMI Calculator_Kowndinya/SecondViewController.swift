//
//  SecondViewController.swift
//  BMI Calculator_Kowndinya
//
//  Created by Kowndinya Varanasi on 2022-12-16.
//

import UIKit

class SecondViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    //set height of cell
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    //display number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bmiRL.count
    }
    
    //set cell values according to list data
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let bmiResult = bmiRL[indexPath.row]
        nameLb.text = bmiResult.name
        ageLb.text = bmiResult.age
        let cell = bmiTableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CustomCell
        let dateFormatter = DateFormatter()
        //dateFormatter.dateStyle = .long
        dateFormatter.dateFormat = "MMMM d,yyyy      HH:mm"
        cell.dateLb.text = dateFormatter.string(from: bmiResult.date)
        cell.bmiLb.text = String(bmiResult.bmi)
        cell.weightLb.text = String(bmiResult.weight)
        
        return cell
    }

    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var bmiRL = [BMIResultList]()
    
    var name:String?
    var age:String?
    var date:String?
    var weight:String?
    var bmi:String?
    
    
    @IBOutlet var bgColor: UIView!
    
    @IBOutlet weak var nameLb: UILabel!
    
    @IBOutlet weak var ageLb: UILabel!
    
    @IBOutlet weak var bmiTableView: UITableView!
    
        
        override func viewDidLoad(){
            super.viewDidLoad()
            bmiTableView.dataSource = self
            bmiTableView.delegate = self
            getAllRecords()
            
            
            let gradientLayer = CAGradientLayer()
            gradientLayer.frame = view.bounds
            gradientLayer.colors = [#colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1).cgColor, #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1).cgColor, UIColor.systemPurple]
            gradientLayer.shouldRasterize = true
            gradientLayer.startPoint = CGPoint(x: 0, y: 0)
            gradientLayer.endPoint = CGPoint(x: 1, y: 1)
            bgColor.layer.insertSublayer(gradientLayer, at: 0)
            
        }
//        //set height of cell
//        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//            return 80
//        }
//
//        //display number of rows
//        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//            return bmiRL.count
//        }
//
//        //set cell values according to list data
//        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//            let bmiResult = bmiRL[indexPath.row]
//            nameLb.text = bmiResult.name
//            ageLb.text = bmiResult.age
//            let cell = bmiTableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CustomCell
//            let dateFormatter = DateFormatter()
//            //dateFormatter.dateStyle = .long
//            dateFormatter.dateFormat = "MMMM d,yyyy      HH:mm"
//            cell.dateLb.text = dateFormatter.string(from: bmiResult.date)
//            cell.bmiLb.text = String(bmiResult.bmi)
//            cell.weightLb.text = String(bmiResult.weight)
//
//            return cell
//        }
        
        //reload BMI records list
        func getAllRecords() {
            do {
                bmiRL = try context.fetch(BMIResultList.fetchRequest())
                DispatchQueue.main.async {
                    self.bmiTableView.reloadData()
                }
            }
            catch {}
        }
        
        
        //update BMI record
        func updateBMIRecord(record :BMIResultList, newWeight : Float, newBmi : Float){
            record.weight = Float(newWeight)
            let bmi = String(format: "%.2f", Float(newBmi))
            record.bmi = Float(bmi)!
            do{
                try context.save()
                getAllRecords()
            }
            catch{}
        }
        
        
    }
