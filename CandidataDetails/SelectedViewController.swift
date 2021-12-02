//
//  SelectedViewController.swift
//  CandidataDetails
//
//  Created by Udagedara Dehigama on 2021/12/02.
//

import UIKit

class SelectedViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    @IBOutlet weak var StableView: UITableView!
    var getCandidate: Results?
    var getSelectedCandidate = [Results]()
    override func viewDidLoad() {
        super.viewDidLoad()
        StableView.register(UINib(nibName: "CandidateTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
    }
    func getSelectedCandidate(data:Results){
        getCandidate = data
        getSelectedCandidate.append(getCandidate!)
}
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getSelectedCandidate.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CandidateTableViewCell
        cell.OnBind(data: getCandidate!)
        return cell
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
      return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete){
            getSelectedCandidate.remove(at:indexPath.row)
            StableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}
