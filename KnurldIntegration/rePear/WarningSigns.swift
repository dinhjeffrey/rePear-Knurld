//
//  WarningSigns.swift
//  rePear
//
//  Created by Sara Du on 5/19/16.
//  Copyright © 2016 Sara Du. All rights reserved.
//

import UIKit
import Chatto
import ChattoAdditions

class WarningSigns: ChatViewController {
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
            if(WarningMessageFactory.messageindex == 0){
                WarningMessageFactory.messageindex = 1
                self?.dataSource.addTextMessage(WarningMessageFactory.demoTexts[WarningMessageFactory.messageindex], isIncoming: true)
            }
            //Answer yes to listing
            else if(WarningMessageFactory.messageindex == 1 && self?.currtxt.lowercaseString == "yes"){
                self?.dataSource.addTextMessage(WarningMessageFactory.demoTexts[2], isIncoming: true)
                self?.dataSource.addTextMessage(WarningMessageFactory.demoTexts[3], isIncoming: true)
                self?.dataSource.addTextMessage(WarningMessageFactory.demoTexts[4], isIncoming: true)
                WarningMessageFactory.messageindex = 4
            }
            else if(self?.currtxt.lowercaseString == "stop" && WarningMessageFactory.messageindex < 17){
                WarningMessageFactory.messageindex = 18
                self?.dataSource.addTextMessage(WarningMessageFactory.demoTexts[18], isIncoming: true)
                
            }
            else if(WarningMessageFactory.messageindex == 4 && self?.currtxt.lowercaseString == "more"){
                self?.dataSource.addTextMessage(WarningMessageFactory.demoTexts[5], isIncoming: true)
            }else if(WarningMessageFactory.messageindex == 4 && self?.currtxt.lowercaseString == "ok"){
                WarningMessageFactory.messageindex = 6
                self?.dataSource.addTextMessage(WarningMessageFactory.demoTexts[6], isIncoming: true)
            }
            else if(WarningMessageFactory.messageindex == 6 && self?.currtxt.lowercaseString == "more"){
                self?.dataSource.addTextMessage(WarningMessageFactory.demoTexts[7], isIncoming: true)
            }else if(WarningMessageFactory.messageindex == 6 && self?.currtxt.lowercaseString == "ok"){
                WarningMessageFactory.messageindex = 8
                self?.dataSource.addTextMessage(WarningMessageFactory.demoTexts[8], isIncoming: true)
            }
            else if(WarningMessageFactory.messageindex == 8 && self?.currtxt.lowercaseString == "more"){
                self?.dataSource.addTextMessage(WarningMessageFactory.demoTexts[9], isIncoming: true)
            }else if(WarningMessageFactory.messageindex == 8 && self?.currtxt.lowercaseString == "ok"){
                WarningMessageFactory.messageindex = 10
                self?.dataSource.addTextMessage(WarningMessageFactory.demoTexts[10], isIncoming: true)
            }
            else if(WarningMessageFactory.messageindex == 10 && self?.currtxt.lowercaseString == "more"){
                self?.dataSource.addTextMessage(WarningMessageFactory.demoTexts[11], isIncoming: true)
            }else if(WarningMessageFactory.messageindex == 10 && self?.currtxt.lowercaseString == "ok"){
                WarningMessageFactory.messageindex = 12
                self?.dataSource.addTextMessage(WarningMessageFactory.demoTexts[12], isIncoming: true)
            }
            else if(WarningMessageFactory.messageindex == 12 && self?.currtxt.lowercaseString == "more"){
                self?.dataSource.addTextMessage(WarningMessageFactory.demoTexts[13], isIncoming: true)
            }else if(WarningMessageFactory.messageindex == 12 && self?.currtxt.lowercaseString == "ok"){
                WarningMessageFactory.messageindex = 14
                self?.dataSource.addTextMessage(WarningMessageFactory.demoTexts[14], isIncoming: true)
            }
            else if(WarningMessageFactory.messageindex == 14 && self?.currtxt.lowercaseString == "more"){
                self?.dataSource.addTextMessage(WarningMessageFactory.demoTexts[15], isIncoming: true)
            }else if(WarningMessageFactory.messageindex == 14 && self?.currtxt.lowercaseString == "ok"){
                WarningMessageFactory.messageindex = 16
                self?.dataSource.addTextMessage(WarningMessageFactory.demoTexts[16], isIncoming: true)
            }
            else if(WarningMessageFactory.messageindex == 16 && self?.currtxt.lowercaseString == "more"){
                self?.dataSource.addTextMessage(WarningMessageFactory.demoTexts[17], isIncoming: true)
            } //end of info
            //Answer no to listing
            else if(self?.currtxt.lowercaseString == "no" && WarningMessageFactory.messageindex == 1 || WarningMessageFactory.messageindex == 16 && self?.currtxt.lowercaseString == "ok"){
                WarningMessageFactory.messageindex = 18
                self?.dataSource.addTextMessage(WarningMessageFactory.demoTexts[18], isIncoming: true)
            }
                else if(WarningMessageFactory.messageindex >= 18 && self?.currtxt.lowercaseString == "stop"){
                    self?.dataSource.addTextMessage(WarningMessageFactory.demoTexts[22], isIncoming: true)
                    WarningMessageFactory.messageindex = 0
                    //self?.navigationController?.popViewControllerAnimated(true)
                
                }
                //yes to what to do
                else if(WarningMessageFactory.messageindex == 18 && self?.currtxt.lowercaseString == "yes"){
                    WarningMessageFactory.messageindex = 19
                    self?.dataSource.addTextMessage(WarningMessageFactory.demoTexts[19], isIncoming: true)
                }
                else if(WarningMessageFactory.messageindex == 19){
                    WarningMessageFactory.messageindex = 20
                    self?.dataSource.addTextMessage(WarningMessageFactory.demoTexts[20], isIncoming: true)
                }
                else if(WarningMessageFactory.messageindex == 20){
                    self?.dataSource.addTextMessage(WarningMessageFactory.demoTexts[22], isIncoming: true)
                    WarningMessageFactory.messageindex = 0
                    //self?.navigationController?.popViewControllerAnimated(true)
                }
                //no to what to do
                else if(WarningMessageFactory.messageindex == 18 && self?.currtxt.lowercaseString == "no"){
                    self?.dataSource.addTextMessage(WarningMessageFactory.demoTexts[22], isIncoming: true)
                    WarningMessageFactory.messageindex = 0
                    //self?.navigationController?.popViewControllerAnimated(true)
                }
            else{
                self?.dataSource.addTextMessage(WarningMessageFactory.demoTexts[21], isIncoming: true)
            }
        }
        return item
    }
    
   
}
