//
//  GeneralChat.swift
//  rePear
//
//  Created by Sara Du on 5/21/16.
//  Copyright © 2016 Sara Du. All rights reserved.
//

import UIKit
import Chatto
import ChattoAdditions

class GeneralChat: ChatViewController {
    var messageSender: FakeMessageSender!
    var currtxt = ""
    var advicetxt = ""

    var dataSource: FakeDataSource! {
        didSet {
            self.chatDataSource = self.dataSource
        }
    }
    
    lazy private var baseMessageHandler: BaseMessageHandler = {
        return BaseMessageHandler(messageSender: self.messageSender)
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _ = UIImage(named: "bubble-incoming-tail-border", inBundle: NSBundle(forClass: self.dynamicType), compatibleWithTraitCollection: nil)?.bma_tintWithColor(UIColor.blueColor())
        super.chatItemsDecorator = ChatItemsDemoDecorator()
        
    }
    
    var chatInputPresenter: ChatInputBarPresenter!
    override func createChatInputView() -> UIView {
        let chatInputView = ChatInputBar.loadNib()
        self.configureChatInputBar(chatInputView)
        self.chatInputPresenter = ChatInputBarPresenter(chatInputView: chatInputView, chatInputItems: self.createChatInputItems())
        return chatInputView
    }
    
    func configureChatInputBar(chatInputBar: ChatInputBar) {
        var appearance = ChatInputBarAppearance()
        appearance.sendButtonTitle = NSLocalizedString("Send", comment: "")
        appearance.textPlaceholder = NSLocalizedString("Type a message", comment: "")
        chatInputBar.setAppearance(appearance)
    }
    
    override func createPresenterBuilders() -> [ChatItemType: [ChatItemPresenterBuilderProtocol]] {
        return [
            TextMessageModel.chatItemType: [
                TextMessagePresenterBuilder(
                    viewModelBuilder: TextMessageViewModelDefaultBuilder(),
                    interactionHandler: TextMessageHandler(baseHandler: self.baseMessageHandler)
                )
            ]
        ]
    }
    
    func createChatInputItems() -> [ChatInputItemProtocol] {
        var items = [ChatInputItemProtocol]()
        items.append(self.createTextInputItem())
        //items.append(self.createPhotoInputItem())
        return items
    }
    
    //receiving inputted message
    private func createTextInputItem() -> TextChatInputItem {
        
        let item = TextChatInputItem()
        item.textInputHandler = { [weak self] text in
            self?.dataSource.addTextMessage(text, isIncoming: false)
            
            self?.currtxt = text
            
            //positive
            if(ChatMessageFactory.messageindex == 0 && self?.currtxt.lowercaseString == "positive"){
                ChatMessageFactory.messageindex = 2
                self?.dataSource.addTextMessage(ChatMessageFactory.demoTexts[2], isIncoming: true)
            }
            else if(ChatMessageFactory.messageindex == 2){
                self?.advicetxt = text
                ChatMessageFactory.messageindex = 3
                self?.dataSource.addTextMessage(ChatMessageFactory.demoTexts[3], isIncoming: true)
            }
                //yes to share -> take screenshot
                else if(ChatMessageFactory.messageindex == 3 && self?.currtxt.lowercaseString == "yes"){
                let shareVC: UIActivityViewController = UIActivityViewController(activityItems: [(self?.advicetxt)!], applicationActivities: nil)
                self!.presentViewController(shareVC, animated: true, completion: nil)

                    self?.dataSource.addTextMessage(ChatMessageFactory.demoTexts[5], isIncoming: true)
                    ChatMessageFactory.messageindex = 9
                    self?.dataSource.addTextMessage(ChatMessageFactory.demoTexts[9], isIncoming: true)
                }
                //no to share
                else if(ChatMessageFactory.messageindex == 3 && self?.currtxt.lowercaseString == "no"){
                    ChatMessageFactory.messageindex = 4
                    self?.dataSource.addTextMessage(ChatMessageFactory.demoTexts[4], isIncoming: true)
                }
            //negative
            else if(ChatMessageFactory.messageindex == 0 && self?.currtxt.lowercaseString == "negative"){
                ChatMessageFactory.messageindex = 6
                self?.dataSource.addTextMessage(ChatMessageFactory.demoTexts[6], isIncoming: true)

            }
                //not sure
                else if(ChatMessageFactory.messageindex == 6 && self?.currtxt.lowercaseString == "not sure"){
                    ChatMessageFactory.messageindex = 7
                    self?.dataSource.addTextMessage(ChatMessageFactory.demoTexts[7], isIncoming: true)
                    self?.dataSource.addTextMessage(ChatMessageFactory.demoTexts[10], isIncoming: true)
                    ChatMessageFactory.messageindex = 0
                
                }
            
                //other reason
                else if(ChatMessageFactory.messageindex == 6){
                    self?.dataSource.addTextMessage(ChatMessageFactory.demoTexts[8], isIncoming: true)
                    ChatMessageFactory.messageindex = 10
                    self?.dataSource.addTextMessage(ChatMessageFactory.demoTexts[10], isIncoming: true)
                    ChatMessageFactory.messageindex = 0
                
                
                }
            else{
                self?.dataSource.addTextMessage(ChatMessageFactory.demoTexts[11], isIncoming: true)
            }
        }
        return item
    }
    
}
