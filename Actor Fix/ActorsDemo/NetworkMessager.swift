//
//  NetworkMessager.swift
//  NetworkMessager
//
//  Created by Pedro Rojas on 23/07/21.
//

import Foundation

/// This class is simulating a call to a real API and getting multiple chat messages at the same time.
class NetworkMessager {
    static let shared = NetworkMessager()

    private init() {}

    func fetchMessage (_  completion: @escaping (Message) -> Void) {
        //More than one concurrent thread at the same time will crash the app at some point!
        //Change this code to only 1 and will work as expected
        let randomNumberOfMessages = Int.random(in: 1...10)

        print("Receiving \(randomNumberOfMessages) messages")
        DispatchQueue.concurrentPerform(iterations: randomNumberOfMessages) { iteration in
            let message = Message(content: "Message #\(iteration)")
            completion(message)

        }
    }
}
