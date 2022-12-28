//
//  ReviewView.swift
//  BigProjectAStoreIpadOS
//
//  Created by Sue on 2022/12/28.
//

import SwiftUI

struct ReviewView: View {
    var body: some View {
        VStack {
            //리뷰 작성일
            Group {
                Text("리뷰 작성일")
                    .font(.title2)
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

struct ReviewView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewView()
    }
}
