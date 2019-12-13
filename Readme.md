         Rxswift là gì 
Observable:Là  thằng phát ra thông báo thay đổi 


 Observable.of   sẽ in toàn bộ mảng
Observable.from in các thành phần trong mảng
 

Oberver:  Đăng ký một  và  lắng nghe khi có một observable thay đổi 
### PublishSubject 
nó chỉ phát ra sự kiện mới nhất của subscribers, mà nó không phát đến sự kiện tiếp theo , do đó bất cứ sự kiện nào trước  subscribers sẽ không được phát ra 
ví dụ  publish  giống như  là vào lớp muộn nhưng chỉ cần nghe 1 điểm nó cần nghe 

code example
```swift
 let subject = PublishSubject<String>()
 
        subject.onNext("Emmit 1")
        
        subject.subscribe(onNext: { (event) in
            
            print("event \(event)")
            }).disposed(by: disposeBag)
        
        subject.onNext("Emmit 2")
``` 
Kết quả sẽ là  event Emmit 2


A PublishSubject is concerned only with emitting new events to its subscribers. It does not replay next() events, so any that existed before the subscription will not be received by that subscriber. It does re-emit stop events to new subscribers however. This means that if you subscribe to a sequence that has already been terminated, the subscriber will receive that information. It is worth noting that all subject types re-emit stop events
BehaviorSubject

Ví dụ một thằng vào lớp muộn nhưng muốn nghe toàn bộ những gì gần nhất có nghĩa là nó chấp nhận bất cứ event nào 


ReplaySubject là khởi tạo với một kích thước và duy trì bộ đệm của các phần tử có kích thước đó và phát lại cho người mới 



### Combining RXSwift 

### Concat 
1 Obserable 2 hoặc nhiều chuỗi 
2 Observable nhiều chuỗi nối tiếp trong  một Obserable  theo thứ tự của Obserable  
3 Hoàn thành Observable đầu tiên rồi đến Observable tiếp theo …
4 Được sử dụng như một hàm static hoặc phương thức của observable 

Example 
```swift

let first = Observable.of(1,2,3)
    let second = Observable.of(4,5,6)
 
let obserable = Observable.concat([first,second])
        
        obserable.subscribe(onNext: { (event) in
            
            print("event \(event)")
                
        }, onError: nil , onCompleted: nil).dispose()
 
```

Kết quả sẽ là 1,3,4,5,6

 
### Merger  Kết hợp nhiều observable trong một lần phát ra 
 
Có thể kết hợp nhiều output của Observable vì thế nó như một Observable  khi sử dụng merger 
 
Example
```swift
   let left = PublishSubject<Int>()
    let right = PublishSubject<Int>()
 
let source = Observable.of(left.asObserver(),right.asObserver())
        let obserable  = source.merge()
        obserable.subscribe(onNext: { (event) in
            print(event)
            }, onError: nil , onCompleted: nil)
        
        left.onNext(1)
        left.onNext(2)
        left.onNext(3)
        
        right.onNext(4)
        right.onNext(5)
        right.onNext(6)
```
 
### Start with 
 
Phát ra một chuỗi được chỉ địnnh trước  
 
Code examole
 ```
func startWith(){
        let number = Observable.of(4,5,6)
        let obserable = number.startWith(1,2,3)
        obserable.subscribe(onNext: { (event) in
            print("event \(event)")
            
        }, onError: nil, onCompleted: nil, onDisposed: nil).dispose()
       
    }
```
 
 
Kết quả lúc này sẽ là 
 
1,2,3,4,5,6,7
 
### Create 
 ```
let source: Observable = Observable<Int>.create { (event) -> Disposable in
            
            for i in 1 ... 5 {
                
                event.on(.next(i))
            }
            event.onCompleted()
            return Disposables.create {
                print("disposed")
            }
            
        }
        
        source.subscribe{
        
            print($0)
        }
 
 ```
 
 
 
 
 
 
 




