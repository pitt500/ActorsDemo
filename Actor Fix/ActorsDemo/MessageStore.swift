//
//  MessageStore.swift
//  MessageStore
//
//  Created by Pedro Rojas on 21/07/21.
//

import Foundation

/// This class is simulating a call to a real API and getting multiple chat messages at the same time.
actor MessageStore {
    private var messageHistory: [Message] = []
    let id = UUID()

    func newMessage(completion: @escaping (Message) async -> Void) async {
        NetworkMessager.shared.fetchMessage { [weak self] message in
            guard let self = self else { return }

            Task {
                await self.saveMessage(message)
                await completion(message)
            }
        }

    }

    func saveMessage(_ message: Message) {
        messageHistory.append(message)
    }

    func history() async -> [Message] {
        self.messageHistory
    }
}

extension MessageStore: Equatable {
    // No self instance required because it's a static method.
    // This implementation only access immutable states.
    static func == (lhs: MessageStore, rhs: MessageStore) -> Bool {
        return lhs.id == rhs.id
    }
}

extension MessageStore: Hashable {
    // This function requires to be nonisolated to exclude it from the actor protection.
    // Otherwise we are not satisfying protocol requirements or breaking actor-isolation.
    nonisolated func hash(into hasher: inout Hasher) {
        //Actor-isolated property 'messageHistory' can not be referenced from a non-isolated context
        hasher.combine(id)
    }

    // We need to add this to fulfill requirements
    nonisolated var hashValue: Int {
        return id.hashValue
    }
}

















