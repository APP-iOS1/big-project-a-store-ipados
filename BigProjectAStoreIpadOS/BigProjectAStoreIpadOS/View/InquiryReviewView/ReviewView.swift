//
//  ReviewView.swift
//  BigProjectAStoreIpadOS
//
//  Created by Sue on 2022/12/28.
//

import SwiftUI

struct ReviewView: View {
    @State private var reviewWriteSelection: Int = 1
    @State private var reviewWriteStartDate = Date()
    @State private var reviewWriteEndDate = Date()
    
    var body: some View {
        VStack {
            //리뷰 작성일
            Group {
                HStack {
                    Text("리뷰 작성일")
                        .font(.title2)
                    VStack {
                        Picker(selection: $reviewWriteSelection, label: Text("리뷰 작성일")) {
                            Text("오늘").tag(1)
                            Text("1주일").tag(2)
                            Text("1개월").tag(3)
                            Text("3개월").tag(4)
                            Text("6개월").tag(5)
                            Text("1년").tag(6)
                        }
                        .pickerStyle(.segmented)
                        .frame(width: 500)
                        HStack{
                            DatePicker("", selection: $reviewWriteStartDate, in: ...Date(), displayedComponents: .date)
                            Text("~")
                            DatePicker("", selection: $reviewWriteEndDate, in: ...Date(), displayedComponents: .date)
                        }.frame(width: 40)
                    }//vstack
                }
                Divider()
            }
            // 리뷰 구분
            Group {
                Text("리뷰 구분")
                    .font(.title2)
                Divider()
            }
            //리뷰 타입
            Group {
                Text("리뷰 타입")
                    .font(.title2)
                Divider()
            }
            // 카테고리
            Group {
                Text("카테고리")
                    .font(.title2)
                Divider()
            }
            // 채널
            Group {
                Text("채널")
                    .font(.title2)
                Divider()
            }
            // 리뷰 조건
            Group {
                Text("리뷰 조건")
                    .font(.title2)
                Divider()
            }
        }//vstack
    }//body
}

//체크박스 스타일
struct CheckboxStyle: ToggleStyle {

    func makeBody(configuration: Self.Configuration) -> some View {

        return HStack {
            Image(systemName: configuration.isOn ? "checkmark.square" : "square")
                .resizable()
                .frame(width: 24, height: 24)
                .foregroundColor(configuration.isOn ? .blue : .gray)
                .font(.system(size: 20, weight: .regular, design: .default))
                configuration.label
        }
        .onTapGesture { configuration.isOn.toggle() }

    }
}

struct ReviewView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewView()
    }
}
