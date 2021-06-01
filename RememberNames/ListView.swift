//
//  ListView.swift
//  RememberNames
//
//  Created by Brandon Knox on 5/31/21.
//

import SwiftUI

struct ListView: View {
    @Binding var nameList: [NameWithImage]
    
    var body: some View {
        NavigationView {
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
        }
    }
}
