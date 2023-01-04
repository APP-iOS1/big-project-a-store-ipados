//
//  ChartView.swift
//  BigProjectAStoreIpadOS
//
//  Created by kimminho on 2022/12/27.
//

//더 미 데 이 터 차 트
import FirebaseAuth
import Charts
import SwiftUI

struct Posting: Identifiable,Hashable {
    var id: String {day}
    let day: String
    let DayoftheWeek: String
    let count: Int
}

struct Posting1: Identifiable,Hashable,Comparable {
    static func < (lhs: Posting1, rhs: Posting1) -> Bool {
        return lhs.day < rhs.day
    }
    static func > (lhs: Posting1, rhs: Posting1) -> Bool {
        return lhs.randomDay < rhs.randomDay
    }
    

    
    var id: String {day}
    let day: String
    let priceTotal: Double
    var randomDay: String {
        ["월","화","수","목","금","토","일"].randomElement()!
    }
}


let postings: [Posting] = [
    Posting(day: "2022-12-01",DayoftheWeek: "월요일",count:30),
    Posting(day: "2022-12-02",DayoftheWeek: "화요일",count:40),
    Posting(day: "2022-12-03",DayoftheWeek: "수요일",count:50),
    Posting(day: "2022-12-04",DayoftheWeek: "목요일",count:70),
    Posting(day: "2022-12-05",DayoftheWeek: "금요일",count:100),
    Posting(day: "2022-12-06",DayoftheWeek: "토요일",count:20),
    Posting(day: "2022-12-07",DayoftheWeek: "일요일",count:24),
    Posting(day: "2022-12-08",DayoftheWeek: "월",count:54),
    Posting(day: "2022-12-09",DayoftheWeek: "화",count:139),
    Posting(day: "2022-12-10",DayoftheWeek: "수",count:60),
    Posting(day: "2022-12-11",DayoftheWeek: "목",count:13),
    Posting(day: "2022-12-12",DayoftheWeek: "금",count:62),
    Posting(day: "2022-12-13",DayoftheWeek: "토",count:44),
    Posting(day: "2022-12-14",DayoftheWeek: "일",count:51),
]

struct ChartView: View {
    @State private var postings1: [Posting1] = []
    @EnvironmentObject var storeNetworkManager: StoreNetworkManager
    func drawChart() -> some View {
        Chart {
            ForEach(self.postings1.sorted(by: <)) { posting in
                BarMark(
                    x: .value("Name", posting.day),
                    y: .value("Posting", posting.priceTotal)
                )
            }
        }
    }
    
    func drawChartDay() -> some View {
        Chart {
            ForEach(self.postings1.sorted(by: >)) { posting in
                BarMark(
                    x: .value("Name", posting.randomDay),
                    y: .value("Posting", posting.priceTotal)
                )
            }
        }
    }
    
    var body: some View {
        ScrollView {
            Text("매출 현황")
                .font(.title)
            HStack {
                Button("일별") {
                }
                Button("주별") {
                }
                Button("월별") {
                }
            }
            drawChart()
                .frame(minWidth:100, maxWidth: .infinity, minHeight: 350, maxHeight: 500)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 30, trailing: 0))
            HStack {
                VStack {
                    Text("요일별 결제금액")
                    drawChartDay().foregroundStyle(.red)
                }
                VStack {
                    Text("요일별 평균결제금액")
                    drawChartDay()
                }
            }
            .frame(minWidth:100, maxWidth: .infinity, minHeight: 450, maxHeight: 450)
        }
        .padding(40)
        .modifier(CloseUpDetailModifier())
        .onAppear {
            Task {await storeNetworkManager.requestOrderedItemInfo(with: Auth.auth().currentUser?.uid)
                print(storeNetworkManager.currentStoreOrderInfoArray[0].orderTime)
                print(storeNetworkManager.currentStoreOrderInfoArray[0].orderedItems[0].price)
                for element in storeNetworkManager.currentStoreOrderInfoArray {
                    for j in element.orderedItems {
                        postings1.append(Posting1(day: element.orderTime, priceTotal: j.price))
                    }
                }
            }
        }
    }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView()
            .environmentObject(NavigationStateManager())
    }
}
