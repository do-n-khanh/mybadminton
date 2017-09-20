//
//  ChatDataSource.swift
//  MyBadminton
//
//  Created by Khanh N. Do on 2017/09/20.
//  Copyright © 2017 MyBadminton. All rights reserved.
//

import Foundation
import Chatto
import ChattoAdditions

class DataSource: ChatDataSourceProtocol {
    var controller = ChatItemsController()
    var chatItems: [ChatItemProtocol] {
        return controller.items
    }
    
    
    var hasMoreNext: Bool {
    
        return false
    }
    var hasMorePrevious: Bool {
    
        return false
    }

    
    weak var delegate: ChatDataSourceDelegateProtocol?
//    
    func loadNext() {
        
    }// Should trigger chatDataSourceDidUpdate with UpdateType.Pagination
    func loadPrevious() {
        
    }// Should trigger chatDataSourceDidUpdate with UpdateType.Pagination
    func adjustNumberOfMessages(preferredMaxCount: Int?, focusPosition: Double, completion:(_ didAdjust: Bool) -> Void) { // If you want, implement message count contention for performance, otherwise just call completion(false)
        completion(false)
    
    }
    
    func addTextMessage(message: ChatItemProtocol) {
        self.controller.insertItem(message: message)
        self.delegate?.chatDataSourceDidUpdate(self)
    }
}
