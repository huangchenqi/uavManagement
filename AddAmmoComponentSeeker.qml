import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtQuick.Window 2.12
import QtQuick.Dialogs 1.2
import "qrc:/"
import "qrc:/AddAmmoModules/Component"

Rectangle{//航空弹药的组件导引头
    id:addAmmoComponentSeekerRoot
    visible: true
    width: 540
    height: 380
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
            text: "导引头"
            anchors.top: parent.top
            anchors.topMargin: 15
            anchors.horizontalCenter: parent.horizontalCenter
            color: mainColor
            pixelSize: 28
        }

        Rectangle{
            id:rect_Data
            anchors.top: topTitle.bottom
            anchors.topMargin: 20
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.right: parent.right
            anchors.rightMargin: 10
            height: 300
            color: "transparent"
            radius: 5

            CTextInput{
                id:seekerWorkingWavelengthText
                anchors.left: parent.left
                anchors.leftMargin: 5
                anchors.top: parent.top
                anchors.topMargin: 5
                title: "工作波长(nm):"
                pixelSize: 18
                titleWidth: pixelSize * 6.5
                width: parent.width/2 - 20
                height: 30
            }

            CTextInput{
                id:seekerEffectDistanceText
                anchors.left: seekerWorkingWavelengthText.left
                anchors.top: seekerWorkingWavelengthText.bottom
                anchors.topMargin: 15
                title: "作用距离(Km):"
                pixelSize: 18
                titleWidth: pixelSize * 6.5
                width: parent.width/2 - 20
                height: 30
            }

            CTextInput{
                id:seekerFrameAngleText
                anchors.left: seekerEffectDistanceText.left
                anchors.top: seekerEffectDistanceText.bottom
                anchors.topMargin: 15
                title: "框架角(°):"
                pixelSize: 18
                titleWidth: pixelSize * 5.5
                width: parent.width/2 - 20
                height: 30
            }

            CTextInput{
                id:seekerViewingAngleLinearRegionText
                anchors.left: seekerFrameAngleText.left
                anchors.top: seekerFrameAngleText.bottom
                anchors.topMargin: 15
                title: "视场角[线性区](°):"
                pixelSize: 18
                titleWidth: pixelSize * 9.5
                width: parent.width/2 - 20
                height: 30
            }

            CTextInput{
                id:seekerOperatingFrequencyText
                anchors.left: seekerWorkingWavelengthText.right
                anchors.leftMargin: 15
                anchors.top: seekerWorkingWavelengthText.top
                title: "工作频率(Hz):"
                pixelSize: 18
                titleWidth: pixelSize * 6.5
                width: parent.width/2 - 10
                height: 30
            }

            CTextInput{
                id:seekerBlindAreaText
                anchors.left: seekerOperatingFrequencyText.left
                anchors.top: seekerOperatingFrequencyText.bottom
                anchors.topMargin: 15
                title: "盲区(m):"
                pixelSize: 18
                titleWidth: pixelSize * 4
                width: parent.width/2 - 10
                height: 30
            }

            CTextInput{
                id:seekerAdaptabilityToSunlightText
                anchors.left: seekerBlindAreaText.left
                anchors.top: seekerBlindAreaText.bottom
                anchors.topMargin: 15
                title: "适应性[太阳光](°):"
                pixelSize: 18
                titleWidth: pixelSize * 9.5
                width: parent.width/2 - 10
                height: 30
            }

            CTextInput{
                id:seekerViewingAngleIFOVText
                anchors.left: seekerAdaptabilityToSunlightText.left
                anchors.top: seekerAdaptabilityToSunlightText.bottom
                anchors.topMargin: 15
                title: "视场角[瞬时视场](°):"
                pixelSize: 18
                titleWidth: pixelSize * 10.5
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
                addAmmoComponentSeekerRoot.visible = false
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
                addAmmoComponentSeekerRoot.visible = false
            }
        }
    }


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

