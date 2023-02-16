//
//  ContentView.swift
//  db
//
//  Created by 関琢磨 on 2023/01/13.
//


import SwiftUI

import LocalAuthentication

struct ContentView: View {
    @State private var isAuthenticated = false

    var body: some View {
        Group {
            if isAuthenticated {
                //認証が成功した場合に表示するView
                NavigationView{
                    VStack{
                        NavigationLink(destination: HomeView()){
                            Text("メモ")
                                .navigationBarTitle("")
                                .navigationBarHidden(true)
                        }.padding()
                            
                        NavigationLink(destination: PasshomeView()){
                            Text("パスワード")
                        }.padding()
                    }.background(passBackgroundView())

                }.background(Color.clear)
            } else {
                // 認証が失敗またはまだ行われていない場合に表示するView
                VStack{
                    Button(action: authenticate) {
                        Text("認証")
                    }
                    Text("※認証に失敗した時パスワード入力はできません")
                }
            }
        }
        .background(passBackgroundView())
        .onAppear {
            // Viewが表示されたときに認証を要求
            authenticate()
        }
    }

    func authenticate() {
        let context = LAContext()
        var error: NSError?

        // Face IDを使用するためのポリシーを設定
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            // ポリシーが有効な場合は認証を実行
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Face IDを使用して認証してください") { success, authenticationError in
                DispatchQueue.main.async {
                    if success {
                        // 認証が成功した場合はisAuthenticatedをtrueに設定
                        self.isAuthenticated = true
                    } else {
                        // 認証が失敗した場合はエラーメッセージを表示
                        print(authenticationError?.localizedDescription ?? "Face ID認証に失敗しました")
                    }
                }
            }
        } else {
            // ポリシーが無効な場合はエラーメッセージを表示
            print(error?.localizedDescription ?? "Face IDが使用できません")
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
