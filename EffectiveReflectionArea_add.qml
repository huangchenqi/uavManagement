import QtQuick 2.0
import QtQuick.Controls 2.14
import QtQuick.Window 2.12

import "qrc:/"
import "qrc:/AddAmmoModules/Component"
import "qrc:/AddAmmoModules"

Item {
    id:custom_EffectiveReflectionArea
    width: 1000
    height: 500

    Image {
        id: backGround
        source: mainBackgroundSource
        anchors.fill: parent
    }

    Rectangle{
        id:rect_Root
        anchors.fill: parent
        color: "#50000000"

        Rectangle{
            id:rect_DataShow
            color: "transparent"
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: btn_Add.top
            anchors.bottomMargin: 10

            Rectangle{
                id:rect_Title
                anchors.top: parent.top
                anchors.left: parent.left
                width: parent.width
                color: "#1D0D0E"
                height: 50
                border.color: mainColor

                Rectangle{
                    id:rect_NumTitle
                    border.width: 1
                    border.color: mainColor
                    width: 50
                    color: "transparent"
                    height: parent.height
                    CText{
                        id:text_NumTitle
                        text: "序号"
                        color: mainColor
                        pixelSize: 18
                        anchors.centerIn: parent
                        anchors.verticalCenter: parent.verticalCenter
                        horizontalAlignment: Text.AlignHCenter
                    }
                }

                Rectangle{
                    id:rect_MinTitle
                    height: parent.height
                    border.width: 1
                    border.color: mainColor
                    width: 200
                    color: "transparent"
                    anchors.left: rect_NumTitle.right
                    CText{
                        id:text_MinTitle
                        pixelSize: 18
                        anchors.centerIn: parent
                        horizontalAlignment: Text.AlignHCenter
                        width: parent.width / 5
                        color: mainColor
                        text: "最小有效反射功率(GHz)"
                    }
                }

                Rectangle{
                    id:rect_MaxTitle
                    height: parent.height
                    border.width: 1
                    border.color: mainColor
                    width: 200
                    color: "transparent"
                    anchors.left: rect_MinTitle.right
                    CText{
                        id:text_Maxitle
                        pixelSize: 18
                        anchors.centerIn: parent
                        horizontalAlignment: Text.AlignHCenter
                        color: mainColor
                        text: "最大有效反射功率(GHz)"
                    }
                }

                Rectangle{
                    id:rect_AreaTitle
                    height: parent.height
                    border.width: 1
                    border.color: mainColor
                    width: 200
                    color: "transparent"
                    anchors.left: rect_MaxTitle.right
                    CText{
                        pixelSize: 18
                        anchors.centerIn: parent
                        horizontalAlignment: Text.AlignHCenter
                        color: mainColor
                        text: "有效反射面积(m²/盒)"
                    }
                }

                Rectangle{
                    id:rect_Describe
                    height: parent.height
                    border.width: 1
                    border.color: mainColor
                    width: parent.width - rect_MaxTitle.width - rect_MinTitle.width- rect_AreaTitle.width - rect_NumTitle.width
                    color: "transparent"
                    anchors.left: rect_AreaTitle.right
                    CText{
                        id:text_Describe
                        pixelSize: 18
                        anchors.centerIn: parent
                        horizontalAlignment: Text.AlignHCenter
                        text: "用途"
                        color: mainColor
                    }
                }
            }

            ListView{
                id:listView_DataShow
                anchors.top: rect_Title.bottom
                anchors.left: parent.left
                width: parent.width
                height: parent.height - rect_Title.height
                visible: true
                clip: true

                model:ListModel{
                    id:listmodel_
                }
                delegate: Component{
                    Item {
                        id:item_Delegate
                        width: listView_DataShow.width
                        height: 50

                        Rectangle{
                            id:rect_Data
                            anchors.fill: parent
                            color: "transparent"
                            border.color: m_SelectState ? "red" : mainColor
                            border.width: m_SelectState ? 3 : 1
                            Rectangle{
                                id:rect_Num
                                border.width: 1
                                border.color: m_SelectState ? "red" : mainColor
                                width: 50
                                color: "transparent"
                                height: parent.height
                                CText{
                                    id:text_Num
                                    text: index + 1
                                    pixelSize: 18
                                    color: mainColor
                                    anchors.fill: parent
                                    horizontalAlignment: Text.AlignHCenter
                                }
                                MouseArea{
                                    anchors.fill: parent
                                    acceptedButtons: Qt.LeftButton | Qt.RightButton
                                    onClicked: {
                                        m_SelectState = !m_SelectState
                                    }
                                }
                            }

                            Rectangle{
                                id:rect_Min
                                height: parent.height
                                border.width: m_SelectState ? 3 : 1
                                border.color: m_SelectState ? "red" : mainColor
                                width: 200
                                color: "transparent"
                                anchors.left: rect_Num.right
//                                TextField{
//                                    id:text_Min
//                                    width: parent.width - 5
//                                    height: parent.height -5
//                                    font.pixelSize: 18
//                                    font.family: "黑体"
//                                    anchors.centerIn: parent
//                                    horizontalAlignment: Text.AlignHCenter
//                                    text: m_MinData
//                                    onTextChanged: {
//                                        m_MinData = text
//                                    }
//                                    validator: DoubleValidator {
//                                        bottom: -9999999
//                                        top: 9999999
//                                        notation: DoubleValidator.StandardNotation
//                                        decimals: 5
//                                    }
//                                }
                                CTextInput{
                                    id:text_Min
                                    anchors.fill: parent
                                    pixelSize: 18
                                    titleWidth: 0
                                    anchors.centerIn: parent
                                    horizontalAlignment: Text.AlignHCenter
                                    borderVisible: false
                                    text: m_MinData
                                    onTextChanged: {
                                        m_MinData = text
                                    }
                                }
                            }

                            Rectangle{
                                id:rect_Max
                                height: parent.height
                                border.width: m_SelectState ? 3 : 1
                                border.color: m_SelectState ? "red" : mainColor
                                width: 200
                                color: "transparent"
                                anchors.left: rect_Min.right
//                                TextField{
//                                    id:text_Max
//                                    width: parent.width - 5
//                                    height: parent.height -5
//                                    font.pixelSize: 18
//                                    font.family: "黑体"
//                                    anchors.centerIn: parent
//                                    horizontalAlignment: Text.AlignHCenter
//                                    text: m_MaxData
//                                    onTextChanged: {
//                                        m_MaxData = text
//                                    }
//                                    validator: DoubleValidator {
//                                        bottom: -9999999
//                                        top: 9999999
//                                        notation: DoubleValidator.StandardNotation
//                                        decimals: 5
//                                    }
//                                }
                                CTextInput{
                                    id:text_Max
                                    anchors.fill: parent
                                    pixelSize: 18
                                    titleWidth: 0
                                    anchors.centerIn: parent
                                    horizontalAlignment: Text.AlignHCenter
                                    borderVisible: false
                                    text: m_MaxData
                                    onTextChanged: {
                                        m_MaxData = text
                                    }
                                }
                            }

                            Rectangle{
                                id:rect_Area
                                height: parent.height
                                border.width: m_SelectState ? 3 : 1
                                border.color: m_SelectState ? "red" : mainColor
                                width: 200
                                color: "transparent"
                                anchors.left: rect_Max.right
//                                TextField{
//                                    id:text_Area
//                                    width: parent.width - 5
//                                    height: parent.height -5
//                                    font.pixelSize: 18
//                                    font.family: "黑体"
//                                    anchors.centerIn: parent
//                                    horizontalAlignment: Text.AlignHCenter
//                                    text: m_AreaData
//                                    onTextChanged: {
//                                        m_AreaData = text
//                                    }
//                                    validator: DoubleValidator {
//                                        bottom: -9999999
//                                        top: 9999999
//                                        notation: DoubleValidator.StandardNotation
//                                        decimals: 5
//                                    }
//                                }
                                CTextInput{
                                    id:text_Area
                                    anchors.fill: parent
                                    pixelSize: 18
                                    titleWidth: 0
                                    anchors.centerIn: parent
                                    horizontalAlignment: Text.AlignHCenter
                                    borderVisible: false
                                    text: m_AreaData
                                    onTextChanged: {
                                        m_AreaData = text
                                    }
                                }
                            }

                            Rectangle{
                                id:rect_Describe
                                height: parent.height
                                border.width: m_SelectState ? 3 : 1
                                border.color: m_SelectState ? "red" : mainColor
                                width: parent.width - rect_Max.width - rect_Min.width - rect_Num.width - rect_Area.width
                                color: "transparent"
                                anchors.left: rect_Area.right
//                                TextField{
//                                    id:text_Describe
//                                    font.pixelSize: 18
//                                    font.family: "黑体"
//                                    width: parent.width - 5
//                                    height: parent.height -5
//                                    anchors.centerIn: parent
//                                    horizontalAlignment: Text.AlignLeft
//                                    text: m_DescribeData
//                                    onTextChanged: {
//                                        m_DescribeData = text
//                                    }
//                                }
                                CTextInput{
                                    id:text_Describe
                                    anchors.fill: parent
                                    pixelSize: 18
                                    titleWidth: 0
                                    anchors.centerIn: parent
                                    onlyNum: false
                                    borderVisible: false
                                    text: m_DescribeData
                                    onTextChanged: {
                                        m_DescribeData = text
                                    }
                                }
                            }
                        }
                    }
                }
//                Component.onCompleted: {
//                    listmodel_.append({m_SelectState:false,m_MinData:"11",m_MaxData:"22",m_DescribeData:"aaa"})
//                    listmodel_.append({m_SelectState:false,m_MinData:"55.5",m_MaxData:"66",m_DescribeData:"cc"})
//                }
            }

        }

        CButton{
            id:btn_Cancel
            anchors.right: parent.right
            anchors.rightMargin: 10
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 10
            text: "取消"
            pixelSize: 18
            width: 80
            height: 36
            onClicked: {
                custom_EffectiveReflectionArea.visible = false
            }
        }
        CButton{
            id:btn_Confir
            anchors.right: btn_Cancel.left
            anchors.rightMargin: 10
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 10
            text: "确认"
            pixelSize: 18
            width: 80
            height: 36
            onClicked: {
                //
                custom_PassiveInterferencePod.effectiveReflectionArea = confirData()
                custom_EffectiveReflectionArea.visible = false
            }
        }

        CButton{
            id:btn_Add
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 10
            text: "新增"
            pixelSize: 18
            width: 80
            height: 36
            onClicked: {
                listmodel_.append({m_SelectState:false,m_MinData:"",m_MaxData:"",m_AreaData:"",m_DescribeData:""})
            }
        }
        CButton{
            id:btn_Del
            anchors.left: btn_Add.right
            anchors.leftMargin: 10
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 10
            text: "删除"
            pixelSize: 18
            width: 80
            height: 36
            onClicked: {
                for(var index = 0; index < listmodel_.count;)
                {
                    if(listmodel_.get(index).m_SelectState)
                    {
                        listmodel_.remove(index)
                        continue
                    }
                    index++
                }
            }
        }
    }
    //加载数据查看与修改
    function initListData(data){
        listmodel_.clear()
        for(var index = 0; index < data.length; index++)
        {
            var dataList = data[index].split(",")
            if(dataList.length > 0)
            {
                listmodel_.append({m_SelectState:false,m_MinData:dataList[0],m_MaxData:dataList[1],m_AreaData:dataList[2],m_DescribeData:dataList[3]})
            }
        }
    }

    function confirData()
    {
        var returnData = []
        for(var index = 0; index < listmodel_.count; index++)
        {
            returnData.push(listmodel_.get(index).m_MinData + "," + listmodel_.get(index).m_MaxData + "," + listmodel_.get(index).m_AreaData + "," + listmodel_.get(index).m_DescribeData)
        }
        return returnData
    }
}
