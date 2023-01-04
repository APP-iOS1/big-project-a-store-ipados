//
//  TestView.swift
//  BigProjectAStoreIpadOS
//
//  Created by 이민경 on 2023/01/04.
//

import SwiftUI


struct TestView: View {
    @StateObject var inquiryNetworkManager: InquiryNetworkManager = InquiryNetworkManager()
    
    @State private var selectedInquiry: CustomerServiceInfo.ID?
//    @State private var sortOrder = [KeyPathComparator(\CustomerServiceInfo.orderId)]
    @State private var path: [CustomerServiceInfo] = []
    @State var searchUserText : String = ""
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack{
                Text("문의내역")
                    .font(.title)
                    .bold()
                    .padding()
                Table(inquiryNetworkManager.customerService, selection: $selectedInquiry, sortOrder: $sortOrder) {
                    TableColumn("주문 번호", value: \.orderId)
                    TableColumn("상품명", value: \.itemName)
                    TableColumn("문의 제목", value: \.title)
                    TableColumn("답변 완료 여부") { inquiry in
                        Image(systemName: inquiry.isAnswered ? "checkmark" : "xmark")
                            .foregroundColor(inquiry.isAnswered ? Color.green : Color.red)
                    }
                }
                .navigationDestination(for: CustomerServiceInfo.self) { inquiry in
                    InquiryDetailView(inquiry: inquiry)
                }
            } // VStack
            .searchable(text: $searchUserText, prompt: "검색")
            .refreshable {
                Task{
                    await inquiryNetworkManager.requestCustomerServiceList()
                }
            }
            .onChange(of: selectedInquiry) { newElement in
                if let newElement,
                   let inquiry = inquiryNetworkManager.customerService.first(where: { $0.id == newElement }) {
                    path.append(inquiry)
                }
            }
//            .onChange(of: sortOrder) {
//                inquiryNetworkManager.customerService.sort(using: $0)
//            }
            .onAppear{
                Task{
                    await inquiryNetworkManager.requestCustomerServiceList()
                }
                //                filter를 날짜로 한번하고 그 이후 필터 진행
                let dateFilteredData = inquiryNetworkManager.customerService
                
                if !searchUserText.isEmpty {
                    results = dateFilteredData.filter {
                        $0.itemName .contains(searchUserText)
                    }
                }
                results = dateFilteredData
            }
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}

