//
//  CandidateTableViewCell.swift
//  CandidataDetails
//
//  Created by Udagedara Dehigama on 2021/12/02.
//

import UIKit

class CandidateTableViewCell: UITableViewCell {

    @IBOutlet weak var lblAge: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var uICandidateImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
  
    func OnBind(data:Results){
        lblName.text = data.name.first+" "+data.name.last
        lblAge.text = String(data.dob.age)
        let url = data.picture.thumbnail
        if let data = try? Data(contentsOf: URL(string: url)!){
            self.uICandidateImage.image = UIImage(data: data)
        }
    }
}
