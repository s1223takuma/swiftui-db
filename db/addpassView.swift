//
//  addpassView.swift
//  db
//
//  Created by 関琢磨 on 2023/01/23.
//

import SwiftUI

struct addpassView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentation
    @State private var sitename: String = ""
    @State private var password: String = ""
    @State private var url: String = ""
    @State private var siteid: String = ""

    var body: some View {
        VStack {
            TextField("サイトの名前", text: $sitename)
                .padding(10)
                .font(.title)
                .autocapitalization(.none)
            Spacer()
            TextField("URL",text: $url)
                .padding(20)
                .autocapitalization(.none)
            Spacer()
            TextField("サイトで使用するID",text: $siteid)
                .padding(20)
                .autocapitalization(.none)
            Spacer()
            SecureField("パスワード",text: $password)
                .padding(20)
                .autocapitalization(.none)
            Spacer()
            
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {addPass()}) {
                    Text("保存")
                }
            }
        }
    }
    // 保存ボタン押下時の処理
    private func addPass() {
        let pass = Pass(context: viewContext)
        pass.sitename = sitename
        pass.url = url
        pass.password = password
        pass.userid = siteid
    // 生成したインスタンスをCoreDataに保存する
        try? viewContext.save()
    
        presentation.wrappedValue.dismiss()
    }
}

struct addpassView_Previews: PreviewProvider {
    static var previews: some View {
        addpassView()
    }
}
