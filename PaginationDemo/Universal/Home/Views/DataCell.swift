//
//  DataCell.swift
//  PaginationDemo
//
//  Created by Vihaa on 12/21/19.
//

import UIKit

class DataCell: UITableViewCell {

    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var swSwitch: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.lblTitle.textColor = UIColor.black
        self.lblDate.textColor = UIColor.darkGray
        self.lblDate.font = UIFont.systemFont(ofSize: 14)
        self.lblTitle.font = UIFont.boldSystemFont(ofSize: 17)
        self.swSwitch.onTintColor = UIColor.blue
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
