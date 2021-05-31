//
//  EditView.swift
//  BucketList
//
//  Created by Brandon Knox on 5/23/21.
//

import SwiftUI

struct EditView: View {
//    enum LoadingState {
//        case loading, loaded, failed
//    }
    
    @Environment(\.presentationMode) var presentationMode
    @State private var photoName = ""
//    @ObservedObject var placemark: MKPointAnnotation
//    @State private var loadingState = LoadingState.loading
//    @Binding var locations: [CodableMKPointAnnotation]
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Person name", text: $photoName)
                }
            }
            .navigationBarItems(trailing: Button("Done") {
                                    self.presentationMode.wrappedValue.dismiss()
            })
        }
    }
}
