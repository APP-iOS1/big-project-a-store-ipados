//
//  InquiryDetailView.swift
//  BigProjectAStoreIpadOS
//
//  Created by 추현호 on 2023/01/02.
//

import SwiftUI

struct InquiryDetailView: View {
    var inquiry : CustomerServiceInfo
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(inquiry.title)")
                .bold()
                .font(.title)
                .padding(20)
            Divider()
            HStack{
                Text("작성자")
                Text(" \(inquiry.customerId)")
            }
            .padding(.horizontal, 20)
            .font(.title3)
            Divider()
            Text("\(inquiry.description)")
                .padding(20)
            Spacer()
        }
        .padding(20)
    }
}
