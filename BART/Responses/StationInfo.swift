//
//  StationInfo.swift
//  BART
//
//  Created by Caroline Law on 1/21/20.
//  Copyright © 2020 WT. All rights reserved.
//

import Foundation

struct Stations: Decodable {
    var root: Root

    struct Root: Decodable {
        let stations: Station

        struct Station: Decodable {
            let station: [StationInfo]
        }
    }

    struct StationInfo: Decodable {
                   let name: String
                   let abbreviation: String
                   let address: String
                   let city: String
                   let zipcode: String

                   enum CodingKeys: String, CodingKey {
                       case name
                       case abbreviation = "abbr"
                       case address
                       case city
                       case zipcode
                   }

                   init(from decoder: Decoder) throws {
                       let container = try decoder.container(keyedBy: CodingKeys.self)
                       name = try container.decode(String.self, forKey: .name)
                       abbreviation = try container.decode(String.self, forKey: .abbreviation)
                       address = try container.decode(String.self, forKey: .address)
                       city = try container.decode(String.self, forKey: .city)
                       zipcode = try container.decode(String.self, forKey: .zipcode)
                   }
               }
}
