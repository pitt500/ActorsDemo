//
//  MessageView.swift
//  MessageView
//
//  Created by Pedro Rojas on 22/07/21.
//

import SwiftUI

struct MessageView: View {
    let message: Message
    
    var body: some View {
        Text(message.content)
            .id(message.id)
            .frame(height: 200)
    }
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView(
            message: Message(content: "This is Swift and Tips!😉")
        )
    }
}
