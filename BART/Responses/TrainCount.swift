//
//  TrainCount.swift
//  BART
//
//  Created by Caroline Law on 11/27/19.
//  Copyright © 2019 WT. All rights reserved.
//

import Foundation

struct TrainCount: Decodable {
    var root: Root
    
    struct Root: Decodable {

        let date: String
        let time: String
        let traincount: String

        enum CodingKeys: CodingKey {
            case date
            case time
            case traincount
        }

        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)

            date = try container.decode(String.self, forKey: .date)
            time = try container.decode(String.self, forKey: .time)
            traincount = try container.decode(String.self, forKey: .traincount)
        }
    }
}
