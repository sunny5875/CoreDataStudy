# CoreDataStudy
2023, CoreData Practice
노션 정리 원본: https://exciting-anorak-474.notion.site/CoreData-6d2bcaa51f0d49169790957db08c0c85?pvs=4

### 개요
데이터베이스로 주로 Realm와 캐시로 키체인과 UserDefault를 사용했었다.
하지만, Realm의 경우 Task 내에서 진행 시 Thread 충돌 문제가 발생해서 리팩토링 작업을 하다보니 자꾸 앱이 크래시나는 현상이 발생되었다.
그러면 CoreData를 쓰는 것이 어떨까??

### CoreData란?

- userDefault보다 좀 더 복잡한 데이터를 저장할 수 있는 프레임워크

### 기능

- persistence
    - 객체를 저장소에 매핑하는 세부정보를 추상화하기 때문에 DB를 관ㄹ리하지 않고도 Swift데이터를 쉽게 저장할 수 있음
    
    ![Untitled](https://prod-files-secure.s3.us-west-2.amazonaws.com/3b9e488f-6100-40ea-934a-e01d97147ac2/91796531-ecde-4bf2-99cc-fc5c3a1576a1/Untitled.png)
    
- 개별/일괄 변경상황을 undo,redo가능
    - 변경사항을 추적하고 개별적/그룹적으로 한번에 롤백할 수 있음
- 백그라운드 데이터 작업
    - 백그라운드에서 json을 객체로 분석하는 작업을수행
- 동기화
    - DataSource를 제공하기 때문에 동기화 상태로 유지하는데 많은 도움을 줌

### 특징

- Database 아님!
- cloudKit과 연동이 아주 쉬움
    - 내가 가진 기기에서 오브젝트 접근 가능
- sqlite를 쓰긴 하지만 오브젝트 관리를 해준다라고 생각할 것
- SQL도 아님
- Container라는 공간에 데이터를 저장

### 개념

세개의 레이어 존재

![스크린샷 2023-10-26 오전 11.12.21.png](https://prod-files-secure.s3.us-west-2.amazonaws.com/3b9e488f-6100-40ea-934a-e01d97147ac2/7a99dd47-6937-4c0b-b82b-ff4f76f59349/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA_2023-10-26_%E1%84%8B%E1%85%A9%E1%84%8C%E1%85%A5%E1%86%AB_11.12.21.png)

Managed Object model: 클래스, 이 모델을 통해서 오브젝트를 생성

Persistent Store Coordinator: 데이터 저장

Managed object model: 코디네이터와 스토어를 관리

---

여기서 잠깐 CoreData를 만들려고 보니 SwiftData라는 개념도 나와서 추가 설명 🙂

### CoreData VS SwiftData

- 공통점
    - 둘다 object relational mapping framework로 data를 영구적으로 관리하는 방법
- 차이점
- SwiftData
    - **iOS 17부터 사용 가능**, CoreData로 마이그레이션 가능
    - declarative data modeling
    - automatic persistence
    - efficient data access: lazy loading하기 때문에 접근이 쉬움
    - integration with SwiftUI
- CoreData
    - mature framework
    - powerful feature
    - well-tested

![Untitled](https://prod-files-secure.s3.us-west-2.amazonaws.com/3b9e488f-6100-40ea-934a-e01d97147ac2/c8a20bec-cb90-40a9-b2e3-4bfdfe08ead7/Untitled.png)

<aside>
💡 즉, SwiftData는 새로 나온 프레임워크이고 좀 더 선언적이고 사용성이 좋아 보이나 iOS 17 소노마부터 적용가능하기 때문에 CoreData를 우선적으로 쓰는 것이 좋아 보임!

</aside>

### 사용 방법

1. Data model 파일 추가
2. Entity 생성
    1. 여기서 Entity의 의미
        1. 저장될 데이터들의 집합
3. relation 생성
    1. property를 계산해서 넣지 않아도 relation만 넣어주면 아예 오브젝트끼리 relation이 생성됨
4. model의 inspector에서 codegen 선택
- Manual / None(모두 관리할 수 있다는 뜻)
    - 관리 객체 하위 클래스의 프로퍼티, 논리를 편집
- Class Definition
    - 생성된 논리나 프로퍼티를 편집할 필요가 없을 경우 선택
    - 소스 파일 없이 바로 Entity()가 가능해진다는 소리임!!
- Category / Extension
    - 관리 객체 하위 클래스에 추가적인 메서드나 비즈니스 논리를 추가하고 싶은 경우 선택
1. editor에서 createNSManagedObject를 선택
2. CoreData Stack을 설정
    1. persistent container를 생성

![Untitled](https://prod-files-secure.s3.us-west-2.amazonaws.com/3b9e488f-6100-40ea-934a-e01d97147ac2/4067eef7-7e5b-4e05-9742-4bee3b4923c2/Untitled.png)

![Untitled](https://prod-files-secure.s3.us-west-2.amazonaws.com/3b9e488f-6100-40ea-934a-e01d97147ac2/ce89d6e3-9929-46e5-940a-82df526d7b69/Untitled.png)

- NSManagedObjectModel
    - 앱의 타입, 프로퍼티, 관계를 설명하는 앱의 모델 파일
        - Entity를 설명하는 database의 스키마
- NSManagedObjectContext
    - 앱 타입의 인스턴스에 대한 변경 사항을 추적
    - object를 생성, 저장, 가져오는 작업을 제공
- NSPersistentStoreCoordinator
    - 스토어에서 앱 타입의 인스턴스를 저장하고 가져옴
    - 영구 저장소와 managedObjectModel을 연결
- NSPersistentContainer
    - 모델, 컨텍스트, 스토어 coordinator를 한 번에 설정
    - 모든 객체를 포함하는 최상위 칭구

### container

- 이곳의 데이터는 모두 공유된 자원을 사용하기에 싱글톤으로 생성

```swift
class CoreDataDB {
    
    static let shared = CoreDataDB()
    
    // 여기 이름은 모델 이름을 넣을 것
    private let container = NSPersistentContainer(name: "Model")
    var context: NSManagedObjectContext {
        container.viewContext
    }
    
    private init() {
        loadStores()
    }
    
    private func loadStores() {
        container.loadPersistentStores(completionHandler: { _, _ in })
    }
    
    func save() {
        try? context.save()
    }
}
```

### CoreData Stack

- 앱의 모델 레이어를 관리하고 유지하는 역할

### 저장하는 방법

1. NSManagedObjectContext를 가져온다
2. Entity를 가져온다
3. NSManagedObject를 만든다
4. NSManagedObject에 값을 세팅한다
5. NSManagedObjectContext를 저장한다.

### Optional이나 default값 설정하는 방법

attribute의 inspector를 보면 보인다!!

![스크린샷 2023-10-26 오후 2.25.09.png](https://prod-files-secure.s3.us-west-2.amazonaws.com/3b9e488f-6100-40ea-934a-e01d97147ac2/efe8b625-1215-41bc-8de9-545057a0c8c4/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA_2023-10-26_%E1%84%8B%E1%85%A9%E1%84%92%E1%85%AE_2.25.09.png)

### GUI라고 해서 만만하게 보지 말자...

- 디비에 값이 있는데 GUI에서 조금이라도 변경했다?? 그러면 migration해줘야한다… ㅠㅠ
- add model version 후에 바꿀 거 바꾸고 기본 모델 설정바꾸고 맵핑 모델 만들면 성공~

### Unique 제약조건 두는 방법

- inspector에 보면 constaint가 있음 거기에 unique를 두고 싶은 property값을 적으면 됨

### Upsert지원하는 방법

- 일단 unique key를 생성하고
- create하는 부분에  mergepolicy 지정하면 됨

### AutoIncrement
- 찾아본 결과로는 지원하지 않는 것으로 보임
- 하지만 내부의 objectId가 있어 대체할 수 있을 것으로 보임
