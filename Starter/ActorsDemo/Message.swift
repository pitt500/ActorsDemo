//
//  Message.swift
//  Message
//
//  Created by Pedro Rojas on 21/07/21.
//

import Foundation

struct Message {
    let content: String
    let date: Date

    init(content: String, date: Date = Date()) {
        self.content = content
        self.date = date
    }
}
