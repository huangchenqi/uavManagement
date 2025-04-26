import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtQuick.Window 2.12
import QtQuick.Dialogs 1.2
import "qrc:/"
import "qrc:/AddAmmoModules/Component"

Rectangle{//航空弹药的组件战斗部
    id:addAmmoComponentWarheadRoot
    visible: true
    width: 600
    height: 500
    color:"cyan"
    //title: qsTr("QML TableView example")
    Item {
        anchors.fill: parent
        Image {
            id: backGround
            anchors.fill: parent
            sourceSize: Qt.size(width,height)
            source: mainBackgroundSource
        }

    }

    Rectangle{
        id:rect_root
        anchors.fill: parent
        color: "transparent"

        CText{
            id:topTitle
            text: "战斗部"
            anchors.top: parent.top
            anchors.topMargin: 15
            anchors.horizontalCenter: parent.horizontalCenter
            color: mainColor
            pixelSize: 28
        }


        Grid{
            anchors.top: topTitle.bottom
            anchors.topMargin: 20
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.right: parent.right
            anchors.rightMargin: 10
            height: 300
            columnSpacing: 10
            rowSpacing: 20
            columns: 2

            CTextInput{
                id:warheadTypeText
                title: "类型:"
                pixelSize: 18
                titleWidth: pixelSize * 2.5
                width: parent.width/2 - 10
                height: 30
            }
            CTextInput{
                id:warheadWeightText
                title: "重量(Kg):"
                pixelSize: 18
                titleWidth: pixelSize * 4.5
                width: parent.width/2 - 10
                height: 30
            }

            CTextInput{
                id:warheadLengthText
                title: "长度(mm):"
                pixelSize: 18
                titleWidth: pixelSize * 4.5
                width: parent.width/2 - 10
                height: 30
            }

            CTextInput{
                id:warheadDiameterText
                title: "直径(mm):"
                pixelSize: 18
                titleWidth: pixelSize * 4.5
                width: parent.width/2 - 10
                height: 30
            }

            CTextInput{
                id:warheadMainChargeTypeText
                title: "装药类型:"
                pixelSize: 18
                titleWidth: pixelSize * 4.5
                width: parent.width/2 - 10
                height: 30
            }

            CTextInput{
                id:warheadChargeQualityText
                title: "装药质量(Kg):"
                pixelSize: 18
                titleWidth: pixelSize * 6.5
                width: parent.width/2 - 10
                height: 30
            }

            CTextInput{
                id:warheadChargingDensityText
                title: "装药密度(/m³):"
                pixelSize: 18
                titleWidth: pixelSize * 6.5
                width: parent.width/2 - 10
                height: 30
            }

            CTextInput{
                id:warheadFillingCoefficientText
                title: "装填系数:"
                pixelSize: 18
                titleWidth: pixelSize * 4.5
                width: parent.width/2 - 10
                height: 30
            }

            CTextInput{
                id:warheadBoosterText
                title: "扩爆药(g):"
                pixelSize: 18
                titleWidth: pixelSize * 5
                width: parent.width/2 - 10
                height: 30
            }

            CTextInput{
                id:warheadfragmentsNumberText
                title: "破片数量:"
                pixelSize: 18
                titleWidth: pixelSize * 4.5
                width: parent.width/2 - 10
                height: 30
            }

            CTextInput{
                id:warheadVehiclesEffectiveKillingRadiusText
                title: "有效杀伤半径[车辆](m):"
                pixelSize: 18
                titleWidth: pixelSize * 11.5
                width: parent.width/2 - 10
                height: 30
            }

            CTextInput{
                id:warheadPeopleEffectiveKillingRadiusText
                title: "有效杀伤半径[人](m):"
                pixelSize: 18
                titleWidth: pixelSize * 10.5
                width: parent.width/2 - 10
                height: 30
            }

            CTextInput{
                id:warheadInvasivenessText
                title: "侵袭能力:"
                pixelSize: 18
                titleWidth: pixelSize * 4.5
                width: parent.width/2 - 10
                height: 30
            }

            CTextInput{
                id:warheadVerticalStaticArmorPenetrationDepthText
                title: "垂直静破甲深度:"
                pixelSize: 18
                titleWidth: pixelSize * 7.5
                width: parent.width/2 - 10
                height: 30
            }
        }

        CButton {
            id:saveButton
            anchors.right: cancleButton.left
            anchors.rightMargin: 15
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 10
            width: 100
            height: 40
            text: "保存"
            onClicked:{
//                                saveammunitionData()
                addAmmoComponentWarheadRoot.visible = false
            }
        }

        CButton {
            id:cancleButton
            anchors.right: parent.right
            anchors.rightMargin: 10
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 10
            width: 100
            height: 40
            text: "返回"
            onClicked: {
                addAmmoComponentWarheadRoot.visible = false
            }
        }

    }

//    Item {
//        id:controlAmmunition
//        // width: 1200
//        // height: 600

//        ColumnLayout {
//                    anchors.fill: parent
//                    //Layout.fillWidth: true
//                    //Layout.fillHeight: true
//                    spacing: 10
//                    RowLayout {
//                        //anchors.fill: parent
//                        Layout.fillWidth: true
//                        //Layout.fillHeight: true
//                        Label {
//                            Layout.fillWidth: true
//                            verticalAlignment: Text.AlignVCenter
//                            Layout.leftMargin: 10
//                            horizontalAlignment: Text.AlignHCenter
//                            text: "战斗部"//qsTr("弹药管理");
//                            font.pointSize: 20
//                            color: "#4EC4FF"
//                        }
//                    }
//                    RowLayout {
//                        //anchors.fill: parent
//                        Layout.fillWidth: true
//                        Layout.fillHeight: true
//                        ColumnLayout {
//                            anchors.fill: parent
//                            Layout.fillWidth: true
//                            Layout.fillHeight: true

//                            RowLayout {
//                                //anchors.fill: parent
//                                Layout.fillWidth: true  // 占满列布局宽度
//                                // Layout.fillHeight: true
//                                spacing: 10
//                                Label{
//                                    id:warheadType
//                                    text: "类型:"
//                                    height: 50
//                                    width:100
//                                    // anchors.left: parent.left //锚点属性与锚点边距一起用。
//                                    // anchors.leftMargin: 10
//                                    Layout.leftMargin: 142
//                                    color: mainColor
//                                }

//                                TextField{
//                                    id: warheadTypeText
//                                    Layout.preferredWidth: 100
//                                    //Layout.leftMargin: 20
//                                    //width: 50
//                                }
//                                Label{
//                                    id:warheadWeight
//                                    text: "重量(Kg):"
//                                    height: 50
//                                    width:100
//                                    Layout.leftMargin: 100
//                                    color: mainColor
//                                }

//                                TextField{
//                                    id: warheadWeightText
//                                    Layout.preferredWidth: 100//width: 50
//                                    //Layout.leftMargin: 20
//                                }
//                                // Label{
//                                //     id:uavType
//                                //     text: "无人机类型:"
//                                //     height: 50
//                                //     width:100
//                                //     // anchors.left: parent.left //锚点属性与锚点边距一起用。
//                                //     // anchors.leftMargin: 10
//                                //     Layout.leftMargin: 10

//                                // }

//                                // ComboBox{
//                                //         id: ammunitionNameText
//                                //         width:100
//                                //         height:50
//                                //         model:["侦察无人机","攻击无人机","查打一体无人机"]
//                                // }


//                            }
//                            RowLayout {
//                                // anchors.fill: parent
//                                Layout.fillWidth: true
//                                // Layout.fillHeight: true
//                                spacing: 10
//                                Label{
//                                    id:warheadLength
//                                    text: "长度(mm):"
//                                    height: 50
//                                    width:100
//                                    Layout.leftMargin: 118
//                                    color: mainColor

//                                }
//                                TextField{
//                                    id: warheadLengthText
//                                    Layout.preferredWidth: 100//width: 50
//                                }
//                                Label{
//                                    id:warheadDiameter
//                                    text: "直径(mm):"
//                                    height: 50
//                                    width:100
//                                    Layout.leftMargin: 100
//                                    color: mainColor
//                                }
//                                TextField{
//                                    id: warheadDiameterText
//                                    Layout.preferredWidth: 100//width: 50
//                                }
//                            }
//                            RowLayout{
//                                Layout.fillWidth: true
//                                spacing:10
//                                Label{
//                                    id:warheadMainChargeType
//                                    text: "装药类型:"
//                                    height: 50
//                                    width:100
//                                    // anchors.left: parent.left //锚点属性与锚点边距一起用。
//                                    // anchors.leftMargin: 10
//                                    Layout.leftMargin: 118
//                                    color: mainColor

//                                }

//                                TextField{
//                                    id: warheadMainChargeTypeText
//                                    //width: 50
//                                    Layout.preferredWidth: 100
//                                    //Layout.preferredHeight: 50
//                                }
//                                Label{
//                                    id:warheadChargeQuality
//                                    text: "装药质量(Kg):"
//                                    height: 50
//                                    width:100
//                                    // anchors.left: parent.left //锚点属性与锚点边距一起用。
//                                    // anchors.leftMargin: 10
//                                    Layout.leftMargin: 76
//                                    color: mainColor

//                                }

//                                TextField{
//                                    id: warheadChargeQualityText
//                                    Layout.preferredWidth: 100//width: 50
//                                    //Layout.preferredHeight: 50
//                                }

//                            }

//                            RowLayout {
//                                // anchors.fill: parent
//                                Layout.fillWidth: true
//                                // Layout.fillHeight: true
//                                spacing: 10
//                                Label{
//                                    id:warheadChargingDensity
//                                    text: "装药密度(/m³):"
//                                    height: 50
//                                    width:100
//                                    // anchors.left: parent.left //锚点属性与锚点边距一起用。
//                                    // anchors.leftMargin: 10
//                                    Layout.leftMargin: 88
//                                    color: mainColor

//                                }

//                                TextField{
//                                    id: warheadChargingDensityText
//                                    Layout.preferredWidth: 100//width: 50
//                                    //Layout.preferredHeight: 50
//                                }
//                                Label{
//                                    id:warheadFillingCoefficient
//                                    text: "装填系数:"
//                                    height: 50
//                                    width:10
//                                    Layout.leftMargin: 100
//                                    color: mainColor
//                                }
//                                TextField{
//                                    id: warheadFillingCoefficientText
//                                    Layout.preferredWidth: 100//width: 50
//                                    //Layout.preferredHeight: 50
//                                }

//                            }
//                            RowLayout {
//                                // anchors.fill: parent
//                                Layout.fillWidth: true
//                                // Layout.fillHeight: true
//                                spacing: 10
//                                Label{
//                                    id:warheadBooster
//                                    text: "扩爆药(g):"
//                                    height: 50
//                                    width:100
//                                    // anchors.left: parent.left //锚点属性与锚点边距一起用。
//                                    // anchors.leftMargin: 10
//                                    Layout.leftMargin: 112
//                                    color: mainColor

//                                }

//                                TextField{
//                                    id: warheadBoosterText
//                                    Layout.preferredWidth: 100//width: 50
//                                    //Layout.preferredHeight: 50
//                                }
//                                Label{
//                                    id:warheadfragmentsNumber
//                                    text: "破片数量:"
//                                    height: 50
//                                    width:10
//                                    Layout.leftMargin: 100
//                                    color: mainColor
//                                }
//                                TextField{
//                                    id: warheadfragmentsNumberText
//                                    Layout.preferredWidth: 100//width: 50
//                                    //Layout.preferredHeight: 50
//                                }

//                            }
//                            RowLayout {
//                                // anchors.fill: parent
//                                Layout.fillWidth: true
//                                // Layout.fillHeight: true
//                                spacing: 10
//                                Label{
//                                    id:warheadVehiclesEffectiveKillingRadius
//                                    text: "有效杀伤半径【车辆】(m):"
//                                    height: 50
//                                    width:100
//                                    // anchors.left: parent.left //锚点属性与锚点边距一起用。
//                                    // anchors.leftMargin: 10
//                                    Layout.leftMargin: 28
//                                    color: mainColor

//                                }

//                                TextField{
//                                    id: warheadVehiclesEffectiveKillingRadiusText
//                                    Layout.preferredWidth: 100//width: 50
//                                    //Layout.preferredHeight: 50
//                                }
//                                Label{
//                                    id:warheadPeopleEffectiveKillingRadius
//                                    text: "有效杀伤半径【人】(m):"
//                                    height: 50
//                                    width:10
//                                    Layout.leftMargin: 22
//                                    color: mainColor
//                                }
//                                TextField{
//                                    id: warheadPeopleEffectiveKillingRadiusText
//                                    Layout.preferredWidth: 100//width: 50
//                                    //Layout.preferredHeight: 50
//                                }

//                            }
//                            RowLayout {
//                                // anchors.fill: parent
//                                Layout.fillWidth: true
//                                // Layout.fillHeight: true
//                                spacing: 10
//                                Label{
//                                    id:warheadInvasiveness
//                                    text: "侵袭能力:"
//                                    height: 50
//                                    width:100
//                                    // anchors.left: parent.left //锚点属性与锚点边距一起用。
//                                    // anchors.leftMargin: 10
//                                    Layout.leftMargin: 118
//                                    color: mainColor

//                                }

//                                TextField{
//                                    id: warheadInvasivenessText
//                                    Layout.preferredWidth: 100//width: 50
//                                    //Layout.preferredHeight: 50
//                                }
//                                Label{
//                                    id:warheadVerticalStaticArmorPenetrationDepth
//                                    text: "垂直静破甲深度:"
//                                    height: 50
//                                    width:10
//                                    Layout.leftMargin: 64
//                                    color: mainColor
//                                }
//                                TextField{
//                                    id: warheadVerticalStaticArmorPenetrationDepthText
//                                    Layout.preferredWidth: 100//width: 50
//                                    //Layout.preferredHeight: 50
//                                }

//                            }

//                        }

//                    }
//                    Item { Layout.topMargin: 60 }
//                    // Item { Layout.fillHeight:  true }
//                    // Item { Layout.fillHeight:  true }

//                // 下部行布局（底部对齐）
//                    RowLayout {
//                        Layout.fillWidth: true
//                        Layout.alignment: Qt.AlignBottom  // 底部对齐
//                        spacing: 10
//                        //Item { Layout.fillWidth: true }  // 占位空格元素
//                        CButton {
//                            id:saveButton
//                            // anchors.left: parent.left
//                            // anchors.leftMargin: 200
//                            Layout.leftMargin: 240
//                            width: 100
//                            height: 50
//                            text: "保存"
//                            onClicked:{
////                                saveammunitionData()
//                                addAmmoComponentWarheadRoot.visible = false
//                            }
//                        }

//                        CButton {
//                            id:cancleButton
//                            // anchors.left: parent.left
//                            // anchors.leftMargin: 10
//                            Layout.leftMargin: 40
//                            width: 100
//                            height: 50
//                            text: "返回"
//                            onClicked: {
//                                addAmmoComponentWarheadRoot.visible = false
//                            }
//                        }
//                    }
//        }
//    }


    function saveammunitionData(){
//        console.log("ammunitionTypeSelevtContent"+ammunitionTypeSelect.currentText+"-"+"testValue"+ammunitionTypeSelect.currentValue)

        var ammunitionData = {
            ammunitionTypeSelectContent:"",
            ammunitionNameTextContent:"",
            ammunitionIdTextContent:"",
            ammunitionLengthTextContent:"",
            ammunitionWidthTextContent:"",
            ammunitionHeightTextContent:"",
            ammunitionInvisibilitySelectContent:"",
            ammunitionFlightHeightTextContent:"",
            ammunitionFlightSpeedTextContent:"",
            ammunitionFlightDistanceRangeTextContent:"",
            ammunitionFlightTimeRangeTextContent:"",
            ammunitionTakeoffDistanceTextContent:"",
            ammunitionLandDistanceTextContent:"",
            ammunitionTurningRadiusRangeTextContent:"",
            ammunitionOperatioanalRadiusTextContent:"",
            ammunitionInvestigationPayloadTypeGroupContent:"",
            ammunitionBombingmethodGroupContent:"",
            ammunitionLoadReconnaissanceRangeTextContent:"",
            ammunitionLoadReconnaissanceAccuracyTextContent:"",
            ammunitionRecoverymodeGroupContent:"",
            ammunitionLowAltitudeBreakthroughSpeedTextContent:"",
            ammunitionHangingpointsTextContent:"",
            ammunitionPayloadcapacityTextContent:"",
            ammunitionRadarCrossSectionTextContent:""
        };


        var ammunitionInvestigationPayloadTypeJson = getSelectedPayloads(ammunitionInvestigationPayloadTypeGroup.buttons)
        console.log("有效载荷选择:", JSON.stringify(ammunitionInvestigationPayloadTypeJson))
        var ammunitionInvestigationPayloadTypeJsonStr = JSON.stringify(ammunitionInvestigationPayloadTypeJson)
        var ammunitionInvestigationPayloadTypeJsonStrresult = convertToJsonArray(ammunitionInvestigationPayloadTypeJson);
        console.log(ammunitionInvestigationPayloadTypeJsonStrresult);

        var ammunitionBombingmethodGroupJson = getSelectedPayloads(ammunitionBombingmethodGroup.buttons)
        console.log("投弹方式:", JSON.stringify(ammunitionBombingmethodGroupJson))
        var ammunitionBombingmethodGroupStr = JSON.stringify(ammunitionInvestigationPayloadTypeJson)
        var ammunitionBombingmethodGroupJsonStrresult = convertToJsonArray(ammunitionBombingmethodGroupJson);
        console.log(ammunitionBombingmethodGroupJsonStrresult);

        var ammunitionRecoverymodeGroupJson = getSelectedPayloads(ammunitionRecoverymodeGroup.buttons)
        console.log("回收方式:", JSON.stringify(ammunitionRecoverymodeGroupJson))
        var ammunitionRecoverymodeGroupJsonStr = JSON.stringify(ammunitionRecoverymodeGroupJson)
        var ammunitionRecoverymodeGroupJsonStrresult = convertToJsonArray(ammunitionRecoverymodeGroupJson);
        console.log(ammunitionRecoverymodeGroupJsonStrresult);

        var ammunitionTypeSelectContent = ammunitionTypeSelect.currentText
        var ammunitionNameTextContent = ammunitionNameText.text
        var ammunitionIdTextContent = ammunitionIdText.text
        var ammunitionLengthTextContent = ammunitionLengthText.text
        var ammunitionWidthTextContent = ammunitionWidthText.text
        var ammunitionHeightTextContent = ammunitionHeightText.text
        var ammunitionInvisibilitySelectContent = ammunitionInvisibilitySelect.currentText
        var ammunitionFlightHeightTextContent = ammunitionFlightHeightText.text
        var ammunitionFlightSpeedTextContent = ammunitionFlightSpeedText.text
        var ammunitionFlightDistanceRangeTextContent = ammunitionFlightDistanceRangeText.text
        var ammunitionFlightTimeRangeTextContent = ammunitionFlightTimeRangeText.text
        var ammunitionTakeoffDistanceTextContent = ammunitionTakeoffDistanceText.text
        var ammunitionLandDistanceTextContent = ammunitionLandDistanceText.text
        var ammunitionTurningRadiusRangeTextContent = ammunitionTurningRadiusRangeText.text
        var ammunitionOperatioanalRadiusTextContent = ammunitionOperatioanalRadiusText.text
        var ammunitionInvestigationPayloadTypeGroupContent = ammunitionInvestigationPayloadTypeJsonStrresult
        var ammunitionBombingmethodGroupContent = ammunitionBombingmethodGroupJsonStrresult
        var ammunitionLoadReconnaissanceRangeTextContent = ammunitionLoadReconnaissanceRangeText.text
        var ammunitionLoadReconnaissanceAccuracyTextContent = ammunitionLoadReconnaissanceAccuracyText.text
        var ammunitionRecoverymodeGroupContent = ammunitionRecoverymodeGroupJsonStrresult
        var ammunitionLowAltitudeBreakthroughSpeedTextContent = ammunitionLowAltitudeBreakthroughSpeedText.text
        var ammunitionHangingpointsTextContent = ammunitionHangingpointsText.text
        var ammunitionPayloadcapacityTextContent = ammunitionPayloadcapacityText.text
        var ammunitionRadarCrossSectionTextContent = ammunitionRadarCrossSectionText.text

        ammunitionData.ammunitionTypeSelectContent = ammunitionTypeSelectContent
        ammunitionData.ammunitionNameTextContent = ammunitionNameTextContent
        ammunitionData.ammunitionIdTextContent = ammunitionIdTextContent
        ammunitionData.ammunitionLengthTextContent = ammunitionLengthTextContent
        ammunitionData.ammunitionWidthTextContent = ammunitionWidthTextContent
        ammunitionData.ammunitionHeightTextContent = ammunitionHeightTextContent
        ammunitionData.ammunitionInvisibilitySelectContent = ammunitionInvisibilitySelectContent
        ammunitionData.ammunitionFlightHeightTextContent = ammunitionFlightHeightTextContent
        ammunitionData.ammunitionFlightSpeedTextContent = ammunitionFlightSpeedTextContent
        ammunitionData.ammunitionFlightDistanceRangeTextContent = ammunitionFlightDistanceRangeTextContent
        ammunitionData.ammunitionFlightTimeRangeTextContent = ammunitionFlightTimeRangeTextContent
        ammunitionData.ammunitionTakeoffDistanceTextContent = ammunitionTakeoffDistanceTextContent
        ammunitionData.ammunitionLandDistanceTextContent = ammunitionLandDistanceTextContent
        ammunitionData.ammunitionTurningRadiusRangeTextContent = ammunitionTurningRadiusRangeTextContent
        ammunitionData.ammunitionOperatioanalRadiusTextContent = ammunitionOperatioanalRadiusTextContent
        ammunitionData.ammunitionInvestigationPayloadTypeGroupContent = ammunitionInvestigationPayloadTypeGroupContent
        ammunitionData.ammunitionBombingmethodGroupContent = ammunitionBombingmethodGroupContent
        ammunitionData.ammunitionLoadReconnaissanceRangeTextContent = ammunitionLoadReconnaissanceRangeTextContent
        ammunitionData.ammunitionLoadReconnaissanceAccuracyTextContent = ammunitionLoadReconnaissanceAccuracyTextContent
        ammunitionData.ammunitionRecoverymodeGroupContent = ammunitionRecoverymodeGroupContent
        ammunitionData.ammunitionLowAltitudeBreakthroughSpeedTextContent = ammunitionLowAltitudeBreakthroughSpeedTextContent
        ammunitionData.ammunitionHangingpointsTextContent = ammunitionHangingpointsTextContent
        ammunitionData.ammunitionPayloadcapacityTextContent = ammunitionPayloadcapacityTextContent
        ammunitionData.ammunitionRadarCrossSectionTextContent = ammunitionRadarCrossSectionTextContent

        var jsonString = JSON.stringify(ammunitionData);
                console.log("jsonString"+jsonString);




    }
    function convertToJsonArray(jsonData) {
            return jsonData.map(function(item) {
                return item.name;
            });
    }

    function getSelectedPayloads(buttons) {
            return Array.from(buttons)
                .filter(btn => btn.checked)
                .map(btn => ({
                    name: btn.text,
                    code: btn.payloadCode
                }))
    }
    function saveDeliveryRecord() {

    }

}

