//
//  NetworkManager.swift
//  IssueTracker
//
//  Created by Effie on 2023/05/15.
//

import Foundation

typealias RequestParameters = [String: String]

final class NetworkManager {
   static let dummyURLString = "https://example.com"
   static let defaultPagingOffSet = 10
   
   private let baseURL = ServerAPI.baseURL
   
   private let session: URLSessionInterface
   
   init(session: URLSessionInterface = URLSession.shared) {
      self.session = session
   }
   
   private func decodeJson<T: Decodable>(type: T.Type, fromJson data: Data) -> T? {
      var result: T? = nil
      do {
         result = try JSONDecoder().decode(type, from: data)
      } catch {
         // TODO: failToParse 에러 핸들링
         print("fail to parse \(String(describing: type.self))")
         print(error)
      }
      return result
   }
   
   private func encodeJson<T: Encodable>(data: T) -> Data? {
      var json: Data? = nil
      do {
         json = try JSONEncoder().encode(data)
      } catch {
         // TODO: failToEncode 에러 핸들링
         print("fail to encode \(String(describing: data))")
         print(error)
      }
      return json
   }
   
   private func getData<T: Decodable>(
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
      var request = URLRequest(url: url)
      print(request)
      request.timeoutInterval = 15
      
      let completionHandler = { @Sendable [weak self] (data: Data?, response: URLResponse?, error: Error?) in
         if let error {
            completion(.failure(error))
            return
         }
         
         guard let response = response as? HTTPURLResponse, (200..<300) ~= response.statusCode else {
            completion(.failure(NetworkError.noResponse))
            print(error)
            return
         }
         
         guard let data else {
            completion(.failure(NetworkError.invalidData))
            return
         }
         
         guard let newData = self?.decodeJson(type: dataType, fromJson: data) else { return }
         completion(.success(newData))
      }
      
      let dataTask = session.dataTask(with: request, handler: completionHandler)
      dataTask.resume()
   }
   
   private func postData<DataType: Encodable, Response: Codable>(
      for urlString: String,
      with query: [String: String]? = nil,
      data: DataType,
      completion: @escaping (Result<Response?, Error>) -> Void)
   {
      guard let url = URL(string: urlString) else { return }
      var request = URLRequest(url: url)
      request.httpMethod = "POST"
      request.addValue("application/json", forHTTPHeaderField: "Content-Type")
      request.timeoutInterval = 15
      
      request.httpBody = encodeJson(data: data)
      
      let dataTask = session.dataTask(with: request) { _, response, error in
         if let error {
            completion(.failure(error))
            return
         }
         
         guard let response = response as? HTTPURLResponse else {
            completion(.failure(NetworkError.noResponse))
            return
         }
         
         switch response.statusCode {
         case (200..<300):
            completion(.success(nil))
            return
         case 400:
            completion(.failure(NetworkError.failToPost))
            return
         default:
            completion(.failure(NetworkError.someError))
            return
         }
      }
      dataTask.resume()
   }
   
   private func patchData<DataType: Encodable, Response: Codable>(
      for urlString: String,
      with query: [String: String]? = nil,
      data: DataType,
      completion: @escaping (Result<Response?, Error>) -> Void)
   {
      guard let url = URL(string: urlString) else { return }
      var request = URLRequest(url: url)
      request.httpMethod = "PATCH"
      request.addValue("application/json", forHTTPHeaderField: "Content-Type")
      request.timeoutInterval = 15
      
      request.httpBody = encodeJson(data: data)
      
      let dataTask = session.dataTask(with: request) { _, response, error in
         if let error {
            completion(.failure(error))
            return
         }
         
         guard let response = response as? HTTPURLResponse else {
            completion(.failure(NetworkError.noResponse))
            return
         }
         
         switch response.statusCode {
         case (200..<300):
            completion(.success(nil))
            return
         case 400:
            completion(.failure(NetworkError.failToPost))
            return
         default:
            completion(.failure(NetworkError.someError))
            return
         }
      }
      dataTask.resume()
   }
   
   private func deleteData(for urlString: String, completion: @escaping (Result<Data?, Error>) -> Void) {
      guard let url = URL(string: urlString) else { return }
      var request = URLRequest(url: url)
      request.httpMethod = "DELETE"
      request.timeoutInterval = 15
      
      let dataTask = session.dataTask(with: request) { _, response, error in
         if let error {
            completion(.failure(error))
            return
         }
         
         guard let response = response as? HTTPURLResponse else {
            completion(.failure(NetworkError.noResponse))
            return
         }
         
         switch response.statusCode {
         case (200..<300):
            completion(.success(nil))
            return
         case 400:
            completion(.failure(NetworkError.failToDelete))
            return
         default:
            completion(.failure(NetworkError.someError))
            return
         }
      }
      dataTask.resume()
   }
   
}

// MARK: - Util

extension NetworkManager {
   func requestIssueList(
      searchQuery: String? = nil,
      filterList: FilterApplyList? = nil,
      pageNumber: Int? = nil,
      completion: @escaping (IssueListDTO) -> Void
   ) {
      let issueListURL = ServerAPI.issueURL
      
      var query: RequestParameters = [:]
      if let filters = filterList?.makeQuery() {
         filters.forEach { filter in query.updateValue(filter.value, forKey: filter.key) }
      }
      
      if let searchQuery {
         query.updateValue(searchQuery, forKey: "search")
      }
      
      if let pageNumber {
         query.updateValue("\(pageNumber)", forKey: "pageNum")
      }
      
      getData(for: issueListURL,
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
   
   func requestIssueDetail(issueId: Int, completion: @escaping (IssueDetailDTO) -> Void) {
      let issueDetailURL = ServerAPI.issueURL + "/\(issueId)"
      
      getData(for: issueDetailURL,
              dataType: IssueDetailDTO.self) { result in
         switch result {
         case .success(let dto):
            completion(dto)
         case .failure(let error):
            print(error)
         }
      }
   }
   
   func deleteIssue(id: Int, completion: @escaping () -> Void) {
      let urlString = ServerAPI.issueURL + "/\(id)"
      deleteData(for: urlString) { (result: Result<Data?, Error>) in
         switch result {
         case .success:
            completion()
         case .failure(let error):
            print(error)
         }
      }
   }
   
   func requestLabelList(completion: @escaping (LabelListDTO) -> Void) {
      let labelListURL = ServerAPI.labelURL
      
      getData(for: labelListURL,
              dataType: LabelListDTO.self) { result in
         switch result {
         case .success(let dto):
            completion(dto)
         case .failure(let error):
            print(error)
         }
      }
   }
   
   func requestMilestoneList(completion: @escaping (MilestoneListDTO) -> Void) {
      let url = ServerAPI.milestoneURL
      
      getData(for: url, dataType: MilestoneListDTO.self) { result in
         switch result {
         case .success(let dto):
            completion(dto)
         case .failure(let error):
            print(error)
         }
      }
   }
}

extension NetworkManager {
   func patchIssue(_ issue: IssuePatchDTO, completion: @escaping () -> Void) {
      let urlString = ServerAPI.issueURL
      patchData(for: urlString, data: issue) { (result: Result<Data?, Error>) in
         switch result {
         case .success:
            completion()
         case .failure(let error):
            print(error)
         }
      }
   }
   
   func patchIssue(id: Int, _ issue: IssueDetailPostDTO, completion: @escaping () -> Void) {
      let urlString = ServerAPI.issueURL
      patchData(for: urlString, data: issue) { (result: Result<Data?, Error>) in
         switch result {
         case .success:
            completion()
         case .failure(let error):
            print(error)
         }
      }
   }
   
   func postNewLabel(_ newLabel: LabelDetailPostDTO, completion: @escaping () -> Void) {
      let urlString = ServerAPI.labelURL
      postData(for: urlString, data: newLabel) { (result: Result<Data?, Error>) in
         switch result {
         case .success:
            completion()
         case .failure(let error):
            print(error)
         }
      }
   }
   
   func patchLabel(id: Int, newDetail: LabelDetailPostDTO, completion: @escaping () -> Void) {
      let urlString = ServerAPI.labelURL + "/\(id)"
      patchData(for: urlString, data: newDetail) { (result: Result<Data?, Error>) in
         switch result {
         case .success:
            completion()
         case .failure(let error):
            print(error)
         }
      }
   }
   
   func deleteLabel(id: Int, completion: @escaping () -> Void) {
      let urlString = ServerAPI.labelURL + "/\(id)"
      deleteData(for: urlString) { (result: Result<Data?, Error>) in
         switch result {
         case .success:
            completion()
         case .failure(let error):
            print(error)
         }
      }
   }
}

extension NetworkManager {
   func getIssueForm(completion: @escaping (IssueFormDTO) -> Void) {
      let urlString = baseURL + "/issues" + "/create"
      getData(for: urlString, dataType: IssueFormDTO.self) { result in
         switch result {
         case .success(let dto):
            completion(dto)
         case .failure(let error):
            print(error)
         }
      }
   }
   
   func postNewIssue(_ newIssue: IssueDetailPostDTO, completion: @escaping () -> Void) {
      let urlString = baseURL + "/issues"
      postData(for: urlString, data: newIssue) { (result: Result<Data?, Error>) in
         switch result {
         case .success:
            completion()
         case .failure(let error):
            print(error)
         }
      }
   }
}
