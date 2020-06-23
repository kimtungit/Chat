//
//  NewConvSelectedProtocol + Extension.swift
// Live Chat
//
//  Created by Kimtungit on 1/7/20.
//  Copyright © 2020 KimtungIT. All rights reserved.
//

import UIKit

// ---------------------------------------------------------------------------------------------------------------------------------------------------- //

protocol NewConversationSelected {
    func showSelectedUser(selectedFriend: FriendInfo)
}

// ---------------------------------------------------------------------------------------------------------------------------------------------------- //

extension ConversationsVC: NewConversationSelected {
    
    // ---------------------------------------------------------------------------------------------------------------------------------------------------- //
    
    func showSelectedUser(selectedFriend: FriendInfo) {
        nextControllerHandler(usr: selectedFriend)
    }
    
    // ---------------------------------------------------------------------------------------------------------------------------------------------------- //
    
}
