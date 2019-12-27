
### Đùa nghịc với Rxswift 
   Sau 2 tháng tìm hiều về Rxswift, thì hôm nay mình xin mạn phép để chia sẻ những gì mà mình học được trong 2 tháng vừa qua mong rằng bài viết sẽ hữu ích cho các bạn mới tiếp cận với RxSwift  
   
   ### RxSwift là gì 
   RxSwift là một phiên bản Reactive Extension được viết bằng ngôn ngữ Swift. ReactiveX là sự kết hợp của những ý tưởng hay nhất từ Observer pattern, Iterator pattern và functional programming.
   RxSwift sẽ giúp công việc của bạn trở nên đơn giản hơn. Thay cho notifications, một đối tượng khó để test, ta có thể sử dụng signals. Thay cho delegates, thứ tốn rất nhiều code, ta có thể viết blocks và bỏ điswitches/ifs lồng nhau. Ta còn có thể sử dụng KVO, IBActions, filters, MVVM và nhiều tiện ích khác được hỗ trợ mượt mà trong RxSwift.
   
   ###1  Observable Sequences 🎞
   Đầu tiên bạn cần phải hiểu bất mọi thứ trong Rxswift là  observable sequence hoặc một vài thứ họat động trong  subscribes các sự kiện phát ra bởi một observable sequence. 
   
 Observable sequences có thể phát ra không hoặc nhiều trong vòng đời của nó  với 3 trạng thái 
 .next(value: T) — khi nhận  giá trị vào  một observable sequence 

 .error(error: Error) — Nếu gặp phải Error một chuỗi sẽ phát ra sự kiện lỗi , và sẽ kết thúc chuỗi 

 .completed — Nếu một chuỗi kết thúc nó sẽ gửi event hoàn thành đến  subscribers
 Observable:Là  thằng phát ra thông báo thay đổi 
  Observable.of   sẽ in toàn bộ mảng
 Observable.from in các thành phần trong mảng
 Oberver:  Đăng ký một  và  lắng nghe khi có một observable thay đổi 

 ### Subjects 
 ### PublishSubject 
 Chỉ phát ra sự kiện mới nhất của  subscribers , do đó bất cứ sự kiện nào trước  subscribers sẽ không được phát ra 
 Ví  dụ  thực tế  publish  giống như  một thằng vào lớp muộn nhưng chỉ cần nghe 1 điểm nó cần nghe 
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

 ### BehaviourSubject

1  behavior subject  lưu các  các next event()  gần nhất, và phát lại cho subscriber mới 
behavior subject  cũng giống với publishsubject chỉ khác  behavior subject  bắt đầu bằng một gía trị mặc định khi khởi tạo, giá trị này có thể bị gi đè ngay sau khi , phần tử mới được thêm vào 

 code example

 ```swift
     let subject = BehaviorSubject(value: "")
     subject.onNext("Issue 1")

     subject.subscribe(onNext: { (event) in

     print("event \(event)")

     }).disposed(by: disposeBag)

     subject.onNext("Issue 2")

 ```
 Kêt quả sẽ là 

 event Issue 1 
 event Issue 2

 
 ###  ReplaySubject 
 Là khởi tạo với một kích thước bộ đệm  lưu  các phần tử  gần nhất vào bộ nhớ đệm và sau đó phát lại các phần tử  có trong bộ nhớ đệm cho subcriber mới 
 
 code example
 ```swift
     let replaySub = ReplaySubject<String>.create(bufferSize: 2)

     replaySub.onNext("Issue #1")
     replaySub.onNext("Issue #2")
     replaySub.onNext("Issue #3")
     replaySub.onNext("Issue #5")
     replaySub.onNext("Issue #6")
     replaySub.onNext("Issue #7")

     replaySub.subscribe { (event) in
         
         print("event \(event)")
     }
 ```

 Kết quả sẽ là:
 event next(Issue #6)
 event next(Issue #7)

 ### Combining Observables
 ### Merger 
  merge() cho phép kết hợp nhiều  Obseravble bằng cách gộp cái emit lại với nhau 
  Bạn có thể kết hơp nhiều output của nhiều  Obseravble thành  một Obseravble khi sử dụng   Merger  operator 
  .merge() complete chỉ khi tất cả các Inner Sequence và source Observable đều complete.
  Các Inner Sequence hoạt động đọc lập không liên quan với nhau.
  Nếu bết kỳ Inner Sequence nào emit Error thì Source Observable ngay lập tức emit ra Error và terminate.
 code example
 ```swift
     let left = PublishSubject<Int>()
     let right = PublishSubject<Int>()

     let source = Observable.of(left.asObserver(),right.asObserver())
     let obserable  = source.merge()
     obserable.subscribe(onNext: { (event) in
     print(event)
     }, onError: nil , onCompleted: nil)

     left.onNext(1)
     right.onNext(4)
     left.onNext(2)
     left.onNext(3)

     right.onNext(5)
     right.onNext(6)
 ```
 Kết quả là 1,4,2,3,5,6
 
 
 ### Concat 
 Concat tương tư như  hoạt động của  merge()   sự khác nhau nằm ở chỗ  concat sẽ đợi các luồng trước kết thúc trước rồi đến các luồng sau, còn merger()  thì bạn có thể thay thế output 

 ### Lưu ý 
 Bạn chỉ có thể nối các chuỗi có cùng kiểu dữ liệu với nhau, nếu nối khác kiểu  sẽ báo lỗi 

 Example 
 ```swift

    let source = Observable.of(left.asObserver(),right.asObserver())
     let obserable  = source.merge()
     obserable.subscribe(onNext: { (event) in
         print(event)
         }, onError: nil , onCompleted: nil)
     
     
     left.onNext(1)
     right.onNext(4)
     left.onNext(2)
     left.onNext(3)
     right.onNext(6)

 ```

 Kết quả sẽ là  
 event 1
 event 2
 event 3
*** Lý do 4 không chạy vì luồng left chưa kết thúc nên 4 sẽ không được hiển thị 

  
 ### Start with 
  
 Phát ra một chuỗi  mà bạn muốn phát ra đầu tiên 
  
 Code example 
  ```swift
  
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
  ```swift
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
  ### RxSwift Transforming
  ### map
  Rxswift map hoạt động tương tự thư viện chuẩn của swift điểm khác biệt là nó hoạt động trong một observables 
  
  code example
  
  ```swift
  
  let observable1 = Observable.of(1,2,3)

  observable1.map {
      
      return  $0 * 2
  }.subscribe(onNext: { (event) in
      print("event \(event)")
  }).disposed(by: disposeBag)
  
  ```
  Kết quả sẽ là 2,4,6
  
  
  ### flat map
  Đinh nghĩa flatMap biến đổi các thành phần phát ra bởi một Observable trong  thành nhiểu  Observable sau đó gộp lại thành một  Observable duy nhất 
  code example 
  Đầu tiên cần phải khởi tạo 1 struct 
  ``` swift 
  struct Player {
      var score:BehaviorRelay<Int>
      
  }
  
  ```
  
  ``` swift
  let kevin  = Player(score: BehaviorRelay(value: 50))
  
  let player = PublishSubject<Player>()
  
  player.asObservable().flatMap { $0.score.asObservable()}.subscribe(onNext: { (event) in
      
      print("event \(event)")
      }).disposed(by: disposeBag)
  
  player.onNext(kevin)
  
  
  ```
  Kết quả lúc này sẽ là event 50 
  
  
  ### flatMapLatest
  Sự khác biệt giữa flatMap và flatMapLatest  là nó huỷ trước khi subscription khi  subscription xảy ra 
  ``` swift
  
      let outerObservable = Observable<Int>.interval(0.5, scheduler: MainScheduler.instance).take(2)
      let combineObservable = outerObservable.flatMapLatest {  value in
      return Observable<NSInteger>.interval(0.3, scheduler: MainScheduler.instance).take(3).map {  inerValue in
      print("Outer value \(value) Iner Value \(inerValue)")
      }
      }
      combineObservable.subscribe(onNext: { (event) in
      print("event \(event)")
      }, onError: nil, onCompleted: nil).disposed(by: disposeBag)
  ````
  
  Kết quả sẽ là 
  
  Outer value 0 Iner Value 0
  event ()
  Outer value 1 Iner Value 0
  event ()
  Outer value 1 Iner Value 1
  event ()
  Outer value 1 Iner Value 2
  event ()

  
  ### Filtering Operators 
  ### Element at 
   Sẽ lấy một phần tử nằm ở một vị trí xác định trong chuỗi mà bạn muốn nhận được và bỏ qua  
   
   ``` swift 
   
         let observable1 = Observable.of(1,2,3)

        observable1.elementAt(2).subscribe(onNext: { (event) in
            print("event: \(event)")
        }).disposed(by: disposeBag)
   
   ```
   
   Kết quả lúc này sẽ là 3
   
   ### Filter 
   
   Chỉ phát ra những phần tử thoả mãn điều kiện 
   code example
   
   ```swift
  
      let observable1 = Observable.of(1,2,3,4,5,6)
      
      observable1.filter { $0 % 2 == 0
      
      }.subscribe(onNext: { (event) in
      
      print("event \(event)")
      }).disposed(by: disposeBag)
  
  ```
  ### Skipping operators
  Cho phép bỏ qua phần tử khi  truyền vào 1 prametter 
  
  code example
  ```swift 
  
  
  let observable1 = Observable.of("A","B","C","D","E","F")
  
    observable1.skip(0).subscribe { (event) in
  
  print(event)
  }.disposed(by: disposeBag)
  
  
  ```
  kêt quả sẽ là 
  next(B)
  next(C)
  next(D)
  next(E)
  next(F)
  completed
  ###  skipWhile
  
  
  ### Take
  
  Phát ra phần tử đầu tiên thứ n trong chuỗi 
  n-> là parmater truyền vào take ()
  
  code example
  
  ``` swif 
  
   Observable.of(1,2,3,4,5,6).take(2).subscribe { (event) in
       
       print(event)
   }.disposed(by: disposeBag)

```
Kết quả sẽ là 1,2 


### Take while 

Take while 
  
  code example

  ``` swift 
        Observable.of(2,4,6,7,5,8,10).takeWhile {
            
            return $0 % 2  == 0 
        }.subscribe(onNext: { (event) in
            print(event)
            }).disposed(by: disposeBag)

  ```


### Take until 


code example

```swift 
let subject = PublishSubject<String>()
        let trigger = PublishSubject<String>()
        
        subject.takeUntil(trigger).subscribe(onNext: { (event) in
            
            print(event)
            
        }).disposed(by: disposeBag)
        
       
        
        subject.onNext("event 1")
        trigger.onNext("X")

        subject.onNext("event 2")
        
        trigger.onNext("event 3")
```
kết quả sẽ là 1 
### Debounce

Chỉ phát ra sự kiện qua một thời gian nhất định trong quãng thời gian đó không phát ra tín hiệu khác 


### Throtter 



### Ứng dụng thực tế 

* [App tin tức  ]("https://github.com/codedeman/TT101/tree/f679be78c195e621b6a28b66c75c4bb8dc2c4cf5")


Bài viết này  là những gì mình học được trong những ngày tháng tiếp cận với Rx swift nên không  thể trách  nhiều thiếu sót mong các bậc cao nhân góp ý giúp mình để mình 



