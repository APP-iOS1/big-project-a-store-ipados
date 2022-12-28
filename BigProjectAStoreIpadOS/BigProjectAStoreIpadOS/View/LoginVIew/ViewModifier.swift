//
//  ViewModifier.swift
//  BigProjectAStoreIpadOS
//
//  Created by 추현호 on 2022/12/28.
//

import Foundation
import SwiftUI

// MARK: -Modifier : 디테일뷰 전체화면 modify
struct CloseUpDetailModifier : ViewModifier {
    @EnvironmentObject var navigationManager: NavigationStateManager
#if os(iOS)
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    var isRegular: Bool {
        horizontalSizeClass == .regular
    }
#else
    let isRegular = false
#endif
    func body(content: Content) -> some View {
        content
            .toolbar {
                ToolbarItem(placement: .navigation) {
                    
                    if navigationManager.columnVisibility == .doubleColumn, isRegular {
                        Button {
                            navigationManager.columnVisibility = .detailOnly
                        } label: {
                            Image(systemName: "arrow.left.to.line")
                        }
                    }
                }
            }
    }
}
//.environmentObject(NavigationStateManager()) 프리뷰에 꼭 붙일 것
