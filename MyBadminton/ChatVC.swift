//
//  ChatVC.swift
//  MyBadminton
//
//  Created by Khanh N. Do on 2017/09/19.
//  Copyright © 2017 MyBadminton. All rights reserved.
//

import UIKit
import Chatto
import ChattoAdditions

class ChatVC: BaseChatViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.chatDataSource = self.dataSource
        self.chatItemsDecorator = self.decorator
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
//    lazy private var baseMessageHandler: BaseMessageHandler = {
//        return BaseMessageHandler(messageSender: self.messageSender)
//    }()
    var chatInputPresenter: BasicChatInputBarPresenter!
    var dataSource = DataSource()
    var decorator = Decorator()
    
    override func createPresenterBuilders() -> [ChatItemType: [ChatItemPresenterBuilderProtocol]] {
        
        let textMessageBuilder = TextMessagePresenterBuilder(
            viewModelBuilder: TextBuilder(),
            interactionHandler: TextHandler()
        )
//        textMessagePresenter.baseMessageStyle = BaseMessageCollectionViewCellAvatarStyle()
//        
//        let photoMessagePresenter = PhotoMessagePresenterBuilder(
//            viewModelBuilder: DemoPhotoMessageViewModelBuilder(),
//            interactionHandler: DemoPhotoMessageHandler(baseHandler: self.baseMessageHandler)
//        )
//        photoMessagePresenter.baseCellStyle = BaseMessageCollectionViewCellAvatarStyle()
//        
//        return [
//            DemoTextMessageModel.chatItemType: [
//                textMessagePresenter
//            ],
//            DemoPhotoMessageModel.chatItemType: [
//                photoMessagePresenter
//            ],
//            SendingStatusModel.chatItemType: [SendingStatusPresenterBuilder()],
//            TimeSeparatorModel.chatItemType: [TimeSeparatorPresenterBuilder()]
//        ]
        return [TextModel.chatItemType: [textMessageBuilder]]
    }

    override func createChatInputView() -> UIView {
        let chatInputView = ChatInputBar.loadNib()
        var appearance = ChatInputBarAppearance()
        appearance.sendButtonAppearance.title = NSLocalizedString("Send", comment: "")
        appearance.textInputAppearance.placeholderText = NSLocalizedString("Type a message", comment: "")
        self.chatInputPresenter = BasicChatInputBarPresenter(chatInputBar: chatInputView, chatInputItems: self.createChatInputItems(), chatInputBarAppearance: appearance)
        chatInputView.maxCharactersCount = 1000
        return chatInputView
    }

    func createChatInputItems() -> [ChatInputItemProtocol] {
        var items = [ChatInputItemProtocol]()
        items.append(self.createTextInputItem())
        items.append(self.createPhotoInputItem())
        return items
    }

    private func createTextInputItem() -> TextChatInputItem {
        let item = TextChatInputItem()
        item.textInputHandler = { [weak self] text in
            print(text)
            let message = MessageModel(uid: "", senderId: "", type: TextModel.chatItemType, isIncoming: false, date: Date(), status: MessageStatus.success)
            let textMessage = TextModel(messageModel: message, text: text)
            self?.dataSource.addTextMessage(message: textMessage)
            
        }
        return item
    }
    
    private func createPhotoInputItem() -> PhotosChatInputItem {
        let item = PhotosChatInputItem(presentingController: self)
        item.photoInputHandler = { [weak self] image in
          //  self?.dataSource.addPhotoMessage(image)
        }
        return item
    }

    
}
