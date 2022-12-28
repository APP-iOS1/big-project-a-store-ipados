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
    
    @Namespace var namespace
    @State var tabSelection: Int = 0
    var navigationitems: [String] = ["전체", "배송준비", "배송중", "배송완료"]
    
    
    var body: some View {
        NavigationStack {
            ScrollView {
                
                DeliverySummaryView()
                
                Divider()
                
                navigationBarView
                    .padding(.top, 50)
                
                switch tabSelection {
                case 0:
                    DeliveryReadyView()
                        .padding(.top, 10)
                case 1:
                    DeliveryReadyView()
                        .padding(.top, 10)
                case 2:
                    DeliveryReadyView()
                        .padding(.top, 10)
                case 3:
                    DeliveryReadyView()
                        .padding(.top, 10)
                default:
                    EmptyView()
                }
                
                // MARK: -TabView
//                TabView(selection: $tabSelection){
//                    DeliveryReadyView().tag(0)
//                    DeliveryShippingView().tag(1)
//                    DeliveryCompleteView().tag(2)
//                }
//                .tabViewStyle(.page(indexDisplayMode: .never))
//                .edgesIgnoringSafeArea(.all)
                
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
        } // NavigationStack
    } // Body
    
    // MARK: -navigationBarView
    var navigationBarView: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 20) {
                ForEach(Array(zip(self.navigationitems.indices, self.navigationitems)), id: \.0, content: {
                    index, name in
                    navBarItem(string: name, tab: index)
                })
            }
            .padding(.horizontal)
        }
        .background(Color.white)
        .frame(height: 0)
        //.edgesIgnoringSafeArea(.top)
    }
    
    // MARK: -navBarItem
    func navBarItem(string: String, tab: Int) -> some View {
        Button {
            self.tabSelection = tab
            print("\(self.tabSelection)")
        } label: {
            VStack {
                //Spacer()
                if self.tabSelection == tab {
                    Text(string)
                        .foregroundColor(.black)
                        .font(.largeTitle)
                        .bold()
                    Color(.black)
                        .frame(height: 4)
                        .matchedGeometryEffect(id: "underline", in: namespace, properties: .frame)
                        .padding(.top, -20)
                } else {
                    Text(string)
                        .foregroundColor(.gray)
                        .font(.largeTitle)
                        .bold()
                    Color.clear.frame(height: 2)
                }
            }
            .animation(.easeInOut(duration: 0.2), value: tabSelection)
        }
        .buttonStyle(.plain)
    }
}

struct DeliveryView_Previews: PreviewProvider {
    static var previews: some View {
        DeliveryView()
            .environmentObject(NavigationStateManager())
    }
}
