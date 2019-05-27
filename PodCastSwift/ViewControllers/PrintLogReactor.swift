import ReactorKit
import RxSwift

protocol PrintLogReactor {
}
extension Reactor where Self: PrintLogReactor {
    #if DEBUG
    func transform(action: Observable<Action>) -> Observable<Action> {
        return action.debug("action")
    }
    
    func transform(state: Observable<State>) -> Observable<State> {
        return state.debug("state")
    }
    #endif
}
