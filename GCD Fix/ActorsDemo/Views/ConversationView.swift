//
//  ConversationView.swift
//  ConversationView
//
//  Created by Pedro Rojas on 22/07/21.
//

import SwiftUI

struct ConversationView: View {
    @ObservedObject var viewModel: GroupChatViewModel

    var body: some View {
        ScrollViewReader { proxy in
            ScrollView {
                LazyVStack {
                    ForEach(viewModel.messages) { message in
                        MessageView(chatMessage: message)
                            .transition(
                                .move(
                                    edge: message.direction == .left ? .leading : .trailing
                                )
                            )
                    }
                }
            }
            .onChange(of: viewModel.messages) { _ in
                if let last = viewModel.last {
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
        ConversationView(viewModel: GroupChatViewModel())
    }
}
