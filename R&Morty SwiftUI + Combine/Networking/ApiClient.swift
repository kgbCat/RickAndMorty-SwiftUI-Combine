//
//  ApiClient.swift
//  CombainNetworking
//
//  Created by Anna Delova on 2/12/22.
//

import Foundation
import  Combine
import UIKit

struct ApiClient  {

    private let decoder = JSONDecoder()
    private let queue = DispatchQueue(label: "APIClient", qos: .default, attributes: .concurrent)

    // MARK: Characters API
    func page(num: Int) -> AnyPublisher<CharacterPage, NetworkingError> {
        URLSession.shared
            .dataTaskPublisher(for: Method.page(num).url)
            .receive(on: queue)
            .map(\.data)
            .decode(type: CharacterPage.self, decoder: decoder)
            .mapError { error -> NetworkingError in
                switch error{
                case is URLError:
                    return NetworkingError.unreachableAddress(url: Method.page(num).url)
                default:
                    return NetworkingError.invalidResponse
                }
            }
            .eraseToAnyPublisher()
    }
    func character(id: Int) -> AnyPublisher<Character, NetworkingError> {
         return URLSession.shared
            .dataTaskPublisher(for: Method.character(id).url)
             .receive(on: queue)
             .map(\.data)
             .decode(type: Character.self, decoder: decoder)
             .mapError({ error -> NetworkingError in
                 switch error {
                 case is URLError:
                   return NetworkingError.unreachableAddress(url: Method.character(id).url)
                 default:
                   return NetworkingError.invalidResponse }
             })
             .eraseToAnyPublisher()
    }
  
}
