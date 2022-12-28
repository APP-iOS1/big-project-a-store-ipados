//
//  DeliverySummaryView.swift
//  BigProjectAStoreIpadOS
//
//  Created by 최한호 on 2022/12/27.
//

import SwiftUI

struct DeliverySummaryView: View {
    var body: some View {
        // MARK: - 요약 바
        HStack {
            
            // MARK: -배송준비
            HStack {
                Image(systemName: "shippingbox")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50)
                
                VStack {
                    Text("배송준비")
                    
                    HStack {
                        Text("0")
                            .font(.title)
                            .bold()
                        Text("건")
                    }
                }
                .padding(.leading, 20)
            }
            .font(.title2)
            .padding(.trailing, 50)
            
            // MARK: -배송중
            HStack {
                Image(systemName: "box.truck")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 60, height: 60)
                
                VStack {
                    Text("배송중")
                    
                    HStack {
                        Text("0")
                            .font(.title)
                            .bold()
                        Text("건")
                    }
                }
                .padding(.leading, 20)
            }
            .font(.title2)
            .padding(.trailing, 50)
            
            // MARK: -배송완료
            HStack {
                Image(systemName: "checkmark.square")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40, height: 40)
                
                VStack {
                    Text("배송완료")
                    
                    HStack {
                        Text("0")
                            .font(.title)
                            .bold()
                        Text("건")
                    }
                }
                .padding(.leading, 20)
            }
            .font(.title2)
            .padding(.trailing, 50)
            
            Spacer()
        }
        .padding()
    }
}

struct DeliverySummaryView_Previews: PreviewProvider {
    static var previews: some View {
        DeliveryView()
    }
}
