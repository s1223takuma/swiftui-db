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
                Text("サイトの名前")
                    .bold()
                    .padding()
                TextField("", text: $sitename)
                    .font(.title)
                    .overlay(
                        RoundedRectangle(cornerSize: CGSize(width: 8.0, height: 8.0))
                            .stroke(Color.black, lineWidth: 1.0)
                            .padding(-8.0)
                    )
                    .padding(20)
                    .autocapitalization(.none)
            }
            Spacer()
            HStack{
                Text("URL")
                    .bold()
                    .padding()
                TextField("",text: $url)
                    .keyboardType(.URL)
                    .overlay(
                        RoundedRectangle(cornerSize: CGSize(width: 8.0, height: 8.0))
                            .stroke(Color.black, lineWidth: 1.0)
                            .padding(-8.0)
                    )
                    .padding(20)
                    .autocapitalization(.none)
                if let url = URL(string:pass.url ?? "") {
                                    Link("サイトに飛ぶ", destination:url)
                                        .padding()
                                }
            }
            Spacer()
            HStack{
                VStack{
                    Text("サイトで")
                        .bold()
                    Text("使用するID")
                        .bold()
                }
                .padding()
                TextField("",text: $userid)
                    .overlay(
                        RoundedRectangle(cornerSize: CGSize(width: 8.0, height: 8.0))
                            .stroke(Color.black, lineWidth: 1.0)
                            .padding(-8.0)
                    )
                    .padding(16.0)
                    .autocapitalization(.none)
                Button(action:{
                                    UIPasteboard.general.string = pass.userid ?? ""
                                }){
                                    Text("コピー")
                                }.padding()
            }
            Spacer()
            HStack{
                Text("パスワード")
                    .bold()
                    .padding()
                SecureField("",text: $password)
                    .overlay(
                        RoundedRectangle(cornerSize: CGSize(width: 8.0, height: 8.0))
                            .stroke(Color.black, lineWidth: 1.0)
                            .padding(-8.0)
                    )
                    .padding(16.0)
                    .autocapitalization(.none)
                Button(action:{
                                    UIPasteboard.general.string = pass.userid ?? ""
                                }){
                                    Text("コピー")
                                }.padding()
            }
            Spacer()
            
        }.background(passBackgroundView())

        .navigationBarTitleDisplayMode(.inline)
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
