//
//  ProfileModel.swift
//  payapp
//
//  Created by Georgy on 2025-07-04.
//
import UIKit

struct ProfileModel: Codable {
    let name: String
    let age: Int
    let flag: String
    let imageName: String
    let statusText: String
    let statusColorHex: String
    
    var statusColor: UIColor {
        UIColor(hex: statusColorHex) ?? .gray
    }
}
