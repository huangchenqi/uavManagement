import QtQuick 2.0
import QtQuick.Controls 2.12
import QtQuick.Window 2.12

import "qrc:/"
import "qrc:/Code/QML/Component"
import "qrc:/Code/QML"

Item {
    id:custom_ReconnaissanceCommunication
    width: 800
    height: 450

    Image {
        id: backGround
        source: mainBackgroundSource
        anchors.fill: parent
    }

    Rectangle{
        id:rect_Root
        anchors.fill: parent
        color: "#50000000"

        CText{
            id:topTitle
            text: "侦察通信"
            pixelSize: 25
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 15
            color: mainColor
            horizontalAlignment: Text.AlignHCenter
        }

        CTextInput{
            id:text_Frequency_Min
            anchors.left: parent.left
            anchors.leftMargin: 5
            anchors.top: topTitle.bottom
            anchors.topMargin: 20
            title: "最小频率(Hz):"
            pixelSize: 18
            titleWidth: pixelSize * 6.5
            width: 220
            height: 30
        }
        CTextInput{
            id:text_Frequency_Max
            anchors.left: text_Frequency_Min.right
            anchors.top: text_Frequency_Min.top
            title: "最大频率(Hz):"
            pixelSize: 18
            titleWidth: pixelSize * 6.5
            width: 220
            height: 30
        }

        CButton{
            id:btn_EconnaissanceRange
            anchors.left: text_Frequency_Min.left
            anchors.top: text_Frequency_Min.bottom
            anchors.topMargin: 10
            text: "侦察距离"
            pixelSize: 18
            width: 120
            height: 36
            onClicked: {
                //
                rect_EconnaissanceRangeDataShow.visible = !rect_EconnaissanceRangeDataShow.visible
            }
        }

        CButton{
            id:btn_LateralAccuracy
            anchors.left: btn_EconnaissanceRange.right
            anchors.leftMargin: 5
            anchors.top: btn_EconnaissanceRange.top
            text: "侧向精度"
            pixelSize: 18
            width: 120
            height: 36
            onClicked: {
                //
                rect_LateralAccuracyDataShow.visible = !rect_LateralAccuracyDataShow.visible
            }
        }

        CButton{
            id:btn_PositioningAccuracy
            anchors.left: btn_LateralAccuracy.right
            anchors.leftMargin: 5
            anchors.top: btn_LateralAccuracy.top
            text: "定位精度"
            pixelSize: 18
            width: 120
            height: 36
            onClicked: {
                //
                rect_PositioningAccuracyDataShow.visible = !rect_PositioningAccuracyDataShow.visible
            }
        }


        Rectangle{
            id:rect_EconnaissanceRangeDataShow
            width: 700
            height: 250
            anchors.top: btn_EconnaissanceRange.bottom
            anchors.topMargin: 5
            anchors.left: btn_EconnaissanceRange.left
            color: "black"
            visible: false

            Image {
                source: mainBackgroundSource
                anchors.fill: parent
            }

            Rectangle{
                id:rect_Title
                anchors.top: parent.top
                anchors.left: parent.left
                width: 700
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
                    id:rect_RangeTitle
                    height: parent.height
                    border.width: 1
                    border.color: mainColor
                    width: 150
                    color: "transparent"
                    anchors.left: rect_NumTitle.right
                    CText{
                        pixelSize: 18
                        anchors.centerIn: parent
                        horizontalAlignment: Text.AlignHCenter
                        color: mainColor
                        text: "侦察距离(Km)"
                    }
                }

                Rectangle{
                    id:rect_MinTitle
                    height: parent.height
                    border.width: 1
                    border.color: mainColor
                    width: 175
                    color: "transparent"
                    anchors.left: rect_RangeTitle.right
                    CText{
                        pixelSize: 18
                        anchors.centerIn: parent
                        horizontalAlignment: Text.AlignHCenter
                        color: mainColor
                        text: "最小侦察频率(GHz)"
                    }
                }

                Rectangle{
                    id:rect_MaxTitle
                    height: parent.height
                    border.width: 1
                    border.color: mainColor
                    width: 175
                    color: "transparent"
                    anchors.left: rect_MinTitle.right
                    CText{
                        pixelSize: 18
                        anchors.centerIn: parent
                        horizontalAlignment: Text.AlignHCenter
                        text: "最大侦察频率(GHz)"
                        color: mainColor
                    }
                }

                Rectangle{
                    id:rect_RadiatedPower
                    height: parent.height
                    border.width: 1
                    border.color: mainColor
                    width: 150
                    color: "transparent"
                    anchors.left: rect_MaxTitle.right
                    CText{
                        pixelSize: 18
                        anchors.centerIn: parent
                        horizontalAlignment: Text.AlignHCenter
                        text: "侦密辐射功率"
                        color: mainColor
                    }
                }
            }

            ListView{
                id:listView_DataShow
                anchors.top: rect_Title.bottom
                anchors.left: parent.left
                width: rect_Title.width
                height: parent.height - rect_Title.height
                visible: true
                clip: true

                model:ListModel{
                    id:listmodel_EconnaissanceRange
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
                            border.width: m_SelectState ? 5 : 1
                            Rectangle{
                                id:rect_Num
                                border.width: 1
                                border.color: mainColor
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
                                id:rect_Range
                                height: parent.height
                                width: 150
                                color: "transparent"
                                anchors.left: rect_Num.right
                                TextField{
                                    width: parent.width - 5
                                    height: parent.height -5
                                    font.pixelSize: 18
                                    font.family: "黑体"
                                    anchors.centerIn: parent
                                    horizontalAlignment: Text.AlignHCenter
                                    text: m_RangeData
                                    onTextChanged: {
                                        m_RangeData = text
                                    }
                                    validator: DoubleValidator {
                                        bottom: -9999999
                                        top: 9999999
                                        notation: DoubleValidator.StandardNotation
                                        decimals: 5
                                    }
                                }
                            }

                            Rectangle{
                                id:rect_Min
                                height: parent.height
                                width: 175
                                color: "transparent"
                                anchors.left: rect_Range.right
                                TextField{
                                    width: parent.width - 5
                                    height: parent.height -5
                                    font.pixelSize: 18
                                    font.family: "黑体"
                                    anchors.centerIn: parent
                                    horizontalAlignment: Text.AlignHCenter
                                    text: m_MinData
                                    onTextChanged: {
                                        m_MinData = text
                                    }
                                    validator: DoubleValidator {
                                        bottom: -9999999
                                        top: 9999999
                                        notation: DoubleValidator.StandardNotation
                                        decimals: 5
                                    }
                                }
                            }

                            Rectangle{
                                id:rect_Max
                                height: parent.height
                                width: 175
                                color: "transparent"
                                anchors.left: rect_Min.right
                                TextField{
                                    id:text_Max
                                    width: parent.width - 5
                                    height: parent.height -5
                                    font.pixelSize: 18
                                    font.family: "黑体"
                                    anchors.centerIn: parent
                                    horizontalAlignment: Text.AlignHCenter
                                    text: m_MaxData
                                    onTextChanged: {
                                        m_MaxData = text
                                    }
                                    validator: DoubleValidator {
                                        bottom: -9999999
                                        top: 9999999
                                        notation: DoubleValidator.StandardNotation
                                        decimals: 5
                                    }
                                }
                            }

                            Rectangle{
                                id:rect_Power
                                height: parent.height
                                width: 150
                                color: "transparent"
                                anchors.left: rect_Max.right

                                TextField{
                                    id:text_Describe
                                    font.pixelSize: 18
                                    font.family: "黑体"
                                    width: parent.width - 5
                                    height: parent.height -5
                                    anchors.centerIn: parent
                                    horizontalAlignment: Text.AlignHCenter
                                    text: m_RadiatedPower
                                    onTextChanged: {
                                        m_RadiatedPower = text
                                    }
                                    validator: DoubleValidator {
                                        bottom: -9999999
                                        top: 9999999
                                        notation: DoubleValidator.StandardNotation
                                        decimals: 5
                                    }
                                }
                            }
                        }
                    }
                }
                Component.onCompleted: {
                    listmodel_EconnaissanceRange.append({m_SelectState:false,m_RangeData:"132",m_MinData:"11",m_MaxData:"22",m_RadiatedPower:"22"})
                    listmodel_EconnaissanceRange.append({m_SelectState:false,m_RangeData:"311",m_MinData:"55.5",m_MaxData:"66",m_RadiatedPower:"33"})
                    listmodel_EconnaissanceRange.append({m_SelectState:false,m_RangeData:"41",m_MinData:"55.5",m_MaxData:"66",m_RadiatedPower:"33"})
                    listmodel_EconnaissanceRange.append({m_SelectState:false,m_RangeData:"451",m_MinData:"55.5",m_MaxData:"66",m_RadiatedPower:"33"})
                }
            }

        }

        Rectangle{
            id:rect_LateralAccuracyDataShow
            width: 600
            height: 250
            anchors.top: btn_LateralAccuracy.bottom
            anchors.topMargin: 5
            anchors.left: btn_LateralAccuracy.left
            color: "black"
            visible: false

            Image {
                source: mainBackgroundSource
                anchors.fill: parent
            }

            Rectangle{
                id:rect_LateralAccuracyTitle
                anchors.top: parent.top
                anchors.left: parent.left
                width: 600
                color: "#1D0D0E"
                height: 50
                border.color: mainColor

                Rectangle{
                    id:rect_LateralAccuracyNumTitle
                    border.width: 1
                    border.color: mainColor
                    width: 50
                    color: "transparent"
                    height: parent.height
                    CText{
                        text: "序号"
                        color: mainColor
                        pixelSize: 18
                        anchors.centerIn: parent
                        anchors.verticalCenter: parent.verticalCenter
                        horizontalAlignment: Text.AlignHCenter
                    }
                }

                Rectangle{
                    id:rect_LateralAccuracyRangeTitle
                    height: parent.height
                    border.width: 1
                    border.color: mainColor
                    width: 150
                    color: "transparent"
                    anchors.left: rect_LateralAccuracyNumTitle.right
                    CText{
                        pixelSize: 18
                        anchors.centerIn: parent
                        horizontalAlignment: Text.AlignHCenter
                        color: mainColor
                        text: "测向精度"
                    }
                }

                Rectangle{
                    id:rect_MinLateralAccuracy
                    height: parent.height
                    border.width: 1
                    border.color: mainColor
                    width: 200
                    color: "transparent"
                    anchors.left: rect_LateralAccuracyRangeTitle.right
                    CText{
                        pixelSize: 18
                        anchors.centerIn: parent
                        horizontalAlignment: Text.AlignHCenter
                        color: mainColor
                        text: "最小测向精度频率(GHz)"
                    }
                }

                Rectangle{
                    id:rect_MaxLateralAccuracy
                    height: parent.height
                    border.width: 1
                    border.color: mainColor
                    width: 200
                    color: "transparent"
                    anchors.left: rect_MinLateralAccuracy.right
                    CText{
                        pixelSize: 18
                        anchors.centerIn: parent
                        horizontalAlignment: Text.AlignHCenter
                        text: "最大测向精度频率(GHz)"
                        color: mainColor
                    }
                }

            }

            ListView{
                id:listView_LateralAccuracyDataShow
                anchors.top: rect_LateralAccuracyTitle.bottom
                anchors.left: parent.left
                width: rect_LateralAccuracyTitle.width
                height: parent.height - rect_Title.height
                visible: true
                clip: true

                model:ListModel{
                    id:listmodel_LateralAccuracy
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
                            border.width: m_SelectState ? 5 : 1
                            Rectangle{
                                id:rect_Num
                                border.width: 1
                                border.color: mainColor
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
                                id:rect_Range
                                height: parent.height
                                width: 150
                                color: "transparent"
                                anchors.left: rect_Num.right
                                TextField{
                                    width: parent.width - 5
                                    height: parent.height -5
                                    font.pixelSize: 18
                                    font.family: "黑体"
                                    anchors.centerIn: parent
                                    horizontalAlignment: Text.AlignHCenter
                                    text: m_RangeData
                                    onTextChanged: {
                                        m_RangeData = text
                                    }
                                    validator: DoubleValidator {
                                        bottom: -9999999
                                        top: 9999999
                                        notation: DoubleValidator.StandardNotation
                                        decimals: 5
                                    }
                                }
                            }

                            Rectangle{
                                id:rect_Min
                                height: parent.height
                                width: 200
                                color: "transparent"
                                anchors.left: rect_Range.right
                                TextField{
                                    width: parent.width - 5
                                    height: parent.height -5
                                    font.pixelSize: 18
                                    font.family: "黑体"
                                    anchors.centerIn: parent
                                    horizontalAlignment: Text.AlignHCenter
                                    text: m_MinData
                                    onTextChanged: {
                                        m_MinData = text
                                    }
                                    validator: DoubleValidator {
                                        bottom: -9999999
                                        top: 9999999
                                        notation: DoubleValidator.StandardNotation
                                        decimals: 5
                                    }
                                }
                            }

                            Rectangle{
                                id:rect_Max
                                height: parent.height
                                width: 200
                                color: "transparent"
                                anchors.left: rect_Min.right
                                TextField{
                                    id:text_Max
                                    width: parent.width - 5
                                    height: parent.height -5
                                    font.pixelSize: 18
                                    font.family: "黑体"
                                    anchors.centerIn: parent
                                    horizontalAlignment: Text.AlignHCenter
                                    text: m_MaxData
                                    onTextChanged: {
                                        m_MaxData = text
                                    }
                                    validator: DoubleValidator {
                                        bottom: -9999999
                                        top: 9999999
                                        notation: DoubleValidator.StandardNotation
                                        decimals: 5
                                    }
                                }
                            }
                        }
                    }
                }
                Component.onCompleted: {
                    listmodel_LateralAccuracy.append({m_SelectState:false,m_RangeData:"132",m_MinData:"11",m_MaxData:"22",m_RadiatedPower:"22"})
                    listmodel_LateralAccuracy.append({m_SelectState:false,m_RangeData:"311",m_MinData:"55.5",m_MaxData:"66",m_RadiatedPower:"33"})
                    listmodel_LateralAccuracy.append({m_SelectState:false,m_RangeData:"41",m_MinData:"55.5",m_MaxData:"66",m_RadiatedPower:"33"})
                    listmodel_LateralAccuracy.append({m_SelectState:false,m_RangeData:"451",m_MinData:"55.5",m_MaxData:"66",m_RadiatedPower:"33"})
                }
            }

        }

        Rectangle{
            id:rect_PositioningAccuracyDataShow
            width: 600
            height: 250
            anchors.top: btn_PositioningAccuracy.bottom
            anchors.topMargin: 5
            anchors.left: btn_PositioningAccuracy.left
            color: "black"
            visible: false

            Image {
                source: mainBackgroundSource
                anchors.fill: parent
            }

            Rectangle{
                id:rect_PositioningAccuracyTitle
                anchors.top: parent.top
                anchors.left: parent.left
                width: 600
                color: "#1D0D0E"
                height: 50
                border.color: mainColor

                Rectangle{
                    id:rect_PositioningAccuracyNumTitle
                    border.width: 1
                    border.color: mainColor
                    width: 50
                    color: "transparent"
                    height: parent.height
                    CText{
                        text: "序号"
                        color: mainColor
                        pixelSize: 18
                        anchors.centerIn: parent
                        anchors.verticalCenter: parent.verticalCenter
                        horizontalAlignment: Text.AlignHCenter
                    }
                }

                Rectangle{
                    id:rect_PositioningAccuracyRangeTitle
                    height: parent.height
                    border.width: 1
                    border.color: mainColor
                    width: 150
                    color: "transparent"
                    anchors.left: rect_PositioningAccuracyNumTitle.right
                    CText{
                        pixelSize: 18
                        anchors.centerIn: parent
                        horizontalAlignment: Text.AlignHCenter
                        color: mainColor
                        text: "定位精度"
                    }
                }

                Rectangle{
                    id:rect_MinPositioningAccuracy
                    height: parent.height
                    border.width: 1
                    border.color: mainColor
                    width: 200
                    color: "transparent"
                    anchors.left: rect_PositioningAccuracyRangeTitle.right
                    CText{
                        pixelSize: 18
                        anchors.centerIn: parent
                        horizontalAlignment: Text.AlignHCenter
                        color: mainColor
                        text: "最小定位精度频率(GHz)"
                    }
                }

                Rectangle{
                    id:rect_MaxPositioningAccuracy
                    height: parent.height
                    border.width: 1
                    border.color: mainColor
                    width: 200
                    color: "transparent"
                    anchors.left: rect_MinPositioningAccuracy.right
                    CText{
                        pixelSize: 18
                        anchors.centerIn: parent
                        horizontalAlignment: Text.AlignHCenter
                        text: "最大定位精度频率(GHz)"
                        color: mainColor
                    }
                }

            }

            ListView{
                id:listView_PositioningAccuracyDataShow
                anchors.top: rect_PositioningAccuracyTitle.bottom
                anchors.left: parent.left
                width: rect_PositioningAccuracyTitle.width
                height: parent.height - rect_Title.height
                visible: true
                clip: true

                model:ListModel{
                    id:listmodel_PositioningAccuracy
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
                            border.width: m_SelectState ? 5 : 1
                            Rectangle{
                                id:rect_Num
                                border.width: 1
                                border.color: mainColor
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
                                id:rect_Range
                                height: parent.height
                                width: 150
                                color: "transparent"
                                anchors.left: rect_Num.right
                                TextField{
                                    width: parent.width - 5
                                    height: parent.height -5
                                    font.pixelSize: 18
                                    font.family: "黑体"
                                    anchors.centerIn: parent
                                    horizontalAlignment: Text.AlignHCenter
                                    text: m_RangeData
                                    onTextChanged: {
                                        m_RangeData = text
                                    }
                                    validator: DoubleValidator {
                                        bottom: -9999999
                                        top: 9999999
                                        notation: DoubleValidator.StandardNotation
                                        decimals: 5
                                    }
                                }
                            }

                            Rectangle{
                                id:rect_Min
                                height: parent.height
                                width: 200
                                color: "transparent"
                                anchors.left: rect_Range.right
                                TextField{
                                    width: parent.width - 5
                                    height: parent.height -5
                                    font.pixelSize: 18
                                    font.family: "黑体"
                                    anchors.centerIn: parent
                                    horizontalAlignment: Text.AlignHCenter
                                    text: m_MinData
                                    onTextChanged: {
                                        m_MinData = text
                                    }
                                    validator: DoubleValidator {
                                        bottom: -9999999
                                        top: 9999999
                                        notation: DoubleValidator.StandardNotation
                                        decimals: 5
                                    }
                                }
                            }

                            Rectangle{
                                id:rect_Max
                                height: parent.height
                                width: 200
                                color: "transparent"
                                anchors.left: rect_Min.right
                                TextField{
                                    id:text_Max
                                    width: parent.width - 5
                                    height: parent.height -5
                                    font.pixelSize: 18
                                    font.family: "黑体"
                                    anchors.centerIn: parent
                                    horizontalAlignment: Text.AlignHCenter
                                    text: m_MaxData
                                    onTextChanged: {
                                        m_MaxData = text
                                    }
                                    validator: DoubleValidator {
                                        bottom: -9999999
                                        top: 9999999
                                        notation: DoubleValidator.StandardNotation
                                        decimals: 5
                                    }
                                }
                            }
                        }
                    }
                }
                Component.onCompleted: {
                    listmodel_PositioningAccuracy.append({m_SelectState:false,m_RangeData:"132",m_MinData:"11",m_MaxData:"22"})
                    listmodel_PositioningAccuracy.append({m_SelectState:false,m_RangeData:"311",m_MinData:"55.5",m_MaxData:"66"})
                    listmodel_PositioningAccuracy.append({m_SelectState:false,m_RangeData:"41",m_MinData:"55.5",m_MaxData:"66"})
                    listmodel_PositioningAccuracy.append({m_SelectState:false,m_RangeData:"451",m_MinData:"55.5",m_MaxData:"66"})
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

    }
}
