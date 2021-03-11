//
//  CreateClientViewController.swift
//  autostudio
//
//  Created by Dzmitry  Sakalouski  on 5.03.21.
//

import UIKit

class CreateClientViewController: UIViewController {
    var closeModalAction: (() -> ())?
    var errorMessage: Box<String> = Box("")

    lazy var closeLabel: UILabel = {
        let label = UILabel()
        label.text = "Закрыть"
        label.isUserInteractionEnabled = true
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
    }
    
    func configureView() {
        navigationController?.navigationBar.tintColor = .white
        view.backgroundColor = .white
        
        view.addSubview(closeLabel)
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleCloseModal))
        closeLabel.addGestureRecognizer(tap)
        closeLabel.anchor(top: view.topAnchor, left: view.leftAnchor, paddingTop: 10, paddingLeft: 10)
    }

    @objc func handleCloseModal() {
        print("hello")
        guard let closeAction = closeModalAction else {
            return
        }
        
        closeAction()
    }
}
