//
//  IndicLimitViewController.swift
//  TextFieldWithTabBar
//
//  Created by Olya Sabadina on 2022-12-31.
//

import UIKit

class IndicationLimitViewController: UIViewController, UITextFieldDelegate {
    
    static let maxLength = 10
    
    private let label : UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 25))
        label.text = "Input limit text (\(maxLength) charecters)"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let limitlabel : UILabel = {
        let label = UILabel()//frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        label.text = "\(maxLength)"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16)
        label.backgroundColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let limitTextField: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = .white
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.font = .systemFont(ofSize: 20)
        tf.placeholder = "limit = \(maxLength) charecters"
        tf.layer.borderWidth = 1
        tf.layer.borderColor = UIColor.lightGray.cgColor
        tf.layer.cornerRadius = 4
        tf.autocapitalizationType = .none
        return tf
    }()
    
    private let numberLimitSymbols = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(label)
        view.addSubview(limitTextField)
        view.addSubview(limitlabel)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureLabel()
        configureLimitTextFieldTextField()
        configurelimitlabel()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        
        let numberSymbols = updatedText.count
        let limit = numberLimitSymbols - numberSymbols
        limitlabel.text = "\(limit)"
        
        if numberSymbols > numberLimitSymbols {
            limitlabel.textColor = .red
            textField.layer.borderColor = UIColor.red.cgColor
            textField.layer.borderWidth = 1
            
            var myMutableString = NSMutableAttributedString()
            myMutableString = NSMutableAttributedString(string: currentText)
            
            myMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.black, range:NSRange(location: 0, length: numberLimitSymbols))
            
            textField.textColor = .red
            textField.attributedText = myMutableString
        } else {
            textField.textColor = .black
            textField.layer.borderWidth = 1
            limitlabel.textColor = .black
        }
        
        return true
    }
    
    private func configureLabel(){
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
    }
    
    private func configureLimitTextFieldTextField() {
        limitTextField.delegate = self
        limitTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        limitTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        limitTextField.topAnchor.constraint(equalTo: label.topAnchor, constant: 60).isActive = true
    }
    
    private func configurelimitlabel() {
        limitlabel.widthAnchor.constraint(equalToConstant: 28).isActive = true
        limitlabel.trailingAnchor.constraint(equalTo: limitTextField.trailingAnchor, constant: -30).isActive = true
        limitlabel.centerYAnchor.constraint(equalTo: limitTextField.bottomAnchor).isActive = true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}
