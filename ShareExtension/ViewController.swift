//
//  ViewController.swift
//  ShareExtension
//
//  Created by Marcin Jackowski on 15/08/2017.
//  Copyright © 2017 Marcin Jackowski. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    
    fileprivate var photosData = [Data]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        fetchPhotosUrlsFromGroup()
    }
    
    private func fetchPhotosUrlsFromGroup() {
        guard let datas = UserDefaults(suiteName: "group.pl.marcinjackowski.ShareExtension")?.object(forKey: "sharePhotosKey") as? [Data] else { return }
        
        UserDefaults(suiteName: "group.pl.marcinjackowski.ShareExtension")?.removeObject(forKey: "sharePhotosKey")
        photosData = datas
        tableView.reloadData()
    }
    
    private func setupTableView() {
        tableView.register(UINib(nibName: "PhotoTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "PhotoTableViewCell")
        tableView.dataSource = self
        tableView.rowHeight = 320.0
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return photosData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoTableViewCell", for: indexPath) as! PhotoTableViewCell
        cell.set(data: photosData[indexPath.row])
        
        return cell
    }
}
