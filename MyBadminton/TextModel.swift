//
//  TextMessageModel.swift
//  MyBadminton
//
//  Created by Khanh N. Do on 2017/09/20.
//  Copyright © 2017 MyBadminton. All rights reserved.
//

import Foundation
import ChattoAdditions
import Chatto

public class TextModel: TextMessageModel<MessageModel> {
    
    static let chatItemType = "text"
    override init(messageModel: MessageModel, text: String) {
        super.init(messageModel: messageModel, text: text)
    }
    
    
}
