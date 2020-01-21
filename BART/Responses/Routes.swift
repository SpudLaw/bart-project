//
//  Routes.swift
//  BART
//
//  Created by Caroline Law on 12/2/19.
//  Copyright © 2019 WT. All rights reserved.
//

import Foundation

struct Routes: Decodable {
    var root: Root

    struct Root: Decodable {
        var routes: Route
        
        struct Route: Decodable {
            var route: [RoutePoint]
        }

        struct RoutePoint: Decodable {
            var name: String
            var abbreviation: String
            var routeID: String
            var number: String

            enum CodingKeys: String, CodingKey {
                case name
                case abbreviation = "abbr"
                case routeID
                case number
            }

            init(from decoder: Decoder) throws {
                let container = try decoder.container(keyedBy: CodingKeys.self)

                name = try container.decode(String.self, forKey: .name)
                abbreviation = try container.decode(String.self, forKey: .abbreviation)
                routeID = try container.decode(String.self, forKey: .routeID)
                number = try container.decode(String.self, forKey: .number)
            }
        }
    }
}
