//
//  DeliveryView.swift
//  BigProjectAStoreIpadOS
//
//  Created by 최한호 on 2022/12/27.
//

import SwiftUI

struct DeliveryView: View {
    
    @State private var sortOrder = [KeyPathComparator(\DeliveryModel.orderState)]
    @State private var searchText = ""
    @State private var selected = Set<DeliveryModel.ID>()


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
            VStack(alignment: .leading) {
                DeliverySummaryView()
                
                Divider()
                
                Table(sampleDeliveryData, selection: $selected, sortOrder: $sortOrder) {
                    TableColumn("주문 상태", value: \.orderState) { delivery in
                        if delivery.orderState == "0" {
                            Text("배송 준비")
                        } else if delivery.orderState == "2" {
                            Text("배송 중")
                        } else {
                            Text("배송 완료")
                        }
                    }
                    TableColumn("발송 날짜", value: \.shippingDate)
                    TableColumn("주문 번호", value: \.orderNumber)
                    TableColumn("상품 번호", value: \.productNumber)
                    TableColumn("상품 이름", value: \.productName)
                    TableColumn("택배사", value: \.shipmentCompany)
                    TableColumn("송장 번호", value: \.trackingNumber)
                }
                .onChange(of: sortOrder) {
                    sampleDeliveryData.sort(using: $0)
                }
                
//                navigationBarView
//                    .padding(.top, 50)
//
//                switch tabSelection {
//                case 0:
//                    DeliveryAllView()
//                        .padding(.top, 10)
//                case 1:
//                    DeliveryReadyView()
//                        .padding(.top, 10)
//                case 2:
//                    DeliveryShippingView()
//                        .padding(.top, 10)
//                case 3:
//                    DeliveryCompleteView()
//                        .padding(.top, 10)
//                default:
//                    EmptyView()
//                }
            }
            .navigationTitle("배송 관리")
            .modifier(CloseUpDetailModifier())
            .searchable(text: $searchText)
            
            
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
