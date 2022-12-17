//
//  SecondViewController.swift
//  BMI Calculator_Kowndinya
//
//  Created by Kowndinya Varanasi on 2022-12-16.
//

import UIKit

class SecondViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var bmiRL = [BMIResultList]()
    
    var name:String?
    var age:String?
    var date:String?
    var weight:String?
    var bmi:String?
    var height:Float = 0.0
    
    
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
            gradientLayer.colors = [#colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1).cgColor, #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1).cgColor, UIColor.systemPurple]
            gradientLayer.shouldRasterize = true
            gradientLayer.startPoint = CGPoint(x: 0, y: 0)
            gradientLayer.endPoint = CGPoint(x: 1, y: 1)
            bgColor.layer.insertSublayer(gradientLayer, at: 0)
            
        }
    
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
        cell.dateLb?.text = dateFormatter.string(from: bmiResult.date)
//        cell.dateLb.text = dateFormatter.string(from: bmiResult.date)
        cell.bmiLb?.text = String(bmiResult.bmi)
        cell.weightLb?.text = String(bmiResult.weight)
        
        return cell
    }
        
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
        
    // edit BMI record on left to right swipe gesture functionality
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    {
        let bmiRecord = bmiRL[indexPath.row]
        let edit = UIContextualAction(style: .normal, title: "Edit"){(action,view,nil) in
            // create the actual alert controller view that will be the pop-up
            let alertController = UIAlertController(title: "Edit BMI Record", message: "Enter new value for weight", preferredStyle: .alert)
            
            alertController.addTextField { (weight) in
                // configure the properties of the text field
                alertController.textFields?.first?.text = String(bmiRecord.weight)
            }
            
            // add the buttons/actions to the view controller
            let oldWeight : Float? = Float(bmiRecord.weight)
            let newBmi = bmiRecord.bmi / Float(oldWeight!)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            let saveAction = UIAlertAction(title: "Save", style: .default) { _ in
                
                // this code runs when the user hits the "save" button
                let newWeight = alertController.textFields![0].text
                self.updateBMIRecord(record: bmiRecord, newWeight: Float(newWeight!)!, newBmi: newBmi*Float(newWeight!)!)
            }
            alertController.addAction(cancelAction)
            alertController.addAction(saveAction)
            self.present(alertController, animated: true, completion: nil)
        }
        edit.backgroundColor=UIColor.init(red: 0/255, green: 0/255, blue: 255/255, alpha: 1)
        return UISwipeActionsConfiguration(actions: [edit])
    }
    
    //delete BMI record on right to left swipe gesture functionality
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Delete"){ _, _, _ in
            self.context.delete(self.bmiRL[indexPath.row])
            do
            {
                try self.context.save()
                self.getAllRecords()
            }
            catch{}
        }
        return UISwipeActionsConfiguration(actions: [delete])
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
