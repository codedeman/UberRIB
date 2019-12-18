UBER RIB 

Là viết tắt của Router Interactor  Builder

Interactor chứ business logic 

Router sẽ lắng nghe từ Interactor

Builder sẽ chịu trách nhiệm khởi tạo tất cả các thành phần RIB 

View để update UI
Component được sử dụng để quản lý các ràng buộc của RIB


ViewController - Interactor - 


Interactor  sử dụng routing giao tiếp với  router 

LoggedOutRouter dùng LoggedOutInteractable giao tiếp với  interactor  nó sử dụng LoggedOutViewControllable giao tiếp với ViewController 


ViewController sử dụng listener 
