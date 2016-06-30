/* Copyright Sara D. */

import Foundation
import Chatto

class FakeDataSource: ChatDataSourceProtocol {
    var nextMessageId: Int = 0
    let preferredMaxWindowSize = 500
    
    var slidingWindow: SlidingDataSource<ChatItemProtocol>!
    init(count: Int, pageSize: Int, version: String) {
        self.slidingWindow = SlidingDataSource(count: count, pageSize: pageSize) { () -> ChatItemProtocol in
            defer { self.nextMessageId += 1 }
            if(version == "Chat"){
                return ChatMessageFactory.createChatItem("\(self.nextMessageId)")
            }
            else if(version == "Warning"){
                return WarningMessageFactory.createChatItem("\(self.nextMessageId)")
            }
            else if(version == "Trigger"){
                return TriggerMessageFactory.createChatItem("\(self.nextMessageId)")
            }else{
                return MotivationMessageFactory.createChatItem("\(self.nextMessageId)")
            }
        }
    }
    
    init(messages: [ChatItemProtocol], pageSize: Int) {
        self.slidingWindow = SlidingDataSource(items: messages, pageSize: pageSize)
    }
    
    lazy var messageSender: FakeMessageSender = {
        let sender = FakeMessageSender()
        sender.onMessageChanged = { [weak self] (message) in
            guard let sSelf = self else { return }
            sSelf.delegate?.chatDataSourceDidUpdate(sSelf)
        }
        return sender
    }()
    
    var hasMoreNext: Bool {
        return self.slidingWindow.hasMore()
    }
    
    var hasMorePrevious: Bool {
        return self.slidingWindow.hasPrevious()
    }
    
    var chatItems: [ChatItemProtocol] {
        return self.slidingWindow.itemsInWindow
    }
    
    weak var delegate: ChatDataSourceDelegateProtocol?
    
    func loadNext(completion: () -> Void) {
        self.slidingWindow.loadNext()
        self.slidingWindow.adjustWindow(focusPosition: 1, maxWindowSize: self.preferredMaxWindowSize)
        completion()
    }
    
    func loadPrevious(completion: () -> Void) {
        self.slidingWindow.loadPrevious()
        self.slidingWindow.adjustWindow(focusPosition: 0, maxWindowSize: self.preferredMaxWindowSize)
        completion()
    }
    
    func addTextMessage(text: String, isIncoming: Bool) {
        let uid = "\(self.nextMessageId)"
        self.nextMessageId += 1
        let message = createTextMessageModel(uid, text: text, isIncoming: isIncoming)
        //self.messageSender.sendMessage(message)
        self.slidingWindow.insertItem(message, position: .Bottom)
        self.delegate?.chatDataSourceDidUpdate(self)
    }
    
    func adjustNumberOfMessages(preferredMaxCount preferredMaxCount: Int?, focusPosition: Double, completion:(didAdjust: Bool) -> Void) {
        let didAdjust = self.slidingWindow.adjustWindow(focusPosition: focusPosition, maxWindowSize: preferredMaxCount ?? self.preferredMaxWindowSize)
        completion(didAdjust: didAdjust)
    }
}