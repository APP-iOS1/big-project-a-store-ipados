//
//  ChartView.swift
//  BigProjectAStoreIpadOS
//
//  Created by kimminho on 2022/12/27.
//

//더 미 데 이 터 차 트

import Charts
import SwiftUI

struct Posting: Identifiable,Hashable {
    var id: String {day}
    let day: String
    let DayoftheWeek: String
    let count: Int
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
    @State private var weekSale = 2800000
    @State private var monthSale = 112000000
    
    func drawChart() -> some View {
        Chart {
            ForEach(postings) { posting in
                BarMark(
                    x: .value("Name", posting.day),
                    y: .value("Posting", posting.count)
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
                    drawChart().foregroundStyle(.red)
                }
                VStack {
                    Text("요일별 평균결제금액")
                    drawChart()
                }
            }
            .frame(minWidth:100, maxWidth: .infinity, minHeight: 450, maxHeight: 450)
        }
        .padding(40)
        .modifier(CloseUpDetailModifier())
        
        
        
    }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView()
            .environmentObject(NavigationStateManager())
    }
}
