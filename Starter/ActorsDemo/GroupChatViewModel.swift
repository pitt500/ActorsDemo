//
//  ActorModel.swift
//  ActorModel
//
//  Created by Pedro Rojas on 19/07/21.
//

import SwiftUI

class GroupChatViewModel: ObservableObject {
    @Published var messages: [Message] = []
    let service = ChatService()
}

extension GroupChatViewModel {
    var last: Message? {
        messages.last
    }

    var first: Message? {
        messages.first
    }
}

extension GroupChatViewModel {
    func generateMessages() {
        service.newMessage { message in
            DispatchQueue.main.async {
                self.messages.append(message)
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
