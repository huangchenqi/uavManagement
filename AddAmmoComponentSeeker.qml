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
    color:"skyblue"
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
                onTextChanged: {
                    ammoData.guiding_head_working_wavelength =text
                    console.log("Text content changed to: " + text)
                }
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
                onTextChanged: {
                    ammoData.guidance_head_operating_distance =text
                    console.log("Text content changed to: " + text)
                }
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
                onTextChanged: {
                    ammoData.guidance_head_frame_angle =text
                    console.log("Text content changed to: " + text)
                }
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
                onTextChanged: {
                    ammoData.guidance_head_field_of_view_angle_linearregion =text
                    console.log("Text content changed to: " + text)
                }
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
                onTextChanged: {
                    ammoData.guidance_head_operating_frequency =text
                    console.log("Text content changed to: " + text)
                }
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
                onTextChanged: {
                    ammoData.blind_spot_of_guidance_head =text
                    console.log("Text content changed to: " + text)
                }
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
                onTextChanged: {
                    ammoData.adaptability_of_guidance_head_sunlight =text
                    console.log("Text content changed to: " + text)
                }
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
                onTextChanged: {
                    ammoData.guidance_head_field_of_view_angle_instantaneous =text
                    console.log("Text content changed to: " + text)
                }
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
                //addAmmoComponentSeekerRoot.visible = false
                addAmmoComponentSeekerPopup.close()
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
                //addAmmoComponentSeekerRoot.visible = false
                addAmmoComponentSeekerPopup.close()
            }
        }
    }


    function saveammunitionData(){

    }

    function getSelectedPayloads(buttons) {

    }
    function saveDeliveryRecord() {

    }

}

