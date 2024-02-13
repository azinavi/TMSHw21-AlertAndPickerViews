//
//  ViewController+Ext.swift
//  ChangeAttributedText
//
//  Created by azinavi on 12/2/24.
//

import UIKit

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        inputTextField.resignFirstResponder()
        inputTextField.text = .none
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if (textField == startRangeChangeColorTextField || textField == endRangeChangeColorTextField) {
            // Проверяем, если вводимый символ - цифра
            let allowedCharacters = CharacterSet(charactersIn: "0123456789")
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if (textField == inputTextField) {
            if (textField.text!.count <= 0) {
                shakeTextField()
                textField.layer.borderColor = UIColor.red.cgColor
                textField.layer.borderWidth = 1.5
            } else {
                textField.layer.borderColor = UIColor.green.cgColor
                let plainString = textField.text
                let attributedString = NSMutableAttributedString(string: plainString ?? "")
                textLabel.attributedText = attributedString
                setupSegmentControlFontStyle()
                setupSegmentControlTextAligment()
                setupChangeColorView()
            }
        }
    }
}
