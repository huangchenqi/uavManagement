import QtQuick 2.12
import QtQuick.Controls 2.12
import "qrc:/"
import "qrc:/AddAmmoModules/Component"
import UavMountLocationDaoModel 1.0
import AmmoDaoModel 1.0
import MountingSchemeDaoModel 1.0
import UavDaoModel 1.0
Item {
    id:addMountSchemeData

    width: 800
    height: 700
    property var mountSchemeData: new Object//保存、查看、修改数据
    property var mountLocationArray: []
    property var ammoName:[]
    signal backMountingScheme()
    property int selectType: -1
    Component.onCompleted: {
        init()
        textComponentEnable()
    }
    UavMountLocationDaoTableModel{
        id:uavMountLocationDaoTableModel
    }
    AmmoDaoTableModel{
        id:ammoDaoModel
    }
    MountingSchemeDaoTableModel{
        id:mountingSchemeDaoTableModel
    }
    UavModelDaoTableModel{
        id:uavModelDao
    }
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

    //1号挂点位置
    property var sMountNum1Place: "请选择:"
    //2号挂点位置
    property var sMountNum2Place: "请选择:"
    //3号挂点位置
    property var sMountNum3Place: "请选择:"
    //4号挂点位置
    property var sMountNum4Place: "请选择:"
    //5号挂点位置
    property var sMountNum5Place: "请选择:"
    //6号挂点位置
    property var sMountNum6Place: "请选择:"
    //7号挂点位置
    property var sMountNum7Place: "请选择:"
    //8号挂点位置
    property var sMountNum8Place: "请选择:"
    //9号挂点位置
    property var sMountNum9Place: "请选择:"
    //10号挂点位置
    property var sMountNum10Place: "请选择:"

    //挂点是否选择
    property bool isMount1Select: false
    property bool isMount2Select: false
    property bool isMount3Select: false
    property bool isMount4Select: false
    property bool isMount5Select: false
    property bool isMount6Select: false
    property bool isMount7Select: false
    property bool isMount8Select: false
    property bool isMount9Select: false
    property bool isMount10Select: false

    property var sMountNum1AmmoType: "请选择:"
    property var sMountNum2AmmoType: "请选择:"
    property var sMountNum3AmmoType: "请选择:"
    property var sMountNum4AmmoType: "请选择:"
    property var sMountNum5AmmoType: "请选择:"
    property var sMountNum6AmmoType: "请选择:"
    property var sMountNum7AmmoType: "请选择:"
    property var sMountNum8AmmoType: "请选择:"
    property var sMountNum9AmmoType: "请选择:"
    property var sMountNum10AmmoType: "请选择:"

    property int currentMountPlaceSelect: 0
    function openMountPlace(id){
        switch(id)
        {
        case 1:
            view_List_MountPlace.anchors.horizontalCenter = btn_MountNum1Place.horizontalCenter
//            view_List_MountPlace.x = btn_MountNum1Place.x + btn_MountNum1Place.width
            view_List_MountPlace.y = btn_MountNum1Place.y + btn_MountNum1Place.height
            view_List_MountPlace.visible = !view_List_MountPlace.visible
            break;
        case 2:
            view_List_MountPlace.anchors.horizontalCenter = btn_MountNum2Place.horizontalCenter
            view_List_MountPlace.y = btn_MountNum2Place.y + btn_MountNum2Place.height
            view_List_MountPlace.visible = !view_List_MountPlace.visible
            break;
        case 3:
            view_List_MountPlace.anchors.horizontalCenter = btn_MountNum3Place.horizontalCenter
            view_List_MountPlace.y = btn_MountNum3Place.y + btn_MountNum3Place.height
            view_List_MountPlace.visible = !view_List_MountPlace.visible
            break;
        case 4:
            view_List_MountPlace.anchors.horizontalCenter = btn_MountNum4Place.horizontalCenter
            view_List_MountPlace.y = btn_MountNum4Place.y + btn_MountNum4Place.height
            view_List_MountPlace.visible = !view_List_MountPlace.visible
            break;
        case 5:
            view_List_MountPlace.anchors.horizontalCenter = btn_MountNum5Place.horizontalCenter
            view_List_MountPlace.y = btn_MountNum5Place.y + btn_MountNum5Place.height
            view_List_MountPlace.visible = !view_List_MountPlace.visible
            break;
        case 6:
            view_List_MountPlace.anchors.horizontalCenter = btn_MountNum6Place.horizontalCenter
            view_List_MountPlace.y = btn_MountNum6Place.y + btn_MountNum6Place.height
            view_List_MountPlace.visible = !view_List_MountPlace.visible
            break;
        case 7:
            view_List_MountPlace.anchors.horizontalCenter = btn_MountNum7Place.horizontalCenter
            view_List_MountPlace.y = btn_MountNum7Place.y + btn_MountNum7Place.height
            view_List_MountPlace.visible = !view_List_MountPlace.visible
            break;
        case 8:
            view_List_MountPlace.anchors.horizontalCenter = btn_MountNum8Place.horizontalCenter
            view_List_MountPlace.y = btn_MountNum8Place.y + btn_MountNum8Place.height
            view_List_MountPlace.visible = !view_List_MountPlace.visible
            break;
        case 9:
            view_List_MountPlace.anchors.horizontalCenter = btn_MountNum9Place.horizontalCenter
            view_List_MountPlace.y = btn_MountNum9Place.y + btn_MountNum9Place.height
            view_List_MountPlace.visible = !view_List_MountPlace.visible
            break;
        case 10:
            view_List_MountPlace.anchors.horizontalCenter = btn_MountNum10Place.horizontalCenter
            view_List_MountPlace.y = btn_MountNum10Place.y + btn_MountNum10Place.height
            view_List_MountPlace.visible = !view_List_MountPlace.visible
            break;
        }
        currentMountPlaceSelect =id
    }

    property int currentAmmoTypeSelect: 0
    function openAmmoType(id){
        switch(id)
        {
        case 1:
            view_List_MountAmmoType.anchors.horizontalCenter = btn_MountNum1AmmoType.horizontalCenter
            view_List_MountAmmoType.y = btn_MountNum1AmmoType.y + btn_MountNum1AmmoType.height
            view_List_MountAmmoType.visible = !view_List_MountAmmoType.visible
            break;
        case 2:
            view_List_MountAmmoType.anchors.horizontalCenter = btn_MountNum2AmmoType.horizontalCenter
            view_List_MountAmmoType.y = btn_MountNum2AmmoType.y + btn_MountNum2AmmoType.height
            view_List_MountAmmoType.visible = !view_List_MountAmmoType.visible
            break;
        case 3:
            view_List_MountAmmoType.anchors.horizontalCenter = btn_MountNum3AmmoType.horizontalCenter
            view_List_MountAmmoType.y = btn_MountNum3AmmoType.y + btn_MountNum3AmmoType.height
            view_List_MountAmmoType.visible = !view_List_MountAmmoType.visible
            break;
        case 4:
            view_List_MountAmmoType.anchors.horizontalCenter = btn_MountNum4AmmoType.horizontalCenter
            view_List_MountAmmoType.y = btn_MountNum4AmmoType.y + btn_MountNum4AmmoType.height
            view_List_MountAmmoType.visible = !view_List_MountAmmoType.visible
            break;
        case 5:
            view_List_MountAmmoType.anchors.horizontalCenter = btn_MountNum5AmmoType.horizontalCenter
            view_List_MountAmmoType.y = btn_MountNum5AmmoType.y + btn_MountNum5AmmoType.height
            view_List_MountAmmoType.visible = !view_List_MountAmmoType.visible
            break;
        case 6:
            view_List_MountAmmoType.anchors.horizontalCenter = btn_MountNum6AmmoType.horizontalCenter
            view_List_MountAmmoType.y = btn_MountNum6AmmoType.y + btn_MountNum6AmmoType.height
            view_List_MountAmmoType.visible = !view_List_MountAmmoType.visible
            break;
        case 7:
            view_List_MountAmmoType.anchors.horizontalCenter = btn_MountNum7AmmoType.horizontalCenter
            view_List_MountAmmoType.y = btn_MountNum7AmmoType.y + btn_MountNum7AmmoType.height
            view_List_MountAmmoType.visible = !view_List_MountAmmoType.visible
            break;
        case 8:
            view_List_MountAmmoType.anchors.horizontalCenter = btn_MountNum8AmmoType.horizontalCenter
            view_List_MountAmmoType.y = btn_MountNum8AmmoType.y + btn_MountNum8AmmoType.height
            view_List_MountAmmoType.visible = !view_List_MountAmmoType.visible
            break;
        case 9:
            view_List_MountAmmoType.anchors.horizontalCenter = btn_MountNum9AmmoType.horizontalCenter
            view_List_MountAmmoType.y = btn_MountNum9AmmoType.y + btn_MountNum9AmmoType.height
            view_List_MountAmmoType.visible = !view_List_MountAmmoType.visible
            break;
        case 10:
            view_List_MountAmmoType.anchors.horizontalCenter = btn_MountNum10AmmoType.horizontalCenter
            view_List_MountAmmoType.y = btn_MountNum10AmmoType.y + btn_MountNum10AmmoType.height
            view_List_MountAmmoType.visible = !view_List_MountAmmoType.visible
            break;
        }
        currentAmmoTypeSelect =id
    }


    Rectangle{
        id:rect_Back
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.bottom: btn_Cancel.top
        anchors.bottomMargin: 10
        color: "#50000000"

        CText {
            id: top_title
            text: qsTr("挂载方案设置")
            pixelSize: 25
            width: pixelSize * 6
            color: "#4EC4FF"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 20
            horizontalAlignment: Text.AlignLeft
        }

        CText{
            id:text_PlanName
            text: "挂载方案名称:"
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.top: top_title.bottom
            anchors.topMargin: 30
            pixelSize: 20
            width: pixelSize * 6.5
            horizontalAlignment: Text.AlignLeft
            color: mainColor
        }

        Item{
            id:item_PlanNameInput
            width: 350 - text_PlanName.width
            height: 20
            anchors.left:text_PlanName.right
            anchors.top: text_PlanName.top
            anchors.topMargin: -5
            TextInput{
                id:planNameText
                anchors.fill: parent
                color:"#ffffffff"
                font.family:text_PlanName.family
                font.pixelSize:(18)
                selectByMouse: true
                selectionColor: "#ffcc8800"
                onTextChanged: {
                    // if(text != "")
                    // {

                    // }
                    addMountSchemeData.mountSchemeData.mountSchemeName = text
                }
                validator: RegExpValidator {
                    regExp: /[^\s]*/  // 不允许任何空格
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

        // CText{
        //     id:text_UavName
        //     text: "无人机名称:"
        //     anchors.left: item_PlanNameInput.right
        //     anchors.leftMargin: 10
        //     anchors.verticalCenter: text_PlanName.verticalCenter
        //     pixelSize: 20
        //     width: pixelSize * 5.5
        //     horizontalAlignment: Text.AlignLeft
        //     color: mainColor
        // }

        // Item{
        //     id:item_UavNameInput
        //     width: 350 - text_UavName.width
        //     height: 20
        //     anchors.left:text_UavName.right
        //     anchors.top: text_UavName.top
        //     anchors.topMargin: -5
        //     TextInput{
        //         id:uavNameText
        //         anchors.fill: parent
        //         color:"#ffffffff"
        //         font.family:text_UavName.family
        //         font.pixelSize:(18)
        //         selectByMouse: true
        //         selectionColor: "#ffcc8800"
        //         onTextChanged: {
        //             // if(text != "")
        //             // {

        //             // }
        //             addMountSchemeData.mountSchemeData.uavName = text
        //         }
        //         validator: RegExpValidator {
        //             regExp: /[^\s]*/  // 不允许任何空格
        //         }
        //     }
        //     Rectangle{
        //         width: parent.width
        //         height: (2)
        //         anchors.left: parent.left
        //         anchors.bottom: parent.bottom
        //         color:mainColor
        //     }
        // }

        CText{
            id:uavType
            text: "对应无人机类型:"
            anchors.left: item_PlanNameInput.right
            anchors.leftMargin: 10
            anchors.top: top_title.bottom
            anchors.topMargin: 30
            pixelSize: 18
            color: mainColor
            width: pixelSize * 7.5
            height: pixelSize
            bold: true
        }
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
            z:2
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
                        borderColor: m_SelectState ? "#A5FBB4" : "#ffddaa00"
                        selectColor: borderColor
                        selectBorderColor: borderColor
                        selectBorderHigtColor: borderColor
                        borderHigtColor: "#ffeebb22"
                        pixelSize: 18
                        isSelect: m_SelectState
                        onClicked: {
                            if(processInfo.loadViewType === "query"){

                            }else{
                                view_List_TypeSelect.visible = false
                                selectType = index
                                for (var i = 0; i < listmodel_Box.count; i++) {
                                    listmodel_Box.setProperty(i, "m_SelectState", false);
                                }
                                m_SelectState = !m_SelectState
                                var selectUavData = new Object
                                selectUavData.recordId = m_PlanNumber
                                var  queryResult = uavModelDao.queryMountSchemeToUavMod(selectUavData)
                                text_MaxTakeOffWeight.text = queryResult.max_takeoff_weight
                                text_UavEmptyWeight.text = queryResult.empty_weight
                                text_UavMaxFuelWeight.text = queryResult.max_fuel
                                text_UavMaxExternalWeight.text = queryResult.max_external_weight
                                //isSelect = m_SelectState
                                // 检查数组中是否已经存在该数字
                                    // var uavIndex = useToUavArray.indexOf(m_PlanNumber)

                                    // if (uavIndex === -1) {
                                    //     // 数字不存在，添加到数组
                                    //     useToUavArray.push(m_PlanNumber)
                                    //     console.log("Number added: " + m_PlanNumber)
                                    // } else {
                                    //     // 数字已存在，从数组中删除
                                    //     useToUavArray.splice(uavIndex, 1)
                                    //     console.log("Number removed: " + m_PlanNumber)
                                    // }
                                // 检查数组中是否已经存在该数字
                                // if (!newAmmoData.useToUavArray.includes(m_PlanNumber)) {
                                //     newAmmoData.useToUavArray.push(m_PlanNumber) // 添加数字到数组
                                //     console.log("Number added: " + m_PlanNumber)
                                // } else {
                                //     console.log("Number already exists: " + m_PlanNumber)
                                // }
                                addMountSchemeData.mountSchemeData.uavName = m_TypeName//m_PlanNumber
                                selectMountMethod(queryResult)
                                console.log("mountToUavArray"+JSON.stringify(queryResult))
                            }
                        }
                    }
                }
            }
            Component.onCompleted: {

                var uavData = uavModelDao.queryUavModelPartData()//selectUavModelAllData()
                console.log("uavModelDao"+JSON.stringify(uavData))
                var result = [];
                for (var i = 0; i < uavData.length; i++) {
                    result.push({
                        m_PlanNumber: uavData[i].recordId,
                        m_SelectState:false,// ammoType[i].checked,
                        m_TypeName: uavData[i].uavName
                    });
                }
                if(processInfo.loadViewType === "addUavData"){


                }else if(processInfo.loadViewType === "query"){
                    var ammoToUavModel = custom_PassiveInterferencePod.useToUavResult
                    var a = ammoToUavModel.split(",");

                    // 遍历数组 a 和 b，更新 m_SelectState
                    for (var i = 0; i < a.length; i++) {
                        for (var j = 0; j < result.length; j++) {
                            if (result[j].m_PlanNumber === a[i]) {
                                result[j].m_SelectState = true;
                            }
                        }
                    }

                    // 打印更新后的数组 b
                    console.log("Updated array b:", JSON.stringify(result, null, 2));
                    console.log("<!><@><#>")
                }else if(processInfo.loadViewType === "update"){
                    var ammoToUavModel = custom_PassiveInterferencePod.useToUavResult
                    var a = ammoToUavModel.split(",");
                    custom_PassiveInterferencePod.useToUavArray = a

                    // 遍历数组 a 和 b，更新 m_SelectState
                    for (var i = 0; i < a.length; i++) {
                        for (var j = 0; j < result.length; j++) {
                            if (result[j].m_PlanNumber === a[i]) {
                                result[j].m_SelectState = true;
                            }
                        }
                    }

                    // 打印更新后的数组 b
                    console.log("Updated array b:", JSON.stringify(result, null, 2));
                    console.log("<!><@><#>")
                }else{
                    console.log("processInfo.loadViewType Unknown")
                }
                // if(missileCommonData.selectAmmoViewType === 1 ){

                // }else if(missileCommonData.selectAmmoViewType === 2){
                //     var ammoToUavModelUpdate = newAmmoData.ammoSelectData.ammoToUavModel
                //     var a = ammoToUavModelUpdate.split(",");
                //     uavArray = a
                //     // 遍历数组 a 和 b，更新 m_SelectState
                //     for (var i = 0; i < a.length; i++) {
                //         for (var j = 0; j < result.length; j++) {
                //             if (result[j].m_PlanNumber === a[i]) {
                //                 result[j].m_SelectState = true;
                //             }
                //         }
                //     }

                //     // 打印更新后的数组 b
                //     console.log("Updated array b:", JSON.stringify(result, null, 2));
                //     console.log("<!><@><#>loadAmmoData")
                // }else{
                //     console.log("Unknown selectType!")
                // }
               console.log("listmodel_Box::"+JSON.stringify(result))
               listmodel_Box.append(result);

            }
        }
        //显示区域
        CButton{
            id:comp_DamageFactorType
            width: 200
            height: 36
            color:"#ffddaa00"
            borderColor: "#ffddaa00"
            borderHigtColor: "#ffeebb22"
            anchors.left: uavType.right
            anchors.leftMargin: 2
            anchors.top: top_title.bottom
            anchors.topMargin: 26
            //anchors.topMargin: 30
            //anchors.verticalCenter: uavType.verticalCenter
            pixelSize: 20
            text:{
                if(selectType < 0)
                {
                    return "请选择:"
                }
                else
                {
                    if(listmodel_Box.count > 0)
                        listmodel_Box.get(selectType).m_TypeName
                }
            }
            onClicked: {
                view_List_TypeSelect.visible = !view_List_TypeSelect.visible
            }
        }

        CTextInput{
            id:text_MaxTakeOffWeight
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.top: text_PlanName.bottom
            anchors.topMargin: 30
            title: "无人机最大起飞重量(kg):"
            pixelSize: 18
            titleWidth: pixelSize * 11.5
            width: 350
            height: 30
            onTextChanged: {
                addMountSchemeData.mountSchemeData.maxTakeoffWeight = textToFloat(text)
            }
        }

        CTextInput{
            id:text_UavEmptyWeight
            anchors.left: text_MaxTakeOffWeight.right
            anchors.leftMargin: 10
            anchors.top: text_PlanName.bottom
            anchors.topMargin: 30
            title: "无人机空机重量(kg):"
            pixelSize: 18
            titleWidth: pixelSize * 9.5
            width: 350
            height: 30
            onTextChanged: {
                addMountSchemeData.mountSchemeData.emptyWeight = textToFloat(text)
            }
        }

        CTextInput{
            id:text_UavMaxFuelWeight
            anchors.left: text_MaxTakeOffWeight.left
            anchors.top: text_MaxTakeOffWeight.bottom
            anchors.topMargin: 20
            title: "无人机最大载油量(L):"
            pixelSize: 18
            titleWidth: pixelSize * 10
            width: 350
            height: 30
            onTextChanged: {
                addMountSchemeData.mountSchemeData.maxFuel = textToFloat(text)
            }
        }

        CTextInput{
            id:text_UavMaxExternalWeight
            anchors.left: text_UavMaxFuelWeight.right
            anchors.leftMargin: 10
            anchors.top: text_UavMaxFuelWeight.top
            title: "无人机最大外挂重量(kg):"
            pixelSize: 18
            titleWidth: pixelSize * 11.5
            width: 350
            height: 30
            onTextChanged: {
                addMountSchemeData.mountSchemeData.maxExternalWeight = textToFloat(text)
            }
        }

        CTextInput{
            id:text_RunningDistance
            anchors.left: text_UavMaxFuelWeight.left
            anchors.top: text_UavMaxFuelWeight.bottom
            anchors.topMargin: 20
            title: "滑跑距离:"
            pixelSize: 18
            titleWidth: pixelSize * 4.5
            width: 170
            height: 30
            onTextChanged: {
                addMountSchemeData.mountSchemeData.runningDistance = textToFloat(text)
            }
        }

        CTextInput{
            id:text_FlightTime
            anchors.left: text_RunningDistance.right
            anchors.leftMargin: 10
            anchors.top: text_RunningDistance.top
            title: "航时(h):"
            pixelSize: 18
            titleWidth: pixelSize * 4
            width: 170
            height: 30
            onTextChanged: {
                addMountSchemeData.mountSchemeData.endurance = textToFloat(text)
            }
        }

        CTextInput{
            id:text_FightRadius
            anchors.left: text_FlightTime.right
            anchors.leftMargin: 10
            anchors.top: text_FlightTime.top
            title: "作战半径(km):"
            pixelSize: 18
            titleWidth: pixelSize * 6.5
            width: 170
            height: 30
            onTextChanged: {
                addMountSchemeData.mountSchemeData.fightRadius = textToFloat(text)
            }
        }

        Rectangle{
            id:rect_mountList
            anchors.left: text_RunningDistance.left
            anchors.top: text_RunningDistance.bottom
            anchors.topMargin: 20
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 10
            width: parent.width - 20
            color: "transparent"

            CText{
                id:text_Mount
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.topMargin: 25
                pixelSize: 20
                width: pixelSize * 3.5
                horizontalAlignment: Text.AlignLeft
                text: "挂载点："
            }

            CButton{
                id:btn_Mount1
                anchors.left: text_Mount.right
                anchors.leftMargin: 30
                anchors.verticalCenter: text_Mount.verticalCenter
                width: 40
                height: 40
                text: "1"
                radius: width / 2
                onClicked: {
                    isSelect = !isSelect
                    isMount1Select = isSelect
                    //
                }
            }

            CButton{
                id:btn_Mount2
                anchors.left: btn_Mount1.right
                anchors.leftMargin: 30
                anchors.verticalCenter: text_Mount.verticalCenter
                width: 40
                height: 40
                text: "2"
                radius: width / 2
                onClicked: {
                    isSelect = !isSelect
                    isMount2Select = isSelect
                    //
                }
            }

            CButton{
                id:btn_Mount3
                anchors.left: btn_Mount2.right
                anchors.leftMargin: 30
                anchors.verticalCenter: text_Mount.verticalCenter
                width: 40
                height: 40
                text: "3"
                radius: width / 2
                onClicked: {
                    isSelect = !isSelect
                    isMount3Select = isSelect
                    //
                }
            }

            CButton{
                id:btn_Mount4
                anchors.left: btn_Mount3.right
                anchors.leftMargin: 30
                anchors.verticalCenter: text_Mount.verticalCenter
                width: 40
                height: 40
                text: "4"
                radius: width / 2
                onClicked: {
                    isSelect = !isSelect
                    isMount4Select = isSelect
                    //
                }
            }

            CButton{
                id:btn_Mount5
                anchors.left: btn_Mount4.right
                anchors.leftMargin: 30
                anchors.verticalCenter: text_Mount.verticalCenter
                width: 40
                height: 40
                text: "5"
                radius: width / 2
                onClicked: {
                    isSelect = !isSelect
                    isMount5Select = isSelect
                    //
                }
            }

            CButton{
                id:btn_Mount6
                anchors.left: btn_Mount5.right
                anchors.leftMargin: 30
                anchors.verticalCenter: text_Mount.verticalCenter
                width: 40
                height: 40
                text: "6"
                radius: width / 2
                onClicked: {
                    isSelect = !isSelect
                    isMount6Select = isSelect
                    //
                }
            }

            CButton{
                id:btn_Mount7
                anchors.left: btn_Mount6.right
                anchors.leftMargin: 30
                anchors.verticalCenter: text_Mount.verticalCenter
                width: 40
                height: 40
                text: "7"
                radius: width / 2
                onClicked: {
                    isSelect = !isSelect
                    isMount7Select = isSelect
                    //
                }
            }

            CButton{
                id:btn_Mount8
                anchors.left: btn_Mount7.right
                anchors.leftMargin: 30
                anchors.verticalCenter: text_Mount.verticalCenter
                width: 40
                height: 40
                text: "8"
                radius: width / 2
                onClicked: {
                    isSelect = !isSelect
                    isMount8Select = isSelect
                    //
                }
            }

            CButton{
                id:btn_Mount9
                anchors.left: btn_Mount8.right
                anchors.leftMargin: 30
                anchors.verticalCenter: text_Mount.verticalCenter
                width: 40
                height: 40
                text: "9"
                radius: width / 2
                onClicked: {
                    isSelect = !isSelect
                    isMount9Select = isSelect
                    //
                }
            }

            CButton{
                id:btn_Mount10
                anchors.left: btn_Mount9.right
                anchors.leftMargin: 30
                anchors.verticalCenter: text_Mount.verticalCenter
                width: 40
                height: 40
                text: "10"
                radius: width / 2
                onClicked: {
                    isSelect = !isSelect
                    isMount10Select = isSelect
                    //
                }
            }


            CText{
                id:text_MountPlace
                anchors.left: parent.left
                anchors.top: text_Mount.bottom
                anchors.topMargin: 70
                pixelSize: 20
                width: pixelSize * 4.5
                horizontalAlignment: Text.AlignHCenter
//                color: "#4EC4FF"
                text: "挂点位置:"
            }


            Text{
                id:btn_MountNum1Place
                anchors.top: text_MountPlace.top
                anchors.horizontalCenter: btn_Mount1.horizontalCenter
                width: font.pixelSize
                color: mainColor
                font.pixelSize: 18
                font.family: "黑体"
                wrapMode: Text.WrapAnywhere
                horizontalAlignment: Text.AlignHCenter
                text:sMountNum1Place
                visible: isMount1Select
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        openMountPlace(1)
                    }
                }
            }

            Text{
                id:btn_MountNum2Place
                anchors.top: text_MountPlace.top
                anchors.horizontalCenter: btn_Mount2.horizontalCenter
                width: font.pixelSize
                color: mainColor
                font.pixelSize: 18
                font.family: "黑体"
                wrapMode: Text.WrapAnywhere
                horizontalAlignment: Text.AlignHCenter
                text:sMountNum2Place
                visible: isMount2Select
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        openMountPlace(2)
                    }
                }
            }

            Text{
                id:btn_MountNum3Place
                anchors.top: text_MountPlace.top
                anchors.horizontalCenter: btn_Mount3.horizontalCenter
                width: font.pixelSize
                color: mainColor
                font.pixelSize: 18
                font.family: "黑体"
                wrapMode: Text.WrapAnywhere
                horizontalAlignment: Text.AlignHCenter
                text:sMountNum3Place
                visible: isMount3Select
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        openMountPlace(3)
                    }
                }
            }

            Text{
                id:btn_MountNum4Place
                anchors.top: text_MountPlace.top
                anchors.horizontalCenter: btn_Mount4.horizontalCenter
                width: font.pixelSize
                color: mainColor
                font.pixelSize: 18
                font.family: "黑体"
                wrapMode: Text.WrapAnywhere
                horizontalAlignment: Text.AlignHCenter
                text:sMountNum4Place
                visible: isMount4Select
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        openMountPlace(4)
                    }
                }
            }

            Text{
                id:btn_MountNum5Place
                anchors.top: text_MountPlace.top
                anchors.horizontalCenter: btn_Mount5.horizontalCenter
                width: font.pixelSize
                color: mainColor
                font.pixelSize: 18
                font.family: "黑体"
                wrapMode: Text.WrapAnywhere
                horizontalAlignment: Text.AlignHCenter
                text:sMountNum5Place
                visible: isMount5Select
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        openMountPlace(5)
                    }
                }
            }

            Text{
                id:btn_MountNum6Place
                anchors.top: text_MountPlace.top
                anchors.horizontalCenter: btn_Mount6.horizontalCenter
                width: font.pixelSize
                color: mainColor
                font.pixelSize: 18
                font.family: "黑体"
                wrapMode: Text.WrapAnywhere
                horizontalAlignment: Text.AlignHCenter
                text:sMountNum6Place
                visible: isMount6Select
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        openMountPlace(6)
                    }
                }
            }

            Text{
                id:btn_MountNum7Place
                anchors.top: text_MountPlace.top
                anchors.horizontalCenter: btn_Mount7.horizontalCenter
                width: font.pixelSize
                color: mainColor
                font.pixelSize: 18
                font.family: "黑体"
                wrapMode: Text.WrapAnywhere
                horizontalAlignment: Text.AlignHCenter
                text:sMountNum7Place
                visible: isMount7Select
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        openMountPlace(7)
                    }
                }
            }

            Text{
                id:btn_MountNum8Place
                anchors.top: text_MountPlace.top
                anchors.horizontalCenter: btn_Mount8.horizontalCenter
                width: font.pixelSize
                color: mainColor
                font.pixelSize: 18
                font.family: "黑体"
                wrapMode: Text.WrapAnywhere
                horizontalAlignment: Text.AlignHCenter
                text:sMountNum8Place
                visible: isMount8Select
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        openMountPlace(8)
                    }
                }
            }

            Text{
                id:btn_MountNum9Place
                anchors.top: text_MountPlace.top
                anchors.horizontalCenter: btn_Mount9.horizontalCenter
                width: font.pixelSize
                color: mainColor
                font.pixelSize: 18
                font.family: "黑体"
                wrapMode: Text.WrapAnywhere
                horizontalAlignment: Text.AlignHCenter
                text:sMountNum9Place
                visible: isMount9Select
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        openMountPlace(9)
                    }
                }
            }


            Text{
                id:btn_MountNum10Place
                anchors.top: text_MountPlace.top
                anchors.horizontalCenter: btn_Mount10.horizontalCenter
                width: font.pixelSize
                color: mainColor
                font.pixelSize: 18
                font.family: "黑体"
                wrapMode: Text.WrapAnywhere
                horizontalAlignment: Text.AlignHCenter
                text:sMountNum10Place
                visible: isMount10Select
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        openMountPlace(10)
                    }
                }
            }

            CText{
                id:text_MountLoadingAmmo
                anchors.left: parent.left
                anchors.top: text_MountPlace.bottom
                anchors.topMargin: 100
                pixelSize: 20
                width: pixelSize * 4.5
                horizontalAlignment: Text.AlignHCenter
//                color: "#4EC4FF"
                text: "挂载弹药:"
            }

            Text{
                id:btn_MountNum1AmmoType
                anchors.top: text_MountLoadingAmmo.top
                anchors.horizontalCenter: btn_Mount1.horizontalCenter
                width: font.pixelSize
                color: mainColor
                font.pixelSize: 18
                font.family: "黑体"
                wrapMode: Text.WrapAnywhere
                horizontalAlignment: Text.AlignHCenter
                text:sMountNum1AmmoType
                visible: isMount1Select
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        openAmmoType(1)
                    }
                }
                onTextChanged: {

                }
            }

            Text{
                id:btn_MountNum2AmmoType
                anchors.top: text_MountLoadingAmmo.top
                anchors.horizontalCenter: btn_Mount2.horizontalCenter
                width: font.pixelSize
                color: mainColor
                font.pixelSize: 18
                font.family: "黑体"
                wrapMode: Text.WrapAnywhere
                horizontalAlignment: Text.AlignHCenter
                text:sMountNum2AmmoType
                visible: isMount2Select
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        openAmmoType(2)
                    }
                }
            }

            Text{
                id:btn_MountNum3AmmoType
                anchors.top: text_MountLoadingAmmo.top
                anchors.horizontalCenter: btn_Mount3.horizontalCenter
                width: font.pixelSize
                color: mainColor
                font.pixelSize: 18
                font.family: "黑体"
                wrapMode: Text.WrapAnywhere
                horizontalAlignment: Text.AlignHCenter
                text:sMountNum3AmmoType
                visible: isMount3Select
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        openAmmoType(3)
                    }
                }
            }

            Text{
                id:btn_MountNum4AmmoType
                anchors.top: text_MountLoadingAmmo.top
                anchors.horizontalCenter: btn_Mount4.horizontalCenter
                width: font.pixelSize
                color: mainColor
                font.pixelSize: 18
                font.family: "黑体"
                wrapMode: Text.WrapAnywhere
                horizontalAlignment: Text.AlignHCenter
                text:sMountNum4AmmoType
                visible: isMount4Select
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        openAmmoType(4)
                    }
                }
            }

            Text{
                id:btn_MountNum5AmmoType
                anchors.top: text_MountLoadingAmmo.top
                anchors.horizontalCenter: btn_Mount5.horizontalCenter
                width: font.pixelSize
                color: mainColor
                font.pixelSize: 18
                font.family: "黑体"
                wrapMode: Text.WrapAnywhere
                horizontalAlignment: Text.AlignHCenter
                text:sMountNum5AmmoType
                visible: isMount5Select
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        openAmmoType(5)
                    }
                }
            }

            Text{
                id:btn_MountNum6AmmoType
                anchors.top: text_MountLoadingAmmo.top
                anchors.horizontalCenter: btn_Mount6.horizontalCenter
                width: font.pixelSize
                color: mainColor
                font.pixelSize: 18
                font.family: "黑体"
                wrapMode: Text.WrapAnywhere
                horizontalAlignment: Text.AlignHCenter
                text:sMountNum6AmmoType
                visible: isMount6Select
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        openAmmoType(6)
                    }
                }
            }

            Text{
                id:btn_MountNum7AmmoType
                anchors.top: text_MountLoadingAmmo.top
                anchors.horizontalCenter: btn_Mount7.horizontalCenter
                width: font.pixelSize
                color: mainColor
                font.pixelSize: 18
                font.family: "黑体"
                wrapMode: Text.WrapAnywhere
                horizontalAlignment: Text.AlignHCenter
                text:sMountNum7AmmoType
                visible: isMount7Select
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        openAmmoType(7)
                    }
                }
            }

            Text{
                id:btn_MountNum8AmmoType
                anchors.top: text_MountLoadingAmmo.top
                anchors.horizontalCenter: btn_Mount8.horizontalCenter
                width: font.pixelSize
                color: mainColor
                font.pixelSize: 18
                font.family: "黑体"
                wrapMode: Text.WrapAnywhere
                horizontalAlignment: Text.AlignHCenter
                text:sMountNum8AmmoType
                visible: isMount8Select
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        openAmmoType(8)
                    }
                }
            }

            Text{
                id:btn_MountNum9AmmoType
                anchors.top: text_MountLoadingAmmo.top
                anchors.horizontalCenter: btn_Mount9.horizontalCenter
                width: font.pixelSize
                color: mainColor
                font.pixelSize: 18
                font.family: "黑体"
                wrapMode: Text.WrapAnywhere
                horizontalAlignment: Text.AlignHCenter
                text:sMountNum9AmmoType
                visible: isMount9Select
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        openAmmoType(9)
                    }
                }
            }

            Text{
                id:btn_MountNum10AmmoType
                anchors.top: text_MountLoadingAmmo.top
                anchors.horizontalCenter: btn_Mount10.horizontalCenter
                width: font.pixelSize
                color: mainColor
                font.pixelSize: 18
                font.family: "黑体"
                wrapMode: Text.WrapAnywhere
                horizontalAlignment: Text.AlignHCenter
                text:sMountNum10AmmoType
                visible: isMount10Select
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        openAmmoType(10)
                    }
                }
            }

            ListView{
                //挂点位置 单选
                id:view_List_MountPlace
                width: 140
                height: 36 * 5
                x:btn_MountNum1Place.x + btn_MountNum1Place.width + 2
                visible: false
                clip: true
                model:ListModel{
                    id:listmodel_MountPlace
                }
                delegate:Component{
                    Item{
                        id:item_Delegate
                        width: view_List_MountPlace.width
                        height: 36
                        CButton{
                            id:comp_TypeBtn
                            anchors.fill: parent
                            text:m_TypeName
                            color:"#ffddaa00"
                            borderColor: "#ffddaa00"
                            pixelSize: 17
                            onClicked: {
                                view_List_MountPlace.visible = false
                                m_SelectState = !m_SelectState
                                switch(currentMountPlaceSelect)
                                {
                                case 1: sMountNum1Place = text
                                    addMountSchemeData.mountSchemeData.oneHangingPoint = "1";
                                    addMountSchemeData.mountSchemeData.oneLocation = text;
                                    break
                                case 2: sMountNum2Place = text
                                    addMountSchemeData.mountSchemeData.twoHangingPoint = "2";
                                    addMountSchemeData.mountSchemeData.twoLocation = text;
                                    break
                                case 3: sMountNum3Place = text
                                    addMountSchemeData.mountSchemeData.threeHangingPoint = "3";
                                    addMountSchemeData.mountSchemeData.threeLocation = text;
                                    break
                                case 4: sMountNum4Place = text
                                    addMountSchemeData.mountSchemeData.fourHangingPoint = "4";
                                    addMountSchemeData.mountSchemeData.fourLocation = text;
                                    break
                                case 5: sMountNum5Place = text
                                    addMountSchemeData.mountSchemeData.fiveHangingPoint = "5";
                                    addMountSchemeData.mountSchemeData.fiveLocation = text;
                                    break
                                case 6: sMountNum6Place = text
                                    addMountSchemeData.mountSchemeData.sixHangingPoint = "6";
                                    addMountSchemeData.mountSchemeData.sixLocation = text;
                                    break
                                case 7: sMountNum7Place = text
                                    addMountSchemeData.mountSchemeData.sevenHangingPoint = "7";
                                    addMountSchemeData.mountSchemeData.sevenLocation = text;
                                    break
                                case 8: sMountNum8Place = text
                                    addMountSchemeData.mountSchemeData.eightHangingPoint = "8";
                                    addMountSchemeData.mountSchemeData.eightLocation = text;
                                    break
                                case 9: sMountNum9Place = text
                                    addMountSchemeData.mountSchemeData.nineHangingPoint = "9";
                                    addMountSchemeData.mountSchemeData.nineLocation = text;
                                    break
                                case 10: sMountNum10Place = text
                                    addMountSchemeData.mountSchemeData.tenHangingPoint = "10";
                                    addMountSchemeData.mountSchemeData.tenLocation = text;
                                    break
                                }
                            }
                        }
                    }
                }

                Component.onCompleted: {
                   var uavMountData = uavMountLocationDaoTableModel.selectUavMountLocationAllData()
                   var result = uavMountData.map(function(item) {
                        return {
                            m_SelectState: item.checked,
                            m_PlanNumber: item.recordId,
                            m_TypeName: item.uavModelName
                        }
                    })

                   listmodel_MountPlace.append(result)
                }
            }

            ListView{
                //弹药设置 单选
                id:view_List_MountAmmoType
                width: 140
                height: 36 * 5
                x:btn_MountNum1AmmoType.x + btn_MountNum1AmmoType.width + 2
                visible: false
                clip: true
                model:ListModel{
                    id:listmodel_MountAmmoType
                }
                delegate:Component{
                    Item{
                        id:item_Delegate
                        width: view_List_MountAmmoType.width
                        height: 36
                        CButton{
                            id:comp_TypeBtn
                            anchors.fill: parent
                            text:m_TypeName
                            color:"#ffddaa00"
                            borderColor: "#ffddaa00"
                            pixelSize: 17
                            onClicked: {
                                view_List_MountAmmoType.visible = false
                                m_SelectState = !m_SelectState

                                switch(currentAmmoTypeSelect)
                                {
                                case 1: sMountNum1AmmoType = text
                                    addMountSchemeData.mountSchemeData.oneAmmoName = text;
                                    break
                                case 2: sMountNum2AmmoType = text
                                    addMountSchemeData.mountSchemeData.twoAmmoName = text;
                                    break
                                case 3: sMountNum3AmmoType = text
                                    addMountSchemeData.mountSchemeData.threeAmmoName = text;
                                    break
                                case 4: sMountNum4AmmoType = text
                                    addMountSchemeData.mountSchemeData.fourAmmoName = text;
                                    break
                                case 5: sMountNum5AmmoType = text
                                    addMountSchemeData.mountSchemeData.fiveAmmoName = text;
                                    break
                                case 6: sMountNum6AmmoType = text
                                    addMountSchemeData.mountSchemeData.sixAmmoName = text;
                                    break
                                case 7: sMountNum7AmmoType = text
                                    addMountSchemeData.mountSchemeData.sevenAmmoName = text;
                                    break
                                case 8: sMountNum8AmmoType = text
                                    addMountSchemeData.mountSchemeData.eightAmmoName = text;
                                    break
                                case 9: sMountNum9AmmoType = text
                                    addMountSchemeData.mountSchemeData.nineAmmoName = text;
                                    break
                                case 10: sMountNum10AmmoType = text
                                    addMountSchemeData.mountSchemeData.tenAmmoName = text;
                                    break
                                }
                            }
                        }
                    }
                }

                Component.onCompleted: {
                    var ammoQueryData = new Object
                    ammoQueryData.ammoType = "请选择:"
                    ammoQueryData.ammoName = ""
                    var ammoData = ammoDaoModel.selectAmmoAllData(ammoQueryData)
                   var extractedData = ammoData.map(function(item) {
                                return {
                                    m_SelectState: item.checked,
                                    m_PlanNumber: item.recordId,
                                    m_TypeName: item.ammoName
                                }
                            })
                    //addMountSchemeData.mountLocationArray = addMountSchemeData.ammoName
                    console.log("<>"+"ammoData"+JSON.stringify(ammoData))
                    listmodel_MountAmmoType.append(extractedData)//({m_PlanNumber:0,m_SelectState:false,m_TypeName:"弹药1"})

                }
            }
        }

    }


    CButton{
        id:btn_Cancel
        anchors.right: parent.right
        anchors.rightMargin: 10
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        width: 90
        height: 36
        text: "取消"
        onClicked: {
           backMountingScheme()
           addMountSchemeData.visible = false
        }
    }
    CButton{
        id:btn_Confir
        anchors.right: btn_Cancel.left
        anchors.rightMargin: 10
        anchors.top: btn_Cancel.top
        width: 90
        height: 36
        text: "确定"
        onClicked: {
            saveMountSchemrData()
            backMountingScheme()
            addMountSchemeData.visible = false

        }
    }
    function init(){

        addMountSchemeData.mountSchemeData.mountSchemeName = "";
        addMountSchemeData.mountSchemeData.uavName = "";
        addMountSchemeData.mountSchemeData.maxTakeoffWeight = 0.0;
        addMountSchemeData.mountSchemeData.emptyWeight = 0.0;
        addMountSchemeData.mountSchemeData.oneHangingPoint = "";
        addMountSchemeData.mountSchemeData.oneLocation = "";
        addMountSchemeData.mountSchemeData.oneAmmoName = "";
        addMountSchemeData.mountSchemeData.twoHangingPoint = "";
        addMountSchemeData.mountSchemeData.twoLocation = "";
        addMountSchemeData.mountSchemeData.twoAmmoName = "";
        addMountSchemeData.mountSchemeData.threeHangingPoint = "";
        addMountSchemeData.mountSchemeData.threeLocation = "";
        addMountSchemeData.mountSchemeData.threeAmmoName = "";
        addMountSchemeData.mountSchemeData.fourHangingPoint = "";
        addMountSchemeData.mountSchemeData.fourLocation = "";
        addMountSchemeData.mountSchemeData.fourAmmoName = "";
        addMountSchemeData.mountSchemeData.fiveHangingPoint = "";
        addMountSchemeData.mountSchemeData.fiveLocation = "";
        addMountSchemeData.mountSchemeData.fiveAmmoName = "";
        addMountSchemeData.mountSchemeData.sixHangingPoint = "";
        addMountSchemeData.mountSchemeData.sixLocation = "";
        addMountSchemeData.mountSchemeData.sixAmmoName = "";
        addMountSchemeData.mountSchemeData.sevenHangingPoint = "";
        addMountSchemeData.mountSchemeData.sevenLocation = "";
        addMountSchemeData.mountSchemeData.sevenAmmoName = "";
        addMountSchemeData.mountSchemeData.eightHangingPoint = "";
        addMountSchemeData.mountSchemeData.eightLocation = "";
        addMountSchemeData.mountSchemeData.eightAmmoName = "";
        addMountSchemeData.mountSchemeData.nineHangingPoint = "";
        addMountSchemeData.mountSchemeData.nineLocation = "";
        addMountSchemeData.mountSchemeData.nineAmmoName = "";
        addMountSchemeData.mountSchemeData.tenHangingPoint = "";
        addMountSchemeData.mountSchemeData.tenLocation = "";
        addMountSchemeData.mountSchemeData.tenAmmoName = "";
        addMountSchemeData.mountSchemeData.runningDistance = 0.0;
        addMountSchemeData.mountSchemeData.endurance = 0.0;
        addMountSchemeData.mountSchemeData.fightRadius = 0.0;
        addMountSchemeData.mountSchemeData.maxFuel = 0.0;
        addMountSchemeData.mountSchemeData.maxExternalWeight = 0.0;
    }

   function textComponentEnable(){
       text_MaxTakeOffWeight.readOnly = true
       text_UavEmptyWeight.readOnly = true
       text_UavMaxFuelWeight.readOnly = true
       text_UavMaxExternalWeight.readOnly = true

       text_MaxTakeOffWeight.color = "#fff0cc55"
       text_UavEmptyWeight.color = "#fff0cc55"
       text_UavMaxFuelWeight.color = "#fff0cc55"
       text_UavMaxExternalWeight.color = "#fff0cc55"

       btn_Mount1.enabled = false;
       btn_Mount2.enabled = false;
       btn_Mount3.enabled = false;
       btn_Mount4.enabled = false;
       btn_Mount5.enabled = false;
       btn_Mount6.enabled = false;
       btn_Mount7.enabled = false;
       btn_Mount8.enabled = false;
       btn_Mount9.enabled = false;
       btn_Mount10.enabled = false;
   }
   function selectMount(data){
      // btn_Mount1.isSelect = true
      var location = data.hangingCapacity
       console.log("location"+JSON.stringify(location))
      var ammoResult = []
       // 将字符串 "1,3" 转换为数组
       var array = location.split(",");

       // 遍历 10 次循环
       for (var j = 0; j < array.length; j++){
           // 检查循环的次数是否与数组中的值相等
           // 遍历数组并打印每个值
                 for (var i=1;i<=10;i++) {
                      console.log("Array value at index", i, ":", array[j]);
                      if (i === 1 && parseInt(array[j]) === i){
                           btn_Mount1.isSelect = true
                          console.log("Matching value found:", i);
                      }else if(i === 2 && parseInt(array[j]) === i){
                          btn_Mount2.isSelect = true
                      }else if(i === 3 && parseInt(array[j]) === i){
                           btn_Mount3.isSelect = true
                      }else if(i === 4 && parseInt(array[j]) === i){
                           btn_Mount4.isSelect = true
                      }else if(i === 5 && parseInt(array[j]) === i){
                           btn_Mount5.isSelect = true
                      }else if(i === 6 && parseInt(array[j]) === i){
                           btn_Mount6.isSelect = true
                      }else if(i === 7 && parseInt(array[j]) === i){
                           btn_Mount7.isSelect = true
                      }else if(i === 8 && parseInt(array[j]) === i){
                           btn_Mount8.isSelect = true
                      }else if(i === 9 && parseInt(array[j]) === i){
                           btn_Mount9.isSelect = true
                      }else if(i === 10 && parseInt(array[j]) === i){
                           btn_Mount10.isSelect = true
                      }else {
                          console.log("Unknown hangingLocation!")
                      }
                  }
       }
   }
   //简便方案
   function selectMountMethod(data) {
       // 获取挂载能力字符串，例如 "1,3"
       var location = data.hangingCapacity;
       console.log("location", JSON.stringify(location));

       // 将字符串 "1,3" 转换为数组
       var array = location.split(",");

       // 遍历数组
       for (var j = 0; j < array.length; j++) {
           // 将数组中的字符串转换为数字
           var hangingLocation = parseInt(array[j], 10);

           // 根据挂载位置设置对应的按钮选中状态
           switch (hangingLocation) {
               case 1:
                   btn_Mount1.enabled = true;
                   btn_Mount1.isSelect = true;
                   console.log("Matching value found: 1");
                   break;
               case 2:
                   btn_Mount2.enabled = true;
                   btn_Mount2.isSelect = true;
                   break;
               case 3:
                   btn_Mount3.enabled = true;
                   btn_Mount3.isSelect = true;
                   break;
               case 4:
                   btn_Mount4.enabled = true;
                   btn_Mount4.isSelect = true;
                   break;
               case 5:
                   btn_Mount5.enabled = true;
                   btn_Mount5.isSelect = true;
                   break;
               case 6:
                   btn_Mount6.enabled = true;
                   btn_Mount6.isSelect = true;
                   break;
               case 7:
                   btn_Mount7.enabled = true;
                   btn_Mount7.isSelect = true;
                   break;
               case 8:
                   btn_Mount8.enabled = true;
                   btn_Mount8.isSelect = true;
                   break;
               case 9:
                   btn_Mount9.enabled = true;
                   btn_Mount9.isSelect = true;
                   break;
               case 10:
                   btn_Mount10.enabled = true;
                   btn_Mount10.isSelect = true;
                   break;
               default:
                   console.log("Unknown hangingLocation:", hangingLocation);
                   break;
           }
       }
   }
    function saveMountSchemrData(){
        console.log("AddMountSchemeData"+JSON.stringify(addMountSchemeData.mountSchemeData))
        let result = mountingSchemeDaoTableModel.insertMountingSchemeData(addMountSchemeData.mountSchemeData)
          if(result === true){
              warningItem.text = "^_^挂载方案新增数据成功!^_^"
              warningPopup.open()
              // 2秒后自动关闭
              autoCloseTimer.start()
          }else if(result === false){
              warningItem.text = "^_^挂载方案新增数据失败!^_^"
              warningPopup.open()
              // 2秒后自动关闭
              autoCloseTimer.start()
           }else{
              console.log("unknown deleteMountLocation")
          }

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
    function updateMountSchemeData(){

    }
}
