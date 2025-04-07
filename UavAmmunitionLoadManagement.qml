import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtQuick.Window 2.12
import Qt.labs.qmlmodels 1.0
import QtQuick.Controls.Styles 1.4
import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.12
import "."
/**
https://blog.csdn.net/qq_24890953/article/details/104640454
  */
//Window {
Rectangle {
           id: uavManagementroot
           visible: true
           color: "#ECF2FE"
           signal customSignal(string message)
           property int screenWidth: Qt.platform.os === "android" ? Screen.width : 975;
           property int screenHeight: Qt.platform.os === "android" ? Screen.height : 608;
           property color borderColor: "#A5B3C0"
           property color headerColor: "#D3E1FE"
           property color fontColor: "#3E3E3E"
           property var rowsModel: []
           property var selectRow: []
           property string managementType: "";

           width: 1400; height: 720//width: screenWidth; height: screenHeight

           property int bottonHeight: 50
           Loader {
               id: pageUavModelLoader  // 必须的标识符
               anchors.fill: parent  // 填充父容器
               visible: true    // 确保可见
           }
           // 数据模型
           // 表格数据模型
              TableModel {
                  id: tableModel
                  TableModelColumn { display: "index" }        // 序号
                  TableModelColumn { display: "planeShape" }   // 机型
                  TableModelColumn { display: "batchNo" }      // 批次
                  TableModelColumn { display: "sortiesNo" }    // 架次
                  TableModelColumn { display: "unit" }         // 接装部队
                  TableModelColumn { display: "professionId" } // 部队专业
                  TableModelColumn { display: "presenterId" }  // 提出者ID
                  TableModelColumn { display: "problemDesc" }  // 观察项内容
                  TableModelColumn { display: "proChartNo" }   // 产品图号
                  TableModelColumn { display: "proChartName" } // 产品名称


              }
              // 组件加载完成后生成测试数据
              Component.onCompleted: generateTestData()
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
                          text: "您查询的是全部数据！"
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


       //     Component.onCompleted: {
       //         // 清空从引导界返回后携带的数据。
       //         processInfo.processId = "";
       //         processInfo.stepId = "";
       //         processInfo.operateId = "";
       //         processInfo.taskId = "";

       //         loadDeliveryBatchModel()
       //         loadDeliveryRecordList(processInfo)
       //     }

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
                       text: qsTr("弹药记录");
                       font.pointSize: 20
                       color: "black"
                   }
                   Item { Layout.fillWidth: true }
                   // MxImageButton {
                   //     id: viewButton
                   //     width: 232; height: 46
                   //     text: "接装问题处置确认"
                   //     source: "qrc:/res/icons/problemRecord-2.png"
                   //     sourceSize: "232x46"
                   //     showOutline: false
                   //     onButtonClicked: {
                   //         nativeModel.vibrate();

                   //         pageLoader.setSource("qrc:/ui/delivery/DeliveryProblemView.qml",
                   //                              {processInfo: processInfo,
                   //                                  backUi: "qrc:/ui/delivery/DeliveryRecordListView.qml"})
                   //     }
                   // }
                   // MxBackButton {
                   //     id: backButton
                   //     width: 110
                   //     sourceSize: "110x44"
                   //     Layout.leftMargin: 50
                   //     Layout.rightMargin: 10
                   //     onButtonClicked: {
                   //         pageLoader.setSource("qrc:/ui/MainWindow.qml")
                   //     }
                   // }
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
                           text: "弹药类型:"
                       }
                       ComboBox {
                           id: modelSelector
                           width: 160
                           height: 40
                           font.pointSize: 12
                           model: ["全部","侦察无人机","攻击无人机","查打一体无人机"]
                       }
                       Label{
                           id:inputUavIdData
                           width:100
                           height:50
                           font.pointSize: 12
                           text: "弹药名称:"
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
                           text: "制导类型:"
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
                       property variant columnWidthArr: [50, 100, 180, 180, 180,
                           180, 300, 300, 120, 180]
                       // 显示10个字段
                       property var horHeader: ["序号", "弹药类型", "弹药名称", "制导类型", "弹药尺寸",
                           "可打击目标类型", "投放方式", "投放角度", "杀伤药量", "杀伤方式"]
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
                               leftMargin: control.tableLeft
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
                           delegate: Rectangle {
                               color: (model.row % 2) ? "#FFFFFF": "#EBF2FD"
                               width: control.columnWidthArr[column]
                               height: control.rowHeight
                               //color: column === control.operateCol ? "#03A9F4" : (model.row % 2) ? "#FFFFFF": "#EBF2FD"
                               Text {
                                   anchors.fill: parent
                                   verticalAlignment: Text.AlignVCenter
                                   horizontalAlignment: Text.AlignHCenter
                                   text: display
                                   font.pointSize: 16
                                   color: "#000000"
                                   //color: Commons.taskShowColumnColor(column, display)
                                   elide: Text.ElideRight
                               }
                               Rectangle {
                                   color: borderColor
                                   width: parent.width
                                   height: 1
                                   anchors {
                                       bottom: parent.bottom
                                   }
                               }
                               Rectangle {
                                   height: parent.height
                                   width: 1
                                   anchors.right: parent.right
                                   color: borderColor
                               }
                               MouseArea {
                                   anchors.fill: parent
                                   onPressAndHold: {
                                       // 最后一列不显示
                                       /*if (column >= tableModel.columnCount - 1) {
                                           return false
                                       }*/

                                       let value = tableModel.data(tableModel.index(row, column), "display")
                                       if (value.length > 0) {
                                           var p = mapToItem(uavManagementroot, mouse.x, mouse.y)
                                           tipsArrowPopup.arrowPosition = 300
                                           let content = value

                                           tipsArrowPopup.backgroundWidth = 400
                                           tipsArrowPopup.content = content
                                           tipsArrowPopup.backgroundHeight = 40 + tipsArrowPopup.contentHeight

                                           p.x = p.x - mouse.x-80-tipsArrowPopup.arrowPosition
                                           tipsArrowPopup.showArrowRight(p, content)
                                       }
                                   }
                                   onReleased: {
                                       tipsArrowPopup.close()
                                   }
                                   onClicked: {
                                       nativeModel.vibrate()
                                   }

                                   onDoubleClicked: {
                                       nativeModel.vibrate()
                                       onRecordListViewDoubleClicked(tableModel, row)
                                   }
                               }
                           }
                       }
                       //全选按钮
                       Rectangle {
                           width: control.tableLeft
                           height: control.rowHeight
                           color: "#F8F8F8"
                           anchors {
                               top: parent.top
                               left: parent.left
                           }
                           CheckBox {
                               checked: false
                               id: checkBox
                               anchors {
                                   verticalCenter: parent.verticalCenter
                                   horizontalCenter: parent.horizontalCenter
                               }
                               onClicked: {

                                   onSelectCheckBoxClicked(checkBox.checked)
                               }
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
                       //表头
                       Item {
                           anchors {
                               left: parent.left
                               right: parent.right
                               leftMargin: control.tableLeft
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
                       Column {
                           anchors {
                               top: parent.top
                               bottom: parent.bottom
                               topMargin: control.headerHeight
                           }
                           topPadding: -tableView.contentY
                           z: 2
                           clip: true
                           spacing: 0
                           Repeater {
                               model: tableView.rows > 0 ? tableView.rows : 0
                               Rectangle {
                                   width: control.tableLeft
                                   height: control.rowHeight
                                   color: "white"
                                   CheckBox { //自定义多选框组件
                                       checked: tableView.model.rows.length > 0 ? tableView.model.rows[index].checked : false
                                       anchors.centerIn: parent
                                       onClicked: {
                                           // console.log(index)
                                           // if(checkState == Qt.Checked){
                                           //     selectRow.push(rowModel)
                                           // }else {
                                           //     selectRow = selectRow.filter(item => item.recordId != rowModel[index].recordId)
                                           // }
                                           // console.log("checkedSelect")

                                           rowsModel["checked"] = checkState
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
                       }
                   }
               }
               RowLayout {
                   Layout.preferredHeight: 60

                   Rectangle {
                       anchors.fill: parent
                   }

                   //Item { Layout.leftMargin: 20 }
                   Item { Layout.fillWidth: true }
                   Button {
                       id: killingMethodManagement
                       text: "杀伤方式管理"
                       onClicked: {
                          // onModifyButtonClicked();
                           payloadTypeManagementPopup.open()
                           uavManagementroot.managementType = "killingMethod"
                           uavManagementroot.enabled = false
                           //uavManagementroot.visible = false
                       }
                   }
                   Item { Layout.fillWidth: true }
                   Button {
                       id: attackTargetTypeManagement
                       text: "打击目标类型管理"
                       onClicked: {
                          // onModifyButtonClicked();
                           payloadTypeManagementPopup.open()
                           uavManagementroot.managementType = "attackTargetType"
                           uavManagementroot.enabled = false
                           //uavManagementroot.visible = false
                       }
                   }
                   Item { Layout.fillWidth: true }
                   Button {
                       id: deliveryMethodManagement
                       text: "投放方式管理"
                       onClicked: {
                          // onModifyButtonClicked();
                           payloadTypeManagementPopup.open()
                           uavManagementroot.managementType = "deliveryMethod"
                           uavManagementroot.enabled = false
                           //uavManagementroot.visible = false
                       }
                   }
                   Item { Layout.fillWidth: true }
                   Button {
                       id: guidanceTypeManagement
                       text: "制导类型管理"
                       onClicked: {
                          // onModifyButtonClicked();
                           payloadTypeManagementPopup.open()
                           uavManagementroot.managementType = "guidanceType"
                           uavManagementroot.enabled = false
                           //uavManagementroot.visible = false
                       }
                   }
                   Item { Layout.fillWidth: true }
                   Button {
                       id: payloadTypeManagement
                       text: "弹药类型管理"
                       onClicked: {
                          // onModifyButtonClicked();
                           payloadTypeManagementPopup.open()
                           uavManagementroot.managementType = "ammunitionType"
                           uavManagementroot.enabled = false
                           //uavManagementroot.visible = false
                       }
                   }
                   Item { Layout.leftMargin: 50 }//Item { Layout.fillWidth: true }
                   Button {
                       id: delUavManagement
                       text: "删除弹药"
                       onClicked: {
                          // onDelButtonClicked();
                       }
                   }
                   Item { Layout.leftMargin: 20 }
                   Button {
                       id: addUavManagement
                       text: "新增弹药"
                       onClicked: {
                           pageUavModelLoader.setSource("qrc:./AddAmmunitionLoadData.qml")
                          // onDelButtonClicked();
                       }
                   }
                   Item { Layout.rightMargin: 20 }
               }
           }



           function dpH(h) {
               return h
           }

           function loadProcessInfo(model, row) {
               processInfo.recordId = model.rows[row].recordId
               processInfo.planeShape = model.rows[row].planeShape //机型
               processInfo.batchNo = model.rows[row].batchNo   //批次
               processInfo.sortiesNo = model.rows[row].sortiesNo //架次
               processInfo.deliveryArmy = model.rows[row].deliverArmy // 接装部队
               processInfo.professionId = model.rows[row].professionId // 部队专业
               processInfo.presenterId = tableModel.rows[row].presenterId	// 提出者
               processInfo.presenterName = tableModel.rows[row].presenterName	// 提出者
           }

           function inputValidator() {
               if (modelSelector.currentIndex === 0 && uavIdSelect.text === "" && inputUavNameSelect.text ==="") {
                   warningPopup.open()
                   // 2秒后自动关闭
                    autoCloseTimer.start()
                   return false
               }
               return true
           }

           ///
           function loadDeliveryRecordList(info) {
               filterObject.planeShape = modelSelector.currentIndex === 0 ? "" : modelSelector.currentText
               filterObject.batchNo = batchCommbox.currentIndex === 0 ? "" : batchCommbox.currentText
               filterObject.sortiesNoStart = beginSortieCommbox.currentText
               filterObject.sortiesNoEnd = endSortieCommbox.currentText
               filterObject.proposedDate = foundDateCommbox.content
               filterObject.professionId = profSelector.currentIndex === 0 ? "" : profSelector.currentText
               filterObject.presenterId = inspectUser.content
               filterObject.armyUnit = armyUnit.content
               //filterObject.notProblemStatus = "'已处置', '已归零'";
               filterObject.problemStatus = "处置中";

               var jsonstr = deliveryRecordModel.select(filterObject)
               var jsonobjs = Commons.parseResponse(jsonstr)
               if (jsonobjs.code !== 200)
                   return 0;

               tableModel.clear();
               rowsModel.length = 0;

               tableModel.rows = jsonobjs.lists;
               rowsModel = tableModel.rows;
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

           function loadColumnValue(row, column) {
               let value = "";

               switch (column) {
               case 3:
                   value = tableModel.rows[row].checkItem
                   break;
               }

               return value
           }



           function loadDeliveryBatchModel() {
               // 获取机型信息
               let jsonString = deliveryBatchNoModel.select(0)
               let jsonObject = Commons.parseResponse(jsonString)
               if (jsonObject.code === 200) {
                   planeShapeList = jsonObject.lists
               }

               // 批次信息
               jsonString = deliveryBatchNoModel.select(2)
               jsonObject = Commons.parseResponse(jsonString)
               if (jsonObject.code === 200) {
                   batchNoList = jsonObject.lists
               }

               // 架次信息
               jsonString = deliveryBatchNoModel.select(1)
               jsonObject = Commons.parseResponse(jsonString)
               if (jsonObject.code === 200) {
                   sortiesList = jsonObject.lists
               }

               // 专业信息
               jsonString = deliveryBatchNoModel.select(3)
               jsonObject = Commons.parseResponse(jsonString)
               if (jsonObject.code === 200 && jsonObject.lists.length > 1) {
                   professionList = jsonObject.lists
               }

               // 配合单位信息
               jsonString = deliveryBatchNoModel.select(4)
               jsonObject = Commons.parseResponse(jsonString)
               if (jsonObject.code === 200) {
                   withUnitList = jsonObject.lists
               }

               // 保留过滤项
               if (filterObject.planeShape.length > 0) {   // 机型
                   let index = Commons.currentIndex(planeShapeList, filterObject.planeShape)
                   modelSelector.currentIndex = index !== -1 ? index : 0
               }
               if (filterObject.batchNo.length > 0) {  // 批次
                   let index = Commons.currentIndex(batchNoList, filterObject.batchNo)
                   batchCommbox.currentIndex = index !== -1 ? index : 0
               }

               //架次改为手动输入
       //        if (filterObject.sortiesBegin.length > 0) {  // 架次
       //            let index = Commons.currentIndex(sortiesList, filterObject.sortiesBegin)
       //            beginSortieCommbox.currentIndex = index !== -1 ? index : 0
       //        }
       //        if (filterObject.sortiesEnd.length > 0) {  // 结束架次
       //            let index = Commons.currentIndex(sortiesList, filterObject.sortiesEnd)
       //            endSortieCommbox.currentIndex = index !== -1 ? index : 0
       //        }
           }

           function resetTaskFilterObject() {
               filterObject.planeShape = ""
               filterObject.batchNo = ""
               filterObject.sortiesBegin = ""
               filterObject.sortiesEnd = ""
               filterObject.proposedDate = ""
               //filterObject.professionId = ""
               //filterObject.withUnit = ""
           }

           function onSelectCheckBoxClicked(checked) {
               for (let i = 0; i < tableModel.rowCount; i++) {
                  rowsModel[i].checked = checked ? Qt.Checked : Qt.Unchecked
               }
               tableModel.rows = rowsModel
           }

           function onRecordListViewDoubleClicked(model, row) {
               print(model.rows[row].occurChance) //机型

               pageLoader.setSource("qrc:/ui/delivery/DeliveryProblemRecord.qml",
                                    {recordEntity: model.rows[row], windowModel: 1,
                                        backUi: "qrc:/ui/delivery/DeliveryRecordListView.qml"})
           }

           function onAddButtonClicked() {
               pageLoader.setSource("qrc:/ui/delivery/DeliveryProblemRecord.qml",
                                    {processInfo: processInfo,
                                        backUi: "qrc:/ui/delivery/DeliveryRecordListView.qml"})
           }

           function onCopyButtonClicked() {

           }

           function onModifyButtonClicked() {
           }



           function onDelButtonClicked() {
               let selectCount = 0;
               for (let i = 0; i < tableModel.rowCount; i++) {
                   if (tableModel.rows[i].checked === Qt.Checked) {
                       selectCount ++;
                   }
               }
               if (selectCount === 0) {
                   toastModel.show("请选择要删除的问题");
                   return false;
               }

               // 数字可以任意
               alertDialog.confirm(4, "是否要删除当前选中的问题？")
           }

           function onAlertConfirmButtonClicked() {
               let recordIds = [];
               for (let i = 0; i < tableModel.rowCount; i++) {
                   if (tableModel.rows[i].checked === Qt.Checked) {
                       recordIds.push(tableModel.rows[i].recordId);
                   }
               }

               if (deliveryRecordModel.remove(recordIds)) {
                   checkBox.checked = false;

                   loadDeliveryRecordList(processInfo);
               }
           }
       }
