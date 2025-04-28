import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtQuick.Window 2.12
import QtQuick.Dialogs 1.2

import "qrc:/"
import "qrc:/AddAmmoModules/Component"
import "qrc:/AddAmmoModules/"

//import UavDaoModel 1.0
//import UavModelLoadTypeDaoModel 1.0
//import UavBombingMethodDaoModel 1.0
//import UavModelRecoveryModeDaoModel 1.0
//import UavModelOperationWayDaoModel 1.0
//import UavMountLocationDaoModel 1.0
//import AmmoDaoModel 1.0
//import UavModelTypeDaoModel 1.0
Rectangle{//Window{
    id:addUavModelData
    visible: true
    width: 1400
    height: 900
    //title: qsTr("QML TableView example")
    signal backUavRecord()
    //图片的地址
    property var imagUrl: ""
    property var imgName: ""
    // 获取当前时间并转换为字符串
    property var currentTime: new Date().toLocaleString()
    property var mountContent: []
    //侦察载荷
    property var payloadType: []
    property var uavInvestigationPayloadTypeResult: ""
    property var payloadTypeOrigi: []
    //投弹方式
    property var bombWay: []
    property var uavBombingmethodResult: ""
    property var bombWayOrigi: []
    //回收方式
    property var recoveryWay: []
    property var uavRecoveryModeResult: ""
    property var recoveryWayOrigi: []
    //操控方式
    property var operationWay: []
    property var uavOperatioanalModeResult: ""
    property var opreationWayOrigi: []
    //挂载位置
    property var uavPayloadTypeResult: ""
    //弹药类型
    property  var ammoType:[]
    property  var ammoTypeResult:""
    property  var ammoTypeOrigi: []

    property var  uavModelType: []
    property var uavModelTypeOrigi: []

    //无人机类型
    property int iUavType: 0
    //无人机型号
    property int iUavID: 0
    //挂载弹药类型
    property int uavLoadammoSelect: 0
    //侦察载荷类型
    property int iuavInvestigationPayloadType: 0
    //攻击方式
    property int iuavBombingmethod: 0
    //回收方式
    property int iuavRecoverymode: 0
    //操控方式
    property int ioperationMode: 0

    //获取弹药的类型
    function loadAmmoType(){
        var ammoType = ammoDaoModel.selectAmmoAllData()
        console.log("弹药类型当前函数名称:", arguments.callee.name);
        console.log("loadAmmoType"+JSON.stringify(ammoType))
        addUavModelData.ammoTypeOrigi =  extractAmmoData(ammoType)
        addUavModelData.ammoType = extractAmmoNameData(ammoType)
        console.log("loadAmmoTypeOrigi"+JSON.stringify(addUavModelData.ammoTypeOrigi))
    }
    function loadUavModelType(){
        var uavModelTypeData =  uavModelTypeDaoTableModel.selectUavModelTypeAllData()
        addUavModelData.uavModelTypeOrigi = uavModelTypeData
        console.log("uavModelTypeDaoTableModel"+JSON.stringify(uavModelTypeData))
        var uavModelTypeArray = extractUavModelTypeComponentNames(uavModelTypeData)
        console.log(JSON.stringify(uavModelTypeArray));
        addUavModelData.uavModelType  = uavModelTypeArray
    }
    function extractUavModelTypeComponentNames(originalArray) {
        var resultArray = ["请选择:"];
        // 遍历原始数组
        for (var i = 0; i < originalArray.length; ++i) {
            // 安全获取属性值
            var componentName = originalArray[i].uavComponeName || "";
            // 过滤空值并保留原始空格
            if (componentName.trim().length > 0) {
                resultArray.push(componentName);
            }
        }
        return resultArray;
    }
    // 组件加载完成后生成测试数据
    Component.onCompleted:{
        //        loadUavComponentData()
        //        loadAmmoType()
        //        loadUavModelType()
        //        //loadMountLocationContent()
        //        loadView()
        //generateTestData()
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
        anchors.fill: parent
        // 定义警告对话框

        Popup {
            id: mountLocationManagementPopup
            width: 600  // 需明确设置宽度，否则可能无法显示完整内容
            height: 400
            modal: true
            focus: true
            anchors.centerIn: Overlay.overlay // 居中显示
            closePolicy: Popup.NoAutoClose    // 完全禁用自动关闭
            // 直接引用 admin.qml
            // GetTypeManagement{  // 假设 admin.qml 的根元素是 Admin 类型
            //       id: adminPanel
            //       anchors.fill: parent
            //       managementType:uavManagementroot.managementType

            //       onClose: payloadTypeManagementPopup.close() // 连接关闭信号
            //   }
            //            MultiTextOfCombox{
            //                id:uavMountContent
            //                anchors.fill: parent
            //                loadData:mountContent
            //                onClose: mountLocationManagementPopup.close() // 连接关闭信号
            //            }
            // MultiTextDispay {
            //      id: multiTextDispay
            //      anchors.fill: parent
            //      onClose: payloadTypeManagementPopup.close() // 连接关闭信号
            // }

        }

        //
        Item {
            anchors.fill: parent
            Image {
                id: backGround
                anchors.fill: parent
                sourceSize: Qt.size(width,height)
                source: mainBackgroundSource
            }
        }

        Rectangle{
            id:rect_back
            anchors.fill: parent
            color: "transparent"

            CText{
                id:topTitle
                text: "无人机型号管理"
                anchors.top: parent.top
                anchors.topMargin: 15
                anchors.horizontalCenter: parent.horizontalCenter
                color: mainColor
                pixelSize: 28
            }

            Rectangle{
                id:rect_UAVBaseDataBack
                anchors.left: parent.left
                anchors.top: topTitle.bottom
                anchors.topMargin: 15
                width: parent.width / 5 * 3
//                anchors.right: rect_ImageShow.left
                anchors.rightMargin: 10
                height: 250
                color:"#50000000"
                radius: 5

                CText{
                    id:text_UavBaseData
                    anchors.left: parent.left
                    anchors.leftMargin: 5
                    anchors.top: parent.top
                    anchors.topMargin: 15
                    text: "基本参数"
                    color: "#4EC4FF"
                    pixelSize: 25
                    horizontalAlignment: Text.AlignLeft
                }

                CText{
                    id:ammoName
                    text: "无人机名称:"
                    anchors.left: text_UavBaseData.left
                    anchors.top: text_UavBaseData.bottom
                    anchors.topMargin: 30
                    pixelSize: 20
                    width: pixelSize * 5.5
                    horizontalAlignment: Text.AlignLeft
                    color: mainColor
                }

                Item{
                    id:item_NameInput
                    width: (parent.width / 4) - ammoName.width
                    height: 20
                    anchors.left:ammoName.right
                    anchors.top: ammoName.top
                    anchors.topMargin: -5
                    TextInput{
                        id:uavNameText
                        anchors.fill: parent
                        color:"#ffffffff"
                        font.family:ammoName.family
                        font.pixelSize:(18)
                        selectByMouse: true
                        selectionColor: "#ffcc8800"
                        clip: true
                        validator: RegExpValidator {
                            regExp: /[^\s]*/  // 不允许任何空格
                        }
                        onTextChanged: {
                            if(text != "")
                            {

                            }
                        }
                    }
                    Rectangle{
                        width: parent.width
                        height: (2)
                        anchors.left: parent.left
                        anchors.bottom: parent.bottom
                        color:mainColor
                    }
                }

                Label{
                    id:uavType
                    text: "无人机类型:"
                    anchors.left: item_NameInput.right
                    anchors.leftMargin: 10
                    anchors.verticalCenter: ammoName.verticalCenter
                    font.pixelSize: 20
                    font.bold: true
                    color: mainColor
                }

                CButton{
                    id:comp_DamageFactorType
                    width: 180
                    height: 36
                    color:"#ffddaa00"
                    borderColor: "#ffddaa00"
                    borderHigtColor: "#ffeebb22"
                    anchors.left: uavType.right
                    anchors.verticalCenter: uavType.verticalCenter
                    pixelSize: 20
                    text:{
                        if(iUavType < 0)
                        {
                            return "侦察无人机"
                        }
                        else
                        {
                            if(listmodel_Box.count > 0)
                                listmodel_Box.get(iUavType).m_TypeName
                        }
                    }
                    onClicked: {
                        view_List_TypeSelect.visible = !view_List_TypeSelect.visible
                    }
                }

                Label{
                    id:uavId
                    text: "无人机型号:"
                    anchors.left: comp_DamageFactorType.right
                    anchors.leftMargin: 10
                    anchors.verticalCenter: ammoName.verticalCenter
                    font.pixelSize: 20
                    font.bold: true
                    color: mainColor
                }

                CButton{
                    id:comp_uavId
                    width: 180
                    height: 36
                    color:"#ffddaa00"
                    borderColor: "#ffddaa00"
                    borderHigtColor: "#ffeebb22"
                    anchors.left: uavId.right
                    anchors.verticalCenter: uavId.verticalCenter
                    pixelSize: 20
                    text:{
                        if(iUavID < 0)
                        {
                            return "型号1"
                        }
                        else
                        {
                            if(listmodel_Box_uavId.count > 0)
                                listmodel_Box_uavId.get(iUavID).m_TypeName
                        }
                    }
                    onClicked: {
                        view_List_uavIdSelect.visible = !view_List_uavIdSelect.visible
                    }
                }

                Rectangle{
                    id:rect_UAVBaseData
                    color: "transparent"
                    anchors.left: ammoName.left
                    anchors.top: ammoName.bottom
                    anchors.topMargin: 20
                    anchors.right: parent.right
                    anchors.rightMargin: 5
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 5
                    border.width: 0
                    border.color: mainColor

                    Rectangle {
                        id: rect_UavLength
                        height: 20
                        color: "transparent"
                        anchors.left: parent.left
                        anchors.leftMargin: 5
                        anchors.top: parent.top
                        anchors.topMargin: 15
                        width:( parent.width ) - 10

                        CTextInput{
                            id:uavLengthText
                            anchors.left: parent.left
                            anchors.leftMargin: 5
                            anchors.top: parent.top
                            anchors.topMargin: 5
                            title: "机长(m):"
                            pixelSize: 18
                            titleWidth: pixelSize * 4
                            width: 160
                            height: 30
                        }

                        CTextInput{
                            id:uavWidthText
                            anchors.left: uavLengthText.left
                            anchors.top: uavLengthText.bottom
                            anchors.topMargin: 10
                            title: "翼展(m):"
                            pixelSize: 18
                            titleWidth: pixelSize * 4
                            width: 160
                            height: 30
                        }

                        CTextInput{
                            id:uavHeightText
                            anchors.left: uavWidthText.left
                            anchors.top: uavWidthText.bottom
                            anchors.topMargin: 10
                            title: "机高(m):"
                            pixelSize: 18
                            titleWidth: pixelSize * 4
                            width: 160
                            height: 30
                        }

                        CTextInput{
                            id:uavFlightDistance
                            anchors.left: uavHeightText.left
                            anchors.top: uavHeightText.bottom
                            anchors.topMargin: 10
                            title: "航程(km):"
                            pixelSize: 18
                            titleWidth: pixelSize * 4.5
                            width: 160
                            height: 30
                        }

                        CTextInput{
                            id:uavFlightTime
                            anchors.left: uavLengthText.right
                            anchors.leftMargin: 15
                            anchors.top: uavLengthText.top
                            title: "航时(h):"
                            pixelSize: 18
                            titleWidth: pixelSize * 4
                            width: 160
                            height: 30
                        }

                        CTextInput{
                            id:uavOperatioanalRadius
                            anchors.left: uavFlightTime.left
                            anchors.top: uavFlightTime.bottom
                            anchors.topMargin: 10
                            title: "作战半径(m):"
                            pixelSize: 18
                            titleWidth: pixelSize * 5.5
                            width: 160
                            height: 30
                        }

                        CTextInput{
                            id:uavTakeoffDistanceValue
                            anchors.left: uavFlightTime.right
                            anchors.leftMargin: 15
                            anchors.top: uavFlightTime.top
                            title: "起飞滑跑距离(m):"
                            pixelSize: 18
                            titleWidth: pixelSize * 8
                            width: 220
                            height: 30
                        }

                        CTextInput{
                            id:uavLandDistanceValue
                            anchors.left: uavTakeoffDistanceValue.left
                            anchors.top: uavTakeoffDistanceValue.bottom
                            anchors.topMargin: 10
                            title: "着陆滑跑距离(m):"
                            pixelSize: 18
                            titleWidth: pixelSize * 8
                            width: 220
                            height: 30
                        }

                        CTextInput{
                            id:uavTurningRadiusMin
                            anchors.left: uavLandDistanceValue.left
                            anchors.top: uavLandDistanceValue.bottom
                            anchors.topMargin: 10
                            title: "最小转弯半径(m):"
                            pixelSize: 18
                            titleWidth: pixelSize * 8
                            width: 220
                            height: 30
                        }

                        CTextInput{
                            id:uavTurningRadiusMax
                            anchors.left: uavTurningRadiusMin.left
                            anchors.top: uavTurningRadiusMin.bottom
                            anchors.topMargin: 10
                            title: "最大转弯半径(m):"
                            pixelSize: 18
                            titleWidth: pixelSize * 8
                            width: 220
                            height: 30
                        }

                        CTextInput{
                            id:uavFlightSpeedMin
                            anchors.left: uavTakeoffDistanceValue.right
                            anchors.leftMargin: 15
                            anchors.top: uavTakeoffDistanceValue.top
                            title: "最小飞行速度(Km/h):"
                            pixelSize: 18
                            titleWidth: pixelSize * 9.5
                            width: 240
                            height: 30
                        }

                        CTextInput{
                            id:uavFlightSpeedMax
                            anchors.left: uavFlightSpeedMin.left
                            anchors.top: uavFlightSpeedMin.bottom
                            anchors.topMargin: 10
                            title: "最大飞行速度(Km/h):"
                            pixelSize: 18
                            titleWidth: pixelSize * 9.5
                            width: 240
                            height: 30
                        }

                        CTextInput{
                            id:uavFlightHeightMin
                            anchors.left: uavFlightSpeedMax.left
                            anchors.top: uavFlightSpeedMax.bottom
                            anchors.topMargin: 10
                            title: "最小飞行高度(m):"
                            pixelSize: 18
                            titleWidth: pixelSize * 8
                            width: 240
                            height: 30
                        }

                        CTextInput{
                            id:uavFlightHeightMax
                            anchors.left: uavFlightHeightMin.left
                            anchors.top: uavFlightHeightMin.bottom
                            anchors.topMargin: 10
                            title: "最大飞行高度(m):"
                            pixelSize: 18
                            titleWidth: pixelSize * 8
                            width: 240
                            height: 30
                        }

                    }

                }
                //显示区域
                ListView{
                    id:view_List_TypeSelect
                    width: comp_DamageFactorType.width
                    height: comp_DamageFactorType.height * 5
                    anchors.left: comp_DamageFactorType.left
                    anchors.leftMargin: comp_DamageFactorType.width/2 - width/2
                    anchors.top: comp_DamageFactorType.bottom
                    anchors.topMargin: 2
                    visible: false
                    clip: true
                    model:ListModel{
                        id:listmodel_Box
                    }
                    delegate:Component{
                        Item{
                            id:item_Delegate
                            width: view_List_TypeSelect.width
                            height: 36
                            CButton{
                                id:comp_TypeBtn
                                anchors.fill: parent
                                text:m_TypeName
                                color:"#ffddaa00"
                                borderColor: "#ffddaa00"
                                pixelSize: 18
                                onClicked: {
                                    view_List_TypeSelect.visible = false
                                    iUavType = index
                                    m_SelectState = !m_SelectState
                                }
                            }
                        }
                    }
                    Component.onCompleted: {
                        listmodel_Box.append({m_PlanNumber:0,m_SelectState:false,m_TypeName:"侦察无人机"})
                        listmodel_Box.append({m_PlanNumber:1,m_SelectState:false,m_TypeName:"攻击无人机"})
                        listmodel_Box.append({m_PlanNumber:2,m_SelectState:false,m_TypeName:"查打一体无人机"})
                    }
                }
                //显示区域
                ListView{
                    id:view_List_uavIdSelect
                    width: comp_uavId.width
                    height: comp_uavId.height * 5
                    anchors.left: comp_uavId.left
                    anchors.leftMargin: comp_uavId.width/2 - width/2
                    anchors.top: comp_uavId.bottom
                    anchors.topMargin: 2
                    visible: false
                    clip: true
                    model:ListModel{
                        id:listmodel_Box_uavId
                    }
                    delegate:Component{
                        Item{
                            id:item_Delegate
                            width: view_List_uavIdSelect.width
                            height: 36
                            CButton{
                                id:comp_TypeBtn
                                anchors.fill: parent
                                text:m_TypeName
                                color:"#ffddaa00"
                                borderColor: "#ffddaa00"
                                pixelSize: 18
                                onClicked: {
                                    view_List_uavIdSelect.visible = false
                                    iUavID = index
                                    m_SelectState = !m_SelectState
                                }
                            }
                        }
                    }
                    Component.onCompleted: {
                        listmodel_Box_uavId.append({m_PlanNumber:0,m_SelectState:false,m_TypeName:"型号1"})
                        listmodel_Box_uavId.append({m_PlanNumber:1,m_SelectState:false,m_TypeName:"型号2"})
                        listmodel_Box_uavId.append({m_PlanNumber:2,m_SelectState:false,m_TypeName:"型号3"})
                    }
                }

            }

            Rectangle{
                id:rect_UavHangingData
                anchors.left: rect_UAVBaseDataBack.left
                anchors.top: rect_UAVBaseDataBack.bottom
                anchors.topMargin: 10
                width:rect_UAVBaseDataBack.width
                height: 180
                color:"#50000000"
                radius: 10
                z:1

                CText{
                    id:text_UavHaning
                    anchors.left: parent.left
                    anchors.leftMargin: 5
                    anchors.top: parent.top
                    anchors.topMargin: 15
                    text: "挂载参数"
                    color: "#4EC4FF"
                    pixelSize: 25
                    horizontalAlignment: Text.AlignLeft
                }

                Label{
                    id:uavLoadammo
                    text: "挂载弹药类型:"
                    anchors.left: text_UavHaning.left
                    anchors.top: text_UavHaning.bottom
                    anchors.topMargin: 30
                    font.pixelSize: 20
                    font.bold: true
                    color: mainColor
                }

                CButton{
                    id:comp_uavLoadammo
                    width: 120
                    height: 36
                    color:"#ffddaa00"
                    borderColor: "#ffddaa00"
                    borderHigtColor: "#ffeebb22"
                    anchors.left: uavLoadammo.right
                    anchors.verticalCenter: uavLoadammo.verticalCenter
                    pixelSize: 20
                    text:{
                        if(uavLoadammoSelect < 0)
                        {
                            return "炸弹"
                        }
                        else
                        {
                            if(listmodel_Box_uavLoadammo.count > 0)
                                listmodel_Box_uavLoadammo.get(uavLoadammoSelect).m_TypeName
                        }
                    }
                    onClicked: {
                        view_List_uavLoadammo.visible = !view_List_uavLoadammo.visible
                    }
                }

                Label{
                    id:uavHangingLocation
                    text: "挂载弹药类型:"
                    font.pixelSize: 20
                    anchors.left: uavLoadammo.left
                    anchors.top: uavLoadammo.bottom
                    anchors.topMargin: 25
                    font.bold: true
                    color: mainColor
                }

                CButton{
                    id:comp_uavHangingLocation
                    width: 120
                    height: 36
                    color:"#ffddaa00"
                    borderColor: "#ffddaa00"
                    borderHigtColor: "#ffeebb22"
                    anchors.left: uavHangingLocation.right
                    anchors.verticalCenter: uavHangingLocation.verticalCenter
                    pixelSize: 20
                    text:"请选择"
                    onClicked: {
                        //
                    }
                }

                Label{
                    id:uavInvestigationPayloadType
                    text: "侦察载荷类型:"
                    anchors.left: comp_uavLoadammo.right
                    anchors.leftMargin: 10
                    anchors.verticalCenter: uavLoadammo.verticalCenter
                    font.pixelSize: 20
                    font.bold: true
                    color: mainColor
                }

                CButton{
                    id:comp_uavInvestigationPayloadType
                    width: 120
                    height: 36
                    color:"#ffddaa00"
                    borderColor: "#ffddaa00"
                    borderHigtColor: "#ffeebb22"
                    anchors.left: uavInvestigationPayloadType.right
                    anchors.verticalCenter: uavInvestigationPayloadType.verticalCenter
                    pixelSize: 20
                    text:{
                        if(iuavInvestigationPayloadType < 0)
                        {
                            return "无载荷"
                        }
                        else
                        {
                            if(listmodel_Box_InvestigationPayloadType.count > 0)
                                listmodel_Box_InvestigationPayloadType.get(iuavInvestigationPayloadType).m_TypeName
                        }
                    }
                    onClicked: {
                        view_List_InvestigationPayloadType.visible = !view_List_InvestigationPayloadType.visible
                    }
                }

                CTextInput{
                    id:uavLoadReconnaissanceRangeValue
                    anchors.left: uavInvestigationPayloadType.left
                    anchors.top: uavInvestigationPayloadType.bottom
                    anchors.topMargin: 20
                    title: "载荷侦察范围(Km):"
                    pixelSize: 18
                    titleWidth: pixelSize * 8.5
                    width: 250
                    height: 30
                }

                CTextInput{
                    id:uavLoadReconnaissanceAccuracyValue
                    anchors.left: uavLoadReconnaissanceRangeValue.left
                    anchors.top: uavLoadReconnaissanceRangeValue.bottom
                    anchors.topMargin: 20
                    title: "载荷侦察精度(m):"
                    pixelSize: 18
                    titleWidth: pixelSize * 8
                    width: 250
                    height: 30
                }


                Label{
                    id:uavBombingmethod
                    text: "攻击方式:"
                    anchors.left: comp_uavInvestigationPayloadType.right
                    anchors.leftMargin: 10
                    anchors.verticalCenter: comp_uavInvestigationPayloadType.verticalCenter
                    font.pixelSize: 20
                    font.bold: true
                    color: mainColor
                }

                CButton{
                    id:comp_uavBombingmethod
                    width: 200
                    height: 36
                    color:"#ffddaa00"
                    borderColor: "#ffddaa00"
                    borderHigtColor: "#ffeebb22"
                    anchors.left: uavBombingmethod.right
                    anchors.verticalCenter: uavBombingmethod.verticalCenter
                    pixelSize: 20
                    text:{
                        if(iuavBombingmethod < 0)
                        {
                            return "非精确制导"
                        }
                        else
                        {
                            if(listmodel_Box_uavBombingmethod.count > 0)
                                listmodel_Box_uavBombingmethod.get(iuavBombingmethod).m_TypeName
                        }
                    }
                    onClicked: {
                        view_List_uavBombingmethod.visible = !view_List_uavBombingmethod.visible
                    }
                }

                CTextInput{
                    id:uavAttackaccuracyValue
                    anchors.left: uavBombingmethod.left
                    anchors.top: uavBombingmethod.bottom
                    anchors.topMargin: 20
                    title: "攻击精度(m):"
                    pixelSize: 18
                    titleWidth: pixelSize * 6
                    anchors.right: comp_uavBombingmethod.right
                    height: 30
                }

                ListView{
                    id:view_List_uavLoadammo
                    width: comp_uavLoadammo.width
                    height: comp_uavLoadammo.height * 5
                    anchors.left: comp_uavLoadammo.left
                    anchors.leftMargin: comp_uavLoadammo.width/2 - width/2
                    anchors.top: comp_uavLoadammo.bottom
                    anchors.topMargin: 2
                    visible: false
                    clip: true
                    model:ListModel{
                        id:listmodel_Box_uavLoadammo
                    }
                    delegate:Component{
                        Item{
                            id:item_Delegate
                            width: view_List_uavLoadammo.width
                            height: 36
                            CButton{
                                id:comp_TypeBtn
                                anchors.fill: parent
                                text:m_TypeName
                                color:"#ffddaa00"
                                borderColor: "#ffddaa00"
                                pixelSize: 18
                                onClicked: {
                                    view_List_uavLoadammo.visible = false
                                    uavLoadammoSelect = index
                                    m_SelectState = !m_SelectState
                                }
                            }
                        }
                    }
                    Component.onCompleted: {
                        listmodel_Box_uavLoadammo.append({m_PlanNumber:0,m_SelectState:false,m_TypeName:"炸弹"})
                        listmodel_Box_uavLoadammo.append({m_PlanNumber:1,m_SelectState:false,m_TypeName:"制导"})
                        listmodel_Box_uavLoadammo.append({m_PlanNumber:2,m_SelectState:false,m_TypeName:"非制导"})
                    }
                }

                ListView{
                    id:view_List_InvestigationPayloadType
                    width: comp_uavInvestigationPayloadType.width
                    height: comp_uavInvestigationPayloadType.height * 5
                    anchors.left: comp_uavInvestigationPayloadType.left
                    anchors.leftMargin: comp_uavInvestigationPayloadType.width/2 - width/2
                    anchors.top: comp_uavInvestigationPayloadType.bottom
                    anchors.topMargin: 2
                    visible: false
                    clip: true
                    model:ListModel{
                        id:listmodel_Box_InvestigationPayloadType
                    }
                    delegate:Component{
                        Item{
                            id:item_Delegate
                            width: view_List_InvestigationPayloadType.width
                            height: 36
                            CButton{
                                id:comp_TypeBtn
                                anchors.fill: parent
                                text:m_TypeName
                                color:"#ffddaa00"
                                borderColor: "#ffddaa00"
                                pixelSize: 18
                                onClicked: {
                                    view_List_InvestigationPayloadType.visible = false
                                    iuavInvestigationPayloadType = index
                                    m_SelectState = !m_SelectState
                                }
                            }
                        }
                    }
                    Component.onCompleted: {
                        listmodel_Box_InvestigationPayloadType.append({m_PlanNumber:0,m_SelectState:false,m_TypeName:"无载荷"})
                        listmodel_Box_InvestigationPayloadType.append({m_PlanNumber:1,m_SelectState:false,m_TypeName:"电子侦察"})
                        listmodel_Box_InvestigationPayloadType.append({m_PlanNumber:2,m_SelectState:false,m_TypeName:"图像侦察"})
                        listmodel_Box_InvestigationPayloadType.append({m_PlanNumber:3,m_SelectState:false,m_TypeName:"气象侦察"})
                        listmodel_Box_InvestigationPayloadType.append({m_PlanNumber:4,m_SelectState:false,m_TypeName:"激光引导"})
                    }
                }

                ListView{
                    id:view_List_uavBombingmethod
                    width: comp_uavBombingmethod.width
                    height: comp_uavBombingmethod.height * 5
                    anchors.left: comp_uavBombingmethod.left
                    anchors.leftMargin: comp_uavBombingmethod.width/2 - width/2
                    anchors.top: comp_uavBombingmethod.bottom
                    anchors.topMargin: 2
                    visible: false
                    clip: true
                    model:ListModel{
                        id:listmodel_Box_uavBombingmethod
                    }
                    delegate:Component{
                        Item{
                            id:item_Delegate
                            width: view_List_uavBombingmethod.width
                            height: 36
                            CButton{
                                id:comp_TypeBtn
                                anchors.fill: parent
                                text:m_TypeName
                                color:"#ffddaa00"
                                borderColor: "#ffddaa00"
                                pixelSize: 18
                                onClicked: {
                                    view_List_uavBombingmethod.visible = false
                                    iuavBombingmethod = index
                                    m_SelectState = !m_SelectState
                                }
                            }
                        }
                    }
                    Component.onCompleted: {
                        listmodel_Box_uavBombingmethod.append({m_PlanNumber:0,m_SelectState:false,m_TypeName:"非精确制导"})
                        listmodel_Box_uavBombingmethod.append({m_PlanNumber:1,m_SelectState:false,m_TypeName:"精确制导"})
                        listmodel_Box_uavBombingmethod.append({m_PlanNumber:2,m_SelectState:false,m_TypeName:"自由落体"})
                        listmodel_Box_uavBombingmethod.append({m_PlanNumber:3,m_SelectState:false,m_TypeName:"水平轰炸反俯冲轰炸"})
                        listmodel_Box_uavBombingmethod.append({m_PlanNumber:4,m_SelectState:false,m_TypeName:"俯冲轰炸"})
                    }
                }

            }

            Rectangle{
                id:rect_UavFlightData
                anchors.left: rect_UavHangingData.left
                anchors.top: rect_UavHangingData.bottom
                anchors.topMargin: 10
                width:rect_UavHangingData.width
                height: 350
                color:"#50000000"
                radius: 10

                CText{
                    id:text_UavFlightData
                    anchors.left: parent.left
                    anchors.leftMargin: 5
                    anchors.top: parent.top
                    anchors.topMargin: 15
                    text: "飞行参数"
                    color: "#4EC4FF"
                    pixelSize: 25
                    horizontalAlignment: Text.AlignLeft
                }

                CTextInput{
                    id:uavMaximumTakeoffWeightValue
                    anchors.left: text_UavFlightData.left
                    anchors.top: text_UavFlightData.bottom
                    anchors.topMargin: 25
                    title: "最大起飞重量(Kg):"
                    pixelSize: 18
                    titleWidth: pixelSize * 8.5
                    width: 250
                    height: 30
                }

                CTextInput{
                    id:uavEmptyWeightValue
                    anchors.left: uavMaximumTakeoffWeightValue.left
                    anchors.top: uavMaximumTakeoffWeightValue.bottom
                    anchors.topMargin: 15
                    title: "空机重量(Kg):"
                    pixelSize: 18
                    titleWidth: pixelSize * 6.5
                    width: 250
                    height: 30
                }

                CTextInput{
                    id:uavMaximumFuelCapacityValue
                    anchors.left: uavEmptyWeightValue.left
                    anchors.top: uavEmptyWeightValue.bottom
                    anchors.topMargin: 15
                    title: "最大载油量(Kg):"
                    pixelSize: 18
                    titleWidth: pixelSize * 7.5
                    width: 250
                    height: 30
                }

                CTextInput{
                    id:uavMaximumExternalWeightValue
                    anchors.left: uavMaximumFuelCapacityValue.left
                    anchors.top: uavMaximumFuelCapacityValue.bottom
                    anchors.topMargin: 15
                    title: "最大外挂重量(Kg):"
                    pixelSize: 18
                    titleWidth: pixelSize * 8.5
                    width: 250
                    height: 30
                }

                CTextInput{
                    id:uavRadarCrossSectionValue
                    anchors.left: uavMaximumExternalWeightValue.left
                    anchors.top: uavMaximumExternalWeightValue.bottom
                    anchors.topMargin: 15
                    title: "雷达反射面积(m²):"
                    pixelSize: 18
                    titleWidth: pixelSize * 8.5
                    width: 250
                    height: 30
                }

                CTextInput{
                    id:uavCenterOfGravityFrontLimitValue
                    anchors.left: uavRadarCrossSectionValue.left
                    anchors.top: uavRadarCrossSectionValue.bottom
                    anchors.topMargin: 15
                    title: "重心前限(%MAC):"
                    pixelSize: 18
                    titleWidth: pixelSize * 8
                    width: 250
                    height: 30
                }

                CTextInput{
                    id:uavCenterOfGravityAfterwardLimitValue
                    anchors.left: uavCenterOfGravityFrontLimitValue.left
                    anchors.top: uavCenterOfGravityFrontLimitValue.bottom
                    anchors.topMargin: 15
                    title: "重心后限(%MAC):"
                    pixelSize: 18
                    titleWidth: pixelSize * 8
                    width: 250
                    height: 30
                }

                CTextInput{
                    id:uavMaximumGroundStartingHeightValue
                    anchors.left: uavMaximumTakeoffWeightValue.right
                    anchors.leftMargin: 15
                    anchors.top: uavMaximumTakeoffWeightValue.top
                    title: "地面最大起动高度(m):"
                    pixelSize: 18
                    titleWidth: pixelSize * 10
                    width: 270
                    height: 30
                }

                CTextInput{
                    id:uavMaximumAirStartingAltitudeValue
                    anchors.left: uavMaximumGroundStartingHeightValue.left
                    anchors.top: uavMaximumGroundStartingHeightValue.bottom
                    anchors.topMargin: 15
                    title: "空中最大起动高度(m):"
                    pixelSize: 18
                    titleWidth: pixelSize * 10
                    width: 270
                    height: 30
                }

                CTextInput{
                    id:uavLowAltitudeBreakthroughSpeedValue
                    anchors.left: uavMaximumAirStartingAltitudeValue.left
                    anchors.top: uavMaximumAirStartingAltitudeValue.bottom
                    anchors.topMargin: 15
                    title: "低空突防速度(Km/h):"
                    pixelSize: 18
                    titleWidth: pixelSize * 9.5
                    width: 270
                    height: 30
                }

                CTextInput{
                    id:uavMaximumFlightVacuumSpeedValue
                    anchors.left: uavLowAltitudeBreakthroughSpeedValue.left
                    anchors.top: uavLowAltitudeBreakthroughSpeedValue.bottom
                    anchors.topMargin: 15
                    title: "最大飞行真空速(Km/h):"
                    pixelSize: 18
                    titleWidth: pixelSize * 10.5
                    width: 270
                    height: 30
                }

                CTextInput{
                    id:uavMaximumEnduranceValue
                    anchors.left: uavMaximumFlightVacuumSpeedValue.left
                    anchors.top: uavMaximumFlightVacuumSpeedValue.bottom
                    anchors.topMargin: 15
                    title: "最大续航时间(h):"
                    pixelSize: 18
                    titleWidth: pixelSize * 8
                    width: 270
                    height: 30
                }

                CTextInput{
                    id:uavMinimumFlightMeterSpeedValue
                    anchors.left: uavMaximumEnduranceValue.left
                    anchors.top: uavMaximumEnduranceValue.bottom
                    anchors.topMargin: 15
                    title: "最小飞行表速(Km/h):"
                    pixelSize: 18
                    titleWidth: pixelSize * 9.5
                    width: 270
                    height: 30
                }

                CTextInput{
                    id:sealLevelTakeoffAndRollDistanceValue
                    anchors.left: uavMinimumFlightMeterSpeedValue.left
                    anchors.top: uavMinimumFlightMeterSpeedValue.bottom
                    anchors.topMargin: 15
                    title: "海平面起飞滑跑距离(m):"
                    pixelSize: 18
                    titleWidth: pixelSize * 11
                    width: 270
                    height: 30
                }

                CTextInput{
                    id:sealLevelLandingAndRollDistanceValue
                    anchors.left: uavMaximumGroundStartingHeightValue.right
                    anchors.leftMargin: 15
                    anchors.top: uavMaximumGroundStartingHeightValue.top
                    title: "海平面着陆滑跑距离(m):"
                    pixelSize: 18
                    titleWidth: pixelSize * 11
                    width: 270
                    height: 30
                }

                CTextInput{
                    id:cruiseAltitudeReconnaissanceConfigurationValue
                    anchors.left: sealLevelLandingAndRollDistanceValue.left
                    anchors.top: sealLevelLandingAndRollDistanceValue.bottom
                    anchors.topMargin: 15
                    title: "侦察构型巡航高度(m):"
                    pixelSize: 18
                    titleWidth: pixelSize * 10
                    width: 270
                    height: 30
                }

                CTextInput{
                    id:cruiseAltitudeFullExternalConfigurationValue
                    anchors.left: cruiseAltitudeReconnaissanceConfigurationValue.left
                    anchors.top: cruiseAltitudeReconnaissanceConfigurationValue.bottom
                    anchors.topMargin: 15
                    title: "满外挂构型巡航高度(m):"
                    pixelSize: 18
                    titleWidth: pixelSize * 11
                    width: 270
                    height: 30
                }

                CTextInput{
                    id:uavCeilingValue
                    anchors.left: cruiseAltitudeFullExternalConfigurationValue.left
                    anchors.top: cruiseAltitudeFullExternalConfigurationValue.bottom
                    anchors.topMargin: 15
                    title: "无人机升限(m):"
                    pixelSize: 18
                    titleWidth: pixelSize * 7
                    width: 270
                    height: 30
                }

                Label{
                    id:uavRecoverymode
                    text: "回收方式:"
                    anchors.left: uavCeilingValue.left
                    anchors.top: uavCeilingValue.bottom
                    anchors.topMargin: 18
                    font.pixelSize: 20
                    font.bold: true
                    color: mainColor
                }

                CButton{
                    id:comp_uavRecoverymode
                    width: 150
                    height: 36
                    color:"#ffddaa00"
                    borderColor: "#ffddaa00"
                    borderHigtColor: "#ffeebb22"
                    anchors.left: uavRecoverymode.right
                    anchors.verticalCenter: uavRecoverymode.verticalCenter
                    pixelSize: 20
                    text:{
                        if(iuavRecoverymode < 0)
                        {
                            return "不可回收"
                        }
                        else
                        {
                            if(listmodel_Box_uavRecoverymode.count > 0)
                                listmodel_Box_uavRecoverymode.get(iuavRecoverymode).m_TypeName
                        }
                    }
                    onClicked: {
                        view_List_uavRecoverymode.visible = !view_List_uavRecoverymode.visible
                    }
                }


                Label{
                    id:operationMode
                    text: "操控方式:"
                    anchors.left: uavRecoverymode.left
                    anchors.top: uavRecoverymode.bottom
                    anchors.topMargin: 20
                    font.pixelSize: 20
                    font.bold: true
                    color: mainColor
                }

                CButton{
                    id:comp_operationMode
                    width: 150
                    height: 36
                    color:"#ffddaa00"
                    borderColor: "#ffddaa00"
                    borderHigtColor: "#ffeebb22"
                    anchors.left: operationMode.right
                    anchors.verticalCenter: operationMode.verticalCenter
                    pixelSize: 20
                    text:{
                        if(ioperationMode < 0)
                        {
                            return "指令模式"
                        }
                        else
                        {
                            if(listmodel_Box_operationMode.count > 0)
                                listmodel_Box_operationMode.get(ioperationMode).m_TypeName
                        }
                    }
                    onClicked: {
                        view_List_operationMode.visible = !view_List_operationMode.visible
                    }
                }

                ListView{
                    id:view_List_operationMode
                    width: comp_operationMode.width
                    height: comp_operationMode.height * 5
                    anchors.left: comp_operationMode.left
                    anchors.leftMargin: comp_operationMode.width/2 - width/2
                    anchors.top: comp_operationMode.bottom
                    anchors.topMargin: 2
                    visible: false
                    clip: true
                    model:ListModel{
                        id:listmodel_Box_operationMode
                    }
                    delegate:Component{
                        Item{
                            id:item_Delegate
                            width: view_List_operationMode.width
                            height: 36
                            CButton{
                                id:comp_TypeBtn
                                anchors.fill: parent
                                text:m_TypeName
                                color:"#ffddaa00"
                                borderColor: "#ffddaa00"
                                pixelSize: 18
                                onClicked: {
                                    view_List_operationMode.visible = false
                                    ioperationMode = index
                                    m_SelectState = !m_SelectState
                                }
                            }
                        }
                    }
                    Component.onCompleted: {
                        listmodel_Box_operationMode.append({m_PlanNumber:0,m_SelectState:false,m_TypeName:"指令模式"})
                        listmodel_Box_operationMode.append({m_PlanNumber:1,m_SelectState:false,m_TypeName:"修正模式"})
                        listmodel_Box_operationMode.append({m_PlanNumber:2,m_SelectState:false,m_TypeName:"自主控制模式"})
                        listmodel_Box_operationMode.append({m_PlanNumber:3,m_SelectState:false,m_TypeName:"遥控指令模式"})
                    }
                }

                ListView{
                    id:view_List_uavRecoverymode
                    width: comp_uavRecoverymode.width
                    height: comp_uavRecoverymode.height * 5
                    anchors.left: comp_uavRecoverymode.left
                    anchors.leftMargin: comp_uavRecoverymode.width/2 - width/2
                    anchors.top: comp_uavRecoverymode.bottom
                    anchors.topMargin: 2
                    visible: false
                    clip: true
                    model:ListModel{
                        id:listmodel_Box_uavRecoverymode
                    }
                    delegate:Component{
                        Item{
                            id:item_Delegate
                            width: view_List_uavRecoverymode.width
                            height: 36
                            CButton{
                                id:comp_TypeBtn
                                anchors.fill: parent
                                text:m_TypeName
                                color:"#ffddaa00"
                                borderColor: "#ffddaa00"
                                pixelSize: 18
                                onClicked: {
                                    view_List_uavRecoverymode.visible = false
                                    iuavRecoverymode = index
                                    m_SelectState = !m_SelectState
                                }
                            }
                        }
                    }
                    Component.onCompleted: {
                        listmodel_Box_uavRecoverymode.append({m_PlanNumber:0,m_SelectState:false,m_TypeName:"不可回收"})
                        listmodel_Box_uavRecoverymode.append({m_PlanNumber:1,m_SelectState:false,m_TypeName:"伞降"})
                        listmodel_Box_uavRecoverymode.append({m_PlanNumber:2,m_SelectState:false,m_TypeName:"滑跑着陆"})
                        listmodel_Box_uavRecoverymode.append({m_PlanNumber:3,m_SelectState:false,m_TypeName:"垂直着陆"})
                    }
                }

            }

            Rectangle {
                id: rect_ImageShow
                visible: true
                height: 600
                anchors.left: rect_UAVBaseDataBack.right
                anchors.leftMargin: 10
                anchors.top: topTitle.bottom
                anchors.topMargin: 15
                anchors.right: parent.right
                anchors.rightMargin: 10
                color: "#ECF2FE"
                border.color: "#BDBDBD"

                Image {
                    id: ammunitionImg
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    width: parent.width - btn_Cancel.width
                }
                CText {
                    anchors.centerIn: parent
                    text: "图片展示区域"
                    color: "#9E9E9E"
                }
                CButton{
                    id:btn_Cancel
                    anchors.top: parent.bottom
                    anchors.topMargin: 5
                    anchors.right: parent.right
                    anchors.rightMargin: 5
                    height: pixelSize * 2
                    width: pixelSize * 4
                    text: "取消"
                    onClicked: {

                        backUavRecord()
                        controlUav.visible = false

                     }
                }

                CButton{
                    id:btn_Save
                    anchors.top: parent.bottom
                    anchors.topMargin: 5
                    anchors.right: btn_Cancel.left
                    anchors.rightMargin: 10
                    height: pixelSize * 2
                    width: pixelSize * 4
                    text: "保存"
                    onClicked: {

                        backUavRecord()
                        controlUav.visible = false

                     }
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
            loadUavModelData()
            // writeControl(false)
            // saveButton.enabled = false
            // cancleButton.enabled = false
            console.log("addUavDataView"+processInfo.loadViewType)
        }else if(processInfo.loadViewType === "update"){
            loadUavModelData()
            // writeControl(true)
            saveButton.text = "编辑"
            // console.log("addUavDataView"+processInfo.loadViewType)
        }else{
            console.log("processInfo.loadViewType Unknown")
        }
    }
    // 提取 ammoId、ammoName 和 recordId 并封装成数组
    function extractAmmoData(data) {
        return data.map(item => ({
                                     ammoId: item.ammoId,
                                     ammoName: item.ammoName,
                                     recordId: item.recordId
                                 }));
    }
    // ammoName并封装成数组
    // function extractAmmoNameData(data) {
    //     return data.map(item => ({
    //         ammoName: item.ammoName
    //     }));
    // }
    function extractAmmoNameData(data) {
        return data.map(item => item.ammoName);
    }
    //查找飞机型号对应的id并保存
    function findRecordIdByName(dataArray, targetName) {
        // 参数有效性校验
        if (!Array.isArray(dataArray)) {
            console.error("输入参数必须是数组类型");
            return "";
        }

        let foundRecordId = "";
        let foundCount = 0;

        // 遍历数组（带索引）
        for (let i = 0; i < dataArray.length; i++) {
            const item = dataArray[i];

            // 安全检查对象结构
            if (!item || typeof item !== "object") {
                console.warn(`索引 ${i} 的元素不是有效对象`);
                continue;
            }

            // 标准化比较（去除首尾空格）
            const currentName = (item.uavComponeName || "").toString().trim();
            const target = targetName.toString().trim();

            // 精确匹配
            if (currentName === target) {
                foundRecordId = item.recordId || "";
                foundCount++;

                // 打印详细信息
                console.log(
                            "匹配项 [索引]", i,
                            "recordId:", foundRecordId,
                            "完整对象:", JSON.stringify(item)
                            );
            }
        }

        // 处理匹配结果
        switch (foundCount) {
        case 0:
            console.warn(`未找到名称匹配'${targetName}'的记录`);
            return "";
        case 1:
            console.log("找到唯一匹配 recordId:", foundRecordId);
            return foundRecordId;
        default:
            console.error(`发现 ${foundCount} 个重复名称'${targetName}'`);
            return foundRecordId + " (存在重复)";
        }
    }

    function loadUavComponentData(){
        var uavBombWay = uavBombingMethodDaoModel.selectUavModelBombingMethodAllData()
        var uavPayloadType = uavModelLoadTypeDaoModel.selectUavModelLoadTypeAllData()
        var uavRecoveryWay = uavModelRecoveryModeDaoModel.selectModelRecoveryModeAllData()
        var uavOperationWay = uavModelOperationWayDaoModel.selectModelOperationWayAllData()
        addUavModelData.bombWayOrigi = uavBombWay
        addUavModelData.payloadTypeOrigi = uavPayloadType
        addUavModelData.recoveryWayOrigi = uavRecoveryWay
        addUavModelData.opreationWayOrigi = uavOperationWay

        console.log("uavBombWay"+JSON.stringify(uavBombWay))
        var bombWaynames = extractNames(uavBombWay);
        addUavModelData.bombWay = bombWaynames
        var payloadTypeNames = extractNames(uavPayloadType)
        var recoveryWayNames = extractNames(uavRecoveryWay)
        var operationWayNames = extractNames(uavOperationWay)
        //console.log("提取的名称数组:", names +"addUavModelData.bombWay"+addUavModelData.bombWay);
        addUavModelData.payloadType = payloadTypeNames
        addUavModelData.recoveryWay = recoveryWayNames
        addUavModelData.operationWay = operationWayNames
        console.log("testloadUavComponentData")
    }
    // 提取 uavComponeName 并封装成数组
    function extractNames(data) {
        return data.map(item => item.uavComponeName);
    }
    function loadMountLocationContent(){
        if(processInfo.loadViewType === "addUavData"){
            var receiveData = uavMountLocationDaoTableModel.selectUavMountLocationAllData()
            console.log("MultiTextOfCombox+:", JSON.stringify(receiveData, null, 2));
            addUavModelData.mountContent = receiveData
            // 打印当前函数的名称
            console.log("当前函数名称:", arguments.callee.name);
            console.log("addUavDataView"+processInfo.loadViewType)

        }else if(processInfo.loadViewType === "query"){

            console.log("addUavDataView"+processInfo.loadViewType)
        }else if(processInfo.loadViewType === "update"){

            console.log("addUavDataView"+processInfo.loadViewType)
        }else{
            console.log("processInfo.loadViewType Unknown")
        }
    }

    function loadUavModelData(){
        var uavAllData = processInfo.uavModelJsonStr
        var uavDataStr = JSON.stringify(uavAllData)
        console.log("loadUavModelData"+uavDataStr)
        var  selectUavData = uavModelDao.selectSomeUavModelDate(uavDataStr)
        console.log("selectUavData"+JSON.stringify(selectUavData))
        // if (selectUavData && selectUavData.payload_type) {
        //         var payloadTypes = selectUavData.payload_type.split(",");
        //         console.log("uavInvestigationPayloadTypeMultiComBox: "+payloadTypes)
        //         uavInvestigationPayloadTypeMultiComBox.selectedItems = payloadTypes.slice();
        //     }
        //对于Combox组件加载数据
        const uavTypeSelecttargetIndex = uavTypeSelect.model.indexOf(selectUavData.uavType);
        console.log("索引值:", uavTypeSelecttargetIndex); // 输出 0
        if (uavTypeSelecttargetIndex !== -1) {
            uavTypeSelect.currentIndex = uavTypeSelecttargetIndex;
        }
        var imageUrlStr = "file:///"+selectUavData.image_url
        console.log("imageUrlStr"+imageUrlStr)
        uavImg.source = imageUrlStr
        //加载文本数据
        //uavHangingLocationValue.text = selectUavData.hangingCapacity
        uavNameText.text = selectUavData.uavName
        //uavIdText.text = selectUavData.uavId
        uavLengthText.text = selectUavData.uavLength
        uavWidthText.text = selectUavData.uavWidth
        uavHeightText.text = selectUavData.uavHeight

        uavFlightHeightMin.text = selectUavData.flight_height_min
        uavFlightHeightMax.text = selectUavData.flight_height_max
        uavFlightSpeedMin.text = selectUavData.flight_speed_min
        uavFlightSpeedMax.text = selectUavData.flight_speed_max
        uavTurningRadiusMin.text = selectUavData.turn_radius_min
        uavTurningRadiusMax.text = selectUavData.turn_radius_max
        uavFlightDistance.text = selectUavData.flight_distance_max
        //uavRecoveryModeResult.currentText = selectUavData.recovery_mode
        uavFlightTime.text = selectUavData.flight_time_max
        uavTakeoffDistanceValue.text = selectUavData.takeoff_distance
        uavLandDistanceValue.text = selectUavData.landing_distance
        uavOperatioanalRadius.text = selectUavData.combat_radius
        uavLoadReconnaissanceRangeValue.text = selectUavData.recon_range_max
        uavLoadReconnaissanceAccuracyValue.text = selectUavData.recon_accuracy
        uavLowAltitudeBreakthroughSpeedValue.text = selectUavData.low_alt_speed
        uavAttackaccuracyValue.text = selectUavData.attack_accuracy
        uavRadarCrossSectionValue.text = selectUavData.rcs
        uavCenterOfGravityFrontLimitValue.text = selectUavData.cg_front_limit
        uavCenterOfGravityAfterwardLimitValue.text = selectUavData.cg_rear_limit
        uavMaximumTakeoffWeightValue.text = selectUavData.max_takeoff_weight
        uavEmptyWeightValue.text = selectUavData.empty_weight
        uavMaximumFuelCapacityValue.text = selectUavData.max_fuel
        uavMaximumExternalWeightValue.text = selectUavData.max_external_weight
        uavCeilingValue.text = selectUavData.ceiling
        uavMaximumAirStartingAltitudeValue.text = selectUavData.air_start_alt
        uavMaximumGroundStartingHeightValue.text = selectUavData.ground_start_alt
        uavMaximumEnduranceValue.text = selectUavData.endurance
        uavMaximumFlightVacuumSpeedValue.text = selectUavData.max_vacuum_speed
        uavMinimumFlightMeterSpeedValue.text = selectUavData.min_meter_speed
        sealLevelTakeoffAndRollDistanceValue.text = selectUavData.sea_takeoff_roll
        sealLevelLandingAndRollDistanceValue.text = selectUavData.sea_landing_roll
        cruiseAltitudeReconnaissanceConfigurationValue.text = selectUavData.recon_cruise_alt
        cruiseAltitudeFullExternalConfigurationValue.text = selectUavData.full_external_cruise_alt
    }
    // 提取 load_ammo_type 并格式化为数组
    function extractLoadAmmoType(data) {
        try {
            // 解析 JSON 字符串
            var loadAmmoType = JSON.parse(data.load_ammo_type);
            // 提取并格式化数据
            return loadAmmoType.map(item => {
                                        var parts = item.split(":");
                                        return `${parts[0]}:${parts[1]}`;
                                    });
        } catch (e) {
            console.log("Error parsing load_ammo_type:", e);
            return [];
        }
    }
    // 提取数组中冒号后面的数字
    function extractAmmoIds(data, extraName) {
        try {
            // 修正3：使用方括号访问对象属性
            var loadAmmoType = JSON.parse(data[extraName])//由于传入的是Json字符串，需要parse转化成数组
            console.log("loadAmmoTypeArray"+JSON.stringify(loadAmmoType))

            if (!Array.isArray(loadAmmoType)) {
                console.log(extraName + "不是数组格式")
                return []
            }

            return loadAmmoType.map(item => {
                                        let parts = item.split(":")
                                        if (parts.length !== 2) {
                                            console.log("格式错误的项:", item)
                                            return null
                                        }
                                        return parseInt(parts[1].trim())
                                    }).filter(num => !isNaN(num))

        } catch (e) {
            console.log("处理" + extraName + "时发生错误:", e)
            return []
        }
    }
    // 在QML中定义函数使用Id查找名称
    function getAmmoNamesByIds(ammoArray, idArray) {
        // 创建哈希表加速查找（recordId作为key）
        const ammoMap = {}
        ammoArray.forEach(ammo => {
                              // 统一转换为数字类型进行比较
                              const id = parseInt(ammo.recordId)
                              ammoMap[id] = ammo.ammoName
                          })

        // 过滤并返回有效弹药名称
        return idArray.map(id => {
                               return ammoMap[id] || null
                           }).filter(name => name !== null)
    }
    function loadMultiSelect(selectUavData){

        //var selectUavData = uavModelDao.selectSomeUavModelDate(uavDataStr)
        var testStr = JSON.stringify(selectUavData)
        console.log("loadAmmoTypeArrayselectUavData"+JSON.stringify(selectUavData))
        var loadAmmoTypeArray = extractAmmoIds(selectUavData,"load_ammo_type")//,
        var investigationPayLoadArray = extractAmmoIds(selectUavData,"payload_type")
        var bombMethodArray = extractAmmoIds(selectUavData,"bomb_method")
        var recoveryWayArray = extractAmmoIds(selectUavData,"recovery_mode")
        var operationWayArray = extractAmmoIds(selectUavData,"operation_method")
        console.log("loadAmmoTypeArray"+JSON.stringify(loadAmmoTypeArray))
        var ammoType = ammoDaoModel.selectAmmoAllData()
        var uavBombWay = uavBombingMethodDaoModel.selectUavModelBombingMethodAllData()
        var uavPayloadType = uavModelLoadTypeDaoModel.selectUavModelLoadTypeAllData()
        var uavRecoveryWay = uavModelRecoveryModeDaoModel.selectModelRecoveryModeAllData()
        var uavOperationWay = uavModelOperationWayDaoModel.selectModelOperationWayAllData()
        console.log("loadAmmoAllData"+JSON.stringify(ammoType))
        var loadAmmoTypeStr = getAmmoNamesByIds(ammoType,loadAmmoTypeArray)
        console.log("查找出来的值"+JSON.stringify(loadAmmoTypeStr))
        if (selectUavData && selectUavData.load_ammo_type) {
            // var payloadTypes = selectUavData.load_ammo_type.split(",");
            // console.log("uavInvestigationPayloadTypeMultiComBox: "+payloadTypes)
            //uavInvestigationPayloadTypeMultiComBox.selectedItems = payloadTypes.slice();
            uavInvestigationPayloadTypeMultiComBox.selectedItems = loadAmmoTypeStr.slice()
            console.log("uavInvestigationPayloadTypeMultiComBox.selectedItems"+uavInvestigationPayloadTypeMultiComBox.selectedItems)
        }
        if (selectUavData && selectUavData.payload_type) {
            var payloadTypes = selectUavData.payload_type.split(",");
            console.log("uavInvestigationPayloadTypeMultiComBox: "+payloadTypes)
            uavInvestigationPayloadTypeMultiComBox.selectedItems = payloadTypes.slice();
        }
        if (selectUavData && selectUavData.bomb_method) {
            var bombMethod = selectUavData.bomb_method.split(",");
            console.log("uavInvestigationPayloadTypeMultiComBox: "+bombMethod)
            uavBombingmethodMultiComBox.selectedItems = bombMethod.slice();
        }
        if (selectUavData && selectUavData.operation_method) {
            var operationMethod = selectUavData.operation_method.split(",");
            console.log("uavInvestigationPayloadTypeMultiComBox: "+operationMethod)
            operationModeMultiComBox.selectedItems = operationMethod.slice();
        }
        if (selectUavData && selectUavData.recovery_mode) {
            var recoveryMode = selectUavData.recovery_mode.split(",");
            console.log("uavInvestigationPayloadTypeMultiComBox: "+recoveryMode)
            uavRecoverymodeMultiComBox.selectedItems = recoveryMode.slice();
        }
    }

    function writeControl(isEditable) {
        // 遍历输入容器的所有子元素
        for (var i = 0; i < controlUav.children.length; i++) {
            var child = controlUav.children[i];
            // 检查是否是输入框或下拉框
            if (child.hasOwnProperty("enabled")) {
                //child.enabled = isEditable;

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
        //isValid = validateInput(uavLoadammoSelect.currentText, "无人机隐身性未选择!") && isValid;
        isValid = validateInput(uavFlightHeightMin.text, "无人机飞行高度最小值未填写!") && isValid;
        isValid = validateInput(uavFlightHeightMax.text, "无人机飞行高度最大值未填写!") && isValid;
        isValid = validateInput(uavFlightSpeedMin.text, "无人机飞行速度最小值未填写!") && isValid;
        isValid = validateInput(uavFlightSpeedMax.text, "无人机飞行速度最大值未填写!") && isValid;
        isValid = validateInput(uavTurningRadiusMin.text, "无人机转弯半径最小值未填写!") && isValid;
        isValid = validateInput(uavTurningRadiusMax.text, "无人机转弯半径最大值未填写!") && isValid;
        isValid = validateInput(uavFlightDistance.text, "无人机飞行航程值未填写!") && isValid;
        //isValid = validateInput(uavRecoveryModeResult, "回收方式未选择!") && isValid;
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
    // 提取特定的 uavComponeName 和对应的 recordId
    function extractRecords(data, names) {
        return data
        .filter(item => names.includes(item.uavComponeName))
        .map(item => ({
                          uavComponeName: item.uavComponeName,
                          recordId: item.recordId
                      }));
    }
    // 提取 recordId 并封装成数组
    function extractRecordIds(data) {
        return data.map(item => item.recordId);
    }
    function textToFloat(data){
        console.log("textToFloatdata"+data)
        // 检查是否以小数点结尾
        if (data.endsWith(".")) {
            data = data.slice(0, -1); // 去掉小数点
        }
        console.log("textToFloatdata"+data)
        // 将文本转换为浮点数
        var num = parseFloat(data);
        if (!isNaN(num)) {

            return num; // 有效时赋值
        } else {
            // 无效时恢复原值（可选）
            num = 0.00
            return num;
        }
    }
    //将原始数据与选中的数据进行保存成名称与id
    // 提取匹配的 ammoName 和 recordId
    function extractAmmoNameRecord(a, b) {
        return b.map(name => {
                         const found = a.find(item => item.ammoName === name);
                         return found ? found.recordId.toString():null//found ? `${found.recordId}` : null;//found ? `${name}:${found.recordId}` : null;
                     }).filter(result => result !== null);
    }
    //提取uavCompoentName与recordId
    // 提取匹配的 uavComponeName 和 recordId
    function extractComponentData(a, b) {
        return b.map(name => {
                         const found = a.find(item => item.uavComponeName === name);
                         return found ? `${found.recordId}` : null;//found ? `${found.uavComponeName}:${found.recordId}` : null;
                     }).filter(result => result !== null);
    }
    // 转换数据格式
    function transformArrayToStrData(data) {
        // 深拷贝原始数据
        var transformed = JSON.parse(JSON.stringify(data));

        // 转换指定字段
        transformed.load_ammo_type = transformField(data.load_ammo_type);
        transformed.payload_type = transformField(data.payload_type);
        transformed.bomb_method = transformField(data.bomb_method);
        transformed.recovery_mode = transformField(data.recovery_mode);
        transformed.operation_method = transformField(data.operation_method);

        return transformed;
    }

    // 转换单个字段的函数
    function transformField(field) {
        if (Array.isArray(field)) {
            return field.join(",");
        }
        return field;
    }
    function saveUavData(){
        console.log("uavTypeSelevtContent"+uavTypeSelect.currentText+"-"+"testValue"+uavTypeSelect.currentValue)

        var uavData = {
            //-- 基础信息
            uav_type:"",
            uav_name:"",
            uav_id:"",
            //-- 尺寸参数
            length:0.0, // 浮点数
            width:0.0, // 浮点数
            height:0.0, // 浮点数
            load_ammo_type:"", // 浮点数
            //-- 飞行性能
            flight_height_min:0.0, // 浮点数
            flight_height_max:0.0, // 浮点数
            flight_speed_min:0.0, // 浮点数
            flight_speed_max:0.0, // 浮点数
            flight_distance_min:0.0, // 浮点数
            flight_distance_max:0.0, // 浮点数
            flight_time_min:0.0, // 浮点数
            flight_time_max:0.0, // 浮点数
            //-- 起降参数
            //-- 机动性能
            takeoff_distance:0.0, // 浮点数
            landing_distance:0.0, // 浮点数
            turn_radius_min:0.0, // 浮点数
            turn_radius_max:0.0, // 浮点数
            combat_radius:0.0, // 浮点数

            //-- 载荷配置
            payload_type:"",
            bomb_method:"",
            recon_range_min:0.0, // 浮点数
            recon_range_max:0.0, // 浮点数
            recon_accuracy:0.0, // 浮点数
            //-- 回收与突防
            //-- 挂载能力
            //-- 操控与攻击
            //-- 雷达特征
            recovery_mode:"",
            low_alt_speed:0.0, // 浮点数
            hanging_capacity:"",
            operation_method:"",
            attack_accuracy:0.0, // 浮点数
            rcs:0.0, // 浮点数
            //-- 重量与平衡
            //-- 燃油与载重
            //-- 高度性能
            //-- 续航性能
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
            //-- 系统记录
            sea_takeoff_roll:0.0, // 浮点数
            sea_landing_roll:0.0, // 浮点数
            recon_cruise_alt:0.0, // 浮点数
            full_external_cruise_alt:0.0, // 浮点数
            image_name:"",
            image_url:"",
            recordcreation_time:""

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
        //检查是否填写完全
        //checkAllValue()
        uavData.uav_type = uavTypeSelect.currentText
        uavData.uav_name = uavNameText.text
        var uavModelType = uavIdText.currentText
        // JSON.parse(addUavModelData.uavModelTypeOrigi)
        var uavModelTypeStr =  findRecordIdByName(addUavModelData.uavModelTypeOrigi,uavModelType)
        console.log("uavModelTypeStr"+uavModelTypeStr)
        uavData.uav_id = uavModelTypeStr//uavIdText.text
        uavData.length = textToFloat(uavLengthText.text)
        uavData.width = textToFloat(uavWidthText.text)
        uavData.height = textToFloat(uavHeightText.text)
        //uavData.load_ammo_type = uavLoadammoSelect.currentText

        uavData.flight_height_min = textToFloat(uavFlightHeightMin.text)
        uavData.flight_height_max = textToFloat(uavFlightHeightMax.text)
        uavData.flight_speed_min = textToFloat(uavFlightSpeedMin.text)
        uavData.flight_speed_max = textToFloat(uavFlightSpeedMax.text)
        uavData.turn_radius_min = textToFloat(uavTurningRadiusMin.text)
        uavData.turn_radius_max = textToFloat(uavTurningRadiusMax.text)

        uavData.flight_distance_max = textToFloat(uavFlightDistance.text)
        //uavData.hanging_capacity = ""//uavRadarCrossSectionText.text
        //var uavAmmoType = uavAmmoDaoModel.selectAmmoTypeAllData()
        var uavBombWay = uavBombingMethodDaoModel.selectUavModelBombingMethodAllData()
        var uavPayloadType = uavModelLoadTypeDaoModel.selectUavModelLoadTypeAllData()
        var uavRecoveryWay = uavModelRecoveryModeDaoModel.selectModelRecoveryModeAllData()
        var uavOperationWay = uavModelOperationWayDaoModel.selectModelOperationWayAllData()
        //console.log("aaaaaaaaaaaaaaaaaaaaaaa"+JSON.stringify(uavPayloadType)+"<>"+JSON.stringify(uavInvestigationPayloadTypeResult))
        //console.log("ammoTypeResult"+ammoTypeResult)
        //挂载弹药类型
        if(isEmpty(ammoTypeResult)){
            warningPopup.open()
            warningItem.text = "挂载弹药类型未选择!"
            autoCloseTimer.start()
        }else{
            // var extractedRecords = extractRecords(uavPayloadType, ammoTypeResult);
            // console.log("提取的记录:", JSON.stringify(extractedRecords));
            // var recordIds = extractRecordIds(extractedRecords);
            // console.log("提取的 recordId 数组:", recordIds);
            var ammoTypeStr = extractAmmoNameRecord(addUavModelData.ammoTypeOrigi,ammoTypeResult)
            uavData.load_ammo_type = JSON.stringify(ammoTypeStr)
            console.log("ammoTypeStr"+ammoTypeStr)
            //uavData.payload_type = JSON.stringify(ammoTypeResult.join(",")).replace(/^"|"$/g, "");//uavInvestigationPayloadTypeJsonStrresult

        }
        //挂载侦察载荷
        if(isEmpty(uavInvestigationPayloadTypeResult)){
            warningPopup.open()
            warningItem.text = "侦察载荷类型未选择!"
            autoCloseTimer.start()
        }else{
            // var extractedRecords = extractRecords(uavPayloadType, uavInvestigationPayloadTypeResult);
            // console.log("侦察载荷记录提取的记录:", JSON.stringify(extractedRecords));
            // var recordIds = extractRecordIds(extractedRecords);
            // console.log("侦察载荷提取的 recordId 数组:", recordIds);
            var InvestigationPayloadStr = extractComponentData(payloadTypeOrigi,uavInvestigationPayloadTypeResult)
            uavData.payload_type = JSON.stringify(InvestigationPayloadStr)
            //uavData.payload_type = JSON.stringify(uavInvestigationPayloadTypeResult.join(",")).replace(/^"|"$/g, "");//uavInvestigationPayloadTypeJsonStrresult

        }
        //挂载攻击方式
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
            // var uavBombextractedRecords = extractRecords(uavBombWay, uavBombingmethodResult);
            // console.log("uavBombingmethodResult提取的记录:", JSON.stringify(uavBombextractedRecords));
            // var uavBombrecordIds = extractRecordIds(uavBombextractedRecords);
            // console.log("uavBombingmethodResult提取的 recordId 数组:", uavBombrecordIds);
            var bombWayStr = extractComponentData(bombWayOrigi,uavBombingmethodResult)
            uavData.bomb_method = JSON.stringify(bombWayStr)
            //uavData.bomb_method = JSON.stringify(uavBombingmethodResult.join(",")).replace(/^"|"$/g, "");//uavBombingmethodGroupJsonStrresult
        }
        if(isEmpty(uavRecoveryModeResult)){
            warningPopup.open()
            warningItem.text = "回收方式未选择!"
            autoCloseTimer.start()
        }else{
            // var uavRecoveryextractedRecords = extractRecords(uavRecoveryWay, uavRecoveryModeResult);
            // console.log("uavRecoveryModeResult提取的记录:", JSON.stringify(uavRecoveryextractedRecords));
            // var uavRecoveryrecordIds = extractRecordIds(uavRecoveryextractedRecords);
            // console.log("uavRecoveryModeResult提取的 recordId 数组:", uavRecoveryrecordIds);
            var recovryModeStr = extractComponentData(recoveryWayOrigi,uavRecoveryModeResult)
            uavData.recovery_mode = JSON.stringify(recovryModeStr)
            //uavData.recovery_mode = JSON.stringify(uavRecoveryModeResult.join(",")).replace(/^"|"$/g, "");//uavBombingmethodGroupJsonStrresult
        }
        if(isEmpty(uavOperatioanalModeResult)){
            warningPopup.open()
            warningItem.text = "操作方式未选择!"
            autoCloseTimer.start()
        }else{
            // var uavOperatioanalextractedRecords = extractRecords(uavOperationWay, uavOperatioanalModeResult);
            // console.log("提取的记录:", JSON.stringify(uavOperatioanalextractedRecords));
            // var uavOperatioanalrecordIds = extractRecordIds(uavOperatioanalextractedRecords);
            // console.log("提取的 recordId 数组:", uavOperatioanalrecordIds);
            var operationWayStr = extractComponentData(opreationWayOrigi,uavOperatioanalModeResult)
            uavData.operation_method = JSON.stringify(operationWayStr)
            //uavData.operation_method = JSON.stringify(uavOperatioanalModeResult.join(",")).replace(/^"|"$/g, "");//uavInvestigationPayloadTypeJsonStrresult

        }
        uavData.hanging_capacity = uavMountContent.queryToData//uavHangingLocationValue.text
        //uavData.operation_method = JSON.stringify(uavOperatioanalModeResult.join(",")).replace(/^"|"$/g, "");//uavOperatioanalmodeGroupJsonStrresult
        //uavData.recovery_mode = JSON.stringify(uavRecoveryModeResult.join(",")).replace(/^"|"$/g, "");//uavRecoverymodeGroupJsonStrresult

        uavData.flight_time_max =  textToFloat(uavFlightTime.text)
        uavData.takeoff_distance = textToFloat(uavTakeoffDistanceValue.text)
        uavData.landing_distance = textToFloat(uavLandDistanceValue.text)
        uavData.combat_radius = textToFloat(uavOperatioanalRadius.text)
        //uavData.recon_range_min = uavLoadReconnaissanceAccuracyText.text
        uavData.recon_range_max = textToFloat(uavLoadReconnaissanceRangeValue.text)
        uavData.recon_accuracy = textToFloat(uavLoadReconnaissanceAccuracyValue.text)

        uavData.low_alt_speed = textToFloat(uavLowAltitudeBreakthroughSpeedValue.text)
        uavData.combat_radius = textToFloat(uavOperatioanalRadius.text)
        uavData.attack_accuracy = textToFloat(uavAttackaccuracyValue.text)
        uavData.rcs = textToFloat(uavRadarCrossSectionValue.text)
        uavData.cg_front_limit = textToFloat(uavCenterOfGravityFrontLimitValue.text)
        uavData.cg_rear_limit = textToFloat(uavCenterOfGravityAfterwardLimitValue.text)
        uavData.max_takeoff_weight = textToFloat(uavMaximumTakeoffWeightValue.text)
        uavData.empty_weight = textToFloat(uavEmptyWeightValue.text)
        uavData.max_fuel = textToFloat(uavMaximumFuelCapacityValue.text)
        uavData.max_external_weight = textToFloat(uavMaximumExternalWeightValue.text)
        uavData.ceiling = textToFloat(uavCeilingValue.text)
        uavData.ground_start_alt = textToFloat(uavMaximumGroundStartingHeightValue.text)
        uavData.air_start_alt = textToFloat(uavMaximumAirStartingAltitudeValue.text)
        uavData.endurance = textToFloat(uavMaximumEnduranceValue.text)
        uavData.max_vacuum_speed = textToFloat(uavMaximumFlightVacuumSpeedValue.text)
        uavData.min_meter_speed = textToFloat(uavMinimumFlightMeterSpeedValue.text)
        uavData.sea_takeoff_roll = textToFloat(sealLevelTakeoffAndRollDistanceValue.text)
        uavData.sea_landing_roll = textToFloat(sealLevelLandingAndRollDistanceValue.text)
        uavData.recon_cruise_alt = textToFloat(cruiseAltitudeReconnaissanceConfigurationValue.text)
        uavData.full_external_cruise_alt = textToFloat(cruiseAltitudeFullExternalConfigurationValue.text)

        uavData.image_name = "aaaaaaaaaaa"
        uavData.image_url = addUavModelData.imagUrl//uavData.image_url = JSON.stringify(addUavModelData.imagUrl)
        uavData.recordcreation_time = addUavModelData.currentTime
        //var uavTransFormToData = transformArrayToStrData(uavData)
        var jsonString = JSON.stringify(uavData);
        console.log("QML saveUavModelData jsonString"+jsonString);

        var insertUavModelDataResult =uavModelDao.insertModelDate(uavData)
        if(insertUavModelDataResult === true){
            warningPopup.open()
            warningItem.text = "无人机数据新增成功!"
            autoCloseTimer.start()
        }else{
            warningPopup.open()
            warningItem.text = "无人机数据新增失败!"
            autoCloseTimer.start()
        }
    }
    function updataUavModelData(){
        console.log("updateUavModelData")
        var uavData = {
            //-- 基础信息
            id:0,
            uav_type:"",
            uav_name:"",
            uav_id:"",
            load_ammo_type:"",
            //-- 尺寸参数
            length:0.0, // 浮点数
            width:0.0, // 浮点数
            height:0.0, // 浮点数
            load_ammo_type:"", // 浮点数
            //-- 飞行性能
            flight_height_min:0.0, // 浮点数
            flight_height_max:0.0, // 浮点数
            flight_speed_min:0.0, // 浮点数
            flight_speed_max:0.0, // 浮点数
            flight_distance_min:0.0, // 浮点数
            flight_distance_max:0.0, // 浮点数
            flight_time_min:0.0, // 浮点数
            flight_time_max:0.0, // 浮点数
            //-- 起降参数
            //-- 机动性能
            takeoff_distance:0.0, // 浮点数
            landing_distance:0.0, // 浮点数
            turn_radius_min:0.0, // 浮点数
            turn_radius_max:0.0, // 浮点数
            combat_radius:0.0, // 浮点数

            //-- 载荷配置
            payload_type:"",
            bomb_method:"",
            recon_range_min:0.0, // 浮点数
            recon_range_max:0.0, // 浮点数
            recon_accuracy:0.0, // 浮点数
            //-- 回收与突防
            //-- 挂载能力
            //-- 操控与攻击
            //-- 雷达特征
            recovery_mode:"",
            low_alt_speed:0.0, // 浮点数
            hanging_capacity:"",
            operation_method:"",
            attack_accuracy:0.0, // 浮点数
            rcs:0.0, // 浮点数
            //-- 重量与平衡
            //-- 燃油与载重
            //-- 高度性能
            //-- 续航性能
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
            //-- 系统记录
            sea_takeoff_roll:0.0, // 浮点数
            sea_landing_roll:0.0, // 浮点数
            recon_cruise_alt:0.0, // 浮点数
            full_external_cruise_alt:0.0, // 浮点数
            image_name:"",
            image_url:"",
            recordcreation_time:""
        };

        //检查是否填写完全
        checkAllValue()
        var uavBombWay = uavBombingMethodDaoModel.selectUavModelBombingMethodAllData()
        var uavPayloadType = uavModelLoadTypeDaoModel.selectUavModelLoadTypeAllData()
        var uavRecoveryWay = uavModelRecoveryModeDaoModel.selectModelRecoveryModeAllData()
        var uavOperationWay = uavModelOperationWayDaoModel.selectModelOperationWayAllData()
        console.log("aaaaaaaaaaaaaaaaaaaaaaa"+JSON.stringify(uavPayloadType)+"<>"+JSON.stringify(uavInvestigationPayloadTypeResult))
        console.log("ammoTypeResult"+ammoTypeResult)
        //挂载弹药类型
        if(isEmpty(ammoTypeResult)){
            warningPopup.open()
            warningItem.text = "挂载弹药类型未选择!"
            autoCloseTimer.start()
        }else{
            var ammoTypeStr = extractAmmoNameRecord(addUavModelData.ammoTypeOrigi,ammoTypeResult)
            uavData.load_ammo_type = JSON.stringify(ammoTypeStr)
        }
        //挂载侦察载荷
        if(isEmpty(uavInvestigationPayloadTypeResult)){
            warningPopup.open()
            warningItem.text = "侦察载荷类型未选择!"
            autoCloseTimer.start()
        }else{
            console.log("uavInvestigationPayloadTypeResult"+uavInvestigationPayloadTypeResult)
            var InvestigationPayloadStr = extractComponentData(payloadTypeOrigi,uavInvestigationPayloadTypeResult)
            uavData.payload_type = JSON.stringify(InvestigationPayloadStr)
            //uavData.payload_type = JSON.stringify(uavInvestigationPayloadTypeResult.join(",")).replace(/^"|"$/g, "");//uavInvestigationPayloadTypeJsonStrresult

        }
        //攻击方式
        if(isEmpty(uavBombingmethodResult)){
            if(uavTypeSelect.currentText === "侦察无人机"){
                uavData.bomb_method = "无"
            }else{
                warningPopup.open()
                warningItem.text = "投弹方式未选择!"
                autoCloseTimer.start()
            }

        }else{
            var bombWayStr = extractComponentData(bombWayOrigi,uavBombingmethodResult)
            uavData.bomb_method = JSON.stringify(bombWayStr)
            //uavData.bomb_method = JSON.stringify(uavBombingmethodResult.join(",")).replace(/^"|"$/g, "");//uavBombingmethodGroupJsonStrresult
        }
        //回收方式
        if(isEmpty(uavRecoveryModeResult)){
            warningPopup.open()
            warningItem.text = "回收方式未选择!"
            autoCloseTimer.start()
        }else{
            var recovryModeStr = extractComponentData(recoveryWayOrigi,uavRecoveryModeResult)
            uavData.recovery_mode = JSON.stringify(recovryModeStr)
            //uavData.recovery_mode = JSON.stringify(uavRecoveryModeResult.join(",")).replace(/^"|"$/g, "");//uavBombingmethodGroupJsonStrresult
        }
        //操作方式
        if(isEmpty(uavOperatioanalModeResult)){
            warningPopup.open()
            warningItem.text = "操作方式未选择!"
            autoCloseTimer.start()
        }else{
            var operationWayStr = extractComponentData(opreationWayOrigi,uavOperatioanalModeResult)
            uavData.operation_method = JSON.stringify(operationWayStr)
            //uavData.operation_method = JSON.stringify(uavOperatioanalModeResult.join(",")).replace(/^"|"$/g, "");//uavInvestigationPayloadTypeJsonStrresult
        }
        //uavData.operation_method = JSON.stringify(uavOperatioanalModeResult.join(",")).replace(/^"|"$/g, "");//uavOperatioanalmodeGroupJsonStrresult
        //uavData.recovery_mode = JSON.stringify(uavRecoveryModeResult.join(",")).replace(/^"|"$/g, "");//uavRecoverymodeGroupJsonStrresult
        uavData.id = processInfo.recordId
        console.log("uavData.id  processInfo.recordId"+uavData.id+"<>"+processInfo.recordId)
        uavData.uav_type = uavTypeSelect.currentText
        uavData.uav_name = uavNameText.text
        uavData.uav_id = uavIdText.text
        uavData.hanging_capacity = uavHangingLocationValue.text
        uavData.length = textToFloat(uavLengthText.text)
        uavData.width = textToFloat(uavWidthText.text)
        uavData.height = textToFloat(uavHeightText.text)

        uavData.flight_height_min = textToFloat(uavFlightHeightMin.text)
        uavData.flight_height_max = textToFloat(uavFlightHeightMax.text)
        uavData.flight_speed_min = textToFloat(uavFlightSpeedMin.text)
        uavData.flight_speed_max = textToFloat(uavFlightSpeedMax.text)
        uavData.turn_radius_min = textToFloat(uavTurningRadiusMin.text)
        uavData.turn_radius_max = textToFloat(uavTurningRadiusMax.text)

        uavData.flight_distance_max = textToFloat(uavFlightDistance.text)

        uavData.flight_time_max =  textToFloat(uavFlightTime.text)
        uavData.takeoff_distance = textToFloat(uavTakeoffDistanceValue.text)
        uavData.landing_distance = textToFloat(uavLandDistanceValue.text)
        uavData.combat_radius = textToFloat(uavOperatioanalRadius.text)
        //uavData.recon_range_min = uavLoadReconnaissanceAccuracyText.text
        uavData.recon_range_max = textToFloat(uavLoadReconnaissanceRangeValue.text)
        uavData.recon_accuracy = textToFloat(uavLoadReconnaissanceAccuracyValue.text)

        uavData.low_alt_speed = textToFloat(uavLowAltitudeBreakthroughSpeedValue.text)
        uavData.combat_radius = textToFloat(uavOperatioanalRadius.text)
        uavData.attack_accuracy = textToFloat(uavAttackaccuracyValue.text)
        uavData.rcs = textToFloat(uavRadarCrossSectionValue.text)
        uavData.cg_front_limit = textToFloat(uavCenterOfGravityFrontLimitValue.text)
        uavData.cg_rear_limit = textToFloat(uavCenterOfGravityAfterwardLimitValue.text)
        uavData.max_takeoff_weight = textToFloat(uavMaximumTakeoffWeightValue.text)
        uavData.empty_weight = textToFloat(uavEmptyWeightValue.text)
        uavData.max_fuel = textToFloat(uavMaximumFuelCapacityValue.text)
        uavData.max_external_weight = textToFloat(uavMaximumExternalWeightValue.text)
        uavData.ceiling = textToFloat(uavCeilingValue.text)
        uavData.ground_start_alt = textToFloat(uavMaximumGroundStartingHeightValue.text)
        uavData.air_start_alt = textToFloat(uavMaximumAirStartingAltitudeValue.text)
        uavData.endurance = textToFloat(uavMaximumEnduranceValue.text)
        uavData.max_vacuum_speed = textToFloat(uavMaximumFlightVacuumSpeedValue.text)
        uavData.min_meter_speed = textToFloat(uavMinimumFlightMeterSpeedValue.text)
        uavData.sea_takeoff_roll = textToFloat(sealLevelTakeoffAndRollDistanceValue.text)
        uavData.sea_landing_roll = textToFloat(sealLevelLandingAndRollDistanceValue.text)
        uavData.recon_cruise_alt = textToFloat(cruiseAltitudeReconnaissanceConfigurationValue.text)
        uavData.full_external_cruise_alt = textToFloat(cruiseAltitudeFullExternalConfigurationValue.text)

        uavData.image_name = "hhhhhh"
        uavData.image_url = addUavModelData.imagUrl
        uavData.recordcreation_time = addUavModelData.currentTime
        var jsonString = JSON.stringify(uavData);
        console.log("updataUavModelDatajsonString"+jsonString);
        var updataUavModelDataResult = uavModelDao.updateModelDate(jsonString)
        if(updataUavModelDataResult === true){
            warningPopup.open()
            warningItem.text = "无人机数据更新成功!"
            autoCloseTimer.start()
        }else{
            warningPopup.open()
            warningItem.text = "无人机数据更新失败!"
            autoCloseTimer.start()
        }
    }

    function convertToJsonArray(jsonData) {
        return jsonData.map(function(item) {
            return item.name;
        });
    }
    //ButtonGroup的接收值方法
    // function getSelectedPayloads(buttons) {
    //         return Array.from(buttons)
    //             .filter(btn => btn.checked)
    //             .map(btn => ({
    //                 name: btn.text,
    //                 code: btn.payloadCode
    //             }))
    // }
    // 生成测试数据函数修正
    function generateTestData() {
        const testData = [
                           {
                               mountCount: "2",
                               payloadCapacity: "500",
                               mountingPosition: "位置A",
                               positionNumber: "001",
                               checked: true
                           },
                           {
                               mountCount: "1",
                               payloadCapacity: "300",
                               mountingPosition: "位置B",
                               positionNumber: "002",
                               checked: false
                           },
                           {
                               mountCount: "1",
                               payloadCapacity: "300",
                               mountingPosition: "位置B",
                               positionNumber: "002",
                               checked: false
                           },
                           {
                               mountCount: "1",
                               payloadCapacity: "300",
                               mountingPosition: "位置B",
                               positionNumber: "002",
                               checked: false
                           },
                           {
                               mountCount: "1",
                               payloadCapacity: "300",
                               mountingPosition: "位置B",
                               positionNumber: "002",
                               checked: false
                           },
                           {
                               mountCount: "1",
                               payloadCapacity: "300",
                               mountingPosition: "位置B",
                               positionNumber: "002",
                               checked: false
                           },
                           {
                               mountCount: "1",
                               payloadCapacity: "300",
                               mountingPosition: "位置B",
                               positionNumber: "002",
                               checked: false
                           }
                       ]
        //multiTextDispay.loadData = testData
    }

}

