//
//  OnboardView.swift
//  DelayedNavigation
//
//  Created by Martine Habib on 6/20/23.
//

import SwiftUI

struct OnboardView: View {


    let message: String

    var body: some View {
        Text("\(message)")
            .font(.headline)
    }
}

struct OnboardView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardView(message: "User is unverified")
    }
}



