//
//  Authentication.swift
//  DelayedNavigation
//
//  Created by Martine Habib on 6/28/23.
//

import Foundation
import SwiftUI

struct LoginInfo {
    var name: String
    var password: String

    init(name: String, password: String) {
        self.name = name
        self.password = password
    }
}

@MainActor //To publish on the main thread
class Authentication: ObservableObject {

    var info: LoginInfo

    @Published var status: String = "unverified"
    @Published var progress: String = "in progress"

    init(loginfo: LoginInfo? = nil) {
        if let user = loginfo {
            info = LoginInfo(name: user.name, password: user.password)
        } else {
            info = LoginInfo(name: "", password: "")
        }
    }

    private func setInfo(loginfo: LoginInfo) {
        self.info = loginfo
    }

    private func authenticateCredentials() async  {

        print("Auth. request to the server")
        try? await Task.sleep(nanoseconds: 3 * NSEC_PER_SEC)
        // For the sake of simplicity, let's just see if anything in the form is empty
        if (!self.info.name.isEmpty && !self.info.password.isEmpty) {
            self.status = "verified"
        } else {
            self.status = "unverified"
        }
    }

    // Public function called from the view
    func verifyUser(userinfo: LoginInfo) async    {
        self.setInfo(loginfo: userinfo)
        await authenticateCredentials()
        // We have a result
        self.progress = "finished"
    }

}

