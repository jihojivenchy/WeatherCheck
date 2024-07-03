//
//  DefaultFileService.swift
//  WeatherCheck
//
//  Created by 엄지호 on 7/3/24.
//

import Foundation
import RxCocoa
import RxSwift

final class DefaultBundleFileService: BundleFileService {
    func fetchData(fromResource resource: String, ofType type: String) -> Observable<Data> {
        guard let path = Bundle.main.path(forResource: resource, ofType: type) else {
            return .error(BundleFileError.invalidPath)
        }
        
        return Observable.create { observer in
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path))
                observer.onNext(data)
                observer.onCompleted()
                
            } catch {
                observer.onError(BundleFileError.underlying(error))
            }
            
            return Disposables.create()
        }
    }
}
