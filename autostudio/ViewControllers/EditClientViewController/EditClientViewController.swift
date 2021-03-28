//
//  EditClientViewController.swift
//  autostudio
//
//  Created by Dzmitry  Sakalouski  on 28.03.21.
//

import UIKit
import RxSwift
import RxCocoa

infix operator <->: DefaultPrecedence

class EditClientViewController: UIViewController {
    let mask = Veil(pattern: "+375 (##) ###-##-##")
    let disposeBag = DisposeBag()
    
    var viewModel: EditClientViewModelType?

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "Изменить"
        return label
    }()
    
    lazy var nameTextField: TextField = {
        let fullNameTF = TextField()
        fullNameTF.placeholder = "Имя"
        fullNameTF.textColor = .black
        fullNameTF.tintColor = .black
        return fullNameTF
    }()
    
    lazy var carTextField: UITextField = {
        let carTF = TextField()
        carTF.textColor = .black
        carTF.tintColor = .black
        carTF.placeholder = "Машина"
        return carTF
    }()
        
    lazy var phoneTextField: TextField = {
        let phoneTF = TextField()
        phoneTF.textColor = .black
        phoneTF.tintColor = .black
        phoneTF.placeholder = "Номер Телефона"
        phoneTF.addTarget(self, action: #selector(phoneNumberDidChange), for: .editingChanged)
        return phoneTF
    }()
    
    lazy var saveHeaderButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(handlePressSave))
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        configureView()
        configureBindings()
    }
    
    private func configureView() {
        view.backgroundColor = .white
        view.addSubview(titleLabel)
        titleLabel.anchor(top: view.topAnchor, paddingTop: 20)
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        view.addSubview(nameTextField)
        nameTextField.anchor(top: titleLabel.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 20, paddingLeft: 20, paddingRight: 20, height: 40)
        
        view.addSubview(carTextField)
        carTextField.anchor(top: nameTextField.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 20, paddingLeft: 20, paddingRight: 20, height: 40)
        
        view.addSubview(phoneTextField)
        phoneTextField.anchor(top: carTextField.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 20, paddingLeft: 20, paddingRight: 20, height: 40)
    }

    private func configureNavBar() {
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.rightBarButtonItem = saveHeaderButton
    }
    
    private func configureBindings() {
        (nameTextField <-> viewModel!.fullName).disposed(by: disposeBag)
        (phoneTextField <-> viewModel!.phoneNumber).disposed(by: disposeBag)
        (carTextField <-> viewModel!.car).disposed(by: disposeBag)
    }
    
    @objc func phoneNumberDidChange(_ sender: UITextField) {
        print(sender)
        guard let currentText = sender.text else  {
            return
        }

        sender.text = mask.mask(input: currentText, exhaustive: false)
    }
    
    @objc func handlePressSave() {
        guard let vm = viewModel else { return }
        
        vm.handleSaveClient()
    }
}
