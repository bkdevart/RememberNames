//
//  ListView.swift
//  RememberNames
//
//  Created by Brandon Knox on 5/31/21.
//

import SwiftUI

struct ListView: View {
//    @Binding var nameList: [NameWithImage]
    @State var nameList: [NameWithImage]
    
    var body: some View {
        Form {
            List(nameList, id: \.name) { name in
                NavigationLink(destination: ImageView(name: name.name, fileName: name.fileName)) {
                    VStack(alignment: .leading) {
                        Text(name.name)
                            .font(.headline)
                    }
                }
            }
            .navigationBarTitle("Name List")
        }
        .onAppear(perform: loadData)
    }
    
    func loadData() {
        let filename = getDocumentsDirectory().appendingPathComponent("ImageNames")

        do {
            let data = try Data(contentsOf: filename)
            nameList = try JSONDecoder().decode([NameWithImage].self, from: data)
        } catch {
            print("Unable to load saved data.")
        }
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
