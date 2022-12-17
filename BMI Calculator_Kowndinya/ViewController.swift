//
//  ViewController.swift
//  BMI Calculator_Kowndinya
//
//  Created by Kowndinya Varanasi on 2022-12-17.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
   // private var bmiResultList = [BMIResultList]()
    
    //variable declaration for textfields,labels and switch
    @IBOutlet var bgColor: UIView!
    
    @IBOutlet weak var nameField: UITextField!
    
    @IBOutlet weak var genderField: UITextField!
    
    @IBOutlet weak var ageField: UITextField!
    
    @IBOutlet weak var unitSelect: UISegmentedControl!
    
    @IBOutlet weak var heightField: UITextField!
    
    @IBOutlet weak var weightField: UITextField!
    
    @IBOutlet weak var CalculateButton: UIButton!
    
    @IBOutlet weak var resetButton: UIButton!
    
    @IBOutlet weak var checkHistoryButton: UIButton!
    
    @IBOutlet weak var categoryLb: UILabel!
    
    @IBOutlet weak var resutlLb: UILabel!
    
    
    var name:String = ""
    var age:String = ""
    var gender:String = ""
//    var height:Float? = 0
//    var weight:Float? = 0
//    var bmi:Float? = 0
    var roundedBMI:Float = 0
    
    var height:Float = 0.0
    
    var weight:Float = 0.0
    
    var bmi:Float = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [#colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1).cgColor, #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1).cgColor, UIColor.systemPurple]
        gradientLayer.shouldRasterize = true
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        bgColor.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    
    

    @IBAction func unitSelect(_ sender: UISegmentedControl) {

    
    if sender.selectedSegmentIndex == 0 {
        weightField.placeholder = "Enter Weight in Pounds"
        heightField.placeholder = "Enter Height in Inches"
    }
    
    if sender.selectedSegmentIndex == 1 {
        weightField.placeholder = "Enter Weight in Kilograms"
        heightField.placeholder = "Enter Height in Centeinmeters"
    }
    
}
    
    
    //BMI Calculation functionality
    @IBAction func calculateButton(_ sender: Any) {
        
        if (nameField.text!.isEmpty || ageField.text!.isEmpty || heightField.text!.isEmpty || weightField.text!.isEmpty || genderField.text!.isEmpty)
        {
            
            // Show alert if fields are empty
            let alert = UIAlertController(title: "Alert", message: "Fields cannot be empty!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }
        else
        {
            

//            weight = Float(self.weightField.text!)
//            height = Float(self.weightField.text!)
//
            
            if (unitSelect.selectedSegmentIndex == 0) {
                
                /** If Imperial Unit is selected convert to kg and meter */
                weight = (Float(weightField.text!)?.rounded())!
                weight = weight * 0.453592
                height = (Float(heightField.text!)?.rounded())!
                height = height * 0.0254
                
            } else {
                
                /** If Metric Unit is selected convert height to meter and leave weight as it is */
                weight = (Float(weightField.text!)?.rounded())!
                height = (Float(heightField.text!)?.rounded())!
                height = height * 0.01
                
            }
            
            bmi = weight / (height * height)
            
            bmi = ceil(bmi * 10) / 10.0
            
            print(bmi)
            self.resutlLb.text = String(format:"%.\(2)f", bmi)
            
         //   bmiTextLabel.text = "Your BMI: \(bmi)"
            
            //for imperial units (pounds & inches)
            //if imperialSwitch.isOn
//            if (unitSelect.selectedSegmentIndex == 0)
//            {
//                weight = (Float(weightField.text!)?.rounded())!
//                weight = weight! * 0.453592
//                height = (Float(heightField.text!)?.rounded())!
//                height = height! * 0.0254
//
//            } else {
//
//                weight = (Float(weightField.text!)?.rounded())!
//                height = (Float(heightField.text!)?.rounded())!
//                height = height! * 0.01
//
//            }
//
//            bmi = weight! / ((height ?? 0) * (height ?? 0))
//            bmi = ceil(bmi! * 10) / 10.0
//            print(bmi!)
//            roundedBMI = round(bmi!*100)/100.0
//            self.resutlLb.text = String(format:"%.\(2)f", bmi!)
////
            ///
            ///
            ///
            ///
            ///
            ///
//                bmi = Float((weight!*703)/(height!*height!))
//                roundedBMI = round(bmi!*100)/100.0
//                self.resutlLb.text = String(format:"%.\(2)f", bmi!)
//
//                if (bmi! < 16) {self.categoryLb.text = "Severe Thinness"}
//                else if (bmi! >= 16 && bmi! < 17) {self.categoryLb.text = "Moderate Thinness"}
//                else if (bmi! >= 17 && bmi! < 18.5) {self.categoryLb.text = "Mild Thinness"}
//                else if (bmi! >= 18.5 && bmi! < 25) {self.categoryLb.text = "Normal"}
//                else if (bmi! >= 25 && bmi! < 30) {self.categoryLb.text = "Overweight"}
//                else if (bmi! >= 30 && bmi! < 35) {self.categoryLb.text = "Obese Class I"}
//                else if (bmi! >= 35 && bmi! <= 40) {self.categoryLb.text = "Obese Class II"}
//                else if (bmi! > 40) {self.categoryLb.text = "Obese Class III"}
        }
            //for standard units (kg & cm)
//            else
//            {
//                bmi = Float((weight!*10000)/(height!*height!))
//                roundedBMI = round(bmi!*100)/100.0
//                self.resutlLb.text = String(format:"%.\(2)f", bmi!)
//
//                if (bmi! < 16) {self.categoryLb.text = "Severe Thinness"}
//                else if (bmi! >= 16 && bmi! < 17) {self.categoryLb.text = "Moderate Thinness"}
//                else if (bmi! >= 17 && bmi! < 18.5) {self.categoryLb.text = "Mild Thinness"}
//                else if (bmi! >= 18.5 && bmi! < 25) {self.categoryLb.text = "Normal"}
//                else if (bmi! >= 25 && bmi! < 30) {self.categoryLb.text = "Overweight"}
//                else if (bmi! >= 30 && bmi! < 35) {self.categoryLb.text = "Obese Class I"}
//                else if (bmi! >= 35 && bmi! <= 40) {self.categoryLb.text = "Obese Class II"}
//                else if (bmi! > 40) {self.categoryLb.text = "Obese Class III"}
////            }
            //        addResult(weight: Float(weight!) , bmi: Float(roundedBMI))
 //       }
    }

//    //add BMI record into coredata
//    func addResult(weight :Float, bmi : Float)
//    {
//        let date = Date()
//        let newResult = BMIResultList(context: context)
//
//        newResult.name = nameField.text
//        newResult.age = ageField.text
//        newResult.gender = genderField.text
//        newResult.height = height!
//        newResult.weight = weight
//        newResult.bmi = bmi
//        newResult.date = date
//        //print(newResult)
//        do
//        {
//            try context.save()
//        }
//        catch{}
//    }
//
//    }
//
    
    
    
    //Reset button functionality
    @IBAction func resetButton(_ sender: Any) {
        nameField.text = ""
        genderField.text = ""
        ageField.text = ""
        heightField.text = ""
        weightField.text = ""
        resutlLb.text = "0"
        categoryLb.text = ""
    }
    
    
    
    
    //History data functionality
    @IBAction func checkHistoryButton(_ sender: Any) {
    }
    
    


}

