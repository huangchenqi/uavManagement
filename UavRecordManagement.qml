import QtQuick 2.10
import QtQuick.Controls 2.10
import QtQuick.Layouts 1.10
import "qrc:/" //引入所有的qml文件使用
import "qrc:/AddAmmoModules/"
import "qrc:/AddAmmoModules/Component"
import AmmoDaoModel 1.0
import InterferencePodDaoModel 1.0
Item {
    id: root

    property var header: [{
        "title": "",
        "width": 50,
        "field": "recordId",
        "delegate": chechBox
        },{
        "title": "序号",
        "width": 80,
        "field": "index"
    }, {
        "title": "干扰吊舱名称",
        "width": 150,
        "field": "interferencePodName"
    }, {
        "title": "长度",
        "width": 60,
        "field": "length"
    }, {
        "title": "质量",
        "width": 60,
        "field": "mass"
    }, {
        "title": "前舱长",
        "width": 150,
        "field": "frontCoverLength"
    },
    {
        "title": "后舱长",
        "width": 150,
        "field": "rearCoverLength"
    },
    {
        "title": "主舱",
        "width": 150,
        "field": "mainCabinSectione"
    },
    {
        "title": "用途",
        "width": 150,
        "field": "description"
    },
    {
        "title": "操作",
        "width": 200,
        "field": "id",
        "delegate": query,
    }]
    property var tableData: [

    ]
    // 搜索过滤相关
    property var query_condition: {
        "tag_ids": [],
        "data_type": "",
        "keyword": "",
        "task_id": "",
        "start_time": "",
        "end_time": "",
        "page": 1,
        "page_size": 30
    }
    // 分页相关属性
    property int totalRecords: 0
    property int totalPages: Math.max(1, Math.ceil(totalRecords / query_condition.page_size))
    // 添加标签数据属性
    property var tags: []
    property var payloadData: new Object //创建对象来实现数据的查询
    // 添加额外信号以触发UI更新
    signal pageChanged(int page)

    // 引用Toast组件
    property var activeToasts: []
    InterferencePodDaoTableModel {
        id: interferencePodDaoTableModel
    }
    Loader {
        id: pagePayloadLoader // 必须的标识符

        anchors.fill: parent // 填充父容器
        visible: true // 确保可见

        // 监听信号并切换界面
        Connections {
            target: pagePayloadLoader.item
            onBackPayloadRecord: {
                console.log("connectuion!!!!!");
                payloadRecordView.visible = true;
            }
        }

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
            id: warningItem

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
    // 添加组件初始化
    Component.onCompleted: {
        loadPayloadData()
        loadPayloadRecord(payloadData)
        // try {
        //     logDebug("组件初始化开始");
        //     // 获取标签数据
        //     if ($backend) {
        //         var tagsData = $backend.query_tags(Functions.createTagQueryCondition());
        //         // logDebug("获取到标签数据，原始响应: " + tagsData);
        //         if (tagsData) {
        //             try {
        //                 tags = JSON.parse(tagsData);
        //                 logDebug("解析标签数据成功，共 " + tags.length + " 个标签");
        //             } catch (except) {
        //                 console.error("解析标签数据失败: ", except);
        //                 tags = [];
        //             }
        //         }
        //         // 初始查询数据
        //         refreshTableData();
        //     } else {
        //         console.warn("$backend 未定义，无法获取数据");
        //     }
        //     logDebug("组件初始化完成");
        // } catch (e) {
        //     console.error("组件初始化错误: ", e);
        // }
    }

    Component {
        id:chechBox
        Item {
            id: chechBoxId
            anchors.fill: parent
            //自定义多选框组件
            CheckBox {

                checked: false
                anchors.centerIn: parent
                onClicked: {
                    console.log(cellData)
                }
            }
        }
    }
    Component {
        id:query
        Item {
            id: queryupdateData
            anchors.fill: parent
            //自定义多选框组件
            RowLayout{
                spacing: 2
                Button {
                    id:queryButton
                    anchors.centerIn: parent.left
                    height: 20
                    text: "查看"
                    onClicked: {
                        console.log(cellData)
                        processInfo.loadViewType = "query";
                        //console.log("processInfo JSONDATA"+JSON.stringify(processInfo))
                        pagePayloadLoader.setSource("qrc:./AddInterferencePodData.qml", {
                            "processInfo": processInfo,
                            "backUi": "qrc:/UavReconnaissancePayloadManagement.qml"
                        });
                        root.visible = false;
                    }
                }
                Button {
                    id:updateButton
                    anchors.centerIn: parent.right
                    height: 20
                    text: "编辑"
                    onClicked: {
                        console.log(cellData)
                        processInfo.loadViewType = "update";
                        //console.log("processInfo JSONDATA"+JSON.stringify(processInfo))
                        pagePayloadLoader.setSource("qrc:./AddInterferencePodData.qml", {
                            "processInfo": processInfo,
                            "backUi": "qrc:/UavReconnaissancePayloadManagement.qml"
                        });
                        root.visible = false;
                    }
                }
            }
        }
    }

    // 定时器确保对话框显示逻辑正确
    Timer {
        id: showDialogTimer

        interval: 100 // 增加到100毫秒延迟，给更多时间让属性生效
        repeat: false
        onTriggered: {
            try {
                logDebug("显示导入对话框计时器触发");
                importFlyDataDialog.visible = true;
                tableContainer.enabled = false;
                overlay.visible = true;
                logDebug("导入对话框显示设置完成");
            } catch (e) {
                console.error("显示导入对话框时出错: ", e);
            }
        }
    }



    // 添加带动画的按钮组件
    Component {
        id: buttonWithAnimationComponent

        Rectangle {
            id: buttonRect

            property bool showAnimation: false
            property string buttonText: "按钮"
            property string buttonColor: "#21f344"
            property bool enabled: true

            signal clicked()

            width: 60
            height: 30
            radius: 4
            color: enabled ? (mouseArea.containsMouse ? Qt.lighter(buttonColor, 1.1) : buttonColor) : Qt.darker(buttonColor, 1.3)

            Text {
                id: buttonLabel
                anchors.centerIn: parent
                text: buttonRect.buttonText
                color: "#FFFFFF"
                font.pixelSize: 12
                visible: !buttonRect.showAnimation
            }

            Item {
                id: animationContainer
                anchors.fill: parent
                visible: buttonRect.showAnimation

                Rectangle {
                    id: spinner
                    width: 16
                    height: 16
                    radius: 8
                    color: "transparent"
                    border.width: 2
                    border.color: "#FFFFFF"
                    anchors.centerIn: parent

                    Rectangle {
                        width: 4
                        height: 4
                        radius: 2
                        color: "#FFFFFF"
                        anchors {
                            top: parent.top
                            horizontalCenter: parent.horizontalCenter
                            topMargin: 2
                        }
                    }

                    RotationAnimation {
                        target: spinner
                        running: buttonRect.showAnimation
                        from: 0
                        to: 360
                        duration: 1000
                        loops: Animation.Infinite
                    }
                }
            }

            MouseArea {
                id: mouseArea
                anchors.fill: parent
                hoverEnabled: true
                enabled: buttonRect.enabled
                onClicked: {
                    if (buttonRect.enabled && !buttonRect.showAnimation) {
                        buttonRect.clicked();
                    }
                }
            }
        }
    }



    Rectangle {
        id: tableContainer

        anchors.fill: parent
        enabled: true

        // 添加遮罩层
        Rectangle {
            id: overlay

            anchors.fill: parent
            color: "black"
            opacity: 0.5
            visible: false
            z: 50 // 确保遮罩层在表格容器之上但在对话框之下

            // 点击遮罩层不做任何操作，防止点击穿透
            MouseArea {
                // 不执行任何操作，仅拦截点击事件

                anchors.fill: parent
                onClicked: {
                    console.log("遮罩层被点击");
                }
            }

        }

        ColumnLayout {
            anchors.fill: parent
            spacing: 10
            anchors.margins: 10

            // Table header
            RowLayout {
                Layout.fillWidth: true

                Text {
                    text: "干扰吊舱记录管理"
                    font.pixelSize: 18
                    font.bold: true
                }

                Item {
                    Layout.fillWidth: true
                }



            }

            // 搜索区域
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 80
                color: "#f5f5f5"
                radius: 4

                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 10
                    spacing: 5

                    Text {
                        text: "搜索条件"
                        font.bold: true
                    }

                    RowLayout {
                        Layout.fillWidth: true
                        spacing: 10

                        Text {
                            text: "干扰吊舱名称"
                            font.bold: true
                        }



                        // 关键词搜索
                        TextField {
                            id: keywordInput

                            Layout.fillWidth: true
                            placeholderText: "搜索名称..."
                            onTextChanged: {
                                // try {
                                //     // 延迟处理文本变更，避免频繁更新
                                //     keywordUpdateTimer.restart();
                                // } catch (e) {
                                //     console.error("处理关键词输入变更错误: ", e);
                                // }
                            }

                            // 添加延迟定时器，优化性能
                            // Timer {
                            //     id: keywordUpdateTimer

                            //     interval: 300 // 300毫秒延迟
                            //     repeat: false
                            //     onTriggered: {

                            //     }
                            // }

                        }

                        Button {
                            text: "搜索"
                            onClicked: {
                                try {
                                    logDebug("搜索按钮点击");
                                    refreshTableData();
                                } catch (e) {
                                    console.error("搜索按钮处理错误: ", e);
                                }
                            }
                        }

                        Button {
                            text: "重置"
                            onClicked: {
                                keywordInput = ""
                            }
                        }

                    }

                }

            }

            // 表格工具栏
            RowLayout {
                Layout.fillWidth: true

                Item {
                    Layout.fillWidth: true
                }

            }

            Rectangle{
                Layout.fillWidth: true
                Layout.fillHeight: true

                DnyTable{
                    // 这里可以处理行选中逻辑

                                   id: dynamicTable
                                   anchors.fill: parent
                                   columnDefinitions: root.header
                                   tableData: root.tableData
                                   rowHeight: 50 // 再次减小行高至30像素，刚好比按钮高度(28px)略大
                                   headerHeight: 45
                                   headerBackgroundColor: "#e0e0e0"
                                   alternateRowBackgroundColor: "#f5f5f5"
                                   rowSpacing: 0 // 确保行间距为0
                                   showGrid: true // 关闭网格线显示
                                   onSelect: function(index) {
                                       // try {
                                       //     logDebug("选中表格行: " + index);
                                       // } catch (e) {
                                       //     console.error("表格行选中处理错误: ", e);
                                       // }
                                   }

                }
            }

            // Dynamic table using DnyTable component

            // 分页控件
            Rectangle {
                id: pagingControl

                Layout.fillWidth: true
                Layout.preferredHeight: 40
                color: "#f5f5f5"
                radius: 4

                RowLayout {
                    anchors.fill: parent
                    anchors.leftMargin: 10
                    anchors.rightMargin: 10
                    spacing: 5

                    // 左侧分页信息
                    // Text {
                    //     id: paginationInfoText

                    //     text: "共 " + totalRecords + " 条记录，第 " + query_condition.page + " / " + totalPages + " 页"
                    //     font.pixelSize: 12
                    //     Layout.alignment: Qt.AlignVCenter

                    //     // 监听页码变化信号
                    //     Connections {
                    //         function onPageChanged(page) {
                    //             // 强制更新分页信息文本
                    //             paginationInfoText.text = "共 " + totalRecords + " 条记录，第 " + page + " / " + totalPages + " 页";
                    //         }

                    //         target: root
                    //     }

                    // }

                    Item {
                        Layout.fillWidth: true
                    }

                    // 每页记录数选择
                    // Row {
                    //     spacing: 5
                    //     Layout.alignment: Qt.AlignVCenter

                    //     Text {
                    //         text: "每页显示：30条"
                    //         font.pixelSize: 12
                    //         anchors.verticalCenter: parent.verticalCenter
                    //     }

                    // }

                    // 首页按钮
                    // Button {
                    //     implicitWidth: 30
                    //     implicitHeight: 30
                    //     text: "«"
                    //     enabled: query_condition.page > 1
                    //     onClicked: {
                    //         goToFirstPage();
                    //     }
                    // }

                    // 上一页按钮
                    // Button {
                    //     implicitWidth: 30
                    //     implicitHeight: 30
                    //     text: "‹"
                    //     enabled: query_condition.page > 1
                    //     onClicked: {
                    //         goToPreviousPage();
                    //     }
                    // }

                    // 页码显示和编辑
                    // TextField {
                    //     id: pageInput

                    //     implicitWidth: 40
                    //     implicitHeight: 30
                    //     horizontalAlignment: TextInput.AlignHCenter
                    //     // 初始化
                    //     Component.onCompleted: {
                    //         text = String(query_condition.page);
                    //     }
                    //     onAccepted: {
                    //         var page = parseInt(text);
                    //         if (!isNaN(page) && page >= 1 && page <= totalPages)
                    //             goToPage(page);
                    //         else
                    //             text = String(query_condition.page);
                    //     }
                    //     onActiveFocusChanged: {
                    //         if (!activeFocus)
                    //             text = String(query_condition.page);

                    //     }

                    //     // 监听页码变化信号
                    //     Connections {
                    //         function onPageChanged(page) {
                    //             // 只在页码实际变化时更新
                    //             if (pageInput.text !== String(page)) {
                    //                 console.log("页码变化, 更新输入框: " + page);
                    //                 pageInput.text = String(page);
                    //             }
                    //         }

                    //         target: root
                    //     }

                    //     validator: IntValidator {
                    //         bottom: 1
                    //         top: totalPages
                    //     }

                    // }

                    // 下一页按钮
                    // Button {
                    //     implicitWidth: 30
                    //     implicitHeight: 30
                    //     text: "›"
                    //     enabled: query_condition.page < totalPages
                    //     onClicked: {
                    //         goToNextPage();
                    //     }
                    // }

                    // 末页按钮
                    // Button {
                    //     implicitWidth: 30
                    //     implicitHeight: 30
                    //     text: "»"
                    //     enabled: query_condition.page < totalPages
                    //     onClicked: {
                    //         goToLastPage();
                    //     }
                    // }
                    Button {
                        implicitWidth: 140
                        implicitHeight: 30
                        text: "删除"
                        onClicked: {
                            // var page = parseInt(pageInput.text);
                            // if (!isNaN(page))
                            //     goToPage(page);

                        }
                    }

                    // 页面跳转按钮
                    Button {
                        implicitWidth: 140
                        implicitHeight: 30
                        text: "新增"
                        onClicked: {
                            // var page = parseInt(pageInput.text);
                            // if (!isNaN(page))
                            //     goToPage(page);
                            processInfo.loadViewType = "addUavData";
                            pagePayloadLoader.setSource("qrc:./AddInterferencePodData.qml", {
                                "processInfo": processInfo,
                                "backUi": "qrc:/UavReconnaissancePayloadManagement.qml"
                            });
                            root.visible = false;

                        }
                    }

                }

            }

        }

    }





    // 添加Toast组件定义，放在文件尾部但在Item结束前
    Component {
        id: toastComponent

        Rectangle {
            id: toast

            property string message: "提示消息"
            property bool success: true
            property int displayTime: 3000  // 显示时间(毫秒)

            signal closed()

            function show() {
                showAnim.start();
                hideTimer.start();
            }

            width: toastText.width + 40
            height: 40
            radius: 20
            color: success ? "#4CAF50" : "#F44336"  // 成功绿色，失败红色
            opacity: 0

            anchors {
                horizontalCenter: parent.horizontalCenter
                top: parent.top
                topMargin: 60 + (activeToasts.indexOf(toast) * 50)  // 堆叠显示
            }

            Text {
                id: toastText
                anchors.centerIn: parent
                text: toast.message
                color: "white"
                font.pixelSize: 14
            }

            NumberAnimation {
                id: showAnim
                target: toast
                property: "opacity"
                from: 0
                to: 1
                duration: 300
                easing.type: Easing.OutCubic
            }

            NumberAnimation {
                id: hideAnim
                target: toast
                property: "opacity"
                from: 1
                to: 0
                duration: 300
                easing.type: Easing.InCubic
                onStopped: toast.closed()
            }

            Timer {
                id: hideTimer
                interval: toast.displayTime
                repeat: false
                onTriggered: hideAnim.start()
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    hideTimer.stop();
                    hideAnim.start();
                }
            }
        }
    }
    function loadPayloadData() {
        payloadData.interferencePodName = "";
        payloadData.interferencePodId = "";
    }
    function loadPayloadRecord(data) {
        var result = interferencePodDaoTableModel.selectInterferencePodData(data);
        console.log("inrettttttttttttttt" + JSON.stringify(result));
        //root.tableData.clear();
        dynamicTable.tableData = result
    }
    function deletePayloadData() {
        var selectedRowsData = [];
        for (var i = 0; i < tableModel.rowCount; i++) {
            //console.log("tableModel.rows[i].checked Rows JSON:", JSON.stringify(tableModel.rows[i]));
            //console.log("tablemodel",JSON.stringify(tableModel.rows))
            if (tableModel.rows[i].checked) {
                var rowData = {
                    "recordId": tableModel.rows[i].recordId,
                    "ammoName": tableModel.rows[i].ammoName
                };
                selectedRowsData.push(rowData);
            }
        }
        // 打印当前函数的名称
        console.log("当前函数名称:", arguments.callee.name);
        console.log("tableModel.rows[i] ammo Rows JSON:" + JSON.stringify(selectedRowsData));
        if (selectedRowsData.length === 0) {
            console.log("数组为空");
            warningItem.text = "数据删除不能为空!";
            warningPopup.open();
            // 2秒后自动关闭
            autoCloseTimer.start();
        } else {
            console.log("数组不为空");
            let result = interferencePodDaoTableModel.deleteInterferencePodData(selectedRowsData);
            loadPayloadData();
            loadPayloadRecord(payloadData);
            if (result === true) {
                warningItem.text = "数据删除成功!";
                warningPopup.open();
                // 2秒后自动关闭
                autoCloseTimer.start();
            } else if (result === false) {
                warningItem.text = "数据删除失败!";
                warningPopup.open();
                // 2秒后自动关闭
                autoCloseTimer.start();
            } else {
                console.log("unknown deleteMountLocation");
            }
        }
    }

}
