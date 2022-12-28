//
//  CloseStoreView.swift
//  BigProjectAStoreIpadOS
//
//  Created by 추현호 on 2022/12/28.
//

import SwiftUI

struct CloseStoreView: View {
    
    @State var currentAmount: CGFloat = 0
    @State private var showingAlert = false
    
    var body: some View {
        VStack {
            Image("탈퇴조건")
                .resizable()
                .scaledToFit()
                .scaleEffect(1 + currentAmount)
                .gesture(
                    MagnificationGesture()
                        .onChanged { value in
                            currentAmount = value - 1
                        }
                        .onEnded { value in
                            withAnimation(.spring()) {
                                currentAmount = 0
                            }
                        }
                )
                .zIndex(1.0)
            
            Button {
                showingAlert = true
            } label: {
                Text("폐점 신청")
                    .foregroundColor(.red)
            }
            .alert("폐점 신청", isPresented: $showingAlert) {
                Button("진짜 폐점?", role: .destructive) {}
            } message: {
                Text("폐점심사가 통과된다면, 등록된 상품과 스토어 통계에 대한 데이터가 사라지며, 이는 돌이킬 수 없습니다")
            }
            
        }.modifier(CloseUpDetailModifier())
    }
}

struct CloseStoreView_Previews: PreviewProvider {
    static var previews: some View {
        CloseStoreView()
            .environmentObject(NavigationStateManager())
    }
}
