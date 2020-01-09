//
//  APIController.swift
//  Binge
//
//  Created by Ciara Beitel on 1/3/20.
//  Copyright © 2020 Ciara Beitel. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class APIController {
    typealias JWT = String
    private let apikey = "44a99549b72525fe8fad6a779408b1eb"
    private let userkey = "5E0A6CEB362AC1.19334680"
    private let username = "ciarabeitel"
    private let baseURL = URL(string: "https://api.thetvdb.com")!
    private var authToken: JWT?
    private let sessionManager = Alamofire.SessionManager()
    private let queue = DispatchQueue(label: "com.ciaranotclara.Binge")
    
    // static properties are available only ON the class, not the INSTANCE of the class
    static let shared = APIController()
    
    private init() {
        if authToken == nil {
            self.login() { token in
                self.sessionManager.adapter = JWTAccessTokenAdapter(authToken: token)
            }
        }
    }
    
    func login(completion: @escaping(JWT) -> Void ) {
        queue.sync {
            if let authToken = self.authToken {
                return completion(authToken)
            }
            let loginDetails = ["apikey": self.apikey, "userkey": self.userkey, "username": self.username]
            Alamofire.request("https://api.thetvdb.com/login",
                              method: .post,
                              parameters: loginDetails,
                              encoding: Alamofire.JSONEncoding.default).responseJSON { response in
                                switch(response.result) {
                                case .success(let value):
                                    // JSON is SwiftyJSON
                                    let jsonData = JSON(value)
                                    self.authToken = jsonData["token"].stringValue
                                    completion(jsonData["token"].stringValue)
                                case .failure(_):
                                    // TODO: handle 401 when credentials are incorrect
                                    print("error")
                                }
            }
        }
    }
    
    func refreshToken(completion: @escaping(JWT) -> Void) {
        let _ = queue.sync {
            sessionManager.request("https://api.thetvdb.com/refresh_token").responseJSON { response in
                switch response.result {
                case .success(let value):
                    let jsonData = JSON(value)
                    let token = jsonData["token"].stringValue
                    completion(token)
                case .failure(_):
                    // TODO: handle 401 when JWT is missing or expired
                    debugPrint("error")
                }
            }
        }
    }
    
    func searchShows(name: String, onSuccess: @escaping([ShowRepresentation?]) -> Void) {
        queue.sync {
            // The TV DB requires parameters and AF likes them as a dictionary [String: String]
            let parameters = ["name": name]
        
            sessionManager.request("https://api.thetvdb.com/search/series", parameters: parameters).responseJSON { response in
                switch (response.result) {
                case .success(let value):
                    let jsonData = JSON(value)
                    let searchResultsArray = jsonData["data"].arrayValue
                    var searchResults: [ShowRepresentation] = []
                    DispatchQueue.main.async {
                        for searchResult in searchResultsArray {
                            let formatter = DateFormatter()
                            formatter.dateFormat = "yyyy-MM-dd"
                            let date = formatter.date(from: searchResult["firstAired"].stringValue)
                            let nsId = searchResult["id"].numberValue
                            let show = ShowRepresentation(
                                banner: searchResult["banner"].stringValue,
                                id: nsId.int16Value,
                                name: searchResult["seriesName"].stringValue,
                                network: searchResult["network"].stringValue,
                                overview: searchResult["overview"].stringValue,
                                releaseDate: date ?? nil,
                                status: searchResult["status"].stringValue
                            )
                            searchResults.append(show)
                        }
                        onSuccess(searchResults)
                    }
                case .failure(_):
                    // TODO: handle 401 auth token is missing or expired
                    // TODO: handle 404 no results found
                    print("failure")
                }
            }
        }
    }
}

// MARK - Alamofire delegates

final class JWTAccessTokenAdapter: RequestAdapter {
    typealias JWT = String
    private var authToken: JWT

    init(authToken: JWT) {
        self.authToken = authToken
    }
    
    func should(_ manager: SessionManager, retry request: Request, with error: Error, completion: @escaping RequestRetryCompletion) {
        guard let response = request.task?.response as? HTTPURLResponse, response.statusCode == 401 else {
            completion(false, 0.0)
            return
        }
        // TODO: How many times do we try refreshing the token?
        
        APIController.shared.refreshToken { [weak self] authToken in
            guard let strongSelf = self else { return }

            strongSelf.authToken = authToken
            completion(true, 0.0)
        }
    }

    func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        var urlRequest = urlRequest
        if let urlString = urlRequest.url?.absoluteString, urlString.hasPrefix("https://api.thetvdb.com") {
            urlRequest.setValue("Bearer " + self.authToken, forHTTPHeaderField: "Authorization")
        }
        return urlRequest
    }
}
