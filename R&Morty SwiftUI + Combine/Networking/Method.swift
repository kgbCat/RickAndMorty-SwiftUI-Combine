//
//  Method.swift
//  CombainNetworking
//
//  Created by Anna Delova on 2/12/22.
//

import Foundation

enum Method {
    static let baseURL = URL(string: "https://rickandmortyapi.com/api/")!

    case character(Int)
    case page(Int)

    var url: URL {
          switch self {
          case .character(let id):
            return Method.baseURL.appendingPathComponent("character/" + String(id))
          case .page(let num):
              let urlStr = Method.baseURL.appendingPathComponent("character/").absoluteString
              var urlComp = URLComponents(string: urlStr)
              urlComp?.queryItems = [URLQueryItem(name: "page", value: "\(num)")]
              return urlComp?.url ?? Method.baseURL
          }
    }
}
