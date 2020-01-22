//
//  Schedule.swift
//  BART
//
//  Created by Caroline Law on 1/22/20.
//  Copyright © 2020 WT. All rights reserved.
//

import Foundation

struct Schedule: Decodable {
    var root: Root

    struct Root: Decodable {
        var origin: String
        var destination: String
        var schedule: ScheduleInfo

        struct ScheduleInfo: Decodable {
            var date: String
            var time: String
            var request: Trip

            struct Trip: Decodable {
                var trip: [TripInfo]

                struct TripInfo: Decodable {
                    var origin: String
                    var destination: String
                    var fare: String
                    var originTimeMin: String
                    var originTimeDate: String
                    var destTimeMin: String
                    var destTimeDate: String

                    enum CodingKeys: String, CodingKey {
                        case origin = "@origin"
                        case destination = "@destination"
                        case fare = "@fare"
                        case originTimeMin = "@origTimeMin"
                        case originTimeDate = "@origTimeDate"
                        case destTimeMin = "@destTimeMin"
                        case destTimeDate = "@destTimeDate"
                    }

                    init(from decoder: Decoder) throws {
                        let container = try decoder.container(keyedBy: CodingKeys.self)
                        origin = try container.decode(String.self, forKey: .origin)
                        destination = try container.decode(String.self, forKey: .destination)
                        fare = try container.decode(String.self, forKey: .fare)
                        originTimeMin = try container.decode(String.self, forKey: .originTimeMin)
                        originTimeDate = try container.decode(String.self, forKey: .originTimeDate)
                        destTimeMin = try container.decode(String.self, forKey: .destTimeMin)
                        destTimeDate = try container.decode(String.self, forKey: .destTimeDate)
                    }
                }

            }
        }
    }
}
