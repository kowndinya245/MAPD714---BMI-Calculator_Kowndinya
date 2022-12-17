//
//  CustomCell.swift
//  BMI Calculator_Kowndinya
//
//  Created by Kowndinya Varanasi on 2022-12-17.
//

import UIKit

class CustomCell: UITableViewCell {
    
    
    
    @IBOutlet weak var bmiLb: UILabel!
    
    @IBOutlet weak var dateLb: UILabel!

    @IBOutlet weak var weightLb: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}










