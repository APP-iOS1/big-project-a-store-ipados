//
//  SettingsView.swift
//  BigProjectAStoreIpadOS
//
//  Created by 최한호 on 2022/12/28.
//

import SwiftUI

struct SettingsView: View {
	@EnvironmentObject var viewModel: SignUpViewModel
	@State private var isAlert: Bool = false
	
    var body: some View {
        VStack {
			Button {
				isAlert = true

			} label: {
				Text("로그아웃")
					.foregroundColor(.white)
					.frame(width: 430, height: 50)
					.background(.blue)
					.padding(.bottom, 30)
			}
        }
		.alert("로그아웃 하시겠습니까?", isPresented: $isAlert) {
			Button("취소", role: .cancel) {}
			Button("로그아웃", role: .destructive) {
				Task {
					viewModel.requestUserSignOut()
				}
			}
		} message: {}
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
