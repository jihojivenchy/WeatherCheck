//
//  DefaultSearchRepository.swift
//  WeatherCheck
//
//  Created by 엄지호 on 7/3/24.
//

import Foundation
import RxSwift

final class DefaultSearchRepository: SearchRepository {
    // MARK: - Properties
    private let bundleFileService: BundleFileService
    private let networkService: NetworkService
    
    // MARK: - Init
    init(bundleFileService: BundleFileService, networkService: NetworkService) {
        self.bundleFileService = bundleFileService
        self.networkService = networkService
    }
    
    // MARK: - Methods
    func searchWeather(for cityID: Int) -> Observable<Weather> {
        let weatherEndpoint = WeatherEndpoint.search(cityID: cityID)
        
        return networkService.request(to: weatherEndpoint)
            .decode(type: WeatherResponseDTO.self, decoder: JSONDecoder())
            .withUnretained(self)
            .map { owner, dto in
                return owner.convertToWeather(from: dto)
            }
    }
    
    func searchCityList(for name: String) -> Observable<[City]> {
        return bundleFileService.fetchData(fromResource: "reduced_citylist", ofType: "json")
            .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .background))  // 백그라운드 스레드에서 데이터 처리
            .decode(type: [CitySearchResponseDTO].self, decoder: JSONDecoder())
            .map { dtos in 
                dtos.filter { !$0.name.isEmpty && $0.name.lowercased().contains(name.lowercased()) }
                    .prefix(20)
            }
            .map { dtos in
                dtos.map { $0.toEntity() }
            }
    }
}

// MARK: - WeatherResponseDTO -> Entity 형 변환
extension DefaultSearchRepository {
    private func convertToWeather(from dto: WeatherResponseDTO) -> Weather {
        let currentTemperature = Int(dto.list.first?.weatherMetric.currentTemperature ?? -100) // 최근 데이터에서 현재 온도
        let status = dto.list.first?.weatherStatus.first?.description ?? "날씨 상태 오류"
        let minTemperature = Int(dto.list.first?.weatherMetric.minTemperature ?? -100)
        let maxTemperature = Int(dto.list.first?.weatherMetric.maxTemperature ?? -100)
        let hourlyWeathers = getHourlyWeatherForTwoDays(from: dto)
        let dailyWeathers = getDailyWeatherForFiveDays(from: dto)
        let humidity = calculateAverageHumidityForToday(from: dto)
        let clouds = calculateAverageCloudsForToday(from: dto)
        let windSpeed = calculateAverageWindSpeedForToday(from: dto)
        let pressure = calculateAveragePressureForToday(from: dto)
        
        return Weather(
            city: dto.city.toEntity(),
            currentTemperature: currentTemperature,
            weatherStatus: status,
            minTemperature: minTemperature,
            maxTemperature: maxTemperature,
            hourlyWeathers: hourlyWeathers,
            dailyWeather: dailyWeathers,
            humidity: humidity,
            clouds: clouds,
            windSpeed: windSpeed,
            pressure: pressure
        )
    }
    
    /// 오늘 날짜의 습도 중 평균을 계산하여 반환
    private func calculateAverageHumidityForToday(from dto: WeatherResponseDTO) -> Int {
        let todayHumidities = dto.list.filter { $0.date.isToday() }.map { $0.weatherMetric.humidity }
        let totalHumidity = todayHumidities.reduce(0, +)
        
        return totalHumidity / todayHumidities.count
    }
    
    /// 오늘 날짜의 구름량 중 평균을 계산하여 반환
    func calculateAverageCloudsForToday(from dto: WeatherResponseDTO) -> Int {
        let todayClouds = dto.list.filter { $0.date.isToday() }.map { $0.cloud.amount }
        let totalClouds = todayClouds.reduce(0, +)
        
        return totalClouds / todayClouds.count
    }
    
    /// 오늘 날짜의 바람 속도 중 평균을 계산하여 반환
    func calculateAverageWindSpeedForToday(from dto: WeatherResponseDTO) -> Double {
        let todayWindSpeeds = dto.list.filter { $0.date.isToday() }.map { $0.wind.speed }
        let totalWindSpeeds = todayWindSpeeds.reduce(0, +)
        
        return totalWindSpeeds / Double(todayWindSpeeds.count)
    }
    
    /// 오늘 날짜의 기압 중 평균을 계산하여 반환
    func calculateAveragePressureForToday(from dto: WeatherResponseDTO) -> Int {
        let todayPressures = dto.list.filter { $0.date.isToday() }.map { $0.weatherMetric.pressure }
        let totalPressures = todayPressures.reduce(0, +)
        
        return totalPressures / todayPressures.count
    }
    
    /// 2일 동안의 3시간 간격 데이터를 가져오는 메서드
    func getHourlyWeatherForTwoDays(from dto: WeatherResponseDTO) -> [HourlyWeather] {
        dto.list.prefix(14).map { forecast in
            let time = forecast.date.toTimeString() ?? "시간 오류"
            let weatherStatus = forecast.weatherStatus.first?.iconID ?? ""
            let temperature = Int(forecast.weatherMetric.currentTemperature)
            return HourlyWeather(time: time, iconID: weatherStatus, temperature: temperature)
        }
    }
    
    /// 5일 동안의 일별 간격 데이터를 가져오는 메서드
    func getDailyWeatherForFiveDays(from dto: WeatherResponseDTO) -> [DailyWeather] {
        // 각 일별로 날씨 예보 리스트를 나누기
        var forecastsByDate: [String: [WeatherForecastResponseDTO]] = [:]
        
        // list를 순회하면서 일 별로 그룹화
        for forecast in dto.list {
            let date = String(forecast.date.prefix(10))    // "YYYY-MM-DD" 형식으로 만들기
            forecastsByDate[date, default: []].append(forecast)  // 해당 날짜의 리스트에 forecast 추가
        }
        
        // 날짜 순서대로 정렬
        let sortedDates = forecastsByDate.keys.sorted()
        var dailyWeatherList: [DailyWeather] = []
        var isFirstDay = true  // 첫 날인지 체크하는 변수

        // 정렬된 키 목록을 순회
        for date in sortedDates {
            // 키와 일치하는 값
            guard let forecasts = forecastsByDate[date] else { return dailyWeatherList }
            
            // 각 일별 날씨의 최저온도 평균값 계산
            let minTemperatures = forecasts.map { $0.weatherMetric.minTemperature }
            let totalMinTemperatures = minTemperatures.reduce(0, +)
            let minTemperatureAverage = totalMinTemperatures / Double(minTemperatures.count)
            
            // 각 일별 날씨의 최고온도 평균값 계산
            let maxTemperatures = forecasts.map { $0.weatherMetric.maxTemperature }
            let totalMaxTemperatures = maxTemperatures.reduce(0, +)
            let maxTemperatureAverage = totalMaxTemperatures / Double(maxTemperatures.count)
            
            // 날씨 아이콘 아이디
            let iconID = forecasts.first?.weatherStatus.first?.iconID ?? ""
            
            // 첫 날이라면 "오늘"로 설정, 나머지는 요일
            let dayOfWeek = isFirstDay ? "오늘" : date.toDayOfWeek() ?? "요일 오류"
            isFirstDay = false
            
            dailyWeatherList.append(DailyWeather(
                dayOfWeek: dayOfWeek,
                iconID: iconID,
                minTemperature: Int(minTemperatureAverage),
                maxTemperature: Int(maxTemperatureAverage)
            ))
        }
        
        return dailyWeatherList
    }
}
