//
//  ScreenRouter.swift
//  Nutritional
//
//  Created by Moein Barzegaran on 11/13/22.
//

import SwiftUI

final class ScreenRouter<T: Hashable>: ObservableObject {
    @Published var root: T
    @Published var paths: [T] = []

    init(root: T) {
        self.root = root
    }

    func push(_ path: T) {
        paths.append(path)
    }

    func pop() {
        paths.removeLast()
    }

    func updateRoot(root: T) {
        self.root = root
    }

    func popToRoot(){
       paths = []
    }
}
