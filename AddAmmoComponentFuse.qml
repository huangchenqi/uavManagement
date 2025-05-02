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
    color:"skyblue"
    property int loadDataType: 0
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
    onLoadDataTypeChanged:{
        if(addAmmoComponentFuseRoot.loadDataType === 1){
            allComponemntEnable()
            loadAmmoData()
        }else if(addAmmoComponentFuseRoot.loadDataType === 2){
            loadAmmoData()
        }else{
            console.log("Unkown loadDataType! ")
        }
    }

    Rectangle{
        id:rect_root
        anchors.fill: parent
        color: "transparent"

        CText{
            id:topTitle
            text: "引信"
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
                id:fuseTypeText
                anchors.left: parent.left
                anchors.leftMargin: 5
                anchors.top: parent.top
                anchors.topMargin: 5
                title: "引信类型:"
                pixelSize: 18
                onlyNum: false
                titleWidth: pixelSize * 4.5
                width: parent.width/2 - 20
                height: 30
                onTextChanged: {
                    ammoData.fuse_type =text
                    console.log("Text content changed to: " + text)
                }
            }

            CTextInput{
                id:fuseLengthText
                anchors.left: fuseTypeText.left
                anchors.top: fuseTypeText.bottom
                anchors.topMargin: 15
                title: "长度(m):"
                pixelSize: 18
                titleWidth: pixelSize * 4
                width: parent.width/2 - 20
                height: 30
                onTextChanged: {
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
                addAmmoComponentFusePopup.close()
                //addAmmoComponentFuseRoot.visible = false
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
                addAmmoComponentFusePopup.close()//addAmmoComponentFuseRoot.visible = false
            }
        }
    }
    function allComponemntEnable(){
        //#pragma db not_null column("fuse_firing_rate") //fuse_firing_rate REAL NOT NULL ,--COMMENT '引信发火率',
        fuseFiringRateText.enabled = false
        //#pragma db not_null column("fuse_type") //fuse_type VARCHAR(50) ,--COMMENT '引信类型',
         fuseTypeText.enabled = false
        //#pragma db not_null column("fuse_length") //fuse_length REAL NOT NULL ,--COMMENT '引信长度',
        fuseLengthText.enabled = false
        //#pragma db not_null column("fuse_diameter")  //fuse_diameter REAL NOT NULL ,--COMMENT '引信直径',
        fuseDiameterText.enabled = false
        //#pragma db not_null column("fuze_quality")  //fuze_quality REAL NOT NULL ,--COMMENT '引信质量',
        fuseWeightText.enabled = false
        //#pragma db not_null column("safe_distance_of_fuse")  //safe_distance_of_fuse REAL NOT NULL ,--COMMENT '引信安全距离',
        fuseSafeDistanceText.enabled = false
        //#pragma db not_null column("time_disarming_fuse")  //time_disarming_fuse REAL NOT NULL ,--COMMENT '引信解除保险时间',
        terminationInsuranceTimeText.enabled = false
        //#pragma db not_null column("first_level_release_time_of_fuse")  //first_level_release_time_of_fuse REAL NOT NULL ,--COMMENT '引信一级解除保险时间',
         fuseFirstLevelTerminationInsuranceTimeText.enabled = false
        //#pragma db not_null column("secondary_release_time_of_fuse")  //secondary_release_time_of_fuse REAL NOT NULL ,--COMMENT '引信二级解除保险时间',
        fuseSecondaryLevelTerminationInsuranceTime.enabled = false
        //#pragma db not_null column("reliability_rate_of_fuse_action")  //reliability_rate_of_fuse_action REAL NOT NULL ,--COMMENT '引信作用可靠率',
        fuseActionReliabilityRateText.enabled = false
        //#pragma db not_null column("fuse_self_destruct_time")  //fuse_self_destruct_time REAL NOT NULL ,--COMMENT '引信自毁时间',

        fuseSelfDestructionTimeText.enabled = false
    }

    function loadAmmoData(){
        console.log("loadAmmoData()"+newAmmoData.ammoSelectData.fuse_firing_rate)
        //#pragma db not_null column("fuse_firing_rate") //fuse_firing_rate REAL NOT NULL ,--COMMENT '引信发火率',
        fuseFiringRateText.text   = newAmmoData.ammoSelectData.fuse_firing_rate
        //#pragma db not_null column("fuse_type") //fuse_type VARCHAR(50) ,--COMMENT '引信类型',
         fuseTypeText.text =   newAmmoData.ammoSelectData.fuse_type
        //#pragma db not_null column("fuse_length") //fuse_length REAL NOT NULL ,--COMMENT '引信长度',
        fuseLengthText.text  =  newAmmoData.ammoSelectData.fuse_length
        //#pragma db not_null column("fuse_diameter")  //fuse_diameter REAL NOT NULL ,--COMMENT '引信直径',
        fuseDiameterText.text  =   newAmmoData.ammoSelectData.fuse_diameter
        //#pragma db not_null column("fuze_quality")  //fuze_quality REAL NOT NULL ,--COMMENT '引信质量',
        fuseWeightText.text  =  newAmmoData.ammoSelectData.fuze_quality
        //#pragma db not_null column("safe_distance_of_fuse")  //safe_distance_of_fuse REAL NOT NULL ,--COMMENT '引信安全距离',
        fuseSafeDistanceText.text  =  newAmmoData.ammoSelectData.safe_distance_of_fuse
        //#pragma db not_null column("time_disarming_fuse")  //time_disarming_fuse REAL NOT NULL ,--COMMENT '引信解除保险时间',
        terminationInsuranceTimeText.text   =    newAmmoData.ammoSelectData.time_disarming_fuse
        //#pragma db not_null column("first_level_release_time_of_fuse")  //first_level_release_time_of_fuse REAL NOT NULL ,--COMMENT '引信一级解除保险时间',
         fuseFirstLevelTerminationInsuranceTimeText.text =   newAmmoData.ammoSelectData.first_level_release_time_of_fuse
        //#pragma db not_null column("secondary_release_time_of_fuse")  //secondary_release_time_of_fuse REAL NOT NULL ,--COMMENT '引信二级解除保险时间',
        fuseSecondaryLevelTerminationInsuranceTime.text   =   newAmmoData.ammoSelectData.secondary_release_time_of_fuse
        //#pragma db not_null column("reliability_rate_of_fuse_action")  //reliability_rate_of_fuse_action REAL NOT NULL ,--COMMENT '引信作用可靠率',
        fuseActionReliabilityRateText.text  =   newAmmoData.ammoSelectData.reliability_rate_of_fuse_action
        //#pragma db not_null column("fuse_self_destruct_time")  //fuse_self_destruct_time REAL NOT NULL ,--COMMENT '引信自毁时间',

        fuseSelfDestructionTimeText.text  =  newAmmoData.ammoSelectData.fuse_self_destruct_time


    }

    function saveammunitionData(){


    }
}

