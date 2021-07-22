//
//  ContentView.swift
//  ActorsDemo
//
//  Created by Pedro Rojas on 19/07/21.
//

import SwiftUI

struct GroupChatView: View {
    @StateObject private var chatManager = GroupChat()

    var body: some View {
        List(chatManager.messages) { message in
            Text("\(message.content)")
        }
            .onAppear {
                chatManager.generateMessages()
            }
            .padding()
    }
}

struct GroupChatView_Previews: PreviewProvider {
    static var previews: some View {
        GroupChatView()
    }
}
