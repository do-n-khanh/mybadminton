//
//  ChatItemsController.swift
//  MyBadminton
//
//  Created by Khanh N. Do on 2017/09/20.
//  Copyright © 2017 MyBadminton. All rights reserved.
//

import Foundation
import Chatto
import ChattoAdditions

class ChatItemsController {
    var items = [ChatItemProtocol]()
    func insertItem(message: ChatItemProtocol) {
        self.items.append(message)
    }
}
