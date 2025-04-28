import QtQuick 2.0
import QtQuick.Controls 2.12
import QtQuick.Window 2.12

import "qrc:/"
import "qrc:/AddAmmoModules/Component"
import "qrc:/AddAmmoModules"

//投放速度弹窗
Item {
    id:custom_InterferencePodDropSpeed
    width: 450
    height: 400

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
            anchors.bottom: btn_Confir.top
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
                    id:rect_DropMethodTitle
                    height: parent.height
                    border.width: 1
                    border.color: mainColor
                    width: 200
                    color: "transparent"
                    anchors.left: rect_NumTitle.right
                    CText{
                        id:text_DropMethodTitle
                        pixelSize: 18
                        anchors.centerIn: parent
                        horizontalAlignment: Text.AlignHCenter
                        width: parent.width / 5
                        color: mainColor
                        text: "投放方式"
                    }
                }

                Rectangle{
                    id:rect_DropSpeedTitle
                    height: parent.height
                    border.width: 1
                    border.color: mainColor
                    width: 200
                    color: "transparent"
                    anchors.left: rect_DropMethodTitle.right
                    CText{
                        id:text_DropSpeeditle
                        pixelSize: 18
                        anchors.centerIn: parent
                        horizontalAlignment: Text.AlignHCenter
                        color: mainColor
                        text: "投放速度(盒/s)"
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
                                border.width: m_SelectState ? 3 : 1
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
                                id:rect_DropMethod
                                height: parent.height
                                border.width: m_SelectState ? 3 : 1
                                border.color: m_SelectState ? "red" : mainColor
                                width: 200
                                color: "transparent"
                                anchors.left: rect_Num.right
                                CText{
                                    id:text_DropMethod
                                    text: m_DropMethod
                                    pixelSize: 18
                                    color: mainColor
                                    anchors.fill: parent
                                    horizontalAlignment: Text.AlignHCenter
                                }
                            }

                            Rectangle{
                                id:rect_DropSpeed
                                height: parent.height
                                border.width: m_SelectState ? 3 : 1
                                border.color: m_SelectState ? "red" : mainColor
                                width: 200
                                color: "transparent"
                                anchors.left: rect_DropMethod.right
                                CText{
                                    id:text_DropSpeed
                                    text: m_DropSpeed
                                    pixelSize: 18
                                    color: mainColor
                                    anchors.fill: parent
                                    horizontalAlignment: Text.AlignHCenter
                                }
                            }
                        }
                    }
                }
                Component.onCompleted: {
                    listmodel_.append({m_SelectState:false,m_DropMethod:"方式1",m_DropSpeed:"同时1"})
                    listmodel_.append({m_SelectState:false,m_DropMethod:"方式2",m_DropSpeed:"同时2"})
                    listmodel_.append({m_SelectState:false,m_DropMethod:"方式3",m_DropSpeed:"交替1"})
                    listmodel_.append({m_SelectState:false,m_DropMethod:"方式4",m_DropSpeed:"交替2"})
                    listmodel_.append({m_SelectState:false,m_DropMethod:"方式5",m_DropSpeed:"交替3"})
                }
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
                //
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
            }
        }

//        CButton{
//            id:btn_Add
//            anchors.left: parent.left
//            anchors.leftMargin: 10
//            anchors.bottom: parent.bottom
//            anchors.bottomMargin: 10
//            text: "新增"
//            pixelSize: 18
//            width: 80
//            height: 36
//            onClicked: {
//                listmodel_.append({m_SelectState:false,m_DropMethod:"方式1",m_DropSpeed:"同时1"})
//            }
//        }
//        CButton{
//            id:btn_Del
//            anchors.left: btn_Add.right
//            anchors.leftMargin: 10
//            anchors.bottom: parent.bottom
//            anchors.bottomMargin: 10
//            text: "删除"
//            pixelSize: 18
//            width: 80
//            height: 36
//            onClicked: {
//                for(var index = 0; index < listmodel_.count;)
//                {
//                    if(listmodel_.get(index).m_SelectState)
//                    {
//                        listmodel_.remove(index)
//                        continue
//                    }

//                    index++
//                }
//            }
//        }
    }
}
