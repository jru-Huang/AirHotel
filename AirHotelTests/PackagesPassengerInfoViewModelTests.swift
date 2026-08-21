import XCTest
@testable import AirHotel

final class PackagesPassengerInfoViewModelTests: XCTestCase {
    private var viewModel: PackagesPassengerInfoViewModel!

    // 每個測試都使用全新的 ViewModel，避免測試狀態互相影響。
    override func setUp() {
        super.setUp()
        viewModel = PackagesPassengerInfoViewModel()
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }

    // 沒有訂單資料時，應視為旅客資料未完成並顯示錯誤狀態。
    func testSubmitResultWhenTravelerInfoIsMissingReturnsIncompleteTravelerInfo() {
        // Given
        viewModel.info = nil

        // When
        let result = viewModel.submitResult(hasAgreedOrderTerms: true)

        // Then
        XCTAssertEqual(result, .incompleteTravelerInfo)
        XCTAssertTrue(viewModel.hasTravelerInfoError)
    }

    // 任一房間尚未加入旅客時，應優先回傳旅客資料未完成，不檢查訂購須知。
    func testSubmitResultWhenAnyRoomHasNoPassengerReturnsIncompleteTravelerInfoFirst() {
        // Given：房間 1 已填寫，房間 2 沒有旅客，且尚未同意訂購須知。
        viewModel.info = makeInfo(travelerLists: [[makeTraveler()], []])

        // When
        let result = viewModel.submitResult(hasAgreedOrderTerms: false)

        // Then
        XCTAssertEqual(result, .incompleteTravelerInfo)
        XCTAssertTrue(viewModel.hasTravelerInfoError)
    }

    // 沒有任何房間資料時，不可因空陣列的 allSatisfy 回傳 true 而誤判為完成。
    func testSubmitResultWhenTravelerRoomListIsEmptyReturnsIncompleteTravelerInfo() {
        // Given
        viewModel.info = makeInfo(travelerLists: [])

        // When
        let result = viewModel.submitResult(hasAgreedOrderTerms: true)

        // Then
        XCTAssertEqual(result, .incompleteTravelerInfo)
        XCTAssertTrue(viewModel.hasTravelerInfoError)
    }

    // 旅客資料完整但尚未同意訂購須知時，應要求開啟訂購須知。
    func testSubmitResultWhenTravelersAreCompleteButTermsAreNotAcceptedReturnsOrderTermsNotAccepted() {
        // Given
        viewModel.info = makeInfo(travelerLists: [[makeTraveler()], [makeTraveler()]])

        // When
        let result = viewModel.submitResult(hasAgreedOrderTerms: false)

        // Then
        XCTAssertEqual(result, .orderTermsNotAccepted)
        XCTAssertFalse(viewModel.hasTravelerInfoError)
    }

    // 旅客資料完整且已同意訂購須知時，應允許送出訂單。
    func testSubmitResultWhenTravelersAreCompleteAndTermsAreAcceptedReturnsSuccess() {
        // Given
        viewModel.info = makeInfo(travelerLists: [[makeTraveler()], [makeTraveler()]])

        // When
        let result = viewModel.submitResult(hasAgreedOrderTerms: true)

        // Then
        XCTAssertEqual(result, .success)
        XCTAssertFalse(viewModel.hasTravelerInfoError)
    }

    // 建立測試所需的最小訂單資料，僅讓每個案例調整旅客清單。
    private func makeInfo(
        travelerLists: [[TravelerModel]]
    ) -> PackagesPassengerInfoModel {
        let travelerRooms = travelerLists.enumerated().map { index, travelerList in
            PackagesPassengerInfoModel.TravelerRoom(
                roomNo: "房間\(index + 1)",
                numberOfPeople: "1位大人",
                travelerList: travelerList
            )
        }

        return PackagesPassengerInfoModel(
            airInfo: .init(
                depLocation: "台北",
                returnLocation: "東京",
                airSegmentList: []
            ),
            hotelInfo: .init(
                hotelName: "測試飯店",
                checkInDate: "2026-08-14",
                checkOutDate: "2026-08-15",
                roomDesc: "測試房型",
                hotelDetail: PackagesPassengerInfoModel.HotelDetail.init(hotelChineseName: "測試飯店", hotelEnglishName: "hotelTest", hotelGrade: 4.0, gradeDesc: "四星級飯店", hotelRating: 3.5, hotelGreenMark: true, displayTag: ["Tag"], roomDescription: "標準房", breakfastMark: true, breakfastType: "含早餐", bookingRule: "可免費取消", guaranteeMark: true, serviceFeeDesc: "手續費ＴＷＤ500", cancelDesc: "啊啊啊取消可行", checkInTime: "16:00~23:00", checkOutTime: "11點前", checkInfo: "入住規定請詳讀")
            ),
            buyerInfo: .init(
                buyerName: "測試訂購人",
                buyerEmail: "test@example.com",
                buyerPhone: "0912345678",
                noticeList: []
            ),
            travelerInfo: .init(travelerRoomList: travelerRooms),
            priceDetail: .init(
                amount: .init(amountPrice: "$0", amountDetailList: []),
                coupon: .init(title: "優惠折扣", price: "$0"),
                colaCoin: .init(title: "可樂旅遊幣", price: "$0"),
                totalTaxPrice: "$0"
            ),
            orderTermsList: []
        )
    }

    // 建立測試使用的預設旅客資料。
    private func makeTraveler() -> TravelerModel {
        TravelerModel(paxNo: nil,
                      gender: nil,
                      chineseName: "王大明",
                      surname: "WANG",
                      givenName: "DA MING",
                      birthday: nil,
                      isRepresentative: true
        )
    }
    
}
