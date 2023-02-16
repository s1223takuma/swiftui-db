//
//  EditPassView.swift
//  db
//
//  Created by 関琢磨 on 2023/02/09.
//

import SwiftUI
import CoreData

struct EditPassView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var sitename: String
    @State private var password: String
    @State private var userid: String
    @State private var url: String
    private var pass: Pass
    
    init(pass: Pass) {
        self.pass = pass
        self.sitename = pass.sitename ?? ""
        self.password = pass.password ?? ""
        self.userid = pass.userid ?? ""
        self.url = pass.url ?? ""
    }
    
    var body: some View {
        VStack {
            HStack{
                TextField("サイトの名前", text: $sitename)
                    .font(.title)
            }
            HStack{
                Text("url")
                TextField("url", text: $url)
                    .font(.body)
                    .autocapitalization(.none)
                if let url = URL(string:pass.url ?? "") {
                    Link("サイトに飛ぶ", destination:url)
                        .padding()
                }
            }
            HStack{
                Text("ID")
                TextField("サイトで使用するID",text: $userid)
                    .font(.body)
                    .autocapitalization(.none)
                Button(action:{
                    UIPasteboard.general.string = pass.userid ?? ""
                }){
                    Text("コピー")
                }.padding()
            }
            HStack{
                Text("パスワード")
                SecureField("パスワード",text: $password)
                    .font(.body)
                    .autocapitalization(.none)
                Button(action:{
                    UIPasteboard.general.string = pass.password ?? ""
                }){
                    Text("コピー")
                }.padding()
            }
            Spacer()
        }.padding()
        .navigationBarTitleDisplayMode(.inline)
        .background(passBackgroundView())
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {saveMemo()}) {
                    Text("更新")
                }
            }
        }.background(passBackgroundView())
    }
    
    private func saveMemo() {
        pass.sitename = sitename
        pass.password = password
        pass.userid = userid
        pass.url = url
        do {
            try viewContext.save()
        } catch {
            // handle error
        }
    }
}

struct EditPassView_Previews: PreviewProvider {
    static var previews: some View {
        EditPassView(pass: Pass())
    }
}
