//
//  ChatTextfield.swift
//  ChatTextfield
//
//  Created by Pedro Rojas on 22/07/21.
//

import SwiftUI

struct ChatTextfield: View {
    @ObservedObject var viewModel: GroupChatViewModel

    var body: some View {
        HStack {
            TextField("Enter your message", text: $viewModel.text)
                .padding([.leading, .trailing], 10)
            Button {
                viewModel.addNewMessageFromTextField()
            } label: {
                Image(systemName: buttonImageName)
                    .resizable()
                    .frame(width: 20, height: 20)
            }
            .disabled(viewModel.isTextfieldEmpty)
        }
    }
}

extension ChatTextfield {
    var buttonImageName: String {
        viewModel.isTextfieldEmpty ? "paperplane" : "paperplane.fill"
    }
}

struct ChatTextfield_Previews: PreviewProvider {
    static var previews: some View {
        ChatTextfield(viewModel: GroupChatViewModel())
    }
}
