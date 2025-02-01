//
//  Item.swift
//  Todo List App
//
//  Created by Alisa Ho on 25/3/2024.
//

import Foundation

//struct Group
//{
//    var id = UUID()
//    let name: String
//    var items: [Item] = []
//}

struct Item: Identifiable, Codable
{
    var id = UUID()
    let name: String
    var done = false
    let scheduleTime: Bool
    let dueDate: Date
    let bgColor: String
    
}


