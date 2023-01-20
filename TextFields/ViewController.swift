//
//  ViewController.swift
//  TextFields
//
//  Created by Olya Sabadina on 2022-12-14.
//

import UIKit
import SafariServices

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var countLabel: UILabel!
    
    @IBOutlet weak var checkMarkMinLenght: UIImageView!
    @IBOutlet weak var minimumLenghtLabel: UILabel!
    @IBOutlet weak var checkMarkMinimumDigit: UIImageView!
    @IBOutlet weak var minimumDigitLabel: UILabel!
    @IBOutlet weak var checkMarkMinimumLowerCase: UIImageView!
    @IBOutlet weak var minimumLowerCaseLabel: UILabel!
    @IBOutlet weak var checkMnimumUpperCase: UIImageView!
    @IBOutlet weak var minimumUpperCaseLabel: UILabel!
    
    @IBOutlet weak var noDigitsTextField: UITextField!
    @IBOutlet weak var indicationLimitedTextField: UITextField!
    @IBOutlet weak var maskTextField: UITextField!
    @IBOutlet weak var linkTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var progressView: UIProgressView!
    
    @IBOutlet weak var switchToTabBarModeButton: UIButton!
    
    private let numberLimitSymbols = 10
    private var url = ""
    private var progress: Float = 0
    private let managerForValidateNotSecureTextFields = ValidateManager()
    private let managerForValidatePasswordField = ValidatePasswordManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTextFieldsDelegate()
        setUpTextFielIdentifier()
        registerKeyboard()
        removeKeyboard()
    }
    
    private func setUpTextFieldsDelegate() {
        noDigitsTextField.delegate = self
        indicationLimitedTextField.delegate = self
        maskTextField.delegate = self
        linkTextField.delegate = self
        passwordTextField.delegate = self
    }
    private func setUpTextFielIdentifier() {
        noDigitsTextField.accessibilityIdentifier = "noDigitsTF"
        indicationLimitedTextField.accessibilityIdentifier = "indicationLimitedTextTF"
        maskTextField.accessibilityIdentifier = "maskTF"
        linkTextField.accessibilityIdentifier = "linkTF"
        passwordTextField.accessibilityIdentifier = "passwordTF"
        switchToTabBarModeButton.accessibilityIdentifier = "switchToTabBarBT"
    }
    
    @IBAction func switchToTabBarModeButton(_ sender: UIButton) {
        let tabBar = MainTabBarController()
        tabBar.modalPresentationStyle = .fullScreen
        present(tabBar, animated: true)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        let userInfo = notification.userInfo
        let keyboardFrame = (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        scrollView.contentOffset = CGPoint(x: 0, y: keyboardFrame.height)
    }
    
    @objc func keyboardWillHide() {
        scrollView.contentOffset = CGPoint.zero
    }
    
    // If URL is valid, you open this url
    @objc func getValideLinkTextField() {
        guard managerForValidateNotSecureTextFields.isValideLinkMask(text: url) else {return}
        if url.hasPrefix("www.") {
            url.insert(contentsOf: "https://", at: url.startIndex)
        }
        openURL(urlAdress: url)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == passwordTextField {
            registerKeyboard()
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == passwordTextField {
            removeKeyboard()
            scrollView.contentOffset = CGPoint.zero
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        
        if textField == noDigitsTextField {
            return !managerForValidateNotSecureTextFields.isContainsDigits(text: updatedText)
        }
        
        if textField == indicationLimitedTextField {
            changingStringAfterTenthCharacter(currentText: currentText, textField: textField, updatedText: updatedText)
        }
        
        // maskTextField "wwwww-ddddd"
        if textField == maskTextField {
            if updatedText.count == 6 && range.length != 1 {
                textField.text?.append("-")
            }
            return managerForValidateNotSecureTextFields.letterAndDigitsMask(text: updatedText)
        }
        
        if textField == linkTextField {
            registerOpenURL(textField: textField, updatedText: updatedText)
        }
        
        if textField == passwordTextField {
            progress = 0
            passwordValidationService(updatedText: updatedText)
        }
        
        return true
    }
    
    private func passwordValidationService(updatedText: String) {
        
        if managerForValidatePasswordField.minimumCharacters(text: updatedText) {
            completeCondition(label: minimumLenghtLabel, image: checkMarkMinLenght)
        } else {
            basicCondition(label: minimumLenghtLabel, image: checkMarkMinLenght)
        }
        
        if  managerForValidatePasswordField.oneDigit(text: updatedText) {
            completeCondition(label: minimumDigitLabel, image: checkMarkMinimumDigit)
        } else {
            basicCondition(label: minimumDigitLabel, image: checkMarkMinimumDigit)
        }
        
        if managerForValidatePasswordField.oneLowerCaseLetter(text: updatedText) {
            completeCondition(label: minimumLowerCaseLabel, image: checkMarkMinimumLowerCase)
        } else {
            basicCondition(label: minimumLowerCaseLabel, image: checkMarkMinimumLowerCase)
        }
        
        if managerForValidatePasswordField.oneCapitalLetter(text: updatedText) {
            completeCondition(label: minimumUpperCaseLabel, image: checkMnimumUpperCase)
        } else {
            basicCondition(label: minimumUpperCaseLabel, image: checkMnimumUpperCase)
        }
        
        configureProgress()
    }
    
    private func changingStringAfterTenthCharacter(currentText: String, textField: UITextField, updatedText: String) {
        
        let numberSymbols = updatedText.count
        let limit = numberLimitSymbols - numberSymbols
        countLabel.text = "\(limit)"
        
        if numberSymbols > numberLimitSymbols {
            countLabel.textColor = .red
            textField.layer.borderColor = UIColor.red.cgColor
            textField.layer.borderWidth = 1
            
            var myMutableString = NSMutableAttributedString()
            myMutableString = NSMutableAttributedString(string: currentText)
            
            myMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.black, range:NSRange(location: 0, length: numberLimitSymbols))
            
            textField.textColor = .red
            textField.attributedText = myMutableString
        } else {
            textField.textColor = .black
            textField.layer.borderWidth = 0
            countLabel.textColor = .black
        }
    }
    
    private func registerOpenURL(textField: UITextField, updatedText: String) {
        
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(self.getValideLinkTextField), object: textField)
        
        self.perform(#selector(self.getValideLinkTextField), with: textField, afterDelay: 4)
        url = updatedText
    }
    
    private func openURL(urlAdress: String){
        guard let url = URL(string: urlAdress) else {return}
        let safariViewController = SFSafariViewController(url: url)
        present(safariViewController, animated: true)
    }
    
    private func registerKeyboard(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func removeKeyboard() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func completeCondition(label: UILabel, image: UIImageView){
        label.textColor = .systemGreen
        image.tintColor = .systemGreen
        image.image = UIImage(systemName: "checkmark")
        image.sizeToFit()
        progress += 0.25
    }
    
    private func basicCondition(label: UILabel, image: UIImageView){
        label.textColor = .black
        image.tintColor = .black
        image.image = UIImage(systemName: "minus")
        progress += 0
    }
    
    private func configureProgress(){
        
        progressView.progress = progress
        if progress <= 0.25 {
            progressView.progressTintColor = .systemRed
        }
        if progress > 0.75 {
            progressView.progressTintColor = .systemGreen
        }
        if progress > 0.25 && progress <= 0.75 {
            progressView.progressTintColor = .systemOrange
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}

