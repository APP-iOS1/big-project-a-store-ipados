//
//  Date+.swift
//  BigProjectAStoreIpadOS
//
//  Created by 이승준 on 2023/01/03.
//

import Foundation

extension Date {
	static func getKoreanNowTimeString() -> String {
		let dateFormatter = DateFormatter()
		dateFormatter.locale = Locale(identifier: "ko-KR")
		dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
		return dateFormatter.string(from: Date.now)
	}
}

