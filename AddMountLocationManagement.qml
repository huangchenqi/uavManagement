import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtQuick.Window 2.12
import Qt.labs.qmlmodels 1.0
import QtQuick.Controls.Styles 1.4
import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.12
import UavMountLocationDaoModel 1.0
/**
https://blog.csdn.net/qq_24890953/article/details/104640454
  */
//Window {
Rectangle {
           id: addMountLocationroot
           visible: true
           color: "#ECF2FE"
           // 暴露接口给父组件
           // property alias tableModel: tableModel
           // signal saveRequested(var selectedData)
           property var loadData: []
           property var resultData: []
           property color borderColor: "#A5B3C0"
           property color headerColor: "#D3E1FE"
           property color fontColor: "#3E3E3E"
           property var rowsModel: []
           property string managementType: "";
           property string queryedit: ""
           property int fontpixelSize: 16   // 设置字体大小为 20 像素: value
           width: 500;
           height: 60//width: screenWidth; height: screenHeight
           //property var rowData : ({test:1})
           property int bottonHeight: 50
           property int maxHeight: 200  // 下拉列表最大高度
           property int minHeight: 20  // 下拉列表最小高度
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
           // 组件加载完成后生成测试数据
           Component.onCompleted:{
               loadUavMountLocationAllData()
           }
           UavMountLocationDaoTableModel{
               id:uavMountLocationDaoTableModel
           }

           // 数据模型
           // 表格数据模型
           TableModel {
              id: tableModel
              TableModelColumn { display: "checked" }//复选框
              TableModelColumn { display: "index"   }        // 序号
              TableModelColumn { display: "uavModelName" }   // 飞机名称
              TableModelColumn { display: "uavmountLocationName" }   // 挂载位置
              TableModelColumn { display: "uavmountLocationId" }    // 位置编号              
              TableModelColumn { display: "uavmountLocationCapacity" }    // 载弹量
            }

                   ColumnLayout {
                       //@disable-check M16
                       anchors.fill: parent
                       Layout.fillWidth: true
                       Layout.fillHeight: true
                       RowLayout {
                           Layout.minimumWidth: addMountLocationroot.width
                           Layout.minimumHeight: addMountLocationroot.height-320
                           Layout.fillHeight: true
                           Layout.fillWidth: true


                           Label {
                               id:addMountLocationShow
                               Layout.leftMargin: 12
                               text: "挂载位置:"
                               font.pointSize: 12
                               width:80
                               height:50
                           }
                           TextField{
                               id:addMountLocationText
                               font.pointSize: 12
                               Layout.preferredWidth: 100   // 指定宽度为 60 像素
                               height: 50
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
                           Label{
                               id:addMountLocationId
                               font.pointSize: 12
                               Layout.leftMargin: 20
                               text: "位置编号:"
                               width:80
                               height: 50
                           }
                           TextField{
                               id:addMountLocationIdText
                               font.pointSize: 12
                               Layout.preferredWidth: 100   // 指定宽度为 60 像素
                               height:50
                               // // 方案一：使用正则表达式验证器（推荐）
                               //     validator: RegExpValidator {
                               //         regExp: /^\d+$/  // 只允许数字输入
                               //     }
                               validator: IntValidator {
                                   bottom: 0
                                   top: 1000
                               }
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
                           Item { Layout.fillWidth: true }

                           Button {
                               id: addMountLocationData
                               Layout.rightMargin: 10
                               //Layout.bottomMargin: 2
                               height: 50
                               width: 80
                               // Layout.preferredWidth: 100
                               // Layout.preferredHeight: 50
                               text: "添加"
                               font.pixelSize: fontpixelSize   // 设置字体大小为 20 像素
                               onClicked: {
                                    saveUavMountLoactionData()
                                    loadUavMountLocationAllData()
                                   // 2秒后自动关闭
                                   autoCloseTimer.start()
                               }
                            }
                        }

                       RowLayout {
                           Layout.minimumWidth: addMountLocationroot.width
                           Layout.minimumHeight: addMountLocationroot.height-280
                           Layout.fillHeight: true
                           Layout.fillWidth: true
                           Item {
                               id: control
                               Layout.topMargin: 2
                               implicitHeight: addMountLocationroot.width
                               implicitWidth: addMountLocationroot.height-280
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
                               property variant columnWidthArr: [50,50, 120, 120,100,100]
                               // 显示10个字段
                               property var horHeader: ["","序号","飞机名称", "挂载位置", "位置编号","载弹量"]
                               property int selected: -1
                               //数据展示
                               TableView {
                                   id: tableView
                                   implicitHeight: addMountLocationroot.width
                                   implicitWidth: addMountLocationroot.height-280
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
                                        DelegateChoice {
                                            column:2
                                            delegate: Rectangle {
                                                color: (model.row % 2) ? "#FFFFFF": "#EBF2FD"
                                                width: control.columnWidthArr[column]
                                                height: control.rowHeight

                                                TextField {
                                                    anchors.fill: parent
                                                    verticalAlignment: Text.AlignVCenter
                                                    horizontalAlignment: Text.AlignHCenter
                                                    text: display
                                                    font.pointSize: 12
                                                    //color: (model.row % 2) ? "#FFFFFF": "#EBF2FD"
                                                    color: "#000000"
                                                    //elide: Text.ElideRight
                                                    // 限制输入为数字和小数
                                                    inputMethodHints: Qt.ImhFormattedNumbersOnly
                                                    // 当文本变化时更新模型数据
                                                    onEditingFinished: {
                                                        // 方法1：通过模型索引修改（推荐）
                                                        const rowIndex = model.row    // 获取当前行索引
                                                        const colIndex = column      // 当前列索引
                                                        // 允许数字和小数点，但不允许连续的小数点
                                                        //         var regex = /^[0-9]*\.?[0-9]*$/;
                                                        // var lastValidText = 0.0
                                                        //         if (!regex.test(text)) {
                                                        //             // 如果输入不符合要求，恢复到上一次有效的值
                                                        //             text = lastValidText;
                                                        //         } else {
                                                        //             // 保存当前有效的值
                                                        //             lastValidText = text;
                                                        //         }
                                                         resultData[rowIndex].uavModelName = text
                                                        updateUavAllData()
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
                                             column:3
                                             delegate: Rectangle {
                                                 color: (model.row % 2) ? "#FFFFFF": "#EBF2FD"
                                                 width: control.columnWidthArr[column]
                                                 height: control.rowHeight

                                                 TextField {
                                                     id:threecol
                                                     anchors.fill: parent
                                                     verticalAlignment: Text.AlignVCenter
                                                     horizontalAlignment: Text.AlignHCenter
                                                     text: display//modelData.mountCount
                                                     font.pointSize: 12
                                                     //color: (model.row % 2) ? "#FFFFFF": "#EBF2FD"
                                                     color: "#000000"
                                                     //elide: Text.ElideRight

                                                     // 当文本变化时更新模型数据
                                                     onEditingFinished:{
                                                         // 方法1：通过模型索引修改（推荐）
                                                         const rowIndex = model.row    // 获取当前行索引
                                                         const colIndex = column      // 当前列索引
                                                         resultData[rowIndex].uavmountLocationName = text
                                                         updateUavAllData()
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
                                            column: 4
                                            delegate: Rectangle {
                                                color: (model.row % 2) ? "#FFFFFF": "#EBF2FD"
                                                width: control.columnWidthArr[column]
                                                height: control.rowHeight

                                                TextField {
                                                    anchors.fill: parent
                                                    verticalAlignment: Text.AlignVCenter
                                                    horizontalAlignment: Text.AlignHCenter
                                                    text: display
                                                    font.pointSize: 12
                                                    //color: (model.row % 2) ? "#FFFFFF": "#EBF2FD"
                                                    color: "#000000"
                                                    //elide: Text.ElideRight
                                                    // 当文本变化时更新模型数据
                                                    onEditingFinished: {
                                                        // 方法1：通过模型索引修改（推荐）
                                                        const rowIndex = model.row    // 获取当前行索引
                                                        const colIndex = column      // 当前列索引

                                                        resultData[rowIndex].uavmountLocationId = text
                                                        updateUavAllData()
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
                                            column:5
                                            delegate: Rectangle {
                                                color: (model.row % 2) ? "#FFFFFF": "#EBF2FD"
                                                width: control.columnWidthArr[column]
                                                height: control.rowHeight

                                                TextField {
                                                    anchors.fill: parent
                                                    verticalAlignment: Text.AlignVCenter
                                                    horizontalAlignment: Text.AlignHCenter
                                                    text: display
                                                    font.pointSize: 12
                                                    //color: (model.row % 2) ? "#FFFFFF": "#EBF2FD"
                                                    color: "#000000"
                                                    //elide: Text.ElideRight
                                                    // 当文本变化时更新模型数据
                                                    onEditingFinished: {
                                                        // 方法1：通过模型索引修改（推荐）
                                                        const rowIndex = model.row    // 获取当前行索引
                                                        const colIndex = column      // 当前列索引
                                                        // var regex = /^[0-9]*\.?[0-9]*$/;
                                                        // var lastValidText = 0.0
                                                        //         if (!regex.test(text)) {
                                                        //             // 如果输入不符合要求，恢复到上一次有效的值
                                                        //             text = lastValidText;
                                                        //         } else {
                                                        //             // 保存当前有效的值
                                                        //             lastValidText = text;
                                                        //         }
                                                        resultData[rowIndex].uavmountLocationCapacity = text
                                                        updateUavAllData()
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

                           }
                       }

                       RowLayout {
                           Layout.minimumWidth: addMountLocationroot.width
                           Layout.minimumHeight: addMountLocationroot.height-300
                           Layout.fillHeight: true
                           Layout.fillWidth: true
                           Button{
                               id:updateMountLocation
                               Layout.leftMargin:12
                               height: 50
                               width:80
                               font.pixelSize: fontpixelSize   // 设置字体大小为 20 像素
                               text:"更新"
                               onClicked: {
                                   updateMountLocationData()

                               }
                            }
                           Button{
                               id:deleteMountLocation
                               Layout.leftMargin: 20
                               height: 50
                               width:80
                               font.pixelSize: fontpixelSize   // 设置字体大小为 20 像素
                               text:"删除"
                               onClicked: {
                                   deleteMountLocationData()
                               }
                            }
                           Item { Layout.fillWidth: true }
                           Button {
                               id: payLoadTypeBack
                               Layout.rightMargin: 10
                               Layout.bottomMargin: 2
                               height: 50
                               width: 100
                               font.pixelSize: fontpixelSize   // 设置字体大小为 20 像素
                               // Layout.preferredWidth: 100
                               // Layout.preferredHeight: 50
                               text: "返回"
                               onClicked: {
                                   addMountLocationManagementPopup.close()// 或myPopup.visible = false
                                   uavManagementroot.enabled = true
                                   uavManagementroot.visible = true
                               }
                           }
                           Item { Layout.bottomMargin:2}
                        }

                   }


           // 定义关闭信号
           signal close()

           function dpH(h) {
               return h
           }
           //添加挂载位置
           function saveUavMountLoactionData(){
               var uavMountLoactionData = {
                   uavmountLocationId:0,
                   uavmountLocationName:"",
                   uavModelName:"",
                   uavmountLocationQuantity:0.0,
                   uavmountLocationCapacity:0.0
               }
               if(addMountLocationText.length != 0 && addMountLocationIdText.length != 0){
                   //将字符串转换为数字常用的方法有`parseInt()`、`parseFloat()`和`Number()`构造函数。
                   // 推荐方案：带错误处理的转换
                   // uavMountLoactionData.uavmountLocationId = {
                   //     let num = parseInt(addMountLocationIdText.text, 10);
                   //     return isNaN(num) ? 0 : num; // 如果转换失败则返回默认值0
                   // }()

                   // 或简写为：
                   uavMountLoactionData.uavmountLocationId = parseInt(addMountLocationIdText.text) || 0
                   uavMountLoactionData.uavmountLocationName = addMountLocationText.text
                   uavMountLoactionData.uavModelName  = ""
                    uavMountLoactionData.uavmountLocationQuantity= 0.0
                   uavMountLoactionData.uavmountLocationCapacity = 0.0
                   // 打印当前函数的名称
                    console.log("当前函数名称:", arguments.callee.name);
                   if(uavMountLoactionData.uavmountLocationName.length  === 0){
                       warningItem.text = "挂载位置数据不能为空!"
                       warningPopup.open()
                       // 2秒后自动关闭
                       autoCloseTimer.start()
                       return false
                   }else if(uavMountLoactionData.uavmountLocationName.length > 0){
                       let insertResult = uavMountLocationDaoTableModel.insertUavMountLocationDate(uavMountLoactionData)
                       console.log("addMountLocationText"+insertResult)
                       if(insertResult === true){
                           warningItem.text = "挂载位置数据添加成功!"
                           warningPopup.open()
                       }else{
                           warningItem.text = "挂载位置数据添加失败!"
                           warningPopup.open()
                       }
                   }else{
                       console.log(" unknown saveUavMountLoactionData")
                   }
               }else{
                   warningItem.text = "挂载位置与编号不能为空!"
                   warningPopup.open()
                   // 2秒后自动关闭
                   autoCloseTimer.start()
               }

           }
           function loadUavMountLocationAllData(){ //加载挂载位置数据
                var receiveData = uavMountLocationDaoTableModel.selectUavMountLocationAllData()
               console.log("loadUavAllData+:", JSON.stringify(receiveData, null, 2));
               // 打印当前函数的名称
                console.log("当前函数名称:", arguments.callee.name);
                //清空旧数据
               tableModel.clear()
               rowsModel.length = 0;
               resultData = receiveData
               tableModel.rows = receiveData;

               rowsModel = tableModel.rows;
               tableModel.layoutChanged()
           }
           function deleteMountLocationData(){
               var selectedRowsData = [];

               for (var i = 0; i < tableModel.rowCount; i++) {

                   //console.log("tableModel.rows[i].checked Rows JSON:", JSON.stringify(tableModel.rows[i]));
                   //console.log("tablemodel",JSON.stringify(tableModel.rows))
                   if (tableModel.rows[i].checked) {
                       var rowData = {
                           recordId: tableModel.rows[i].recordId,
                           uavmountLocationName: tableModel.rows[i].uavmountLocationName,
                           uavmountLocationId: tableModel.rows[i].uavmountLocationId
                       };
                       //console.log("tableModel.rows[i].uavType Rows JSON:", tableModel.rows[i].uavType);
                       selectedRowsData.push(rowData);
                   }
               }
               // 打印当前函数的名称
                console.log("当前函数名称:", arguments.callee.name);
               let result = uavMountLocationDaoTableModel.deleteUavMountLocationDate(selectedRowsData)
               loadUavMountLocationAllData()
               if(result === true){
                   warningItem.text = "挂载位置数据删除成功!"
                   warningPopup.open()
                   // 2秒后自动关闭
                   autoCloseTimer.start()
               }else if(result === false){
                   warningItem.text = "挂载位置数据删除失败!"
                   warningPopup.open()
                   // 2秒后自动关闭
                   autoCloseTimer.start()
                }else{
                   console.log("unknown deleteMountLocation")
               }

               // 将选中的行的数据转换为 JSONArray 格式
               var selectedRowsJson = JSON.stringify(selectedRowsData);
               console.log("Selected deleteMountLocationDataRows JSON:", selectedRowsJson);
               return selectedRowsData
           }
           function updateMountLocationData(){
               // 打印当前函数的名称
                console.log("当前函数名称:", arguments.callee.name);
                //console.log("resultData"+JSON.stringify(resultData))
               let result = uavMountLocationDaoTableModel.updateUavMountLocationDate(resultData)
               loadUavMountLocationAllData()
               if(result === true){
                   warningItem.text = "挂载位置数据更新成功!"
                   warningPopup.open()
                   // 2秒后自动关闭
                   autoCloseTimer.start()
               }else if(result === false){
                   warningItem.text = "挂载位置数据更新失败!"
                   warningPopup.open()
                   // 2秒后自动关闭
                   autoCloseTimer.start()
                }else{
                   console.log("unknown deleteMountLocation")
               }
           }

           function updateUavAllData(){ //更新挂载位置数据
               // var receiveData = uavModelDaoTable.selectUavModelAllData()
               //console.log("loadUavAllData+:", JSON.stringify(loadData, null, 2));
               // 打印当前函数的名称
                console.log("当前函数名称:", arguments.callee.name);
                //清空旧数据
               tableModel.clear()
               tableModel.rows = resultData;
               rowsModel = tableModel.rows;
               //tableModel.layoutChanged()
            }

           function getSelectedData() {
               // let selected = []
               // for (let i = 0; i < tableModel.rowCount; ++i) {
               //     const row = tableModel.getRow(i)
               //     if (row.checked) {
               //         selected.push({
               //           position: row.mountingPosition,
               //           number: row.positionNumber,
               //           count: row.mountCount,
               //           capacity: row.payloadCapacity
               //         })
               //         console.log("selectedDataTest")
               //     }
               // }
               // console.log("getSelectedData"+JSON.stringify(selected, null, 2))
               var selectedRowsData = [];
               for (var i = 0; i < tableModel.rowCount; i++) {

                   //console.log("tableModel.rows[i].checked Rows JSON:", JSON.stringify(tableModel.rows[i]));
                   //console.log("",JSON.stringify(tableModel.rows))
                   if (tableModel.rows[i].checked) {
                       var rowData = {
                           positionNumber: tableModel.rows[i].positionNumber,
                           mountingPosition: tableModel.rows[i].mountingPosition,
                           mountCount: tableModel.rows[i].mountCount,
                           payloadCapacity: tableModel.rows[i].payloadCapacity,

                       };
                       //console.log("tableModel.rows[i].uavType Rows JSON:", tableModel.rows[i].uavType);
                       selectedRowsData.push(rowData);
                   }
               }

               // 将选中的行的数据转换为 JSONArray 格式
               var selectedRowsJson = JSON.stringify(selectedRowsData);
               //console.log("Selected Rows JSON:", selectedRowsJson);
               return selectedRowsData
           }
           // 修正后的保存方法
           function saveClicked() {
               const selectedData = []
               for (let i = 0; i < tableModel.rowCount; ++i) {
                   const row = tableModel.getRow(i)
                   if (row.checked) {
                       selectedData.push({
                           position: row.mountingPosition,
                           number: row.positionNumber,
                           count: row.mountCount,
                           capacity: row.payloadCapacity
                       })
                   }
               }
               saveRequested(selectedData)  // 触发信号
           }
}
