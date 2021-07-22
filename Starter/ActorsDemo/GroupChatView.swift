//
//  ContentView.swift
//  ActorsDemo
//
//  Created by Pedro Rojas on 19/07/21.
//

import SwiftUI

struct GroupChatView: View {
    @StateObject private var chatManager = GroupChatViewModel()

    var body: some View {
        ScrollViewReader { proxy in
            ScrollView {
                LazyVStack {
                    ForEach(chatManager.messages) {
                        MessageView(chatMessage: $0)
                    }
                }
            }
            .onAppear {
                chatManager.generateMessages()
            }
            .onChange(of: chatManager.messages) { _ in
                if let last = chatManager.last {
                    withAnimation(.easeOut) {
                        proxy.scrollTo(last.id)
                    }
                }
            }
        }
    }
}

struct GroupChatView_Previews: PreviewProvider {
    static var previews: some View {
        GroupChatView()
    }
}
