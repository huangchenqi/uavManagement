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
    property int loadDataType: 0
    //title: qsTr("QML TableView example")
    onLoadDataTypeChanged: {
        if(addAmmoComponentSeekerRoot.loadDataType === 1){
            allComponentEnable()
            loadAmmoData()
        }else if(addAmmoComponentSeekerRoot.loadDataType === 2){
            loadAmmoData()
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
                    ammoData.guiding_head_working_wavelength = textToFloat(text)
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
                    ammoData.guidance_head_operating_distance = textToFloat(text)
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
                    ammoData.guidance_head_frame_angle = textToFloat(text)
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
                    ammoData.guidance_head_field_of_view_angle_linearregion = textToFloat(text)
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
                    ammoData.guidance_head_operating_frequency = textToFloat(text)
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
                    ammoData.blind_spot_of_guidance_head = textToFloat(text)
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
                    ammoData.adaptability_of_guidance_head_sunlight = text
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
                    ammoData.guidance_head_field_of_view_angle_instantaneous = textToFloat(text)
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
                cancelAmmunitionData()
                addAmmoComponentSeekerPopup.close()
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
        seekerWorkingWavelengthText.enabled = false
        //#pragma db not_null column("guidance_head_operating_distance")  //guidance_head_operating_distance REAL NOT NULL ,--COMMENT '导引头作用距离',
        seekerEffectDistanceText.enabled =    false
        //#pragma db not_null column("blind_spot_of_guidance_head")  //blind_spot_of_guidance_head REAL NOT NULL ,--COMMENT '导引头盲区',
        seekerBlindAreaText.enabled  =  false
        //#pragma db not_null column("guidance_head_frame_angle")  //guidance_head_frame_angle REAL NOT NULL ,--COMMENT '导引头框架角',
        seekerFrameAngleText.enabled  =   false
        //#pragma db not_null column("guidance_head_field_of_view_angle")  //guidance_head_field_of_view_angle REAL NOT NULL ,--COMMENT '导引头视场角',
        //    newAmmoData.ammoSelectData.guidance_head_field_of_view_angle   = 0.0
        seekerViewingAngleLinearRegionText.enabled  =   false
        seekerViewingAngleIFOVText.enabled  =  false


        //#pragma db not_null column("adaptability_of_guidance_head_sunlight")  //adaptability_of_guidance_head_sunlight VARCHAR(50) ,--COMMENT '导引头对太阳光的适应性',
        seekerAdaptabilityToSunlightText.enabled  =   false
        //#pragma db not_null column("guidance_head_operating_frequency")  //guidance_head_operating_frequency REAL NOT NULL ,--COMMENT '导引头工作频率',
         seekerOperatingFrequencyText.enabled =   false
    }

    function loadAmmoData(){
        console.log("addAmmoSeeker"+newAmmoData.ammoSelectData.guiding_head_working_wavelength)
        //#pragma db not_null column("guiding_head_working_wavelength")  //guiding_head_working_wavelength REAL NOT NULL ,--COMMENT '导引头工作波长(激光波长) (laser wavelength)',
        seekerWorkingWavelengthText.text = newAmmoData.ammoSelectData.guiding_head_working_wavelength
        //#pragma db not_null column("guidance_head_operating_distance")  //guidance_head_operating_distance REAL NOT NULL ,--COMMENT '导引头作用距离',
        seekerEffectDistanceText.text =    newAmmoData.ammoSelectData.guidance_head_operating_distance
        //#pragma db not_null column("blind_spot_of_guidance_head")  //blind_spot_of_guidance_head REAL NOT NULL ,--COMMENT '导引头盲区',
        seekerBlindAreaText.text  =   newAmmoData.ammoSelectData.blind_spot_of_guidance_head
        //#pragma db not_null column("guidance_head_frame_angle")  //guidance_head_frame_angle REAL NOT NULL ,--COMMENT '导引头框架角',
        seekerFrameAngleText.text  =   newAmmoData.ammoSelectData.guidance_head_frame_angle
        //#pragma db not_null column("guidance_head_field_of_view_angle")  //guidance_head_field_of_view_angle REAL NOT NULL ,--COMMENT '导引头视场角',
        //    newAmmoData.ammoSelectData.guidance_head_field_of_view_angle   = 0.0
        seekerViewingAngleLinearRegionText.text  =   newAmmoData.ammoSelectData.guidance_head_field_of_view_angle_linearregion    //线性区
        seekerViewingAngleIFOVText.text  =   newAmmoData.ammoSelectData.guidance_head_field_of_view_angle_instantaneous    //瞬时区
        //#pragma db not_null column("adaptability_of_guidance_head_sunlight")  //adaptability_of_guidance_head_sunlight VARCHAR(50) ,--COMMENT '导引头对太阳光的适应性',
        seekerAdaptabilityToSunlightText.text  =   newAmmoData.ammoSelectData.adaptability_of_guidance_head_sunlight
        //#pragma db not_null column("guidance_head_operating_frequency")  //guidance_head_operating_frequency REAL NOT NULL ,--COMMENT '导引头工作频率',
         seekerOperatingFrequencyText.text =   newAmmoData.ammoSelectData.guidance_head_operating_frequency

        newAmmoData.ammoData.guiding_head_working_wavelength = textToFloat(newAmmoData.ammoSelectData.guiding_head_working_wavelength)
        //#pragma db not_null column("guidance_head_operating_distance")  //guidance_head_operating_distance REAL NOT NULL ,--COMMENT '导引头作用距离',
        newAmmoData.ammoData.guidance_head_operating_distance =    textToFloat(newAmmoData.ammoSelectData.guidance_head_operating_distance)
        //#pragma db not_null column("blind_spot_of_guidance_head")  //blind_spot_of_guidance_head REAL NOT NULL ,--COMMENT '导引头盲区',
        newAmmoData.ammoData.blind_spot_of_guidance_head  =   textToFloat(newAmmoData.ammoSelectData.blind_spot_of_guidance_head)
        //#pragma db not_null column("guidance_head_frame_angle")  //guidance_head_frame_angle REAL NOT NULL ,--COMMENT '导引头框架角',
        newAmmoData.ammoData.guidance_head_frame_angle  =   textToFloat(newAmmoData.ammoSelectData.guidance_head_frame_angle)
        //#pragma db not_null column("guidance_head_field_of_view_angle")  //guidance_head_field_of_view_angle REAL NOT NULL ,--COMMENT '导引头视场角',
        //    newAmmoData.ammoSelectData.guidance_head_field_of_view_angle   = 0.0
        newAmmoData.ammoData.guidance_head_field_of_view_angle_linearregion  =   textToFloat(newAmmoData.ammoSelectData.guidance_head_field_of_view_angle_linearregion)    //线性区
        newAmmoData.ammoData.guidance_head_field_of_view_angle_instantaneous  =   textToFloat(newAmmoData.ammoSelectData.guidance_head_field_of_view_angle_instantaneous)    //瞬时区
        //#pragma db not_null column("adaptability_of_guidance_head_sunlight")  //adaptability_of_guidance_head_sunlight VARCHAR(50) ,--COMMENT '导引头对太阳光的适应性',
        newAmmoData.ammoData.adaptability_of_guidance_head_sunlight  =   newAmmoData.ammoSelectData.adaptability_of_guidance_head_sunlight
        //#pragma db not_null column("guidance_head_operating_frequency")  //guidance_head_operating_frequency REAL NOT NULL ,--COMMENT '导引头工作频率',
        newAmmoData.ammoData.guidance_head_operating_frequency =   textToFloat(newAmmoData.ammoSelectData.guidance_head_operating_frequency)

    }

    function cancelAmmunitionData(){
        seekerWorkingWavelengthText.text = ""
        //#pragma db not_null column("guidance_head_operating_distance")  //guidance_head_operating_distance REAL NOT NULL ,--COMMENT '导引头作用距离',
        seekerEffectDistanceText.text =    ""
        //#pragma db not_null column("blind_spot_of_guidance_head")  //blind_spot_of_guidance_head REAL NOT NULL ,--COMMENT '导引头盲区',
        seekerBlindAreaText.text  =  ""
        //#pragma db not_null column("guidance_head_frame_angle")  //guidance_head_frame_angle REAL NOT NULL ,--COMMENT '导引头框架角',
        seekerFrameAngleText.text  =   ""
        //#pragma db not_null column("guidance_head_field_of_view_angle")  //guidance_head_field_of_view_angle REAL NOT NULL ,--COMMENT '导引头视场角',
        //    newAmmoData.ammoSelectData.guidance_head_field_of_view_angle   = 0.0
        seekerViewingAngleLinearRegionText.text  =   ""
        seekerViewingAngleIFOVText.text  =  ""


        //#pragma db not_null column("adaptability_of_guidance_head_sunlight")  //adaptability_of_guidance_head_sunlight VARCHAR(50) ,--COMMENT '导引头对太阳光的适应性',
        seekerAdaptabilityToSunlightText.text  =   ""
        //#pragma db not_null column("guidance_head_operating_frequency")  //guidance_head_operating_frequency REAL NOT NULL ,--COMMENT '导引头工作频率',
         seekerOperatingFrequencyText.text =   ""
    }


}

