//
//  File.swift
//  Movie
//
//  Created by Apple Josal on 11/04/25.
//

import SwiftUI
import Core
import RxSwift


public class GetDetailMoviePresenter<MovieUseCase: UseCases, FavoriteUseCase: UseCases>: ObservableObject where MovieUseCase.Request == DetailMovieModel, MovieUseCase.Response == DetailMovieModel, FavoriteUseCase.Request == DetailMovieModel, FavoriteUseCase.Response == DetailMovieModel
{
    private let _movieUseCase: MovieUseCase
    private let _favoriteUseCase: FavoriteUseCase
    
    
    private var disposebag: DisposeBag = .init()
    
    @Published public var movie: DetailMovieModel = DetailMovieModel()
    
    @Published public var msgError: String = ""
    @Published public var isLoading: Bool = false
    @Published public var isShowAlert: Bool = false
    @Published public var isAlertConfirmation: Bool = false
    
    public init(id: Int, movieUseCase: MovieUseCase, favoriteUseCase: FavoriteUseCase) {
        self._movieUseCase = movieUseCase
        self._favoriteUseCase = favoriteUseCase
        getDetailMovie(id: id)
    }
    
    public func getDetailMovie(id: Int) {
        isLoading = true
        _movieUseCase.execute(request: DetailMovieModel(id: id))
            .observe(on: MainScheduler.instance)
            .subscribe { result in
                self.movie = result
                self.isLoading = false
            }
            .disposed(by: disposebag)
    }
    
    public func onTapFavoriteBTN() {
        if movie.isFavorite {
            isAlertConfirmation = true
        } else {
            executeFavorite(id: movie)
        }
    }
    
    public func executeFavorite(id: DetailMovieModel) {
        _favoriteUseCase.execute(request: id)
            .observe(on: MainScheduler.instance)
            .subscribe { result in
                self.msgError = result.isFavorite ? "Berhasil menambahkan favorit" : "Berhasil menghapus favorit"
                self.movie.isFavorite = result.isFavorite
                self.isShowAlert = true
            } onError: { error in
                self.msgError = (error as? DatabaseErrors)?.errorDescription ?? ""
                self.isShowAlert = true
            }
            .disposed(by: disposebag)
    }
    
    public func rateView<Content: View>(@ViewBuilder content: (String) -> Content) -> some View {
        content(String(convertToFiveStarScale(voteAverage: movie.voteAverage)))
    }
    
    public func formatTime(minutes: Int) -> String {
        let hours = minutes / 60
        let remainingMinutes = minutes % 60
        return "\(hours)h \(remainingMinutes)m"
    }
    
    public func convertToFiveStarScale(voteAverage: Double) -> Double {
        let scaledValue = voteAverage / 2.0
         return (scaledValue * 2.0).rounded() / 2.0
    }
}

public enum DatabaseErrors: LocalizedError {
    case invalidInstance
    case invalidFetchMovieDetail
    case requestFailed
    
    public var errorDescription: String? {
        switch self {
        case .invalidInstance: return "Database can't instance."
        case .invalidFetchMovieDetail: return "Database can't fetch detail movie."
        case .requestFailed: return "Your request failed."
        }
    }
}
