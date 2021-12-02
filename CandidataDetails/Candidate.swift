//
//  Candidate.swift
//  CandidataDetails
//
//  Created by Udagedara Dehigama on 2021/12/02.
//

import Foundation
struct Candidate : Codable{
  
    let results:[Results]
   
}

struct Results: Codable {
    let name: Names
    let location: Location?
    let email: String?
    let dob: Dob
    let phone: String?
    let cell: String?
    let picture: Picture
}
struct Names: Codable {
    let title: String
    let first: String
    let last: String
}
struct Location: Codable {
    let street: Street?
    let city: String?
    let state: String?
    let country: String?
    
    
}
struct Street: Codable {
    let number: Int
    let name: String
}

struct Dob: Codable {
    let date: String
    let age: Int
}
struct Picture: Codable {
    let thumbnail: String
    let large: String
    
}
