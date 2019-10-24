//
//  FavViewController.swift
//  MSA
//
//  Created by Mac for Rav on 10/20/19.
//  Copyright © 2019 RayZhang. All rights reserved.
//

import UIKit

class FavViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    var indy : UIActivityIndicatorView = UIActivityIndicatorView()
    var names : [String] = []
    @IBOutlet weak var tableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  names.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let myCell = UITableViewCell(style: .default, reuseIdentifier: "myCell")
        myCell.textLabel!.text = names[indexPath.row]
        return myCell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete{
            names.remove(at: indexPath.row)
            var fav = UserDefaults.standard.array(forKey: "favorites") as! Array<String>
            fav.remove(at: indexPath.row)
            UserDefaults.standard.set(fav, forKey: "favorites")
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.fade)
            var favID = UserDefaults.standard.array(forKey: "favId") as! Array<Int>
            favID.remove(at: indexPath.row)
            UserDefaults.standard.set(favID, forKey: "favId")
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "myCell")
        names = UserDefaults.standard.array(forKey: "favorites") as! Array<String>
    }
    override func viewWillAppear(_ animated: Bool) {
        names = UserDefaults.standard.array(forKey: "favorites") as! Array<String>
        self.tableView.reloadData()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
