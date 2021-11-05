//
//  RegistrationViewController.swift
//  com.work.with.filemanager
//
//  Created by v.milchakova on 04.11.2021.
//

import UIKit
import SnapKit
import PhoneNumberKit

class RegistrationViewController: UIViewController, UITextFieldDelegate, UIScrollViewDelegate {
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
        scrollView.addSubview(headerDescriptionLabel)
        scrollView.addSubview(descriptionLabel)
        scrollView.addSubview(phoneTextField)
        scrollView.addSubview(nextButton)
        scrollView.addSubview(policyLabel)

        setConstraints()
    }

    func setConstraints() {
        scrollView.snp.makeConstraints { (make) -> Void in
            make.edges.equalTo(view)
        }

        titleLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(scrollView).offset(148)
            make.height.equalTo(22)
            make.leading.equalTo(view).offset(76)
            make.trailing.equalTo(view).offset(-76)
        }
        
        headerDescriptionLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(titleLabel.snp.bottom).offset(70)
            make.height.equalTo(24)
            make.leading.equalTo(view).offset(126)
            make.trailing.equalTo(view).offset(-126)
        }
        
        descriptionLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(headerDescriptionLabel.snp.bottom).offset(5)
            make.height.equalTo(50)
            make.leading.equalTo(view).offset(70)
            make.trailing.equalTo(view).offset(-70)
        }

        phoneTextField.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(16)
            make.height.equalTo(48)
            make.leading.equalTo(view).offset(57)
            make.trailing.equalTo(view).offset(-58)
        }

        nextButton.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(phoneTextField.snp.bottom).offset(70)
            make.height.equalTo(47)
            make.leading.equalTo(view).offset(127)
            make.trailing.equalTo(view).offset(-128)
        }
        
        policyLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(nextButton.snp.bottom).offset(20)
            make.height.equalTo(85)
            make.leading.equalTo(view).offset(58)
            make.trailing.equalTo(view).offset(-59)
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
        let view = UILabel()
        view.toAutoLayout()
        view.backgroundColor = .white
        view.textColor = UIColor(red: 0.149, green: 0.196, blue: 0.22, alpha: 1)
        view.font = UIFont(name: "Inter-SemiBold", size: 18)
        view.textAlignment = .center
        view.attributedText = NSMutableAttributedString(string: "ЗАРЕГИСТРИРОВАТЬСЯ", attributes: [NSAttributedString.Key.kern: 0.18])
        return view
    }()
    
    private lazy var headerDescriptionLabel: UILabel = {
        let view = UILabel()
        view.toAutoLayout()
        view.backgroundColor = .white
        view.textColor = UIColor(red: 0.149, green: 0.196, blue: 0.22, alpha: 1)
        view.font = UIFont(name: "Inter-Medium", size: 16)
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.24
        paragraphStyle.alignment = NSTextAlignment.center
        view.attributedText = NSMutableAttributedString(string: "Введите номер", attributes: [NSAttributedString.Key.kern: 0.16, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        return view
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let view = UILabel()
        view.toAutoLayout()
        view.backgroundColor = .white
        view.textColor = UIColor(red: 0.495, green: 0.507, blue: 0.512, alpha: 1)
        view.font = UIFont(name: "Inter-Medium", size: 12)
        view.numberOfLines = 0
        view.lineBreakMode = .byWordWrapping
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.03
        paragraphStyle.alignment = NSTextAlignment.center
        view.attributedText = NSMutableAttributedString(string: "Ваш номер будет использоваться для входа в аккаунт", attributes: [NSAttributedString.Key.kern: -0.17, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        return view
    }()
    
    private lazy var phoneTextField: PhoneNumberTextField = {
        let view = PhoneNumberTextField()
        view.delegate = self

        do {
        let phoneNumberKit = PhoneNumberKit()
            let phoneNumber = try phoneNumberKit.parse("+7(000)-000-00-00")
            let phoneNumberCustomDefaultRegion = try phoneNumberKit.parse("+7(000)-000-00-00", withRegion: "RU", ignoreType: true)
            let f = phoneNumberKit.format(phoneNumber, toType: PhoneNumberFormat.national)
        }
        catch {
            print("Generic parser error")
        }

        view.textColor = .darkGray
        view.placeholder = "+_ (___) ___ - __ - __"
        view.textAlignment = .center
        view.font = UIFont.systemFont(ofSize: 20)
        view.maxDigits = 11

        view.layer.cornerRadius = 10
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(red: 0.149, green: 0.196, blue: 0.22, alpha: 1).cgColor

        view.leftViewMode = .always
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 20))
        view.leftView = paddingView

        view.toAutoLayout()
        return view
    }()
    
    private lazy var nextButton: UIButton = {
        let view = UIButton()

        view.setTitle("ДАЛЕЕ", for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.titleLabel!.font = UIFont(name: "Inter-Medium", size: 16)
        
        view.addTarget(self, action: #selector(nextButtonPressed), for:.touchUpInside)
        view.layer.backgroundColor = UIColor(red: 0.149, green: 0.196, blue: 0.22, alpha: 1).cgColor
        view.layer.cornerRadius = 10

        view.toAutoLayout()
        return view
    }()
    
    private lazy var policyLabel: UILabel = {
        let view = UILabel()
        view.toAutoLayout()
        view.backgroundColor = .white
        view.textColor = UIColor(red: 0.495, green: 0.507, blue: 0.512, alpha: 1)
        view.font = UIFont(name: "Inter-Medium", size: 12)
        view.numberOfLines = 0
        view.lineBreakMode = .byWordWrapping
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.03
        paragraphStyle.alignment = NSTextAlignment.center
        view.attributedText = NSMutableAttributedString(string: "Нажимая кнопку “Далее” Вы принимаете пользовательское Соглашение и политику конфедициальности ", attributes: [NSAttributedString.Key.kern: -0.17, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        return view
    }()
    
    @objc func nextButtonPressed() {
        print("Нажали кнопку логина")
        let vc = AcceptRegistrationViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: false, completion: nil)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        let newLength = text.count + string.count - range.length
        return newLength <= 16
   }
}
