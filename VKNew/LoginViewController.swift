//
//  ViewController.swift
//  mega-meta
//
//  Created by v.milchakova on 30.10.2021.
//

import UIKit
import SnapKit
import PhoneNumberKit

class LoginViewController: UIViewController, UITextFieldDelegate, UIScrollViewDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Строка \(#line) в функции \(#function) в файле \(#file)")
        view.backgroundColor = .white
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        view.addSubview(scrollView)
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        
        scrollView.delegate = self
        scrollView.contentSize = view.frame.size
        
        scrollView.addSubview(titleLabel)
        scrollView.addSubview(descriptionLabel)
        scrollView.addSubview(phoneTextField)
        scrollView.addSubview(logInButton)

        setConstraints()
    }

    func setConstraints() {
        scrollView.snp.makeConstraints { (make) -> Void in
            make.edges.equalTo(view)
        }

        titleLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(scrollView).offset(224)
            make.leading.equalTo(view).offset(10)
            make.trailing.equalTo(view).offset(-10)
            make.height.equalTo(22)
        }
        
        descriptionLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(titleLabel.snp.bottom).offset(26)
            make.height.equalTo(60)
            make.leading.equalTo(view).offset(39)
            make.trailing.equalTo(view).offset(-39)
        }

        phoneTextField.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(12)
            make.height.equalTo(48)
            make.leading.equalTo(view).offset(57)
            make.trailing.equalTo(view).offset(-58)
        }

        logInButton.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(view).offset(93)
            make.trailing.equalTo(view).offset(-94)
            make.top.equalTo(phoneTextField.snp.bottom).offset(148)
            make.height.equalTo(47)
        }
    }
    
    @objc private func keyboardWillShow(notification: NSNotification){
//        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
//            scrollView.contentInset.bottom = keyboardSize.height
//            scrollView.verticalScrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
//        }
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }

    @objc private func keyboardWillHide(notification: NSNotification){
//        scrollView.contentInset.bottom = 0
//        scrollView.verticalScrollIndicatorInsets = .zero
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0 {
                self.view.frame.origin.y += keyboardSize.height
            }
        }
    }
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.toAutoLayout()
        return scrollView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.textColor = UIColor(red: 0.965, green: 0.592, blue: 0.027, alpha: 1)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont(name: "Inter-SemiBold", size: 18)
        label.attributedText = NSMutableAttributedString(string: "С возвращением", attributes: [NSAttributedString.Key.kern: 0.18])
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        var paragraphStyle = NSMutableParagraphStyle()

        paragraphStyle.lineHeightMultiple = 1.18

        label.attributedText = NSMutableAttributedString(string: "Введите номер телефона для входа в приложение", attributes: [NSAttributedString.Key.kern: 0.14, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textColor = UIColor(red: 0.149, green: 0.196, blue: 0.22, alpha: 1)
        label.font = UIFont(name: "Inter-Regular", size: 14)
        
//        var shadows = UIView()
//        shadows.frame = view.frame
//        shadows.clipsToBounds = false
//        label.addSubview(shadows)
//
//
//        let shadowPath0 = UIBezierPath(roundedRect: shadows.bounds, cornerRadius: 0)
//        let layer0 = CALayer()
//        layer0.shadowPath = shadowPath0.cgPath
//        layer0.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
//        layer0.shadowOpacity = 1
//        layer0.shadowRadius = 4
//        layer0.shadowOffset = CGSize(width: 0, height: 4)
//        layer0.bounds = shadows.bounds
//        layer0.position = shadows.center
//        shadows.layer.addSublayer(layer0)
        
        return label
    }()
    
    private lazy var phoneTextField: PhoneNumberTextField = {
        let field = PhoneNumberTextField()
        field.delegate = self

        do {
        let phoneNumberKit = PhoneNumberKit()
            let phoneNumber = try phoneNumberKit.parse("+7(000)-000-00-00")
            let phoneNumberCustomDefaultRegion = try phoneNumberKit.parse("+7(000)-000-00-00", withRegion: "RU", ignoreType: true)
            let f = phoneNumberKit.format(phoneNumber, toType: PhoneNumberFormat.national)
        }
        catch {
            print("Generic parser error")
        }

        field.textColor = .darkGray
        field.placeholder = "+_ (___) ___ - __ - __"
        field.textAlignment = .center
        field.font = UIFont.systemFont(ofSize: 20)
        field.maxDigits = 11

        field.layer.cornerRadius = 10
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor(red: 0.149, green: 0.196, blue: 0.22, alpha: 1).cgColor

        field.leftViewMode = .always
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 20))
        field.leftView = paddingView

        field.toAutoLayout()
        return field
    }()
    
    private lazy var logInButton: UIButton = {
        let button = UIButton()

        button.setTitle("ПОДТВЕРДИТЬ", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel!.font = UIFont(name: "Inter-Medium", size: 16)
        
        button.addTarget(self, action: #selector(loginButtonPressed), for:.touchUpInside)
        button.layer.backgroundColor = UIColor(red: 0.149, green: 0.196, blue: 0.22, alpha: 1).cgColor
        button.layer.cornerRadius = 10

        button.toAutoLayout()
        return button
    }()
    
    @objc func loginButtonPressed() {
        print("Нажали кнопку логина")
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        let newLength = text.count + string.count - range.length
        return newLength <= 16
   }
}

extension UIView {
    func toAutoLayout() {
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
