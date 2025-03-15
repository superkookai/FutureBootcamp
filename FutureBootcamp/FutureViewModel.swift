//
//  FutureViewModel.swift
//  FutureBootcamp
//
//  Created by Weerawut Chaiyasomboon on 15/03/2568.
//

import Foundation
import Combine

//download with Combine
//download with @escaping closure
//convert @escaping closure to Combine

class FutureViewModel: ObservableObject {
    @Published var title: String = "Starting Title"
    let url = URL(string: "https://www.google.com")!
    var cancellables: Set<AnyCancellable> = []
    
    init() {
        download()
    }
    
    func download() {
        //1
//        getCombinePublisher()
//            .sink { _ in
//                
//            } receiveValue: { [weak self] returnValue in
//                self?.title = returnValue
//            }
//            .store(in: &cancellables)
        
        //2
//        getEscapingClosure { [weak self] value, error in
//            self?.title = value
//        }
        
        //3
//        getFuturePublisher()
//            .sink { _ in
//                
//            } receiveValue: { [weak self] returnValue in
//                self?.title = returnValue
//            }
//            .store(in: &cancellables)
        
        //4
        doSomethingInFuture()
            .sink { [weak self] value in
                self?.title = value
            }
            .store(in: &cancellables)

    }
    
    func getCombinePublisher() -> AnyPublisher<String,URLError> {
        URLSession.shared.dataTaskPublisher(for: url)
            .timeout(1, scheduler: DispatchQueue.main)
            .map({ _ in
                return "New Value"
            })
            .eraseToAnyPublisher()
    }
    
    func getEscapingClosure(completionHandler: @escaping (_ value: String, _ error: Error?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            completionHandler("New Value 2", nil)
        }
        .resume()
    }
    
    func getFuturePublisher() -> Future<String,Error> {
        return Future { promise in
            self.getEscapingClosure { value, error in
                if let error {
                    promise(.failure(error))
                } else {
                    promise(.success(value))
                }
            }
        }
    }
    
    func doSomething(completion: @escaping (_ value: String) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            completion("NEW STRING")
        }
    }
    
    func doSomethingInFuture() -> Future<String,Never> {
        return Future { promise in
            self.doSomething { value in
                promise(.success(value))
            }
        }
    }
}
