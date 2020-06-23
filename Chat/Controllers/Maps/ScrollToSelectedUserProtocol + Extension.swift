//
//  ScrollToSelectedUser + Extension.swift
// Live Chat
//
//  Created by Kimtungit on 1/14/20.
//  Copyright © 2020 KimtungIT. All rights reserved.
//

import UIKit
import Mapbox

// ---------------------------------------------------------------------------------------------------------------------------------------------------- //

protocol ScrollToSelectedUser {
    func zoomToSelectedFriend(friend: FriendInfo)
}

// ---------------------------------------------------------------------------------------------------------------------------------------------------- //

extension MapsVC: ScrollToSelectedUser {
    
    // ---------------------------------------------------------------------------------------------------------------------------------------------------- //
    
    func zoomToSelectedFriend(friend: FriendInfo) {
        selectedFriend = friend
        isFriendSelected = true
    }
    
    // ---------------------------------------------------------------------------------------------------------------------------------------------------- //

}
