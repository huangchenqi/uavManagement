import QtQuick 2.12
import QtQuick.Controls 2.12
import "qrc:/AddAmmoModules/Component"
import AmmoAerodynamicConfigurationDaoModel 1.0

Item {
    id:item_Missile
    width: 280
    height: 250
    //——————对外参数接口——————
    //工作条件
    property int workCondition: -1
    property int lastWorkCondition: -1
    //气动布局
    property int aerodynamicConfiguration: -1
    property int lastAerodynamicConfiguration: -1
    property int loadAllData: 0
    onWorkConditionChanged: {

        console.log("condition:",workCondition)
        if(lastWorkCondition == workCondition)
            return
        if(lastWorkCondition > -1){
            listmodel_Box.set(lastWorkCondition,{m_SelectState:false})
        }
    }   
    //signal workCondition(var indexStr)
    // Connections {
    //     target: item_Missile
    //     onWorkCondition: {
    //         console.log("connectuion!!!!!")
    //         comp_WorkFactorType.text = "asa7bdyv"
    //     }
    // }


    onAerodynamicConfigurationChanged: {
        if(lastWorkCondition == workCondition)
            return
        if(lastAerodynamicConfiguration > -1)
            listmodel_Box_AerodynamicConfiguration.set(lastAerodynamicConfiguration,{m_SelectState:false})
    }
    onLoadAllDataChanged: {
        if(item_Missile.loadAllData === 1 ){
            console.log("<><><>")
            loadAmmoData()
            allComponentEnable()
        }else if(item_Missile.loadAllData === 2){
            loadAmmoData()
        }else{
            console.log("Unknown selectType!")
        }
    }

    AmmoAerodynamicConfigurationDaoTableModel{
        id:ammoAerodynamicConfigurationDaoTableModel
    }
    Rectangle{
        anchors.fill: parent
        color:"#50000000"

        CText{
            id:text_Title
            text: "工作参数:"
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
                id: rect_WorkCondition
                height: 20
                color: "transparent"
                anchors.left: parent.left
                anchors.leftMargin: 5
                anchors.top: parent.top
                anchors.topMargin: 15
                width:( parent.width ) - 10

                CText{
                    id:text_WorkTemperatureTitle
                    width: pixelSize * 8.5
                    height: 20
                    anchors.left: rect_WorkCondition.left
                    anchors.top: rect_WorkCondition.bottom
                    anchors.topMargin: 20
                    pixelSize: 20
                    horizontalAlignment: Text.AlignLeft
                    color:mainColor
                    text:"工作环境温度(℃): "
                }
                Item{
                    width: parent.width - text_WorkTemperatureTitle.width - 5
                    height: parent.height
                    anchors.left:text_WorkTemperatureTitle.right
                    anchors.top: text_WorkTemperatureTitle.top
                    TextInput{
                        id:text_Input_WorkTemperature
                        anchors.fill: parent
                        color:"#ffffffff"
                        font.family:text_WorkTemperatureTitle.family
                        font.pixelSize:(18)
                        selectByMouse: true
                        selectionColor: "#ffcc8800"
                        onTextChanged: {
                            // if(text != "")
                            // {
                            //     //取值
                            // }
                            newAmmoData.ammoData.working_temperature =text
                            console.log("Text content changed to: " + text)
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

                CText{
                    id:text_WorkAltitudeTitle
                    width: pixelSize * 8
                    height: 20
                    anchors.left: text_WorkTemperatureTitle.left
                    anchors.top: text_WorkTemperatureTitle.bottom
                    anchors.topMargin: 20
                    pixelSize: 20
                    horizontalAlignment: Text.AlignLeft
                    color:mainColor
                    text:"工作海拔高度(m): "
                }

                Item{
                    width: parent.width - text_WorkAltitudeTitle.width - 5
                    height: parent.height
                    anchors.left:text_WorkAltitudeTitle.right
                    anchors.top: text_WorkAltitudeTitle.top
                    TextInput{
                        id:text_Input_WorkAlt
                        anchors.fill: parent
                        color:"#ffffffff"
                        font.family:text_WorkAltitudeTitle.family
                        font.pixelSize:(18)
                        selectByMouse: true
                        selectionColor: "#ffcc8800"
                        onTextChanged: {
                            // if(text != "")
                            // {
                            //     //取值
                            // }
                            newAmmoData.ammoData.working_altitude =text
                            console.log("Text content changed to: " + text)
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

                CText{
                    id:text_AerodynamicConfiguration
                    width: pixelSize * 4.5
                    height: parent.height
                    anchors.left: text_WorkAltitudeTitle.left
                    anchors.top: text_WorkAltitudeTitle.bottom
                    anchors.topMargin: 20
                    pixelSize: 20
                    horizontalAlignment: Text.AlignLeft
                    color:mainColor
                    text:"气动布局: "
                }

                ListView{
                    id:view_List_AerodynamicConfiguration
                    width: comp_AerodynamicConfiguration.width
                    height: comp_AerodynamicConfiguration.height * 5
                    anchors.left: comp_AerodynamicConfiguration.left
                    anchors.leftMargin: comp_AerodynamicConfiguration.width/2 - width/2
                    anchors.top: comp_AerodynamicConfiguration.bottom
                    anchors.topMargin: 2
                    visible: false
                    clip: true
                    model:ListModel{
                        id:listmodel_Box_AerodynamicConfiguration
                    }
                    delegate:Component{
                        Item{
                            id:item_Delegate
                            width: view_List_AerodynamicConfiguration.width
                            height: 36
                            CButton{
                                id:comp_TypeBtn
                                anchors.fill: parent
                                text:m_TypeName
                                color:"#ffddaa00"
                                borderHigtColor: "#ffeebb22"
                                pixelSize: 18
                                isSelect :m_SelectState
                                onClicked: {
                                    view_List_AerodynamicConfiguration.visible = false
                                    lastAerodynamicConfiguration = aerodynamicConfiguration
                                    aerodynamicConfiguration = index
                                    m_SelectState = true
                                    newAmmoData.ammoData.aerodynamic_configuration = m_PlanNumber
                                    console.log("Text aerodynamic_configurationcontent changed to: " + newAmmoData.ammoData.aerodynamic_configuration)

                                }
                            }
                        }
                    }
                    Component.onCompleted: {

                        var ammoAerodynamicConfigurationData = ammoAerodynamicConfigurationDaoTableModel.selectAmmoAerodynamicConfigurationAllData()
                        console.log("ammoAerodynamicConfigurationDao"+JSON.stringify(ammoAerodynamicConfigurationData))
                        var result = [];
                        for (var i = 0; i < ammoAerodynamicConfigurationData.length; i++) {
                            result.push({
                                m_PlanNumber: ammoAerodynamicConfigurationData[i].recordId,
                                m_SelectState:false,// ammoType[i].checked,
                                m_TypeName: ammoAerodynamicConfigurationData[i].ammoComponeName
                            });
                        }
                       listmodel_Box_AerodynamicConfiguration.append(result);
                        //console.log("listmodel_Box_AerodynamicConfiguration"+JSON.stringify(result))
                    }
                }
                //显示区域
                CButton{
                    id:comp_AerodynamicConfiguration
                    width: parent.width - text_AerodynamicConfiguration.width
                    height: 36
                    color:"#ffddaa00"
                    borderColor: "#ffddaa00"
                    borderHigtColor: "#ffeebb22"
                    anchors.left: text_AerodynamicConfiguration.right
                    anchors.verticalCenter: text_AerodynamicConfiguration.verticalCenter
                    pixelSize: 20
                    text:{
                        if(aerodynamicConfiguration < 0)
                        {
                            return "请选择:"
                        }
                        else
                        {
                            if(listmodel_Box_AerodynamicConfiguration.count > 0)
                                listmodel_Box_AerodynamicConfiguration.get(aerodynamicConfiguration).m_TypeName
                        }
                    }
                    onClicked: {
                        view_List_AerodynamicConfiguration.visible = !view_List_AerodynamicConfiguration.visible
                    }
                }

                CText{
                    id:text_WorkConditionTitle
                    width: pixelSize * 4.5
                    height: parent.height
                    anchors.left: parent.left
                    anchors.top: parent.top
                    pixelSize: 20
                    horizontalAlignment: Text.AlignLeft
                    color:mainColor
                    text:"工作条件: "
                }
                //显示区域
                CButton{
                    id:comp_WorkFactorType
                    width: parent.width - text_WorkConditionTitle.width
                    height: 36

                    color:"#ffddaa00"
                    borderColor: "#ffddaa00"
                    borderHigtColor: "#ffeebb22"
                    anchors.left: text_WorkConditionTitle.right
                    anchors.verticalCenter: text_WorkConditionTitle.verticalCenter
                    pixelSize: 20
                    text:{
                        if(workCondition < 0)
                        {
                            return "请选择:"
                        }
                        else
                        {
                            if(listmodel_Box.count > 0)
                                listmodel_Box.get(workCondition).m_TypeName
                        }
                    }

                    onClicked: {
                        view_List_WorkCondition.visible = !view_List_WorkCondition.visible
                    }
                }

                ListView{
                    id:view_List_WorkCondition
                    width: comp_WorkFactorType.width
                    height: comp_WorkFactorType.height * 5
                    anchors.left: comp_WorkFactorType.left
                    anchors.leftMargin: comp_WorkFactorType.width/2 - width/2
                    anchors.top: comp_WorkFactorType.bottom
                    anchors.topMargin: 2
                    visible: false
                    clip: true
                    model:ListModel{
                        id:listmodel_Box
                    }
                    delegate:Component{
                        Item{
                            id:item_Delegate
                            width: view_List_WorkCondition.width
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
                                    view_List_WorkCondition.visible = false
                                    lastWorkCondition =  workCondition
                                    workCondition = index
                                    //workCondition(index)
                                    console.log("current workCondition:",workCondition)
                                    m_SelectState = true
                                    newAmmoData.ammoData.working_conditions =text
                                    console.log("工作条件: " + text)
                                }
                            }
                        }
                    }
                    Component.onCompleted: {
                        listmodel_Box.append({m_Number:0,m_SelectState:false,m_TypeName:"白天"})
                        listmodel_Box.append({m_Number:1,m_SelectState:false,m_TypeName:"夜晚"})
                    }
                }

            }
        }
    }
    function allComponentEnable(){
        text_Input_WorkTemperature.enabled = false
        text_Input_WorkAlt.enabled = false
    }

    function loadAmmoData(){
        console.log("newAmmoData.ammoData.ammoName"+newAmmoData.ammoSelectData.ammoName)
        //#pragma db not_null column("warhead_cg_distance") //warhead_cg_distance REAL NOT NULL ,--COMMENT '弹头端面至重心距离(m)',
      //  newAmmoData.ammoData.ammoWarheadCgDistance   = 0.0
        //#pragma db not_null column("charge_mass") //charge_mass REAL NOT NULL ,--COMMENT '炸弹装药质量(kg)',
       text_Input_WorkTemperature.text = newAmmoData.ammoSelectData.working_temperature
       text_Input_WorkAlt.text = newAmmoData.ammoSelectData.working_altitude

    //view_List_AerodynamicConfiguration  = newAmmoData.ammoData.aerodynamic_configuration
    // view_List_WorkCondition   = newAmmoData.ammoData.working_conditions


    }
}
