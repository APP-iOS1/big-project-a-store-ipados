//
//  WaitingView.swift
//  BigProjectAStoreIpadOS
//
//  Created by 이주희 on 2023/01/02.
//

import SwiftUI

struct WaitingView: View {
    @EnvironmentObject var signUpViewModel: SignUpViewModel
    @Binding var isStoreApproved: Bool
    @Binding var isLoggedin: Bool
    
    var body: some View {
        Text("입점 승인 대기중")
            .font(.largeTitle)
            .padding(.bottom, 30)
        
        // 개발 편의상 만들어 둔 버튼
        Button {
            isStoreApproved = false
        } label: {
            Text("~ 셀프 입점 승인 ~")
                .foregroundColor(.white)
                .frame(width: 430, height: 50)
                .background(.pink)
        }
        
        // TODO: 서버에서 잘 불러와지면 삭제될 버튼
        Button {
            isStoreApproved = false
            signUpViewModel.requestUserSignOut()
            isLoggedin = true
        } label: {
            Text("로그인 화면으로 돌아가기")
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
