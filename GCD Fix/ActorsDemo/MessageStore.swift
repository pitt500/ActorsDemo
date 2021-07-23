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

    func newMessage(completion: (Message) -> Void) {
        //More than one concurrent thread at the same time will crash the app at some point!
        //Change this code to only 1 and will work as expected
        let randomNumberOfMessages = Int.random(in: 1...10)

        print("Receiving \(randomNumberOfMessages) messages")
        DispatchQueue.concurrentPerform(iterations: randomNumberOfMessages) { iteration in

            let message = Message(content: "Message #\(iteration)")
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
