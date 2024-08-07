//
//  PagenationModel.swift
//  Swift-Pagenation
//
//  Created by M.Ömer Ünver on 6.08.2024.
//

import Foundation

struct Users : Codable {
    var page : Int
    var per_page : Int
    var total : Int
    var total_pages : Int
    var data : [User]
}

struct User : Identifiable , Codable {
    var id : Int
    var email : String
    var first_name : String
    var last_name : String
    var avatar : String
}
