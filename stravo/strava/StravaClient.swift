//
//  StravaClient.swift
//  stravo
//
//  Created by Robert Hamilton on 31/01/2020.
//  Copyright © 2020 Robert Hamilton. All rights reserved.
//

import Foundation
import OAuthSwift

/// A class through which authenticate with and query the Strava API.
class StravaClient: Authenticating, APIClient {
    /// A shared instance
    static let shared = StravaClient()
    private static let baseURL = Environment.stravaBaseURL
    let endpoint = "\(StravaClient.baseURL)/api/v3/"
    let callbackURLPath = "strava"
    
    private let authenticator: OAuth2Swift
    private (set) var authenticated: Bool = false
    
    internal init() {
        authenticator = OAuth2Swift(
            consumerKey:    Environment.stravaKey,
            consumerSecret: Environment.stravaSecret,
            authorizeUrl:   "\(StravaClient.baseURL)/oauth/authorize",
            accessTokenUrl: "\(StravaClient.baseURL)/oauth/token",
            responseType:   "code"
        )
        if let accessToken = KeychainHelper.stravaAccessToken,
            let refreshToken = KeychainHelper.stravaRefreshToken {
            authenticator.client.credential.oauthToken = accessToken
            authenticator.client.credential.oauthRefreshToken = refreshToken
            authenticated = true
        }
    }
    
    private var authHeader: [String: String] {
        return ["Authorization": "Bearer \(authenticator.client.credential.oauthToken)"]
    }
    
    func authenticate(completion: ((Bool) -> Void)? = nil) {
        // TODO 2: scope, state and parameters should not be hard-coded. There should be a Strava
        // API helpers or config file for this.
        authenticator.authorize(
            withCallbackURL: callbackURL,
            scope: "activity:read_all",
            state: "someState",
            parameters: [
                "approval_prompt": "force",
                "grant_type":      "authorization_code"
            ]
        ) { result in
            switch result {
            case .success(let credential, _, _):
                self.authenticated = true
                KeychainHelper.stravaAccessToken = credential.oauthToken
                KeychainHelper.stravaRefreshToken = credential.oauthRefreshToken
                if let completion = completion {
                    completion(true)
                }
            case .failure(_):
                self.authenticated = false
                if let completion = completion {
                    completion(false)
                }
            }
        }
    }
    
    
    func makeRequest<T: APIRequest>(
        _ request: T, completion: @escaping RequestResponse<T.entity>
    ){
        authenticator.client.get(
            endpoint.appending(request.resourcePath),
            parameters: request.parameters ?? [:],
            headers: authHeader
        ) { result in
            switch result {
            case .success(let response):
                do {
                    let results = try JSONDecoder().decode(T.entity.self, from: response.data)
                    completion(.success(results))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                // TODO 3: if this fails because the app is no longer authorized, the app should
                // re-show the OOB log in flow
                completion(.failure(error))
            }
        }
    }
}
