import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import Macai.App 1.0
import QtQuick.Layouts 1.14
import "."//import "qrc:/"
Window {
    id: uavShowData
    visible: true
    width: 1200
    height: 600
    title: qsTr("QML TableView example")
    property string managementType: "";
    // 在根元素中定义（如 Window/Item）
    Loader {
        id: pageLoader  // 必须的标识符
        anchors.fill: parent  // 填充父容器
        visible: true    // 确保可见
    }

    Item {
        id:uavManage
        width: 1200
        height: 600


    onWidthChanged: {
        tableView.forceLayout()
    }
    ColumnLayout{

        anchors.fill: parent
        // Layout.fillWidth: true
        // Layout.fillHeight: true
        spacing: 10
        Rectangle {
            id: showUavManagementData
            // anchors.top: parent.top
            // anchors.left: parent.left
            // width: parent.width   // 修正1：需要明确指定父级宽度属性
            //height: 500
            Layout.fillWidth: true
            Layout.fillHeight: true
            //visible: false
            color: "gray"
            TableView {
                    id: tableView
                    anchors.fill: parent
                    columnSpacing: 0
                    rowSpacing: 0
                    clip: true

                    contentHeight: rowHeightProvider(0) * rows + rowHeightProvider(rows-1)
                    leftMargin: vericalHeader.implicitWidth
                    topMargin: horizontalHeader.implicitHeight
                    rowHeightProvider: function (row) { return 32; }
                    columnWidthProvider: function (column) {
                        return Math.max(1, (tableView.width - leftMargin) / tableView.columns)
                    }

                    ScrollIndicator.horizontal: ScrollIndicator {}
                    ScrollIndicator.vertical: ScrollIndicator { active: true }

                    model: SqlTableModel {
                        id: tableModel
                        database: "data.db"
                        table: "books"
                    }

                    delegate: Rectangle {
                        id: cellItem

                        implicitWidth: content.implicitHeight
                        implicitHeight: 30

                        Rectangle { anchors.left: parent.left; height: parent.height; width: 1; color: "#dddddd"}
                        Rectangle { anchors.top: parent.top; width: parent.width; height: 1; color: "#dddddd"}
                        Rectangle { anchors.right: parent.right; height: parent.height; width: 1; color: "#dddddd"; visible: model.column === tableView.columns -1 }
                        Rectangle { anchors.bottom: parent.bottom; width: parent.width; height: 1; color: "#dddddd"; visible: model.row === tableView.rows - 1 }

                        TextEdit {
                            id: content
                            anchors.fill: parent
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignLeft
                            padding: 4
                            clip: true
                            text: tableModel.data(tableModel.index(row, column))
                            selectByMouse: true
                            onEditingFinished: {
                                tableModel.setData(tableModel.index(row, column), content.text)
                            }
                        }

            //            MouseArea{
            //                anchors.fill: parent
            //                hoverEnabled: true
            //                onEntered: cellItem.color = "lightsteelblue"
            //                onExited: cellItem.color = "#ffffff"
            //                onClicked: {
            //                    console.log("(", row, ",", column ,")", "[", cellItem.x, ",",cellItem.y, "]")
            //                    console.log(tableModel.rowCount(), tableModel.columnCount())
            //                }
            //            }
                    }

                    Button {
                        z: 3
                        y: tableView.contentY
                        x: tableView.contentX
                        text: "#"
                        width: tableView.leftMargin
                        height: tableView.topMargin
                    }

                    Row {
                        id: horizontalHeader
                        y: tableView.contentY
                        z: 2
                        Repeater {
                            model: tableView.columns > 0 ? tableView.columns : 1

                            Button {
                                width: tableView.columnWidthProvider(index)
                                height: tableView.rowHeightProvider(index)
                                text: tableModel.headerData(index, Qt.Horizontal)
                            }
                        }
                    }

                    Column {
                        id: vericalHeader
                        x: tableView.contentX
                        z: 2
                        Repeater {
                            model: tableView.rows > 0 ? tableView.rows : 1
                            Button {
                                width: 30
                                height: tableView.rowHeightProvider(index)
                                text: tableModel.headerData(index, Qt.Vertical)
                            }
                        }
                        Button {
                            width: 30
                            height: tableView.rowHeightProvider(0)
                            text: "+"
                            onClicked: {
                                tableModel.add()
                            }
                        }
                    }
                }

                Component {
                    id: highlightComponent
                    Rectangle {
                        id: highlightRect
                        width: 200; height: 50
                        color: "#FFFF88"
                        Behavior on y { SpringAnimation { spring: 2; damping: 0.1 } }
                    }
                }
            }
        RowLayout {
                Layout.fillWidth: true
                Layout.preferredHeight: 60  // 底部栏高度
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                //margins: 20
                spacing: 10
                // 占位符（将按钮推到右侧）
                Item { Layout.fillWidth: true }

                Button{
                    id:addUavManagement
                    /*anchors.bottom: parent.bottom这是QML中用于定位的锚点属性。锚点系统允许元素相对于父元素或其他元素进行定位。
                    这里将元素的底部锚定到父元素的底部，意味着该元素会紧贴在父容器的底部。但需要注意，单独使用这个属性可能不会产生预期效果，
                    通常需要结合其他锚点属性，比如设置左右或水平居中来确定水平位置，否则元素可能会默认靠左对齐，宽度也可能需要明确指定。*/
                    anchors.right: parent.right //锚点属性与锚点边距一起用。
                    anchors.rightMargin: 50
                    //anchors.bottomMargin: 10
                    /* Layout.preferredWidth: 232
                    Layout.preferredHeight: 30
                    这两个属性属于Qt Quick Layouts模块，用于在布局管理器中设置元素的推荐宽度和高度。
                    当使用如RowLayout、ColumnLayout或GridLayout等布局容器时，Layout附加属性可以控制元素在布局中的大小和位置。
                    `preferredWidth`和`preferredHeight`表示元素在布局中的首选尺寸，但实际尺寸可能会根据布局的约束和可用空间进行调整。
                    如果可用空间不足，布局可能会压缩元素；如果空间足够，则优先使用推荐尺寸。*/
                    /*Layout.alignment: Qt.AlignBottom 这个属性用于在布局容器中设置元素的对齐方式。
                    在这里，设置为底部对齐，意味着如果布局中有额外的垂直空间，元素会紧贴布局的底部。但需要结合具体的布局容器来看，
                    例如在RowLayout中，垂直方向的对齐可能影响元素在行内的位置，而在ColumnLayout中则影响列内的位置。
                    此外，如果在布局容器中同时设置了填充属性（如`Layout.fillHeight: true`），
                    对齐属性可能会被覆盖，因为填充属性会拉伸元素以占据可用空间。*/

                    /*Layout.minimumWidth: 150设置元素在布局中的最小允许宽度。
                    Layout.maximumWidth: 300设置元素在布局中的最大允许宽度。
                    `Layout.minimumWidth`应该是指元素在布局中所允许的最小宽度，而`Layout.maximumWidth`则是最大宽度。
                    这样，布局管理器在分配空间时，会确保元素的宽度在这个范围内，无论父容器的尺寸如何变化。*/
                    width: 232;
                    height: 46
                    text: "新增型号"
                    onClicked: {
                         pageLoader.setSource("qrc:./UavManagement.qml")
                    }
                }

                Button{
                    id:delUavManagement
                    // anchors.bottom: parent.bottom
                    anchors.right: parent.right
                    anchors.rightMargin: 200
                    //anchors.bottomMargin: 10
                    // Layout.preferredWidth: 232
                    // Layout.preferredHeight: 30
                    width: 232;
                    height: 46
                    text: "删除型号"
                }


                Button{
                    id:payloadTypeManagement
                    // anchors.bottom: parent.bottom
                    anchors.right: parent.right
                    anchors.rightMargin: 400
                    //anchors.bottomMargin: 10
                    // Layout.preferredWidth: 232
                    // Layout.preferredHeight: 30
                    width: 232;
                    height: 46
                    text: "载荷类型管理"
                    onClicked: {
                       //pageLoader.setSource("qrc:./PayLoadTypeManagement.qml")
                        uavShowData.managementType = "loadType"
                        payloadTypeManagementPopup.open()// myPopup.visible = true
                        uavManage.enabled = false
                        uavManage.visible = false
                    }
                }
                Popup {
                    id: payloadTypeManagementPopup
                    width: 600  // 需明确设置宽度，否则可能无法显示完整内容
                    height: 400
                    anchors.centerIn: Overlay.overlay // 居中显示
                    closePolicy: Popup.NoAutoClose    // 完全禁用自动关闭
                    // 直接引用 admin.qml
                      GetTypeManagement{  // 假设 admin.qml 的根元素是 Admin 类型
                            id: adminPanel
                            anchors.fill: parent
                            managementType:uavShowData.managementType

                            onClose: adminPopup.close() // 连接关闭信号
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
                Button{
                    id:uavBombingmethodManagement
                    // anchors.bottom: parent.bottom
                    anchors.right: parent.right
                    anchors.rightMargin: 600
                    //anchors.bottomMargin: 10
                    // Layout.preferredWidth: 232
                    // Layout.preferredHeight: 30
                    width: 232;
                    height: 46
                    text: "投弹方式管理"
                    onClicked: {
                       //pageLoader.setSource("qrc:./PayLoadTypeManagement.qml")
                        uavShowData.managementType = "bombingMethod"
                        payloadTypeManagementPopup.open()// myPopup.visible = true
                        uavManage.enabled = false
                        uavManage.visible = false
                    }
                }
                Button{
                    id:uavRecoverymodeManagement
                    // anchors.bottom: parent.bottom
                    anchors.right: parent.right
                    anchors.rightMargin: 800
                    //anchors.bottomMargin: 10
                    // Layout.preferredWidth: 232
                    // Layout.preferredHeight: 30
                    width: 232;
                    height: 46
                    text: "回收方式管理"
                    onClicked: {
                       //pageLoader.setSource("qrc:./PayLoadTypeManagement.qml")
                        uavShowData.managementType = "recoveryMode"
                        payloadTypeManagementPopup.open()// myPopup.visible = true
                        uavManage.enabled = false
                        uavManage.visible = false
                    }
                }
                Button{
                    id:uavHangingLoctionManagement
                    // anchors.bottom: parent.bottom
                    anchors.right: parent.right
                    anchors.rightMargin: 1000
                    //anchors.bottomMargin: 10
                    // Layout.preferredWidth: 232
                    // Layout.preferredHeight: 30
                    width: 232;
                    height: 46
                    text: "挂载位置管理"
                    onClicked: {
                       //pageLoader.setSource("qrc:./PayLoadTypeManagement.qml")
                        uavShowData.managementType = "uavHanging"
                        payloadTypeManagementPopup.open()// myPopup.visible = true
                        uavManage.enabled = false
                        uavManage.visible = false
                    }
                }


                Item { Layout.fillWidth: true }
        }
    }

   }
}
