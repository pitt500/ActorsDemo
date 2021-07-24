//
//  MessageStore.swift
//  MessageStore
//
//  Created by Pedro Rojas on 21/07/21.
//

import Foundation

/// This class is simulating a call to a real API and getting multiple chat messages at the same time.
class MessageStore {
    var messageHistory: [Message] = []
    let id = UUID()

    //Creating a private queue
    private let queue = DispatchQueue(label: "com.swiftandtips.actors")

    func newMessage(completion: @escaping (Message) -> Void) {
        NetworkMessager.shared.fetchMessage { [weak self] message in
            guard let self = self else { return }
            //Executing a sync operation fix the problem... but is the only possible data race?
            self.queue.sync {
                self.messageHistory.append(message)
                completion(message)
            }
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
