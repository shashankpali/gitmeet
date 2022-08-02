//
//  Network.swift
//  GitMeet
//
//  Created by Shashank Pali on 02/08/22.
//

import Foundation

enum NetworkResult {
    case success(Data), failure(String)
}

struct Network {
    
    func getData(urlString: String, callback:@escaping (_ res: NetworkResult) -> Void) {
        guard let url = URL(string: urlString) else {return}
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            
            guard let httpResponse = response as? HTTPURLResponse else {return callback(.failure(error?.localizedDescription ?? Constants.Errors.generic))}
            
            if 200...299 ~= httpResponse.statusCode {
                callback(.success(data!))
            }else if 400...499 ~= httpResponse.statusCode {
                callback(.failure(error?.localizedDescription ?? Constants.Errors.invalidInput))
            }else {
                callback(.failure(error?.localizedDescription ?? Constants.Errors.generic))
            }
            
        }.resume()
    }
    
    func parse<T: Codable>(data: Data, type: T.Type) -> [T]? {
        do {
            return try JSONDecoder().decode([T].self, from: data)
        } catch {
            return nil
        }
    }
}
