//
//  WaitingView.swift
//  BigProjectAStoreIpadOS
//
//  Created by 이주희 on 2023/01/02.
//

import SwiftUI

struct WaitingView: View {
    @Binding var isStoreApproved: Bool
    var body: some View {
        Text("입점 승인 대기중입니다.")
        
        // TODO: 서버에서 잘 불러와지면 삭제될 버튼
        Button {
            isStoreApproved = false
        } label: {
            Text("창닫기")
                .foregroundColor(.white)
                .frame(width: 430, height: 50)
                .background(.blue)
                .padding(.bottom, 30)
        }
    }
}

//struct WaitingView_Previews: PreviewProvider {
//    static var previews: some View {
//        WaitingView()
//    }
//}
