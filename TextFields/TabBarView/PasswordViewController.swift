//
//  PasswordViewController.swift
//  TextFieldWithTabBar
//
//  Created by Olya Sabadina on 2022-12-31.
//

import UIKit

class PasswordViewController: UIViewController, UITextFieldDelegate {
    
    private var progress: Float = 0
    private var checkMarkMinLenght = UIImageView()
    private var chekMarkDigit = UIImageView()
    private var checkMarkLowerCase = UIImageView()
    private var checkMarkUpperCase = UIImageView()
    
    private let label : UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 25))
        label.text = "Input Password"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let minimumLenghtLabel : UILabel = {
        let label = UILabel()
        label.text = "minimum of 8 characters."
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    private let minimumDigitLabel : UILabel = {
        let label = UILabel()
        label.text = "minimum 1 digit."
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    private let minimumLowerCaseLabel : UILabel = {
        let label = UILabel()
        label.text = "minimum 1 lowercased"
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    private let minimumUpperCaseLabel : UILabel = {
        let label = UILabel()
        label.text = "minimum 1 uppercased"
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    private let backButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 45))
        button.setTitle("Back to Home", for: .normal)
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = .white
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.font = .systemFont(ofSize: 20)
        tf.placeholder = "input password"
        tf.layer.borderWidth = 1
        tf.layer.borderColor = UIColor.lightGray.cgColor
        tf.layer.cornerRadius = 4
        tf.autocapitalizationType = .none
        tf.isSecureTextEntry = true
        return tf
    }()
    
    private var verticalStack = UIStackView()
    
    private let progressView: UIProgressView = {
        let progress = UIProgressView()
        progress.translatesAutoresizingMaskIntoConstraints = false
        return progress
    }()
    
    let managerForValidatePasswordField = ValidatePasswordManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordTextField.delegate = self
        view.backgroundColor = .white
        view.addSubview(label)
        view.addSubview(passwordTextField)
        view.addSubview(progressView)
        createMark()
        verticalStack = createVerticalStack()
        view.addSubview(verticalStack)
        backButton.addTarget(self, action: #selector(backToHome), for: .touchUpInside)
    }
    
    @objc func backToHome(){
        dismiss(animated: true)
    }
    
    private func createVerticalStack() -> UIStackView {
        let stack = UIStackView(arrangedSubviews: [
            createHorizontalStack(image: checkMarkMinLenght, label: minimumLenghtLabel),
            createHorizontalStack(image: chekMarkDigit, label: minimumDigitLabel),
            createHorizontalStack(image: checkMarkLowerCase, label: minimumLowerCaseLabel),
            createHorizontalStack(image: checkMarkUpperCase, label: minimumUpperCaseLabel),
            backButton])
        stack.axis = .vertical
        stack.spacing = 4
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }
    
    private func createMark(){
        checkMarkMinLenght = createCheckMark()
        chekMarkDigit = createCheckMark()
        checkMarkLowerCase = createCheckMark()
        checkMarkUpperCase = createCheckMark()
    }
    
    private func createHorizontalStack(image: UIImageView, label: UILabel) -> UIStackView {
        let stack = UIStackView(arrangedSubviews: [image,label])
        stack.axis = .horizontal
        stack.alignment = .center
        stack.spacing = 6
        return stack
    }
    
    private func createCheckMark() -> UIImageView{
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "minus")
        imageView.tintColor = .black
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor).isActive = true
        return imageView
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureLabel()
        configurePasswordTextField()
        сonfigureProgressView()
        сonfigureVerticalStack()
    }
    
    private func configureLabel(){
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
    }
    private func configurePasswordTextField() {
        passwordTextField.delegate = self
        passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: label.topAnchor, constant: 60).isActive = true
    }
    private func сonfigureProgressView(){
        progressView.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor).isActive = true
        progressView.widthAnchor.constraint(equalTo: passwordTextField.widthAnchor).isActive = true
        progressView.centerXAnchor.constraint(equalTo: passwordTextField.centerXAnchor).isActive = true
    }
    private func сonfigureVerticalStack(){
        verticalStack.topAnchor.constraint(equalTo: progressView.bottomAnchor, constant: 30).isActive = true
        verticalStack.leadingAnchor.constraint(equalTo: passwordTextField.leadingAnchor).isActive = true
        verticalStack.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor).isActive = true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        
        progress = 0
        
        passwordValidationService(updatedText: updatedText)
        
        return true
    }
    
    func passwordValidationService(updatedText: String) {
       
        if managerForValidatePasswordField.minimumCharacters(text: updatedText) {
            completeCondition(label: minimumLenghtLabel, image: checkMarkMinLenght)
        } else {
            basicCondition(label: minimumLenghtLabel, image: checkMarkMinLenght)
        }
        
        if  managerForValidatePasswordField.oneDigit(text: updatedText) {
            completeCondition(label: minimumDigitLabel, image: chekMarkDigit)
        } else {
            basicCondition(label: minimumDigitLabel, image: chekMarkDigit)
        }
        
        if managerForValidatePasswordField.oneLowerCaseLetter(text: updatedText) {
            completeCondition(label: minimumLowerCaseLabel, image: checkMarkLowerCase)
        } else {
            basicCondition(label: minimumLowerCaseLabel, image: checkMarkLowerCase)
        }
        
        if managerForValidatePasswordField.oneCapitalLetter(text: updatedText) {
            completeCondition(label: minimumUpperCaseLabel, image: checkMarkUpperCase)
        } else {
            basicCondition(label: minimumUpperCaseLabel, image: checkMarkUpperCase)
        }
        
        configureProgress()
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
