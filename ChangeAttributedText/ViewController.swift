//
//  ViewController.swift
//  ChangeAttributedText
//
//  Created by azinavi on 12/2/24.
//

import UIKit

class ViewController: UIViewController {
    var titlteLabel = UILabel()
    var textLabel = UILabel()
    var inputTextField = UITextField()
    var saveButton = UIButton(type: .system)
    var segmentControlFontStyle = UISegmentedControl()
    var segmentControlTextAligment = UISegmentedControl()
    var changeColorView = UIView()
    var changeColorTitle = UILabel()
    var countTextLabel = UILabel()
    var startRangeChangeColorTextField = UITextField()
    var endRangeChangeColorTextField = UITextField()
    var setRedColorButton = UIButton(type: .system)
    var setBlueColorButton = UIButton(type: .system)
    var setGreenColorButton = UIButton(type: .system)
    var setUnderlineButton = UIButton(type: .system)
    var resetButton = UIButton(type: .system)
    var textColor = UIColor()
    
    var startRange: Int = 0
    var endRange: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSuperView()
        setupTitleLabel()
        setupTextLabel()
        setupInputTextField()
        setupKeyboardSettings()
        setupSaveButton()
        
    }
    
    private func setupSuperView() {
        view.backgroundColor = .black
    }
    
    private func setupTitleLabel() {
        self.titlteLabel.numberOfLines = 1
        self.titlteLabel.textAlignment = .center
        self.titlteLabel.font = .boldSystemFont(ofSize: 30)
        self.titlteLabel.textColor = .systemCyan
        self.titlteLabel.text = "Редактор атрибутов"
        
        view.addSubview(titlteLabel)
        
        titlteLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titlteLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titlteLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titlteLabel.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
            titlteLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func setupTextLabel() {
        self.textLabel.numberOfLines = 0
        self.textLabel.textAlignment = .center
        self.textLabel.font = .boldSystemFont(ofSize: 16)
        self.textLabel.adjustsFontSizeToFitWidth = true
        self.textLabel.minimumScaleFactor = 0.5
        self.textLabel.textColor = .white
        self.textLabel.text = "Наберите текст для изменения атрибутов"
        
        view.addSubview(textLabel)
        
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textLabel.topAnchor.constraint(equalTo: titlteLabel.bottomAnchor, constant: 20),
            textLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textLabel.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
            textLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func setupInputTextField() {
        inputTextField.delegate = self
        inputTextField.placeholder = "Введите текст"
        inputTextField.attributedPlaceholder = NSAttributedString(
            string: "Введите текст", attributes: [NSAttributedString.Key.foregroundColor: UIColor.blue]
        )
        inputTextField.textAlignment = .center
        inputTextField.textColor = .blue
        inputTextField.layer.cornerRadius = 10
        inputTextField.layer.borderWidth = 1.3
        inputTextField.layer.borderColor = UIColor.blue.cgColor
        inputTextField.backgroundColor = .white
        
        view.addSubview(inputTextField)
        
        inputTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            inputTextField.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -80),
            inputTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            inputTextField.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
            inputTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func shakeTextField() {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 4
        animation.autoreverses = true
        
        let fromPoint = CGPoint(x: inputTextField.center.x - 10, y: inputTextField.center.y)
        let toPoint = CGPoint(x: inputTextField.center.x + 10, y: inputTextField.center.y)
        
        animation.fromValue = NSValue(cgPoint: fromPoint)
        animation.toValue = NSValue(cgPoint: toPoint)
        
        inputTextField.layer.add(animation, forKey: "position")
    }
    
    func setupKeyboardSettings() {
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideKeyboard)))
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func hideKeyboard() {
        self.view.endEditing(true)
        inputTextField.text = .none
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as?
            NSValue {
            let keyboardHeight = keyboardFrame.cgRectValue.height
            let bottomSpace = self.view.frame.height - (saveButton.frame.origin.y + saveButton.frame.height)
            self.view.frame.origin.y -= keyboardHeight - bottomSpace + 20
        }
    }
    
    @objc func keyboardWillHide() {
        self.view.frame.origin.y = 0
    }
    
    func setupSaveButton() {
        saveButton.setTitle("Сохранить", for: .normal)
        saveButton.setTitleColor(.white, for: .normal)
        saveButton.backgroundColor = .blue
        saveButton.layer.cornerRadius = 15
        saveButton.layer.borderWidth = 1.5
        saveButton.layer.borderColor = UIColor.systemBlue.cgColor
        saveButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideKeyboard)))
        saveButton.addTarget(self, action: #selector(saveText), for: .touchUpInside)
        
        view.addSubview(saveButton)
        
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            saveButton.topAnchor.constraint(equalTo: inputTextField.bottomAnchor, constant: 10),
            saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            saveButton.widthAnchor.constraint(equalToConstant: 130),
            saveButton.heightAnchor.constraint(equalToConstant: 35)
        ])
    }
    @objc func saveText() {
        textLabel.text = inputTextField.text
        if (inputTextField.text!.count <= 0) {
            shakeTextField()
            inputTextField.layer.borderColor = UIColor.red.cgColor
            inputTextField.layer.borderWidth = 1.5
        } else {
            inputTextField.layer.borderColor = UIColor.green.cgColor
            let plainString = inputTextField.text
            let attributedString = NSMutableAttributedString(string: plainString ?? "")
            textLabel.attributedText = attributedString
            textLabel.textAlignment = .left
            textLabel.textColor = .systemBlue
            inputTextField.text = .none
            setupSegmentControlFontStyle()
            setupSegmentControlTextAligment()
            setupChangeColorView()
        }
    }
    
    func setupSegmentControlFontStyle() {
        let menuArray = ["Default", "Italic", "Bold"]
        self.segmentControlFontStyle = UISegmentedControl(items: menuArray)
        self.segmentControlFontStyle.backgroundColor = .white
        self.segmentControlFontStyle.layer.borderWidth = 2
        self.segmentControlFontStyle.layer.borderColor = UIColor.systemBlue.cgColor
        self.segmentControlFontStyle.selectedSegmentTintColor = .systemBlue
        self.segmentControlFontStyle.addTarget(self, action: #selector(selectedStyleValue), for: .valueChanged)
        
        view.addSubview(segmentControlFontStyle)
        
        segmentControlFontStyle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            segmentControlFontStyle.bottomAnchor.constraint(equalTo: inputTextField.topAnchor, constant: -20),
            segmentControlFontStyle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            segmentControlFontStyle.widthAnchor.constraint(equalToConstant: 180),
            segmentControlFontStyle.heightAnchor.constraint(equalToConstant: 25)
        ])
    }
    @objc private func selectedStyleValue(target: UISegmentedControl) {
        if (target == self.segmentControlFontStyle) {
            let segmentIndex = target.selectedSegmentIndex
            if segmentIndex == 0 {
                self.textLabel.font = UIFont.systemFont(ofSize: 16)
            } else if (segmentIndex == 1) {
                self.textLabel.font = UIFont.italicSystemFont(ofSize: 16)
            } else if (segmentIndex == 2) {
                self.textLabel.font = UIFont.boldSystemFont(ofSize: 16)
            } else {
                print("Error")
            }
        }
    }
    
    func setupSegmentControlTextAligment() {
        let menuArray = ["left", "Center", "Right"]
        self.segmentControlTextAligment = UISegmentedControl(items: menuArray)
        self.segmentControlTextAligment.backgroundColor = .white
        self.segmentControlTextAligment.layer.borderWidth = 2
        self.segmentControlTextAligment.layer.borderColor = UIColor.systemBlue.cgColor
        self.segmentControlTextAligment.selectedSegmentTintColor = .systemBlue
        self.segmentControlTextAligment.addTarget(self, action: #selector(selectedAligmentValue), for: .valueChanged)
        
        view.addSubview(segmentControlTextAligment)
        
        segmentControlTextAligment.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            segmentControlTextAligment.bottomAnchor.constraint(equalTo: inputTextField.topAnchor, constant: -20),
            segmentControlTextAligment.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            segmentControlTextAligment.widthAnchor.constraint(equalToConstant: 180),
            segmentControlTextAligment.heightAnchor.constraint(equalToConstant: 25)
        ])
    }
    @objc private func selectedAligmentValue(target: UISegmentedControl) {
        if (target == self.segmentControlTextAligment) {
            let segmentIndex = target.selectedSegmentIndex
            if segmentIndex == 0 {
                self.textLabel.textAlignment = .left
            } else if (segmentIndex == 1) {
                self.textLabel.textAlignment = .center
            } else if (segmentIndex == 2) {
                self.textLabel.textAlignment = .right
            } else {
                print("Error")
            }
        }
    }
    
    func setupChangeColorView() {
        changeColorView.backgroundColor = .white
        changeColorView.layer.cornerRadius = 15
        changeColorView.layer.borderWidth = 1
        changeColorView.layer.borderColor = UIColor.blue.cgColor
        
        view.addSubview(changeColorView)
        
        changeColorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            changeColorView.bottomAnchor.constraint(equalTo: segmentControlTextAligment.topAnchor, constant: -20),
            changeColorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            changeColorView.widthAnchor.constraint(equalToConstant: 180),
            changeColorView.heightAnchor.constraint(equalToConstant: 85)
        ])
        
        setupChangeColorTitle()
        setupCountTextLabel()
        setupStartRangeChangeColorTextField()
        setupEndRangeChangeColorTextField()
        setupRedColorButton()
        setupBlueColorButton()
        setupGreenColorButton()
        setupSetUnderlineButton()
        setupResetButton()
    }
    
    private func setupChangeColorTitle() {
        changeColorTitle.text = "Изменить текст"
        changeColorTitle.textAlignment = .left
        changeColorTitle.font = .boldSystemFont(ofSize: 10)
        
        self.changeColorView.addSubview(changeColorTitle)
        
        changeColorTitle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            changeColorTitle.topAnchor.constraint(equalTo: changeColorView.topAnchor, constant: 5),
            changeColorTitle.leadingAnchor.constraint(equalTo: changeColorView.leadingAnchor, constant: 5),
            changeColorTitle.widthAnchor.constraint(equalToConstant: 100),
            changeColorTitle.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    private func setupCountTextLabel() {
        countTextLabel.text = "Длина: \(textLabel.text?.count ?? 0)"
        countTextLabel.numberOfLines = 0
        countTextLabel.textAlignment = .right
        countTextLabel.font = .boldSystemFont(ofSize: 10)
        
        self.changeColorView.addSubview(countTextLabel)
        
        countTextLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            countTextLabel.topAnchor.constraint(equalTo: changeColorView.topAnchor, constant: 5),
            countTextLabel.trailingAnchor.constraint(equalTo: changeColorView.trailingAnchor, constant: -5),
            countTextLabel.widthAnchor.constraint(equalToConstant: 70),
            countTextLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    private func setupStartRangeChangeColorTextField() {
        startRangeChangeColorTextField.delegate = self
        startRangeChangeColorTextField.placeholder = "0"
        startRangeChangeColorTextField.textAlignment = .center
        startRangeChangeColorTextField.textColor = .blue
        startRangeChangeColorTextField.layer.cornerRadius = 10
        startRangeChangeColorTextField.layer.borderWidth = 1.3
        startRangeChangeColorTextField.layer.borderColor = UIColor.blue.cgColor
        startRangeChangeColorTextField.backgroundColor = .white
        
        changeColorView.addSubview(startRangeChangeColorTextField)
        
        startRangeChangeColorTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            startRangeChangeColorTextField.topAnchor.constraint(equalTo: changeColorTitle.bottomAnchor, constant: 2),
            startRangeChangeColorTextField.trailingAnchor.constraint(equalTo: changeColorView.centerXAnchor, constant: -42),
            startRangeChangeColorTextField.widthAnchor.constraint(equalToConstant: 35),
            startRangeChangeColorTextField.heightAnchor.constraint(equalToConstant: 25)
        ])
    }
    private func setupEndRangeChangeColorTextField() {
        endRangeChangeColorTextField.delegate = self
        endRangeChangeColorTextField.placeholder = "0"
        endRangeChangeColorTextField.textAlignment = .center
        endRangeChangeColorTextField.textColor = .blue
        endRangeChangeColorTextField.layer.cornerRadius = 10
        endRangeChangeColorTextField.layer.borderWidth = 1.3
        endRangeChangeColorTextField.layer.borderColor = UIColor.blue.cgColor
        endRangeChangeColorTextField.backgroundColor = .white
        
        changeColorView.addSubview(endRangeChangeColorTextField)
        
        endRangeChangeColorTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            endRangeChangeColorTextField.topAnchor.constraint(equalTo: changeColorTitle.bottomAnchor, constant: 2),
            endRangeChangeColorTextField.trailingAnchor.constraint(equalTo: changeColorView.centerXAnchor, constant: -2),
            endRangeChangeColorTextField.widthAnchor.constraint(equalToConstant: 35),
            endRangeChangeColorTextField.heightAnchor.constraint(equalToConstant: 25)
        ])
    }
    
    private func setupRedColorButton() {
        setRedColorButton.backgroundColor = .red
        setRedColorButton.layer.cornerRadius = 10
        setRedColorButton.layer.borderWidth = 1
        setRedColorButton.layer.borderColor = UIColor.systemBlue.cgColor
        setRedColorButton.addTarget(self, action: #selector(setColorText(_:)), for: .touchUpInside)
        
        changeColorView.addSubview(setRedColorButton)
        
        setRedColorButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            setRedColorButton.bottomAnchor.constraint(equalTo: changeColorView.bottomAnchor, constant: -7),
            setRedColorButton.trailingAnchor.constraint(equalTo: changeColorView.centerXAnchor, constant: -2),
            setRedColorButton.widthAnchor.constraint(equalToConstant: 35),
            setRedColorButton.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    private func setupGreenColorButton() {
        setGreenColorButton.backgroundColor = .green
        setGreenColorButton.layer.cornerRadius = 10
        setGreenColorButton.layer.borderWidth = 1
        setGreenColorButton.layer.borderColor = UIColor.systemBlue.cgColor
        setGreenColorButton.addTarget(self, action: #selector(setColorText(_:)), for: .touchUpInside)
        
        changeColorView.addSubview(setGreenColorButton)
        
        setGreenColorButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            setGreenColorButton.leadingAnchor.constraint(equalTo: changeColorView.centerXAnchor, constant: 2),
            setGreenColorButton.bottomAnchor.constraint(equalTo: changeColorView.bottomAnchor, constant: -7),
            setGreenColorButton.widthAnchor.constraint(equalToConstant: 35),
            setGreenColorButton.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    private func setupBlueColorButton() {
        setBlueColorButton.backgroundColor = .blue
        setBlueColorButton.layer.cornerRadius = 10
        setBlueColorButton.layer.borderWidth = 1
        setBlueColorButton.layer.borderColor = UIColor.systemBlue.cgColor
        setBlueColorButton.addTarget(self, action: #selector(setColorText(_:)), for: .touchUpInside)
        
        changeColorView.addSubview(setBlueColorButton)
        
        setBlueColorButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            setBlueColorButton.trailingAnchor.constraint(equalTo: setRedColorButton.leadingAnchor, constant: -5),
            setBlueColorButton.bottomAnchor.constraint(equalTo: changeColorView.bottomAnchor, constant: -7),
            setBlueColorButton.widthAnchor.constraint(equalToConstant: 35),
            setBlueColorButton.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    
    private func setupSetUnderlineButton() {
        setUnderlineButton.backgroundColor = .white
        setUnderlineButton.setTitle("_", for: .normal)
        setUnderlineButton.setTitleColor(.black, for: .normal)
        setUnderlineButton.layer.cornerRadius = 10
        setUnderlineButton.layer.borderWidth = 1
        setUnderlineButton.layer.borderColor = UIColor.systemBlue.cgColor
        setUnderlineButton.addTarget(self, action: #selector(setColorText(_:)), for: .touchUpInside)
        
        changeColorView.addSubview(setUnderlineButton)
        
        setUnderlineButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            setUnderlineButton.leadingAnchor.constraint(equalTo: setGreenColorButton.trailingAnchor, constant: 5),
            setUnderlineButton.bottomAnchor.constraint(equalTo: changeColorView.bottomAnchor, constant: -7),
            setUnderlineButton.widthAnchor.constraint(equalToConstant: 35),
            setUnderlineButton.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    private func setupResetButton() {
        resetButton.backgroundColor = .white
        resetButton.setTitle("Сбросить", for: .normal)
        resetButton.titleLabel?.font = .systemFont(ofSize: 13, weight: .medium)
        
        resetButton.setTitleColor(.blue, for: .normal)
        resetButton.layer.cornerRadius = 10
        resetButton.layer.borderWidth = 1
        resetButton.layer.borderColor = UIColor.blue.cgColor
        resetButton.addTarget(self, action: #selector(setColorText(_:)), for: .touchUpInside)
        
        changeColorView.addSubview(resetButton)
        
        resetButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            resetButton.leadingAnchor.constraint(equalTo: endRangeChangeColorTextField.trailingAnchor, constant: 5),
            resetButton.topAnchor.constraint(equalTo: changeColorTitle.bottomAnchor, constant: 2),
            resetButton.widthAnchor.constraint(equalToConstant: 75),
            resetButton.heightAnchor.constraint(equalToConstant: 25)
        ])
    }
    @objc func setColorText( _ sender: UIButton) {
        let length = Int((endRangeChangeColorTextField.text) ?? "0")
        let acceptLenth = countTextLabel.text!.count
        
        if (length ?? 0 <= acceptLenth) {
            if sender == setRedColorButton {
                textColor = .red
                let attributedString = NSMutableAttributedString(string: textLabel.text ?? "")
                let first = Int(startRangeChangeColorTextField.text!) ?? 0
                let second = Int(endRangeChangeColorTextField.text!) ?? 0
                if(first < second) {
                    attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red, range: NSRange(location: first, length: second))
                    textLabel.attributedText = attributedString
                } else {
                    startRangeChangeColorTextField.text = .none
                    endRangeChangeColorTextField.text = .none
                }
            }
            
            if sender == setGreenColorButton {
                let attributedString = NSMutableAttributedString(string: textLabel.text ?? "")
                let first = Int(startRangeChangeColorTextField.text!) ?? 0
                let second = Int(endRangeChangeColorTextField.text!) ?? 0
                if(first < second) {
                    attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.green, range: NSRange(location: first, length: second))
                    textLabel.attributedText = attributedString
                } else {
                    startRangeChangeColorTextField.text = .none
                    endRangeChangeColorTextField.text = .none
                }
            }
            if sender == setBlueColorButton {
                let attributedString = NSMutableAttributedString(string: textLabel.text ?? "")
                let first = Int(startRangeChangeColorTextField.text!) ?? 0
                let second = Int(endRangeChangeColorTextField.text!) ?? 0
                if(first < second) {
                    attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.blue, range: NSRange(location: first, length: second))
                    textLabel.attributedText = attributedString
                } else {
                    startRangeChangeColorTextField.text = .none
                    endRangeChangeColorTextField.text = .none
                }
            }
            if sender == setUnderlineButton {
                let attributedString = NSMutableAttributedString(string: textLabel.text ?? "")
                let first = Int(startRangeChangeColorTextField.text!) ?? 0
                let second = Int(endRangeChangeColorTextField.text!) ?? 0
                if(first < second) {
                    attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: first, length: second))
                    textLabel.attributedText = attributedString
                } else {
                    startRangeChangeColorTextField.text = .none
                    endRangeChangeColorTextField.text = .none
                }
                //MARK: Нужно доработать установку цвета!
                var range = NSRange(location: first, length: second)
                
                if let textColor = attributedString.attribute(NSAttributedString.Key.foregroundColor, at: 0, effectiveRange: &range) as? UIColor {
                    print("Цвет  в  диапазоне: \(textColor)")
                } else {
                    print("Цвет  не найден в  диапазоне")
                }
                
                attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: textColor, range: NSRange(location: first, length: second))
                
            }
        } else {
            startRangeChangeColorTextField.text = .none
            endRangeChangeColorTextField.text = .none
        }
        
        if sender == resetButton {
            let plainString = textLabel.attributedText!.string
            textLabel.text = plainString
            startRangeChangeColorTextField.text = .none
            endRangeChangeColorTextField.text = .none
            segmentControlFontStyle.selectedSegmentIndex = 0
            segmentControlTextAligment.selectedSegmentIndex = 1
        }
    }
}
