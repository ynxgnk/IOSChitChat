//
//  ViewController.swift
//  IOSChitChat
//
//  Created by Nazar Kopeyka on 19.04.2023.
//

import UIKit

final class LoginViewController: UIViewController { /* 26 add Login */

    private let usernameField: UITextField = { /* 28 */
        let field = UITextField() /* 29 */
        field.placeholder = "Username..." /* 30 */
        field.autocapitalizationType = .none /* 31 */
        field.autocorrectionType = .no /* 32 */
        field.leftViewMode = .always /* 33 */
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50)) /* 34 */
        field.translatesAutoresizingMaskIntoConstraints = false /* 36 */
        field.backgroundColor = .secondarySystemBackground /* 44 */
        return field /* 35 */
    }()
    
    private let button: UIButton = { /* 45 */
       let button = UIButton() /* 46 */
        button.backgroundColor = .systemGreen /* 47 */
        button.translatesAutoresizingMaskIntoConstraints = false /* 48 */
        button.setTitleColor(.white, for: .normal) /* 49 */
        button.setTitle("Continue", for: .normal) /* 50 */
        button.layer.cornerRadius = 8 /* 51 */
        button.layer.masksToBounds = true /* 52 */
        return button /* 53 */
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "IOS ChitChat" /* 6 */
        view.backgroundColor = .systemBackground /* 7 */
        view.addSubview(usernameField) /* 37 */
        view.addSubview(button) /* 54 */
        addConstraints() /* 38 */
        button.addTarget(self, action: #selector(didTapContinue), for: .touchUpInside) /* 56 */
    }
    
    override func viewDidAppear(_ animated: Bool) { /* 39 */
        super.viewDidAppear(animated) /* 40 */
        usernameField.becomeFirstResponder() /* 41 */
        
        if ChatManager.shared.isSignedIn { /* 83 */
            presentChatList(animated: false) /* 84 */
        }
    }

    private func addConstraints() { /* 27 */
        NSLayoutConstraint.activate([ /* 42 */
            usernameField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50), /* 43 */
            usernameField.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 50), /* 43 */
            usernameField.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -50), /* 43 */
            usernameField.heightAnchor.constraint(equalToConstant: 50), /* 43 */

            button.topAnchor.constraint(equalTo: usernameField.bottomAnchor, constant: 20), /* 55 */
            button.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50), /* 55 */
            button.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50), /* 55 */
            button.heightAnchor.constraint(equalToConstant: 50) /* 55 */
        ])
    }
    
    @objc private func didTapContinue() { /* 57 */
        usernameField.resignFirstResponder() /* 58 */
        guard let text = usernameField.text, !text.isEmpty else { /* 59 */
            return /* 60 */
        }
        
        ChatManager.shared.signIn(with: text) { [weak self] success in /* 61 */ /* 82 add weak self */
            guard success else { /* 62 */
                return /* 63 */
            }
            print("Did Login") /* 78 */
            //Take user to chat list
            DispatchQueue.main.async { /* 80 */
                self?.presentChatList() /* 81 */
            }
        }
    }
    
    func presentChatList(animated: Bool = true) { /* 79 */
        print("Should show chat list") /* 86 */
        guard let vc = ChatManager.shared.createChanelList() else { return } /* 94 */
        
        vc.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose,
                                                               target: self,
                                                               action: #selector(didTapCompose)) /* 161 */
        
        let tabVC = TabBarViewController(chatList: vc) /* 111 */
        tabVC.modalPresentationStyle = .fullScreen /* 112 */
        
        present(tabVC, animated: animated) /* 95 */ /* 110 change vc */
    }
    
    @objc private func didTapCompose() { /* 162 */
        let alert = UIAlertController(title: "New Chat",
                                      message: "Enter channel name",
                                      preferredStyle: .alert) /* 163 */
        
        alert.addTextField() /* 165 */
        alert.addAction(.init(title: "Cancel", style: .cancel)) /* 166 */
        alert.addAction(.init(title: "Create", style: .default, handler: { _ in /* 167 */
            guard let text = alert.textFields?.first?.text, !text.isEmpty else { /* 168 */
                return /* 169 */
            }
            DispatchQueue.main.async { /* 171 */
                ChatManager.shared.createNewChannel(name: text) /* 170 */
            }
        }))
        
        presentedViewController?.present(alert, animated: true) /* 164 */
    }
}

