//
//  ActorModel.swift
//  ActorModel
//
//  Created by Pedro Rojas on 19/07/21.
//

import SwiftUI

class GroupChatViewModel: ObservableObject {
    @Published var messages: [ChatMessage] = []
    @Published var text = ""
    let store = MessageStore()

    func addNewMessage(_ message: Message) {
        let direction: ChatBubbleShape.Direction = Bool.random() ? .left : .right

        withAnimation {
            messages.append(ChatMessage(message: message, direction: direction))
        }
    }

    func addNewMessageFromTextField() {
        let message = Message(content: text, date: Date.now)
        withAnimation {
            messages.append(ChatMessage(message: message, direction: .right))
        }
        text = ""
    }

    var isTextfieldEmpty: Bool {
        text.isEmpty
    }

    func getHistory() -> [Message] {
        store.messageHistory
    }

    func serviceId() -> UUID {
        return store.id
    }
}

extension GroupChatViewModel {
    var last: ChatMessage? {
        messages.last
    }

    var first: ChatMessage? {
        messages.first
    }
}

extension GroupChatViewModel {
    func generateMessages() {
        print("Invoking messages")
        store.newMessage { [weak self] message in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.addNewMessage(message)
            }
        }
    }
}
