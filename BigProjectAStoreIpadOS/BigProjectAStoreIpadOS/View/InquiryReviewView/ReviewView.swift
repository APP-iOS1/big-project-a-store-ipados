//
//  ReviewView.swift
//  BigProjectAStoreIpadOS
//
//  Created by Sue on 2022/12/28.
//

import SwiftUI

struct ReviewView: View {
    //리뷰 작성일
    @State private var reviewWriteSelection: Int = 1
    @State private var reviewWriteStartDate = Date()
    @State private var reviewWriteEndDate = Date()
    
    //리뷰 구분
    @State private var reviewSeperateTotal: Bool = false
    @State private var reviewSeperateCommon: Bool = false
    @State private var reviewSeperateMonth: Bool = false
    
    //리뷰 타입
    @State private var reviewTypeTotal: Bool = false
    @State private var reviewTypePhoto: Bool = false
    @State private var reviewTypeVideo: Bool = false
    @State private var reviewTypeText: Bool = false
    
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
                HStack {
                    Text("리뷰 구분")
                        .font(.title2)
                    Toggle(isOn: $reviewSeperateTotal) {
                        Text("전체")
                            .font(.title2)
                    }
                    .toggleStyle(CheckboxStyle())
                    
                    Toggle(isOn: $reviewSeperateCommon) {
                        Text("일반 리뷰")
                            .font(.title2)
                    }
                    .toggleStyle(CheckboxStyle())
                    
                    Toggle(isOn: $reviewSeperateMonth) {
                        Text("한달사용리뷰")
                            .font(.title2)
                    }
                    .toggleStyle(CheckboxStyle())
                }
                Divider()
            }
            //리뷰 타입
            Group {
                HStack {
                    Text("리뷰 타입")
                        .font(.title2)
                    
                    Toggle(isOn: $reviewTypeTotal) {
                        Text("전체")
                            .font(.title2)
                    }
                    .toggleStyle(CheckboxStyle())
                    
                    Toggle(isOn: $reviewTypePhoto) {
                        Text("포토리뷰")
                            .font(.title2)
                    }
                    .toggleStyle(CheckboxStyle())
                    
                    Toggle(isOn: $reviewTypeVideo) {
                        Text("동영상리뷰")
                            .font(.title2)
                    }
                    .toggleStyle(CheckboxStyle())
                    
                    Toggle(isOn: $reviewTypeText) {
                        Text("텍스트리뷰")
                            .font(.title2)
                    }
                    .toggleStyle(CheckboxStyle())
                    
                }
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
