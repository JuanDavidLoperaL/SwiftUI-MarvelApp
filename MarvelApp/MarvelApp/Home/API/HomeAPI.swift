//
//  HomeAPI.swift
//  MarvelApp
//
//  Created by Juan david Lopera lopez on 5/10/23.
//

import Combine
import Foundation

protocol HomeAPIProtocol: AnyObject {
    func fetchCharacters() -> AnyPublisher<Marvel, MarvelError>
}

final class HomeAPI: HomeAPIProtocol {
    
    // MARK: - Enum Endpoints
    enum Endpoint: String {
        case marvelInfo = "/v1/public/characters"
    }
    
    // MARK: - Private Properties
    private var urlComponent: URLComponents
    
    // MARK: - Internal Init
    init(urlComponent: URLComponents = URLComponents(string: "https://gateway.marvel.com:443") ?? URLComponents()) {
        self.urlComponent = urlComponent
    }
    
    // MARK: - Protocol Implementation
    func fetchCharacters() -> AnyPublisher<Marvel, MarvelError> {
        urlComponent.path = Endpoint.marvelInfo.rawValue
        urlComponent.queryItems = [
            URLQueryItem(name: "apikey", value: MarvelConfig.shared.apiKey),
            URLQueryItem(name: "hash", value: MarvelConfig.shared.hash),
            URLQueryItem(name: "ts", value: MarvelConfig.shared.timestamp)
        ]
        guard var url: URL = urlComponent.url else {
            return Fail(error: MarvelError.invalidURL).eraseToAnyPublisher()
        }
        return URLSession.shared
            .dataTaskPublisher(for: url)
            .tryMap(\.data)
            .decode(type: Marvel.self, decoder: JSONDecoder())
            .mapError({ error in
                return .invalidURL
            })
            .eraseToAnyPublisher()
        
    }
}
