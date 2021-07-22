//
//  ContentView.swift
//  ActorsDemo
//
//  Created by Pedro Rojas on 19/07/21.
//

import SwiftUI

struct GroupChatView: View {
    @StateObject private var groupChatVM = GroupChatViewModel()

    var body: some View {
        NavigationView {
            VStack {
                ConversationView(viewModel: groupChatVM)
                Divider()
                ChatTextfield(viewModel: groupChatVM)
                .padding(10)
            }
            .navigationTitle("Actors Demo!")
        }
        .onAppear {
            groupChatVM.generateMessages()
        }

    }
}

struct GroupChatView_Previews: PreviewProvider {
    static var previews: some View {
        GroupChatView()
    }
}