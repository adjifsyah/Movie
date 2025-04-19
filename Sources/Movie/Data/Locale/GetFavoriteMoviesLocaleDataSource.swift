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
    public typealias Request = DetailMovieModel
    public typealias Response = MoviesEntityLib
    private let _realm: Realm
    
    public init(realm: Realm) {
        self._realm = realm
    }
    
    public func list(request: DetailMovieModel?) -> RxSwift.Observable<[MoviesEntityLib]> {
        Observable<[MoviesEntityLib]>.create { observer in
            let favorites = {
                _realm.objects(MoviesEntityLib.self)
            }()
            
            observer.onNext(favorites.toArray(ofType: MoviesEntityLib.self))
            return Disposables.create()
        }
    }
    
    public func add(entity: MoviesEntityLib) -> RxSwift.Observable<Bool> {
        return Observable.create { observer in
            do {
                let realm = try Realm()
                try realm.write {
                    realm.add(entity)
                }
                observer.onNext(true)
                observer.onCompleted()
            } catch {
                observer.onError(error)
            }
            return Disposables.create()
        }
    }
    
    public func update(id: Int, entity: MoviesEntityLib) -> RxSwift.Observable<Bool> {
        fatalError()
    }
    
    public func delete(id: Int) -> RxSwift.Observable<Bool> {
        return Observable.create { observer in
            do {
                let realm = try Realm()
                if let entityToDelete = realm.objects(MoviesEntityLib.self).filter("movie_id == %@", String(id)).first {
                    try realm.write {
                        realm.delete(entityToDelete)
                    }
                    observer.onNext(true)
                    observer.onCompleted()
                } else {
                    // Kalau data tidak ditemukan, tetap selesaikan dengan false
                    observer.onNext(false)
                    observer.onCompleted()
                }
            } catch {
                observer.onError(error)
            }
            
            return Disposables.create()
        }
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
