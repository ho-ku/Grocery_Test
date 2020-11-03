//
//  RequestService.swift
//  Grocery_Test
//
//  Created by Денис Андриевский on 03.11.2020.
//

import Foundation

enum RequestError: Error {
    case invalidURL
}

final class RequestService {
    
    private let serviceURLString = "https://smktesting.herokuapp.com/"
    private let imageServiceURlString = "https://smktesting.herokuapp.com/static/"
    
    func proceedUser(_ state: SignUpState, username: String, password: String, completionHandler: @escaping (Result<Data, Error>) -> Void) {
        var endpoint = ""
        switch state {
        case .logIn:
            endpoint = "api/login/"
        case .signUp:
            endpoint = "api/register/"
        }
        let urlString = serviceURLString + endpoint
        guard let url = URL(string: urlString) else { completionHandler(.failure(RequestError.invalidURL)); return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let parameters: [String: String] = [
            "username": username,
            "password": password
        ]
        request.httpBody = parameters.percentEncoded()
        URLSession.shared.dataTask(with: request) { (data, request, error) in
        guard let data = data, error == nil else { completionHandler(.failure(error!)); return }
            completionHandler(.success(data))
        }.resume()
    }
    
    func fetchGrocery(completionHandler: @escaping (Result<Data, Error>) -> Void) {
        let urlString = serviceURLString + "api/products/"
        guard let url = URL(string: urlString) else { completionHandler(.failure(RequestError.invalidURL)); return }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            guard let data = data, error == nil else { completionHandler(.failure(error!)); return }
            completionHandler(.success(data))
        }.resume()
    }
    
    func fetchImage(image: String, completionHandler: @escaping (Result<Data, Error>) -> Void) {
        let urlString = imageServiceURlString + image
        guard let url = URL(string: urlString) else { completionHandler(.failure(RequestError.invalidURL)); return }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            guard let data = data, error == nil else { completionHandler(.failure(error!)); return }
            completionHandler(.success(data))
        }.resume()
    }
    
    func fetchReviews(for productID: Int, completionHandler: @escaping (Result<Data, Error>) -> Void) {
        let urlString = serviceURLString + "api/reviews/\(productID)"
        guard let url = URL(string: urlString) else { completionHandler(.failure(RequestError.invalidURL)); return }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            guard let data = data, error == nil else { completionHandler(.failure(error!)); return }
            completionHandler(.success(data))
        }.resume()
    }
    
    func postReview(productId: Int, rate: Int, review: String, completionHandler: @escaping (Result<Data, Error>) -> Void) {
        let urlString = serviceURLString + "api/reviews/\(productId)"
        guard let url = URL(string: urlString) else { completionHandler(.failure(RequestError.invalidURL)); return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let parameters: [String: Any] = [
            "rate": rate,
            "text": review
        ]
        guard let token = User.shared.token else { return }
        request.setValue("Token \(token)", forHTTPHeaderField: "Authorization")
        request.httpBody = parameters.percentEncoded()
        URLSession.shared.dataTask(with: request) { (data, request, error) in
        guard let data = data, error == nil else { completionHandler(.failure(error!)); return }
            completionHandler(.success(data))
        }.resume()
    }
    
}
