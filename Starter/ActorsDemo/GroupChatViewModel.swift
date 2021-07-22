//
//  ActorModel.swift
//  ActorModel
//
//  Created by Pedro Rojas on 19/07/21.
//

import SwiftUI

class GroupChatViewModel: ObservableObject {
    @Published var messages: [ChatMessage] = []
    let service = ChatService()

    func addNewMessage(_ message: Message) {
        let direction: ChatBubbleShape.Direction = Bool.random() ? .left : .right

        withAnimation {
            messages.append(ChatMessage(message: message, direction: direction))
        }
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
        service.newMessage { [weak self] message in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.addNewMessage(message)
            }
        }
    }
}

//extension ChatManager
//
//extension Book: Hashable {
//    nonisolated func hash(into hasher: inout Hasher) {
//        hasher.combine(id)
//    }
//}
//
//extension Book: Equatable {
//    static func == (lhs: Book, rhs: Book) -> Bool {
//        lhs.id == rhs.id
//    }
//}
