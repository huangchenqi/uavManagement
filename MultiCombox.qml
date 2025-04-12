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
    width: 200  // 设置默认宽度

    // Signal to notify parent component about selection changes
    signal selectionChanged(var selectedItems)

    // 边框样式
    border.width: 1
    border.color: "#CCCCCC"
    radius: 4

    // 显示选中项的文本
    Text {
        id: displayText
        anchors.left: parent.left
        anchors.right: dropdownIcon.left
        anchors.verticalCenter: parent.verticalCenter
        leftPadding: 10
        text: root.selectedItems.length > 0
            ? root.selectedItems.map(item => item.label || item).join(", ")
            : "请选择"
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

        contentItem: ListView {
            id: itemsListView
            implicitHeight: contentHeight
            model: root.items
            clip: true

            delegate: CheckDelegate {
                width: parent.width
                height: 40
                text: modelData.label || modelData
                checked: root.selectedItems.includes(modelData) // 直接检查字符串是否在数组中
                //     root.selectedItems.some(
                //     selectedItem =>
                //     (selectedItem.id || selectedItem) ===
                //     (modelData.id || modelData)
                // )

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
