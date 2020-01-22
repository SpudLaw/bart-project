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

    var firstStationAbbr: String?
    var secondStationAbbr: String?
    var firstStationName: String?
    var secondStationName: String?
    var countId = 0
    var time: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        getStations()
    }

    func setupTableView() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 88
        tableView.register(UINib(nibName: "StationTableViewCell", bundle: nil), forCellReuseIdentifier: "StationTableViewCell")
    }

    func getStations() {
        let stationsURL = api.url(with: [URLQueryItem(name: "cmd", value: "stns")], path: "stn")

        api.load(url: stationsURL) { data in
            if let decoder = try? JSONDecoder().decode(Stations.self, from: data) {
//                dump(decoder.root.stations.station)
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

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if countId == 1 {
            firstStationAbbr = stations?[indexPath.row].abbreviation
            firstStationName = stations?[indexPath.row].name
            secondStationAbbr = nil
        } else if countId == 2 {
            secondStationAbbr = stations?[indexPath.row].abbreviation
            secondStationName = stations?[indexPath.row].name

            let scheduleUrl = api.url(with: [URLQueryItem(name: "cmd", value: "depart"),
                                             URLQueryItem(name: "orig", value: firstStationAbbr),
                                             URLQueryItem(name: "dest", value: secondStationAbbr)], path: "sched")
            api.load(url: scheduleUrl) { data in
                let decoder = try! JSONDecoder().decode(Schedule.self, from: data)
                self.time = decoder.root.schedule.request.trip[2].destTimeMin
                self.performSegue(withIdentifier: "ShowSchedule", sender: nil)
            }
        }
    }

    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if  countId > 1 {
            countId -= 1
            tableView.allowsMultipleSelection = false
        } else {
            countId += 1
            tableView.allowsMultipleSelection = true
        }

        return indexPath
    }

    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        countId -= 1
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "ShowSchedule" else {
            assertionFailure("Undefined segue happening rn")
            return
        }
        let vc = segue.destination as! ScheduleViewController
        vc.scheduleInfo = ScheduleInfo(firstStation: firstStationName ?? "", secondStation: secondStationName ?? "", time: time ?? "")

    }
}
