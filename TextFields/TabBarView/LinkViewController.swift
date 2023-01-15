//
//  LinkViewController.swift
//  TextFieldWithTabBar
//
//  Created by Olya Sabadina on 2022-12-31.
//

import UIKit
import SafariServices

class LinkViewController: UIViewController, UITextFieldDelegate{
    
    private var url = ""
    
    private let label : UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 25))
        label.text = "Input Link Adress"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let linkTextField: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = .white
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.font = .systemFont(ofSize: 20)
        tf.placeholder = "www.example.com"
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
        view.addSubview(linkTextField)
        view.addSubview(backButton)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureLabel()
        configureLinkTextField()
        configureBackButton()
    }
    
    @objc func backToHome(){
        dismiss(animated: true)
    }
    
    @objc func getValideLinkTextField() {
        guard ValidateManager().isValidelinkMask(text: url) else {return}
            if url.hasPrefix("www.") {
                url.insert(contentsOf: "https://", at: url.startIndex)
            }
            openURL(urlAdress: url)
        }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        
        registerOpenURL(textField: textField, updatedText: updatedText)
        
        return true
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
    
    private func configureLabel(){
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
    }
    
    private func configureLinkTextField() {
        linkTextField.delegate = self
        linkTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        linkTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        linkTextField.topAnchor.constraint(equalTo: label.topAnchor, constant: 60).isActive = true
    }
    
    private func configureBackButton() {
        backButton.addTarget(self, action: #selector(backToHome), for: .touchUpInside)
        backButton.topAnchor.constraint(equalTo: linkTextField.topAnchor, constant: 150).isActive = true
        backButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        backButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}
