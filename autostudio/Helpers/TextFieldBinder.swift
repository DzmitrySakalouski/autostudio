//
//  Bind.swift
//  autostudio
//
//  Created by Dzmitry  Sakalouski  on 28.03.21.
//

import Foundation
import RxSwift
import RxCocoa
import UIKit

func <-> (textInput: UITextField, relay: BehaviorRelay<String>) -> Disposable {
    let bindToUIDisposable = relay.bind(to: textInput.rx.text)

    let bindToRelay = textInput.rx.text.subscribe(onNext: {value in
        guard let textValue = value else { return }
        relay.accept(textValue)
    })

    return Disposables.create(bindToUIDisposable, bindToRelay)
}
