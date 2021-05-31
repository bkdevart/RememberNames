//
//  EditView.swift
//  BucketList
//
//  Created by Brandon Knox on 5/23/21.
//

import SwiftUI

struct EditView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State private var imageName = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Person name", text: $imageName)
                }
            }
            .navigationBarItems(trailing: Button("Done") {
                                    self.presentationMode.wrappedValue.dismiss()
            })
        }
    }
}
