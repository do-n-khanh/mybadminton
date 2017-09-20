//
//  TextBuilder.swift
//  MyBadminton
//
//  Created by Khanh N. Do on 2017/09/20.
//  Copyright © 2017 MyBadminton. All rights reserved.
//

import Foundation
import Chatto
import ChattoAdditions

class ViewModel: TextMessageViewModel<TextModel> {
    override init(textMessage: TextModel, messageViewModel: MessageViewModelProtocol) {
        super.init(textMessage: textMessage, messageViewModel: messageViewModel)
    }
    
}

class TextBuilder: ViewModelBuilderProtocol {
    func canCreateViewModel(fromModel decoratedTextMessage: Any) -> Bool {
        return decoratedTextMessage is TextModel
    }
    
    public func createViewModel(_ decoratedTextMessage: TextModel) -> ViewModel {
        
        let textmessageViewModel = ViewModel(textMessage: decoratedTextMessage, messageViewModel: MessageViewModelDefaultBuilder().createMessageViewModel(decoratedTextMessage))
        
        return textmessageViewModel
    }
    
}
