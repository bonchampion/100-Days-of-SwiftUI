//
//  LightDivider.swift
//  Moonshot
//
//  Created by Bon Champion on 7/22/24.
//

import SwiftUI

struct LightDivider: View {
    var body: some View {
        Rectangle()
            .frame(height: 2)
            .foregroundStyle(.lightBackground)
            .padding(.vertical)
    }
}

#Preview {
    LightDivider()
}
