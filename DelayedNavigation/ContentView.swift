//
//  ContentView.swift
//  DelayedNavigation
//
//  Created by Martine Habib on 6/20/23.
//

import SwiftUI


struct ContentView: View {

    @State private var username: String = ""
    @State private var password: String = ""
    @State var info: LoginInfo?

    @State private var path = [String]()
    @ObservedObject var authentication = Authentication()

    var body: some View {

        NavigationStack(path: $path) {
            
            Form {
                TextField("User name", text: $username)
                SecureField("Password", text: $password)

                VStack {

                    Button {
                        info = LoginInfo(name: username, password: password)

                        Task {
                            await authentication.verifyUser(userinfo: info ?? LoginInfo(name:"", password:""))
                            print("Ready to Navigate")
                            path.append(authentication.progress)
                        }
                    } label: {
                        Text("Login")
                    }
                }
                .navigationTitle("Login")
                .navigationDestination(for: String.self) { route in
                    switch route {
                    case "finished":
                        OnboardView(message:"User credentials are \($authentication.status.wrappedValue)" )
                    default:
                        EmptyView()
                    }
                }
            }
        }
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
