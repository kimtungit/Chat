//
//  ForwardToSend + Protocol.swift
// Live Chat
//
//  Created by Kimtungit on 1/2/20.
//  Copyright © 2020 KimtungIT. All rights reserved.
//

import UIKit

// ---------------------------------------------------------------------------------------------------------------------------------------------------- //

protocol ForwardToFriend {
    
    func forwardToSelectedFriend(friend: FriendInfo, for name: String)
    
}

// ---------------------------------------------------------------------------------------------------------------------------------------------------- //

extension ChatVC: ForwardToFriend {
    
    // ---------------------------------------------------------------------------------------------------------------------------------------------------- //
    
    func forwardToSelectedFriend(friend: FriendInfo, for name: String) {
        responseButtonPressed(userResponse.messageToForward!, forwardedName: name)
        self.friend = friend
        messages = []
        collectionView.reloadData()
        setupChat()
    }

    // ---------------------------------------------------------------------------------------------------------------------------------------------------- //
    
}
