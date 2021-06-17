//
//  DailyWisdom.swift
//  Wakey
//
//  Created by Student on 16.06.21.
//

import Foundation

import Foundation

// MARK: - Welcome
struct Welcome: Codable {
    let success: Success
    let contents: Contents
    let baseurl: String
    let copyright: Copyright
}

// MARK: - Contents
struct Contents: Codable {
    let quotes: [Quote]
}

// MARK: - Quote
struct Quote: Codable {
    let quote, length, author: String
    let tags: [String]
    let category, language, date: String
    let permalink: String
    let id: String
    let background: String
    let title: String
}

// MARK: - Copyright
struct Copyright: Codable {
    let year: Int
    let url: String
}

// MARK: - Success
struct Success: Codable {
    let total: Int
}
