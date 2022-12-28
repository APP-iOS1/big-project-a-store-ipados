//
//  DeliveryView.swift
//  BigProjectAStoreIpadOS
//
//  Created by 최한호 on 2022/12/27.
//

import SwiftUI

struct DeliveryView: View {
    
    @EnvironmentObject var navigationManager: NavigationStateManager
    
    #if os(iOS)
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    var isRegular: Bool {
        horizontalSizeClass == .regular
    }
    #else
    let isRegular = false
    #endif
    
    var body: some View {
        ScrollView {
            
            DeliverySummaryView()
            
            Divider()
            
            
        }
        .navigationTitle("배송 관리")
        .toolbar {
            ToolbarItem(placement: .navigation) {
                
                if navigationManager.columnVisibility != .detailOnly, isRegular {
                    Button {
                        navigationManager.columnVisibility = .detailOnly
                    } label: {
                        Image(systemName: "arrow.up.left.and.arrow.down.right")
                    }
                }
            }
        }
    }
}

struct DeliveryView_Previews: PreviewProvider {
    static var previews: some View {
        DeliveryView()
    }
}
