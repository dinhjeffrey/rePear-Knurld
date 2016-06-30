/* Copyright Sara D. */


import Foundation
import Chatto
import ChattoAdditions

public class FakeMessageSender {
    
    public var onMessageChanged: ((message: MessageModelProtocol) -> Void)?
    
    public func sendMessages(messages: [MessageModelProtocol]) {
        for message in messages {
            self.fakeMessageStatus(message)
        }
    }
    
    public func sendMessage(message: MessageModelProtocol) {
        self.fakeMessageStatus(message)
    }
    
    private func fakeMessageStatus(message: MessageModelProtocol) {
    }
    
    private func updateMessage(message: MessageModelProtocol, status: MessageStatus) {
        if message.status != status {
            message.status = status
            self.notifyMessageChanged(message)
        }
    }
    
    private func notifyMessageChanged(message: MessageModelProtocol) {
        self.onMessageChanged?(message: message)
    }
}
