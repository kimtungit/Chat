//
//  UserResponse.swift
// Live Chat
//
//  Created by Kimtungit on 12/31/19.
//  Copyright © 2019 KimungIT. All rights reserved.
//

import UIKit

class UserResponse {
    
    // ---------------------------------------------------------------------------------------------------------------------------------------------------- //
    
    var responseStatus = false
    
    var repliedMessage: Messages?
    
    var messageToForward: Messages?
    
    var messageSender: String?
    
    let lineView = UIView()
    
    let nameLabel = UILabel()
    
    var nameLabelConstraint: NSLayoutConstraint!
    
    let messageLabel = UILabel()
    
    let mediaMessage = UIImageView()
    
    let audioMessage = UILabel()
    
    let exitButton = UIButton(type: .system)
    
    // ---------------------------------------------------------------------------------------------------------------------------------------------------- //
    
}

