//
//  ChatService.swift
//  ChatService
//
//  Created by Pedro Rojas on 21/07/21.
//

import Foundation

class ChatService {
    private var messageHistory: [Message] = []

    func newMessage(completion: @escaping (Message) -> Void) {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {  [weak self] _ in
            guard let self = self else { return }
            let randomNumberOfMessages = 1//Int.random(in: 1...10)
            DispatchQueue.concurrentPerform(iterations: randomNumberOfMessages) { iteration in
                let message = Message(content: "Message #\(iteration)")
                self.messageHistory.append(message)
                completion(message)
            }
        }
    }
}
