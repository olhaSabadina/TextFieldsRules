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
    
    @IBOutlet weak var nameProgramLabel: UILabel!
    @IBOutlet weak var noDigitsFieldLabel: UILabel!
    @IBOutlet weak var inputLimitLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var letterAndDigitsMaskLabel: UILabel!
    @IBOutlet weak var linkLabel: UILabel!
    @IBOutlet weak var validationRulesLabel: UILabel!
    
    @IBOutlet weak var stackView: UIStackView!
    
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
    @IBOutlet weak var startButton: UIButton!
    
    private let numberLimitSymbols = 10
    private var url = ""
    private var progress: Float = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNoDigitsTextField()
        configureIndicationLimitedTextField()
        configureCountLabel()
        configureMaskTextField()
        configurelinkTextFieldd()
        configurePasswordTextField()
        registerKeyboard()
        removeKeyboard()
    }
    
    @IBAction func startButton(_ sender: UIButton) {
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
    @objc func getHintsToLinkTextField(textField: UITextField) {
        if url.isValidelinkMask() {
            if url.hasPrefix("www.") {
                url.insert(contentsOf: "https://", at: url.startIndex)
            }
            openURL(urlAdress: url)
        }
    }
    
    private func openURL(urlAdress: String){
        guard let url = URL(string: urlAdress) else {return}
        let safariViewController = SFSafariViewController(url: url)
        present(safariViewController, animated: true)
    }
    
    private func configureNoDigitsTextField() {
        noDigitsTextField.delegate = self
    }
    
    private func configureIndicationLimitedTextField() {
        indicationLimitedTextField.delegate = self
    }
    
    private func configureCountLabel() {
    }
    
    private func configureMaskTextField() {
        maskTextField.delegate = self
    }
    
    private func configurelinkTextFieldd() {
        linkTextField.delegate = self
    }
    
    private func configurePasswordTextField() {
        passwordTextField.delegate = self
    }
    
    internal func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        
        // First TextField
        if textField == noDigitsTextField {
            return !updatedText.noDigits()
        }
        
        // Second TextField
        if textField == indicationLimitedTextField {
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
            return true
        }
        
        // Third TextField maskTextField "wwwww-ddddd"
        if textField == maskTextField {
            if updatedText.count == 6 && range.length != 1 {
                textField.text?.append("-")
            }
            return updatedText.letterAndDigitsMask()
        }
        
        // Fourth: on link input/paste open it in SFSafariViewController.
        if textField == linkTextField {
            
            NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(self.getHintsToLinkTextField(textField:)), object: textField)
            
            self.perform(#selector(self.getHintsToLinkTextField(textField:)), with: textField, afterDelay: 4)
            url = updatedText
        }
        
        // Five TextField password
        if textField == passwordTextField {
            progress = 0
            
            if updatedText.minimumCharacters() {
                completeCondition(label: minimumLenghtLabel, image: checkMarkMinLenght)
                
            } else {
                basicCondition(label: minimumLenghtLabel, image: checkMarkMinLenght)
            }
            
            if updatedText.oneDigit() {
                completeCondition(label: minimumDigitLabel, image: checkMarkMinimumDigit)
                
            } else {
                basicCondition(label: minimumDigitLabel, image: checkMarkMinimumDigit)
            }
            
            if updatedText.oneLowerCaseLetter() {
                completeCondition(label: minimumLowerCaseLabel, image: checkMarkMinimumLowerCase)
                
            } else {
                basicCondition(label: minimumLowerCaseLabel, image: checkMarkMinimumLowerCase)
            }
            if updatedText.oneCapitalLetter() {
                completeCondition(label: minimumUpperCaseLabel, image: checkMnimumUpperCase)
                
            } else {
                basicCondition(label: minimumUpperCaseLabel, image: checkMnimumUpperCase)
            }
            configureProgress()
        }
        
        return true
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

