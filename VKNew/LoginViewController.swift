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
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            scrollView.contentInset.bottom = keyboardSize.height / 2
            scrollView.verticalScrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        }
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height / 2
            }
        }
    }

    @objc private func keyboardWillHide(notification: NSNotification){
        scrollView.contentInset.bottom = 0
        scrollView.verticalScrollIndicatorInsets = .zero
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0 {
                self.view.frame.origin.y += keyboardSize.height / 2
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
        
        label.layer.masksToBounds = false
        label.layer.shadowColor = UIColor.systemGray2.cgColor
        label.layer.shadowOpacity = 1
        label.layer.shadowOffset = CGSize(width: -2, height: 2)
        label.layer.shadowRadius = 3
        label.layer.shouldRasterize = true
        
        return label
    }()
    
    private lazy var phoneTextField: PhoneNumberTextField = {
        let field = PhoneNumberTextField()
        field.delegate = self

        let phoneNumberKit = PhoneNumberKit()

        do {
            let phoneNumber = try phoneNumberKit.parse("(968) 321 15 95")
            let phoneNumberCustomDefaultRegion = try phoneNumberKit.parse("(968) 321 15 95", withRegion: "RU", ignoreType: true)
        }
        catch {
            print("Generic parser error")
        }
        
        field.textColor = .darkGray
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
        let vc = MainTabBarController()
        navigationController?.pushViewController(vc, animated: false)
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
