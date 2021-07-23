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

    func newMessage(completion: @escaping (Message) -> Void) async {
        print("HHHH")

        //More than one concurrent thread at the same time will crash the app at some point!
        //Change this code to only 1 and will work as expected
        let randomNumberOfMessages = Int.random(in: 1...10)

        DispatchQueue.concurrentPerform(iterations: randomNumberOfMessages) { iteration in
            let message = Message(content: "Message #\(iteration)")

            Task {
                await self.saveMessage(message)
                print(message)
                completion(message)
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

















