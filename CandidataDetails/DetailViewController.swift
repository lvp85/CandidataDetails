//
//  DetailViewController.swift
//  CandidataDetails
//
//  Created by Udagedara Dehigama on 2021/12/02.
//

import UIKit
import Foundation

class DetailViewController: UIViewController {
    // select candidate
    @IBOutlet weak var selectCandidate: UIButton!
    @IBOutlet weak var candidateSwitch: UISwitch!
    //-----------------
    var Candidate_Email: String?
    var Candidate_DOB: Date?
    var Candidate_Telephone: String?
    var candidate_Address: String?
    var Candidata_Name: String?
    var Candidate_Image: String?

    @IBOutlet weak var CandidateEmail: UILabel!
    @IBOutlet weak var CandidateDOB: UILabel!
    @IBOutlet weak var CandidateTelephone: UILabel!
    @IBOutlet weak var candidateAddress: UILabel!
    @IBOutlet weak var CandidataName: UILabel!
    @IBOutlet weak var CandidateImage: UIImageView!
  //Topic Label
    
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblName: UILabel!


    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblDob: UILabel!
    @IBOutlet weak var telephone: UILabel!
    var slectedCandi: Results?
    var isSelected  = false
    override func viewDidLoad() {
        super.viewDidLoad()
        CandidateEmail.text = Candidate_Email
        CandidataName.text = Candidata_Name
       
        CandidateTelephone.text = Candidate_Telephone
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yy"
        
        CandidateDOB.text = formatter.string(from: Candidate_DOB!)
        if let data = try? Data(contentsOf: URL(string: Candidate_Image!)!){
            CandidateImage.image = UIImage(data: data)
        }
        candidateAddress.text = candidate_Address
   
    

    

}
    //---- Select /Deselect Users
    @IBAction func candidateSwich(_ sender: UISwitch) {
        if sender.isOn{
            isSelected  = true
        }
        else{
            isSelected = false
        }
    }
    @IBAction func selectCandidate(_ sender: UIButton) {
      if isSelected == true
        {
          performSegue(withIdentifier: "SelectCandidate", sender: self)
          
        }
        
    }
    
    func getData(data:Results){
        slectedCandi = data
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if isSelected == true{
           if segue.identifier == "SelectCandidate"{
          
            let destinationVC = segue.destination as!
            SelectedViewController
            destinationVC.getSelectedCandidate(data: slectedCandi!)
            }
             
        }
    }

}
