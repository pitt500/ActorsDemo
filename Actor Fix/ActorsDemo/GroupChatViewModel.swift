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

    // We are decorating with @MainActor all methods
    // that are mutating states to only doing it in the main thread
    @MainActor func addNewMessage(_ message: Message) {
        let direction: ChatBubbleShape.Direction = Bool.random() ? .left : .right

        withAnimation {
            messages.append(ChatMessage(message: message, direction: direction))
        }
    }

    @MainActor func addNewMessageFromTextField() {
        let message = Message(content: text, date: Date.now)
        withAnimation {
            messages.append(ChatMessage(message: message, direction: .right))
        }
        text = ""
    }

    var isTextfieldEmpty: Bool {
        text.isEmpty
    }

    func history() async -> [Message] {
        await store.history()
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

    func generateMessages() async {
        print("Invoking messages")
        await store.newMessage { [weak self] message in
            guard let self = self else { return }

            // Using @MainActor, now our function is actor-isolated
            // and requires to run in an asynchronous context.
            // More details here: https://youtu.be/8jvtHCXJ4Ow
            Task{
                await self.addNewMessage(message)
            }
        }
    }
}
