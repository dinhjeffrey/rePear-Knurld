//
//  Trigger.swift
//  rePear
//
//  Created by Sara Du on 5/21/16.
//  Copyright © 2016 Sara Du. All rights reserved.
//

import UIKit
import Chatto
import ChattoAdditions

class Trigger: ChatViewController {
    var messageSender: FakeMessageSender!
    var currtxt = ""

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
            
            if(TriggerMessageFactory.messageindex == 0){
                TriggerMessageFactory.messageindex = 1
                self?.dataSource.addTextMessage(TriggerMessageFactory.demoTexts[1], isIncoming: true)
            }
            //yes to quiz
            else if(TriggerMessageFactory.messageindex == 1 && self?.currtxt.lowercaseString == "yes"){
                TriggerMessageFactory.messageindex = 3
                self?.dataSource.addTextMessage(TriggerMessageFactory.demoTexts[3], isIncoming: true)
            }
                //yes to recording
                else if(TriggerMessageFactory.messageindex == 3 && self?.currtxt.lowercaseString == "yes"){
                    TriggerMessageFactory.messageindex = 6
                    self?.dataSource.addTextMessage(TriggerMessageFactory.demoTexts[4], isIncoming: true)
                    self?.dataSource.addTextMessage(TriggerMessageFactory.demoTexts[6], isIncoming: true)
                self?.dataSource.addTextMessage(TriggerMessageFactory.demoTexts[7], isIncoming: true)
                TriggerMessageFactory.messageindex = 7
                

                }
                //no to recording
                else if(TriggerMessageFactory.messageindex == 3 && self?.currtxt.lowercaseString == "no"){
                    TriggerMessageFactory.messageindex = 6
                    self?.dataSource.addTextMessage(TriggerMessageFactory.demoTexts[5], isIncoming: true)
                    self?.dataSource.addTextMessage(TriggerMessageFactory.demoTexts[6], isIncoming: true)
                self?.dataSource.addTextMessage(TriggerMessageFactory.demoTexts[7], isIncoming: true)
                TriggerMessageFactory.messageindex = 7
                

                }
            else if(self?.currtxt.lowercaseString == "stop"){
                TriggerMessageFactory.messageindex = 17
                self?.dataSource.addTextMessage(TriggerMessageFactory.demoTexts[17], isIncoming: true)
            }
            else if(TriggerMessageFactory.messageindex == 7){
                self?.dataSource.addTextMessage(TriggerMessageFactory.demoTexts[8], isIncoming: true)
                TriggerMessageFactory.messageindex = 8

            }
            else if(TriggerMessageFactory.messageindex == 8){
                self?.dataSource.addTextMessage(TriggerMessageFactory.demoTexts[9], isIncoming: true)
                TriggerMessageFactory.messageindex = 9

            }
            else if(TriggerMessageFactory.messageindex == 9){
                self?.dataSource.addTextMessage(TriggerMessageFactory.demoTexts[10], isIncoming: true)
                TriggerMessageFactory.messageindex = 10
            }
            else if(TriggerMessageFactory.messageindex == 10){
                self?.dataSource.addTextMessage(TriggerMessageFactory.demoTexts[11], isIncoming: true)
                TriggerMessageFactory.messageindex = 11
            }
            else if(TriggerMessageFactory.messageindex == 11){
                self?.dataSource.addTextMessage(TriggerMessageFactory.demoTexts[12], isIncoming: true)
                TriggerMessageFactory.messageindex = 12
            }
            else if(TriggerMessageFactory.messageindex == 12){
                self?.dataSource.addTextMessage(TriggerMessageFactory.demoTexts[13], isIncoming: true)
                TriggerMessageFactory.messageindex = 13
            }
            else if(TriggerMessageFactory.messageindex == 13){
                self?.dataSource.addTextMessage(TriggerMessageFactory.demoTexts[14], isIncoming: true)
                TriggerMessageFactory.messageindex = 14
            }
            else if(TriggerMessageFactory.messageindex == 14){
                self?.dataSource.addTextMessage(TriggerMessageFactory.demoTexts[15], isIncoming: true)
                TriggerMessageFactory.messageindex = 15
            }
            else if(TriggerMessageFactory.messageindex == 15){
                self?.dataSource.addTextMessage(TriggerMessageFactory.demoTexts[16], isIncoming: true)
                TriggerMessageFactory.messageindex = 16
            }
            else if(TriggerMessageFactory.messageindex == 16){
                self?.dataSource.addTextMessage(TriggerMessageFactory.demoTexts[17], isIncoming: true)
                TriggerMessageFactory.messageindex = 17
            }

            
            //no to quiz
            else if(TriggerMessageFactory.messageindex == 1 && self?.currtxt.lowercaseString == "no"){
                TriggerMessageFactory.messageindex = 17

                self?.dataSource.addTextMessage(TriggerMessageFactory.demoTexts[5], isIncoming: true)
                self?.dataSource.addTextMessage(TriggerMessageFactory.demoTexts[17], isIncoming: true)
            }
            
            //yes to start of sharing experience
            else if(TriggerMessageFactory.messageindex == 17 && self?.currtxt.lowercaseString == "yes"){
                self?.dataSource.addTextMessage(TriggerMessageFactory.demoTexts[18], isIncoming: true)
                TriggerMessageFactory.messageindex = 18
            }
            else if(TriggerMessageFactory.messageindex == 18){
                self?.dataSource.addTextMessage(TriggerMessageFactory.demoTexts[19], isIncoming: true)
                TriggerMessageFactory.messageindex = 19
            }
            else if(TriggerMessageFactory.messageindex == 19){
                self?.dataSource.addTextMessage(TriggerMessageFactory.demoTexts[20], isIncoming: true)
                TriggerMessageFactory.messageindex = 20
            }
            //end of convo
            else if(TriggerMessageFactory.messageindex == 20){
                self?.dataSource.addTextMessage(TriggerMessageFactory.demoTexts[2], isIncoming: true)
                TriggerMessageFactory.messageindex = 0
            }
            
                //no to start of sharing experience & end of convo
            else if(TriggerMessageFactory.messageindex == 17 && self?.currtxt.lowercaseString == "no"){
                self?.dataSource.addTextMessage(TriggerMessageFactory.demoTexts[21], isIncoming: true)
                self?.dataSource.addTextMessage(TriggerMessageFactory.demoTexts[2], isIncoming: true)
                TriggerMessageFactory.messageindex = 0
            }

        }
        return item
    }
    
}
