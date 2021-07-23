//
//  ChatMessage.swift
//  ChatMessage
//
//  Created by Pedro Rojas on 22/07/21.
//

import Foundation

struct ChatMessage: Identifiable {
    let message: Message
    let id: UUID
    let direction: ChatBubbleShape.Direction

    init(id: UUID = UUID(), message: Message, direction: ChatBubbleShape.Direction) {
        self.id = id
        self.message = message
        self.direction = direction
    }
}

extension ChatMessage: Equatable {
    static func == (lhs: ChatMessage, rhs: ChatMessage) -> Bool {
        lhs.id == rhs.id
    }
}
