//
//  NetworkManager.swift
//  IssueTracker
//
//  Created by Effie on 2023/05/15.
//

import Foundation

final class NetworkManager {
  static let dummyURLString = "https://api.codesquad.kr/onban/main"
  
  let session: URLSessionInterface
  
  init(session: URLSessionInterface = URLSession.shared) {
    self.session = session
  }
  
  func fetchData<T: Decodable>(
    for urlString: String,
    dataType: T.Type,
    completion: @escaping (Result<T, Error>) -> Void)
  {
    guard let url = URL(string: urlString) else { return }
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
  
  func fetchIssueList(completion: @escaping (IssueListDTO) -> Void) {
    fetchData(for: Self.dummyURLString,
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
