//
//  Network.swift
//  GitMeet
//
//  Created by Shashank Pali on 02/08/22.
//

import Foundation

enum NetworkResult<T, String> {
    case success(T), failure(String)
}

struct Network {
    
    static func getData<T: Codable>(urlString: String, callback:@escaping (_ res: NetworkResult<[T], String>) -> Void) {
        guard let url = URL(string: urlString) else {return}
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            
            guard let httpResponse = response as? HTTPURLResponse else {return callback(.failure(error?.localizedDescription ?? ""))}
            
            if 200...299 ~= httpResponse.statusCode {
                do {
                    let parsedData = try JSONDecoder().decode([T].self, from: data!)
                    callback(.success(parsedData))
                } catch {
                    callback(.failure(""))
                }
            }else {
                callback(.failure(""))
            }
            
        }.resume()
    }
}
