//
//  String-EmptyChecking.swift
//  Cupcake Corner
//
//  Created by Bon Champion on 9/6/24.
//

import Foundation

extension String {
    var isReallyEmpty: Bool {
        self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
