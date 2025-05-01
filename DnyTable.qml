import QtQuick 2.10
import QtQuick.Controls 2.10
import QtQuick.Layouts 1.10

Item {
    id: root

    // 公开的属性
    property var columnDefinitions: []  // 列定义数组，每个元素应包含 title, width, delegate 等属性
    property var tableData: []  // 数据源
    property int rowHeight: 40  // 默认行高
    property int headerHeight: 40  // 表头高度
    property color headerBackgroundColor: "#f0f0f0"  // 表头背景色
    property color rowBackgroundColor: "white"  // 行背景色
    property color alternateRowBackgroundColor: "#f9f9f9"  // 交替行背景色
    property color gridColor: "#e0e0e0"  // 网格线颜色
    property bool showGrid: true  // 是否显示网格线
    property int rowSpacing: 0    // 行间距，设为0消除间隙

    // 内部属性
    property int contentWidth: 0  // 内容总宽度
    property var rowHeights: []  // 存储每行的自定义高度
    property var columnWidths: []  // 存储每列的实际宽度
    property int availableWidth: width  // 可用宽度

    property color hoverBackgroundColor: "#e8f0fe"  // 鼠标悬停时的背景色
    property int hoveredRow: -1  // 当前悬停的行索引

    signal select(int index)
    signal cellClicked(int rowIndex, int columnIndex, var cellData)

    Component.onCompleted: {
        console.log("DnyTable初始化");
        resetRowHeights();
        calculateColumnWidths();
    }

    // 调试函数 - 打印表格数据信息
    function logTableInfo() {
        console.log("表格信息: 列数=" + columnDefinitions.length + ", 行数=" + tableData.length);
        console.log("列宽: " + JSON.stringify(columnWidths));
        console.log("表格宽度: " + contentWidth);
        console.log("表格高度: " + calculateContentHeight());
    }

    // 计算列宽
    function calculateColumnWidths() {
        var fixedWidthTotal = 0;
        var flexibleColumns = [];
        var widths = [];

        for (var i = 0; i < columnDefinitions.length; i++) {
            var col = columnDefinitions[i];
            if (col.width) {
                widths[i] = col.width;
                fixedWidthTotal += col.width;
            } else {
                widths[i] = 100; // 默认宽度
                flexibleColumns.push(i);
            }
        }

        var remainingWidth = availableWidth - fixedWidthTotal;
        if (remainingWidth > 0 && flexibleColumns.length > 0) {
            var extraWidthPerColumn = remainingWidth / flexibleColumns.length;
            for (var j = 0; j < flexibleColumns.length; j++) {
                widths[flexibleColumns[j]] += extraWidthPerColumn;
            }
        }
        else if (fixedWidthTotal < availableWidth && columnDefinitions.length > 0) {
            var expandRatio = availableWidth / fixedWidthTotal;
            for (var k = 0; k < widths.length; k++) {
                widths[k] = widths[k] * expandRatio;
            }
        }

        columnWidths = widths;

        // 计算内容总宽度
        contentWidth = 0;
        for (var m = 0; m < columnWidths.length; m++) {
            contentWidth += columnWidths[m];
        }
        
        console.log("计算列宽完成，总宽度: " + contentWidth);
    }

    // 重置行高存储
    function resetRowHeights() {
        rowHeights = [];
        for (var i = 0; i < tableData.length; i++) {
            rowHeights.push(rowHeight);
        }
    }

    // 当列定义或宽度改变时，重新计算列宽
    onColumnDefinitionsChanged: {
        console.log("列定义已更改，重新计算列宽");
        calculateColumnWidths();
    }

    onWidthChanged: {
        console.log("容器宽度已更改: " + width);
        availableWidth = width;
        calculateColumnWidths();
    }

    // 当数据源改变时，重置行高存储
    onTableDataChanged: {
        console.log("表格数据已更改，行数: " + tableData.length);
        resetRowHeights();
    }

    // 计算内容总高度
    function calculateContentHeight() {
        var height = 0;
        for (var i = 0; i < rowHeights.length; i++) {
            height += rowHeights[i] || rowHeight;
        }
        // 确保至少有一个最小高度，防止空表格时无法滚动
        return Math.max(height, 10);
    }

    // 计算特定行的Y位置
    function calculateRowY(rowIndex) {
        var y = 0;
        for (var i = 0; i < rowIndex; i++) {
            y += rowHeights[i] || rowHeight;
        }
        return y;
    }

    // 表格容器
    Rectangle {
        id: tableContainer
        anchors.fill: parent
        color: "transparent"
        clip: true

        // 表头
        Rectangle {
            id: header
            width: parent.width
            height: headerHeight
            color: headerBackgroundColor
            z: 2

            // 表头行
            Row {
                id: headerRow
                height: parent.height
                spacing: 0

                // 动态创建表头项
                Repeater {
                    model: columnDefinitions

                    Item {
                        width: columnWidths[index] || 100
                        height: headerHeight

                        // 表头内容
                        Rectangle {
                            anchors.fill: parent
                            color: "transparent"
                            border.width: showGrid ? 1 : 0
                            border.color: gridColor

                            // 表头标题
                            Text {
                                anchors.centerIn: parent
                                text: modelData.title || ""
                                font.bold: true
                                elide: Text.ElideRight
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                                width: parent.width - 10
                            }
                        }

                        // 右侧分隔线
                        Rectangle {
                            visible: index < columnDefinitions.length - 1
                            anchors.right: parent.right
                            anchors.top: parent.top
                            anchors.bottom: parent.bottom
                            width: 1
                            color: "#999999"
                            z: 2
                        }
                    }
                }
            }
        }

        // 使用ScrollView实现滚动
        ScrollView {
            id: scrollView
            anchors.top: header.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            clip: true
            
            // 滚动条策略
            ScrollBar.vertical.policy: ScrollBar.AsNeeded
            ScrollBar.horizontal.policy: ScrollBar.AsNeeded

            // 内容区域
            Column {
                id: tableBodyColumn
                width: Math.max(scrollView.width, contentWidth)
                
                // 行容器 - 使用Repeater动态创建行
                Repeater {
                    id: rowRepeater
                    model: tableData

                    // 行背景和内容
                    Rectangle {
                        id: rowContainer
                        width: contentWidth
                        height: rowHeights[index] || rowHeight
                        color: {
                            if (hoveredRow === index) {
                                return hoverBackgroundColor;
                            }
                            return index % 2 === 0 ? rowBackgroundColor : alternateRowBackgroundColor;
                        }
                        
                        property var rowData: (tableData && index >= 0 && index < tableData.length) ? tableData[index] : {}
                        property int rowIndex: index

                        // 行内容
                        Row {
                            height: parent.height
                            spacing: 0

                            // 单元格
                            Repeater {
                                model: columnDefinitions

                                // 单元格容器
                                Rectangle {
                                    width: columnWidths[index] || 100
                                    height: parent.height
                                    color: "transparent"
                                    border.width: showGrid ? 1 : 0
                                    border.color: gridColor

                                    // 单元格点击区域
                                    MouseArea {
                                        anchors.fill: parent
                                        propagateComposedEvents: true
                                        hoverEnabled: true
                                        z: 1

                                        onClicked: {
                                            console.log("[DnyTable] 单元格点击: 行=" + rowContainer.rowIndex + ", 列=" + index);
                                            root.cellClicked(rowContainer.rowIndex, index, cellLoader.cellData);
                                            mouse.accepted = false;
                                        }

                                        onPressed: {
                                            mouse.accepted = false;
                                        }

                                        onReleased: {
                                            mouse.accepted = false;
                                        }
                                    }

                                    // 单元格内容加载器
                                    Loader {
                                        id: cellLoader
                                        anchors.centerIn: parent
                                        width: parent.width - 4
                                        height: parent.height - 4
                                        z: 2

                                        // 使用自定义代理或默认文本代理
                                        sourceComponent: {
                                            if (modelData && modelData.delegate) {
                                                return modelData.delegate;
                                            } else {
                                                return defaultDelegate;
                                            }
                                        }

                                        // 传递数据给代理
                                        property var cellData: {
                                            if (rowData && modelData.field) {
                                                return rowData[modelData.field] || "";
                                            }
                                            return "";
                                        }
                                        property int columnIndex: index
                                        property int rowIndex: rowContainer.rowIndex
                                    }
                                }
                            }
                        }

                        // 行鼠标处理
                        MouseArea {
                            anchors.fill: parent
                            hoverEnabled: true
                            propagateComposedEvents: true
                            z: 0

                            onEntered: {
                                hoveredRow = index;
                            }

                            onExited: {
                                hoveredRow = -1;
                            }

                            onClicked: {
                                console.log("[DnyTable] 行点击: 行=" + index);
                                select(index);
                                mouse.accepted = false;
                            }
                        }
                    }
                }
            }
        }
    }

    // 默认单元格代理
    Component {
        id: defaultDelegate

        Text {
            text: cellData || ""
            anchors.fill: parent
            anchors.leftMargin: 5
            elide: Text.ElideRight
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
        }
    }
}

