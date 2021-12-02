//
//  CandidateViewController.swift
//  CandidataDetails
//
//  Created by Udagedara Dehigama on 2021/12/02.
//

import UIKit

class CandidateViewController: UIViewController,UITextFieldDelegate {
    @IBOutlet weak var Uitable: UITableView!

    @IBOutlet weak var field: UITextField!
    
    
    var dataList = [Results]()
    var filetreData = [Results]()
    var isFiltered  = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Uitable.register(UINib(nibName: "CandidateTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        loadingData()
        
    }
    func loadingData(){
        let candidateUrl = "https://randomuser.me/api/?results=50"
        if let url = URL(string: candidateUrl){
            URLSession.shared.dataTask(with:URLRequest(url: url)){(data,response,error) in
                do{
                    let result = try JSONDecoder().decode(Candidate.self, from: data!)
                    DispatchQueue.main.async {
                       
                        self.dataList = result.results
                        self.Uitable.reloadData()
                    }
                }
                catch{
                    print(error)
                }
            }.resume()
        }
    }
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text  = textField.text{
            filterText(text+string)
            }
            return true
    }
    func filterText(_ query:String){
        filetreData.removeAll()
        for data in dataList{

            if data.name.first.lowercased().starts(with: query.lowercased()){
                filetreData.append(data)
            }
        }
        Uitable.reloadData()
       
        isFiltered = true
       
    }
}
extension CandidateViewController:UITableViewDelegate,UITableViewDataSource{
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    //return dataList.count
    
    //----- change part---------
    if !filetreData.isEmpty{
        return filetreData.count
    }
    return isFiltered ? 0 : dataList.count
//--------------------
}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CandidateTableViewCell
    
    //cell.OnBind(data:dataList[indexPath.row])
    //----- change part
    if !filetreData.isEmpty{
       
        cell.OnBind(data:filetreData[indexPath.row])
    }
    else
    {
        cell.OnBind(data:dataList[indexPath.row])
    }
    
    //-------
    return cell
}
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       performSegue(withIdentifier: "ShowDetails", sender: self)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      
       if segue.identifier == "ShowDetails"{
            let destinationVC = segue.destination as!
            DetailViewController
            destinationVC.Candidate_Email = dataList[Uitable.indexPathForSelectedRow!.row].email
            let cname = (dataList[Uitable.indexPathForSelectedRow!.row].name.title+" "+dataList[Uitable.indexPathForSelectedRow!.row].name.first+" "+dataList[Uitable.indexPathForSelectedRow!.row].name.last)
            destinationVC.Candidata_Name = cname
            destinationVC.Candidate_Telephone = dataList[Uitable.indexPathForSelectedRow!.row].cell!+", "+dataList[Uitable.indexPathForSelectedRow!.row].phone!
            
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            let date = dateFormatter.date(from: dataList[Uitable.indexPathForSelectedRow!.row].dob.date)
              destinationVC.Candidate_DOB = date
            destinationVC.Candidate_Image = dataList[Uitable.indexPathForSelectedRow!.row].picture.large
            
            let Caddress = (String(dataList[Uitable.indexPathForSelectedRow!.row].location!.street!.number)+","+dataList[Uitable.indexPathForSelectedRow!.row].location!.street!.name+","+dataList[Uitable.indexPathForSelectedRow!.row].location!.city!+","+dataList[Uitable.indexPathForSelectedRow!.row].location!.state!+","+dataList[Uitable.indexPathForSelectedRow!.row].location!.country!)
            destinationVC.candidate_Address = Caddress
            // send data to
            destinationVC.getData(data:dataList[Uitable.indexPathForSelectedRow!.row])
         
        }
         
    }

}



