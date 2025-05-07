import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtQuick.Window 2.12
import Qt.labs.qmlmodels 1.0
import QtQuick.Controls.Styles 1.4
import QtQuick.Dialogs 1.2
import "."
import "qrc:/"   //引入所有的qml文件使用
import "qrc:/AddAmmoModules/Component"
import "qrc:/AddAmmoModules/"
import InterferencePodDaoModel 1.0
import AmmoDaoModel 1.0
import ReconnaissanceCommunicationDaoModel 1.0

/**
https://blog.csdn.net/qq_24890953/article/details/104640454
  */
//Window {
Rectangle {
           id: reconnaissanceCommunicationRecordManagementroot
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
           property var ammoTypeSelect: []
           property var payloadData:new Object  //创建对象来实现数据的查询

           anchors.fill: parent//width: 1400; height: 760//width: screenWidth; height: screenHeight

           property int bottonHeight: 50
           Loader {
               id: reconnaissanceCommunicationRecordLoader  // 必须的标识符
               anchors.fill: parent  // 填充父容器
               visible: true    // 确保可见
               // 监听信号并切换界面
              Connections {
                  target: reconnaissanceCommunicationRecordLoader.item
                  onReconnaissanceCommunicationRecord: {
                      loadPayloadData()
                      loadPayloadRecord(payloadData)
                      console.log("connectuion!!!!!")
                      reconnaissanceCommunicationView.visible = true
                  }
              }

           }

           InterferencePodDaoTableModel{
               id:interferencePodDaoTableModel
           }

           ReconnaissanceCommunicationDaoTableModel{
               id:reconnaissanceCommunicationDaoTableModel
           }

//           AmmoDaoTableModel{
//               id:ammoDaoTableModel
//           }
           // 数据模型
           // 表格数据模型
              TableModel {
                  id: tableModel
                  TableModelColumn { display: "checked" }//复选框
                  TableModelColumn { display: "index" }
                  TableModelColumn { display: "reconnaissanceName" }
                  //TableModelColumn { display: "usedUavModels" }
                  TableModelColumn { display: "frequencyMinimum" }
                  TableModelColumn { display: "frequencyMaximum" }
                  TableModelColumn { display: "description" }
                  TableModelColumn { display: "recordcreationTime"}
                  TableModelColumn { display: "" }
              }
              // 组件加载完成后生成测试数据
              Component.onCompleted:
                {
                      loadPayloadData()
                      loadPayloadRecord(payloadData)
                }


              // 定义查询
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
                          //text: "您查询的是全部数据！"
                          id:warningItem
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
                  id: addAmmoComponentManagementPopup
                  width: 456  // 需明确设置宽度，否则可能无法显示完整内容
                  height: 400
                  modal: true
                  focus: true
                  anchors.centerIn: Overlay.overlay // 居中显示
                  closePolicy: Popup.NoAutoClose    // 完全禁用自动关闭

                  // 直接引用 admin.qml
                    AddAmmoComponentManagement{  // 假设 admin.qml 的根元素是 Admin 类型
                          id: addAmmoComponentManagementPanel
                          anchors.fill: parent
                          //managementType:uavManagementroot.managementType

                          onClose: addAmmoComponentManagementPopup.close() // 连接关闭信号


                      }

                    function setup(name){
                        addAmmoComponentManagementPanel.title = name
                    }

                    function setUpAmmoCompType(name){
                        addAmmoComponentManagementPanel.managementType = name
                    }


              }


              Item {
                  id: reconnaissanceCommunicationView
                  height: parent.height
                  ColumnLayout {

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
                              text: qsTr("侦察通信记录");
                              font.pointSize: 16
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
                                  id:interferencePod
                                  width:100
                                  height:50
                                  font.pointSize: 12
                                  text: "侦察通信名称:"
                              }
                              TextField{
                                  id:reconnaissanceCommunicationText
                                  width: 100
                                  height:50
                                  font.pointSize: 12
                                  onTextChanged: {
                                      // 使用正则表达式移除首尾的空白字符（包括空格、tab、换行）
                                      var newText = text.replace(/^[\s\uFEFF\xA0]+|[\s\uFEFF\xA0]+$/g, '')

                                      // 判断是否需要更新（避免无限循环）
                                      if (newText !== text) {
                                          // 保存当前光标位置
                                          var cursorPos = cursorPosition

                                          // 更新文本
                                          text = newText

                                          // 恢复光标位置（考虑文本缩短的情况）
                                          cursorPosition = Math.min(cursorPos, newText.length)
                                      }
                                  }
                              }

                              Item {
                                  id: item
                                  width:100
                                  height:50
                              }
                              Button{
                                  id:selectButton
                                  width:100
                                  height:50
                                  font.pointSize: 12
                                  text: "搜索"
                                  Layout.leftMargin: 30
                                  onClicked: {
                                      //inputValidator()
                                      if(reconnaissanceCommunicationText.length === 0 ){
                                          warningItem.text = "查询全部数据!"
                                          warningPopup.open()
                                          // 2秒后自动关闭
                                          autoCloseTimer.start()
                                      }
                                       payloadData.interferencePodName = reconnaissanceCommunicationText.text
                                       loadPayloadRecord(payloadData)
                                       loadPayloadData()
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
                                      reconnaissanceCommunicationText.text = ""
                                  }
                              }

                              Item { Layout.fillWidth: true }
                          }
                      }
                      RowLayout {
                          Layout.minimumWidth: reconnaissanceCommunicationRecordManagementroot.width
                          Layout.minimumHeight: reconnaissanceCommunicationRecordManagementroot.height-380
                          Layout.fillHeight: true
                          Layout.fillWidth: true

                          Item {
                              id: control
                              implicitHeight: reconnaissanceCommunicationRecordManagementroot.width
                              implicitWidth: reconnaissanceCommunicationRecordManagementroot.height-380
                              Layout.fillWidth: true
                              Layout.fillHeight: true

                              //表头行高
                              property int headerHeight: dpH(48)
                              //行高
                              property int rowHeight: dpH(48)
                              property int tableLeft: dpH(0)//表距离左边的距离
                              //滚动条
                              property color scrollBarColor: "#E5E5E5"
                              property int scrollBarWidth: 7
                              //列宽
                              property variant columnWidthArr: [50,50, 200,  120, 120,360, 200,300 ]//180,

                              // 显示10个字段
                              property var horHeader: ["","序号", "通信侦察名称", "频率最小值", "频率最大值",//"使用机型",
                                  "用途描述","时间",  "操作"]
                              property int selected: -1
                              //数据展示
                              TableView {
                                  id: tableView
                                  implicitHeight: reconnaissanceCommunicationRecordManagementroot.width
                                  implicitWidth: reconnaissanceCommunicationRecordManagementroot.height-380
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

                                      DelegateChoice {
                                          column:7
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
                                                          processInfo.recordId = transformedData.recordId
                                                          processInfo.loadViewType = "query"
                                                          processInfo.originData = transformedData

                                                          //console.log("processInfo JSONDATA"+JSON.stringify(processInfo))
                                                          reconnaissanceCommunicationRecordLoader.setSource("qrc:./AddReconnaissanceCommunicationData_add.qml",//AddReconnaissanceCommunicationData
                                                                               {processInfo: processInfo,
                                                                                   backUi: "qrc:/ReconnaissanceCommunicationRecordManagement.qml"})
                                                          reconnaissanceCommunicationView.visible = false
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
                                                          processInfo.recordId = transformedData.recordId
                                                          processInfo.loadViewType = "update"
                                                          processInfo.originData = transformedData

                                                          console.log("processInfo JSONDATA"+JSON.stringify(processInfo))
                                                          reconnaissanceCommunicationRecordLoader.setSource("qrc:./AddReconnaissanceCommunicationData_add.qml",//AddReconnaissanceCommunicationData
                                                                               {processInfo: processInfo,
                                                                                   backUi: "qrc:/ReconnaissanceCommunicationRecordManagement.qml"})
                                                          reconnaissanceCommunicationView.visible = false
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
//                                                           onEntered: {
//                                                               var pos = mapToGlobal(0, 0)
//                                                               tooltip.x = pos.x //+ width + 10
//                                                               tooltip.y = pos.y -10
//                                                               tooltipText.text = display
//                                                               tooltip.open()
//                                                           }
//                                                           onExited: tooltip.close()
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

                          }
                      }
                      RowLayout {
                          Layout.preferredHeight: 60

                          Rectangle {
                              anchors.fill: parent
                          }

                          //Item { Layout.leftMargin: 20 }
                          Item { Layout.fillWidth: true }
//                          Button {
//                              id: killingMethodManagement
//                              text: "杀伤方式管理"
//                              onClicked: {

//                                  addAmmoComponentManagementPopup.setup("杀伤方式")
//                                  addAmmoComponentManagementPopup.setUpAmmoCompType("killingMethod")
//                                  addAmmoComponentManagementPopup.open()

//                              }
//                          }
                          Item { Layout.fillWidth: true }
//                          Button {
//                              id: attackTargetTypeManagement
//                              text: "打击目标类型管理"
//                              onClicked: {
//                                 addAmmoComponentManagementPopup.setup("打击目标类型")
//                                  addAmmoComponentManagementPanel.managementType = "attackTargetType"//addAmmoComponentManagementPopup.setUpAmmoCompType("attackTargetType")
//                                  addAmmoComponentManagementPopup.open()

//                              }
//                          }
                          Item { Layout.fillWidth: true }
//                          Button {
//                              id: deliveryMethodManagement
//                              text: "发射方式管理"
//                              onClicked: {
//                                  addAmmoComponentManagementPopup.setup("发射方式")
//                                  addAmmoComponentManagementPopup.setUpAmmoCompType("deliveryMethod")
//                                  addAmmoComponentManagementPopup.open()
//                                  //addAmmoComponentManagementPanel.managementType = "deliveryMethod"
//                              }
//                          }
                          Item { Layout.fillWidth: true }
//                          Button {
//                              id: guidanceTypeManagement
//                              text: "制导类型管理"
//                              onClicked: {
//                                 addAmmoComponentManagementPopup.setup("制导类型")
//                                  addAmmoComponentManagementPopup.setUpAmmoCompType("guidanceType")
//                                  addAmmoComponentManagementPopup.open()
//                                  //addAmmoComponentManagementPanel.managementType = "guidanceType"
//                              }
//                          }
                          Item { Layout.fillWidth: true }
//                          Button {
//                              id: payloadTypeManagement
//                              text: "弹药类型管理"
//                              onClicked: {
//                                  addAmmoComponentManagementPopup.setup("弹药类型")
//                                  addAmmoComponentManagementPopup.setUpAmmoCompType("ammunitionType")
//                                  addAmmoComponentManagementPopup.open()
//                                  //addAmmoComponentManagementPanel.managementType = "ammunitionType"
//                              }
//                          }
                          Item { Layout.fillWidth: true }

                          Item { Layout.leftMargin: 50 }//Item { Layout.fillWidth: true }
                          Button {
                              id: delUavManagement
                              text: "删除侦察通信"
                              onClicked: {
                                  deletePayloadData();
                              }
                          }
                          Item { Layout.leftMargin: 20 }
                          Button {
                              id: addUavManagement
                              text: "新增侦察通信"
                              onClicked: {


                                  processInfo.loadViewType = "addUavData"
                                  reconnaissanceCommunicationRecordLoader.setSource("qrc:./AddReconnaissanceCommunicationData_add.qml") //AddReconnaissanceCommunicationData
                                  reconnaissanceCommunicationView.visible = false
                              }
                          }
                          Item { Layout.rightMargin: 20 }
                      }
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


           function onSelectCheckBoxClicked(checked) {
               for (let i = 0; i < tableModel.rowCount; i++) {
                  rowsModel[i].checked = checked ? Qt.Checked : Qt.Unchecked
               }
               tableModel.rows = rowsModel
           }
           function dpH(h) {
               return h
           }
           function loadPayloadData(){
             reconnaissanceCommunicationRecordManagementroot.payloadData.interferencePodName = ""
             reconnaissanceCommunicationRecordManagementroot.payloadData.interferencePodId = ""
           }
           function loadAmmoType(){
            var ammoTypeArray = ammoTypeDaoTableModel.selectAmmoTypeAllData()
               console.log("teaaaastammoType"+JSON.stringify(ammoTypeArray))
               var names = ["请选择:"];
                       for (var i = 0; i < ammoTypeArray.length; i++) {
                           names.push(ammoTypeArray[i].ammoComponeName);
                       }
              console.log("testAmmoo"+JSON.stringify(names))
              reconnaissanceCommunicationRecordManagementroot.ammoTypeSelect = names

           }
           function loadPayloadRecord(data){
            var result = reconnaissanceCommunicationDaoTableModel.selectReconnaissanceCommunicationData(data)
               console.log("reconnaissanceCommunicationdata+"+JSON.stringify(result))
               tableModel.clear()
               rowsModel.length = 0;

               tableModel.rows = result;
               rowsModel = tableModel.rows;

               // 自动刷新表格
               tableModel.layoutChanged()

           }
           function deletePayloadData(){

                   var selectedRowsData = [];
                   for (var i = 0; i < tableModel.rowCount; i++) {

                       //console.log("tableModel.rows[i].checked Rows JSON:", JSON.stringify(tableModel.rows[i]));
                       //console.log("tablemodel",JSON.stringify(tableModel.rows))
                       if (tableModel.rows[i].checked) {
                           var rowData = {
                               recordId: tableModel.rows[i].recordId
                               //uavmountLocationId: tableModel.rows[i].uavmountLocationId
                           };

                           selectedRowsData.push(rowData);
                       }
                   }
                   // 打印当前函数的名称
                    console.log("当前函数名称:", arguments.callee.name);
                   console.log("tableModel.rows[i] ammo Rows JSON:"+JSON.stringify(selectedRowsData));
                   if (selectedRowsData.length === 0) {
                       console.log("数组为空");
                       warningItem.text = "数据删除不能为空!"
                       warningPopup.open()
                       // 2秒后自动关闭
                       autoCloseTimer.start()
                   } else {
                       console.log("数组不为空");
                       let result = reconnaissanceCommunicationDaoTableModel.deleteReconnaissanceCommunicationData(selectedRowsData)
                       loadPayloadData()
                       loadPayloadRecord(payloadData)
                       if(result === true){
                           warningItem.text = "数据删除成功!"
                           warningPopup.open()
                           // 2秒后自动关闭
                           autoCloseTimer.start()
                       }else if(result === false){
                           warningItem.text = "数据删除失败!"
                           warningPopup.open()
                           // 2秒后自动关闭
                           autoCloseTimer.start()
                        }else{
                           console.log("unknown deleteMountLocation")
                       }

                   }





                   // 将选中的行的数据转换为 JSONArray 格式
//                   var selectedRowsJson = JSON.stringify(selectedRowsData);
//                   console.log("Selected deleteMountLocationDataRows JSON:", selectedRowsJson);
//                   return selectedRowsData

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

           function transformData(data){
               return {
                   "reconnaissanceName":data.reconnaissanceName,
                   "usedUavModels":data.usedUavModels,
                   "recordId":data.recordId,
                   "frequencyMinimum":data.frequencyMinimum,
                   "frequencyMaximum":data.frequencyMaximum,
                   "description":data.description,
                   "imageUrl":data.imageUrl
               }
           }
}
