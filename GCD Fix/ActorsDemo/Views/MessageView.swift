//
//  MessageView.swift
//  MessageView
//
//  Created by Pedro Rojas on 22/07/21.
//

import SwiftUI

struct MessageView: View {
    let chatMessage: ChatMessage
    
    var body: some View {
        ChatBubble(direction: chatMessage.direction) {
            Text(chatMessage.message.content)
                .padding(.all, 20)
                .background(chatMessage.direction == .left ? .green : .blue)
                .foregroundColor(.white)
        }
        .id(chatMessage.id)
    }


}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView(
            chatMessage: ChatMessage(
                message: Message(content: "This is Swift and Tips!😉"),
                direction: .left
            )
        )
    }
}
