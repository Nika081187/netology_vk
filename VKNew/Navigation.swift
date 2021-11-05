//
//  Navigation.swift
//  VKNew
//
//  Created by v.milchakova on 05.11.2021.
//

import Foundation
import UIKit

class Navigation: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let backbutton = UIButton(type: .custom)
//        backbutton.setImage(UIImage(named: "BackButton.png"), for: .normal)
        backbutton.setTitle("Back", for: .normal)
        backbutton.setTitleColor(backbutton.tintColor, for: .normal)
        backbutton.addTarget(self, action: #selector(backAction), for: .touchUpInside)

        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backbutton)
    }

    @objc func backAction() -> Void {
        self.navigationController?.popViewController(animated: true)
    }
}
