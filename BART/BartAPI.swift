//
//  BartAPI.swift
//  BART
//
//  Created by Caroline Law on 11/27/19.
//  Copyright © 2019 WT. All rights reserved.
//

import Foundation

class BartAPI {

    enum Constants: String {
        case baseURL = "api.bart.gov"
    }

    let session = URLSession.shared

    func url(with queryItems: [URLQueryItem], path: String) -> URL {
        var components = URLComponents()
        components.scheme = "http"
        components.host = "api.bart.gov"
        components.path = "/api/" + path + ".aspx"

        components.queryItems = [
        URLQueryItem(name: "key", value: "MW9S-E7SL-26DU-VV8V"),
        URLQueryItem(name: "json", value: "y")]

        components.queryItems?.append(contentsOf: queryItems)

        guard let url = components.url else {
            preconditionFailure("Failure to construct URL")
        }

        return url
    }

    func load(url: URL, completionHandler: @escaping (Data) -> Void) {
        let task = self.session.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if let data = data {
                    completionHandler(data)
                } else {
                    if let error = error {
                        print(error.localizedDescription)
                    } else {
                        print("something went wrong")
                    }
                }
            }
        }

        task.resume()
    }
}
