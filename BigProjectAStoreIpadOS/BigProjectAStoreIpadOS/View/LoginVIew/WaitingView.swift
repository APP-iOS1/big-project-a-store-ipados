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
        
        Button {
            // FIXME: Auth에서 로그인 상태 가져오기
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
