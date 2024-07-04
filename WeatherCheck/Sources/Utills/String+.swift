//
//  String+.swift
//  WeatherCheck
//
//  Created by 엄지호 on 7/4/24.
//

import Foundation

extension String {
    // 현재 날짜 문자열이 오늘 날짜와 동일한지 여부를 체크하는 메서드
    func isToday() -> Bool {
        // "yyyy-MM-dd HH:mm:ss" 형식으로 Date 변환
        guard let date = self.toDate(format: "yyyy-MM-dd HH:mm:ss") else { return false }
        
        // 오늘 날짜를 "yyyy-MM-dd" 형식의 문자열로 변환
        let todayString = Date().toString(format: "yyyy-MM-dd")
        
        // 입력된 날짜를 "yyyy-MM-dd" 형식의 문자열로 변환
        let dateString = date.toString(format: "yyyy-MM-dd")
        
        // 비교
        return todayString == dateString
    }
    
    func toDate(format: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.locale = Locale(identifier: "ko_KR")
        return dateFormatter.date(from: self)
    }
   
    // "yyyy-MM-dd HH:mm:ss" -> "오전/오후 h시" 형태로 변환하는 메서드
    func toTimeString() -> String? {
        guard let date = self.toDate(format: "yyyy-MM-dd HH:mm:ss") else { return nil }
        let resultString = date.toString(format: "a h시")  // Date 객체를 원하는 형식의 문자열로 변환
        return resultString
    }
    
    // "yyyy-MM-dd HH:mm:ss" -> 요일 문자열 반환하는 메서드
    func toDayOfWeek() -> String? {
        guard let date = self.toDate(format: "yyyy-MM-dd") else { return nil }
        return date.toString(format: "EEE")
    }
}
