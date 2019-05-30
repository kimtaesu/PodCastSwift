import RxSwift

protocol RxDispatcherSchedulersType {
    var io: SchedulerType { get }
    var main: SchedulerType { get }
}

class RxDispatcherSchedulers: RxDispatcherSchedulersType {
    var main: SchedulerType = MainScheduler.instance
    let io: SchedulerType = SerialDispatchQueueScheduler(internalSerialQueueName: "io-thread")
}
