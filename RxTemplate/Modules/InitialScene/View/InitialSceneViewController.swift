//
//  InitialSceneViewController.swift
//  RxTemplate
//
//  Created by Yaroslav Abaturov on 11.02.2023.
//  Copyright (c) 2023 Yaroslav Abaturov. All rights reserved.
//

import RxSwift
import UIKit

class InitialSceneViewController: BaseViewController<InitialSceneInteractable> {
	// MARK: View lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setup()
	}
	
	private func setup() {
        topPaddingConstraint.constant = (AppCore.shared.deviceLayer.hasTopNotch ? Constants.topConstraintValueWithNotch : Constants.topConstraintValueWithoutNotch)
        
		interactor?.makeRequest(requestType: .initialSetup)
	}
    
    private func example(of value: String, completion: () -> ()) {
        print("--- Examlpe of: \(value) ---")
        completion()
    }

    @IBOutlet private weak var topPaddingConstraint: NSLayoutConstraint!
    @IBOutlet private weak var sceneTitle: UILabel!
}

extension InitialSceneViewController: InitialSceneViewControllerType {
	func update(viewModelDataType: InitialSceneViewControllerViewModel.ViewModelDataType) {
		switch viewModelDataType {
		case .initialSetup(let model):
            sceneTitle.text = model.sceneTitle
            
            example(of: "Just, Of, From") {
                let one = 1
                let two = 2
                let three = 3
                
                let observable = Observable<Int>.just(one)
                let observable2 = Observable.of(one, two, three)
                let observable3 = Observable.of([one, two, three])
                let observable4 = Observable.from([one, two, three])
            }
            
            example(of: "Subscribe") {
                let one = 1
                let two = 2
                let three = 3
                
                let observable = Observable.of(one, two, three)
                
                observable.subscribe(onNext: { print($0) })
            }
            
            example(of: "emplty") {
                let observable = Observable<Void>.empty()
                
                observable.subscribe(
                    onNext: { print($0) },
                    onCompleted: { print("completed")}
                    )
            }
            
            example(of: "Range") {
                let observable = Observable<Int>.range(start: 1, count: 10)
                
                observable.subscribe(onNext: { i in
                    let n = Double(i)
                    let fibonacci = Int(((pow(1.61803, n) - pow(0.61803, n)) / 2.23606).rounded())
                    print(fibonacci)
                })
            }
            
            example(of: "Dispose") {
                let observable = Observable.of("A", "B", "C")
                
                let subscription = observable.subscribe { print($0) }
                subscription.dispose()
            }
            
            example(of: "DisposeBag") {
                let disposeBag = DisposeBag()
                
                Observable.of("A", "B", "C")
                    .subscribe { print($0) }
                    .disposed(by: disposeBag)
            }
            
            example(of: "create") {
                let disposeBag = DisposeBag()
                
                Observable<String>.create { observer in
                    observer.onNext("1")
                    observer.onCompleted()
                    observer.onNext("?")
                    
                    return Disposables.create()
                }.subscribe(
                    onNext: { print($0) },
                    onError: { print($0) },
                    onCompleted: { print("Completed") },
                    onDisposed: { print("Disposed") }
                    )
                .disposed(by: disposeBag)
            }
            
            example(of: "deffered") {
                let db = DisposeBag()
                var flip = false
                
                let factory: Observable<Int> = Observable.deferred {
                    flip.toggle()
                    
                    return flip ? Observable.of(1, 2, 3) : Observable.of(4, 5, 6)
                }
                
                for _ in 0...3 {
                    factory.subscribe(onNext: { print($0, terminator: "") }).disposed(by: db)
                    print()
                }
            }
            
            example(of: "PublishSubject") {
                let publisher = PublishSubject<String>()
                publisher.onNext("is anyone listening?")
                let subscriber1 = publisher.subscribe { value in
                    print(value)
                }
                let subscriber2 = publisher.subscribe { value in
                    print(value)
                }
                
                publisher.on(.next("1"))
            }
            
            example(of: "working with publiser") {
                let publisher = PublishSubject<Int>()
                
                let subscriber0 = publisher.subscribe { value in
                    print("subscriber0 \(value)")
                }
                
                publisher.onNext(0)
                
                let subscriber1 = publisher.subscribe { value in
                    print("subscriber1 \(value)")
                }
                
                publisher.onNext(1)
                
                let subscriber2 = publisher.subscribe { value in
                    print("subscriber1 \(value)")
                }
                
                publisher.onNext(2)
                
                subscriber0.dispose()
                subscriber1.dispose()
                subscriber2.dispose()
                
                let db = DisposeBag()
                
                publisher.subscribe {
                    print("publisher", $0.element ?? $0)
                }
                .disposed(by: db)
                
                publisher.onNext(99)
            }
            
            example(of: "Behavior subject") {
                let bs = BehaviorSubject(value: 0)
                let db = DisposeBag()
                
                let subscriber0 = bs.subscribe { print("s0 \($0)") }
                
                bs.onNext(1)
                
                let subscriber1 = bs.subscribe { print("s1 \($0)") }
                
                bs.onNext(2)
                
                let subscriber2 = bs.subscribe { print("s2 \($0)") }
                
                subscriber0.dispose()
                subscriber1.dispose()
                subscriber2.dispose()
                
                bs.onNext(3)
                
                bs.subscribe {
                    print("bs \($0)")
                }
                .disposed(by: db)
                
            }
            
            example(of: "Replay subject") {
                let rs = ReplaySubject<String>.create(bufferSize: 2)
                let db = DisposeBag()
                
                rs.onNext("1")
                rs.onNext("2")
                rs.onNext("3")
                
                let subscriber0 = rs.subscribe { print("s0 \($0)") }
                
                rs.onNext("4")
                
                let subscriber1 = rs.subscribe { print("s1 \($0)") }
                
                rs.onNext("5")
                
                let subscriber2 = rs.subscribe { print("s2 \($0)") }
                
                rs.onNext("6")
                
                let subscriber3 = rs.subscribe { print("s3 \($0)") }
                
                subscriber0.dispose()
                subscriber1.dispose()
                subscriber2.dispose()
                subscriber3.dispose()
                
                rs.subscribe {
                    print("rs \($0)")
                }
                
                rs.disposed(by: db)
            } 
		}
	}
}

extension InitialSceneViewController {
	private struct Constants {
        static let topConstraintValueWithNotch: CGFloat = 44
        static let topConstraintValueWithoutNotch: CGFloat = 24
	}
}
