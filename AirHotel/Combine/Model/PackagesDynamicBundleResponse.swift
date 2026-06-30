//
//  PackagesDynamicBundleResponse.swift
//  AirHotel
//
//  Created by 7943 on 2026/6/22.
//

import Foundation

struct PackagesDynamicBundleResponse: Codable {
    let flowId: String?
    let conditionDetail: ConditionDetail?
    let airTicketPreselection: AirTicketPreselection?
    let hotelPreselection: HotelPreselection?
    let totalPrice: Int?
    let adtPerPrice: Int?
    let chdPerPrice: Int?
    let adtTotalPrice: Int?
    let chdTotalPrice: Int?
    let noticeContent: NoticeContent?
    let expireTime: String?
    
    enum CodingKeys: String, CodingKey {
        case flowId = "Flow_Id"
        case conditionDetail = "Condition_Detail"
        case airTicketPreselection = "AirTicket_Preselection"
        case hotelPreselection = "Hotel_Preselection"
        case totalPrice = "Total_Price"
        case adtPerPrice = "Adt_PerPrice"
        case chdPerPrice = "Chd_PerPrice"
        case adtTotalPrice = "Adt_Total_Price"
        case chdTotalPrice = "Chd_Total_Price"
        case noticeContent = "Notice_Content"
        case expireTime = "Expire_Time"
    }
    
    struct ConditionDetail: Codable {
        let departureCode: String?
        let departureName: String?
        let departureType: String?
        let arrivalCode: String?
        let arrivalName: String?
        let arrivalType: String?
        let departureDate: String?
        let returnDate: String?
        let serviceClass: ServiceClass?
        let directMark: Bool?
        let roomNumber: Int?
        let adultsNumber: Int?
        let childNumber: Int?
        let partialStayMark: Bool?
        let childAge: [Int]?
        let checkInDate: String?
        let checkOutDate: String?
        let nightDesc: String?
        
        enum CodingKeys: String, CodingKey {
            case departureCode = "Departure_Code"
            case departureName = "Departure_Name"
            case departureType = "Departure_Type"
            case arrivalCode = "Arrival_Code"
            case arrivalName = "Arrival_Name"
            case arrivalType = "Arrival_Type"
            case departureDate = "Departure_Date"
            case returnDate = "Return_Date"
            case serviceClass = "Service_Class"
            case directMark = "Direct_Mark"
            case roomNumber = "Room_Number"
            case adultsNumber = "Adults_Number"
            case childNumber = "Child_Number"
            case partialStayMark = "Partial_Stay_Mark"
            case childAge = "Child_Age"
            case checkInDate = "CheckIn_Date"
            case checkOutDate = "CheckOut_Date"
            case nightDesc = "Night_Desc"
        }
    }
    
    struct ServiceClass: Codable {
        let value: String?
        let Text: String?
        
        enum CodingKeys: String, CodingKey {
            case value = "Value"
            case Text = "Text"
        }
    }
    
    struct AirTicketPreselection: Codable {
        let pageId: String?
        let segmentInfoList: [SegmentInfo]?
        let baggageInfoDesc: String?
        let displayTag: [String]?
        
        enum CodingKeys: String, CodingKey {
            case pageId = "Page_Id"
            case segmentInfoList = "SegmentInfo_List"
            case baggageInfoDesc = "BaggageInfo_Desc"
            case displayTag = "Display_Tag"
        }
    }
    
    struct SegmentInfo: Codable {
        let itemIndex: Int?
        let breakdownPrice: Int?
        let breakdownPriceDesc: String?
        let segmentContent: SegmentContent?
        let ticketingAirline: String?
        let isNdcOptional: Bool?
        let isFareFamilyOptional: Bool?
        
        enum CodingKeys: String, CodingKey {
            case itemIndex = "Item_Index"
            case breakdownPrice = "Breakdown_Price"
            case breakdownPriceDesc = "Breakdown_PriceDesc"
            case segmentContent = "Segment_Content"
            case ticketingAirline = "Ticketing_Airline"
            case isNdcOptional = "Is_NdcOptional"
            case isFareFamilyOptional = "Is_FareFamilyOptional"
        }
    }
    
    struct SegmentContent: Codable {
        let segmentIndex: Int?
        let departureTime: String?
        let arrivalTime: String?
        let departureDateTime: String?
        let arrivalDateTime: String?
        let dateVariation: String?
        let segmentTimeDesc: String?
        let segmentTime: Int?
        let departureLocCode: String?
        let arrivalLocCode: String?
        let transitCount: Int?
        let flightList: [Flight]?
        
        enum CodingKeys: String, CodingKey {
            case segmentIndex = "Segment_Index"
            case departureTime = "Departure_Time"
            case arrivalTime = "Arrival_Time"
            case departureDateTime = "Departure_DateTime"
            case arrivalDateTime = "Arrival_DateTime"
            case dateVariation = "Date_Variation"
            case segmentTimeDesc = "Segment_TimeDesc"
            case segmentTime = "Segment_Time"
            case departureLocCode = "Departure_LocCode"
            case arrivalLocCode = "Arrival_LocCode"
            case transitCount = "Transit_Count"
            case flightList = "Flight_List"
        }
    }
    
    struct Flight: Codable {
        let flightIndex: Int?
        let departureDate: String?
        let departureTime: String?
        let arrivalDate: String?
        let arrivalTime: String?
        let departureDateTime: String?
        let arrivalDateTime: String?
        let dateVariation: String?
        let departureLocCode: String?
        let departureTerminal: String?
        let departureLocDesc: String?
        let arrivalLocCode: String?
        let arrivalTerminal: String?
        let arrivalLocDesc: String?
        let ticketingCarrier: String?
        let ticketingCarrierName: String?
        let operatingCarrier: String?
        let operatingCarrierName: String?
        let carrierLogo: String?
        let carrierNo: String?
        let carrierDesc: String?
        let equipmentType: String?
        let serviceClassDesc: String?
        let carrierTime: Int?
        let carrierTimeDesc: String?
        let transitTime: Int?
        let isLcc: Bool?
        let stopoverList: [Stopover]?
        
        enum CodingKeys: String, CodingKey {
            case flightIndex = "Flight_Index"
            case departureDate = "Departure_Date"
            case departureTime = "Departure_Time"
            case arrivalDate = "Arrival_Date"
            case arrivalTime = "Arrival_Time"
            case departureDateTime = "Departure_DateTime"
            case arrivalDateTime = "Arrival_DateTime"
            case dateVariation = "Date_Variation"
            case departureLocCode = "Departure_LocCode"
            case departureTerminal = "Departure_Terminal"
            case departureLocDesc = "Departure_LocDesc"
            case arrivalLocCode = "Arrival_LocCode"
            case arrivalTerminal = "Arrival_Terminal"
            case arrivalLocDesc = "Arrival_LocDesc"
            case ticketingCarrier = "Ticketing_Carrier"
            case ticketingCarrierName = "Ticketing_CarrierName"
            case operatingCarrier = "Operating_Carrier"
            case operatingCarrierName = "Operating_CarrierName"
            case carrierLogo = "Carrier_Logo"
            case carrierNo = "Carrier_No"
            case carrierDesc = "Carrier_Desc"
            case equipmentType = "Equipment_Type"
            case serviceClassDesc = "Service_ClassDesc"
            case carrierTime = "Carrier_Time"
            case carrierTimeDesc = "Carrier_TimeDesc"
            case transitTime = "Transit_Time"
            case isLcc = "Is_Lcc"
            case stopoverList = "Stopover_List"
        }
    }
    
    struct Stopover: Codable {
        let airportCode: String?
        let airportName: String?
        let stopoverTime: Int?
        let stopoverLocDesc: String?
        
        enum CodingKeys: String, CodingKey {
            case airportCode = "Airport_Code"
            case airportName = "Airport_Name"
            case stopoverTime = "Stopover_Time"
            case stopoverLocDesc = "Stopover_LocDesc"
        }
    }
    
    struct HotelPreselection: Codable {
        let priceId: String?
        let hotelInfoList: [HotelInfo]?
        let roomInfo: RoomInfo?
        let displayTag: [String]?
        
        enum CodingKeys: String, CodingKey {
            case priceId = "Price_Id"
            case hotelInfoList = "HotelInfo_List"
            case roomInfo = "Room_Info"
            case displayTag = "Display_Tag"
        }
    }
    
    struct HotelInfo: Codable {
        let hotelNo: Int?
        let hotelChineseName: String?
        let hotelEnglishName: String?
        let locationName: String?
        let hotelImg: String?
        let hotelHotMark: Bool?
        let hotelGrade: Double?
        let gradeDesc: String?
        let hotelSort: Int?
        let hotelAddress: String?
        let hotelTraceMark: Bool?
        let hotelRating: Double?
        let hotelLongitude: String?
        let hotelLatitude: String?
        let hotelTrafficInfo: String?
        let hotelBrief: String?
        let hotelLandmarkMark1: Bool?
        let hotelLandmarkMark2: Bool?
        let hotelLandmarkMark3: Bool?
        let hotelLandmarkMark4: Bool?
        let hotelLandmarkMark5: Bool?
        let hotelLandmarkMark6: Bool?
        let hotelRoomMark1: Bool?
        let hotelRoomMark4: Bool?
        let hotelRoomMark7: Bool?
        let hotelServiceMark1: Bool?
        let hotelServiceMark3: Bool?
        let hotelServiceMark6: Bool?
        let hotelServiceMark7: Bool?
        let hotelServiceMark8: Bool?
        let hotelServiceMark9: Bool?
        let hotelServiceMark10: Bool?
        let hotelServiceMark13: Bool?
        let hotelServiceMark15: Bool?
        let hotelGreenMark: Bool?
        
        enum CodingKeys: String, CodingKey {
            case hotelNo = "Hotel_No"
            case hotelChineseName = "Hotel_Chinese_Name"
            case hotelEnglishName = "Hotel_English_Name"
            case locationName = "Location_Name"
            case hotelImg = "Hotel_Img"
            case hotelHotMark = "Hotel_HotMark"
            case hotelGrade = "Hotel_Grade"
            case gradeDesc = "Grade_Desc"
            case hotelSort = "Hotel_Sort"
            case hotelAddress = "Hotel_Address"
            case hotelTraceMark = "Hotel_TraceMark"
            case hotelRating = "Hotel_Rating"
            case hotelLongitude = "Hotel_Longitude"
            case hotelLatitude = "Hotel_Latitude"
            case hotelTrafficInfo = "Hotel_Traffic_Info"
            case hotelBrief = "Hotel_Brief"
            case hotelLandmarkMark1 = "Hotel_LandmarkMark1"
            case hotelLandmarkMark2 = "Hotel_LandmarkMark2"
            case hotelLandmarkMark3 = "Hotel_LandmarkMark3"
            case hotelLandmarkMark4 = "Hotel_LandmarkMark4"
            case hotelLandmarkMark5 = "Hotel_LandmarkMark5"
            case hotelLandmarkMark6 = "Hotel_LandmarkMark6"
            case hotelRoomMark1 = "Hotel_RoomMark1"
            case hotelRoomMark4 = "Hotel_RoomMark4"
            case hotelRoomMark7 = "Hotel_RoomMark7"
            case hotelServiceMark1 = "Hotel_ServiceMark1"
            case hotelServiceMark3 = "Hotel_ServiceMark3"
            case hotelServiceMark6 = "Hotel_ServiceMark6"
            case hotelServiceMark7 = "Hotel_ServiceMark7"
            case hotelServiceMark8 = "Hotel_ServiceMark8"
            case hotelServiceMark9 = "Hotel_ServiceMark9"
            case hotelServiceMark10 = "Hotel_ServiceMark10"
            case hotelServiceMark13 = "Hotel_ServiceMark13"
            case hotelServiceMark15 = "Hotel_ServiceMark15"
            case hotelGreenMark = "Hotel_GreenMark"
        }
    }
    
    struct RoomInfo: Codable {
        let roomDescription: String?
        let bedDescription: String?
        let bookingRule: String?
        let guaranteeMark: Bool?
        let serviceFeeDesc: String?
        let cancelDesc: String?
        let breakfastType: String?
        let breakfastRemark: String?
        let coverImg: [CoverImg]?
        
        enum CodingKeys: String, CodingKey {
            case roomDescription = "Room_Description"
            case bedDescription = "Bed_Description"
            case bookingRule = "Booking_Rule"
            case guaranteeMark = "Guarantee_Mark"
            case serviceFeeDesc = "Service_Fee_Desc"
            case cancelDesc = "Cancel_Desc"
            case breakfastType = "Breakfast_Type"
            case breakfastRemark = "Breakfast_Remark"
            case coverImg = "Cover_img"
        }
    }
    
    struct CoverImg: Codable {
        let imgURL: String?
        let imgAlt: String?
        
        enum CodingKeys: String, CodingKey {
            case imgURL = "Img_URL"
            case imgAlt = "Img_Alt"
        }
    }
    
    struct NoticeContent: Codable {
        let announceTextList: [String]?
        let stopBookingText: String?
        let policyList: [Policy]?
        let overnightMark: Bool?
        let warningTimeText: String?
        
        enum CodingKeys: String, CodingKey {
            case announceTextList = "Announce_Text"
            case stopBookingText = "StopBooking_Text"
            case policyList = "Policy_List"
            case overnightMark = "Overnight_Mark"
            case warningTimeText = "WarningTime_Text"
        }
    }
    
    struct Policy: Codable {
        let title: String?
        let text: String?
        
        enum CodingKeys: String, CodingKey {
            case title = "Title"
            case text = "Text"
        }
    }
}
