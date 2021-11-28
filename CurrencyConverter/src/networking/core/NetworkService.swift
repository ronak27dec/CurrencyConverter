//
//  NetworkService.swift
//  CurrencyConverter
//
//  Created by Ronak on 25/11/21.
//

import Foundation

final class NetworkService {
    
    private var session: URLSession
    
    init(session: URLSession = URLSession(configuration: URLSessionConfiguration.default)) {
        self.session = session
    }
    
    func dispatch(_ endpoint: Endpoint,
                  onCompletion: @escaping (Result<Data, NetworkError>) -> Void) -> URLSessionTask? {
        guard let url = endpoint.url else {
            onCompletion(.failure(NetworkError.invalidURL))
            return nil
        }
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                onCompletion(.failure(.networkError("NETWORKING ERROR: " + error.localizedDescription)))
                return
            }
            if let data = data {onCompletion(.success(data))}
        }
        task.resume()
        return task
    }
}
