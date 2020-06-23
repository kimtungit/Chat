//
//  SignInVC.swift
// Live Chat
//
//  Created by Kimtungit on 11/16/19.
//  Copyright © 2019 KimungIT. All rights reserved.
//

import UIKit
import AuthenticationServices

class SignInVC: UIViewController, UITextFieldDelegate {
    
    
    
    // ---------------------------------------------------------------------------------------------------------------------------------------------------- //
    // SignInVC. This controller is responsible for authenticating users that are already in the database.
    
    var authNetworking: AuthNetworking!
    var authKeyboardHandler = AuthKeyboardHandler()
    var loginView: SignInView!
    var loginButton: AuthActionButton!
    var appleLogInButton : ASAuthorizationAppleIDButton = {
        let button = ASAuthorizationAppleIDButton(type: .default, style: .black)
        button.addTarget(self, action: #selector(handleLogInWithAppleID), for: .touchUpInside)
        return button
    }()
    
    // ---------------------------------------------------------------------------------------------------------------------------------------------------- //
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        authKeyboardHandler.view = view
        authKeyboardHandler.notificationCenterHandler()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // ---------------------------------------------------------------------------------------------------------------------------------------------------- //
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return false
    }
    
    // ---------------------------------------------------------------------------------------------------------------------------------------------------- //
    
    private func setupUI(){
        view.backgroundColor = .white
        let _ = GradientLogoView(self, false)
        loginView = SignInView(self)
        let _ = SignInLogoAnimation(self)
        setupLoginButton()
        setupSignUpButton()
        setupSignWithApple()
    }
    
    // ---------------------------------------------------------------------------------------------------------------------------------------------------- //
    // MARK: TEXTFIELD VALIDATION
    
    private func validateTF() -> String?{
        if loginView.emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || loginView.passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            return "Make sure you fill in all fields"
        }
        
        let password = loginView.passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if password.count < 6 {
            return "Password should be at least 6 characters long"
        }
        return nil
    }
    
    // ---------------------------------------------------------------------------------------------------------------------------------------------------- //
    
    private func setupLoginButton() {
        loginButton = AuthActionButton("SIGN IN", self)
        view.addSubview(loginButton)
        loginButton.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        let constraints = [
            loginButton.centerXAnchor.constraint(equalTo: loginView.centerXAnchor),
            loginButton.centerYAnchor.constraint(equalTo: loginView.bottomAnchor),
            loginButton.heightAnchor.constraint(equalToConstant: 40),
            loginButton.widthAnchor.constraint(equalToConstant: 200)
        ]
        NSLayoutConstraint.activate(constraints)
        
    }
    
    // ---------------------------------------------------------------------------------------------------------------------------------------------------- //
    
    private func setupSignUpButton() {
        let signUpButton = UIButton(type: .system)
        view.addSubview(signUpButton)
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        let mainString = "Don't have an account? Sign Up"
        let stringWithColor = "Sign Up"
        let range = (mainString as NSString).range(of: stringWithColor)
        let attributedString = NSMutableAttributedString(string: mainString)
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.systemBlue, range: range)
        signUpButton.setAttributedTitle(attributedString, for: .normal)
        signUpButton.tintColor = .black
        signUpButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        signUpButton.addTarget(self, action: #selector(signUpButtonPressed), for: .touchUpInside)
        let constraints = [
            signUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signUpButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 8),
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    private func setupSignWithApple() {
        view.addSubview(appleLogInButton)
        appleLogInButton.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            appleLogInButton.centerXAnchor.constraint(equalTo: loginView.centerXAnchor),
            appleLogInButton.bottomAnchor.constraint(equalToSystemSpacingBelow: self.view.safeAreaLayoutGuide.bottomAnchor, multiplier: -10),
            appleLogInButton.heightAnchor.constraint(equalToConstant: 40),
            appleLogInButton.widthAnchor.constraint(equalToConstant: 200)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    // ---------------------------------------------------------------------------------------------------------------------------------------------------- //
    // MARK: ANIMATION TO SIGN UP VIEW
    
    @objc private func signUpButtonPressed() {
        UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            for subview in self.loginView.subviews {
                subview.alpha = 0
            }
            self.loginButton.alpha = 0
        }) { (true) in
            let controller = SignUpVC()
            controller.modalPresentationStyle = .fullScreen
            controller.signInVC = self
            self.present(controller, animated: false, completion: nil)
        }
    }
    @objc func handleLogInWithAppleID() {
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let controller = ASAuthorizationController(authorizationRequests: [request])
        
        controller.delegate = self
        controller.presentationContextProvider = self
        
        controller.performRequests()
    }
    
    
    // ---------------------------------------------------------------------------------------------------------------------------------------------------- //
    // MARK: LOGIN METHOD
    
    @objc private func loginButtonPressed() {
        loginView.errorLabel.text = ""
        let validation = validateTF()
        if validation != nil {
            loginView.errorLabel.text = validation!
            return
        }
        let password = loginView.passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let email = loginView.emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        authNetworking = AuthNetworking(self)
        authNetworking.signIn(with: email, and: password) { (error) in
            self.loginView.errorLabel.text = error?.localizedDescription
        }
    }
    
    // ---------------------------------------------------------------------------------------------------------------------------------------------------- //
    
}
extension SignInVC: ASAuthorizationControllerDelegate,ASAuthorizationControllerPresentationContextProviding {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            let userIdentifier = appleIDCredential.user
            
            
            signUpApple(id: userIdentifier)
            //            let defaults = UserDefaults.standard
            //            defaults.set(userIdentifier, forKey: "userIdentifier1")
            
            
            
            break
        default:
            break
        }
    }
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
    
    func signUpApple(id : String) {
        let email = String("\(id)@livechat.cc")
        authNetworking = AuthNetworking(self)
        authNetworking.checkForExistingEmail(email) { (errorMessage) in
            guard errorMessage == nil else {
                // daregister - after login
                self.authNetworking = AuthNetworking(self)
                self.authNetworking.signIn(with: email, and: id) { (error) in
                    self.loginView.errorLabel.text = error?.localizedDescription
                }
                return
            }
            self.goToNextController(id: id)
        }
    }
    
    
    private func goToNextController( id : String){
        let controller = SelectProfileImageVC()
        controller.modalPresentationStyle = .fullScreen
        controller.name = id
        controller.email = String("\(id)@livechat.cc")
        controller.password = id
        self.show(controller, sender: nil)
    }  
}
