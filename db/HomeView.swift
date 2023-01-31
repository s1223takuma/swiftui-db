//
//  HomeView.swift
//  db
//
//  Created by 関琢磨 on 2023/01/13.
//


import SwiftUI
import CoreData

struct HomeView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        entity: Memo.entity(),
        sortDescriptors: [NSSortDescriptor(key: "updatedAt", ascending: false)],
        animation: .default
    ) var fetchedMemoList: FetchedResults<Memo>
    
    var body: some View {
        NavigationView {
            VStack{
                List {
                    ForEach(fetchedMemoList) { memo in
                        NavigationLink(destination: EditMemoView(memo: memo)){
                            VStack {
                                Text(memo.title ?? "")
                                    .font(.title)
                                    .frame(maxWidth: .infinity,alignment: .leading)
                                    .lineLimit(1)
                                HStack {
                                    Text (memo.stringUpdatedAt)
                                        .font(.caption)
                                        .lineLimit(1)
                                    Spacer()
                                }
                                }
                            }
                    }.onDelete(perform: deleteMemo)
                }
                .navigationTitle("メモ")
                .navigationBarTitleDisplayMode(.automatic)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink(destination: AddMemoView()) {
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
            
            
        }.navigationTitle("メモ")
            .navigationBarBackButtonHidden(true)
    }
    private func deleteMemo(offsets: IndexSet) {
            offsets.forEach { index in
                viewContext.delete(fetchedMemoList[index])
            }
        // 保存を忘れない
            try? viewContext.save()
        }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
