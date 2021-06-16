//
//  WakeupWisdomAPI.swift
//  Wakey
//
//  Created by Student on 16.06.21.
//

import Foundation

class WakeupWisdomAPI {
    let url = URL(string:"https://quotes.rest")!
    
    let session = URLSession(configuration: .default)
    
    func getWakeupWisdom(completion: @escaping (Result<Welcome, Error>) -> Void) {
        let task = session.dataTask(with: url.appendingPathComponent("/qod?language=en")) {
            (data, response, error) in
            guard let data = data else {
                completion(.failure(error!))
                return
            }
            do {
                let decoder = JSONDecoder()
                let quote = try decoder.decode(Welcome.self, from: data)
                completion(.success(quote))
            }
            catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
}
