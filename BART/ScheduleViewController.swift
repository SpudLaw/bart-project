//
//  ScheduleViewController.swift
//  BART
//
//  Created by Caroline Law on 1/22/20.
//  Copyright © 2020 WT. All rights reserved.
//

import UIKit

struct ScheduleInfo {
    var firstStation: String
    var secondStation: String
    var time: String
}

class ScheduleViewController: UIViewController {

    @IBOutlet var firstStation: UILabel!
    @IBOutlet var secondStation: UILabel!
    @IBOutlet var time: UILabel!


    var scheduleInfo: ScheduleInfo? = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        firstStation.text = scheduleInfo?.firstStation ?? ""
        secondStation.text = scheduleInfo?.secondStation ?? ""
        time.text = scheduleInfo?.time ?? ""

    }

}
