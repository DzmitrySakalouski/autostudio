//
//  CoordinatorOutput.swift
//  autostudio
//
//  Created by Dzmitry  Sakalouski  on 20.02.21.
//

import Foundation

protocol CoordinatorOutputType: class {
    var finishFlow: (() -> Void)? { get set }
}
