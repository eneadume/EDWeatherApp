//
//  URLEncodeTest.swift
//  weather-appTests
//
//  Created by Enea Dume on 30.6.21.
//

import XCTest
@testable import weather_app
class URLEncodeTest: XCTestCase {

    func testURLEncoding() {
        guard let url = URL(string: "https:www.google.com/") else {
            XCTAssertTrue(false, "Could not instantiate url")
            return
        }
        var urlRequest = URLRequest(url: url)
        let parameters: Parameters = [
            "UserID": 1,
            "Name": "Enea",
            "Email": "enea@test.com",
            "isDone": true
        ]
        
        do {
            let encoder = URLParameterEncoder()
            try encoder.encode(urlRequest: &urlRequest, with: parameters)
            guard let fullURL = urlRequest.url else {
                XCTAssertTrue(false, "urlRequest url is nil.")
                return
            }

            let expectedURL = "https:www.google.com/?Name=Enea&Email=enea%2540test.com&UserID=1&isDone=true"
            XCTAssertEqual(fullURL.absoluteString.sorted(), expectedURL.sorted())
        }catch {
            
        }
        
        
    }

}
