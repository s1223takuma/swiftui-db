//
//  PasshomeView.swift
//  db
//
//  Created by 関琢磨 on 2023/01/14.
//

import SwiftUI


struct PasshomeView: View {
        @Environment(\.dismiss) private var dismiss
        @Environment(\.managedObjectContext) private var viewContext
        @FetchRequest(
            entity: Pass.entity(),
            sortDescriptors: [NSSortDescriptor(key: "updatedAt", ascending: false)],
            animation: .default
        ) var fetchedPassList: FetchedResults<Pass>
        
        var body: some View {
            NavigationView {
                VStack{
                    List {
                        ForEach(fetchedPassList) { pass in                                VStack {
                            Text(pass.sitename ?? "")
                                .font(.title)
                                .frame(maxWidth: .infinity,alignment: .leading)
                                .lineLimit(1)
                        }
                        
                            if let url = URL(string:pass.url ?? "") {
                                Link("\(pass.sitename ?? "")のURL", destination:url)
                            }
                        }.onDelete(perform: deleteMemo)
                    }
                    .navigationTitle("パスワード")
                    .navigationBarTitleDisplayMode(.automatic)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            NavigationLink(destination: addpassView()) {
                                Text("新規作成")
                            }
                        }
                    }
                    Button {
                        dismiss()
                                } label: {
                                    Text("ホームに戻る")
                                }
                }
                
                
            }.navigationTitle("パスワード")
                .navigationBarBackButtonHidden(true)
        }
        private func deleteMemo(offsets: IndexSet) {
                offsets.forEach { index in
                    viewContext.delete(fetchedPassList[index])
                }
            // 保存を忘れない
                try? viewContext.save()
            }
    }


struct PasshomeView_Previews: PreviewProvider {
    static var previews: some View {
        PasshomeView()
    }
}
