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
        NavigationView {
            VStack {
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
                Divider()
                HStack {
                    TextField("Enter your message", text: $chatManager.text)
                        .padding([.leading, .trailing], 10)
                    Button {
                        chatManager.addNewMessageFromTextField()
                    } label: {
                        Image(systemName: "paperplane.fill")
                            .resizable()
                            .frame(width: 20, height: 20)
                    }


                }
                .padding(10)
            }
            .navigationTitle("Actors Demo!")
        }
        .onAppear {
            chatManager.generateMessages()
        }

    }
}

struct GroupChatView_Previews: PreviewProvider {
    static var previews: some View {
        GroupChatView()
    }
}
