//
//  NoDigitsViewController.swift
//  TextFieldWithTabBar
//
//  Created by Olya Sabadina on 2022-12-31.
//
import Foundation
import UIKit

class NoDigitsViewController: UIViewController, UITextFieldDelegate {
    
    private var inputedText = ""
    
    private let label : UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 25))
        label.text = "Allows characters without digits"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let noDigitsTextField: UITextField = {
        var tf = UITextField()
        tf.backgroundColor = .white
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.font = .systemFont(ofSize: 20)
        tf.placeholder = "enter any characters"
        tf.layer.borderWidth = 1
        tf.layer.borderColor = UIColor.lightGray.cgColor
        tf.layer.cornerRadius = 4
        tf.autocapitalizationType = .none
        return tf
    }()
    
    private let backButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 45))
        button.setTitle("Back to Home", for: .normal)
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(label)
        view.addSubview(noDigitsTextField)
        view.addSubview(backButton)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureNoDigitsTextField()
        configureLabel()
        configureBackButton()
    }
    
    @objc func backToHome(){
        dismiss(animated: true)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        return !ValidateManager().noDigits(text: updatedText)
    }
    
    private func configureLabel(){
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
    }
    
    private func configureNoDigitsTextField() {
        noDigitsTextField.delegate = self
        noDigitsTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        noDigitsTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        noDigitsTextField.topAnchor.constraint(equalTo: label.topAnchor, constant: 60).isActive = true
    }
    
    private func configureBackButton() {
        backButton.addTarget(self, action: #selector(backToHome), for: .touchUpInside)
        backButton.topAnchor.constraint(equalTo: noDigitsTextField.topAnchor, constant: 150).isActive = true
        backButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        backButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}


