import QtQuick 2.0
import QtQuick.Controls 2.12
import QtQuick.Window 2.12

import "qrc:/"
import "qrc:/AddAmmoModules/Component"
import "qrc:/AddAmmoModules"
//import "qrc:/Code/QML/Component"
//import "qrc:/Code/QML"

//投放速度弹窗
Item {
    id:custom_ReconnaissanceCommunication
    width: 800
    height: 450

    property int loadState: 0  //0:新增、1:查看、2:编辑

    signal reconnaissanceCommunicationRecord()

    Component.onCompleted: {
        loadView()
    }

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
            id:text_name
            anchors.left: parent.left
            anchors.leftMargin: 5
            anchors.top: topTitle.bottom
            anchors.topMargin: 20
            title: "通信侦察名称:"
            pixelSize: 18
            titleWidth: pixelSize * 6.5
            width: 380
            height: 30
            onlyNum: false
            enabled: loadState != 1
        }

        CTextInput{
            id:text_Frequency_Min
            anchors.left: parent.left
            anchors.leftMargin: 5
            anchors.top: text_name.bottom
            anchors.topMargin: 20
            title: "最小频率(MHz):"
            pixelSize: 18
            titleWidth: pixelSize * 7
            width: 220
            height: 30
            enabled: loadState != 1
        }

        CTextInput{
            id:text_Frequency_Max
            anchors.left: text_Frequency_Min.right
            anchors.leftMargin: 20
            anchors.top: text_Frequency_Min.top
            title: "最大频率(GHz):"
            pixelSize: 18
            titleWidth: pixelSize * 7
            width: 220
            height: 30
            enabled: loadState != 1
        }

        CButton{
            id:btn_EconnaissanceRange
            anchors.left: text_Frequency_Min.left
            anchors.top: text_Frequency_Min.bottom
            anchors.topMargin: 10
            text: "侦察距离"
            pixelSize: 18
            width: 220
            height: 36
            onClicked: {
                rect_PositioningAccuracyDataShow.visible = false
                rect_LateralAccuracyDataShow.visible = false
                rect_EconnaissanceRangeDataShow.visible = !rect_EconnaissanceRangeDataShow.visible
            }
        }

        CButton{
            id:btn_LateralAccuracy
            anchors.left: btn_EconnaissanceRange.right
            anchors.leftMargin: 20
            anchors.top: btn_EconnaissanceRange.top
            text: "测向精度"
            pixelSize: 18
            width: 220
            height: 36
            onClicked: {
                rect_EconnaissanceRangeDataShow.visible = false
                rect_PositioningAccuracyDataShow.visible = false
                rect_LateralAccuracyDataShow.visible = !rect_LateralAccuracyDataShow.visible
            }
        }

        CButton{
            id:btn_PositioningAccuracy
            anchors.left: btn_LateralAccuracy.right
            anchors.leftMargin: 20
            anchors.top: btn_LateralAccuracy.top
            text: "定位精度"
            pixelSize: 18
            width: 220
            height: 36
            onClicked: {
                rect_EconnaissanceRangeDataShow.visible = false
                rect_LateralAccuracyDataShow.visible = false
                rect_PositioningAccuracyDataShow.visible = !rect_PositioningAccuracyDataShow.visible
            }
        }
        Rectangle{
            id:rect_Describe
            anchors.top: btn_EconnaissanceRange.bottom
            anchors.left: btn_EconnaissanceRange.left
            width:770
            //height: 300
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 350
            anchors.leftMargin: 0
            anchors.topMargin: 10
            // anchors.right: addAmmo.right
            // anchors.bottom: custom_PassiveInterferencePod.bottom
            color:"#50000000"
            radius: 10

            CText {
                id: text_DescribeTitle
                text: qsTr("用途描述:")
                pixelSize: 18
                color: "#4EC4FF"
                anchors.left: parent.left
                anchors.leftMargin: 0
                anchors.top: parent.top
                anchors.topMargin: 20
                horizontalAlignment: Text.AlignLeft

            }
            TextArea {
                id: usageDescriptionText
                anchors.top: text_DescribeTitle.bottom
                anchors.topMargin: 15
                anchors.left: text_DescribeTitle.left
                anchors.right: parent.right
                anchors.rightMargin: 5
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 5
                // 边框样式
                    background: Rectangle {
                        border.color: "#cccccc"
                        radius: 10
                    }

                // 多行显示关键配置
                wrapMode: Text.Wrap                   // 自动换行
                placeholderText: "请输入多行描述..."    // 占位提示
                textFormat: Text.PlainText            // 文本格式
                selectByMouse: true                   // 允许鼠标选择
                inputMethodHints: Qt.ImhMultiLine      // 启用多行输入法支持
                font.family: "黑体"
                font.pixelSize: 20
                onTextChanged: {
                    //ammoData.ammoDescription =text
                    console.log("Text content changed to: " + text)

                }
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
                enabled: loadState != 1
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
//                    listmodel_EconnaissanceRange.append({m_SelectState:false,m_RangeData:"132",m_MinData:"11",m_MaxData:"22",m_RadiatedPower:"22"})
//                    listmodel_EconnaissanceRange.append({m_SelectState:false,m_RangeData:"311",m_MinData:"55.5",m_MaxData:"66",m_RadiatedPower:"33"})
//                    listmodel_EconnaissanceRange.append({m_SelectState:false,m_RangeData:"41",m_MinData:"55.5",m_MaxData:"66",m_RadiatedPower:"33"})
//                    listmodel_EconnaissanceRange.append({m_SelectState:false,m_RangeData:"451",m_MinData:"55.5",m_MaxData:"66",m_RadiatedPower:"33"})

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
                enabled: loadState != 1

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
//                    listmodel_LateralAccuracy.append({m_SelectState:false,m_RangeData:"132",m_MinData:"11",m_MaxData:"22",m_RadiatedPower:"22"})
//                    listmodel_LateralAccuracy.append({m_SelectState:false,m_RangeData:"311",m_MinData:"55.5",m_MaxData:"66",m_RadiatedPower:"33"})
//                    listmodel_LateralAccuracy.append({m_SelectState:false,m_RangeData:"41",m_MinData:"55.5",m_MaxData:"66",m_RadiatedPower:"33"})
//                    listmodel_LateralAccuracy.append({m_SelectState:false,m_RangeData:"451",m_MinData:"55.5",m_MaxData:"66",m_RadiatedPower:"33"})

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
                enabled: loadState != 1

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
//                    listmodel_PositioningAccuracy.append({m_SelectState:false,m_RangeData:"132",m_MinData:"11",m_MaxData:"22"})
//                    listmodel_PositioningAccuracy.append({m_SelectState:false,m_RangeData:"311",m_MinData:"55.5",m_MaxData:"66"})
//                    listmodel_PositioningAccuracy.append({m_SelectState:false,m_RangeData:"41",m_MinData:"55.5",m_MaxData:"66"})
//                    listmodel_PositioningAccuracy.append({m_SelectState:false,m_RangeData:"451",m_MinData:"55.5",m_MaxData:"66"})

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
                reconnaissanceCommunicationRecord()
                custom_ReconnaissanceCommunication.visible = false
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
                // if(loadState == 1)
                //     return
                saveReconnaissanceCommunicationData()
                reconnaissanceCommunicationRecord()
                custom_ReconnaissanceCommunication.visible = false                
            }
        }
    }


    function textToFloat(data){
        // 检查是否以小数点结尾
        if (data.endsWith(".")) {
            data = data.slice(0, -1); // 去掉小数点
        }
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

    //判断是否加载新增、查看、编辑
    function loadView(){
        var viewType = processInfo.loadViewType
        if(processInfo.loadViewType === "addUavData"){
            //新增
            loadState = 0;
            initData()
        }else if(processInfo.loadViewType === "query"){
            //查看
            loadState = 1;
            loadReconnaissanceCommunicationData()
            btn_Confir.visible = false
            btn_Cancel.text = "返回"
        }else if(processInfo.loadViewType === "update"){
            //编辑
            loadState = 2;
            loadReconnaissanceCommunicationData()
        }else{
            console.log("processInfo.loadViewType Unknown")
        }
    }

    function initData()
    {
        for(var i=0; i<4; i++)
        {
            listmodel_EconnaissanceRange.append({m_SelectState:false,m_RangeData:"",m_MinData:"",m_MaxData:"",m_RadiatedPower:""})
            listmodel_LateralAccuracy.append({m_SelectState:false,m_RangeData:"",m_MinData:"",m_MaxData:""})
            listmodel_PositioningAccuracy.append({m_SelectState:false,m_RangeData:"",m_MinData:"",m_MaxData:""})

        }
    }

    function loadReconnaissanceCommunicationData()
    {
        var loadData = reconnaissanceCommunicationDaoTableModel.queryReconnaissanceCommunicationData(processInfo.originData)
        text_name.text = loadData.reconnaissanceName

        text_Frequency_Min.text = loadData.frequencyMinimum
        text_Frequency_Max.text = loadData.frequencyMaximum
        usageDescriptionText.text = loadData.description
        listmodel_EconnaissanceRange.append({m_SelectState:false,m_RangeData:loadData.firstReconnaissanceRange,m_MinData:loadData.firstReconnaissanceFrequencyMinimum,m_MaxData:loadData.firstReconnaissanceFrequencyMaximum,m_RadiatedPower:loadData.firstReconnaissanceRadiatedPower})
        listmodel_EconnaissanceRange.append({m_SelectState:false,m_RangeData:loadData.secondReconnaissanceRange,m_MinData:loadData.secondReconnaissanceFrequencyMinimum,m_MaxData:loadData.secondReconnaissanceFrequencyMaximum,m_RadiatedPower:loadData.secondReconnaissanceRadiatedPower})
        listmodel_EconnaissanceRange.append({m_SelectState:false,m_RangeData:loadData.thirdReconnaissanceRange,m_MinData:loadData.thirdReconnaissanceFrequencyMinimum,m_MaxData:loadData.thirdReconnaissanceFrequencyMaximum,m_RadiatedPower:loadData.thirdReconnaissanceRadiatedPower})
        listmodel_EconnaissanceRange.append({m_SelectState:false,m_RangeData:loadData.fourthReconnaissanceRange,m_MinData:loadData.fourthReconnaissanceFrequencyMinimum,m_MaxData:loadData.fourthReconnaissanceFrequencyMaximum,m_RadiatedPower:loadData.fourthReconnaissanceRadiatedPower})

        listmodel_LateralAccuracy.append({m_SelectState:false,m_RangeData:loadData.firstOrientationAccuracy,m_MinData:loadData.firstOrientationFrequencyMinimum,m_MaxData:loadData.firstOrientationFrequencyMaximum})
        listmodel_LateralAccuracy.append({m_SelectState:false,m_RangeData:loadData.secondOrientationAccuracy,m_MinData:loadData.firstOrientationFrequencyMinimum,m_MaxData:loadData.secondOrientationFrequencyMaximum})
        listmodel_LateralAccuracy.append({m_SelectState:false,m_RangeData:loadData.thirdOrientationAccuracy,m_MinData:loadData.firstOrientationFrequencyMinimum,m_MaxData:loadData.thirdOrientationFrequencyMaximum})
        listmodel_LateralAccuracy.append({m_SelectState:false,m_RangeData:loadData.fourthOrientationAccuracy,m_MinData:loadData.firstOrientationFrequencyMinimum,m_MaxData:loadData.fourthOrientationFrequencyMaximum})

        listmodel_PositioningAccuracy.append({m_SelectState:false,m_RangeData:loadData.firstPositioningAccuracy,m_MinData:loadData.firstPositioningFrequencyMinimum,m_MaxData:loadData.firstPositioningFrequencyMaximum})
        listmodel_PositioningAccuracy.append({m_SelectState:false,m_RangeData:loadData.secondPositioningAccuracy,m_MinData:loadData.secondPositioningFrequencyMinimum,m_MaxData:loadData.secondPositioningFrequencyMaximum})
        listmodel_PositioningAccuracy.append({m_SelectState:false,m_RangeData:loadData.thirdPositioningAccuracy,m_MinData:loadData.thirdPositioningFrequencyMinimum,m_MaxData:loadData.thirdPositioningFrequencyMaximum})
        listmodel_PositioningAccuracy.append({m_SelectState:false,m_RangeData:loadData.fourthPositioningAccuracy,m_MinData:loadData.fourthPositioningFrequencyMinimum,m_MaxData:loadData.fourthPositioningFrequencyMaximum})
    }

    function saveReconnaissanceCommunicationData()
    {
        var saveData = {
            id:0,
            reconnaissanceName:"",
            usedUavModels:"",
            description:"",
            frequencyMinimum:0.0,
            frequencyMaximum:0.0,
            firstReconnaissanceRange:0.0,
            firstReconnaissanceFrequencyMinimum:0.0,
            firstReconnaissanceFrequencyMaximum:0.0,
            firstReconnaissanceRadiatedPower:0.0,
            secondReconnaissanceRange:0.0,
            secondReconnaissanceFrequencyMinimum:0.0,
            secondReconnaissanceFrequencyMaximum:0.0,
            secondReconnaissanceRadiatedPower:0.0,
            thirdReconnaissanceRange:0.0,
            thirdReconnaissanceFrequencyMinimum:0.0,
            thirdReconnaissanceFrequencyMaximum:0.0,
            thirdReconnaissanceRadiatedPower:0.0,
            fourthReconnaissanceRange:0.0,
            fourthReconnaissanceFrequencyMinimum:0.0,
            fourthReconnaissanceFrequencyMaximum:0.0,
            fourthReconnaissanceRadiatedPower:0.0,

            firstOrientationAccuracy:0.0,
            firstOrientationFrequencyMinimum:0.0,
            firstOrientationFrequencyMaximum:0.0,
            secondOrientationAccuracy:0.0,
            secondOrientationFrequencyMinimum:0.0,
            secondOrientationFrequencyMaximum:0.0,
            thirdOrientationAccuracy:0.0,
            thirdOrientationFrequencyMinimum:0.0,
            thirdOrientationFrequencyMaximum:0.0,
            fourthOrientationAccuracy:0.0,
            fourthOrientationFrequencyMinimum:0.0,
            fourthOrientationFrequencyMaximum:0.0,

            firstPositioningAccuracy:0.0,
            firstPositioningFrequencyMinimum:0.0,
            firstPositioningFrequencyMaximum:0.0,
            secondPositioningAccuracy:0.0,
            secondPositioningFrequencyMinimum:0.0,
            secondPositioningFrequencyMaximum:0.0,
            thirdPositioningAccuracy:0.0,
            thirdPositioningFrequencyMinimum:0.0,
            thirdPositioningFrequencyMaximum:0.0,
            fourthPositioningAccuracy:0.0,
            fourthPositioningFrequencyMinimum:0.0,
            fourthPositioningFrequencyMaximum:0.0,

            imageUrl:""
        }

        saveData.reconnaissanceName = text_name.text
        saveData.frequencyMinimum = textToFloat(text_Frequency_Min.text)
        saveData.frequencyMaximum = textToFloat(text_Frequency_Max.text)
        saveData.description = usageDescriptionText.text
        if(listmodel_EconnaissanceRange.count == 4)
        {
            saveData.firstReconnaissanceRange = textToFloat(listmodel_EconnaissanceRange.get(0).m_RangeData)
            saveData.firstReconnaissanceFrequencyMinimum = textToFloat(listmodel_EconnaissanceRange.get(0).m_MinData)
            saveData.firstReconnaissanceFrequencyMaximum = textToFloat(listmodel_EconnaissanceRange.get(0).m_MaxData)
            saveData.firstReconnaissanceRadiatedPower = textToFloat(listmodel_EconnaissanceRange.get(0).m_RadiatedPower)
            saveData.secondReconnaissanceRange = textToFloat(listmodel_EconnaissanceRange.get(1).m_RangeData)
            saveData.secondReconnaissanceFrequencyMinimum = textToFloat(listmodel_EconnaissanceRange.get(1).m_MinData)
            saveData.secondReconnaissanceFrequencyMaximum = textToFloat(listmodel_EconnaissanceRange.get(1).m_MaxData)
            saveData.secondReconnaissanceRadiatedPower = textToFloat(listmodel_EconnaissanceRange.get(1).m_RadiatedPower)
            saveData.thirdReconnaissanceRange = textToFloat(listmodel_EconnaissanceRange.get(2).m_RangeData)
            saveData.thirdReconnaissanceFrequencyMinimum = textToFloat(listmodel_EconnaissanceRange.get(2).m_MinData)
            saveData.thirdReconnaissanceFrequencyMaximum = textToFloat(listmodel_EconnaissanceRange.get(2).m_MaxData)
            saveData.thirdReconnaissanceRadiatedPower = textToFloat(listmodel_EconnaissanceRange.get(2).m_RadiatedPower)
            saveData.fourthReconnaissanceRange = textToFloat(listmodel_EconnaissanceRange.get(3).m_RangeData)
            saveData.fourthReconnaissanceFrequencyMinimum = textToFloat(listmodel_EconnaissanceRange.get(3).m_MinData)
            saveData.fourthReconnaissanceFrequencyMaximum = textToFloat(listmodel_EconnaissanceRange.get(3).m_MaxData)
            saveData.fourthReconnaissanceRadiatedPower = textToFloat(listmodel_EconnaissanceRange.get(3).m_RadiatedPower)

        }

        if(listmodel_LateralAccuracy.count == 4)
        {
            saveData.firstOrientationAccuracy = textToFloat(listmodel_LateralAccuracy.get(0).m_RangeData)
            saveData.firstOrientationFrequencyMinimum = textToFloat(listmodel_LateralAccuracy.get(0).m_MinData)
            saveData.firstOrientationFrequencyMaximum = textToFloat(listmodel_LateralAccuracy.get(0).m_MaxData)
            saveData.secondOrientationAccuracy = textToFloat(listmodel_LateralAccuracy.get(1).m_RangeData)
            saveData.secondOrientationFrequencyMinimum = textToFloat(listmodel_LateralAccuracy.get(1).m_MinData)
            saveData.secondOrientationFrequencyMaximum = textToFloat(listmodel_LateralAccuracy.get(1).m_MaxData)
            saveData.thirdOrientationAccuracy = textToFloat(listmodel_LateralAccuracy.get(2).m_RangeData)
            saveData.thirdOrientationFrequencyMinimum = textToFloat(listmodel_LateralAccuracy.get(2).m_MinData)
            saveData.thirdOrientationFrequencyMaximum = textToFloat(listmodel_LateralAccuracy.get(2).m_MaxData)
            saveData.fourthOrientationAccuracy = textToFloat(listmodel_LateralAccuracy.get(3).m_RangeData)
            saveData.fourthOrientationFrequencyMinimum = textToFloat(listmodel_LateralAccuracy.get(3).m_MinData)
            saveData.fourthOrientationFrequencyMaximum = textToFloat(listmodel_LateralAccuracy.get(3).m_MaxData)

        }

        if(listmodel_PositioningAccuracy.count == 4)
        {
            saveData.firstPositioningAccuracy = textToFloat(listmodel_PositioningAccuracy.get(0).m_RangeData)
            saveData.firstPositioningFrequencyMinimum = textToFloat(listmodel_PositioningAccuracy.get(0).m_MinData)
            saveData.firstPositioningFrequencyMaximum = textToFloat(listmodel_PositioningAccuracy.get(0).m_MaxData)
            saveData.secondPositioningAccuracy = textToFloat(listmodel_PositioningAccuracy.get(1).m_RangeData)
            saveData.secondPositioningFrequencyMinimum = textToFloat(listmodel_PositioningAccuracy.get(1).m_MinData)
            saveData.secondPositioningFrequencyMaximum = textToFloat(listmodel_PositioningAccuracy.get(1).m_MaxData)
            saveData.thirdPositioningAccuracy = textToFloat(listmodel_PositioningAccuracy.get(2).m_RangeData)
            saveData.thirdPositioningFrequencyMinimum = textToFloat(listmodel_PositioningAccuracy.get(2).m_MinData)
            saveData.thirdPositioningFrequencyMaximum = textToFloat(listmodel_PositioningAccuracy.get(2).m_MaxData)
            saveData.fourthPositioningAccuracy = textToFloat(listmodel_PositioningAccuracy.get(3).m_RangeData)
            saveData.fourthPositioningFrequencyMinimum = textToFloat(listmodel_PositioningAccuracy.get(3).m_MinData)
            saveData.fourthPositioningFrequencyMaximum = textToFloat(listmodel_PositioningAccuracy.get(3).m_MaxData)
        }

        var succ
        if(loadState == 0)
            succ = reconnaissanceCommunicationDaoTableModel.insertReconnaissanceCommunicationData(saveData)
        else
        {
            saveData.id = processInfo.recordId
            succ = reconnaissanceCommunicationDaoTableModel.updateReconnaissanceCommunicationData(saveData)
        }
        if(succ)
            console.log("写入数据库成功")
        else
            console.log("写入数据库失败")
    }
}
