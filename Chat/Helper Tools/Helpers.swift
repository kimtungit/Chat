//
//  Helpers.swift
// Live Chat
//
//  Created by Kimtungit on 11/17/19.
//  Copyright © 2019 KimungIT. All rights reserved.
//

import UIKit
import Firebase
import Lottie

extension UIViewController {
    
    // ---------------------------------------------------------------------------------------------------------------------------------------------------- //
    // BLANK VIEW FOR CONTROLLERS WITH NO DATA.
    
    func setupBlankView(_ blankLoadingView: AnimationView) {
        view.addSubview(blankLoadingView)
        blankLoadingView.translatesAutoresizingMaskIntoConstraints = false
        blankLoadingView.backgroundColor = .white
        blankLoadingView.play()
        blankLoadingView.loopMode = .loop
        blankLoadingView.backgroundBehavior = .pauseAndRestore
        let constraints = [
            blankLoadingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            blankLoadingView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            blankLoadingView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            blankLoadingView.topAnchor.constraint(equalTo: view.topAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    // ---------------------------------------------------------------------------------------------------------------------------------------------------- //
    // GRADIENT BACKGROUND
    
    func setupGradientLayer() -> CAGradientLayer {
        let gradient = CAGradientLayer()
        let topColor = UIColor(red: 60/255, green: 194/255, blue: 96/255, alpha: 1.0).cgColor
        let bottomColor = UIColor(red: 73/255, green: 239/255, blue: 121/255, alpha: 1.0).cgColor
        gradient.colors = [topColor, bottomColor]
        gradient.locations = [0, 1]
        return gradient
    }
    
    // ---------------------------------------------------------------------------------------------------------------------------------------------------- //
    // SHOWS ALERT VIEW WHEN THERE'S AN ERROR
    
    func showAlert(title: String?, message: String?){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    // ---------------------------------------------------------------------------------------------------------------------------------------------------- //
    
}

extension UITextView {
    
    // ---------------------------------------------------------------------------------------------------------------------------------------------------- //
    // METHOD FOR CALCULATING LINES IN A UITEXTVIEW
    
    func calculateLines() -> Int {
        let numberOfGlyphs = layoutManager.numberOfGlyphs
        var index = 0, numberOfLines = 0
        var lineRange = NSRange(location: NSNotFound, length: 0)
        
        while index < numberOfGlyphs {
            layoutManager.lineFragmentRect(forGlyphAt: index, effectiveRange: &lineRange)
            index = NSMaxRange(lineRange)
            numberOfLines += 1
            if text.last == "\n" {
                numberOfLines += 1
            }
        }
        return numberOfLines
    }
    
    // ---------------------------------------------------------------------------------------------------------------------------------------------------- //
    
}

