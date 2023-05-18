//
//  SettingsViewController.swift
//  IOSChitChat
//
//  Created by Nazar Kopeyka on 19.04.2023.
//

import UIKit

class SettingsViewController: UIViewController {

    
    private let imageView: UIImageView = { /* 117 */
        let imageView = UIImageView() /* 118 */
        imageView.translatesAutoresizingMaskIntoConstraints = false /* 119 */
        imageView.image = UIImage(systemName: "person.circle") /* 120 */
        imageView.contentMode = .scaleAspectFit /* 121 */
        return imageView /* 122 */
    }()
    
    private let label: UILabel = { /* 123 */
        let label = UILabel() /* 124 */
        label.textAlignment = .center /* 125 */
        label.font = .systemFont(ofSize: 24, weight: .medium) /* 126 */
        label.translatesAutoresizingMaskIntoConstraints = false /* 127 */
        label.textColor = .label /* 128 */
        return label /* 129 */
    }()
    
    private let button: UIButton = { /* 130 */
        let button = UIButton() /* 131 */
        button.translatesAutoresizingMaskIntoConstraints = false /* 132 */
        button.setTitleColor(.red, for: .normal) /* 133 */
        button.setTitle("Sign Out", for: .normal) /* 134 */
        return button /* 135 */
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Settings" /* 113 */
        
        view.backgroundColor = .systemBackground /* 114 */
        view.addSubview(imageView) /* 136 */
        view.addSubview(label) /* 137 */
        view.addSubview(button) /* 138 */
        
        label.text = ChatManager.shared.currentUser /* 148 */
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside) /* 139 */
        
        addConstraints() /* 116 */
    }
    
    @objc private func didTapButton() { /* 140 */
        ChatManager.shared.signOut() /* 141 */
        let vc = UINavigationController(rootViewController: LoginViewController()) /* 143 */
        vc.modalPresentationStyle = .fullScreen /* 144 */
        present(vc, animated: true) /* 145 */
    }
    
    private func addConstraints() { /* 115 */
        NSLayoutConstraint.activate([ /* 146 */
            imageView.widthAnchor.constraint(equalToConstant: 100), /* 147 */
            imageView.heightAnchor.constraint(equalToConstant: 100), /* 147 */
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20), /* 147 */
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor), /* 147 */
            
            label.leftAnchor.constraint(equalTo: view.leftAnchor), /* 149 */
            label.rightAnchor.constraint(equalTo: view.rightAnchor), /* 149 */
            label.heightAnchor.constraint(equalToConstant: 80), /* 149 */
            label.topAnchor.constraint(equalTo: imageView.bottomAnchor,constant: 20), /* 149 */
            
            button.leftAnchor.constraint(equalTo: view.leftAnchor), /* 150 */
            button.rightAnchor.constraint(equalTo: view.rightAnchor), /* 150 */
            button.heightAnchor.constraint(equalToConstant: 50), /* 150 */
            button.topAnchor.constraint(equalTo: label.bottomAnchor,constant: 50), /* 150 */
        ])
    }
}
