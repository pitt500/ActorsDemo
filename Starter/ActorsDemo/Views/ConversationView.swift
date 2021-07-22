//
//  ConversationView.swift
//  ConversationView
//
//  Created by Pedro Rojas on 22/07/21.
//

import SwiftUI

struct ConversationView: View {
    @ObservedObject var chatManager: GroupChatViewModel

    var body: some View {
        ScrollViewReader { proxy in
            ScrollView {
                LazyVStack {
                    ForEach(chatManager.messages) { message in
                        MessageView(chatMessage: message)
                            .transition(
                                .move(
                                    edge: message.direction == .left ? .leading : .trailing
                                )
                            )
                    }
                }
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

struct ConversationView_Previews: PreviewProvider {
    static var previews: some View {
        ConversationView(chatManager: GroupChatViewModel())
    }
}
