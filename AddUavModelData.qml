import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtQuick.Window 2.12
import QtQuick.Dialogs 1.2

import "qrc:/"
import UavDaoModel 1.0
import UavModelLoadTypeDaoModel 1.0
import UavBombingMethodDaoModel 1.0
import UavModelRecoveryModeDaoModel 1.0
import UavModelOperationWayDaoModel 1.0
import UavMountLocationDaoModel 1.0
Window{//Rectangle{
    id:addUavModelData
    visible: true
    width: 1200
    height: 600
    //title: qsTr("QML TableView example")
    // 获取当前时间并转换为字符串
    property var currentTime: new Date().toLocaleString()
    property var mountContent: []
    //侦察载荷
    property var payloadType: []
    property var uavInvestigationPayloadTypeResult: ""
    //投弹方式
    property var bombWay: []
    property var uavBombingmethodResult: ""
    //回收方式
    property var recoveryWay: []
    property var uavRecoveryModeResult: ""
    //操控方式
    property var operationWay: []
    property var uavOperatioanalModeResult: ""
    //挂载位置
    property var uavPayloadTypeResult: ""
    // 组件加载完成后生成测试数据
    Component.onCompleted:{
        loadUavComponentData()
        loadMountLocationContent()
        loadView()
        generateTestData()
    }
    Popup {
            id: warningPopup
            width: 300
            height: 100
            anchors.centerIn: Overlay.overlay // 居中显示
            closePolicy: Popup.NoAutoClose    // 完全禁用自动关闭
            modal: true
            focus: true

            background: Rectangle {
                color: "#ffeb3b"
                border.color: "#fbc02d"
                radius: 5
            }

            contentItem: Text {
                id:warningItem
                //text: "您查询的是全部数据！"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: 16
            }
        }
    Timer {
            id: autoCloseTimer
            interval: 500 // 2秒
            onTriggered: warningPopup.close()
        }

    Item {
        id:controlUav
        // width: 1200
        // height: 600
        // 定义警告对话框

        Popup {
            id: mountLocationManagementPopup
            width: 600  // 需明确设置宽度，否则可能无法显示完整内容
            height: 400
            modal: true
            focus: true
            anchors.centerIn: Overlay.overlay // 居中显示
            closePolicy: Popup.NoAutoClose    // 完全禁用自动关闭
            // 直接引用 admin.qml
              // GetTypeManagement{  // 假设 admin.qml 的根元素是 Admin 类型
              //       id: adminPanel
              //       anchors.fill: parent
              //       managementType:uavManagementroot.managementType

              //       onClose: payloadTypeManagementPopup.close() // 连接关闭信号
              //   }
            MultiTextOfCombox{
                id:uavMountContent
                anchors.fill: parent
                loadData:mountContent
                onClose: mountLocationManagementPopup.close() // 连接关闭信号
            }
            // MultiTextDispay {
            //      id: multiTextDispay
            //      anchors.fill: parent
            //      onClose: payloadTypeManagementPopup.close() // 连接关闭信号
            // }

        }
        UavModelDaoTableModel{
            id:uavModelDao
        }
        UavBombingMethodDaoTableModel{
           id:uavBombingMethodDaoModel
        }
        UavModelLoadTypeDaoTableModel{
           id:uavModelLoadTypeDaoModel
        }
        UavModelRecoveryModeDaoTableModel{
           id:uavModelRecoveryModeDaoModel
        }
        UavModelOperationWayDaoTableModel{
           id:uavModelOperationWayDaoModel
        }
        UavMountLocationDaoTableModel{
            id:uavMountLocationDaoTableModel
        }
        ColumnLayout {
                    anchors.fill: parent
                    //Layout.fillWidth: true
                    //Layout.fillHeight: true
                    spacing: 10
                    RowLayout {
                        //anchors.fill: parent
                        Layout.fillWidth: true
                        //Layout.fillHeight: true
                        Label {
                            Layout.fillWidth: true
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignHCenter
                            text: qsTr("无人机型号管理");
                            font.pointSize: 28
                            color: "black"
                        }
                    }
                    RowLayout {
                        //anchors.fill: parent
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        // Rectangle {
                        //     id: root
                        //     visible: true
                        //     width:900
                        //     height: 500
                        //     color: "#ECF2FE"
                        //     // ColumnLayout{


                        //     // }
                        // }
                        ColumnLayout {
                            anchors.fill: parent
                            Layout.fillWidth: true
                            Layout.fillHeight: true



                            RowLayout {
                                //anchors.fill: parent
                                Layout.fillWidth: true  // 占满列布局宽度
                                // Layout.fillHeight: true
                                spacing: 10
                                Label{
                                    id:uavType
                                    text: "无人机类型:"
                                    height: 50
                                    width:100
                                    // anchors.left: parent.left //锚点属性与锚点边距一起用。
                                    // anchors.leftMargin: 10
                                    Layout.leftMargin: 10

                                }

                                ComboBox{
                                    id:uavTypeSelect
                                    width:100
                                    height:50
                                    model:["侦察型无人机","攻击型无人机","查打一体无人机"]
                                }

                                Label{
                                    id:uavName
                                    text: "无人机名称:"
                                    height: 50
                                    width:100
                                }
                                TextField{
                                    id: uavNameText
                                    width: 120
                                }
                                Label{
                                    id:uavId
                                    text: "无人机编号:"
                                    height: 50
                                    width:100
                                }
                                TextField{
                                    id: uavIdText
                                    width: 120
                                }
                            }


                            RowLayout {
                                // anchors.fill: parent
                                Layout.fillWidth: true
                                // Layout.fillHeight: true
                                spacing: 10
                                Label{
                                    id:uavLength
                                    text: "机长(m):"
                                    height: 50
                                    width:100
                                    // anchors.left: parent.left //锚点属性与锚点边距一起用。
                                    // anchors.leftMargin: 10
                                    Layout.leftMargin: 10

                                }

                                TextField{
                                    id: uavLengthText
                                    Layout.preferredWidth: 80
                                    //width: 50
                                }

                                Label{
                                    id:uavWidth
                                    text: "翼展(m):"
                                    height: 50
                                    width:100
                                }
                                TextField{
                                    id: uavWidthText
                                    //width: 120
                                    Layout.preferredWidth: 80
                                }
                                Label{
                                    id:uavHeight
                                    text: "机高(m):"
                                    height: 50
                                    width:100
                                }
                                TextField{
                                    id: uavHeightText
                                    //width: 120
                                    Layout.preferredWidth: 80
                                }

                                Label{
                                    id:uavInvisibility
                                    text: "是否具备隐身:"
                                    height: 50
                                    width:100
                                    // anchors.left: parent.left //锚点属性与锚点边距一起用。
                                    // anchors.leftMargin: 10
                                    Layout.leftMargin: 10

                                }

                                ComboBox{
                                    id:uavInvisibilitySelect
                                    width:100
                                    height:50
                                    model:["未定","是","否"]
                                }



                            }
                            RowLayout {
                                // anchors.fill: parent
                                Layout.fillWidth: true
                                // Layout.fillHeight: true
                                spacing: 10
                                Label{
                                    id:uavFlightHeight
                                    text: "飞行高度范围(m):"
                                    height: 50
                                    width:100
                                    // anchors.left: parent.left //锚点属性与锚点边距一起用。
                                    // anchors.leftMargin: 10
                                    Layout.leftMargin: 10

                                }

                                TextField{
                                    id: uavFlightHeightMin
                                    //width: 50
                                    Layout.preferredWidth: 50
                                    //Layout.preferredHeight: 50
                                }
                                Label{
                                    id:uavFlightHeightRange
                                    text: "-"
                                    height: 50
                                    width:10
                                }
                                TextField{
                                    id: uavFlightHeightMax
                                    //width: 50
                                    Layout.preferredWidth: 50
                                    //Layout.preferredHeight: 50
                                }

                                Label{
                                    id:uavFlightSpeed
                                    text: "飞行速度范围(Km/h):"
                                    height: 50
                                    width:100
                                }
                                TextField{
                                    id: uavFlightSpeedMin
                                    Layout.preferredWidth: 50
                                }
                                Label{
                                    id:uavFlightSpeedRange
                                    text: "-"
                                    height: 50
                                    width:10
                                }
                                TextField{
                                    id: uavFlightSpeedMax
                                    Layout.preferredWidth: 50
                                }
                                Label{
                                    id:uavFlightDistanceRange
                                    text: "航程范围(km):"
                                    height: 50
                                    width:100
                                }
                                TextField{
                                    id: uavFlightDistance
                                    Layout.preferredWidth: 80
                                }
                                Label{
                                    id:uavFlightTimeRange
                                    text: "航时范围(h):"
                                    height: 50
                                    width:100
                                }
                                TextField{
                                    id: uavFlightTime
                                    Layout.preferredWidth: 80
                                }
                            }
                            RowLayout {
                                // anchors.fill: parent
                                Layout.fillWidth: true
                                // Layout.fillHeight: true
                                spacing: 10
                                Label{
                                    id:uavTakeoffDistance
                                    text: "起飞滑跑距离(m):"
                                    height: 50
                                    width:100
                                    // anchors.left: parent.left //锚点属性与锚点边距一起用。
                                    // anchors.leftMargin: 10
                                    Layout.leftMargin: 10

                                }

                                TextField{
                                    id: uavTakeoffDistanceValue
                                    //width: 50
                                    Layout.preferredWidth: 50
                                    //Layout.preferredHeight: 50
                                }

                                Label{
                                    id:uavLandDistance
                                    text: "着陆滑跑距离(m):"
                                    height: 50
                                    width:100
                                }
                                TextField{
                                    id: uavLandDistanceValue
                                    Layout.preferredWidth: 50
                                }
                                Label{
                                    id:uavTurningRadiusRange
                                    text: "转弯半径范围(Km):"
                                    height: 50
                                    width:100
                                }
                                TextField{
                                    id: uavTurningRadiusMin
                                    Layout.preferredWidth: 80
                                }
                                Label{
                                    id:uavFlightSpeedRangeValue
                                    text: "-"
                                    height: 50
                                    width:10
                                }
                                TextField{
                                    id: uavTurningRadiusMax
                                    Layout.preferredWidth: 80
                                }
                                Label{
                                    id:uavOperatioanalRadiusRange
                                    text: "作战半径:"
                                    height: 50
                                    width:100
                                }
                                TextField{
                                    id: uavOperatioanalRadius
                                    Layout.preferredWidth: 80
                                }
                            }

                            RowLayout {
                                // anchors.fill: parent
                                Layout.fillWidth: true
                                // Layout.fillHeight: true
                                spacing: 10
                                Label{
                                    id:uavInvestigationPayloadType
                                    text: "侦察载荷类型:"
                                    height: 50
                                    width:100
                                    Layout.leftMargin: 10
                                }
                                // ButtonGroup {
                                //         id: uavInvestigationPayloadTypeGroup
                                //         exclusive: false // 关键！允许复选
                                //         checkState: groupCheckBox.checkState
                                //     }

                                //     // CheckBox {
                                //     //     id: groupCheckBox
                                //     //     text: "全选"
                                //     //     checkState: checkboxGroup.checkState
                                //     //     onCheckStateChanged: {
                                //     //         if (checkState === Qt.Checked) {
                                //     //             checkboxGroup.checkAll()
                                //     //         } else if (checkState === Qt.Unchecked) {
                                //     //             checkboxGroup.uncheckAll()
                                //     //         }
                                //     //     }
                                //     // }

                                //     Repeater {
                                //         id:uavInves
                                //         model:["无载荷","电子侦察","图像侦察","气象侦察","激光引导"]
                                //         CheckBox {

                                //             text: modelData
                                //             ButtonGroup.group: uavInvestigationPayloadTypeGroup

                                //         }
                                //     }
                                MultiCombox{
                                    id:uavInvestigationPayloadTypeMultiComBox
                                    items: addUavModelData.payloadType//["无载荷","电子侦察","图像侦察","气象侦察","激光引导"]
                                    // Component.onCompleted: {
                                    //             // 关键：创建新数组触发更新
                                    //             //selectedItems = ["电子侦察", "图像侦察", "气象侦察", "激光引导"].slice();
                                    //             loadUavModelData()
                                    //         }
                                    // 处理选中值变化
                                    onSelectionChanged: {
                                        // var selectedLabels = selectedItems.map(item => item.label)
                                        // uavInvestigationPayloadTypeResult = selectedLabels.join(", ")
                                        var value = selectedItems
                                        uavInvestigationPayloadTypeResult = value
                                        console.log("uavInvestigationPayloadTypeMultiComBox"+value)
                                    }
                                }
                                Label{
                                     id:uavLoadReconnaissanceRange
                                     text: "载荷侦察范围(Km):"  //
                                     height: 50
                                     width:100
                                     //visible: uavTypeSelect.currentText == "侦察无人机"
                                     //Layout.leftMargin: 10
                                 }

                                 TextField{
                                     id: uavLoadReconnaissanceRangeValue
                                     //width: 50
                                     Layout.preferredWidth: 80
                                     //visible: uavTypeSelect.currentText == "侦察无人机"
                                     //Layout.preferredHeight: 50
                                 }
                                 Label{
                                     id:uavLoadReconnaissanceAccuracy
                                     text: "载荷侦察精度(m):"  //
                                     height: 50
                                     width:100
                                     //visible: uavTypeSelect.currentText == "侦察无人机"
                                     Layout.leftMargin: 10
                                 }

                                 TextField{
                                     id: uavLoadReconnaissanceAccuracyValue
                                     //width: 50
                                     Layout.preferredWidth: 80
                                     //visible: uavTypeSelect.currentText == "侦察无人机"
                                     //Layout.preferredHeight: 50
                                 }
                            }  
                            RowLayout {
                                // anchors.fill: parent
                                Layout.fillWidth: true
                                // Layout.fillHeight: true

                                spacing: 10
                                Label{
                                    id:uavRecoverymode
                                    text: "回收方式:"
                                    height: 50
                                    width:100
                                    Layout.leftMargin: 10
                                }
                                MultiCombox{
                                    id:uavRecoverymodeMultiComBox
                                    items: addUavModelData.recoveryWay//["不可回收","伞降","滑跑着陆","垂直着陆"]
                                    onSelectionChanged: {
                                        var value = selectedItems
                                        uavRecoveryModeResult = value
                                        //console.log("uavRecoverymodeMultiComBox"+value)
                                    }
                                }
                                Label{
                                    id:operationMode
                                    text: "操控方式:"
                                    height: 50
                                    width:100
                                    Layout.leftMargin: 10
                                }
                                MultiCombox{
                                    id:operationModeMultiComBox
                                    items: addUavModelData.operationWay//["指令模式","修正模式","自主控制模式","遥控指令模式"]
                                    onSelectionChanged: {
                                        //var selectedLabels = operationModeMultiComBox.selectedItems.map(item => item.label)
                                        // = selectedLabels.join(", ")
                                        var value = selectedItems
                                        uavOperatioanalModeResult = value
                                        //console.log("operationModeMultiComBox"+value)

                                    }
                                }
                            }
                            RowLayout {
                                // anchors.fill: parent
                                Layout.fillWidth: true
                                // Layout.fillHeight: true
                                spacing: 10
                                Label{
                                    id:uavLowAltitudeBreakthroughSpeed
                                    text: "低空突防速度(km/h):"
                                    height: 50
                                    width:100
                                    // anchors.left: parent.left //锚点属性与锚点边距一起用。
                                    // anchors.leftMargin: 10
                                    Layout.leftMargin: 10

                                }

                                TextField{
                                    id: uavLowAltitudeBreakthroughSpeedValue
                                    //width: 50
                                    Layout.preferredWidth: 50
                                    //Layout.preferredHeight: 50
                                }

                                Label{
                                    id:uavHangingLocation
                                    text: "挂载位置:"
                                    height: 50
                                    width:100
                                }
                                // TextField{
                                //     id: uavHangingLocationValue
                                //     Layout.preferredWidth: 50
                                // }


                                // 下拉箭头
                                Text {
                                    id: dropdownIcon
                                    anchors.right: parent.right
                                    anchors.verticalCenter: parent.verticalCenter
                                    //rightPadding: 10
                                    text: "▼"
                                    font.pixelSize: 12
                                }
                                // // Text {
                                // //     id: uavHangingLocationText
                                // //     text: qsTr("请选择")
                                // // }
                                //点击区域
                                MouseArea {
                                    anchors.fill: parent
                                    onClicked: { //uavHangingLocationText.visible = !uavHangingLocationText.visible
                                            mountLocationManagementPopup.open()
                                            //uavManagementroot.managementType = "bombingMethod"
                                            uavManagementroot.enabled = false
                                        }
                                }


                                // 直接调用组件的获取选中数据方法
                                // const selectedData = multiTextDispay.getSelectedData()
                                // console.log("=== 选中数据 ===", JSON.stringify(selectedData, null, 2))

                            }
                            RowLayout {
                                    // anchors.fill: parent
                                    Layout.fillWidth: true
                                    // Layout.fillHeight: true
                                    spacing: 10
                                Label{
                                    id:uavAttackaccuracy
                                    text: "攻击精度(m):"
                                    height: 50
                                    width:100
                                    Layout.leftMargin: 10
                                }
                                TextField{
                                    id: uavAttackaccuracyValue
                                    Layout.preferredWidth: 50
                                }
                                Label{
                                    id:uavRadarCrossSection
                                    text: "雷达反射面积(m²):"
                                    height: 50
                                    width:100
                                }
                                TextField{
                                    id: uavRadarCrossSectionValue
                                    Layout.preferredWidth: 50
                                }
                                Label{
                                    id:uavCenterOfGravityFrontLimit
                                    text: "重心前限(%MAC):"
                                    height: 50
                                    width:100
                                }
                                TextField{
                                    id: uavCenterOfGravityFrontLimitValue
                                    Layout.preferredWidth: 50
                                }
                                Label{
                                    id:uavCenterOfGravityAfterwardLimit
                                    text: "重心后限(%MAC):"
                                    height: 50
                                    width:100
                                }
                                TextField{
                                    id: uavCenterOfGravityAfterwardLimitValue
                                    Layout.preferredWidth: 50
                                }
                            }
                            RowLayout {
                                    // anchors.fill: parent
                                    Layout.fillWidth: true
                                    // Layout.fillHeight: true
                                    spacing: 10
                                Label{
                                    id:uavMaximumTakeoffWeight
                                    text: "最大起飞重量(Kg):"
                                    height: 50
                                    width:100
                                    Layout.leftMargin: 10
                                }
                                TextField{
                                    id: uavMaximumTakeoffWeightValue
                                    Layout.preferredWidth: 50
                                }
                                Label{
                                    id:uavEmptyWeight
                                    text: "空机重量(Kg):"
                                    height: 50
                                    width:100
                                }
                                TextField{
                                    id: uavEmptyWeightValue
                                    Layout.preferredWidth: 50
                                }
                                Label{
                                    id:uavMaximumFuelCapacity
                                    text: "最大载油量(Kg):"
                                    height: 50
                                    width:100
                                }
                                TextField{
                                    id: uavMaximumFuelCapacityValue
                                    Layout.preferredWidth: 50
                                }
                                Label{
                                    id:uavMaximumExternalWeight
                                    text: "最大外挂重量(Kg):"
                                    height: 50
                                    width:100
                                }
                                TextField{
                                    id: uavMaximumExternalWeightValue
                                    Layout.preferredWidth: 50
                                }
                            }
                            RowLayout {
                                    // anchors.fill: parent
                                    Layout.fillWidth: true
                                    // Layout.fillHeight: true
                                    spacing: 10
                                Label{
                                    id:uavCeiling
                                    text: "最大飞行高度(m):"
                                    height: 50
                                    width:100
                                    Layout.leftMargin: 10
                                }
                                TextField{
                                    id: uavCeilingValue
                                    Layout.preferredWidth: 50
                                }
                                Label{
                                    id:uavMaximumGroundStartingHeight
                                    text: "地面最大起动高度(m):"
                                    height: 50
                                    width:100
                                }
                                TextField{
                                    id: uavMaximumGroundStartingHeightValue
                                    Layout.preferredWidth: 50
                                }
                                Label{
                                    id:uavMaximumAirStartingAltitude
                                    text: "空中最大起动高度(m):"
                                    height: 50
                                    width:100
                                }
                                TextField{
                                    id: uavMaximumAirStartingAltitudeValue
                                    Layout.preferredWidth: 50
                                }
                                Label{
                                    id:uavMaximumEndurance
                                    text: "最大续航时间(h):"
                                    height: 50
                                    width:100
                                }
                                TextField{
                                    id: uavMaximumEnduranceValue
                                    Layout.preferredWidth: 50
                                }
                            }
                            RowLayout {
                                    // anchors.fill: parent
                                    Layout.fillWidth: true
                                    // Layout.fillHeight: true
                                    spacing: 10
                                Label{
                                    id:uavMaximumFlightVacuumSpeed
                                    text: "最大飞行真空速(Km/h):"
                                    height: 50
                                    width:100
                                    Layout.leftMargin: 10
                                }
                                TextField{
                                    id: uavMaximumFlightVacuumSpeedValue
                                    Layout.preferredWidth: 50
                                }
                                Label{
                                    id:uavMinimumFlightMeterSpeed
                                    text: "最小飞行表速(Km/h):"
                                    height: 50
                                    width:100
                                }
                                TextField{
                                    id: uavMinimumFlightMeterSpeedValue
                                    Layout.preferredWidth: 50
                                }
                                Label{
                                    id:sealLevelTakeoffAndRollDistance
                                    text: "海平面起飞滑跑距离(m):"
                                    height: 50
                                    width:100
                                }
                                TextField{
                                    id: sealLevelTakeoffAndRollDistanceValue
                                    Layout.preferredWidth: 50
                                }
                                Label{
                                    id:sealLevelLandingAndRollDistance
                                    text: "海平面着陆滑跑距离(h):"
                                    height: 50
                                    width:100
                                }
                                TextField{
                                    id: sealLevelLandingAndRollDistanceValue
                                    Layout.preferredWidth: 50
                                }
                            }
                            RowLayout {
                                    // anchors.fill: parent
                                    Layout.fillWidth: true
                                    // Layout.fillHeight: true
                                    spacing: 10
                                Label{
                                    id:cruiseAltitudeReconnaissanceConfiguration
                                    text: "侦察构型巡航高度(m):"
                                    height: 50
                                    width:100
                                    Layout.leftMargin: 10
                                }
                                TextField{
                                    id: cruiseAltitudeReconnaissanceConfigurationValue
                                    Layout.preferredWidth: 50
                                }
                                Label{
                                    id:cruiseAltitudeFullExternalConfiguration
                                    text: "满外挂构型巡航高度(m):"
                                    height: 50
                                    width:100
                                }
                                TextField{
                                    id: cruiseAltitudeFullExternalConfigurationValue
                                    Layout.preferredWidth: 50
                                }
                                Label{
                                    id:uavBombingmethod
                                    text: "投弹方式:"  // uavTypeSelect.currentText === "侦察无人机" ? "速度:" : "投弹方式:"
                                    height: 50
                                    width:100
                                    visible: uavTypeSelect.currentText !== "侦察无人机"
                                    Layout.leftMargin: 10
                                }
                                RowLayout {
                                        visible: uavTypeSelect.currentText !== "侦察无人机"  // 非侦察机时显示
                                        spacing: 5
                                        MultiCombox{
                                            id:uavBombingmethodMultiComBox
                                            items: addUavModelData.bombWay//["非精确制导","精确制导","自由落体","水平轰炸反俯冲轰炸","俯冲轰炸"]
                                            onSelectionChanged: {
                                                // var selectedLabels = selectedItems.map(item => item.label)
                                                // uavBombingmethodResult = selectedLabels.join(", ")
                                                var value = selectedItems
                                                uavBombingmethodResult = value
                                                console.log("uavBombingmethodMultiComBox"+value)
                                            }

                                        }
                                }
                            }
                            // Text {
                            //     Layout.fillWidth: true
                            //     verticalAlignment: Text.AlignVCenter
                            //     horizontalAlignment: Text.AlignHCenter
                            //     text: qsTr("接装问题记录");
                            //     font.pointSize: 28
                            //     color: "black"
                            // }


                        }
                        ColumnLayout{
                            //anchors.fill: parent
                            //Layout.fillWidth: true
                            Layout.fillHeight: true
                            spacing: 10
                            Button{
                                id:imageSelect
                                width:100
                                height:50
                                anchors.right: parent.right
                                anchors.rightMargin: 2
                                anchors.top: parent.top
                                anchors.topMargin: 8
                                // anchors.bottom: parent.bottom
                                // anchors.bottomMargin: 10
                                text: "选择图片"
                                onClicked: {
                                    fileDialog.open()
                                }
                            }
                            Rectangle {
                                id: aroot
                                visible: true
                                width:500
                                height: 600
                                // anchors.top: parent.top
                                // anchors.topMargin: 40
                                // anchors.right: parent.right
                                // anchors.rightMargin: 2
                                Layout.alignment:Qt.AlignRight
                                color: "#ECF2FE"
                                border.color: "#BDBDBD"

                                Image {
                                    id: uavImg
                                    //source: "qrc:/resource/1.jpg"
                                    anchors.fill: parent
                                }
                                Column {
                                    anchors.centerIn: parent
                                    spacing: 10

                                    Text {
                                        anchors.horizontalCenter: parent.horizontalCenter
                                        text: "图片展示区域"
                                        color: "#9E9E9E"
                                        font.italic: true
                                    }
                                }
                            }


                        }
                    }
                // 下部行布局（底部对齐）
                    RowLayout {
                        Layout.fillWidth: true
                        Layout.alignment: Qt.AlignBottom  // 底部对齐
                        spacing: 10
                        Item { Layout.fillWidth: true }  // 占位空格元素
                        Button {
                            id:saveButton
                            anchors.right: parent.right
                            anchors.rightMargin: 200
                            width: 100
                            height: 50
                            text: "保存"
                            onClicked:{
                                if(processInfo.loadViewType === "addUavData"){

                                    console.log("addUavDataView"+processInfo.loadViewType)
                                    addUavModelData.currentTime = new Date().toLocaleString()
                                    console.log("addUavModelData.currentTime"+addUavModelData.currentTime)
                                    saveUavData()

                                }else if(processInfo.loadViewType === "query"){
                                    //loadUavModelData()
                                    //writeControl(false)


                                    console.log("addUavDataView"+processInfo.loadViewType)
                                }else if(processInfo.loadViewType === "update"){
                                    updataUavModelData()

                                    console.log("addUavDataView"+processInfo.loadViewType)
                                }else{
                                    console.log("processInfo.loadViewType Unknown")
                                }

                            }
                        }

                        Button {
                            id:cancleButton
                            anchors.right: parent.right
                            anchors.rightMargin: 10
                            width: 100
                            height: 50
                            text: "取消"
                        }
                    }
                    FileDialog {
                        id: fileDialog
                        title: "选择图片"
                        nameFilters: ["图片文件 (*.png *.jpg *.jpeg)"]
                        onAccepted: {
                            uavImg.source = fileUrls[0]
                            var currentModel = navBar.currentIndex === 0 ? droneModel : schemeModel
                            for(var i = 0; i < currentModel.count; i++){
                                if(currentModel.get(i).expanded){
                                    currentModel.get(i).items.push({
                                        name: "新条目",
                                        selected: false
                                    });
                                    break;
                                }
                            }
                        }
                    }
        }



    }
    //判断是否加载新增、查看、编辑
    function loadView(){
        var viewType = processInfo.loadViewType
        if(processInfo.loadViewType === "addUavData"){

            console.log("addUavDataView"+processInfo.loadViewType)

        }else if(processInfo.loadViewType === "query"){
            loadUavModelData()
            writeControl(false)
            saveButton.enabled = false

            console.log("addUavDataView"+processInfo.loadViewType)
        }else if(processInfo.loadViewType === "update"){
            loadUavModelData()
            writeControl(true)
            saveButton.text = "编辑"
            console.log("addUavDataView"+processInfo.loadViewType)
        }else{
            console.log("processInfo.loadViewType Unknown")
        }
    }
    function loadUavComponentData(){
        var uavBombWay = uavBombingMethodDaoModel.selectUavModelBombingMethodAllData()
        var uavPayloadType = uavModelLoadTypeDaoModel.selectUavModelLoadTypeAllData()
        var uavRecoveryWay = uavModelRecoveryModeDaoModel.selectModelRecoveryModeAllData()
        var uavOperationWay = uavModelOperationWayDaoModel.selectModelOperationWayAllData()
        console.log("uavBombWay"+JSON.stringify(uavBombWay))
        var bombWaynames = extractNames(uavBombWay);
        addUavModelData.bombWay = bombWaynames
        var payloadTypeNames = extractNames(uavPayloadType)
        var recoveryWayNames = extractNames(uavRecoveryWay)
        var operationWayNames = extractNames(uavOperationWay)
        //console.log("提取的名称数组:", names +"addUavModelData.bombWay"+addUavModelData.bombWay);
        addUavModelData.payloadType = payloadTypeNames
        addUavModelData.recoveryWay = recoveryWayNames
        addUavModelData.operationWay = operationWayNames
    }
    // 提取 uavComponeName 并封装成数组
    function extractNames(data) {
        return data.map(item => item.uavComponeName);
    }
    function loadMountLocationContent(){
        if(processInfo.loadViewType === "addUavData"){
           var receiveData = uavMountLocationDaoTableModel.selectUavMountLocationAllData()
           console.log("MultiTextOfCombox+:", JSON.stringify(receiveData, null, 2));
            addUavModelData.mountContent = receiveData
           // 打印当前函数的名称
            console.log("当前函数名称:", arguments.callee.name);
            console.log("addUavDataView"+processInfo.loadViewType)

        }else if(processInfo.loadViewType === "query"){

            console.log("addUavDataView"+processInfo.loadViewType)
        }else if(processInfo.loadViewType === "update"){

            console.log("addUavDataView"+processInfo.loadViewType)
        }else{
            console.log("processInfo.loadViewType Unknown")
        }
    }

    function loadUavModelData(){
        var uavAllData = processInfo.uavModelJsonStr
        var uavDataStr = JSON.stringify(uavAllData)
        ///console.log("loadUavModelData"+ uavDataStr)
        var selectUavData = uavModelDao.selectSomeUavModelDate(uavDataStr)
        console.log("selectUavData"+JSON.stringify(selectUavData))


        // if (selectUavData && selectUavData.payload_type) {

        //         var payloadTypes = selectUavData.payload_type.split(",");
        //         console.log("uavInvestigationPayloadTypeMultiComBox: "+payloadTypes)
        //         uavInvestigationPayloadTypeMultiComBox.selectedItems = payloadTypes.slice();
        //     }
        loadMultiSelect(selectUavData)
        //对于Combox组件加载数据
        const uavTypeSelecttargetIndex = uavTypeSelect.model.indexOf(selectUavData.uavType);
        console.log("索引值:", uavTypeSelecttargetIndex); // 输出 0
        if (uavTypeSelecttargetIndex !== -1) {
            uavTypeSelect.currentIndex = uavTypeSelecttargetIndex;
        }
        const uavInvisibilitySelecttargetIndex = uavInvisibilitySelect.model.indexOf(selectUavData.invisibility);
        console.log("索引值:", uavInvisibilitySelecttargetIndex); // 输出 0
        if (uavInvisibilitySelecttargetIndex !== -1) {
            uavInvisibilitySelect.currentIndex = uavInvisibilitySelecttargetIndex;
        }
        //在MultiCombox加载数据
        //generateTestData()
        uavHangingLocationValue.text = selectUavData.hardpoint_loc
        uavNameText.text = selectUavData.uavName
        uavIdText.text = selectUavData.uavId
        uavLengthText.text = selectUavData.uavLength
        uavWidthText.text = selectUavData.uavWidth
        uavHeightText.text = selectUavData.uavHeight

        uavFlightHeightMin.text = selectUavData.flight_height_min
        uavFlightHeightMax.text = selectUavData.flight_height_max
        uavFlightSpeedMin.text = selectUavData.flight_speed_min
        uavFlightSpeedMax.text = selectUavData.flight_speed_max
        uavTurningRadiusMin.text = selectUavData.turn_radius_min
        uavTurningRadiusMax.text = selectUavData.turn_radius_max
        uavFlightDistance.text = selectUavData.flight_distance_max
        //uavRecoveryModeResult.currentText = selectUavData.recovery_mode
        uavFlightTime.text = selectUavData.flight_time_max
        uavTakeoffDistanceValue.text = selectUavData.takeoff_distance
        uavLandDistanceValue.text = selectUavData.landing_distance
        uavOperatioanalRadius.text = selectUavData.combat_radius
        uavLoadReconnaissanceRangeValue.text = selectUavData.recon_range_max
        uavLoadReconnaissanceAccuracyValue.text = selectUavData.recon_accuracy
        uavLowAltitudeBreakthroughSpeedValue.text = selectUavData.low_alt_speed
        uavAttackaccuracyValue.text = selectUavData.attack_accuracy
        uavRadarCrossSectionValue.text = selectUavData.rcs
        uavCenterOfGravityFrontLimitValue.text = selectUavData.cg_front_limit
        uavCenterOfGravityAfterwardLimitValue.text = selectUavData.cg_rear_limit
        uavMaximumTakeoffWeightValue.text = selectUavData.max_takeoff_weight
        uavMaximumFuelCapacityValue.text = selectUavData.max_fuel
        uavMaximumExternalWeightValue.text = selectUavData.max_external_weight
        uavCeilingValue.text = selectUavData.ceiling
        uavMaximumAirStartingAltitudeValue.text = selectUavData.air_start_alt
        uavMaximumGroundStartingHeightValue.text = selectUavData.ground_start_alt
        uavMaximumEnduranceValue.text = selectUavData.endurance
        uavMaximumFlightVacuumSpeedValue.text = selectUavData.max_vacuum_speed
        uavMinimumFlightMeterSpeedValue.text = selectUavData.min_meter_speed
        sealLevelTakeoffAndRollDistanceValue.text = selectUavData.sea_takeoff_roll
        sealLevelLandingAndRollDistanceValue.text = selectUavData.sea_landing_roll
        cruiseAltitudeReconnaissanceConfigurationValue.text = selectUavData.recon_cruise_alt
        cruiseAltitudeFullExternalConfigurationValue.text = selectUavData.full_external_cruise_alt
    }
    function loadMultiSelect(selectUavData){

        //var selectUavData = uavModelDao.selectSomeUavModelDate(uavDataStr)

        console.log("loadMultiSelect"+JSON.stringify(selectUavData))
        if (selectUavData && selectUavData.payload_type) {
                var payloadTypes = selectUavData.payload_type.split(",");
                console.log("uavInvestigationPayloadTypeMultiComBox: "+payloadTypes)
                uavInvestigationPayloadTypeMultiComBox.selectedItems = payloadTypes.slice();
        }
        if (selectUavData && selectUavData.bomb_method) {
                var bombMethod = selectUavData.bomb_method.split(",");
                console.log("uavInvestigationPayloadTypeMultiComBox: "+bombMethod)
                uavBombingmethodMultiComBox.selectedItems = bombMethod.slice();
        }
        if (selectUavData && selectUavData.operation_method) {
                var operationMethod = selectUavData.operation_method.split(",");
                console.log("uavInvestigationPayloadTypeMultiComBox: "+operationMethod)
                operationModeMultiComBox.selectedItems = operationMethod.slice();
        }
        if (selectUavData && selectUavData.recovery_mode) {
                var recoveryMode = selectUavData.recovery_mode.split(",");
                console.log("uavInvestigationPayloadTypeMultiComBox: "+recoveryMode)
                uavRecoverymodeMultiComBox.selectedItems = recoveryMode.slice();
        }
    }

    function writeControl(isEditable) {
        // 遍历输入容器的所有子元素
        for (var i = 0; i < controlUav.children.length; i++) {
            var child = controlUav.children[i];
            // 检查是否是输入框或下拉框
            if (child.hasOwnProperty("enabled")) {
                //child.enabled = isEditable;

            }
        }

    }

    // 检查变量是否为空的函数
    function isEmpty(value) {
        if (typeof value === "string") {
            return value.length === 0;
        } else if (typeof value === "object" && value !== null) {
            return Object.keys(value).length === 0;
        } else {
            return value === null || value === undefined;
        }
    }
    // 定义一个通用的验证函数
   function validateInput(field, message) {
       if (field === "" || (field.length !== undefined && field.length === 0)) {
           warningPopup.open();
           warningItem.text = message;
           autoCloseTimer.start()
           return false;
       }
       return true;
   }

    function checkAllValue(){
        var isValid = true;
        // 检查每个字段
        isValid = validateInput(uavTypeSelect.currentText, "无人机类型未选择!") && isValid;
        isValid = validateInput(uavNameText.text, "无人机名称未填写!") && isValid;
        isValid = validateInput(uavIdText.text, "无人机编号未填写!") && isValid;
        isValid = validateInput(uavLengthText.text, "无人机长度未填写!") && isValid;
        isValid = validateInput(uavWidthText.text, "无人机翼宽未填写!") && isValid;
        isValid = validateInput(uavHeightText.text, "无人机高度未填写!") && isValid;
        isValid = validateInput(uavInvisibilitySelect.currentText, "无人机隐身性未选择!") && isValid;
        isValid = validateInput(uavFlightHeightMin.text, "无人机飞行高度最小值未填写!") && isValid;
        isValid = validateInput(uavFlightHeightMax.text, "无人机飞行高度最大值未填写!") && isValid;
        isValid = validateInput(uavFlightSpeedMin.text, "无人机飞行速度最小值未填写!") && isValid;
        isValid = validateInput(uavFlightSpeedMax.text, "无人机飞行速度最大值未填写!") && isValid;
        isValid = validateInput(uavTurningRadiusMin.text, "无人机转弯半径最小值未填写!") && isValid;
        isValid = validateInput(uavTurningRadiusMax.text, "无人机转弯半径最大值未填写!") && isValid;
        isValid = validateInput(uavFlightDistance.text, "无人机飞行航程值未填写!") && isValid;
        isValid = validateInput(uavRecoveryModeResult, "回收方式未选择!") && isValid;
        isValid = validateInput(uavFlightTime.text, "无人机航时值未填写!") && isValid;
        isValid = validateInput(uavTakeoffDistanceValue.text, "无人机起飞滑跑距离未填写!") && isValid;
        isValid = validateInput(uavLandDistanceValue.text, "无人机着陆滑跑距离未填写!") && isValid;
        isValid = validateInput(uavOperatioanalRadius.text, "无人机作战距离未填写!") && isValid;
        isValid = validateInput(uavLoadReconnaissanceRangeValue.text, "无人机侦察范围未填写!") && isValid;
        isValid = validateInput(uavLoadReconnaissanceAccuracyValue.text, "无人机侦察精度未填写!") && isValid;
        isValid = validateInput(uavLowAltitudeBreakthroughSpeedValue.text, "无人机低空突防速度未填写!") && isValid;
        isValid = validateInput(uavAttackaccuracyValue.text, "无人机攻击精度未填写!") && isValid;
        isValid = validateInput(uavRadarCrossSectionValue.text, "无人机的雷达反射面积未填写!") && isValid;
        isValid = validateInput(uavCenterOfGravityFrontLimitValue.text, "无人机重心前向未填写!") && isValid;
        isValid = validateInput(uavCenterOfGravityAfterwardLimitValue.text, "无人机重心后向未填写!") && isValid;
        isValid = validateInput(uavMaximumTakeoffWeightValue.text, "无人机最大起飞重量未填写!") && isValid;
        isValid = validateInput(uavMaximumFuelCapacityValue.text, "无人机最大载油重量未填写!") && isValid;
        isValid = validateInput(uavMaximumExternalWeightValue.text, "无人机最大外挂重量未填写!") && isValid;
        isValid = validateInput(uavCeilingValue.text, "无人机最大升限未填写!") && isValid;
        isValid = validateInput(uavMaximumAirStartingAltitudeValue.text, "无人机空中最大起动高度未填写!") && isValid;
        isValid = validateInput(uavMaximumGroundStartingHeightValue.text, "无人机地面最大起动高度未填写!") && isValid;
        isValid = validateInput(uavMaximumEnduranceValue.text, "无人机最大续航时间未填写!") && isValid;
        isValid = validateInput(uavMaximumFlightVacuumSpeedValue.text, "无人机最大飞行真空速未填写!") && isValid;
        isValid = validateInput(uavMinimumFlightMeterSpeedValue.text, "无人机最小飞行表速未填写!") && isValid;
        isValid = validateInput(sealLevelTakeoffAndRollDistanceValue.text, "无人机海平面起飞滑跑距离未填写!") && isValid;
        isValid = validateInput(sealLevelLandingAndRollDistanceValue.text, "无人机海平面着陆滑跑距离未填写!") && isValid;
        isValid = validateInput(cruiseAltitudeReconnaissanceConfigurationValue.text, "无人机侦察构型巡航高度未填写!") && isValid;
        isValid = validateInput(cruiseAltitudeFullExternalConfigurationValue.text, "无人机满外挂构型巡航高度未填写!") && isValid;
        return isValid;

    }


    function saveUavData(){
        console.log("uavTypeSelevtContent"+uavTypeSelect.currentText+"-"+"testValue"+uavTypeSelect.currentValue)

        var uavData = {
            //-- 基础信息
            // uav_type VARCHAR(255) NOT NULL,
            // uav_name VARCHAR(255),
            // uav_id VARCHAR(255) NOT NULL,
            uav_type:"",
            uav_name:"",
            uav_id:"",
            //-- 尺寸参数
            // length REAL,
            // width REAL,
            // height REAL,
            // invisibility VARCHAR(255),
            length:0.0, // 浮点数
            width:0.0, // 浮点数
            height:0.0, // 浮点数
            invisibility:0.0, // 浮点数
            //-- 飞行性能
            // flight_height_min REAL,
            // flight_height_max REAL,
            // flight_speed_min REAL,
            // flight_speed_max REAL,
            // flight_distance_min REAL,
            // flight_distance_max REAL,
            // flight_time_min REAL,
            // flight_time_max REAL,
            flight_height_min:0.0, // 浮点数
            flight_height_max:0.0, // 浮点数
            flight_speed_min:0.0, // 浮点数
            flight_speed_max:0.0, // 浮点数
            flight_distance_min:0.0, // 浮点数
            flight_distance_max:0.0, // 浮点数
            flight_time_min:0.0, // 浮点数
            flight_time_max:0.0, // 浮点数
            //-- 起降参数
            //takeoff_distance REAL,
            //landing_distance REAL,

            //-- 机动性能
            //turn_radius_min REAL,
            // turn_radius_max REAL,
            //combat_radius REAL,
            takeoff_distance:0.0, // 浮点数
            landing_distance:0.0, // 浮点数
            turn_radius_min:0.0, // 浮点数
            turn_radius_max:0.0, // 浮点数
            combat_radius:0.0, // 浮点数

            //-- 载荷配置
            // payload_type VARCHAR(255),
            // bomb_method VARCHAR(255),
            // recon_range_min REAL,
            // recon_range_max REAL,
            // recon_accuracy REAL,

            payload_type:"",
            bomb_method:"",
            recon_range_min:0.0, // 浮点数
            recon_range_max:0.0, // 浮点数
            recon_accuracy:0.0, // 浮点数
            //-- 回收与突防
            // recovery_mode VARCHAR(255),
            // low_alt_speed REAL,

            //-- 挂载能力
            //hanging_capacity VARCHAR(255),

            //-- 操控与攻击
            // operation_method VARCHAR(255),  -- 注意：建议修正拼写为
            // attack_accuracy REAL,

            //-- 雷达特征
            //rcs REAL,
            recovery_mode:"",
            low_alt_speed:0.0, // 浮点数
            hanging_capacity:"",
            operation_method:"",
            attack_accuracy:0.0, // 浮点数
            rcs:0.0, // 浮点数
            //-- 重量与平衡
            // cg_front_limit REAL,
            // cg_rear_limit REAL,
            // max_takeoff_weight REAL,
            // empty_weight REAL,

            //-- 燃油与载重
            // max_fuel REAL,
            // max_external_weight REAL,

            //-- 高度性能
            // ceiling REAL,
            // ground_start_alt REAL,
            // air_start_alt REAL,

            //-- 续航性能
            // endurance REAL,
            // max_vacuum_speed REAL,
            // min_meter_speed REAL,
            cg_front_limit:0.0, // 浮点数
            cg_rear_limit:0.0, // 浮点数
            max_takeoff_weight:0.0, // 浮点数
            empty_weight:0.0, // 浮点数
            max_fuel:0.0, // 浮点数
            max_external_weight:0.0, // 浮点数
            ceiling:0.0, // 浮点数
            ground_start_alt:0.0, // 浮点数
            air_start_alt:0.0, // 浮点数
            endurance:0.0, // 浮点数
            max_vacuum_speed:0.0, // 浮点数
            min_meter_speed:0.0, // 浮点数
            //-- 特殊场景性能
            // sea_takeoff_roll REAL,
            // sea_landing_roll REAL,
            // recon_cruise_alt REAL,
            // full_external_cruise_alt REAL,

            //-- 系统记录
            // create_time VARCHAR(255),  -- 建议改为 TIMESTAMP
            // image_name VARCHAR(255),
            // image_url VARCHAR(255)

            sea_takeoff_roll:0.0, // 浮点数
            sea_landing_roll:0.0, // 浮点数
            recon_cruise_alt:0.0, // 浮点数
            full_external_cruise_alt:0.0, // 浮点数
            image_name:"",
            image_url:"",
            create_time:""

        };
        //ButtonGroup的接收值转化方法
        // var uavInvestigationPayloadTypeJson = getSelectedPayloads(uavInvestigationPayloadTypeMultiComBox.buttons)
        // console.log("有效载荷选择:", JSON.stringify(uavInvestigationPayloadTypeJson))
        // var uavInvestigationPayloadTypeJsonStr = JSON.stringify(uavInvestigationPayloadTypeJson)
        // var uavInvestigationPayloadTypeJsonStrresult = convertToJsonArray(uavInvestigationPayloadTypeJson);
        // console.log(uavInvestigationPayloadTypeJsonStrresult);

        // var uavBombingmethodGroupJson = getSelectedPayloads(uavBombingmethodMultiComBox.buttons)
        // console.log("投弹方式:", JSON.stringify(uavBombingmethodGroupJson))
        // var uavBombingmethodGroupStr = JSON.stringify(uavInvestigationPayloadTypeJson)
        // var uavBombingmethodGroupJsonStrresult = convertToJsonArray(uavBombingmethodGroupJson);
        // console.log(uavBombingmethodGroupJsonStrresult);

        // var uavRecoverymodeGroupJson = getSelectedPayloads(uavRecoverymodeMultiComBox.buttons)
        // console.log("回收方式:", JSON.stringify(uavRecoverymodeGroupJson))
        // var uavRecoverymodeGroupJsonStr = JSON.stringify(uavRecoverymodeGroupJson)
        // var uavRecoverymodeGroupJsonStrresult = convertToJsonArray(uavRecoverymodeGroupJson);
        // console.log(uavRecoverymodeGroupJsonStrresult);

        // var uavOperatioanalmodeGroupJson = getSelectedPayloads(operationModeMultiComBox.buttons)
        // console.log("操控方式:", JSON.stringify(uavOperatioanalmodeGroupJson))
        // var uavOperatioanalmodeGroupJsonStr = JSON.stringify(uavOperatioanalmodeGroupJson)
        // var uavOperatioanalmodeGroupJsonStrresult = convertToJsonArray(uavOperatioanalmodeGroupJson);
        // console.log(uavOperatioanalmodeGroupJsonStrresult);
        uavData.uav_type = uavTypeSelect.currentText
        uavData.uav_name = uavNameText.text
        uavData.uav_id = uavIdText.text
        uavData.length = uavLengthText.text
        uavData.width = uavWidthText.text
        uavData.height = uavHeightText.text
        uavData.invisibility = uavInvisibilitySelect.currentText

        uavData.flight_height_min = uavFlightHeightMin.text
        uavData.flight_height_max = uavFlightHeightMax.text
        uavData.flight_speed_min = uavFlightSpeedMin.text
        uavData.flight_speed_max = uavFlightSpeedMax.text
        uavData.turn_radius_min = uavTurningRadiusMin.text
        uavData.turn_radius_max = uavTurningRadiusMax.text

        uavData.flight_distance_max = uavFlightDistance.text
        //uavData.hanging_capacity = ""//uavRadarCrossSectionText.text
        //检查是否填写完全
        checkAllValue()
        if(isEmpty(uavInvestigationPayloadTypeResult)){
            warningPopup.open()
            warningItem.text = "侦察载荷类型未选择!"
            autoCloseTimer.start()
        }else{
            uavData.payload_type = JSON.stringify(uavInvestigationPayloadTypeResult.join(",")).replace(/^"|"$/g, "");//uavInvestigationPayloadTypeJsonStrresult

        }
        console.log("uavBombingmethodResult"+uavBombingmethodResult)
        if(isEmpty(uavBombingmethodResult)){
            if(uavTypeSelect.currentText === "侦察无人机"){
                    uavData.bomb_method = ""
            }else{
                    warningPopup.open()
                    warningItem.text = "投弹方式未选择!"
                    autoCloseTimer.start()
            }

        }else{
            uavData.bomb_method = JSON.stringify(uavBombingmethodResult.join(",")).replace(/^"|"$/g, "");//uavBombingmethodGroupJsonStrresult
        }
        if(isEmpty(uavRecoveryModeResult)){
            warningPopup.open()
            warningItem.text = "回收方式未选择!"
            autoCloseTimer.start()
        }else{
            uavData.bomb_method = JSON.stringify(uavRecoveryModeResult.join(",")).replace(/^"|"$/g, "");//uavBombingmethodGroupJsonStrresult
        }
        if(isEmpty(uavOperatioanalModeResult)){
            warningPopup.open()
            warningItem.text = "操作方式未选择!"
            autoCloseTimer.start()
        }else{
            uavData.payload_type = JSON.stringify(uavOperatioanalModeResult.join(",")).replace(/^"|"$/g, "");//uavInvestigationPayloadTypeJsonStrresult

        }
        uavData.hanging_capacity = ""//uavRadarCrossSectionText.text
        uavData.operation_method = JSON.stringify(uavOperatioanalModeResult.join(",")).replace(/^"|"$/g, "");//uavOperatioanalmodeGroupJsonStrresult
        uavData.recovery_mode = JSON.stringify(uavRecoveryModeResult.join(",")).replace(/^"|"$/g, "");//uavRecoverymodeGroupJsonStrresult

        uavData.flight_time_max =  uavFlightTime.text
        uavData.takeoff_distance = uavTakeoffDistanceValue.text
        uavData.landing_distance = uavLandDistanceValue.text
        uavData.combat_radius = uavOperatioanalRadius.text
        //uavData.recon_range_min = uavLoadReconnaissanceAccuracyText.text
        uavData.recon_range_max = uavLoadReconnaissanceRangeValue.text
        uavData.recon_accuracy = uavLoadReconnaissanceAccuracyValue.text

        uavData.low_alt_speed = uavLowAltitudeBreakthroughSpeedValue.text
        uavData.combat_radius = uavOperatioanalRadius.text
        uavData.attack_accuracy = uavAttackaccuracyValue.text
        uavData.rcs = uavRadarCrossSectionValue.text
        uavData.cg_front_limit = uavCenterOfGravityFrontLimitValue.text
        uavData.cg_rear_limit = uavCenterOfGravityAfterwardLimitValue.text
        uavData.max_takeoff_weight = uavMaximumTakeoffWeightValue.text
        uavData.empty_weight = uavEmptyWeightValue.text
        uavData.max_fuel = uavMaximumFuelCapacityValue.text
        uavData.max_external_weight = uavMaximumExternalWeightValue.text
        uavData.ceiling = uavCeilingValue.text
        uavData.ground_start_alt = uavMaximumGroundStartingHeightValue.text
        uavData.air_start_alt = uavMaximumAirStartingAltitudeValue.text
        uavData.endurance = uavMaximumEnduranceValue.text
        uavData.max_vacuum_speed = uavMaximumFlightVacuumSpeedValue.text
        uavData.min_meter_speed = uavMinimumFlightMeterSpeedValue.text
        uavData.sea_takeoff_roll = sealLevelTakeoffAndRollDistanceValue.text
        uavData.sea_landing_roll = sealLevelLandingAndRollDistanceValue.text
        uavData.recon_cruise_alt = cruiseAltitudeReconnaissanceConfigurationValue.text
        uavData.full_external_cruise_alt = cruiseAltitudeFullExternalConfigurationValue.text

        uavData.image_name = ""
        uavData.image_url = ""
        uavData.create_time = addUavModelData.currentTime
        var jsonString = JSON.stringify(uavData);
        console.log("jsonString"+jsonString);

        // uavModelDao.insertModelDate(uavData)
    }
    function updataUavModelData(){
        console.log("updateUavModelData")
        var uavData = {
            //-- 基础信息
            id:0,
            uav_type:"",
            uav_name:"",
            uav_id:"",
            //-- 尺寸参数
            length:0.0, // 浮点数
            width:0.0, // 浮点数
            height:0.0, // 浮点数
            invisibility:0.0, // 浮点数
            //-- 飞行性能
            flight_height_min:0.0, // 浮点数
            flight_height_max:0.0, // 浮点数
            flight_speed_min:0.0, // 浮点数
            flight_speed_max:0.0, // 浮点数
            flight_distance_min:0.0, // 浮点数
            flight_distance_max:0.0, // 浮点数
            flight_time_min:0.0, // 浮点数
            flight_time_max:0.0, // 浮点数
            //-- 起降参数
            //-- 机动性能
            takeoff_distance:0.0, // 浮点数
            landing_distance:0.0, // 浮点数
            turn_radius_min:0.0, // 浮点数
            turn_radius_max:0.0, // 浮点数
            combat_radius:0.0, // 浮点数

            //-- 载荷配置
            payload_type:"",
            bomb_method:"",
            recon_range_min:0.0, // 浮点数
            recon_range_max:0.0, // 浮点数
            recon_accuracy:0.0, // 浮点数
            //-- 回收与突防
            //-- 挂载能力
            //-- 操控与攻击
            //-- 雷达特征
            recovery_mode:"",
            low_alt_speed:0.0, // 浮点数
            hanging_capacity:"",
            operation_method:"",
            attack_accuracy:0.0, // 浮点数
            rcs:0.0, // 浮点数
            //-- 重量与平衡
            //-- 燃油与载重
            //-- 高度性能
            //-- 续航性能
            cg_front_limit:0.0, // 浮点数
            cg_rear_limit:0.0, // 浮点数
            max_takeoff_weight:0.0, // 浮点数
            empty_weight:0.0, // 浮点数
            max_fuel:0.0, // 浮点数
            max_external_weight:0.0, // 浮点数
            ceiling:0.0, // 浮点数
            ground_start_alt:0.0, // 浮点数
            air_start_alt:0.0, // 浮点数
            endurance:0.0, // 浮点数
            max_vacuum_speed:0.0, // 浮点数
            min_meter_speed:0.0, // 浮点数
            //-- 特殊场景性能
            //-- 系统记录
            sea_takeoff_roll:0.0, // 浮点数
            sea_landing_roll:0.0, // 浮点数
            recon_cruise_alt:0.0, // 浮点数
            full_external_cruise_alt:0.0, // 浮点数
            image_name:"",
            image_url:"",
            create_time:""
        };
        uavData.id = processInfo.recordId
        console.log("uavData.id  processInfo.recordId"+uavData.id+"<>"+processInfo.recordId)
        uavData.uav_type = uavTypeSelect.currentText
        uavData.uav_name = uavNameText.text
        uavData.uav_id = uavIdText.text
        uavData.length = uavLengthText.text
        uavData.width = uavWidthText.text
        uavData.height = uavHeightText.text
        uavData.invisibility = uavInvisibilitySelect.currentText

        uavData.flight_height_min = uavFlightHeightMin.text
        uavData.flight_height_max = uavFlightHeightMax.text
        uavData.flight_speed_min = uavFlightSpeedMin.text
        uavData.flight_speed_max = uavFlightSpeedMax.text
        uavData.turn_radius_min = uavTurningRadiusMin.text
        uavData.turn_radius_max = uavTurningRadiusMax.text

        uavData.flight_distance_max = uavFlightDistance.text
        //uavData.hanging_capacity = ""//uavRadarCrossSectionText.text
        //检查是否填写完全
        checkAllValue()
        if(isEmpty(uavInvestigationPayloadTypeResult)){
            warningPopup.open()
            warningItem.text = "侦察载荷类型未选择!"
            autoCloseTimer.start()
        }else{
            uavData.payload_type = JSON.stringify(uavInvestigationPayloadTypeResult.join(",")).replace(/^"|"$/g, "");//uavInvestigationPayloadTypeJsonStrresult

        }
        console.log("payload_type"+uavInvestigationPayloadTypeResult)
        if(isEmpty(uavBombingmethodResult)){
            if(uavTypeSelect.currentText === "侦察无人机"){
                    uavData.bomb_method = "无"
            }else{
                    warningPopup.open()
                    warningItem.text = "投弹方式未选择!"
                    autoCloseTimer.start()
            }

        }else{
            uavData.bomb_method = JSON.stringify(uavBombingmethodResult.join(",")).replace(/^"|"$/g, "");//uavBombingmethodGroupJsonStrresult
        }
        if(isEmpty(uavRecoveryModeResult)){
            warningPopup.open()
            warningItem.text = "回收方式未选择!"
            autoCloseTimer.start()
        }else{
            uavData.recovery_mode = JSON.stringify(uavRecoveryModeResult.join(",")).replace(/^"|"$/g, "");//uavBombingmethodGroupJsonStrresult
        }
        if(isEmpty(uavOperatioanalModeResult)){
            warningPopup.open()
            warningItem.text = "操作方式未选择!"
            autoCloseTimer.start()
        }else{
            uavData.operation_method = JSON.stringify(uavOperatioanalModeResult.join(",")).replace(/^"|"$/g, "");//uavInvestigationPayloadTypeJsonStrresult

        }
        uavData.hanging_capacity = ""//uavRadarCrossSectionText.text
        uavData.operation_method = JSON.stringify(uavOperatioanalModeResult.join(",")).replace(/^"|"$/g, "");//uavOperatioanalmodeGroupJsonStrresult
        uavData.recovery_mode = JSON.stringify(uavRecoveryModeResult.join(",")).replace(/^"|"$/g, "");//uavRecoverymodeGroupJsonStrresult

        uavData.flight_time_max =  uavFlightTime.text
        uavData.takeoff_distance = uavTakeoffDistanceValue.text
        uavData.landing_distance = uavLandDistanceValue.text
        uavData.combat_radius = uavOperatioanalRadius.text
        //uavData.recon_range_min = uavLoadReconnaissanceAccuracyText.text
        uavData.recon_range_max = uavLoadReconnaissanceRangeValue.text
        uavData.recon_accuracy = uavLoadReconnaissanceAccuracyValue.text

        uavData.low_alt_speed = uavLowAltitudeBreakthroughSpeedValue.text
        uavData.combat_radius = uavOperatioanalRadius.text
        uavData.attack_accuracy = uavAttackaccuracyValue.text
        uavData.rcs = uavRadarCrossSectionValue.text
        uavData.cg_front_limit = uavCenterOfGravityFrontLimitValue.text
        uavData.cg_rear_limit = uavCenterOfGravityAfterwardLimitValue.text
        uavData.max_takeoff_weight = uavMaximumTakeoffWeightValue.text
        uavData.empty_weight = uavEmptyWeightValue.text
        uavData.max_fuel = uavMaximumFuelCapacityValue.text
        uavData.max_external_weight = uavMaximumExternalWeightValue.text
        uavData.ceiling = uavCeilingValue.text
        uavData.ground_start_alt = uavMaximumGroundStartingHeightValue.text
        uavData.air_start_alt = uavMaximumAirStartingAltitudeValue.text
        uavData.endurance = uavMaximumEnduranceValue.text
        uavData.max_vacuum_speed = uavMaximumFlightVacuumSpeedValue.text
        uavData.min_meter_speed = uavMinimumFlightMeterSpeedValue.text
        uavData.sea_takeoff_roll = sealLevelTakeoffAndRollDistanceValue.text
        uavData.sea_landing_roll = sealLevelLandingAndRollDistanceValue.text
        uavData.recon_cruise_alt = cruiseAltitudeReconnaissanceConfigurationValue.text
        uavData.full_external_cruise_alt = cruiseAltitudeFullExternalConfigurationValue.text

        uavData.image_name = "hhhhhh"
        uavData.image_url = "hhhhhhhh"
        uavData.create_time = addUavModelData.currentTime
        var jsonString = JSON.stringify(uavData);
        console.log("jsonString"+jsonString);

        uavModelDao.updateModelDate(jsonString)

    }

    function convertToJsonArray(jsonData) {
            return jsonData.map(function(item) {
                return item.name;
            });
    }
    //ButtonGroup的接收值方法
    // function getSelectedPayloads(buttons) {
    //         return Array.from(buttons)
    //             .filter(btn => btn.checked)
    //             .map(btn => ({
    //                 name: btn.text,
    //                 code: btn.payloadCode
    //             }))
    // }
    // 生成测试数据函数修正
    function generateTestData() {
        const testData = [
            {
                mountCount: "2",
                payloadCapacity: "500",
                mountingPosition: "位置A",
                positionNumber: "001",
                checked: true
            },
            {
                mountCount: "1",
                payloadCapacity: "300",
                mountingPosition: "位置B",
                positionNumber: "002",
                checked: false
            },
                           {
                               mountCount: "1",
                               payloadCapacity: "300",
                               mountingPosition: "位置B",
                               positionNumber: "002",
                               checked: false
                           },
                           {
                               mountCount: "1",
                               payloadCapacity: "300",
                               mountingPosition: "位置B",
                               positionNumber: "002",
                               checked: false
                           },
                           {
                               mountCount: "1",
                               payloadCapacity: "300",
                               mountingPosition: "位置B",
                               positionNumber: "002",
                               checked: false
                           },
                           {
                               mountCount: "1",
                               payloadCapacity: "300",
                               mountingPosition: "位置B",
                               positionNumber: "002",
                               checked: false
                           },
                           {
                               mountCount: "1",
                               payloadCapacity: "300",
                               mountingPosition: "位置B",
                               positionNumber: "002",
                               checked: false
                           }
        ]
         //multiTextDispay.loadData = testData
    }

}
