//
//  API.swift
//  TestIOSApp
//
//  Created by Hovhannes Sukiasyan on 19.10.2018.
//  Copyright © 2018 Hovhannes Sukiasyan. All rights reserved.
//

import UIKit

class API: NSObject {
    struct Server: Codable {
        
        let ts: Int?
        let name: String?
        let t: Int?
        
    }
    func fetchResultsFromApi(completion: @escaping (_ result: Server) -> Void) {

        guard let url = URL(string: "https://api.myjson.com/bins/r2pdk") else { return }
        URLSession.shared.dataTask(with: url) { (data, response
            , error) in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let obj = try decoder.decode(Server.self, from: data)
                print(obj.name ?? "Город")
                
                completion(obj)
                
            } catch let err {
                print("Err", err)
            }
            }.resume()
    }
    
}
