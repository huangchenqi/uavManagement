import QtQuick 2.0
import "qrc:/"
import "qrc:/AddAmmoModules/Component"

//无源干扰吊舱
Item {
    id:custom_PassiveInterferencePod

    width: 1100
    height: 470

    //干扰波段
    property int iBand: 0
    //干扰强度
    property int iIntensity: 0

    property int iLaunchControlType: 0
    signal backPayloadRecord()
    Rectangle{
        id:rect_root
        anchors.fill: parent
        color:"#50000000"

        CText {
            id: title
            text: qsTr("无源干扰吊舱")
            pixelSize: 25
            width: pixelSize * 6
            color: "#4EC4FF"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 20
            horizontalAlignment: Text.AlignLeft
        }

        CTextInput{
            id:text_PodTotaloLength
            anchors.left: parent.left
            anchors.leftMargin: 20
            anchors.top: title.bottom
            anchors.topMargin: 30
            title: "吊舱总长度(mm):"
            pixelSize: 18
            titleWidth: pixelSize * 7.5
            width: 200
            height: 30
        }

        CTextInput{
            id:text_MainCarbinLength
            anchors.left: text_PodTotaloLength.left
            anchors.top: text_PodTotaloLength.bottom
            anchors.topMargin: 20
            title: "主舱长(mm):"
            pixelSize: 18
            titleWidth: pixelSize * 5.5
            width: 200
            height: 30
        }

        CTextInput{
            id:text_FrontHoodLength
            anchors.left: text_MainCarbinLength.left
            anchors.top: text_MainCarbinLength.bottom
            anchors.topMargin: 20
            title: "前罩长(mm):"
            pixelSize: 18
            titleWidth: pixelSize * 5.5
            width: 200
            height: 30
        }

        CTextInput{
            id:text_BackHoodLength
            anchors.left: text_FrontHoodLength.left
            anchors.top: text_FrontHoodLength.bottom
            anchors.topMargin: 20
            title: "后罩长(mm):"
            pixelSize: 18
            titleWidth: pixelSize * 5.5
            width: 200
            height: 30
        }

        CTextInput{
            id:text_MainCarbinSection
            anchors.left: text_PodTotaloLength.right
            anchors.leftMargin: 20
            anchors.top: text_PodTotaloLength.top
            title: "主舱截面(mm):"
            pixelSize: 18
            titleWidth: pixelSize * 6.5
            width: 200
            height: 30
        }

        CTextInput{
            id:text_SinglePodWeight
            anchors.left: text_MainCarbinSection.left
            anchors.top: text_MainCarbinSection.bottom
            anchors.topMargin: 20
            title: "单吊舱自重(Kg):"
            pixelSize: 18
            titleWidth: pixelSize * 7.5
            width: 200
            height: 30
        }

        CTextInput{
            id:text_LoadCapacity
            anchors.left: text_SinglePodWeight.left
            anchors.top: text_SinglePodWeight.bottom
            anchors.topMargin: 20
            title: "装载容量:"
            pixelSize: 18
            titleWidth: pixelSize * 4.5
            width: 200
            height: 30
        }

        CTextInput{
            id:text_SinglePodFullLoadWeight
            anchors.left: text_LoadCapacity.left
            anchors.top: text_LoadCapacity.bottom
            anchors.topMargin: 20
            title: "单吊舱满载最大重量(Kg):"
            pixelSize: 18
            titleWidth: pixelSize * 11.5
            width: 280
            height: 30
        }

        CText{
            id:text_InterferenceBand
            anchors.left: text_SinglePodFullLoadWeight.left
            anchors.top: text_SinglePodFullLoadWeight.bottom
            anchors.topMargin: 30
            text: "干扰波段:"
            pixelSize: 18
            color: mainColor
            width: pixelSize * 4.5
            height: pixelSize
            bold: true
        }

        CButton{
            id:btn_InterferenceBand
            width: 200
            height: 36
            color:"#ffddaa00"
            borderColor: "#ffddaa00"
            borderHigtColor: "#ffeebb22"
            anchors.left: text_InterferenceBand.right
            anchors.verticalCenter: text_InterferenceBand.verticalCenter
            pixelSize: 20
            text:{
                if(iBand < 0)
                {
                    return "波段1"
                }
                else
                {
                    if(listmodel_Box_Band.count > 0)
                        listmodel_Box_Band.get(iBand).m_TypeName
                }
            }
            onClicked: {
                view_List_Band.visible = !view_List_Band.visible
            }
        }

        CText{
            id:text_InterferenceIntensity
            anchors.left: text_InterferenceBand.left
            anchors.top: text_InterferenceBand.bottom
            anchors.topMargin: 30
            text: "干扰强度:"
            pixelSize: 18
            color: mainColor
            width: pixelSize * 4.5
            height: pixelSize
            bold: true
        }

        CButton{
            id:btn_InterferenceIntensity
            width: 200
            height: 36
            color:"#ffddaa00"
            borderColor: "#ffddaa00"
            borderHigtColor: "#ffeebb22"
            anchors.left: text_InterferenceIntensity.right
            anchors.verticalCenter: text_InterferenceIntensity.verticalCenter
            pixelSize: 20
            text:{
                if(iIntensity < 0)
                {
                    return "强度1"
                }
                else
                {
                    if(listmodel_Box_Intensity.count > 0)
                        listmodel_Box_Intensity.get(iIntensity).m_TypeName
                }
            }
            onClicked: {
                view_List_InterferenceIntensity.visible = !view_List_InterferenceIntensity.visible
            }
        }

        ListView{
            //干扰强度ListView  单选
            id:view_List_InterferenceIntensity
            width: btn_InterferenceIntensity.width
            height: btn_InterferenceIntensity.height * 5
            anchors.left: btn_InterferenceIntensity.left
            anchors.leftMargin: btn_InterferenceIntensity.width/2 - width/2
            anchors.top: btn_InterferenceIntensity.bottom
            anchors.topMargin: 2
            visible: false
            clip: true
            model:ListModel{
                id:listmodel_Box_Intensity
            }
            delegate:Component{
                Item{
                    id:item_Delegate
                    width: view_List_InterferenceIntensity.width
                    height: 36
                    CButton{
                        id:comp_TypeBtn
                        anchors.fill: parent
                        text:m_TypeName
                        color:"#ffddaa00"
                        borderColor: "#ffddaa00"
                        pixelSize: 18
                        onClicked: {
                            view_List_InterferenceIntensity.visible = false
                            iIntensity = index
                            m_SelectState = !m_SelectState
                        }
                    }
                }
            }
            Component.onCompleted: {
                listmodel_Box_Intensity.append({m_PlanNumber:0,m_SelectState:false,m_TypeName:"强度1"})
                listmodel_Box_Intensity.append({m_PlanNumber:1,m_SelectState:false,m_TypeName:"强度2"})
                listmodel_Box_Intensity.append({m_PlanNumber:2,m_SelectState:false,m_TypeName:"强度3"})
            }
        }

        ListView{
            //干扰波段ListView   多选
            id:view_List_Band
            width: btn_InterferenceBand.width
            height: btn_InterferenceBand.height * 5
            anchors.left: btn_InterferenceBand.left
            anchors.leftMargin: btn_InterferenceBand.width/2 - width/2
            anchors.top: btn_InterferenceBand.bottom
            anchors.topMargin: 2
            visible: false
            clip: true
            model:ListModel{
                id:listmodel_Box_Band
            }
            delegate:Component{
                Item{
                    id:item_Delegate
                    width: view_List_Band.width
                    height: 36
                    CButton{
                        id:comp_TypeBtn
                        anchors.fill: parent
                        text:m_TypeName
                        color:"#ffddaa00"
                        borderColor: "#ffddaa00"
                        pixelSize: 18
                        onClicked: {
                            view_List_Band.visible = false
                            iBand = index
                            m_SelectState = !m_SelectState
                            isSelect = m_SelectState
                        }
                    }
                }
            }
            Component.onCompleted: {
                listmodel_Box_Band.append({m_PlanNumber:0,m_SelectState:false,m_TypeName:"波段1"})
                listmodel_Box_Band.append({m_PlanNumber:1,m_SelectState:false,m_TypeName:"波段2"})
                listmodel_Box_Band.append({m_PlanNumber:2,m_SelectState:false,m_TypeName:"波段3"})
            }
        }

        CButton{
            id:btn_EffectiveReflectionArea
            width: 200
            height: 36
            color:"#ffddaa00"
            borderColor: "#ffddaa00"
            borderHigtColor: "#ffeebb22"
            anchors.left: text_BackHoodLength.left
            anchors.top: text_BackHoodLength.bottom
            anchors.topMargin: 20
            pixelSize: 20
            text: "有效反射面积"
            onClicked: {
                //弹出窗口
            }
        }

        CButton{
            id:btn_LaunchSpeed
            width: 200
            height: 36
            color:"#ffddaa00"
            borderColor: "#ffddaa00"
            borderHigtColor: "#ffeebb22"
            anchors.left: btn_EffectiveReflectionArea.left
            anchors.top: btn_EffectiveReflectionArea.bottom
            anchors.topMargin: 20
            pixelSize: 20
            text: "投放速度"
            onClicked: {
                //弹出窗口
            }
        }

        CText{
            id:text_LaunchControlType
            anchors.left: btn_LaunchSpeed.left
            anchors.top: btn_LaunchSpeed.bottom
            anchors.topMargin: 30
            text: "投放控制方式:"
            pixelSize: 18
            color: mainColor
            width: pixelSize * 6.5
            height: pixelSize
            bold: true
        }

        CButton{
            id:btn_LaunchControlType
            width: 150
            height: 36
            color:"#ffddaa00"
            borderColor: "#ffddaa00"
            borderHigtColor: "#ffeebb22"
            anchors.left: text_LaunchControlType.right
            anchors.verticalCenter: text_LaunchControlType.verticalCenter
            pixelSize: 20
            text:{
                if(iLaunchControlType < 0)
                {
                    return "方式1"
                }
                else
                {
                    if(listmodel_Box_LaunchControlType.count > 0)
                        listmodel_Box_LaunchControlType.get(iLaunchControlType).m_TypeName
                }
            }
            onClicked: {
                view_List_LaunchControlType.visible = !view_List_LaunchControlType.visible
            }
        }

        ListView{
            //投放控制方式ListView  多选
            id:view_List_LaunchControlType
            width: btn_LaunchControlType.width
            height: btn_LaunchControlType.height * 5
            anchors.left: btn_LaunchControlType.left
            anchors.leftMargin: btn_LaunchControlType.width/2 - width/2
            anchors.top: btn_LaunchControlType.bottom
            anchors.topMargin: 2
            visible: false
            clip: true
            model:ListModel{
                id:listmodel_Box_LaunchControlType
            }
            delegate:Component{
                Item{
                    id:item_Delegate
                    width: view_List_LaunchControlType.width
                    height: 36
                    CButton{
                        id:comp_TypeBtn
                        anchors.fill: parent
                        text:m_TypeName
                        color:"#ffddaa00"
                        borderColor: "#ffddaa00"
                        pixelSize: 18
                        onClicked: {
                            view_List_LaunchControlType.visible = false
                            iLaunchControlType = index
                            m_SelectState = !m_SelectState
                            isSelect = m_SelectState
                        }
                    }
                }
            }
            Component.onCompleted: {
                listmodel_Box_LaunchControlType.append({m_PlanNumber:0,m_SelectState:false,m_TypeName:"方式1"})
                listmodel_Box_LaunchControlType.append({m_PlanNumber:1,m_SelectState:false,m_TypeName:"方式2"})
                listmodel_Box_LaunchControlType.append({m_PlanNumber:2,m_SelectState:false,m_TypeName:"方式3"})
            }
        }

        Rectangle {
            id: rect_ImageShow
            visible: true
            width:520
            anchors.right: parent.right
            anchors.rightMargin: 10
            anchors.top: title.bottom
            anchors.topMargin: 20
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 20
            color: "transparent"

            Rectangle{
                id:rect_Image
                width: parent.width
                anchors.bottom: btn_Cancel.top
                anchors.bottomMargin: 10
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.right: parent.right
                color: "#ECF2FE"
                Image {
                    id: ammunitionImg
                    anchors.fill: parent
                }
                CText {
                    anchors.centerIn: parent
                    text: "图片展示区域"
                    color: "#9E9E9E"
                }
            }

            CButton{
                id:btn_Cancel
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 5
                anchors.right: parent.right
                anchors.rightMargin: 5
                height: pixelSize * 2
                width: pixelSize * 4
                pixelSize: 20
                text: "取消"
                onClicked: {
                    backPayloadRecord()
                    custom_PassiveInterferencePod.visible = false
                }
            }

            CButton{
                id:btn_Save
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 5
                anchors.right: btn_Cancel.left
                anchors.rightMargin: 10
                height: pixelSize * 2
                width: pixelSize * 4
                pixelSize: 20
                text: "保存"
                onClicked: {
                    backPayloadRecord()
                    custom_PassiveInterferencePod.visible = false
                }
            }
        }
    }
}
