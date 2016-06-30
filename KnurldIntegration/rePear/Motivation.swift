//
//  Motivation.swift
//  rePear
//
//  Created by Sara Du on 5/19/16.
//  Copyright © 2016 Sara Du. All rights reserved.
//

import UIKit
import Chatto
import ChattoAdditions

class Motivation: ChatViewController {
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
            
            if(MotivationMessageFactory.messageindex == 0){
                MotivationMessageFactory.messageindex = 2
                 self?.dataSource.addTextMessage(MotivationMessageFactory.demoTexts[1], isIncoming: true)
                self?.dataSource.addTextMessage(MotivationMessageFactory.demoTexts[2], isIncoming: true)
            }
            //yes to keys
            else if(MotivationMessageFactory.messageindex == 2 && self?.currtxt.lowercaseString == "yes"){
                  self?.dataSource.addTextMessage(MotivationMessageFactory.demoTexts[3], isIncoming: true)
                MotivationMessageFactory.messageindex = 3
                self?.dataSource.addTextMessage(MotivationMessageFactory.demoTexts[4], isIncoming: true)
                MotivationMessageFactory.messageindex = 4
            }
            else if(MotivationMessageFactory.messageindex < 24 && self?.currtxt.lowercaseString == "stop"){
                  self?.dataSource.addTextMessage(MotivationMessageFactory.demoTexts[3], isIncoming: true)
                MotivationMessageFactory.messageindex = 24
            }
           
                else if(MotivationMessageFactory.messageindex == 4 && self?.currtxt.lowercaseString == "why"){
                    self?.dataSource.addTextMessage(MotivationMessageFactory.demoTexts[5], isIncoming: true)
                    self?.dataSource.addTextMessage(MotivationMessageFactory.demoTexts[6], isIncoming: true)
                    MotivationMessageFactory.messageindex = 6
                }
                else if(MotivationMessageFactory.messageindex == 4 && self?.currtxt.lowercaseString == "ok"){
                    self?.dataSource.addTextMessage(MotivationMessageFactory.demoTexts[6], isIncoming: true)
                    MotivationMessageFactory.messageindex = 6
                }
                else if(MotivationMessageFactory.messageindex == 6 && self?.currtxt.lowercaseString == "why"){
                    self?.dataSource.addTextMessage(MotivationMessageFactory.demoTexts[7], isIncoming: true)
                    self?.dataSource.addTextMessage(MotivationMessageFactory.demoTexts[8], isIncoming: true)
                    MotivationMessageFactory.messageindex = 8
                }
                else if(MotivationMessageFactory.messageindex == 6 && self?.currtxt.lowercaseString == "ok"){
                    self?.dataSource.addTextMessage(MotivationMessageFactory.demoTexts[8], isIncoming: true)
                    MotivationMessageFactory.messageindex = 8
                }
                else if(MotivationMessageFactory.messageindex == 8 && self?.currtxt.lowercaseString == "why"){
                    self?.dataSource.addTextMessage(MotivationMessageFactory.demoTexts[9], isIncoming: true)
                    self?.dataSource.addTextMessage(MotivationMessageFactory.demoTexts[10], isIncoming: true)
                    MotivationMessageFactory.messageindex = 10
                }
                else if(MotivationMessageFactory.messageindex == 8 && self?.currtxt.lowercaseString == "ok"){
                    self?.dataSource.addTextMessage(MotivationMessageFactory.demoTexts[10], isIncoming: true)
                    MotivationMessageFactory.messageindex = 10
                }
            else if(MotivationMessageFactory.messageindex == 10 && self?.currtxt.lowercaseString == "why"){
                self?.dataSource.addTextMessage(MotivationMessageFactory.demoTexts[11], isIncoming: true)
                self?.dataSource.addTextMessage(MotivationMessageFactory.demoTexts[12], isIncoming: true)
                MotivationMessageFactory.messageindex = 12
            }
            else if(MotivationMessageFactory.messageindex == 10 && self?.currtxt.lowercaseString == "ok"){
                self?.dataSource.addTextMessage(MotivationMessageFactory.demoTexts[12], isIncoming: true)
                MotivationMessageFactory.messageindex = 12
            }
            else if(MotivationMessageFactory.messageindex == 12 && self?.currtxt.lowercaseString == "why"){
                self?.dataSource.addTextMessage(MotivationMessageFactory.demoTexts[13], isIncoming: true)
                self?.dataSource.addTextMessage(MotivationMessageFactory.demoTexts[14], isIncoming: true)
                MotivationMessageFactory.messageindex = 14
            }
            else if(MotivationMessageFactory.messageindex == 12 && self?.currtxt.lowercaseString == "ok"){
                self?.dataSource.addTextMessage(MotivationMessageFactory.demoTexts[14], isIncoming: true)
                MotivationMessageFactory.messageindex = 14
            }
            else if(MotivationMessageFactory.messageindex == 14 && self?.currtxt.lowercaseString == "why"){
                self?.dataSource.addTextMessage(MotivationMessageFactory.demoTexts[15], isIncoming: true)
                self?.dataSource.addTextMessage(MotivationMessageFactory.demoTexts[16], isIncoming: true)
                MotivationMessageFactory.messageindex = 16
            }
            else if(MotivationMessageFactory.messageindex == 14 && self?.currtxt.lowercaseString == "ok"){
                self?.dataSource.addTextMessage(MotivationMessageFactory.demoTexts[16], isIncoming: true)
                MotivationMessageFactory.messageindex = 16
            }
            else if(MotivationMessageFactory.messageindex == 16 && self?.currtxt.lowercaseString == "why"){
                self?.dataSource.addTextMessage(MotivationMessageFactory.demoTexts[17], isIncoming: true)
                self?.dataSource.addTextMessage(MotivationMessageFactory.demoTexts[18], isIncoming: true)
                MotivationMessageFactory.messageindex = 18
            }
            else if(MotivationMessageFactory.messageindex == 16 && self?.currtxt.lowercaseString == "ok"){
                self?.dataSource.addTextMessage(MotivationMessageFactory.demoTexts[18], isIncoming: true)
                MotivationMessageFactory.messageindex = 18
            }
            else if(MotivationMessageFactory.messageindex == 18 && self?.currtxt.lowercaseString == "why"){
                self?.dataSource.addTextMessage(MotivationMessageFactory.demoTexts[19], isIncoming: true)
                self?.dataSource.addTextMessage(MotivationMessageFactory.demoTexts[20], isIncoming: true)
                MotivationMessageFactory.messageindex = 20
            }
            else if(MotivationMessageFactory.messageindex == 18 && self?.currtxt.lowercaseString == "ok"){
                self?.dataSource.addTextMessage(MotivationMessageFactory.demoTexts[20], isIncoming: true)
                MotivationMessageFactory.messageindex = 20
            }
            else if(MotivationMessageFactory.messageindex == 20 && self?.currtxt.lowercaseString == "why"){
                self?.dataSource.addTextMessage(MotivationMessageFactory.demoTexts[21], isIncoming: true)
                self?.dataSource.addTextMessage(MotivationMessageFactory.demoTexts[22], isIncoming: true)
                MotivationMessageFactory.messageindex = 22
            }
            else if(MotivationMessageFactory.messageindex == 20 && self?.currtxt.lowercaseString == "ok"){
                self?.dataSource.addTextMessage(MotivationMessageFactory.demoTexts[22], isIncoming: true)
                MotivationMessageFactory.messageindex = 22
            }
            else if(MotivationMessageFactory.messageindex == 22 && self?.currtxt.lowercaseString == "why"){
                self?.dataSource.addTextMessage(MotivationMessageFactory.demoTexts[23], isIncoming: true)
                self?.dataSource.addTextMessage(MotivationMessageFactory.demoTexts[24], isIncoming: true)
                MotivationMessageFactory.messageindex = 24
            }
            else if(MotivationMessageFactory.messageindex == 22 && self?.currtxt.lowercaseString == "ok"){
                self?.dataSource.addTextMessage(MotivationMessageFactory.demoTexts[24], isIncoming: true)
                MotivationMessageFactory.messageindex = 24
            }
            
            //activities they might enjoy
                //yes
            else if(MotivationMessageFactory.messageindex == 24 && self?.currtxt.lowercaseString == "yes"){
                self?.dataSource.addTextMessage(MotivationMessageFactory.demoTexts[25], isIncoming: true)
                self?.dataSource.addTextMessage(MotivationMessageFactory.demoTexts[26], isIncoming: true)
                MotivationMessageFactory.messageindex = 26
            }
            else if(self?.currtxt.lowercaseString == "stop" && MotivationMessageFactory.messageindex >= 24){
                self?.dataSource.addTextMessage(MotivationMessageFactory.demoTexts[37], isIncoming: true)
                MotivationMessageFactory.messageindex = 0
            }
            else if(MotivationMessageFactory.messageindex == 26 && self?.currtxt.lowercaseString == "more"){
                self?.dataSource.addTextMessage(MotivationMessageFactory.demoTexts[27], isIncoming: true)
                self?.dataSource.addTextMessage(MotivationMessageFactory.demoTexts[28], isIncoming: true)
                MotivationMessageFactory.messageindex = 28
            }
            else if(MotivationMessageFactory.messageindex == 26 && self?.currtxt.lowercaseString == "ok"){
                self?.dataSource.addTextMessage(MotivationMessageFactory.demoTexts[28], isIncoming: true)
                MotivationMessageFactory.messageindex = 28
            }
            else if(MotivationMessageFactory.messageindex == 28 && self?.currtxt.lowercaseString == "more"){
                self?.dataSource.addTextMessage(MotivationMessageFactory.demoTexts[29], isIncoming: true)
                self?.dataSource.addTextMessage(MotivationMessageFactory.demoTexts[30], isIncoming: true)
                MotivationMessageFactory.messageindex = 30
            }
            else if(MotivationMessageFactory.messageindex == 28 && self?.currtxt.lowercaseString == "ok"){
                self?.dataSource.addTextMessage(MotivationMessageFactory.demoTexts[30], isIncoming: true)
                MotivationMessageFactory.messageindex = 30
            }
            else if(MotivationMessageFactory.messageindex == 30 && self?.currtxt.lowercaseString == "more"){
                self?.dataSource.addTextMessage(MotivationMessageFactory.demoTexts[31], isIncoming: true)
                self?.dataSource.addTextMessage(MotivationMessageFactory.demoTexts[32], isIncoming: true)
                MotivationMessageFactory.messageindex = 32
            }
            else if(MotivationMessageFactory.messageindex == 30 && self?.currtxt.lowercaseString == "ok"){
                self?.dataSource.addTextMessage(MotivationMessageFactory.demoTexts[32], isIncoming: true)
                MotivationMessageFactory.messageindex = 32
            }
            else if(MotivationMessageFactory.messageindex == 32 && self?.currtxt.lowercaseString == "more"){
                self?.dataSource.addTextMessage(MotivationMessageFactory.demoTexts[33], isIncoming: true)
                self?.dataSource.addTextMessage(MotivationMessageFactory.demoTexts[34], isIncoming: true)
                MotivationMessageFactory.messageindex = 34
            }
            else if(MotivationMessageFactory.messageindex == 32 && self?.currtxt.lowercaseString == "ok"){
                self?.dataSource.addTextMessage(MotivationMessageFactory.demoTexts[34], isIncoming: true)
                MotivationMessageFactory.messageindex = 34
            }
            
            //end of convo
            else if(MotivationMessageFactory.messageindex == 34 && self?.currtxt.lowercaseString == "more"){
                self?.dataSource.addTextMessage(MotivationMessageFactory.demoTexts[35], isIncoming: true)
                self?.dataSource.addTextMessage(MotivationMessageFactory.demoTexts[37], isIncoming: true)
                MotivationMessageFactory.messageindex = 0
            }
            else if(MotivationMessageFactory.messageindex == 26 && self?.currtxt.lowercaseString == "ok"){
                self?.dataSource.addTextMessage(MotivationMessageFactory.demoTexts[37], isIncoming: true)
                MotivationMessageFactory.messageindex = 0
            }




                //no
            else if(MotivationMessageFactory.messageindex == 24 && self?.currtxt.lowercaseString == "no"){
                self?.dataSource.addTextMessage(MotivationMessageFactory.demoTexts[37], isIncoming: true)
                MotivationMessageFactory.messageindex = 0
            }

            
        }
        return item
    }
    
}
