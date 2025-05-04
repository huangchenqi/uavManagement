import QtQuick 2.12
import QtQuick.Controls 2.12
import "qrc:/AddAmmoModules/Component"
//import AmmoKillingWayDaoModel 1.0
import AmmoGuidanceTypeDaoModel 1.0
import AmmoLaunchWayDaoModel 1.0

Item {
    id:item_Missile
    width: 550
    height: 100
    //——————对外参数接口——————
    //发射方式
    property int launchedType: -1
    property int lastLaunchedType: -1
    //导引规律
    property int guidRule: 0
    //制导方式
    property int guidType: -1
    property int lastGuidType: -1
    property int loadDataType: 0
    property var launchWay: ""
    property var guideWay: ""
    onLaunchedTypeChanged: {
        if(lastLaunchedType == launchedType)
            return
        if(lastLaunchedType > -1)
        {
            listmodel_Box.set(lastLaunchedType,{m_SelectState:false})
        }
    }
    onGuidTypeChanged: {
        if(lastGuidType == guidType)
            return
        if(lastGuidType > -1)
        {
            listmodel_Box_GuidType.set(lastGuidType,{m_SelectState:false})
        }
    }
    onLoadDataTypeChanged: {
        if(item_Missile.loadDataType === 1){
            //loadAllData()
            allComponentEnable()
        }else if(item_Missile.loadDataType === 2){
            //loadAllData()
        }else{
            console.log("Unknown loadDataType!")
        }
    }

    // AmmoKillingWayDaoTableModel{
    //     id:ammoKillingWayDaoTableModel
    // }
    AmmoGuidanceTypeDaoTableModel{
        id:ammoGuidanceTypeDaoTableModel
    }
    AmmoLaunchWayDaoTableModel{
        id:ammoLaunchWayDaoTableModel
    }
    Rectangle{
        anchors.fill: parent
        color:"#50000000"

        CText{
            id:text_Title
            text: "发射参数:"
            pixelSize: 25
            color: "#4EC4FF"
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.top: parent.top
            anchors.topMargin: 20
            horizontalAlignment: Text.AlignLeft
        }

        Rectangle{
            id:rect_data
            anchors.left: text_Title.left
            anchors.top: text_Title.bottom
            anchors.topMargin: 15
            anchors.right: parent.right
            anchors.rightMargin: 10
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 15
            border.width: 0
            border.color: mainColor
            color: "transparent"

            Rectangle {
                id: rect_LaunchedData
                height: 20
                color: "transparent"
                anchors.left: parent.left
                anchors.leftMargin: 5
                anchors.top: parent.top
                anchors.topMargin: 15
                width:(( parent.width ) / 3) - 10

                CText{
                    id:text_LaunchedDataTitle
                    width: pixelSize * 4.5
                    height: parent.height
                    anchors.left: parent.left
                    anchors.top: parent.top
                    pixelSize: 20
                    horizontalAlignment: Text.AlignLeft
                    color:mainColor
                    text:"发射方式: "
                }

                //显示区域
                CButton{
                    id:comp_LaunchedDataType
                    width: parent.width - text_LaunchedDataTitle.width
                    height: 36
                    color:"#ffddaa00"
                    borderColor: "#ffddaa00"
                    borderHigtColor: "#ffeebb22"
                    anchors.left: text_LaunchedDataTitle.right
                    anchors.verticalCenter: text_LaunchedDataTitle.verticalCenter
                    pixelSize: 20
                    text:{
                        if(launchedType < 0)
                        {
                            if(item_Missile.loadDataType === 1 ||item_Missile.loadDataType === 2){
                                return item_Missile.launchWay
                            }else{
                                return "请选择:"
                            }
                        }
                        else
                        {
                            if(listmodel_Box.count > 0)
                                listmodel_Box.get(launchedType).m_TypeName
                        }
                    }
                    onClicked: {
                        view_List_LaunchedData.visible = !view_List_LaunchedData.visible
                    }
                }

                ListView{
                    id:view_List_LaunchedData
                    width: comp_LaunchedDataType.width
                    height: comp_LaunchedDataType.height * 5
                    anchors.left: comp_LaunchedDataType.left
                    anchors.leftMargin: comp_LaunchedDataType.width/2 - width/2
                    anchors.top: comp_LaunchedDataType.bottom
                    anchors.topMargin: 2
                    visible: false
                    clip: true
                    model:ListModel{
                        id:listmodel_Box
                    }
                    delegate:Component{
                        Item{
                            id:item_Delegate
                            width: view_List_LaunchedData.width
                            height: 36
                            CButton{
                                id:comp_TypeBtn
                                anchors.fill: parent
                                text:m_TypeName
                                color:"#ffddaa00"
                                borderColor: "#ffddaa00"
                                borderHigtColor: "#ffeebb22"
                                pixelSize: 18
                                isSelect: m_SelectState
                                onClicked: {
                                    view_List_LaunchedData.visible = false
                                    //lastLaunchedType = launchedType

                                    // 清除所有按钮的选中状态
                                    for (var i = 0; i < listmodel_Box.count; i++) {
                                        listmodel_Box.setProperty(i, "m_SelectState", false);
                                    }
                                    launchedType = index
                                    m_SelectState = true
                                    newAmmoData.ammoData.launch_way =m_PlanNumber
                                    console.log("Text content changed to: " + newAmmoData.ammoData.launch_way)
                                }
                            }
                        }
                    }
                    Component.onCompleted: {
                        var ammoAmmoLaunchWayData = ammoLaunchWayDaoTableModel.selectAmmoLaunchWayAllData()
                        console.log("ammoAmmoLaunchWayData"+JSON.stringify(ammoAmmoLaunchWayData))
                        var result = [];
                        for (var i = 0; i < ammoAmmoLaunchWayData.length; i++) {
                            result.push({
                                m_PlanNumber: ammoAmmoLaunchWayData[i].recordId,
                                m_SelectState:false,// ammoType[i].checked,
                                m_TypeName: ammoAmmoLaunchWayData[i].ammoComponeName
                            });
                        }
                        if(item_Missile.loadDataType === 1 || item_Missile.loadDataType === 2){
                            //console.log("<~>"+newAmmoData.ammoSelectData.aerodynamic_configuration)
                            newAmmoData.ammoData.launch_way = newAmmoData.ammoSelectData.launch_way
                            // 遍历数组 a 和 b，更新 m_SelectState
                            for (var j = 0; j < result.length; j++) {
                                if (result[j].m_PlanNumber === newAmmoData.ammoSelectData.launch_way) {
                                    result[j].m_SelectState = true;
                                    item_Missile.launchWay = result[j].m_TypeName
                                    console.log("</>"+result[j].m_PlanNumber+"<,>"+result[j].m_TypeName)
                                }
                            }
                        }else{
                            console.log("Unknown loadDataType!")
                        }
                       listmodel_Box.append(result);
                        console.log("ammoAmmoLaunchWayData"+JSON.stringify(result))
                    }
                }
            }

            Rectangle {
                id: rect_GuidRuleData
                height: 20
                color: "transparent"
                anchors.left: rect_LaunchedData.right
                anchors.leftMargin: 10
                visible: false
                anchors.top: parent.top
                anchors.topMargin: 15
                width:(( parent.width ) / 3) - 10

                CText{
                    id:text_GuidRuleDataTitle
                    width: pixelSize * 4.5
                    height: parent.height
                    anchors.left: parent.left
                    anchors.top: parent.top
                    pixelSize: 20
                    horizontalAlignment: Text.AlignLeft
                    color:mainColor
                    text:"导引规律: "
                }

                ListView{
                    id:view_List_GuidRuleData
                    width: comp_GuidRuleType.width
                    height: comp_GuidRuleType.height * 5
                    anchors.left: comp_GuidRuleType.left
                    anchors.leftMargin: comp_GuidRuleType.width/2 - width/2
                    anchors.top: comp_GuidRuleType.bottom
                    anchors.topMargin: 2
                    visible: false
                    clip: true
                    model:ListModel{
                        id:listmodel_Box_GuidRule
                    }
                    delegate:Component{
                        Item{
                            id:item_Delegate
                            width: view_List_GuidRuleData.width
                            height: 36
                            CButton{
                                id:comp_TypeBtn
                                anchors.fill: parent
                                text:m_TypeName
                                color:"#ffddaa00"
                                borderColor: "#ffddaa00"
                                borderHigtColor: "#ffeebb22"
                                pixelSize: 18
                                onClicked: {
                                    view_List_GuidRuleData.visible = false
                                    guidRule = index
                                    m_SelectState = !m_SelectState
                                }
                            }
                        }
                    }
                    Component.onCompleted: {
                        listmodel_Box_GuidRule.append({m_Number:0,m_SelectState:false,m_TypeName:"方式1"})
                        listmodel_Box_GuidRule.append({m_Number:1,m_SelectState:false,m_TypeName:"方式2"})
                    }
                }
                //显示区域
                CButton{
                    id:comp_GuidRuleType
                    width: parent.width - text_GuidRuleDataTitle.width
                    height: 36
                    color:"#ffddaa00"
                    borderColor: "#ffddaa00"
                    borderHigtColor: "#ffeebb22"
                    anchors.left: text_GuidRuleDataTitle.right
                    anchors.verticalCenter: text_GuidRuleDataTitle.verticalCenter
                    pixelSize: 20
                    text:"请选择:"/*{
                        if(guidRule < 0)
                        {
                            return "方式1"
                        }
                        else
                        {
                            if(listmodel_Box_GuidRule.count > 0)
                                listmodel_Box_GuidRule.get(guidRule).m_TypeName
                        }
                    }*/
                    onClicked: {
                        view_List_GuidRuleData.visible = !view_List_GuidRuleData.visible
                    }
                }
            }

            Rectangle {
                id: rect_GuidTypeData
                height: 20
                color: "transparent"
                anchors.left: rect_LaunchedData.right
                anchors.leftMargin: 10
                anchors.top: parent.top
                anchors.topMargin: 15
                width:(( parent.width ) / 3) - 10

                CText{
                    id:text_GuidTypeDataTitle
                    width: pixelSize * 4.5
                    height: parent.height
                    anchors.left: parent.left
                    anchors.top: parent.top
                    pixelSize: 20
                    horizontalAlignment: Text.AlignLeft
                    color:mainColor
                    text:"制导方式: "
                }
                //显示区域
                CButton{
                    id:comp_GuidType
                    width: parent.width - text_GuidTypeDataTitle.width
                    height: 36
                    color:"#ffddaa00"
                    borderColor: "#ffddaa00"
                    borderHigtColor: "#ffeebb22"
                    anchors.left: text_GuidTypeDataTitle.right
                    anchors.verticalCenter: text_GuidTypeDataTitle.verticalCenter
                    pixelSize: 20
                    text:{
                        if(guidType < 0)
                        {
                            if(item_Missile.loadDataType === 1 ||item_Missile.loadDataType === 2){
                                return item_Missile.guideWay
                            }else{
                                return "请选择:"
                            }
                        }
                        else
                        {
                            if(listmodel_Box_GuidType.count > 0)
                                listmodel_Box_GuidType.get(guidType).m_TypeName
                        }
                    }
                    onClicked: {
                        view_List_GuidTypeData.visible = !view_List_GuidTypeData.visible
                    }
                }

                ListView{
                    id:view_List_GuidTypeData
                    width: comp_GuidType.width
                    height: comp_GuidType.height * 5
                    anchors.left: comp_GuidType.left
                    anchors.leftMargin: comp_GuidType.width/2 - width/2
                    anchors.top: comp_GuidType.bottom
                    anchors.topMargin: 2
                    visible: false
                    clip: true
                    model:ListModel{
                        id:listmodel_Box_GuidType
                    }
                    delegate:Component{
                        Item{
                            id:item_Delegate
                            width: view_List_GuidTypeData.width
                            height: 36
                            CButton{
                                id:comp_TypeBtn
                                anchors.fill: parent
                                text:m_TypeName
                                color:"#ffddaa00"
                                borderColor: "#ffddaa00"
                                borderHigtColor: "#ffeebb22"
                                pixelSize: 18
                                isSelect: m_SelectState
                                onClicked: {
                                    view_List_GuidTypeData.visible = false
                                    //lastGuidType = guidType
                                    // 清除所有按钮的选中状态
                                    for (var i = 0; i < listmodel_Box_GuidType.count; i++) {
                                        listmodel_Box_GuidType.setProperty(i, "m_SelectState", false);
                                    }
                                    guidType = index
                                    m_SelectState = true
                                    newAmmoData.ammoData.guidance_way =m_PlanNumber
                                    console.log("Text content changed to: " + newAmmoData.ammoData.guidance_way)
                                }
                            }
                        }
                    }
                    Component.onCompleted: {

                        var ammoGuidanceTypeData = ammoGuidanceTypeDaoTableModel.selectAmmoGuidanceTypeAllData()
                        console.log("ammoGuidanceTypeData"+JSON.stringify(ammoGuidanceTypeData))
                        var result = [];
                        for (var i = 0; i < ammoGuidanceTypeData.length; i++) {
                            result.push({
                                m_PlanNumber: ammoGuidanceTypeData[i].recordId,
                                m_SelectState:false,// ammoType[i].checked,
                                m_TypeName: ammoGuidanceTypeData[i].ammoComponeName
                            });
                        }
                        if(item_Missile.loadDataType === 1 || item_Missile.loadDataType === 2){
                            //console.log("<~>"+newAmmoData.ammoSelectData.aerodynamic_configuration)
                            newAmmoData.ammoData.guidance_way = newAmmoData.ammoSelectData.guidance_way
                            // 遍历数组 a 和 b，更新 m_SelectState
                            for (var j = 0; j < result.length; j++) {
                                if (result[j].m_PlanNumber === newAmmoData.ammoSelectData.guidance_way) {
                                    result[j].m_SelectState = true;
                                    item_Missile.guideWay = result[j].m_TypeName
                                    console.log("</>"+result[j].m_PlanNumber+"<,>"+result[j].m_TypeName)
                                }
                            }
                        }else{
                            console.log("Unknown loadDataType!")
                        }
                       listmodel_Box_GuidType.append(result);
                        console.log("ammoAmmoLaunchWayData"+JSON.stringify(result))
                    }
                }
            }

        }
    }
    function allComponentEnable(){
      view_List_LaunchedData.enabled = false
       view_List_GuidTypeData.enabled = false
    }

    function loadAllData(){
        //newAmmoData.ammoSelectData
    }
}
