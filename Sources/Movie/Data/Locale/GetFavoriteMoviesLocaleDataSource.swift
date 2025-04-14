//
//  File.swift
//  Movie
//
//  Created by Apple Josal on 12/04/25.
//

import Foundation
import Core
import RealmSwift
import RxSwift

public struct GetFavoriteMoviesLocaleDataSource: LocaleDataSource {
    public typealias Request = Int
    public typealias Response = MoviesEntityLib
    private let _realm: Realm
    
    public init(realm: Realm) {
        self._realm = realm
    }
    
    public func list(request: Int?) -> RxSwift.Observable<[MoviesEntityLib]> {
        Observable<[MoviesEntityLib]>.create { observer in
            let favorites = {
                _realm.objects(MoviesEntityLib.self)
            }()
            
            observer.onNext(favorites.toArray(ofType: MoviesEntityLib.self))
            return Disposables.create()
        }
    }
    
    public func add(entities: [MoviesEntityLib]) -> RxSwift.Observable<Bool> {
        fatalError()
    }
    
    public func update(id: Int, entity: MoviesEntityLib) -> RxSwift.Observable<Bool> {
        fatalError()
    }
    
    public func delete(id: Int) -> RxSwift.Observable<Bool> {
        fatalError()
    }
}

extension Results {

  public func toArray<T>(ofType: T.Type) -> [T] {
    var array = [T]()
    for index in 0 ..< count {
      if let result = self[index] as? T {
        array.append(result)
      }
    }
    return array
  }

}
