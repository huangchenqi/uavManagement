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
           // 暴露接口给父组件
           // property alias tableModel: tableModel
           // signal saveRequested(var selectedData)
           property var loadData: []
           property var updateData: []
           property color borderColor: "#A5B3C0"
           property color headerColor: "#D3E1FE"
           property color fontColor: "#3E3E3E"
           property var rowsModel: []
           property string managementType: "";
           property string queryedit: ""
           width: 500;
           height: 60//width: screenWidth; height: screenHeight
           //property var rowData : ({test:1})
           property int bottonHeight: 50
           property int maxHeight: 200  // 下拉列表最大高度
           property int minHeight: 20  // 下拉列表最小高度
           // 组件加载完成后生成测试数据
           Component.onCompleted:{
               loadUavAllData()

           }
           // 数据模型
           // 表格数据模型
           TableModel {
              id: tableModel
              TableModelColumn { display: "checked" }//复选框
              TableModelColumn { display: "positionNumber"   }        // 位置编号
              TableModelColumn { display: "mountingPosition" }   // 挂载位置
              TableModelColumn { display: "mountCount" }    // 挂载数量
              TableModelColumn { display: "payloadCapacity" }      // 载弹量
            }

                   ColumnLayout {
                       //@disable-check M16
                       anchors.fill: parent
                       Layout.fillWidth: true
                       Layout.fillHeight: true
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
                               property variant columnWidthArr: [50,130, 130, 130,120]
                               // 显示10个字段
                               property var horHeader: ["","挂载位置", "位置编号", "挂载数量","载弹量"]
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
                                                         updateData[rowIndex].mountCount = text
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

                                                         updateData[rowIndex].payloadCapacity = text
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
                                   // 修正后的委托选择器
                                           // delegate: DelegateChooser {
                                           //     DelegateChoice {
                                           //         column: 0
                                           //         delegate: CheckBoxDelegate {}  // 提取为单独组件
                                           //     }

                                           //     DelegateChoice {
                                           //         column: 3
                                           //         delegate: TextFieldDelegate {
                                           //             fieldName: "mountCount"  // 指定绑定的字段
                                           //         }
                                           //     }

                                           //     DelegateChoice {
                                           //         column: 4
                                           //         delegate: TextFieldDelegate {
                                           //             fieldName: "payloadCapacity"
                                           //         }
                                           //     }

                                           //     DelegateChoice {
                                           //         delegate: DefaultTextDelegate {}
                                           //     }
                                           // }
                               }
                               // 单独封装的委托组件
                                   component CheckBoxDelegate: Rectangle {
                                       color: (model.row % 2) ? "#FFFFFF" : "#EBF2FD"
                                       width: control.columnWidthArr[column]
                                       height: control.rowHeight

                                       CheckBox {
                                           checked: model.checked  // 直接绑定模型数据
                                           anchors.centerIn: parent
                                           onClicked: {
                                               // 直接修改模型数据
                                               tableModel.setData(tableModel.index(model.row, 0), checked, Qt.CheckStateRole)
                                           }
                                       }

                                       // ...边框代码保持不变...
                                   }

                                   component TextFieldDelegate: Rectangle {
                                       required property string fieldName
                                       color: (model.row % 2) ? "#FFFFFF" : "#EBF2FD"
                                       width: control.columnWidthArr[column]
                                       height: control.rowHeight

                                       TextField {
                                           anchors.fill: parent
                                           text: model[fieldName]  // 绑定指定字段
                                           onTextChanged: {
                                               tableModel.setData(
                                                   tableModel.index(model.row, column),
                                                   text,
                                                   Qt.DisplayRole
                                               )
                                           }
                                       }

                                       // ...边框代码保持不变...
                                   }

                                   component DefaultTextDelegate: Rectangle {
                                       color: (model.row % 2) ? "#FFFFFF" : "#EBF2FD"
                                       width: control.columnWidthArr[column]
                                       height: control.rowHeight

                                       Text {
                                           text: model.display
                                           anchors.centerIn: parent
                                       }

                                       // ...边框代码保持不变...
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
                                                   font.pointSize: 8
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
                           Layout.minimumWidth: uavManagementroot.width
                           Layout.minimumHeight: uavManagementroot.height-280
                           Layout.fillHeight: true
                           Layout.fillWidth: true

                           Item { Layout.fillWidth: true }
                           Button {
                               id: payLoadTypeBack
                               Layout.rightMargin: 10
                               Layout.bottomMargin: 2
                               height: 50
                               width: 100
                               // Layout.preferredWidth: 100
                               // Layout.preferredHeight: 50
                               text: "返回"
                               onClicked: {
                                   payloadTypeManagementPopup.close()// 或myPopup.visible = false
                                   uavManagementroot.enabled = true
                                   uavManagementroot.visible = true
                               }
                           }
                           Item { Layout.bottomMargin:2}
                        }

                   }

           // Component {
           //     id: rowDelegate
           //     Rectangle {
           //         visible: styleData.row === undefined ? false : true
           //         //color: styleData.alternate ? "#F9F9F9":"#EAEAEA"
           //         color: "#F9F9F9"
           //         height: 60
           //         Rectangle { // 底部边框
           //             anchors.right: parent.right
           //             anchors.left: parent.left
           //             anchors.bottom: parent.bottom
           //             height: 1
           //             color: "gray"
           //         }
           //     }
           // }

           // Component {
           //     id: itemDelegate
           //     Text {
           //         text: styleData.value+""
           //         font.pointSize: 12
           //         font.bold: false
           //         color: "black"
           //         //color: styleData.textColor
           //         horizontalAlignment: Text.AlignHCenter
           //         verticalAlignment: Text.AlignVCenter
           //         elide: styleData.elideMode
           //     }
           // }

           // Component {
           //     id: headerDelegate
           //     Rectangle {
           //         height: 60
           //         implicitHeight: 60
           //         border.width: 1
           //         color: "#0089CF"
           //         border.color: "#FFFFFF"
           //         Text {
           //             id: headerName
           //             text: styleData.value
           //             font.pointSize: 12
           //             font.bold: false
           //             horizontalAlignment: Text.AlignHCenter
           //             verticalAlignment: Text.AlignVCenter
           //             anchors.fill: parent
           //             color: "#FFFFFF"
           //         }
           //     }
           // }
           // 定义关闭信号
           signal close()

           function dpH(h) {
               return h
           }
           // 在 MultiTextDispay 组件中添加以下函数
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
           function loadUavAllData(){
               // var receiveData = uavModelDaoTable.selectUavModelAllData()
               //console.log("loadUavAllData+:", JSON.stringify(loadData, null, 2));
                //清空旧数据
               tableModel.clear()
               rowsModel.length = 0;
               updateData = loadData
               tableModel.rows = loadData;

               rowsModel = tableModel.rows;
               tableModel.layoutChanged()
           }
           function updateUavAllData(){
               // var receiveData = uavModelDaoTable.selectUavModelAllData()
               //console.log("loadUavAllData+:", JSON.stringify(loadData, null, 2));
                //清空旧数据
               tableModel.clear()
               tableModel.rows = updateData;
               rowsModel = tableModel.rows;
               //tableModel.layoutChanged()
            }
}
