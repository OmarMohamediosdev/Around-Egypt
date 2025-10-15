//
//  NetworkService.swift
//  Around Egypt
//
//  Created by Omar Mohamed on 14/10/2025.
//

import Foundation
import Alamofire

protocol APIServiceProtocol {
    func fetchRecommendedExperiences(completion: @escaping (Result<Experience, Error>) -> Void)
    func fetchRecentExperiences(completion: @escaping (Result<Experience, Error>) -> Void)
    func likeExperience(id: String, completion: @escaping (Result<Experience, Error>) -> Void)
    func searchExperiences(query: String, completion: @escaping (Result<Experience, Error>) -> Void)
}

class APIService: APIServiceProtocol {
    private let baseURL = "https://aroundegypt.34ml.com/api/v2/experiences"
    
    func fetchRecommendedExperiences(completion: @escaping (Result<Experience, Error>) -> Void) {
        let url = "\(baseURL)?filter[recommended]=true"
        AF.request(url)
            .validate()
            .responseDecodable(of: Experience.self) { response in
                switch response.result {
                case .success(let experience):
                    completion(.success(experience))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func fetchRecentExperiences(completion: @escaping (Result<Experience, Error>) -> Void) {
        AF.request(baseURL)
            .validate()
            .responseDecodable(of: Experience.self) { response in
                switch response.result {
                case .success(let experience):
                    completion(.success(experience))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func searchExperiences(query: String, completion: @escaping (Result<Experience, Error>) -> Void) {
        let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let url = "\(baseURL)?filter[title]=\(encodedQuery)"
        AF.request(url)
            .validate()
            .responseDecodable(of: Experience.self) { response in
                switch response.result {
                case .success(let experience):
                    completion(.success(experience))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func likeExperience(id: String, completion: @escaping (Result<Experience, Error>) -> Void) {
        let url = "\(baseURL)/\(id)/like"
        
        // Send POST request to like endpoint
        AF.request(url, method: .post)
            .validate()
            .responseDecodable(of: Experience.self) { response in
                switch response.result {
                case .success(let experience):
                    completion(.success(experience)) // return updated experience
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
