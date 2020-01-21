//
//  ViewController.swift
//  BART
//
//  Created by Caroline Law on 11/27/19.
//  Copyright © 2019 WT. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var api = BartAPI()

    var stations: [Stations.StationInfo]?

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: "StationTableViewCell", bundle: nil), forCellReuseIdentifier: "StationTableViewCell")

        let stationsURL = api.url(with: [URLQueryItem(name: "cmd", value: "stns")], path: "stn")
        api.load(url: stationsURL) { data in
            if let decoder = try? JSONDecoder().decode(Stations.self, from: data) {
                self.stations = decoder.root.stations.station
                self.tableView.reloadData()
            } else {
                print("couldn't decode json")
            }
        }

    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stations?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StationTableViewCell") as! StationTableViewCell
        cell.nameLabel.text = stations?[indexPath.row].name
        cell.cityLabel.text = stations?[indexPath.row].city

        return cell
    }
}
