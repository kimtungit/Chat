//
//  MapSettingsButton.swift
// Live Chat
//
//  Created by Kimtungit on 1/15/20.
//  Copyright © 2020 KimtungIT. All rights reserved.
//

import UIKit

class MapSettingsButton: UIButton {
    
    // ---------------------------------------------------------------------------------------------------------------------------------------------------- //
    
    var mapsVC: MapsVC!
    
    // ---------------------------------------------------------------------------------------------------------------------------------------------------- //
    
    init(mapsVC: MapsVC) {
        super.init(frame: .zero)
        self.mapsVC = mapsVC
        setupSettingsButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // ---------------------------------------------------------------------------------------------------------------------------------------------------- //
    
    private func setupSettingsButton(){
        mapsVC.view.addSubview(self)
        translatesAutoresizingMaskIntoConstraints = false
        tintColor = ThemeColors.mainColor
        setBackgroundImage(UIImage(systemName: "gear"), for: .normal)
        addTarget(mapsVC, action: #selector(mapsVC.openMapsSettings), for: .touchUpInside)
        let constraints = [
            trailingAnchor.constraint(equalTo: mapsVC.view.trailingAnchor, constant: -16),
            topAnchor.constraint(equalTo: mapsVC.view.safeAreaLayoutGuide.topAnchor, constant: 4),
            widthAnchor.constraint(equalToConstant: 30),
            heightAnchor.constraint(equalToConstant: 30),
        ]
        NSLayoutConstraint.activate(constraints)
    }
        
    // ---------------------------------------------------------------------------------------------------------------------------------------------------- //
    
}
