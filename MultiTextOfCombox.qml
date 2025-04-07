import QtQuick 2.10
import QtQuick.Controls 2.10
import QtQuick.Layouts 1.10

Rectangle {
    id: root

    // Public properties
    property var items: []  // 传入的数据项数组
    property var selectedItems: []  // 当前选中的项目
    property int maxHeight: 200  // 下拉列表最大高度
    height: 40  // 设置默认高度
    width: 500  // 设置默认宽度

    // Signal to notify parent component about selection changes
    signal selectionChanged(var selectedItems)
    property variant columnWidthArr: [100, 100, 90]
    // 显示10个字段
    property var horHeader: ["挂载数量", "载弹量", "挂载位置"]
    // 边框样式
    border.width: 1
    border.color: "#CCCCCC"
    radius: 4

    //显示选中项的文本
    Text {
        id: displayText
        anchors.left: parent.left
        anchors.right: dropdownIcon.left
        anchors.verticalCenter: parent.verticalCenter
        leftPadding: 10
        text: {
                   if (root.selectedItems.length === 0) return "请选择"

                   // 统计各无人机型号及其挂载数量
                   var result = []
                   root.selectedItems.forEach(item => {
                       var count = item.mountCount || 1
                       result.push(item.label + (count > 1 ? `×${count}` : ""))
                   })
                   return result.join(", ")
               }
               elide: Text.ElideRight
               verticalAlignment: Text.AlignVCenter
    }

    // 下拉箭头
    Text {
        id: dropdownIcon
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        rightPadding: 10
        text: "▼"
        font.pixelSize: 12
    }

    // 点击区域
    MouseArea {
        anchors.fill: parent
        onClicked: dropdown.visible = !dropdown.visible
    }

    // 下拉框
    Popup {
        id: dropdown
        width: root.width
        y: root.height + 2
        height: Math.min(contentHeight, root.maxHeight)

        // 表头行

       //Item { Layout.toptMargin: 20 }
        contentItem: ListView {
            id: itemsListView
            implicitHeight: contentHeight
            model: root.items
            clip: true
            ColumnLayout{

            }

            Rectangle {
                id: headerRow
                width: parent.width
                height: 30
                color: "#f0f0f0"

                Row {
                    width: parent.width
                    height: parent.height
                    spacing: 1

                    Repeater {
                        model: root.horHeader.length

                        Rectangle {
                            width: root.columnWidthArr[index]
                            height: parent.height
                            color: "transparent"

                            Text {
                                anchors.centerIn: parent
                                text: root.horHeader[index]
                                font.bold: true
                            }
                        }
                    }
                }
            }

            delegate: Item {
                width: parent.width
                height: 40

                // 水平布局，包含 TextField 和 CheckDelegate
                Row {
                    width: parent.width
                    height: parent.height
                    spacing: 10

                    // 添加的 TextField
                    TextField {
                        id:uavHangingpoints
                        width: parent.width * 0.2  // 占据30%宽度
                        height: parent.height
                        text: modelData.textValue || ""  // 关联模型中的textValue字段
                        placeholderText: "输入值"

                        // 当文本变化时更新模型
                        onTextChanged: {
                            if (modelData.textValue !== undefined) {
                                modelData.textValue = text
                            }
                            // 如果模型是普通数组，需要通过模型索引更新
                            root.items.setProperty(index, "textValue", text)
                        }
                    }

                    TextField {
                        id:uavPayloadcapacity
                        width: parent.width * 0.2  // 占据30%宽度
                        height: parent.height
                        text: modelData.textValue || ""  // 关联模型中的textValue字段
                        placeholderText: "输入值"

                        // 当文本变化时更新模型
                        onTextChanged: {
                            if (modelData.textValue !== undefined) {
                                modelData.textValue = text
                            }
                            // 如果模型是普通数组，需要通过模型索引更新
                            root.items.setProperty(index, "textValue", text)
                        }
                    }

                    // 原有的 CheckDelegate
                    CheckDelegate {
                        width: parent.width * 0.4 - parent.spacing  // 剩余宽度减去间距
                        height: parent.height
                        text: modelData.label || modelData
                        checked: root.selectedItems.some(
                            selectedItem =>
                            (selectedItem.id || selectedItem) ===
                            (modelData.id || modelData)
                        )

                        onCheckedChanged: {
                            var currentItem = modelData
                            var updatedSelectedItems = [...root.selectedItems]

                            if (checked) {
                                if (!updatedSelectedItems.some(
                                    selectedItem =>
                                    (selectedItem.id || selectedItem) ===
                                    (currentItem.id || currentItem)
                                )) {
                                    updatedSelectedItems.push(currentItem)
                                }
                            } else {
                                updatedSelectedItems = updatedSelectedItems.filter(
                                    selectedItem =>
                                    (selectedItem.id || selectedItem) !==
                                    (currentItem.id || currentItem)
                                )
                            }

                            root.selectedItems = updatedSelectedItems
                            root.selectionChanged(root.selectedItems)
                        }
                    }
                }
            }
        }

    }
}
