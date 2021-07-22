// import 'package:flutter/material.dart';
// import 'package:json_annotation/json_annotation.dart';

// part 'membership_argument.g.dart';

// enum AttentionStatus {
//   @JsonValue('0')
//   notAttentioned,
//   @JsonValue('1')
//   attentioned,
//   @JsonValue('2')
//   mutualAttentioned,
//   @JsonValue('-1')
//   unknow,
// }

// const _orderListTypeServiceOrderStr = 'ServiceOrder';
// const _orderListTypeProductsOrderStr = 'ProductsOrder';
// const _orderListTypeVehicleOrderStr = 'VehicleOrder';

// enum OrderListType {
//   @JsonValue(_orderListTypeServiceOrderStr)
//   serviceOrder,
//   @JsonValue(_orderListTypeProductsOrderStr)
//   productOrder,
//   @JsonValue(_orderListTypeVehicleOrderStr)
//   vehicleOrder,
// }

// enum MemberShipCnRouteType {
//   @JsonValue(0)
//   memberShipCn,
//   @JsonValue(1)
//   myOrders,
//   @JsonValue(2)
//   myDealers,
//   @JsonValue(3)
//   profileHome,
//   @JsonValue(4)
//   socialStatics,
//   @JsonValue(5)
//   followPage,
//   @JsonValue(6)
//   joyCoinCenterPage,
//   @JsonValue(7)
//   myCard,
//   @JsonValue(8)
//   membershipCenter,
//   @JsonValue(9)
//   joyCoinHistory,
//   @JsonValue(10)
//   vehicleLinkEntry,
//   @JsonValue(11)
//   vehicleLinkedDetail,
//   @JsonValue(12)
//   vehicleTabEntryCard,
//   @JsonValue(13)
//   vehicleTabEntryItem,
//   @JsonValue(14)
//   myMembershipBenefits,
//   @JsonValue(15)
//   membershipBenefits,
//   @JsonValue(16)
//   membershipBenefitsDetail,
//   @JsonValue(17)
//   joyCoinIntroduction,
//   @JsonValue(18)
//   myActiveValueHomePage,
//   @JsonValue(19)
//   myActiveValueHistroyPage,
//   @JsonValue(20)
//   myMedals,
//   @JsonValue(21)
//   medalProfile,
//   @JsonValue(22)
//   medalDetail,
// }

// @JsonSerializable(createToJson: false)
// class MemberShipCnRouteArguments {
//   @JsonKey(
//     unknownEnumValue: MemberShipCnRouteType.memberShipCn,
//     defaultValue: MemberShipCnRouteType.memberShipCn,
//   )
//   final MemberShipCnRouteType routeType;
//   final OrderListType orderListType;
//   final String orderId;
//   final String accountId;
//   final Object personalInfoBloc;
//   @JsonKey(unknownEnumValue: AttentionStatus.unknow)
//   final AttentionStatus status;
//   final String userId;
//   final String nickName;
//   final int selectIndex;
//   final bool isCommitVinPageEntry;
//   final String vehicleFrameNumber;
//   final String vehicleId;
//   final bool isCdVehicle;
//   final bool isFromChat;
//   final bool isShowFollowersActivities;
//   final int medalId;
//   final int medalLevel;
//   final String categoryId;
//   final String url;

//   MemberShipCnRouteArguments({
//     this.routeType,
//     this.orderListType,
//     this.orderId,
//     this.accountId,
//     this.personalInfoBloc,
//     this.status,
//     this.userId,
//     this.nickName,
//     this.selectIndex = 0,
//     this.isCommitVinPageEntry,
//     this.vehicleFrameNumber,
//     this.vehicleId,
//     this.isCdVehicle,
//     this.isFromChat = false,
//     this.isShowFollowersActivities = false,
//     this.medalId,
//     this.medalLevel,
//     this.categoryId,
//     this.url,
//   });

//   factory MemberShipCnRouteArguments.vehicleTabEntryCard({
//     @required String vehicleFrameNumber,
//     @required bool isCdVehicle,
//   }) =>
//       MemberShipCnRouteArguments(
//         routeType: MemberShipCnRouteType.vehicleTabEntryCard,
//         vehicleFrameNumber: vehicleFrameNumber,
//         isCdVehicle: isCdVehicle,
//       );

//   factory MemberShipCnRouteArguments.vehicleTabEntryItem({
//     @required String vehicleFrameNumber,
//     @required bool isCdVehicle,
//   }) =>
//       MemberShipCnRouteArguments(
//         routeType: MemberShipCnRouteType.vehicleTabEntryItem,
//         vehicleFrameNumber: vehicleFrameNumber,
//         isCdVehicle: isCdVehicle,
//       );

//   factory MemberShipCnRouteArguments.vehicleLinkedDetailPage({
//     String vehicleId,
//     @required String vehicleFrameNumber,
//     bool isCdVehicle = false,
//   }) =>
//       MemberShipCnRouteArguments(
//         routeType: MemberShipCnRouteType.vehicleLinkedDetail,
//         vehicleId: vehicleId,
//         vehicleFrameNumber: vehicleFrameNumber,
//         isCdVehicle: isCdVehicle,
//       );

//   factory MemberShipCnRouteArguments.vehicleLinkEntryPage({
//     @required bool isCommitVinPageEntry,
//     @required String vehicleFrameNumber,
//   }) =>
//       MemberShipCnRouteArguments(
//         routeType: MemberShipCnRouteType.vehicleLinkEntry,
//         isCommitVinPageEntry: isCommitVinPageEntry,
//         vehicleFrameNumber: vehicleFrameNumber,
//       );

//   factory MemberShipCnRouteArguments.followPage({
//     @required AttentionStatus status,
//     @required String userId,
//   }) =>
//       MemberShipCnRouteArguments(
//         routeType: MemberShipCnRouteType.followPage,
//         status: status,
//         userId: userId,
//       );

//   factory MemberShipCnRouteArguments.joyCoinCenterPage() =>
//       MemberShipCnRouteArguments(
//         routeType: MemberShipCnRouteType.joyCoinCenterPage,
//       );

//   factory MemberShipCnRouteArguments.fromArguments(Object arguments) {
//     if (arguments is MemberShipCnRouteArguments) return arguments;
//     if (arguments is! Map) return null;

//     final params = Map<String, dynamic>.from(arguments);
//     var routeType = int.tryParse(params['routeType']?.toString() ?? '0');
//     if (routeType < 0 || routeType >= MemberShipCnRouteType.values.length) {
//       routeType = 0;
//     }
//     params['routeType'] = routeType;
//     final selectIndex = int.tryParse(params['selectIndex'] ?? '0');
//     params['selectIndex'] = selectIndex;
//     if (params.containsKey('isCommitVinPageEntry')) {
//       final isCommitVinPageEntry = params['isCommitVinPageEntry'];
//       if (isCommitVinPageEntry is String) {
//         params['isCommitVinPageEntry'] =
//             (isCommitVinPageEntry == 'true' || isCommitVinPageEntry == '1')
//                 ? true
//                 : false;
//       }
//     }
//     if (params.containsKey('isCdVehicle')) {
//       final isCdVehicle = params['isCdVehicle'];
//       if (isCdVehicle is String) {
//         params['isCdVehicle'] =
//             (isCdVehicle == 'true' || isCdVehicle == '1') ? true : false;
//       }
//     }
//     if (params.containsKey('medalId')) {
//       final medalId = params['medalId'];
//       if (medalId is String) {
//         params['medalId'] = int.tryParse(medalId) ?? 0;
//       }
//     }
//     if (params.containsKey('medalLevel')) {
//       final medalLevel = params['medalLevel'];
//       if (medalLevel is String) {
//         params['medalLevel'] = int.tryParse(medalLevel) ?? 0;
//       }
//     }

//     final type = MemberShipCnRouteType.values[routeType];
//     if (type == MemberShipCnRouteType.joyCoinCenterPage) {
//       return MemberShipCnRouteArguments.joyCoinCenterPage();
//     } else if (type == MemberShipCnRouteType.followPage) {
//       final status = int.tryParse(params['status'] ?? '0') ?? 0;
//       return MemberShipCnRouteArguments.followPage(
//         status: status == 0
//             ? AttentionStatus.notAttentioned
//             : AttentionStatus.attentioned,
//         userId: params['userId'],
//       );
//     } else if (type == MemberShipCnRouteType.joyCoinHistory) {
//       return MemberShipCnRouteArguments(
//         routeType: type,
//         selectIndex: selectIndex,
//       );
//     }
//     return MemberShipCnRouteArguments.fromJson(params);
//   }

//   factory MemberShipCnRouteArguments.fromJson(Map<String, dynamic> json) =>
//       _$MemberShipCnRouteArgumentsFromJson(json);
// }
