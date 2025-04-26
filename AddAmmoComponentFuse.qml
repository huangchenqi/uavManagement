import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtQuick.Window 2.12
import QtQuick.Dialogs 1.2
import "qrc:/"
import "qrc:/AddAmmoModules/Component"

Rectangle{//航空弹药的组件引信
    id:addAmmoComponentFuseRoot
    visible: true
    width: 530
    height: 460
//    color:"cyan"
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
        Rectangle{
            id:rect_DataTitle
            anchors.top: rect_root.top
            anchors.topMargin: 2
            anchors.left: parent.left
            anchors.leftMargin: 2
            anchors.right: parent.right
            anchors.rightMargin: 10
            height: 30
            color: "transparent"
            radius: 5
            Label{
                id:fuseTypetion
                text: "引信类型:"
                color: mainColor
                width: parent.width/2 - 20
                height: 30

            }
            CText{
                id:fuseType
                anchors.top: parent.top
                anchors.topMargin: 15
                anchors.horizontalCenter: parent.horizontalCenter
                color: mainColor
                pixelSize: 28
                onTextChanged: {

                    ammoData.fuse_type =text
                    console.log("Text content changed to: " + text)
                }
            }
        }
            CTextInput{
                id:fuseLengthText
                anchors.left: rect_DataTitle.left
                anchors.top: rect_DataTitle.bottom
                anchors.topMargin: 15
                title: "长度(m):"
                pixelSize: 18
                titleWidth: pixelSize * 4
                width: parent.width/2 - 20
                height: 30
                onTextChanged: {
                    // if(text != "")
                    // {
                    // }
                    ammoData.fuse_length =text
                    console.log("Text content changed to: " + text)
                }

            }

            CTextInput{
                id:fuseWeightText
                anchors.left: fuseLengthText.left
                anchors.top: fuseLengthText.bottom
                anchors.topMargin: 15
                title: "质量(Kg):"
                pixelSize: 18
                titleWidth: pixelSize * 4.5
                width: parent.width/2 - 20
                height: 30
                onTextChanged: {
                    // if(text != "")
                    // {
                    // }
                    ammoData.fuze_quality =text
                    console.log("Text content changed to: " + text)
                }
            }

            CTextInput{
                id:fuseSelfDestructionTimeText
                anchors.left: fuseWeightText.left
                anchors.top: fuseWeightText.bottom
                anchors.topMargin: 15
                title: "自毁时间(s):"
                pixelSize: 18
                titleWidth: pixelSize * 6
                width: parent.width/2 - 20
                height: 30
                onTextChanged: {
                    // if(text != "")
                    // {
                    // }
                    ammoData.fuse_self_destruct_time =text
                    console.log("Text content changed to: " + text)
                }
            }

            CTextInput{
                id:fuseFirstLevelTerminationInsuranceTimeText
                anchors.left: fuseSelfDestructionTimeText.left
                anchors.top: fuseSelfDestructionTimeText.bottom
                anchors.topMargin: 15
                title: "一级解除保险时间(s):"
                pixelSize: 18
                titleWidth: pixelSize * 10
                width: parent.width/2 - 20
                height: 30
                onTextChanged: {
                    // if(text != "")
                    // {
                    // }
                    ammoData.first_level_release_time_of_fuse =text
                    console.log("Text content changed to: " + text)
                }
            }

            CTextInput{
                id:fuseActionReliabilityRateText
                anchors.left: fuseFirstLevelTerminationInsuranceTimeText.left
                anchors.top: fuseFirstLevelTerminationInsuranceTimeText.bottom
                anchors.topMargin: 15
                title: "作用可靠率:"
                pixelSize: 18
                titleWidth: pixelSize * 5.5
                width: parent.width/2 - 20
                height: 30
                onTextChanged: {
                    // if(text != "")
                    // {
                    // }
                    ammoData.reliability_rate_of_fuse_action =text
                    console.log("Text content changed to: " + text)
                }
            }

            CTextInput{
                id:fuseFiringRateText
                anchors.left: fuseTypeText.right
                anchors.leftMargin: 15
                anchors.top: fuseTypeText.top
                title: "发火率:"
                pixelSize: 18
                titleWidth: pixelSize * 3.5
                width: parent.width/2 - 20
                height: 30
                onTextChanged: {
                    // if(text != "")
                    // {
                    // }
                    ammoData.fuse_firing_rate =text
                    console.log("Text content changed to: " + text)
                }
            }

            CTextInput{
                id:fuseDiameterText
                anchors.left: fuseFiringRateText.left
                anchors.top: fuseFiringRateText.bottom
                anchors.topMargin: 15
                title: "直径(m):"
                pixelSize: 18
                titleWidth: pixelSize * 4
                width: parent.width/2 - 20
                height: 30
                onTextChanged: {
                    // if(text != "")
                    // {
                    // }
                    ammoData.fuse_diameter =text
                    console.log("Text content changed to: " + text)
                }
            }

            CTextInput{
                id:fuseSafeDistanceText
                anchors.left: fuseDiameterText.left
                anchors.top: fuseDiameterText.bottom
                anchors.topMargin: 15
                title: "安全距离(m):"
                pixelSize: 18
                titleWidth: pixelSize * 6
                width: parent.width/2 - 20
                height: 30
                onTextChanged: {
                    // if(text != "")
                    // {
                    // }
                    ammoData.safe_distance_of_fuse =text
                    console.log("Text content changed to: " + text)
                }
            }

            CTextInput{
                id:terminationInsuranceTimeText
                anchors.left: fuseSafeDistanceText.left
                anchors.top: fuseSafeDistanceText.bottom
                anchors.topMargin: 15
                title: "解除保险时间(s):"
                pixelSize: 18
                titleWidth: pixelSize * 8
                width: parent.width/2 - 20
                height: 30
                onTextChanged: {
                    // if(text != "")
                    // {
                    // }
                    ammoData.time_disarming_fuse =text
                    console.log("Text content changed to: " + text)
                }
            }

            CTextInput{
                id:fuseSecondaryLevelTerminationInsuranceTime
                anchors.left: terminationInsuranceTimeText.left
                anchors.top: terminationInsuranceTimeText.bottom
                anchors.topMargin: 15
                title: "二级解除保险时间(s):"
                pixelSize: 18
                titleWidth: pixelSize * 10
                width: parent.width/2 - 20
                height: 30
                onTextChanged: {
                    // if(text != "")
                    // {
                    // }
                    ammoData.secondary_release_time_of_fuse =text
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
                addAmmoComponentFuseRoot.visible = false
                addAmmoComponentFusePopup.close()
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
                addAmmoComponentFuseRoot.visible = false
                addAmmoComponentFusePopup.close()
            }
        }




    function saveAmmoFuseData(){

    }

    function updateAmmoFuseData() {

    }

}

