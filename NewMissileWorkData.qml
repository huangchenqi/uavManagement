import QtQuick 2.12
import QtQuick.Controls 2.12
import "qrc:/AddAmmoModules/Component"


Item {
    id:item_Missile
    width: 280
    height: 250
    //——————对外参数接口——————
    //工作条件
    property int workCondition: 0
    //气动布局
    property int aerodynamicConfiguration: 0
    Rectangle{
        anchors.fill: parent
        color:"#50000000"

        CText{
            id:text_Title
            text: "工作参数:"
            pixelSize: 25
            color: "#4EC4FF"
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.top: parent.top
            anchors.topMargin: 20
            horizontalAlignment: Text.AlignLeft
        }

        Rectangle{
            id:rect_data
            anchors.left: text_Title.left
            anchors.top: text_Title.bottom
            anchors.topMargin: 15
            anchors.right: parent.right
            anchors.rightMargin: 10
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 15
            border.width: 0
            border.color: mainColor
            color: "transparent"

            Rectangle {
                id: rect_WorkCondition
                height: 20
                color: "transparent"
                anchors.left: parent.left
                anchors.leftMargin: 5
                anchors.top: parent.top
                anchors.topMargin: 15
                width:( parent.width ) - 10

                CText{
                    id:text_WorkTemperatureTitle
                    width: pixelSize * 8.5
                    height: 20
                    anchors.left: rect_WorkCondition.left
                    anchors.top: rect_WorkCondition.bottom
                    anchors.topMargin: 20
                    pixelSize: 20
                    horizontalAlignment: Text.AlignLeft
                    color:mainColor
                    text:"工作环境温度(℃): "
                }
                Item{
                    width: parent.width - text_WorkTemperatureTitle.width - 5
                    height: parent.height
                    anchors.left:text_WorkTemperatureTitle.right
                    anchors.top: text_WorkTemperatureTitle.top
                    TextInput{
                        id:text_Input_WorkTemperature
                        anchors.fill: parent
                        color:"#ffffffff"
                        font.family:text_WorkTemperatureTitle.family
                        font.pixelSize:(18)
                        selectByMouse: true
                        selectionColor: "#ffcc8800"
                        onTextChanged: {
                            if(text != "")
                            {
                                //取值
                            }
                        }
                    }
                    Rectangle{
                        width: parent.width
                        height: (2)
                        anchors.left: parent.left
                        anchors.bottom: parent.bottom
                        color:mainColor
                    }
                }

                CText{
                    id:text_WorkAltitudeTitle
                    width: pixelSize * 8
                    height: 20
                    anchors.left: text_WorkTemperatureTitle.left
                    anchors.top: text_WorkTemperatureTitle.bottom
                    anchors.topMargin: 20
                    pixelSize: 20
                    horizontalAlignment: Text.AlignLeft
                    color:mainColor
                    text:"工作海拔高度(m): "
                }

                Item{
                    width: parent.width - text_WorkAltitudeTitle.width - 5
                    height: parent.height
                    anchors.left:text_WorkAltitudeTitle.right
                    anchors.top: text_WorkAltitudeTitle.top
                    TextInput{
                        id:text_Input_WorkAlt
                        anchors.fill: parent
                        color:"#ffffffff"
                        font.family:text_WorkAltitudeTitle.family
                        font.pixelSize:(18)
                        selectByMouse: true
                        selectionColor: "#ffcc8800"
                        onTextChanged: {
                            if(text != "")
                            {
                                //取值
                            }
                        }
                    }
                    Rectangle{
                        width: parent.width
                        height: (2)
                        anchors.left: parent.left
                        anchors.bottom: parent.bottom
                        color:mainColor
                    }
                }

                CText{
                    id:text_AerodynamicConfiguration
                    width: pixelSize * 4.5
                    height: parent.height
                    anchors.left: text_WorkAltitudeTitle.left
                    anchors.top: text_WorkAltitudeTitle.bottom
                    anchors.topMargin: 20
                    pixelSize: 20
                    horizontalAlignment: Text.AlignLeft
                    color:mainColor
                    text:"气动布局: "
                }

                ListView{
                    id:view_List_AerodynamicConfiguration
                    width: comp_AerodynamicConfiguration.width
                    height: comp_AerodynamicConfiguration.height * 5
                    anchors.left: comp_AerodynamicConfiguration.left
                    anchors.leftMargin: comp_AerodynamicConfiguration.width/2 - width/2
                    anchors.top: comp_AerodynamicConfiguration.bottom
                    anchors.topMargin: 2
                    visible: false
                    clip: true
                    model:ListModel{
                        id:listmodel_Box_AerodynamicConfiguration
                    }
                    delegate:Component{
                        Item{
                            id:item_Delegate
                            width: view_List_AerodynamicConfiguration.width
                            height: 36
                            CButton{
                                id:comp_TypeBtn
                                anchors.fill: parent
                                text:m_TypeName
                                color:"#ffddaa00"
                                borderColor: "#ffddaa00"
                                borderHigtColor: "#ffeebb22"
                                pixelSize: 18
                                onClicked: {
                                    view_List_AerodynamicConfiguration.visible = false
                                    aerodynamicConfiguration = index
                                    m_SelectState = !m_SelectState
                                }
                            }
                        }
                    }
                    Component.onCompleted: {
                        listmodel_Box_AerodynamicConfiguration.append({m_Number:0,m_SelectState:false,m_TypeName:"白天"})
                        listmodel_Box_AerodynamicConfiguration.append({m_Number:1,m_SelectState:false,m_TypeName:"夜晚"})
                    }
                }
                //显示区域
                CButton{
                    id:comp_AerodynamicConfiguration
                    width: parent.width - text_AerodynamicConfiguration.width
                    height: 36
                    color:"#ffddaa00"
                    borderColor: "#ffddaa00"
                    borderHigtColor: "#ffeebb22"
                    anchors.left: text_AerodynamicConfiguration.right
                    anchors.verticalCenter: text_AerodynamicConfiguration.verticalCenter
                    pixelSize: 20
                    text:{
                        if(aerodynamicConfiguration < 0)
                        {
                            return "白天"
                        }
                        else
                        {
                            if(listmodel_Box_AerodynamicConfiguration.count > 0)
                                listmodel_Box_AerodynamicConfiguration.get(aerodynamicConfiguration).m_TypeName
                        }
                    }
                    onClicked: {
                        view_List_AerodynamicConfiguration.visible = !view_List_AerodynamicConfiguration.visible
                    }
                }

                CText{
                    id:text_WorkConditionTitle
                    width: pixelSize * 4.5
                    height: parent.height
                    anchors.left: parent.left
                    anchors.top: parent.top
                    pixelSize: 20
                    horizontalAlignment: Text.AlignLeft
                    color:mainColor
                    text:"工作条件: "
                }

                ListView{
                    id:view_List_WorkCondition
                    width: comp_WorkFactorType.width
                    height: comp_WorkFactorType.height * 5
                    anchors.left: comp_WorkFactorType.left
                    anchors.leftMargin: comp_WorkFactorType.width/2 - width/2
                    anchors.top: comp_WorkFactorType.bottom
                    anchors.topMargin: 2
                    visible: false
                    clip: true
                    model:ListModel{
                        id:listmodel_Box
                    }
                    delegate:Component{
                        Item{
                            id:item_Delegate
                            width: view_List_WorkCondition.width
                            height: 36
                            CButton{
                                id:comp_TypeBtn
                                anchors.fill: parent
                                text:m_TypeName
                                color:"#ffddaa00"
                                borderColor: "#ffddaa00"
                                borderHigtColor: "#ffeebb22"
                                pixelSize: 18
                                onClicked: {
                                    view_List_WorkCondition.visible = false
                                    workCondition = index
                                    m_SelectState = !m_SelectState
                                }
                            }
                        }
                    }
                    Component.onCompleted: {
                        listmodel_Box.append({m_Number:0,m_SelectState:false,m_TypeName:"白天"})
                        listmodel_Box.append({m_Number:1,m_SelectState:false,m_TypeName:"夜晚"})
                    }
                }
                //显示区域
                CButton{
                    id:comp_WorkFactorType
                    width: parent.width - text_WorkConditionTitle.width
                    height: 36
                    color:"#ffddaa00"
                    borderColor: "#ffddaa00"
                    borderHigtColor: "#ffeebb22"
                    anchors.left: text_WorkConditionTitle.right
                    anchors.verticalCenter: text_WorkConditionTitle.verticalCenter
                    pixelSize: 20
                    text:{
                        if(workCondition < 0)
                        {
                            return "白天"
                        }
                        else
                        {
                            if(listmodel_Box.count > 0)
                                listmodel_Box.get(workCondition).m_TypeName
                        }
                    }
                    onClicked: {
                        view_List_WorkCondition.visible = !view_List_WorkCondition.visible
                    }
                }

            }
        }
    }
}
