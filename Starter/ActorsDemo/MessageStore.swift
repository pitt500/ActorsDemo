//
//  MessageStore.swift
//  MessageStore
//
//  Created by Pedro Rojas on 21/07/21.
//

import Foundation

class MessageStore {
    var messageHistory: [Message] = []
    let id = UUID()

    func newMessage(completion: @escaping (Message) -> Void) {
        NetworkMessager.shared.fetchMessage { [weak self] message in
            guard let self = self else { return }
            self.messageHistory.append(message)
            completion(message)
        }

    }

    func history() -> [Message] {
        self.messageHistory
    }
}

extension MessageStore: Equatable {
    static func == (lhs: MessageStore, rhs: MessageStore) -> Bool {
        return lhs.id == rhs.id
    }
}

extension MessageStore: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(messageHistory)
    }
}
