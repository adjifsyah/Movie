//
//  File.swift
//  Movie
//
//  Created by Apple Josal on 11/04/25.
//

import SwiftUI
import Core
import RxSwift


public class GetDetailMoviePresenter<MovieUseCase: UseCases>: ObservableObject
where MovieUseCase.Request == Int, MovieUseCase.Response == DetailMovieModel
{
    private let _movieUseCase: MovieUseCase
    
    
    private var disposebag: DisposeBag = .init()
    
    @Published public var movie: DetailMovieModel = DetailMovieModel()
    
    @Published public var isLoading: Bool = false
    @Published public var isFavorite: Bool = false
    
    public init(id: Int, movieUseCase: MovieUseCase) {
        self._movieUseCase = movieUseCase
        getDetailMovie(id: id)
    }
    
    public func getDetailMovie(id: Int) {
        _movieUseCase.execute(request: id)
            .observe(on: MainScheduler.instance)
            .subscribe { result in
                self.movie = result
            }
            .disposed(by: disposebag)
    }
}
