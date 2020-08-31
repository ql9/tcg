//
//  ViewController.swift
//  The Coffee Garden
//
//  Created by Quốc Lê on 8/31/20.
//  Copyright © 2020 Quốc Lê. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
        
    @IBOutlet var table: UITableView!
    
    var adverts = [Advert](){
        didSet{
            DispatchQueue.main.async{
                self.table.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        table.register(AdvertTableViewCell.nib(), forCellReuseIdentifier: AdvertTableViewCell.indentifier)
        table.dataSource = self
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return adverts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AdvertTableViewCell.indentifier, for: indexPath) as! AdvertTableViewCell
        cell.configure(with: adverts[indexPath.row].title)
        cell.delegate = self
        return cell
    }
    
    func loadData() {
        let advertRequest = AdvertRequest()
        advertRequest.getAdvert { [weak self] results in
            switch results{
            case .failure(let error):
                print(error)
            case .success(let adverts):
                self?.adverts = adverts.reversed()
            }
        }
    }

}

extension ViewController: AdvertTableViewCellDelegate{
    func didTapButton(with title: String) {
        let vc = storyboard?.instantiateViewController(identifier: "detail_vc") as! DetailViewController
        present(vc, animated: true)
    }
}

