//
//  Decorator.swift
//  MyBadminton
//
//  Created by Khanh N. Do on 2017/09/20.
//  Copyright © 2017 MyBadminton. All rights reserved.
//

import Foundation
import Chatto
import ChattoAdditions
class Decorator : ChatItemsDecoratorProtocol {
    func decorateItems(_ chatItems: [ChatItemProtocol]) -> [DecoratedChatItem] {
        var decoratedItems = [DecoratedChatItem]()
        for item in chatItems {
            let decoratedItem = DecoratedChatItem(chatItem: item, decorationAttributes: ChatItemDecorationAttributes(bottomMargin: 10, canShowTail: false, canShowAvatar: false, canShowFailedIcon: false))
            decoratedItems.append(decoratedItem)
            
        }
        return decoratedItems
    }
}
