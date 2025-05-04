import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtQuick.Window 2.12
import QtQuick.Dialogs 1.2
import "qrc:/"
import "qrc:/AddAmmoModules/Component"

Rectangle{//航空弹药的组件发射条件
    id:addAmmoComponentLaunchconditionsRoot
    visible: true
    width: 600
    height: 340
    color:"skyblue"
    //title: qsTr("QML TableView example")
    property int loadDataType: 0
    onLoadDataTypeChanged: {
        if(addAmmoComponentLaunchconditionsRoot.loadDataType === 1){
            allComponentEnable()
            loadData()
        }else if(addAmmoComponentLaunchconditionsRoot.loadDataType === 2){
            loadData()
        }else{
            console.log("Unknown loadDataType!")
        }
    }

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

            CText{
                id:topTitle

                anchors.top: parent.top
                anchors.topMargin: 15
                anchors.left: rect_DataTitle.right
                anchors.leftMargin: 2
                anchors.horizontalCenter: parent.horizontalCenter
                color: mainColor
                text: "发射条件"
                pixelSize: 28
                width: parent.width/2 - 20
                height: 30
            }
        }

        Rectangle{
            id:rect_Data
            anchors.top: rect_DataTitle.bottom
            anchors.topMargin: 20
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.right: parent.right
            anchors.rightMargin: 10
            height: 300
            color: "transparent"
            radius: 5

            CTextInput{
                id:launchMinimumVisibilityText
                anchors.left: parent.left
                anchors.leftMargin: 5
                anchors.top: parent.top
                anchors.topMargin: 5
                title: "最小能见度:"
                pixelSize: 18
                titleWidth: pixelSize * 6
                width: parent.width/2 - 20
                height: 30
                onTextChanged: {
                    ammoData.minimum_visibility_emission = textToFloat(text)
                    console.log("Text content changed to: " + text)
                }
            }

            CTextInput{
                id:launchMaximumTargetAltitudeText
                anchors.left: launchMinimumVisibilityText.left
                anchors.top: launchMinimumVisibilityText.bottom
                anchors.topMargin: 15
                title: "最大目标海拔高度(Km):"
                pixelSize: 18
                titleWidth: pixelSize * 10.5
                width: parent.width/2 - 20
                height: 30
                onTextChanged: {
                    ammoData.launch_maximum_target_altitude = textToFloat(text)
                    console.log("Text content changed to: " + text)
                }
            }

            CTextInput{
                id:launchMinimumRelativeHeightText
                anchors.left: launchMaximumTargetAltitudeText.left
                anchors.top: launchMaximumTargetAltitudeText.bottom
                anchors.topMargin: 15
                title: "最小发射相对高度(m):"
                pixelSize: 18
                titleWidth: pixelSize * 10
                width: parent.width/2 - 20
                height: 30
                onTextChanged: {
                    ammoData.minimum_relative_height_launch = textToFloat(text)
                    console.log("Text content changed to: " + text)
                }
            }

            CTextInput{
                id:weatherRestrictionsText
                anchors.left: launchMinimumRelativeHeightText.left
                anchors.top: launchMinimumRelativeHeightText.bottom
                anchors.topMargin: 15
                title: "天气限制:"
                pixelSize: 18
                onlyNum: false
                titleWidth: pixelSize * 4.5
                width: parent.width/2 - 20
                height: 30
                onTextChanged: {
                    ammoData.launch_conditions = text
                    console.log("Text content changed to: " + text)
                }
            }

            CTextInput{
                id:launchMaximumAltitudeText
                anchors.left: launchMinimumVisibilityText.right
                anchors.leftMargin: 15
                anchors.top: launchMinimumVisibilityText.top
                title: "最大发射海拔高度(Km):"
                pixelSize: 18
                titleWidth: pixelSize * 10.5
                width: parent.width/2 - 20
                height: 30
                onTextChanged: {
                    ammoData.maximum_launch_altitude = textToFloat(text)
                    console.log("Text content changed to: " + text)
                }
            }

            CTextInput{
                id:launchMaximumRelativeHeightText
                anchors.left: launchMaximumAltitudeText.left
                anchors.top: launchMaximumAltitudeText.bottom
                anchors.topMargin: 15
                title: "最大发射相对高度(Km):"
                pixelSize: 18
                titleWidth: pixelSize * 10.5
                width: parent.width/2 - 20
                height: 30
                onTextChanged: {
                    ammoData.maximum_launch_relative_height = textToFloat(text)
                    console.log("Text content changed to: " + text)
                }
            }

            CTextInput{
                id:launchSpeedText
                anchors.left: launchMaximumRelativeHeightText.left
                anchors.top: launchMaximumRelativeHeightText.bottom
                anchors.topMargin: 15
                title: "发射速度(Km/h):"
                pixelSize: 18
                titleWidth: pixelSize * 7.5
                width: parent.width/2 - 20
                height: 30
                onTextChanged: {
                    ammoData.launch_speed = textToFloat(text)
                    console.log("Text content changed to: " + text)
                }
            }

            CTextInput{
                id:launchOffAxisAngleText
                anchors.left: launchSpeedText.left
                anchors.top: launchSpeedText.bottom
                anchors.topMargin: 15
                title: "发射离轴角(°):"
                pixelSize: 18
                titleWidth: pixelSize * 7
                width: parent.width/2 - 20
                height: 30
                onTextChanged: {
                    ammoData.launch_off_axis_angle = textToFloat(text)
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
                //addAmmoComponentLaunchconditionsRoot.visible = false
                addAmmoComponentLaunchconditionsPopup.close()
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
                //addAmmoComponentLaunchconditionsRoot.visible = false
                addAmmoComponentLaunchconditionsPopup.close()
            }
        }
    }
    function textToFloat(data){
        console.log("textToFloatdata"+data)
        // 检查是否以小数点结尾
        if (data.endsWith(".")) {
            data = data.slice(0, -1); // 去掉小数点
        }
        console.log("textToFloatdata"+data)
        // 将文本转换为浮点数
        var num = parseFloat(data);
        if (!isNaN(num)) {

            return num; // 有效时赋值
        } else {
            // 无效时恢复原值（可选）
            num = 0.00
            return num;
        }
    }

    function allComponentEnable(){
        launchMinimumVisibilityText.enabled =  false
        //#pragma db not_null column("maximum_launch_altitude") //maximum_launch_altitude REAL NOT NULL ,--COMMENT '发射最大发射海拔高度',
         launchMaximumAltitudeText.enabled  =  false
        //#pragma db not_null column("launch_maximum_target_altitude") //launch_maximum_target_altitude REAL NOT NULL ,--COMMENT '发射最大目标海拔高度',
        launchMaximumTargetAltitudeText.enabled   =  false
        //#pragma db not_null column("maximum_launch_relative_height") //maximum_launch_relative_height REAL NOT NULL ,--COMMENT '发射最大发射相对高度',
        launchMaximumRelativeHeightText.enabled  =  false
        //#pragma db not_null column("minimum_relative_height_launch")  //minimum_relative_height_launch REAL NOT NULL ,--COMMENT '发射最小发射相对高度',
        launchMinimumRelativeHeightText.enabled  =   false
        //#pragma db not_null column("launch_speed") //launch_speed REAL NOT NULL ,--COMMENT '发射速度',
        launchSpeedText.enabled  =   false
        //#pragma db not_null column("launch_conditions") //launch_conditions VARCHAR(50) ,--COMMENT '发射条件天气限制',
        weatherRestrictionsText.enabled  =  false
        //#pragma db not_null column("launch_off_axis_angle") //launch_off_axis_angle REAL NOT NULL ,--COMMENT '发射离轴角',
        launchOffAxisAngleText.enabled  =   false
    }

    function loadData() {


        //#pragma db not_null column("guidance_rule")  //guidance_rule VARCHAR(50) ,--COMMENT '导引规律',
           // newAmmoData.ammoSelectData.guidance_rule   = ""
        //#pragma db not_null column("minimum_visibility_emission") //minimum_visibility_emission REAL NOT NULL ,--COMMENT '发射最小能见度',
        launchMinimumVisibilityText.text =  newAmmoData.ammoSelectData.minimum_visibility_emission
        //#pragma db not_null column("maximum_launch_altitude") //maximum_launch_altitude REAL NOT NULL ,--COMMENT '发射最大发射海拔高度',
         launchMaximumAltitudeText.text  =  newAmmoData.ammoSelectData.maximum_launch_altitude
        //#pragma db not_null column("launch_maximum_target_altitude") //launch_maximum_target_altitude REAL NOT NULL ,--COMMENT '发射最大目标海拔高度',
        launchMaximumTargetAltitudeText.text   =  newAmmoData.ammoSelectData.launch_maximum_target_altitude
        //#pragma db not_null column("maximum_launch_relative_height") //maximum_launch_relative_height REAL NOT NULL ,--COMMENT '发射最大发射相对高度',
        launchMaximumRelativeHeightText.text  =  newAmmoData.ammoSelectData.maximum_launch_relative_height
        //#pragma db not_null column("minimum_relative_height_launch")  //minimum_relative_height_launch REAL NOT NULL ,--COMMENT '发射最小发射相对高度',
        launchMinimumRelativeHeightText.text  =   newAmmoData.ammoSelectData.minimum_relative_height_launch
        //#pragma db not_null column("launch_speed") //launch_speed REAL NOT NULL ,--COMMENT '发射速度',
        launchSpeedText.text  =   newAmmoData.ammoSelectData.launch_speed
        //#pragma db not_null column("launch_conditions") //launch_conditions VARCHAR(50) ,--COMMENT '发射条件天气限制',
        weatherRestrictionsText.text  =  newAmmoData.ammoSelectData.launch_conditions
        //#pragma db not_null column("launch_off_axis_angle") //launch_off_axis_angle REAL NOT NULL ,--COMMENT '发射离轴角',
        launchOffAxisAngleText.text  =   newAmmoData.ammoSelectData.launch_off_axis_angle


    }


}

