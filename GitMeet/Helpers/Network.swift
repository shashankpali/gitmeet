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
    
    func getData<T: Codable>(urlString: String, type: T.Type, callback:@escaping (_ res: NetworkResult<[T]?, String>) -> Void) {
        guard let url = URL(string: urlString) else {return}
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            
            guard let httpResponse = response as? HTTPURLResponse else {return callback(.failure(error?.localizedDescription ?? Constants.Errors.generic))}
            
            if 200...299 ~= httpResponse.statusCode {
                do {
                    let parsedData = try JSONDecoder().decode([T].self, from: data!)
                    callback(.success(parsedData))
                } catch {
                    callback(.failure(error.localizedDescription ))
                }
            }else if 400...499 ~= httpResponse.statusCode {
                callback(.failure(error?.localizedDescription ?? Constants.Errors.invalidInput))
            }else {
                callback(.failure(error?.localizedDescription ?? Constants.Errors.generic))
            }
            
        }.resume()
    }
}
