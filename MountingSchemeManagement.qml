import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtQuick.Window 2.12
import Qt.labs.qmlmodels 1.0
import QtQuick.Controls.Styles 1.4
import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.12
import UavDaoModel 1.0
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
               //generateTestData()
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
                  TableModelColumn { display: "uavInvisibility" }//是否隐身
                  TableModelColumn { display: "recordId" }//型号记录编号
                  TableModelColumn { display: "uavCreatModelTime" }//创建时间
                  TableModelColumn { display: "operation" } // 操作(查看/编辑)
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
                       text: qsTr("挂载方案记录");
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
                           text: "吊舱配置:"
                       }
                       ComboBox {
                           id: modelSelector
                           width: 160
                           height: 40
                           font.pointSize: 12
                           model: ["无吊舱","200kg通侦吊舱","500kg吊舱"]
                       }
                       Label{
                           id:inputUavIdData
                           width:100
                           height:50
                           font.pointSize: 12
                           text: "弹药类型:"
                       }
                       ComboBox {
                           id: inputUavId
                           width: 160
                           height: 40
                           font.pointSize: 12
                           model: ["无炸弹","空地炸弹","制导炸弹"]
                       }
                       Label{
                           id:inputUavNameData
                           width:100
                           height:50
                           font.pointSize: 12
                           text: "挂载数量:"
                       }

                       TextField{
                           id:inputUavNameSelect
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
                               inputUavNameSelect.text = ""
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
                       property variant columnWidthArr: [50,50, 140, 140, 140, 140,
                           120, 120, 120, 120,120,160,240, 300]
                       // 显示10个字段
                       property var horHeader: ["","序号", "无人机机型", "无人机名称", "无人机编号", "挂载内容",
                           "操控方式", "投弹方式", "回收方式", "载荷类型","是否隐身","型号记录编号","创建时间", "操作"]
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
                                                   var rowData = tableModel.rows[row]
                                                   console.log("查看行数据:", JSON.stringify(rowData, null, 2))
                                                   processInfo.loadViewType = "query"
                                                   pageUavModelLoader.setSource("qrc:./UavManagement.qml",
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
                                                   console.log("编辑行数据:", JSON.stringify(rowData, null, 2))
                                                   processInfo.loadViewType = "update"
                                                   pageUavModelLoader.setSource("qrc:./UavManagement.qml",
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
                                            font.pointSize: 16
                                            color: "#000000"
                                            elide: Text.ElideRight
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
                                           font.pointSize: 18
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
                           payloadTypeManagementPopup.open()
                           uavManagementroot.managementType = "bombingMethod"
                           uavManagementroot.enabled = false
                           //uavManagementroot.visible = false



                       //     onSelectCheckBoxClicked(checkBox.checked)
                       }
                   }
                   Item { Layout.fillWidth: true }
                   //底部提出问题按钮
                   Button {
                       id: uavRecoverymodeManagement
                       text: "回收方式管理"
                       onClicked: {

                           payloadTypeManagementPopup.open()
                           uavManagementroot.managementType = "recoveryMode"
                           uavManagementroot.enabled = false
                           //uavManagementroot.visible = false
                           customSignal("按钮被点击")
                       }
                   }
                   Item { Layout.fillWidth: true }
                   Button {
                       id: uavHangingLoctionManagement
                       text: "挂载位置管理"
                       onClicked: {
                           //onCopyButtonClicked();
                           payloadTypeManagementPopup.open()
                           uavManagementroot.managementType = "uavHanging"
                           uavManagementroot.enabled = false
                           //uavManagementroot.visible = false
                       }
                   }
                   Item { Layout.fillWidth: true }

                   Button {
                       id: payloadTypeManagement
                       text: "载荷类型管理"
                       onClicked: {
                          // onModifyButtonClicked();
                           payloadTypeManagementPopup.open()
                           uavManagementroot.managementType = "loadType"
                           uavManagementroot.enabled = false
                           //uavManagementroot.visible = false
                       }
                   }
                   Item { Layout.fillWidth: true }
                   Button {
                       id: opreationTypeManagement
                       text: "操控方式管理"
                       onClicked: {
                          // onModifyButtonClicked();
                           payloadTypeManagementPopup.open()
                           uavManagementroot.managementType = "operationType"
                           uavManagementroot.enabled = false
                           //uavManagementroot.visible = false
                       }
                   }
                   Item { Layout.fillWidth: true }
                   Button {
                       id: delUavManagement
                       text: "删除方案"
                       onClicked: {
                           onDelButtonClicked();
                       }
                   }
                   Item { Layout.leftMargin: 20 }
                   Button {
                       id: addUavManagement
                       text: "新增方案"
                       onClicked: {
                           processInfo.loadViewType = "addUavData"
                           pageUavModelLoader.setSource("qrc:./AddMountingSchemeData.qml",
                                                {processInfo: processInfo,
                                                    backUi: "qrc:/MountingSchemeManagement.qml"})
                           // 退出并隐藏界面
                           //uavManagementLoader.setSource = null // 卸载界面
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

           function loadUavAllData(){

               var receiveData = uavModelDaoTable.selectUavModelAllData()
               console.log("+:", JSON.stringify(receiveData, null, 2));
                // 清空旧数据
               tableModel.clear()
               rowsModel.length = 0;

               tableModel.rows = receiveData;
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
               if (modelSelector.currentIndex === 0 && uavIdSelect.text === "" && inputUavNameSelect.text ==="") {
                   warningPopup.open()
                   // 2秒后自动关闭
                   warningItem.text = "您查询的是全部数据！"
                    autoCloseTimer.start()
                   return false
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
