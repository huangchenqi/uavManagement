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
    visible: true // 确保初始状态可见

    // 添加调试信息
    Component.onCompleted: {
        console.log("InterferencePodRecordManagement 组件初始化开始");
        try {
            loadPayloadData();
            loadPayloadRecord(payloadData);
        } catch (e) {
            console.error("初始化数据失败:", e);
        }
        console.log("InterferencePodRecordManagement 组件初始化完成");
    }

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
        "width": 50,
        "field": "frontCoverLength"
    },
    {
        "title": "后舱长",
        "width": 50,
        "field": "rearCoverLength"
    },
    {
        "title": "主舱",
        "width": 50,
        "field": "mainCabinSectione"
    },
    {
        "title": "用途",
        "width": 250,
        "field": "description"
    },
    {
        "title": "操作",
        "width": 200,
        "field": "id",
        "delegate": query,
    }]
    property var tableData: []
    
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
    property var payloadData: ({}) //创建对象来实现数据的查询
    // 添加额外信号以触发UI更新
    signal pageChanged(int page)
    property var processInfo: ({}) // 初始化processInfo对象

    // 引用Toast组件
    property var activeToasts: []
    
    InterferencePodDaoTableModel {
        id: interferencePodDaoTableModel
    }
    AddInterferencePodData{
        id:addInterferencePodData
        anchors.fill: parent
        visible: false
    }
    
    // 确保Loader初始状态为不可见
    Loader {
        id: pagePayloadLoader
        anchors.fill: parent
        visible: false
        
        Connections {
            target: pagePayloadLoader.item || null
            function onBackPayloadRecord() {
                console.log("返回到干扰吊舱记录管理界面");
                root.visible = true;
                //pagePayloadLoader.visible = false;
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
        closePolicy: Popup.NoAutoClose

        background: Rectangle {
            color: "#ffeb3b"
            border.color: "#fbc02d"
            radius: 5
        }

        contentItem: Text {
            id: warningItem
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: 16
        }
    }

    Timer {
        id: autoCloseTimer
        interval: 500
        onTriggered: warningPopup.close()
    }

    Component {
        id:chechBox
        Item {
            id: chechBoxId
            anchors.fill: parent
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
            RowLayout{
                anchors.centerIn: parent
                spacing: 2
                Button {
                    id:queryButton
                    height: 20
                    text: "查看"
                    onClicked: {
                        console.log(cellData)
                        processInfo.loadViewType = "query";
                        pagePayloadLoader.setSource("qrc:./AddInterferencePodData.qml", {
                            "processInfo": processInfo,
                            "backUi": "qrc:/UavReconnaissancePayloadManagement.qml"
                        });
                        root.visible = false;
                        pagePayloadLoader.visible = true;
                    }
                }
                Button {
                    id:updateButton
                    height: 20
                    text: "编辑"
                    onClicked: {
                        console.log(cellData)
                        processInfo.loadViewType = "update";
                        pagePayloadLoader.setSource("qrc:./AddInterferencePodData.qml", {
                            "processInfo": processInfo,
                            "backUi": "qrc:/UavReconnaissancePayloadManagement.qml"
                        });
                        root.visible = false;
                        pagePayloadLoader.visible = true;
                    }
                }
            }
        }
    }

    Timer {
        id: showDialogTimer
        interval: 100
        repeat: false
        onTriggered: {
            try {
                console.log("显示导入对话框计时器触发");
                importFlyDataDialog.visible = true;
                tableContainer.enabled = false;
                overlay.visible = true;
                console.log("导入对话框显示设置完成");
            } catch (e) {
                console.error("显示导入对话框时出错: ", e);
            }
        }
    }

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
        color: "#ffffff" // 添加背景色以便于确认容器是否显示

        // 添加遮罩层
        Rectangle {
            id: overlay
            anchors.fill: parent
            color: "black"
            opacity: 0.5
            visible: false
            z: 50
            
            MouseArea {
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

                        TextField {
                            id: keywordInput
                            Layout.fillWidth: true
                            placeholderText: "搜索名称..."
                            onTextChanged: {
                                keywordUpdateTimer.restart();
                            }

                            Timer {
                                id: keywordUpdateTimer
                                interval: 300
                                repeat: false
                                onTriggered: {
                                    payloadData.interferencePodName = keywordInput.text;
                                }
                            }
                        }

                        Button {
                            text: "搜索"
                            onClicked: {
                                try {
                                    console.log("搜索按钮点击");
                                    payloadData.interferencePodName = keywordInput.text;
                                    loadPayloadRecord(payloadData);
                                } catch (e) {
                                    console.error("搜索按钮处理错误: ", e);
                                }
                            }
                        }

                        Button {
                            text: "重置"
                            onClicked: {
                                keywordInput.text = "";
                                payloadData.interferencePodName = "";
                                loadPayloadRecord(payloadData);
                            }
                        }
                    }
                }
            }

            // 表格区域
            Rectangle{
                id: tableRect
                Layout.fillWidth: true
                Layout.fillHeight: true
                border.width: 1
                border.color: "#e0e0e0"
                
                DnyTable{
                    id: dynamicTable
                    anchors.fill: parent
                    columnDefinitions: root.header
                    tableData: root.tableData
                    rowHeight: 50
                    headerHeight: 45
                    headerBackgroundColor: "#e0e0e0"
                    alternateRowBackgroundColor: "#f5f5f5"
                    rowSpacing: 0
                    showGrid: true
                    onSelect: function(index) {
                        console.log("选中表格行: " + index);
                    }
                }
            }

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

                    Item {
                        Layout.fillWidth: true
                    }

                    Button {
                        implicitWidth: 140
                        implicitHeight: 30
                        text: "删除"
                        onClicked: {
                            deletePayloadData();
                        }
                    }

                    Button {
                        implicitWidth: 140
                        implicitHeight: 30
                        text: "新增"
                        onClicked: {
                            console.log("dayig")
                            processInfo.loadViewType = "addUavData";

                            addInterferencePodData.visible = true

                            // console.log("dayig!")
                            pagePayloadLoader.setSource("qrc:./AddInterferencePodData.qml", {
                                "processInfo": processInfo//,
                                //"backUi": "qrc:/UavReconnaissancePayloadManagement.qml"
                            });
                            console.log("dayig!!")
                            root.visible = false;

                        }
                    }
                }
            }
        }
    }

    // Toast组件
    Component {
        id: toastComponent
        Rectangle {
            id: toast
            property string message: "提示消息"
            property bool success: true
            property int displayTime: 3000
            signal closed()
            function show() {
                showAnim.start();
                hideTimer.start();
            }
            width: toastText.width + 40
            height: 40
            radius: 20
            color: success ? "#4CAF50" : "#F44336"
            opacity: 0
            anchors {
                horizontalCenter: parent.horizontalCenter
                top: parent.top
                topMargin: 60 + (activeToasts.indexOf(toast) * 50)
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
        payloadData = {};
        payloadData.interferencePodName = "";
        payloadData.interferencePodId = "";
    }

    function loadPayloadRecord(data) {
        try {
            var result = interferencePodDaoTableModel.selectInterferencePodData(data);
            console.log("获取干扰吊舱数据: " + JSON.stringify(result));
            
            // 添加示例数据用于测试 - 如果后端返回为空
            if (!result || result.length === 0) {
                console.log("后端未返回数据，使用测试数据");
                result = [
                    {
                        recordId: "1", 
                        index: 1,
                        interferencePodName: "测试干扰吊舱1",
                        length: 120,
                        mass: 35,
                        frontCoverLength: 30,
                        rearCoverLength: 25,
                        mainCabinSectione: "标准舱",
                        description: "通用干扰",
                        id: "1"
                    },
                    {
                        recordId: "2", 
                        index: 2,
                        interferencePodName: "测试干扰吊舱2",
                        length: 150,
                        mass: 42,
                        frontCoverLength: 35,
                        rearCoverLength: 30,
                        mainCabinSectione: "增强舱",
                        description: "高频干扰",
                        id: "2"
                    }
                ];
            }
            
            // 更新表格数据
            root.tableData = result;
            
            console.log("表格数据已更新: " + root.tableData.length + "条记录");
        } catch (e) {
            console.error("加载干扰吊舱数据失败: ", e);
        }
    }

    function deletePayloadData() {
        var selectedRowsData = [];
        for (var i = 0; i < tableData.length; i++) {
            if (tableData[i].checked) {
                var rowData = {
                    "recordId": tableData[i].recordId,
                    "interferencePodName": tableData[i].interferencePodName
                };
                selectedRowsData.push(rowData);
            }
        }
        
        console.log("当前函数名称:", arguments.callee.name);
        console.log("选中的行数据:" + JSON.stringify(selectedRowsData));
        
        if (selectedRowsData.length === 0) {
            console.log("未选择数据");
            warningItem.text = "数据删除不能为空!";
            warningPopup.open();
            autoCloseTimer.start();
        } else {
            console.log("准备删除数据");
            let result = interferencePodDaoTableModel.deleteInterferencePodData(selectedRowsData);
            loadPayloadData();
            loadPayloadRecord(payloadData);
            
            if (result === true) {
                warningItem.text = "数据删除成功!";
                warningPopup.open();
                autoCloseTimer.start();
            } else if (result === false) {
                warningItem.text = "数据删除失败!";
                warningPopup.open();
                autoCloseTimer.start();
            } else {
                console.log("未知的删除结果");
            }
        }
    }
}
