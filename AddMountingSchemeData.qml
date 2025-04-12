import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtQuick.Window 2.12
import QtQuick.Dialogs 1.2

import "qrc:/"
import UavDaoModel 1.0

Window{//Rectangle{
    id:addUavModelData
    visible: true
    width: 1200
    height: 600
    //title: qsTr("QML TableView example")
    // 获取当前时间并转换为字符串
    property var currentTime: new Date().toLocaleString()

    //侦察载荷
    property var uavInvestigationPayloadTypeResult: ""
    //投弹方式
    property var uavBombingmethodResult: ""
    //回收方式
    property var uavRecoveryModeResult: ""
    //操控方式
    property var uavOperatioanalModeResult: ""
    //挂载位置
    property var uavPayloadTypeResult: ""
    // 组件加载完成后生成测试数据
    Component.onCompleted:{
        //loadUavAllData()
        loadView()
    }
    Popup {
            id: warningPopup
            width: 300
            height: 100
            anchors.centerIn: Overlay.overlay // 居中显示
            closePolicy: Popup.NoAutoClose    // 完全禁用自动关闭
            modal: true
            focus: true

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

    Item {
        id:controlUav
        // width: 1200
        // height: 600
        // 定义警告对话框

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
        }
        UavModelDaoTableModel{
            id:uavModelInsertDao
        }

        ColumnLayout {
                    anchors.fill: parent
                    //Layout.fillWidth: true
                    //Layout.fillHeight: true
                    spacing: 10
                    RowLayout {
                        //anchors.fill: parent
                        Layout.fillWidth: true
                        //Layout.fillHeight: true
                        Label {
                            Layout.fillWidth: true
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignHCenter
                            text: qsTr("挂载方案管理");
                            font.pointSize: 28
                            color: "black"
                        }
                    }
                    RowLayout {
                        //anchors.fill: parent
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        // Rectangle {
                        //     id: root
                        //     visible: true
                        //     width:900
                        //     height: 500
                        //     color: "#ECF2FE"
                        //     // ColumnLayout{


                        //     // }
                        // }
                        ColumnLayout {
                            anchors.fill: parent
                            Layout.fillWidth: true
                            Layout.fillHeight: true



                            RowLayout {
                                //anchors.fill: parent
                                Layout.fillWidth: true  // 占满列布局宽度
                                // Layout.fillHeight: true
                                spacing: 10
                                Label{
                                    id:podType
                                    text: "吊舱类型:"
                                    height: 50
                                    width:100
                                    // anchors.left: parent.left //锚点属性与锚点边距一起用。
                                    // anchors.leftMargin: 10
                                    Layout.leftMargin: 10

                                }

                                ComboBox{
                                    id:podTypeSelect
                                    width:100
                                    height:50
                                    model:["无吊舱","200kg通侦吊舱","500kg吊舱"]
                                    onActivated: {
                                        refreshProblemDesc()
                                    }
                                }

                                Label{
                                    id:uavMaximumTakeoffWeight
                                    text: "最大起飞重量(Kg):"
                                    height: 50
                                    width:100
                                }
                                TextField{
                                    id: uavMaximumTakeoffWeightValue
                                    Layout.preferredWidth: 50
                                    onTextChanged: {
                                        refreshProblemDesc()
                                    }
                                }
                                Label{
                                    id:uavEmptyWeight
                                    text: "空机重量(Kg):"
                                    height: 50
                                    width:100

                                }
                                TextField{
                                    id: uavEmptyWeightValue
                                    Layout.preferredWidth: 50
                                }
                            }
                            RowLayout {
                                //anchors.fill: parent
                                Layout.fillWidth: true  // 占满列布局宽度
                                // Layout.fillHeight: true
                                spacing: 10

                                Label{
                                    id:uavMaximumFuelCapacity
                                    text: "最大载油量(Kg):"
                                    height: 50
                                    width:100
                                    Layout.leftMargin: 10
                                }
                                TextField{
                                    id: uavMaximumFuelCapacityValue
                                    Layout.preferredWidth: 50
                                }
                                Label{
                                    id:uavMaximumExternalWeight
                                    text: "最大外挂重量(Kg):"
                                    height: 50
                                    width:100
                                }
                                TextField{
                                    id: uavMaximumExternalWeightValue
                                    Layout.preferredWidth: 50
                                }
                            }

                            RowLayout {
                                // anchors.fill: parent
                                Layout.fillWidth: true
                                // Layout.fillHeight: true
                                spacing: 10
                                Label{
                                    id:mountingWeight
                                    text: "已挂载重量(kg):"
                                    height: 50
                                    width:100
                                    // anchors.left: parent.left //锚点属性与锚点边距一起用。
                                    // anchors.leftMargin: 10
                                    Layout.leftMargin: 10

                                }

                                TextField{
                                    id: mountingWeightText
                                    Layout.preferredWidth: 80
                                    //width: 50
                                }

                                Label{
                                    id:remainingLoadCapacity
                                    text: "剩余载重(kg):"
                                    height: 50
                                    width:100
                                }
                                TextField{
                                    id: remainingLoadCapacityText
                                    //width: 120
                                    Layout.preferredWidth: 80
                                }
                            }


                            RowLayout {
                                // anchors.fill: parent
                                Layout.fillWidth: true
                                // Layout.fillHeight: true
                                spacing: 10
                                Label{
                                    id:uavLowAltitudeBreakthroughSpeed
                                    text: "挂载配置:"
                                    height: 50
                                    width:100
                                    // anchors.left: parent.left //锚点属性与锚点边距一起用。
                                    // anchors.leftMargin: 10
                                    Layout.leftMargin: 10

                                }
                                Text {
                                    id: uavHangingLocationText
                                    text: qsTr("请选择")
                                }
                                // 点击区域
                                MouseArea {
                                    anchors.fill: parent
                                    onClicked: { //uavHangingLocationText.visible = !uavHangingLocationText.visible
                                        payloadTypeManagementPopup.open()
                                        uavManagementroot.managementType = "bombingMethod"
                                        //uavManagementroot.enabled = false
                                    }
                                }
                            }
                        }
                        ColumnLayout{
                            //anchors.fill: parent
                            //Layout.fillWidth: true
                            Layout.fillHeight: true
                            spacing: 10
                            Rectangle {
                                id: aroot
                                visible: true
                                width:500
                                height: 600
                                // anchors.top: parent.top
                                // anchors.topMargin: 40
                                // anchors.right: parent.right
                                // anchors.rightMargin: 2
                                Layout.alignment:Qt.AlignRight
                                color: "#ECF2FE"
                                border.color: "#BDBDBD"
                                TextField{
                                    id: describeTextArea
                                    //width: 120
                                    width:500
                                    height: 600
                                    // 对齐设置
                                    verticalAlignment: Text.AlignTop      // 垂直顶部对齐
                                    horizontalAlignment: Text.AlignLeft   // 水平左对齐
                                    // 边距设置
                                    leftPadding: 6       // 左侧零边距
                                    topPadding: 10        // 顶部零边距
                                    rightPadding: 6      // 右侧保留2像素防止滚动条遮挡
                                    bottomPadding: 6     // 底部保留2像素
                                    echoMode: TextField.Normal
                                    inputMethodHints: Qt.ImhMultiLine
                                    wrapMode: TextField.WrapAtWordBoundaryOrAnywhere
                                    Layout.preferredWidth: 80
                                    // 可选样式调整（根据实际需要）
                                    background: Rectangle {
                                        //color: "#D3E1FE"
                                        //border.color: "gray"
                                        border.width: 1
                                        color: "#e0f0ff" // 淡蓝色
                                        border.color: "#cccccc" // 边框颜色
                                        radius: 4 // 圆角
                                    }
                                    // 设置字体颜色为黑色
                                    color: "#000000"

                                    // 设置字体大小为 12 点
                                    font.pointSize: 12
                                }
                            }
                        }

                    }

                // 下部行布局（底部对齐）
                    RowLayout {
                        Layout.fillWidth: true
                        Layout.alignment: Qt.AlignBottom  // 底部对齐
                        spacing: 10
                        Item { Layout.fillWidth: true }  // 占位空格元素
                        Button {
                            id:saveButton
                            anchors.right: parent.right
                            anchors.rightMargin: 200
                            width: 100
                            height: 50
                            text: "保存"
                            onClicked:{
                                addUavModelData.currentTime = new Date().toLocaleString()
                                console.log("addUavModelData.currentTime"+addUavModelData.currentTime)
                                saveUavData()
                            }
                        }

                        Button {
                            id:cancleButton
                            anchors.right: parent.right
                            anchors.rightMargin: 10
                            width: 100
                            height: 50
                            text: "取消"
                        }
                    }




        }



    }
    //判断是否加载新增、查看、编辑
    function loadView(){
        var viewType = processInfo.loadViewType
        if(processInfo.loadViewType === "addUavData"){
            console.log("addUavDataView"+processInfo.loadViewType)
        }else if(processInfo.loadViewType === "query"){
            writeControl(false)
            console.log("addUavDataView"+processInfo.loadViewType)
        }else if(processInfo.loadViewType === "update"){
            writeControl(true)
            console.log("addUavDataView"+processInfo.loadViewType)
        }else{
            console.log("processInfo.loadViewType Unknown")
        }
    }
    function writeControl(isEditable) {
        // 遍历输入容器的所有子元素
        for (var i = 0; i < controlUav.children.length; i++) {
            var child = controlUav.children[i];
            // 检查是否是输入框或下拉框
            if (child.hasOwnProperty("enabled")) {
                child.enabled = isEditable;
            }
        }
    }

    // 检查变量是否为空的函数
    function isEmpty(value) {
        if (typeof value === "string") {
            return value.length === 0;
        } else if (typeof value === "object" && value !== null) {
            return Object.keys(value).length === 0;
        } else {
            return value === null || value === undefined;
        }
    }
    // 定义一个通用的验证函数
   function validateInput(field, message) {
       if (field === "" || (field.length !== undefined && field.length === 0)) {
           warningPopup.open();
           warningItem.text = message;
           autoCloseTimer.start()
           return false;
       }
       return true;
   }

    function checkAllValue(){
        var isValid = true;
        // 检查每个字段
        isValid = validateInput(uavTypeSelect.currentText, "无人机类型未选择!") && isValid;
        isValid = validateInput(uavNameText.text, "无人机名称未填写!") && isValid;
        isValid = validateInput(uavIdText.text, "无人机编号未填写!") && isValid;
        isValid = validateInput(uavLengthText.text, "无人机长度未填写!") && isValid;
        isValid = validateInput(uavWidthText.text, "无人机翼宽未填写!") && isValid;
        isValid = validateInput(uavHeightText.text, "无人机高度未填写!") && isValid;
        isValid = validateInput(uavInvisibilitySelect.currentText, "无人机隐身性未选择!") && isValid;
        isValid = validateInput(uavFlightHeightMin.text, "无人机飞行高度最小值未填写!") && isValid;
        isValid = validateInput(uavFlightHeightMax.text, "无人机飞行高度最大值未填写!") && isValid;
        isValid = validateInput(uavFlightSpeedMin.text, "无人机飞行速度最小值未填写!") && isValid;
        isValid = validateInput(uavFlightSpeedMax.text, "无人机飞行速度最大值未填写!") && isValid;
        isValid = validateInput(uavTurningRadiusMin.text, "无人机转弯半径最小值未填写!") && isValid;
        isValid = validateInput(uavTurningRadiusMax.text, "无人机转弯半径最大值未填写!") && isValid;
        isValid = validateInput(uavFlightDistance.text, "无人机飞行航程值未填写!") && isValid;
        isValid = validateInput(uavRecoveryModeResult, "回收方式未选择!") && isValid;
        isValid = validateInput(uavFlightTime.text, "无人机航时值未填写!") && isValid;
        isValid = validateInput(uavTakeoffDistanceValue.text, "无人机起飞滑跑距离未填写!") && isValid;
        isValid = validateInput(uavLandDistanceValue.text, "无人机着陆滑跑距离未填写!") && isValid;
        isValid = validateInput(uavOperatioanalRadius.text, "无人机作战距离未填写!") && isValid;
        isValid = validateInput(uavLoadReconnaissanceRangeValue.text, "无人机侦察范围未填写!") && isValid;
        isValid = validateInput(uavLoadReconnaissanceAccuracyValue.text, "无人机侦察精度未填写!") && isValid;
        isValid = validateInput(uavLowAltitudeBreakthroughSpeedValue.text, "无人机低空突防速度未填写!") && isValid;
        isValid = validateInput(uavAttackaccuracyValue.text, "无人机攻击精度未填写!") && isValid;
        isValid = validateInput(uavRadarCrossSectionValue.text, "无人机的雷达反射面积未填写!") && isValid;
        isValid = validateInput(uavCenterOfGravityFrontLimitValue.text, "无人机重心前向未填写!") && isValid;
        isValid = validateInput(uavCenterOfGravityAfterwardLimitValue.text, "无人机重心后向未填写!") && isValid;
        isValid = validateInput(uavMaximumTakeoffWeightValue.text, "无人机最大起飞重量未填写!") && isValid;
        isValid = validateInput(uavMaximumFuelCapacityValue.text, "无人机最大载油重量未填写!") && isValid;
        isValid = validateInput(uavMaximumExternalWeightValue.text, "无人机最大外挂重量未填写!") && isValid;
        isValid = validateInput(uavCeilingValue.text, "无人机最大升限未填写!") && isValid;
        isValid = validateInput(uavMaximumAirStartingAltitudeValue.text, "无人机空中最大起动高度未填写!") && isValid;
        isValid = validateInput(uavMaximumGroundStartingHeightValue.text, "无人机地面最大起动高度未填写!") && isValid;
        isValid = validateInput(uavMaximumEnduranceValue.text, "无人机最大续航时间未填写!") && isValid;
        isValid = validateInput(uavMaximumFlightVacuumSpeedValue.text, "无人机最大飞行真空速未填写!") && isValid;
        isValid = validateInput(uavMinimumFlightMeterSpeedValue.text, "无人机最小飞行表速未填写!") && isValid;
        isValid = validateInput(sealLevelTakeoffAndRollDistanceValue.text, "无人机海平面起飞滑跑距离未填写!") && isValid;
        isValid = validateInput(sealLevelLandingAndRollDistanceValue.text, "无人机海平面着陆滑跑距离未填写!") && isValid;
        isValid = validateInput(cruiseAltitudeReconnaissanceConfigurationValue.text, "无人机侦察构型巡航高度未填写!") && isValid;
        isValid = validateInput(cruiseAltitudeFullExternalConfigurationValue.text, "无人机满外挂构型巡航高度未填写!") && isValid;
        return isValid;

    }


    function saveUavData(){
        console.log("uavTypeSelevtContent"+uavTypeSelect.currentText+"-"+"testValue"+uavTypeSelect.currentValue)

        var uavData = {
            //-- 基础信息
            // uav_type VARCHAR(255) NOT NULL,
            // uav_name VARCHAR(255),
            // uav_id VARCHAR(255) NOT NULL,
            uav_type:"",
            uav_name:"",
            uav_id:"",
            //-- 尺寸参数
            // length REAL,
            // width REAL,
            // height REAL,
            // invisibility VARCHAR(255),
            length:0.0, // 浮点数
            width:0.0, // 浮点数
            height:0.0, // 浮点数
            invisibility:0.0, // 浮点数
            //-- 飞行性能
            // flight_height_min REAL,
            // flight_height_max REAL,
            // flight_speed_min REAL,
            // flight_speed_max REAL,
            // flight_distance_min REAL,
            // flight_distance_max REAL,
            // flight_time_min REAL,
            // flight_time_max REAL,
            flight_height_min:0.0, // 浮点数
            flight_height_max:0.0, // 浮点数
            flight_speed_min:0.0, // 浮点数
            flight_speed_max:0.0, // 浮点数
            flight_distance_min:0.0, // 浮点数
            flight_distance_max:0.0, // 浮点数
            flight_time_min:0.0, // 浮点数
            flight_time_max:0.0, // 浮点数
            //-- 起降参数
            //takeoff_distance REAL,
            //landing_distance REAL,

            //-- 机动性能
            //turn_radius_min REAL,
            // turn_radius_max REAL,
            //combat_radius REAL,
            takeoff_distance:0.0, // 浮点数
            landing_distance:0.0, // 浮点数
            turn_radius_min:0.0, // 浮点数
            turn_radius_max:0.0, // 浮点数
            combat_radius:0.0, // 浮点数

            //-- 载荷配置
            // payload_type VARCHAR(255),
            // bomb_method VARCHAR(255),
            // recon_range_min REAL,
            // recon_range_max REAL,
            // recon_accuracy REAL,

            payload_type:"",
            bomb_method:"",
            recon_range_min:0.0, // 浮点数
            recon_range_max:0.0, // 浮点数
            recon_accuracy:0.0, // 浮点数
            //-- 回收与突防
            // recovery_mode VARCHAR(255),
            // low_alt_speed REAL,

            //-- 挂载能力
            //hanging_capacity VARCHAR(255),

            //-- 操控与攻击
            // operation_method VARCHAR(255),  -- 注意：建议修正拼写为
            // attack_accuracy REAL,

            //-- 雷达特征
            //rcs REAL,
            recovery_mode:"",
            low_alt_speed:0.0, // 浮点数
            hanging_capacity:"",
            operation_method:"",
            attack_accuracy:0.0, // 浮点数
            rcs:0.0, // 浮点数
            //-- 重量与平衡
            // cg_front_limit REAL,
            // cg_rear_limit REAL,
            // max_takeoff_weight REAL,
            // empty_weight REAL,

            //-- 燃油与载重
            // max_fuel REAL,
            // max_external_weight REAL,

            //-- 高度性能
            // ceiling REAL,
            // ground_start_alt REAL,
            // air_start_alt REAL,

            //-- 续航性能
            // endurance REAL,
            // max_vacuum_speed REAL,
            // min_meter_speed REAL,
            cg_front_limit:0.0, // 浮点数
            cg_rear_limit:0.0, // 浮点数
            max_takeoff_weight:0.0, // 浮点数
            empty_weight:0.0, // 浮点数
            max_fuel:0.0, // 浮点数
            max_external_weight:0.0, // 浮点数
            ceiling:0.0, // 浮点数
            ground_start_alt:0.0, // 浮点数
            air_start_alt:0.0, // 浮点数
            endurance:0.0, // 浮点数
            max_vacuum_speed:0.0, // 浮点数
            min_meter_speed:0.0, // 浮点数
            //-- 特殊场景性能
            // sea_takeoff_roll REAL,
            // sea_landing_roll REAL,
            // recon_cruise_alt REAL,
            // full_external_cruise_alt REAL,

            //-- 系统记录
            // create_time VARCHAR(255),  -- 建议改为 TIMESTAMP
            // image_name VARCHAR(255),
            // image_url VARCHAR(255)

            sea_takeoff_roll:0.0, // 浮点数
            sea_landing_roll:0.0, // 浮点数
            recon_cruise_alt:0.0, // 浮点数
            full_external_cruise_alt:0.0, // 浮点数
            image_name:"",
            image_url:"",
            create_time:""

        };
        //ButtonGroup的接收值转化方法
        // var uavInvestigationPayloadTypeJson = getSelectedPayloads(uavInvestigationPayloadTypeMultiComBox.buttons)
        // console.log("有效载荷选择:", JSON.stringify(uavInvestigationPayloadTypeJson))
        // var uavInvestigationPayloadTypeJsonStr = JSON.stringify(uavInvestigationPayloadTypeJson)
        // var uavInvestigationPayloadTypeJsonStrresult = convertToJsonArray(uavInvestigationPayloadTypeJson);
        // console.log(uavInvestigationPayloadTypeJsonStrresult);

        // var uavBombingmethodGroupJson = getSelectedPayloads(uavBombingmethodMultiComBox.buttons)
        // console.log("投弹方式:", JSON.stringify(uavBombingmethodGroupJson))
        // var uavBombingmethodGroupStr = JSON.stringify(uavInvestigationPayloadTypeJson)
        // var uavBombingmethodGroupJsonStrresult = convertToJsonArray(uavBombingmethodGroupJson);
        // console.log(uavBombingmethodGroupJsonStrresult);

        // var uavRecoverymodeGroupJson = getSelectedPayloads(uavRecoverymodeMultiComBox.buttons)
        // console.log("回收方式:", JSON.stringify(uavRecoverymodeGroupJson))
        // var uavRecoverymodeGroupJsonStr = JSON.stringify(uavRecoverymodeGroupJson)
        // var uavRecoverymodeGroupJsonStrresult = convertToJsonArray(uavRecoverymodeGroupJson);
        // console.log(uavRecoverymodeGroupJsonStrresult);

        // var uavOperatioanalmodeGroupJson = getSelectedPayloads(operationModeMultiComBox.buttons)
        // console.log("操控方式:", JSON.stringify(uavOperatioanalmodeGroupJson))
        // var uavOperatioanalmodeGroupJsonStr = JSON.stringify(uavOperatioanalmodeGroupJson)
        // var uavOperatioanalmodeGroupJsonStrresult = convertToJsonArray(uavOperatioanalmodeGroupJson);
        // console.log(uavOperatioanalmodeGroupJsonStrresult);
        uavData.uav_type = uavTypeSelect.currentText
        uavData.uav_name = uavNameText.text
        uavData.uav_id = uavIdText.text
        uavData.length = uavLengthText.text
        uavData.width = uavWidthText.text
        uavData.height = uavHeightText.text
        uavData.invisibility = uavInvisibilitySelect.currentText

        uavData.flight_height_min = uavFlightHeightMin.text
        uavData.flight_height_max = uavFlightHeightMax.text
        uavData.flight_speed_min = uavFlightSpeedMin.text
        uavData.flight_speed_max = uavFlightSpeedMax.text
        uavData.turn_radius_min = uavTurningRadiusMin.text
        uavData.turn_radius_max = uavTurningRadiusMax.text

        uavData.flight_distance_max = uavFlightDistance.text
        //uavData.hanging_capacity = ""//uavRadarCrossSectionText.text
        //检查是否填写完全
        checkAllValue()
        if(isEmpty(uavInvestigationPayloadTypeResult)){
            warningPopup.open()
            warningItem.text = "侦察载荷类型未选择!"
            autoCloseTimer.start()
        }else{
            uavData.payload_type = JSON.stringify(uavInvestigationPayloadTypeResult.join(",")).replace(/^"|"$/g, "");//uavInvestigationPayloadTypeJsonStrresult

        }
        console.log("uavBombingmethodResult"+uavBombingmethodResult)
        if(isEmpty(uavBombingmethodResult)){
            if(uavTypeSelect.currentText === "侦察无人机"){
                    uavData.bomb_method = ""
            }else{
                    warningPopup.open()
                    warningItem.text = "投弹方式未选择!"
                    autoCloseTimer.start()
            }

        }else{
            uavData.bomb_method = JSON.stringify(uavBombingmethodResult.join(",")).replace(/^"|"$/g, "");//uavBombingmethodGroupJsonStrresult
        }
        if(isEmpty(uavRecoveryModeResult)){
            warningPopup.open()
            warningItem.text = "回收方式未选择!"
            autoCloseTimer.start()
        }else{
            uavData.bomb_method = JSON.stringify(uavRecoveryModeResult.join(",")).replace(/^"|"$/g, "");//uavBombingmethodGroupJsonStrresult
        }
        if(isEmpty(uavOperatioanalModeResult)){
            warningPopup.open()
            warningItem.text = "操作方式未选择!"
            autoCloseTimer.start()
        }else{
            uavData.payload_type = JSON.stringify(uavOperatioanalModeResult.join(",")).replace(/^"|"$/g, "");//uavInvestigationPayloadTypeJsonStrresult

        }
        uavData.hanging_capacity = ""//uavRadarCrossSectionText.text
        uavData.operation_method = JSON.stringify(uavOperatioanalModeResult.join(",")).replace(/^"|"$/g, "");//uavOperatioanalmodeGroupJsonStrresult
        uavData.recovery_mode = JSON.stringify(uavRecoveryModeResult.join(",")).replace(/^"|"$/g, "");//uavRecoverymodeGroupJsonStrresult

        uavData.flight_time_max =  uavFlightTime.text
        uavData.takeoff_distance = uavTakeoffDistanceValue.text
        uavData.landing_distance = uavLandDistanceValue.text
        uavData.combat_radius = uavOperatioanalRadius.text
        //uavData.recon_range_min = uavLoadReconnaissanceAccuracyText.text
        uavData.recon_range_max = uavLoadReconnaissanceRangeValue.text
        uavData.recon_accuracy = uavLoadReconnaissanceAccuracyValue.text

        uavData.low_alt_speed = uavLowAltitudeBreakthroughSpeedValue.text
        uavData.combat_radius = uavOperatioanalRadius.text
        uavData.attack_accuracy = uavAttackaccuracyValue.text
        uavData.rcs = uavRadarCrossSectionValue.text
        uavData.cg_front_limit = uavCenterOfGravityFrontLimitValue.text
        uavData.cg_rear_limit = uavCenterOfGravityAfterwardLimitValue.text
        uavData.max_takeoff_weight = uavMaximumTakeoffWeightValue.text
        uavData.empty_weight = uavEmptyWeightValue.text
        uavData.max_fuel = uavMaximumFuelCapacityValue.text
        uavData.max_external_weight = uavMaximumExternalWeightValue.text
        uavData.ceiling = uavCeilingValue.text
        uavData.ground_start_alt = uavMaximumGroundStartingHeightValue.text
        uavData.air_start_alt = uavMaximumAirStartingAltitudeValue.text
        uavData.endurance = uavMaximumEnduranceValue.text
        uavData.max_vacuum_speed = uavMaximumFlightVacuumSpeedValue.text
        uavData.min_meter_speed = uavMinimumFlightMeterSpeedValue.text
        uavData.sea_takeoff_roll = sealLevelTakeoffAndRollDistanceValue.text
        uavData.sea_landing_roll = sealLevelLandingAndRollDistanceValue.text
        uavData.recon_cruise_alt = cruiseAltitudeReconnaissanceConfigurationValue.text
        uavData.full_external_cruise_alt = cruiseAltitudeFullExternalConfigurationValue.text

        uavData.image_name = ""
        uavData.image_url = ""
        uavData.create_time = addUavModelData.currentTime
        var jsonString = JSON.stringify(uavData);
        console.log("jsonString"+jsonString);

        // uavModelInsertDao.insertModelDate(uavData)
        //"^_^记录更新成功^_^" ^_^记录更新失败^_^


    }
    function refreshProblemDesc() {
        let css1 = "   " //""<strong><div style=\"font-size:18px;\">"
        let css2 = "" //"</div></strong>"

        // 某方案总共8个挂载位置(左上、右上)可挂载600kg的外挂配置，现在挂载配置包含左上(1号位置)挂载1个制导炸弹(炸弹参数),共计1个制导炸弹挂载在左上(1号位置),其余位置未挂载配置,总计重量200kg,剩余载重500kg。
        //let presentDate = proposedDate.content.split(" ")
        let descContent = css1 + "某方案总共"+"8"+"个挂载位置("+"左上、右上"+")可挂载"+uavMaximumExternalWeightValue.text+"kg的外挂配置" + "，" + css2
        descContent += "现在挂载配置包含"+"中心位置(7号)"
        if (uavTypeSelect.currentText === "无吊舱") {
            descContent += "不挂载吊舱" + css1
        } else {
            descContent += "挂载"+uavTypeSelect.currentText+","
        }
        describeTextArea.text = descContent;
    }
    function convertToJsonArray(jsonData) {
            return jsonData.map(function(item) {
                return item.name;
            });
    }

}
