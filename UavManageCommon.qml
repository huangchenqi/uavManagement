import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtQuick.Window 2.12
import Qt.labs.qmlmodels 1.0
import QtQuick.Controls.Styles 1.4
import QtQuick.Dialogs 1.2
import UavDaoModel 1.0
import UavModelLoadTypeDaoModel 1.0
import UavBombingMethodDaoModel 1.0
import UavModelRecoveryModeDaoModel 1.0
import UavModelOperationWayDaoModel 1.0
import UavMountLocationDaoModel 1.0
import AmmoDaoModel 1.0
/**
https://blog.csdn.net/qq_24890953/article/details/104640454
  */
//Window {
Rectangle {
           id: uavManagementroot
           visible: true
           color: "#ECF2FE"
           //signal customSignal(string message)
           property color borderColor: "#A5B3C0"
           property color headerColor: "#D3E1FE"
           property color fontColor: "#3E3E3E"
           property var rowsModel: []
           property string managementType: "";
           property string queryedit: ""
           width: 1400; height: 820//width: screenWidth; height: screenHeight
           property var rowData : ({test:1})
           property int bottonHeight: 50




           // 组件加载完成后生成测试数据
           Component.onCompleted:{
               loadUavAllData()
               loadRecord()
           }
           Loader {
               id: pageUavModelLoader  // 必须的标识符
               anchors.fill: parent  // 填充父容器
               visible: true    // 确保可见
           }

           UavModelDaoTableModel{
               id:uavModelDaoTable
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
           AmmoDaoTableModel{
               id:ammoDaoModel
           }

           // 数据模型
           // 表格数据模型
              TableModel {
                  id: tableModel
                  TableModelColumn { display: "checked" }//复选框
                  TableModelColumn { display: "index"   }        // 序号
                  TableModelColumn { display: "uavType" }   // 机型
                  TableModelColumn { display: "uavName" }      // 名称
                  TableModelColumn { display: "uavId" }    // 编号
                  TableModelColumn { display: "hangingCapacity" }         // 挂载内容
                  TableModelColumn { display: "operationMethod" } //操控方式
                  TableModelColumn { display: "bombMethod" }  // 投弹方式
                  TableModelColumn { display: "recoveryMode" }  // 回收方式
                  TableModelColumn { display: "payloadType" }   // 载荷类型
                  TableModelColumn { display: "uavLoadAmmoType" }//载弹类型
                  TableModelColumn { display: "recordId" }//型号记录编号
                  TableModelColumn { display: "uavCreatModelTime" }//创建时间
                  TableModelColumn { display: "operation" } // 操作(查看/编辑)
              }
              // 新增悬浮提示框
              Popup {
                  id: tooltip
                  //width: 200
                  //height: 50
                  padding: 10
                  closePolicy: Popup.NoAutoClose
                  background: Rectangle {
                      color: "#F0F8FF"
                      border.color: "#4682B4"
                      radius: 4
                  }
                  contentItem: Text {
                      id: tooltipText
                      width: 300
                      wrapMode: Text.Wrap
                      font.pixelSize: 12
                      color: "#2F4F4F"
                  }
              }
              // 定义警告对话框
              Popup {
                      id: warningPopup
                      width: 200
                      height: 100
                      x: (parent.width - width) / 2
                      y: (parent.height - height) / 2
                      modal: true
                      focus: true
                      closePolicy: Popup.NoAutoClose // 禁止点击外部关闭

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
              Popup {
                  id: payloadTypeManagementPopup
                  width: 600  // 需明确设置宽度，否则可能无法显示完整内容
                  height: 400
                  modal: true
                  focus: true
                  anchors.centerIn: Overlay.overlay // 居中显示
                  closePolicy: Popup.NoAutoClose    // 完全禁用自动关闭
                  // 直接引用 admin.qml
                    GetTypeManagement{  // 假设 admin.qml 的根元素是 Admin 类型
                          id: adminPanel
                          anchors.fill: parent
                          managementType:uavManagementroot.managementType

                          onClose: payloadTypeManagementPopup.close() // 连接关闭信号
                    }

                  // 你的内容
                  // Item {
                  //     id: payLoadType
                  //     anchors.fill: parent // 填充 Popup 区域

                  //     ColumnLayout {
                  //         anchors.fill: parent
                  //         spacing: 10

                  //         // 第一行：输入框和按钮
                  //         RowLayout {
                  //             Layout.fillWidth: true  // 关键！让 RowLayout 填满宽度
                  //             spacing: 10

                  //             TextField {
                  //                 id: payLoadTypeText
                  //                 Layout.preferredWidth: 100  // 用 Layout 属性替代固定宽高
                  //                 Layout.preferredHeight: 50
                  //             }

                  //             Button {
                  //                 id: payLoadTypeAdd
                  //                 Layout.preferredWidth: 100
                  //                 Layout.preferredHeight: 50
                  //                 text: "新增载荷"
                  //             }

                  //             Button {
                  //                 id: payLoadTypeDel
                  //                 Layout.preferredWidth: 100
                  //                 Layout.preferredHeight: 50
                  //                 text: "删除载荷"
                  //             }
                  //             Button {
                  //                 id: payLoadTypeBack
                  //                 Layout.preferredWidth: 100
                  //                 Layout.preferredHeight: 50
                  //                 text: "返回"
                  //                 onClicked: {
                  //                     payloadTypeManagementPopup.close()// 或myPopup.visible = false
                  //                     uavManage.enabled = true
                  //                     uavManage.visible = true
                  //                 }
                  //             }
                  //         }

                  //         // 下方的蓝色矩形区域
                  //         Rectangle {
                  //             id: showPayLoadType
                  //             Layout.fillWidth: true  // 自动填充宽度
                  //             Layout.fillHeight: true  // 自动填充剩余高度
                  //             Layout.alignment: Qt.AlignLeft // 左对齐
                  //             Layout.leftMargin: 10  // 左侧边距
                  //             color: "skyblue"
                  //         }
                  //     }
                  // }
              }
              Popup{//挂载位置管理
                  id: addMountLocationManagementPopup
                  width: 600  // 需明确设置宽度，否则可能无法显示完整内容
                  height: 400
                  modal: true
                  focus: true
                  anchors.centerIn: Overlay.overlay // 居中显示
                  closePolicy: Popup.NoAutoClose    // 完全禁用自动关闭
                  // 直接引用 admin.qml
                    AddMountLocationManagement{  // 假设 admin.qml 的根元素是 Admin 类型
                          id: addMountLocationPanel
                          anchors.fill: parent

                          onClose: addMountLocationManagementPopup.close() // 连接关闭信号
                    }
                }
              Popup{//其他消息管理
                  id: addUavComponentManagementPopup
                  width: 460  // 需明确设置宽度，否则可能无法显示完整内容
                  height: 400
                  modal: true
                  focus: true
                  anchors.centerIn: Overlay.overlay // 居中显示
                  closePolicy: Popup.NoAutoClose    // 完全禁用自动关闭
                  //   AddUavComponentManagement{  // 假设 admin.qml 的根元素是 Admin 类型
                  //         id: addUavComponentPanel
                  //         anchors.fill: parent
                  //         managementType:uavManagementroot.managementType
                  //         onClose: addUavComponentManagementPopup.close() // 连接关闭信号
                  //   }
                }
              Popup{//投弹管理
                  id: addUavModelBombingMethodPopup
                  width: 460  // 需明确设置宽度，否则可能无法显示完整内容
                  height: 400
                  modal: true
                  focus: true
                  anchors.centerIn: Overlay.overlay // 居中显示
                  closePolicy: Popup.NoAutoClose    // 完全禁用自动关闭
                  AddUavModelBombingMethod{
                            id: addUavModelBombingMethodPanel
                            anchors.fill: parent
                            onClose: addUavModelBombingMethodPopup.close() // 连接关闭信号
                    }
                }
              Popup{//载荷管理
                  id: addUavModelLoadTypePopup
                  width: 460  // 需明确设置宽度，否则可能无法显示完整内容
                  height: 400
                  modal: true
                  focus: true
                  anchors.centerIn: Overlay.overlay // 居中显示
                  closePolicy: Popup.NoAutoClose    // 完全禁用自动关闭
                  AddUavModelLoadType{
                            id: addUavModelLoadTypePanel
                            anchors.fill: parent
                            onClose: addUavModelLoadTypePopup.close() // 连接关闭信号
                    }
                }
              Popup{//回收管理
                  id: addUavModelRecoveryModePopup
                  width: 460  // 需明确设置宽度，否则可能无法显示完整内容
                  height: 400
                  modal: true
                  focus: true
                  anchors.centerIn: Overlay.overlay // 居中显示
                  closePolicy: Popup.NoAutoClose    // 完全禁用自动关闭
                  AddUavModelRecoveryMode{
                            id: addUavModelRecoveryModePanel
                            anchors.fill: parent
                            onClose: addUavModelRecoveryModePopup.close() // 连接关闭信号
                    }
                }
              Popup{//操控管理
                  id: addUavModelOperationWayPopup
                  width: 460  // 需明确设置宽度，否则可能无法显示完整内容
                  height: 400
                  modal: true
                  focus: true
                  anchors.centerIn: Overlay.overlay // 居中显示
                  closePolicy: Popup.NoAutoClose    // 完全禁用自动关闭
                  AddUavModelOperationWay{
                            id: addUavModelOperationWayPanel
                            anchors.fill: parent
                            onClose: addUavModelOperationWayPopup.close() // 连接关闭信号
                    }
                }


           ColumnLayout {
               //@disable-check M16
               anchors.fill: parent
               Layout.fillWidth: true
               Layout.fillHeight: true
               RowLayout {
                   Layout.fillWidth: true
                   Layout.preferredHeight: 60
                   Layout.minimumHeight: 60
                   Layout.alignment: Qt.AlignCenter
                   Text {
                       Layout.fillWidth: true
                       verticalAlignment: Text.AlignVCenter
                       horizontalAlignment: Text.AlignHCenter
                       text: qsTr("无人机型号记录");
                       font.pointSize: 20
                       color: "black"
                   }
                   Item { Layout.fillWidth: true }
               }

               ColumnLayout {
                   spacing: 5
                   Layout.fillWidth: true
                   Layout.fillHeight: true
                   Rectangle {
                       anchors.fill: parent
                   }
                   RowLayout {
                       Layout.topMargin: 2
                       Layout.fillHeight: true
                       Layout.minimumHeight: 40
                       Layout.alignment: Qt.AlignLeft
                       spacing: 5
                       Label{
                           id:inputUavTypeData
                           width:100
                           height:50
                           font.pointSize: 12
                           text: "飞机类型:"
                       }
                       ComboBox {
                           id: modelSelector
                           width: 160
                           height: 40
                           font.pointSize: 12
                           model: ["全部","侦察型无人机","攻击型无人机","查打一体无人机"]
                       }
                       Label{
                           id:inputUavIdData
                           width:100
                           height:50
                           font.pointSize: 12
                           text: "飞机型号:"
                       }
                       TextField{
                           id:uavIdSelect
                           width: 100
                           height:50
                           font.pointSize: 12
                       }
                       Label{
                           id:inputUavNameData
                           width:100
                           height:50
                           font.pointSize: 12
                           text: "飞机名称:"
                       }

                       TextField{
                           id:uavNameSelect
                           width: 100
                           height:50
                           font.pointSize: 12
                       }
                       Button{
                           id:selectButton
                           width:100
                           height:50
                           font.pointSize: 12
                           text: "搜索"
                           Layout.leftMargin: 30
                           onClicked: {
                               inputValidator()
                               queryConditionUavModelData()

                           }
                       }
                       Button{
                           id:clearButton
                           width:100
                           height:50
                           font.pointSize: 12
                           Layout.leftMargin: 10
                           text: "重置"
                           onClicked: {
                               modelSelector.currentIndex = 0
                               uavIdSelect.text = ""
                               uavNameSelect.text = ""
                           }
                       }

                       Item { Layout.fillWidth: true }
                   }
                   RowLayout {
                       Layout.bottomMargin: 2
                       Layout.fillHeight: true
                       Layout.maximumHeight: 40
                       Layout.alignment: Qt.AlignLeft
                       spacing: 5
                       // MxDateInput {
                       //     id: foundDateCommbox
                       //     title: "提出日期:"
                       //     labelWidth: 80
                       //     width: 240;
                       //     visible: false;
                       //     onFinished: {
                       //         loadDeliveryRecordList(processInfo)
                       //     }
                       // }

                   }
               }
               RowLayout {
                   Layout.minimumWidth: uavManagementroot.width
                   Layout.minimumHeight: uavManagementroot.height-280
                   Layout.fillHeight: true
                   Layout.fillWidth: true
                   Item {
                       id: control
                       implicitHeight: uavManagementroot.width
                       implicitWidth: uavManagementroot.height-280
                       Layout.fillWidth: true
                       Layout.fillHeight: true
                       //表头行高
                       property int headerHeight: dpH(48)
                       //行高
                       property int rowHeight: dpH(48)
                       property int tableLeft: dpH(60)
                       //滚动条
                       property color scrollBarColor: "#E5E5E5"
                       property int scrollBarWidth: 7
                       //列宽
                       property variant columnWidthArr: [50,50, 120, 100, 100, 140,
                           120, 120, 120, 120,120,120,220, 220]
                       // 显示10个字段
                       property var horHeader: ["","序号", "无人机机型", "无人机名称", "无人机编号", "挂载内容",
                           "操控方式", "投弹方式", "回收方式", "载荷类型","载弹类型","型号记录编号","创建时间", "操作"]
                       property int selected: -1
                       //数据展示
                       TableView {
                           id: tableView
                           implicitHeight: uavManagementroot.width
                           implicitWidth: uavManagementroot.height-280
                           Layout.fillWidth: true
                           Layout.fillHeight: true
                           anchors {
                               fill: parent
                               topMargin: control.rowHeight
                               leftMargin: 2//control.tableLeft
                           }

                           clip: true
                           boundsBehavior: Flickable.StopAtBounds
                           columnSpacing: 0
                           rowSpacing: 0

                           //内容行高
                           rowHeightProvider: function (row) {
                               return control.headerHeight
                           }
                           //内容列的列宽
                           columnWidthProvider: function (column) {
                               return control.columnWidthArr[column]
                           }
                           ScrollBar.vertical: ScrollBar {
                               id: scroll_vertical
                               anchors.right: parent.right
                               anchors.rightMargin: 0
                               contentItem: Rectangle {
                                   visible: (scroll_vertical.size < 1.0)
                                   implicitWidth: control.scrollBarWidth
                                   color: control.scrollBarColor
                               }
                           }

                           ScrollBar.horizontal: ScrollBar {
                               id: scroll_horizontal
                               anchors.bottom: parent.bottom
                               anchors.bottomMargin: 0
                               anchors.left: parent.left
                               anchors.leftMargin: -control.tableLeft
                               contentItem: Rectangle {
                                   visible: (scroll_horizontal.size < 1.0)
                                   implicitHeight: control.scrollBarWidth
                                   color: control.scrollBarColor
                               }


                           }

                           model: tableModel
                            // 使用 DelegateChooser 为不同的列指定不同的委托
                           delegate:DelegateChooser{
                                   // 默认委托（用于非最后一列）
                               // 最后一列（操作列，索引12）使用按钮委托
                                role: "column" // 根据列索引选择不同的委托
                                // 其他列使用默认文本显示委托
                                DelegateChoice {
                                     column:0
                                     delegate: Rectangle {
                                         color: (model.row % 2) ? "#FFFFFF": "#EBF2FD"
                                         width: control.columnWidthArr[column]
                                         height: control.rowHeight
                                         CheckBox { //自定义多选框组件
                                             checked: tableView.model.rows.length > 0 ? tableView.model.rows[index].checked : false
                                             anchors.centerIn: parent
                                             onClicked: {
                                                 //Qt.unchecked：适合用于需要明确表示复选框状态的场景，特别是在处理 CheckState 类型的属性时。
                                                 //false：适合用于布尔类型的属性，表示未选中状态。
                                                 //
                                                 rowsModel[index].checked = !rowsModel[index].checked
                                                 tableModel.rows = rowsModel;


                                             }
                                         }
                                         Rectangle {
                                             height: 1
                                             width: parent.width
                                             anchors.bottom: parent.bottom
                                             color: borderColor
                                         }
                                         Rectangle {
                                             height: parent.height
                                             width: 1
                                             anchors.right: parent.right
                                             color: borderColor
                                         }
                                     }
                                 }
                                // DelegateChoice {
                                //     column:0
                                //     delegate: Rectangle {
                                //         color: (model.row % 2) ? "#FFFFFF": "#EBF2FD"
                                //         width: control.columnWidthArr[column]
                                //         height: control.rowHeight

                                //         Text {
                                //             anchors.fill: parent
                                //             verticalAlignment: Text.AlignVCenter
                                //             horizontalAlignment: Text.AlignHCenter
                                //             text: display
                                //             font.pointSize: 16
                                //             color: "#000000"
                                //             elide: Text.ElideRight
                                //         }

                                //         Rectangle {
                                //             color: borderColor
                                //             width: parent.width
                                //             height: 1
                                //             anchors.bottom: parent.bottom
                                //         }
                                //         Rectangle {
                                //             height: parent.height
                                //             width: 1
                                //             anchors.right: parent.right
                                //             color: borderColor
                                //         }
                                //     }
                                // }
                               DelegateChoice {
                                   column:13
                                   // delegate: Row {
                                   //         width: tableView.width // 确保宽度占满单元格
                                   //         spacing: 5 // 按钮之间的间距

                                   //         MouseArea {
                                   //             width: parent.width / 2 - spacing / 2
                                   //             height: 30
                                   //             onClicked: {
                                   //                 console.log("操作1点击，行索引:", index)
                                   //                 // 执行操作1的逻辑
                                   //             }

                                   //             Text {
                                   //                 text: "操作1"
                                   //                 anchors.centerIn: parent
                                   //             }
                                   //         }

                                   //         MouseArea {
                                   //             width: parent.width / 2 - spacing / 2
                                   //             height: 30
                                   //             onClicked: {
                                   //                 console.log("操作2点击，行索引:", index)
                                   //                 // 执行操作2的逻辑
                                   //             }

                                   //             Text {
                                   //                 text: "操作2"
                                   //                 anchors.centerIn: parent
                                   //             }
                                   //         }
                                   //     }
                                   delegate: Rectangle {
                                       color: (model.row % 2) ? "#FFFFFF": "#EBF2FD"
                                       width: control.columnWidthArr[column]
                                       height: control.rowHeight

                                       Row {
                                           spacing: 5
                                           anchors.centerIn: parent

                                           Button {
                                               text: "查看"
                                               width: 60
                                               height: 30
                                               onClicked: {
                                                   var rowData = tableModel.getRow(row) //.rows[row]
                                                   console.log("查看行数据:", JSON.stringify(rowData, null, 2))
                                                   // 转换数据
                                                   var transformedData = transformData(rowData)
                                                   console.log("转换后的数据:", JSON.stringify(transformedData, null, 2))

                                                   // 将转换后的数据转换为 JSON 字符串
                                                   //var jsonStr = JSON.stringify(transformedData)
                                                   // processInfo.recordId = transformedData.recordId
                                                   // processInfo.uavType = transformedData.uavType
                                                   // processInfo.uavName = transformedData.uavName
                                                   // processInfo.uavId = transformedData.uavId
                                                   processInfo.loadViewType = "query"
                                                   //processInfo.jsonStr = transformedData
                                                   assignmentEncapsulation(transformedData)
                                                   processInfo.hangingCapacity = rowData.origHangingCapacity
                                                   //console.log("processInfo JSONDATA"+JSON.stringify(processInfo))
                                                   pageUavModelLoader.setSource("qrc:./AddUavModelData.qml",
                                                                        {processInfo: processInfo,
                                                                            backUi: "qrc:/UavManageCommon.qml"})
                                               }
                                           }

                                           Button {
                                               text: "编辑"
                                               width: 60
                                               height: 30
                                               onClicked: {

                                                   var rowData = tableModel.rows[row]
                                                   console.log("查看行数据:", JSON.stringify(rowData, null, 2))
                                                   // 转换数据
                                                   var transformedData = transformData(rowData)
                                                   console.log("转换后的数据:", JSON.stringify(transformedData, null, 2))

                                                   // 将转换后的数据转换为 JSON 字符串
                                                   //var jsonStr = JSON.stringify(transformedData)

                                                   console.log("编辑行数据:", JSON.stringify(transformedData, null, 2))

                                                   processInfo.loadViewType = "update"
                                                   assignmentEncapsulation(transformedData)
                                                   processInfo.hangingCapacity = rowData.origHangingCapacity
                                                   console.log("processInfo JSONDATA"+JSON.stringify(processInfo))
                                                   pageUavModelLoader.setSource("qrc:./AddUavModelData.qml",
                                                                        {processInfo: processInfo,
                                                                            backUi: "qrc:/UavManageCommon.qml"})
                                               }
                                           }
                                       }

                                       Rectangle {
                                           color: borderColor
                                           width: parent.width
                                           height: 1
                                           anchors.bottom: parent.bottom
                                       }
                                       Rectangle {
                                           height: parent.height
                                           width: 1
                                           anchors.right: parent.right
                                           color: borderColor
                                       }
                                   }
                               }

                               DelegateChoice {
                                    //column:1
                                    delegate: Rectangle {
                                        color: (model.row % 2) ? "#FFFFFF": "#EBF2FD"
                                        width: control.columnWidthArr[column]
                                        height: control.rowHeight

                                        Text {
                                            anchors.fill: parent
                                            verticalAlignment: Text.AlignVCenter
                                            horizontalAlignment: Text.AlignHCenter
                                            text: display
                                            font.pointSize: 12
                                            color: "#000000"
                                            elide: Text.ElideRight
                                        }
                                        MouseArea {
                                                    anchors.fill: parent
                                                    hoverEnabled: true
                                                    onEntered: {
                                                        var pos = mapToGlobal(0, 0)
                                                        tooltip.x = pos.x //+ width + 10
                                                        tooltip.y = pos.y -10
                                                        tooltipText.text = display
                                                        tooltip.open()
                                                    }
                                                    onExited: tooltip.close()
                                                }

                                        Rectangle {
                                            color: borderColor
                                            width: parent.width
                                            height: 1
                                            anchors.bottom: parent.bottom
                                        }
                                        Rectangle {
                                            height: parent.height
                                            width: 1
                                            anchors.right: parent.right
                                            color: borderColor
                                        }
                                    }
                                }
                            }
                       }
                       //全选按钮
                       // Rectangle {
                       //     width: control.tableLeft
                       //     height: control.rowHeight
                       //     color: "#F8F8F8"
                       //     anchors {
                       //         top: parent.top
                       //         left: parent.left
                       //     }
                       //     CheckBox {
                       //         checked: false
                       //         id: checkBox
                       //         anchors {
                       //             verticalCenter: parent.verticalCenter
                       //             horizontalCenter: parent.horizontalCenter
                       //         }
                       //         onClicked: {

                       //             //onSelectCheckBoxClicked(checkBox.checked)
                       //             // if (checkBox.checked) {
                       //             //     checkBox.checked = Qt.Unchecked;
                       //             // }
                       //             // else {
                       //             //     checkBox.checked = Qt.Checked;
                       //             // }
                       //             if (checkBox.checked === false) {
                       //                 onAllSelectCheckBoxClicked("allSelectCancel");
                       //             }
                       //             else if(checkBox.checked === true) {
                       //                 onAllSelectCheckBoxClicked("allSelect");
                       //             }else{
                       //                 console.log("复选框未知")
                       //             }

                       //         }
                       //     }
                       //     Rectangle {
                       //         height: 1
                       //         width: parent.width
                       //         anchors.bottom: parent.bottom
                       //         color: borderColor
                       //     }
                       //     Rectangle {
                       //         height: 1
                       //         width: parent.width
                       //         anchors.top: parent.top
                       //         color: borderColor
                       //     }
                       //     Rectangle {
                       //         height: parent.height
                       //         width: 1
                       //         anchors.right: parent.right
                       //         color: borderColor
                       //     }
                       // }
                       //表头
                       Item {
                           anchors {
                               left: parent.left
                               right: parent.right
                               leftMargin:2// control.tableLeft
                           }
                           height: control.rowHeight
                           z: 2

                           Row {
                               anchors.fill: parent
                               leftPadding: -tableView.contentX
                               clip: true
                               spacing: 0
                               Repeater {
                                   model: tableView.columns > 0 ? tableView.columns : 0
                                   Rectangle {
                                       width: tableView.columnWidthProvider(
                                                  index) + tableView.columnSpacing
                                       height: control.rowHeight
                                       color: headerColor
                                       Text {
                                           anchors.centerIn: parent
                                           text: control.horHeader[index]
                                           font.pointSize: 12
                                           color: fontColor
                                           elide: Text.ElideRight
                                       }
                                       Rectangle {
                                           height: 1
                                           width: parent.width
                                           anchors.bottom: parent.bottom
                                           color: borderColor
                                       }
                                       Rectangle {
                                           height: 1
                                           width: parent.width
                                           anchors.top: parent.top
                                           color: borderColor
                                       }
                                       Rectangle {
                                           height: parent.height
                                           width: 1
                                           anchors.right: parent.right
                                           color: borderColor
                                       }
                                   }
                               }
                           }
                       }
                       //每一行前面加多选框
                       // Column {
                       //     anchors {
                       //         top: parent.top
                       //         bottom: parent.bottom
                       //         topMargin: control.headerHeight
                       //     }
                       //     //topPadding: -tableView.contentY
                       //     z: 2
                       //     clip: true
                       //     spacing: 0
                       //     Repeater {
                       //         model: tableView.rows > 0 ? tableView.rows : 0
                       //         Rectangle {
                       //             width: control.tableLeft
                       //             height: control.rowHeight
                       //             color: "white"
                       //             CheckBox { //自定义多选框组件
                       //                 checked: tableView.model.rows.length > 0 ? tableView.model.rows[index].checked : false
                       //                 anchors.centerIn: parent
                       //                 onClicked: {
                       //                     //Qt.unchecked：适合用于需要明确表示复选框状态的场景，特别是在处理 CheckState 类型的属性时。
                       //                     //false：适合用于布尔类型的属性，表示未选中状态。
                       //                     //
                       //                     rowsModel[index].checked = !rowsModel[index].checked
                       //                     tableModel.rows = rowsModel;


                       //                 }
                       //             }
                       //             Rectangle {
                       //                 height: 1
                       //                 width: parent.width
                       //                 anchors.bottom: parent.bottom
                       //                 color: borderColor
                       //             }
                       //             Rectangle {
                       //                 height: parent.height
                       //                 width: 1
                       //                 anchors.right: parent.right
                       //                 color: borderColor
                       //             }
                       //         }
                       //     }
                       // }
                   }
               }
               RowLayout {
                   Layout.preferredHeight: 60

                   Rectangle {
                       anchors.fill: parent
                   }

                   Item { Layout.leftMargin: 20 }
                   Button {
                       id: uavBombingmethodManagement
                       text: "投弹方式管理"
                       onClicked: {
                           processInfo.uavComponentType = "bombingMethod"
                           uavManagementroot.managementType = "bombingMethod"
                           addUavModelBombingMethodPopup.open()
                           uavManagementroot.enabled = false
                           //uavManagementroot.visible = false
                       }
                   }
                   Item { Layout.fillWidth: true }
                   //底部提出问题按钮
                   Button {
                       id: uavRecoverymodeManagement
                       text: "回收方式管理"
                       onClicked: {
                           addUavModelRecoveryModePopup.open()
                           //uavManagementroot.managementType = "recoveryMode"
                           uavManagementroot.enabled = false
                       }
                   }
                   Item { Layout.fillWidth: true }
                   Button {
                       id: uavHangingLoctionManagement
                       text: "挂载位置管理"
                       onClicked: {
                           addMountLocationManagementPopup.open()
                           //uavManagementroot.managementType = "uavHanging"
                           uavManagementroot.enabled = false
                           //uavManagementroot.visible = false
                       }
                   }
                   Item { Layout.fillWidth: true }

                   Button {
                       id: payloadTypeManagement
                       text: "载荷类型管理"
                       onClicked: {
                           addUavModelLoadTypePopup.open()
                           uavManagementroot.managementType = "loadType"
                           uavManagementroot.enabled = false
                       }
                   }
                   Item { Layout.fillWidth: true }
                   Button {
                       id: opreationTypeManagement
                       text: "操控方式管理"
                       onClicked: {
                           addUavModelOperationWayPopup.open()
                           //uavManagementroot.managementType = "operationType"
                           uavManagementroot.enabled = false
                       }
                   }
                   Item { Layout.fillWidth: true }
                   Button {
                       id: delUavManagement
                       text: "删除型号"
                       onClicked: {
                           onDelButtonClicked();
                       }
                   }
                   Item { Layout.leftMargin: 20 }
                   Button {
                       id: addUavManagement
                       text: "新增型号"
                       onClicked: {
                           processInfo.loadViewType = "addUavData"
                           pageUavModelLoader.setSource("qrc:./AddUavModelData.qml",
                                                {processInfo: processInfo,
                                                    backUi: "qrc:/UavManageCommon.qml"})


                           // 退出并隐藏界面
                           //uavManagementLoader.setSource = null // 卸载界面
                           //uavManagementroot.visible = false
                       }
                   }
                   Item { Layout.rightMargin: 20 }
               }
           }

           Component {
               id: rowDelegate
               Rectangle {
                   visible: styleData.row === undefined ? false : true
                   //color: styleData.alternate ? "#F9F9F9":"#EAEAEA"
                   color: "#F9F9F9"
                   height: 60
                   Rectangle { // 底部边框
                       anchors.right: parent.right
                       anchors.left: parent.left
                       anchors.bottom: parent.bottom
                       height: 1
                       color: "gray"
                   }
               }
           }

           Component {
               id: itemDelegate
               Text {
                   text: styleData.value+""
                   font.pointSize: 22
                   font.bold: false
                   color: "black"
                   //color: styleData.textColor
                   horizontalAlignment: Text.AlignHCenter
                   verticalAlignment: Text.AlignVCenter
                   elide: styleData.elideMode
               }
           }

           Component {
               id: headerDelegate
               Rectangle {
                   height: 60
                   implicitHeight: 60
                   border.width: 1
                   color: "#0089CF"
                   border.color: "#FFFFFF"
                   Text {
                       id: headerName
                       text: styleData.value
                       font.pointSize: 22
                       font.bold: false
                       horizontalAlignment: Text.AlignHCenter
                       verticalAlignment: Text.AlignVCenter
                       anchors.fill: parent
                       color: "#FFFFFF"
                   }
               }
           }

           function dpH(h) {
               return h
           }
           function mapToGlobal(x, y) {
               var globalPoint = tableView.mapToItem(null, x, y)
               return Qt.point(
                   globalPoint.x + tableView.contentX,
                   globalPoint.y + tableView.contentY
               )
           }
           function queryConditionUavModelData(){
               var uavData ={
                   uavName:"",
                   uavType:"",
                   uavId:""
               }
               uavData.uavType = modelSelector.currentText
               uavData.uavId  = uavIdSelect.text
               uavData.uavName = uavNameSelect.text
               var uavDataStr = JSON.stringify(uavData)
               var queryUavData = uavModelDaoTable.queryUavModelData(uavDataStr)
               console.log("queryConditionModelData!"+JSON.stringify(queryUavData))
               const modifiedData = convertMultiFields(queryUavData);
                console.log("receiveData"+JSON.stringify(modifiedData, null, 2));
                // 清空旧数据
               tableModel.clear()
               rowsModel.length = 0;

               tableModel.rows = modifiedData;
               rowsModel = tableModel.rows;
               // 自动刷新表格
               tableModel.layoutChanged()

           }

           //只提取弹药中的id与弹药
           function extractAmmoInfo(ammoArray) {
               return ammoArray.map(item => ({
                   ammoName: item.ammoName,
                   recordId: item.recordId
               }));
           }
           function convertMultiFields(originalArray) {
               // 需要处理的字段列表
               const targetFields = [
                   "operationMethod",
                    "hangingCapacity",
                   "uavLoadAmmoType",
                   "payloadType",
                   "recoveryMode",
                   "bombMethod"
               ];

               return originalArray.map(item => {
                   // 深拷贝对象
                   const newItem = JSON.parse(JSON.stringify(item));

                   targetFields.forEach(field => {
                       if (newItem.hasOwnProperty(field)) {
                           const value = newItem[field];

                           // 处理不同数据类型
                           if (Array.isArray(value)) {
                               // 数组转字符串
                               newItem[field] = value.join(',');
                           } else if (typeof value === 'string') {
                               // 字符串直接保留（如果已经是逗号分隔格式）
                               // 如果需要强制转换可以添加正则验证：
                               // if (!/,/.test(value)) { ... }
                           } else {
                               // 处理意外类型（如数字/布尔值）
                               console.warn(`Unexpected type for ${field}:`, typeof value);
                           }
                       }
                   });

                   return newItem;
               });
           }

           //提取原数据的属性
           function loadUavAllData(){

               var receiveData = uavModelDaoTable.selectUavModelAllData()
               const modifiedData = convertMultiFields(receiveData);
                console.log("receiveData"+JSON.stringify(modifiedData, null, 2));
               //var test = extractBombNumbers(receiveData,"bombMethod")//operationMethod\payloadType\recoveryMode\uavLoadAmmoType
               //console.log("loadUaz洒下vAllData+:", JSON.stringify(receiveData, null, 2));
               //var ammoType = ammoDaoModel.selectAmmoAllData()
               //var ammoTypeArray = extractAmmoInfo(ammoType)
               //var uavBombWay = uavBombingMethodDaoModel.selectUavModelBombingMethodAllData()
               // var uavtransformUavAllData = uavModelDaoTable.transformQueryAllData()
               // console.log("uavBombWay"+JSON.stringify(uavBombWay))
               // var uavPayloadType = uavModelLoadTypeDaoModel.selectUavModelLoadTypeAllData()
               // var uavRecoveryWay = uavModelRecoveryModeDaoModel.selectModelRecoveryModeAllData()
               // var uavOperationWay = uavModelOperationWayDaoModel.selectModelOperationWayAllData()

                // 清空旧数据
               tableModel.clear()
               rowsModel.length = 0;

               tableModel.rows = modifiedData;
               rowsModel = tableModel.rows;
               //console.log("UAV Model Data:", JSON.stringify(tableModel))
               // try {
               //         var receiveData = uavModelDaoTable.selectUavModelAllData();
               //         console.log("UAV Model Data:", JSON.stringify(receiveData, null, 2));

               //         // 清空旧数据
               //         tableModel.clear();

               //         // 填充新数据
               //         for (var i = 0; i < receiveData.length; i++) {
               //             tableModel.append(receiveData[i]);
               //         }
               //     } catch (error) {
               //         console.error("Error loading UAV data:", error);
               //     }

               // 填充新数据（带序号）
               // receiveData.forEach((item, index) => {
               //     tableModel.appendRow({
               //         "index": index + 1,
               //         "uavType": item.uavType || "--",
               //         "uavName": item.uavName || "--",
               //         "uavId": item.uavId || "N/A",
               //         "hangingCapacity": item.hangingCapacity || "无",
               //         "operationMethod": item.opreationMethod || "未知",
               //         "bombMethod": item.bombMethod || "未指定",
               //         "recoveryMode": item.recoveryMode || "默认",
               //         "payloadType": item.payloadType || "通用",
               //         "operation": "操作"
               //     })
               // })

               // 自动刷新表格
               tableModel.layoutChanged()
           }
           // 转换函数
           function transformData(data) {
               return {
                   "bombMethod": data.bombMethod,
                   "hangingCapacity": data.hangingCapacity,
                   "operationMethod": data.operationMethod,
                   "payloadType": data.payloadType,
                   "recordId": data.recordId,
                   "recoveryMode": data.recoveryMode,
                   "uavId": data.uavId,
                   "uavName": data.uavName,
                   "uavType": data.uavType,
                   "uavLoadAmmoType":data.uavLoadAmmoType,
                   "imageUrl":data.imageUrl
               };
           }
           // 提取数组中冒号后面的数字
           function extractAmmoIds(data, extraName) {
                   try {
                       // 修正3：使用方括号访问对象属性
                       var loadAmmoType = JSON.parse(data[extraName])//由于传入的是Json字符串，需要parse转化成数组
                       console.log("loadAmmoTypeArray"+JSON.stringify(loadAmmoType))

                       if (!Array.isArray(loadAmmoType)) {
                           console.log(extraName + "不是数组格式")
                           return []
                       }

                       return loadAmmoType.map(item => {
                           let parts = item.split(":")
                           if (parts.length !== 2) {
                               console.log("格式错误的项:", item)
                               return null
                           }
                           return parseInt(parts[1].trim())
                       }).filter(num => !isNaN(num))

                   } catch (e) {
                       console.log("处理" + extraName + "时发生错误:", e)
                       return []
                   }
               }
           // 在QML中定义函数使用Id查找uavComponentName名称
           function getUavComponentNamesByIds(ammoArray, idArray) {

               // 先将 idArray 转为字符串数组（因为 recordId 是字符串类型）
                   const targetIds = idArray.map(id => id.toString());
                   // 先过滤出符合条件的元素，再映射提取名称
                   return ammoArray.filter(ammo =>
                       targetIds.includes(ammo.recordId)
                   ).map(ammo => ammo.uavComponeName);
               // return ammoArray.map(ammo=>{
               //                          console.log("inmap : " + JSON.stringify(ammo))
               //                          if(idArray.some(id=> id == ammo.recordId))
               //                              return ammo.uavComponeName
               //                      })

               // // 创建哈希表加速查找（recordId作为key）
               // const ammoMap = {}
               // ammoArray.forEach(ammo => {
               //     // 统一转换为数字类型进行比较
               //     const id = parseInt(ammo.recordId)
               //     ammoMap[id] = ammo.ammoName
               // })

               // // 过滤并返回有效弹药名称
               // return idArray.map(id => {
               //     return ammoMap[id] || null
               // }).filter(name => name !== null)
           }
           // function getAmmoNamesByIds(ammoData, bArray) {
           //     var result = [];
           //     // 遍历目标数组中的每个元素
           //     for (var i = 0; i < bArray.length; i++) {
           //         // 将数字转换为字符串以匹配 recordId 的类型
           //         var targetId = bArray[i].toString();
           //         // 在弹药数据中查找匹配的 recordId
           //         for (var j = 0; j < ammoData.length; j++) {
           //             if (ammoData[j].recordId === targetId) {
           //                 result.push(ammoData[j].ammoName);
           //                 break; // 找到后跳出内层循环
           //             }
           //         }
           //     }
           //     return result;
           // }

           //使用Id查找ammoType的名称
           function getAmmoNamesByIds(ammoArray, idArray) {

               // 先将 idArray 转为字符串数组（因为 recordId 是字符串类型）
                   const targetIds = idArray.map(id => id.toString());
                   // 先过滤出符合条件的元素，再映射提取名称
                   return ammoArray.filter(ammo =>
                       targetIds.includes(ammo.recordId)
                   ).map(ammo => ammo.ammoName);
            }
           //将其选中的数据重新封装
           function convertStringFieldsToArray(originalObj) {
               // 需要转换的字段列表
               const targetFields = [
                   "bombMethod",
                   //"hangingCapacity",
                   "operationMethod",
                   "payloadType",
                   "recoveryMode",
                   "uavLoadAmmoType"
               ];

               // 深拷贝原始对象
               let newObj = JSON.parse(JSON.stringify(originalObj));

               targetFields.forEach(field => {
                   if (newObj.hasOwnProperty(field)) {
                       const value = newObj[field];

                       // 仅处理字符串类型字段
                       if (typeof value === 'string') {
                           // 特殊处理空字符串
                           if (value === "") {
                               newObj[field] = [];
                           }
                           // 处理非空字符串
                           else {
                               newObj[field] = value.split(',')
                                   .map(item => item.trim())  // 去除前后空格
                                   .filter(item => item !== '');  // 过滤空项
                           }
                       }
                       // 非字符串类型保持原样
                       else if (Array.isArray(value)) {
                           console.log(`${field} is already an array`);
                       }
                       else {
                           console.warn(`${field} has unexpected type: ${typeof value}`);
                       }
                   }
               });

               return newObj;
           }
           //行数值赋予下界面跳转
           function assignmentEncapsulation(data){

               var transformData = convertStringFieldsToArray(data)
               processInfo.recordId = transformData.recordId
               processInfo.uavType = transformData.uavType
               processInfo.uavName = transformData.uavName
               processInfo.uavId = transformData.uavId
               processInfo.uavModelJsonStr = transformData
               //console.log("assignmentEncapsulation"+JSON.stringify(data))
               // var ammoType = ammoDaoModel.selectAmmoAllData()
               // var uavBombWay = uavBombingMethodDaoModel.selectUavModelBombingMethodAllData()
               // var uavPayloadType = uavModelLoadTypeDaoModel.selectUavModelLoadTypeAllData()
               // var uavRecoveryWay = uavModelRecoveryModeDaoModel.selectModelRecoveryModeAllData()
               // var uavOperationWay = uavModelOperationWayDaoModel.selectModelOperationWayAllData()
               // var operationWayArray = extractAmmoIds(data,"operationMethod")
               // var recoveryWayArray = extractAmmoIds(data,"recoveryMode")
               // var bombWayArray = extractAmmoIds(data,"bombMethod")
               // var investagationArray = extractAmmoIds(data,"payloadType")
               // var loadAmmoTypeArray = extractAmmoIds(data,"uavLoadAmmoType")

               // processInfo.operationWay = getUavComponentNamesByIds(uavOperationWay,operationWayArray)
               // console.log("{},{},{}",processInfo.operationWay,JSON.stringify(processInfo.operationWay),operationWayArray)
               // processInfo.recoveryWay =getUavComponentNamesByIds(uavRecoveryWay,recoveryWayArray)
               // processInfo.bombWay =getUavComponentNamesByIds(uavBombWay,bombWayArray)
               // processInfo.investagationPayLoadType =getUavComponentNamesByIds(uavPayloadType,investagationArray)
               // processInfo.loadAmmoType =getAmmoNamesByIds(ammoType,loadAmmoTypeArray)
               //console.log("ammoType="+JSON.stringify(ammoType))
               //console.log("aaaaaas"+JSON.stringify(data))

               processInfo.operationWay = transformData.operationMethod
               processInfo.recoveryWay = transformData.recoveryMode
               processInfo.bombWay = transformData.bombMethod
               processInfo.investagationPayLoadType = transformData.payloadType
               processInfo.loadAmmoType = transformData.uavLoadAmmoType
               processInfo.imagUrl = transformData.imageUrl
               console.log("assignmentEncapsulation JSON.stringify"+JSON.stringify(processInfo))

           }

           // 生成测试数据函数
           function generateTestData() {
               const testData = [
                   // 序号 | 机型       | 批次 | 架次 | 接装部队       | 部队专业     | 提出者 | 观察项内容      | 产品图号   | 产品名称
                   ["1",  "RQ-4",     "A1", "001", "第1航空旅",   "战略侦察",  "张伟",  "发动机过热",    "DWG-001", "主引擎组件"],
                   ["2",  "MQ-9",     "B2", "003", "第3无人机团", "战术打击",  "王芳",  "摄像头偏移",    "DWG-002", "光电吊舱"],
                   ["3",  "CH-5",     "C3", "005", "东部战区",    "电子对抗",  "李明",  "通信延迟",      "DWG-003", "数据链模块"],
                   ["4",  "TB-2",     "D4", "007", "海军陆战队",  "海上侦察",  "陈强",  "燃油效率低",    "DWG-004", "燃油系统"],
                   ["5",  "Wing Loong", "E5","009", "西部战区",    "边境巡逻",  "周涛",  "起落架异常",    "DWG-005", "起落架总成"]
               ]

               testData.forEach(row => {
                   tableModel.appendRow({
                       index: row[0],
                       planeShape: row[1],
                       batchNo: row[2],
                       sortiesNo: row[3],
                       unit: row[4],
                       professionId: row[5],
                       presenterId: row[6],
                       problemDesc: row[7],
                       proChartNo: row[8],
                       proChartName: row[9]
                   })
               })
            }
           function loadRecord(){
               processInfo.recordId = 0
               processInfo.uavType = ""
               processInfo.uavName = ""
               processInfo.uavId = ""
               processInfo.uavComponentType = "" //对应里面下拉列表中管理界面
               processInfo.loadViewType = ""//加载界面类型，主要是区分查看与编辑
               console.log("loadRecord()"+JSON.stringify(processInfo))
           }

           function loadProcessInfo(model, row) {
               processInfo.recordId = model.rows[row].recordId
               processInfo.uavType = model.rows[row].uavType
               processInfo.uavName = model.rows[row].uavName
               processInfo.uavId = model.rows[row].uavId
           }
           //对于uav搜索框的控制
           function inputValidator() {
               if (modelSelector.currentIndex === 0 && uavIdSelect.text === "" && uavNameSelect.text ==="") {
                   warningPopup.open()
                   // 2秒后自动关闭
                   warningItem.text = "您查询的是全部数据！"
                    autoCloseTimer.start()
                   loadUavAllData()
                   loadRecord()
                   return false
               }else{
                   console.log("搜索")
               }

               return true
           }

           function onSelectCheckBoxClicked(checked) {
               for (let i = 0; i < tableModel.rowCount; i++) {
                  rowsModel[i].checked = checked ? Qt.Checked : Qt.Unchecked
               }
               tableModel.rows = rowsModel
           }
           function onAllSelectCheckBoxClicked(selectStr){
               //var check = false; // 使用 var 声明变量
               if(selectStr === "allSelect"){
                   for (var i = 0; i < tableModel.rowCount; i++) {
                      //rowsModel[i].checked = true//Qt.Checked
                       console.log("qqqqqqqqqqqqqqqallSelect"+i+"as"+tableModel.rowCount)
                       // rowsModel[i].checked = true
                       // tableModel.rows = rowsModel
                        tableModel.rows[i].checked = true;
                       tableView.model = tableModel
                       // tableModel.layoutChanged(); // 通知表格刷新
                   }
               }else if(selectStr === "allSelectCancel"){
                   for (var j = 0; j < tableModel.rowCount; j++) {
                      //rowsModel[j].checked = false// Qt.Unchecked
                       tableModel.rows[i].checked = false;
                        tableView.model = tableModel
                       console.log("qqqqqqqqqqqqqqqallSelectCalcel"+j+"as"+tableModel.rowCount)
                       //tableModel.layoutChanged(); // 通知表格刷新
                   }
               }else{
                   console.log("未知选择")
               }

           }

           function onRecordListViewDoubleClicked(model, row) {
               print(model.rows[row].occurChance) //机型

               pageLoader.setSource("qrc:/ui/delivery/DeliveryProblemRecord.qml",
                                    {recordEntity: model.rows[row], windowModel: 1,
                                        backUi: "qrc:/ui/delivery/DeliveryRecordListView.qml"})
           }

           function onModifyButtonClicked() {
           }
           function onDelButtonClicked() {
               var selectedRowsData = [];
                   for (var i = 0; i < tableModel.rowCount; i++) {

                       //console.log("tableModel.rows[i].checked Rows JSON:", JSON.stringify(tableModel.rows[i]));
                       //console.log("",JSON.stringify(tableModel.rows))
                       if (tableModel.rows[i].checked) {
                           var rowData = {
                               uav_type: tableModel.rows[i].uavType,
                               uav_name: tableModel.rows[i].uavName,
                               uav_id: tableModel.rows[i].uavId,
                               payload_type: tableModel.rows[i].payloadType,
                               bomb_method: tableModel.rows[i].bombMethod,
                               recovery_mode: tableModel.rows[i].recoveryMode,
                               hanging_capacity: tableModel.rows[i].hangingCapacity,
                               operation_method: tableModel.rows[i].operationMethod,
                               create_time: tableModel.rows[i].uavCreatModelTime
                           };
                           //console.log("tableModel.rows[i].uavType Rows JSON:", tableModel.rows[i].uavType);
                           selectedRowsData.push(rowData);
                       }
                   }

                   // 将选中的行的数据转换为 JSONArray 格式
                   var selectedRowsJson = JSON.stringify(selectedRowsData);
                   //console.log("Selected Rows JSON:", selectedRowsJson);
                    if (selectedRowsData.length === 0) {
                        warningPopup.open()
                        warningItem.text = "请选择复选框删除数据"
                        // 2秒后自动关闭
                        autoCloseTimer.start()
                        return false;
                    }else{
                        //console.log("DeleteUavData"+selectedRowsJson)
                        uavModelDaoTable.deleteModelDate(selectedRowsData)

                    }
                loadUavAllData()
    }
}
