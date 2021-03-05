//
//  CreateClientViewController.swift
//  autostudio
//
//  Created by Dzmitry  Sakalouski  on 5.03.21.
//

import UIKit

class CreateClientViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
    }
    
    func configureView() {
        navigationController?.navigationBar.tintColor = .white
        view.backgroundColor = .white
    }

}
