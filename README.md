# OpenWeather API를 이용한 날씨 앱

## 구현 영상
<img src = "https://github.com/jihojivenchy/WeatherCheck/assets/99619107/e57f07ed-9368-4036-907b-885547f6568a" height = 600>
용량 문제로 저화질일 수 있다는 점 양해부탁드립니다:)


### 배경 날씨를 적용한 경우 영상
<img src = "https://github.com/jihojivenchy/WeatherCheck/assets/99619107/579faa1c-2e19-47d5-b884-eecea8683c1b" height = 600>



### <br>

# 아키텍처
1. 클린아키텍처
2. MVVM
3. 코디네이터 패턴

<br>

## 클린 아키텍처
<img alt="Clean-architecture" src="https://github.com/bridge0813/bridge-ios/assets/65343417/716863c5-c30d-4785-b7eb-5706775be58d">

### 사용 이유
- 각 객체의 명확한 책임 분리를 통해 유지보수성을 향상시키기 위해 적용했습니다.
- 오버 엔지니어링인 점은 알지만, 과제 특성 상 다양한 접근을 보여드리기 위해 적용했습니다.

### 결과
- 각 객체의 책임을 명확하게 분리함으로써 유지보수성 및 개발 생산성이 향상되었습니다.
- Mock 리포지토리를 이용하여 네트워크 의존성 없이 UI 테스트를 할 수 있습니다.

<br>

## 코디네이터 패턴
<img alt="Coordinator" src="https://github.com/jihojivenchy/WeatherCheck/assets/99619107/c89ab25f-3107-4637-8ba1-10066a4dc7bc">

### 사용 이유
- UI 로직과 화면 전환 로직을 분리하여 객체의 책임을 명확하게 하기 위해 적용했습니다.

### 결과
- UI 로직과 화면 전환 로직의 분리를 통해 Massive한 뷰 컨트롤러를 방지할 수 있습니다.
- 불필요한 인스턴스의 중복 생성을 방지할 수 있습니다

<br>

## 검색 요청에 관한 플로우 설명
<img alt="Flow" src="https://github.com/jihojivenchy/WeatherCheck/assets/99619107/c2ad0f89-7c34-4e63-951d-9198f8919c43">

<br>

### 순서
- MainViewModel에서 SearchWeatherUseCase를 이용하여 날씨 조회를 요청합니다. (이 때, 초기 값 CityID를 전달합니다.)
- SearchWeatherUseCase는 SearchRepository를 통해 날씨 조회를 요청합니다.
- SearchRepository에서는 날씨 조회에 맞는 엔드포인트를 생성하고, URLRequest를 정의하여 NetworkService에게 요청합니다.
- NetworkService에서는 네트워킹을 수행한 후, 반환 결과를 리포지토리에게 전달합니다.
- 다시 SearchRepository에서는 반환 결과를 디코딩하고, 화면에서 사용될 엔티티에 맞게 가공 후 전달합니다.
- 다시 SearchWeatherUseCase는 가공된 데이터를 MainViewModel에게 전달합니다.
- MainViewModel에서는 데이터를 ViewController에게 전달합니다.
- ViewController는 각 뷰에 필요한 데이터를 전달하여 화면을 구성합니다.

<br>

## 데이터 계층 설명
### APIKeyManager
- APIKeyManager는 저장되어 있는 APIKey를 가져오는 객체입니다.
- APIKey를 외부로 노출하지 않도록 .xcconfig와 gitignore를 이용하여 보안을 유지했습니다.
- .xcconfig를 이용하면 API 키를 코드에서 분리하며, 디버그나 릴리스와 같은 환경 별로 다른 설정 파일을 사용하여 손쉽게 관리할 수 있습니다.
<br>

### DTO
- 데이터 전송을 위한 객체로 사용되어, 엔티티와의 직접적인 의존성을 제거해줍니다.
<br>

### Endpoint
- HTTP 구조에 맞게 URLRequest를 정의하는 프로토콜입니다.
- 필요한 요청에 맞게 Endpoint를 채택하여 구현합니다.
- 불필요한 요소들이 있지만, API 통신을 위해 다음과 같은 구조를 설계할 수 있다는 점을 어필했습니다.
<br>

### NetworkService
- 단일 책임에 맞게 네트워킹만을 수행하는 객체입니다.
- 에러 발생 시, 상태 코드에 기반하여 NetworkError를 전달합니다.

<br>

### BundleFileService
- 단일 책임에 맞게 파일에 접근하여 데이터를 조회하는 객체입니다.
- 리포지토리에서 수행할 수 있는 기능이지만, 명확한 책임 분리를 위해 따로 구현했습니다.
- city.json 파일에 접근하여 데이터를 가져옵니다.
<br>

### Repository
- 네트워크 서비스 등을 이용하여 필요한 데이터를 조회하고, 조회된 데이터를 가공하여 도메인으로 보내주는 역할을 수행합니다.
- 날씨를 조회하고, 날씨 데이터를 가공하는 역할을 수행합니다.

<br>

## 트러블 슈팅 - 원활한 검색
- 기존에는 검색 화면에서 검색이 완료된 시점에서 정확하게 단어가 일치하는 도시 리스트를 가져오도록 했습니다.
- 여기서 더 나은 사용자 경험을 제공하기 위해 타이핑 시점마다 각 문자열에 포함되는 도시 리스트를 조회할 수 있도록 구현했습니다.
- 하지만 워낙 방대한 양의 자료를 다루다보니 UI가 버벅이는 문제가 발생했습니다.
<br>

### 해결 방법 - Debounce 적용
```swift
searchTextChanged: searchBar.rx.text.orEmpty
                .debounce(RxTimeInterval.milliseconds(10), scheduler: MainScheduler.instance)
                .distinctUntilChanged()
```
- RxSwift의 debounce 오퍼레이션를 적용하여, 일정 시간 내에 연속되는 이벤트를 제거했습니다.
- 사용자 검색 특성 상 글자마다 조회를 시도하는 것보다는 특정 시간 제한을 두어 연속되는 이벤트를 제거하는 것이 효율적입니다. 
<br>

### 해결 방법 - 백그라운드 처리
```swift
bundleFileService.fetchData(fromResource: "reduced_citylist", ofType: "json")
            .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .background))  // 백그라운드 스레드에서 데이터 처리
            .decode(type: [CitySearchResponseDTO].self, decoder: JSONDecoder())
            .map { dtos in 
                dtos.filter { !$0.name.isEmpty && $0.name.lowercased().contains(name.lowercased()) }
                    .prefix(20)
            }
            .map { dtos in
                dtos.map { $0.toEntity() }
            }
```
- 받아온 도시 리스트를 디코딩 및 필터링 하는 처리 작업을 백그라운드 스레드에서 수행할 수 있도록 했습니다.
- 이를 통해 UI의 영향을 최소화할 수 있습니다.
<br>

### 조회 데이터 제한
- 너무 방대한 양의 데이터는 사용자에게도 불필요하다고 판단되어, prefix를 이용하여 갯수를 20개로 제한하여 반환하도록 구현했습니다.

<br>

## 트러블 슈팅 - 화면 이동 간 데이터 전달
- 요구사항은 메인 화면(A)에서 검색 화면(B)을 presnet 하고, 검색 화면에서 조회된 결과를 다시 메인 화면에 가져와야 합니다.
- 일반적으로 A에서 띄우는 B화면 간의 데이터 전달은 Delegate 패턴을 이용합니다.
- 하지만 코디네이터 패턴을 사용하는 상황에서는 데이터 전달이 애매하다고 판단되었습니다.
- 이를 위해, 여러 가지 해결책을 고려해보았습니다.
<br>

### 해결책1 - 팝업 뷰 이용하기
- 검색 화면을 ViewController를 이용하여 구현하지 않고, 하나의 UIView 컴포넌트로 구현하여 Popup 형식으로 띄우는 방법입니다.
- 컴포넌트가 MainViewController에 종속되기 때문에 화면 이동이 필요하지 않게 됩니다. (MainViewModel에서 한 번에 처리가 가능)
- 하지만 도시 검색이라는 데이터 계층의 의존이 필요하기 때문에 뷰 컨트롤러와 뷰 모델을 생성하는 것이 적절하다고 판단했습니다.
<br>

### 해결책2 - 코디네이터에 참조 객체를 생성하기
- 코디네이터에서 새로운 참조 객체를 구현하여 A에서는 객체를 바인딩하고, B에서는 이벤트를 전달할 수 있도록 구현하는 방법입니다.
- 이 방법은 간단하지만, 코디네이터의 화면 전환이라는 역할에서 벗어나는 책임을 맡는다고 판단되어 수정했습니다.
<br>

### 해결책3 - 하나의 뷰 모델 사용하기
- 검색 화면은 결국 메인 화면에 종속되어 있기 때문에 같은 MainViewModel 객체를 사용하여 이벤트 전달이 필요없게 하는 방법입니다.
- 이 방법 또한 하나의 해결책이 되지만, 고려해봐야 할 부분이 있다고 판단되었습니다.
<br>

### 최종 구현
```swift
func showSearchViewController(searchedCityID: PublishSubject<CityID>) {
        let searchViewModel = SearchViewModel(
            coordinator: self,
            searchCityListUseCase: searchCityListUseCase,
            searchedCityID: searchedCityID
        )
        
        let searchVC = SearchViewController(viewModel: searchViewModel)
        navigationController.present(searchVC, animated: true)
    }
```
- A에 검색된 결과를 받을 수 있는 참조 객체(searchedCityID)를 구현하고, B에서는 해당 객체를 전달받아서 이벤트를 방출하는 형태입니다.
- 코디네이터에 직접 참조 객체를 구현하지않기 때문에 역할 소재가 분명해지며, 이벤트를 전달받는 깔끔한 방법이라고 판단되어 적용했습니다.
<br>

### 더 나아간 생각
- 객체 간 데이터 전달을 담당하는 새로운 객체를 구현하는 방법까지 생각해보았습니다.
<br>

## 트러블 슈팅 - 날씨 데이터 가공하기
- 요구 사항은 5일 동안, 일 간격으로 날씨 데이터를 화면에 표시해야 하는 것입니다.
- API는 5일 동안 3시간 간격으로 주어집니다. 따라서 요구사항을 충족하기 위해서는 일 간격으로 데이터를 나누고, 평균 데이터를 계산해야 했습니다.
- 따라서 다음과 같은 처리 방법을 고려했습니다.

### 아이디어
- 리스트를 조회하여 각 일별로 날씨 데이터를 나누기
- 일 별로 나누어진 데이터에서 평균값을 계산하기
<br>

### 해결
```swift
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
```
1. 먼저 해싱 알고리즘을 기반으로 한 Dictionary를 이용하여 각 일별로 날씨 데이터를 나누었습니다.
2. 화면에 순서대로 보일 수 있도록, 일별로 나누어진 데이터를 날짜를 기준으로 정렬합니다.
3. 각 일별 데이터를 순회하면서, 최소 온도의 평균, 최고 온도의 평균을 계산하여 구현했습니다.

<br>


## 아쉬웠던 점 - 형상 관리
- 실제 개발처럼 기능 별로 브랜치를 따서 전체적인 형상 관리를 하는 역량을 보여드리지 못한 점이 아쉽습니다.
- 다음 기회가 있다면 해당 부분을 보완하겠습니다.

<br>

## 아쉬웠던 점 - Alamofire의 사용
- 네트워킹 서비스같은 부분에서 Alamofire에 익숙하지 못해 활용하지 못한 점이 아쉽습니다.
- 하지만 Alamofire의 장점을 충분히 이해하고 있고, 추후에는 적극적으로 도입하여 더 나은 코드를 보여드리도록 하겠습니다.
<br>

## 아쉬웠던 점 - 오류 핸들링
<img src = "https://github.com/jihojivenchy/WeatherCheck/assets/99619107/be76c0b1-4000-49e6-9058-d87d84b454ef" height = 600>

- 위 이미지는 오류 발생 시 사용자에게 `ErrorViewController`를 통해 메세지를 보여주는 화면입니다.
- 나타날 수 있는 각 오류 상황 대해 이해하고, 적절한 처리를 하는 기능을 구현하지 못한 점이 아쉽습니다.
- 학습하여 더 나은 처리 기능을 보여드리도록 하겠습니다.


## 느낀점
짧은 시간 내에 최대한의 결과물을 보여줘야 하는 과정에서 개발 생산성이 같이 향상됨을 느꼈습니다.
새로운 API나 MapView와 같은 컴포넌트를 다뤄보면서 재미를 느낄 수 있었고, 더 학습하고 싶다는 욕구가 생겼습니다.
좋은 경험을 할 수 있게 해주셔서 감사합니다.












