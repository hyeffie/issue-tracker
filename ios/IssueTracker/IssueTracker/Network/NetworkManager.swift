//
//  NetworkManager.swift
//  IssueTracker
//
//  Created by Effie on 2023/05/15.
//

import Foundation

final class NetworkManager {
   static let dummyURLString = "https://example.com"
   static let defaultPagingOffSet = 10
   
   let session: URLSessionInterface
   
   init(session: URLSessionInterface = URLSession.shared) {
      self.session = session
   }
   
   func fetchData<T: Decodable>(
      for urlString: String,
      with query: [String: String]? = nil,
      dataType: T.Type,
      completion: @escaping (Result<T, Error>) -> Void)
   {
      let url: URL?
      if let query {
         guard var urlcomponent = URLComponents(string: urlString) else { return }
         let queryItems = query.map { item in URLQueryItem(name: item.key, value: item.value) }
         urlcomponent.queryItems = queryItems
         url = urlcomponent.url
      } else {
         url = URL(string: urlString)
      }
      guard let url else { return }
      let request = URLRequest(url: url)
      
      let completionHandler = { (data: Data?, response: URLResponse?, error: Error?) in
         if let error {
            completion(.failure(error))
            return
         }
         
         guard let response = response as? HTTPURLResponse, (200..<300) ~= response.statusCode else {
            completion(.failure(NetworkError.noResponse))
            return
         }
         
         guard let data else {
            completion(.failure(NetworkError.invalidData))
            return
         }
         
         do {
            let newData = try JSONDecoder().decode(dataType, from: data)
            completion(.success(newData))
            return
         } catch {
            completion(.failure(NetworkError.failToParse))
            return
         }
      }
      
      let dataTask = session.dataTask(with: request, handler: completionHandler)
      dataTask.resume()
   }
   
   // MARK: - Util
   
   func fetchIssueList(pageNumber: Int? = nil, completion: @escaping (IssueListDTO) -> Void) {
      var query: [String: String] = [:]
      if let pageNumber {
         query.updateValue("\(Self.defaultPagingOffSet)", forKey: "offset")
         query.updateValue("\(pageNumber)", forKey: "pageNum")
      }
      
      let issueListURL = "http://43.200.199.205:8080/api/"
      
      fetchData(for: issueListURL,
                with: query,
                dataType: IssueListDTO.self) { result in
         switch result {
         case .success(let issueList):
            completion(issueList)
         case .failure(let error):
            print(error)
         }
      }
   }
}
