import QtQuick 2.0
import QtQuick.Dialogs 1.2
import "qrc:/"
import "qrc:/AddAmmoModules/Component"
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.5
import UavDaoModel 1.0
//无源干扰吊舱
Item {
    id:custom_PassiveInterferencePod

//    width: 600
//    height: 470
    // width: 1280
    // height: 900
    anchors.fill:parent
    //记录选择的机型数组
    property var useToUavArray: []
    // 获取当前时间并转换为字符串
    property var currentTime: new Date().toLocaleString()
    //干扰波段
    property int iBand: 0
    //干扰强度
    property int iIntensity: 0

    property int iLaunchControlType: 0

    property var effectiveReflectionArea: []

    signal backPayloadRecord()

    property int loadState: 0  //0:新增、1:查看、2:编辑

    Component.onCompleted: {
        loadView()
    }
    UavModelDaoTableModel{
        id:uavModelDao
    }
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
        id:rect_root
        anchors.fill: parent
        color:"#50000000"

        CText {
            id: title
            text: qsTr("无源干扰吊舱")
            pixelSize: 25
            width: pixelSize * 6
            color: "#4EC4FF"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 20
            horizontalAlignment: Text.AlignLeft
        }

        CTextInput{
            id:text_PodName
            anchors.left: parent.left
            anchors.leftMargin: 20
            anchors.top: title.bottom
            anchors.topMargin: 30
            title: "吊舱名称:"
            pixelSize: 18
            onlyNum: false
            titleWidth: pixelSize * 4.5
            width: 280
            height: 30
        }
        CText{
            id:uavType
            text: "对应无人机类型:"
            anchors.left: text_PodName.right
            anchors.leftMargin: 20
            anchors.top: title.bottom
            anchors.topMargin: 34
            //verticalAlignment:parent.verticalCenter
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
                        onClicked: {
                            view_List_TypeSelect.visible = false
                            //selectType = index
                            m_SelectState = !m_SelectState
                            isSelect = m_SelectState
                            // 检查数组中是否已经存在该数字
                                var uavIndex = useToUavArray.indexOf(m_PlanNumber)

                                if (uavIndex === -1) {
                                    // 数字不存在，添加到数组
                                    useToUavArray.push(m_PlanNumber)
                                    console.log("Number added: " + m_PlanNumber)
                                } else {
                                    // 数字已存在，从数组中删除
                                    useToUavArray.splice(uavIndex, 1)
                                    console.log("Number removed: " + m_PlanNumber)
                                }
                            // 检查数组中是否已经存在该数字
                            // if (!newAmmoData.useToUavArray.includes(m_PlanNumber)) {
                            //     newAmmoData.useToUavArray.push(m_PlanNumber) // 添加数字到数组
                            //     console.log("Number added: " + m_PlanNumber)
                            // } else {
                            //     console.log("Number already exists: " + m_PlanNumber)
                            // }
                            console.log("useToUavArray"+custom_PassiveInterferencePod.useToUavArray)

                        }
                    }
                }
            }
            Component.onCompleted: {

                var uavData = uavModelDao.selectUavModelAllData()
                console.log("uavModelDao"+JSON.stringify(uavData))
                var result = [];
                for (var i = 0; i < uavData.length; i++) {
                    result.push({
                        m_PlanNumber: uavData[i].recordId,
                        m_SelectState:false,// ammoType[i].checked,
                        m_TypeName: uavData[i].uavName
                    });
                }

                // if(missileCommonData.selectAmmoViewType === 1 ){
                //     var ammoToUavModel = newAmmoData.ammoSelectData.ammoToUavModel
                //     var a = ammoToUavModel.split(",");

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
                //     console.log("<!><@><#>")
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
            anchors.top: title.bottom
            anchors.topMargin: 30
            //anchors.verticalCenter: uavType.verticalCenter
            pixelSize: 20
            text:"请选择:"/*{
                if(selectType < 0)
                {
                    return "侦察无人机"
                }
                else
                {
                    if(listmodel_Box.count > 0)
                        listmodel_Box.get(selectType).m_TypeName
                }
            }*/
            onClicked: {
                view_List_TypeSelect.visible = !view_List_TypeSelect.visible
            }
        }

        CTextInput{
            id:text_MainCarbinLength
            // anchors.left: text_PodTotaloLength.left
            // anchors.top: text_PodTotaloLength.bottom
            // anchors.topMargin: 20
            anchors.left: parent.left
            anchors.leftMargin: 20
            anchors.top: text_PodName.bottom
            anchors.topMargin: 30
            title: "主舱长(mm):"
            pixelSize: 18
            titleWidth: pixelSize * 5.5
            width: 240
            height: 30
        }

        CTextInput{
            id:text_FrontHoodLength
            anchors.left: text_MainCarbinLength.right
            anchors.leftMargin: 30
            anchors.top: text_PodName.bottom
            anchors.topMargin: 30
            title: "前罩长(mm):"
            pixelSize: 18
            titleWidth: pixelSize * 5.5
            width: 240
            height: 30
        }

        CTextInput{
            id:text_BackHoodLength
            anchors.left: text_FrontHoodLength.right
            anchors.leftMargin: 30
            anchors.top: text_PodName.bottom
            anchors.topMargin: 30
            title: "后罩长(mm):"
            pixelSize: 18
            titleWidth: pixelSize * 5.5
            width: 240
            height: 30
        }
        CTextInput{
            id:text_MainCarbinSection
            anchors.left: text_MainCarbinLength.left
            //anchors.leftMargin: 20
            anchors.top: text_MainCarbinLength.bottom
            anchors.topMargin: 20
            title: "主舱截面(mm):"
            pixelSize: 18
            titleWidth: pixelSize * 6.5
            width: 240
            height: 30
        }
        CTextInput{
            id:text_LoadCapacity
            anchors.left: text_MainCarbinSection.right
            anchors.top: text_MainCarbinLength.bottom
            anchors.leftMargin: 30
            anchors.topMargin: 20
            title: "装载容量:"
            pixelSize: 18
            titleWidth: pixelSize * 4.5
            width: 240
            height: 30
        }
        CTextInput{
            id:text_PodTotaloLength
            anchors.left: text_LoadCapacity.right
            anchors.leftMargin: 30
            anchors.top: text_MainCarbinLength.bottom
            anchors.topMargin: 20
            title: "吊舱总长度(mm):"
            pixelSize: 18
            titleWidth: pixelSize * 7.5
            width: 240
            height: 30
        }

        // CTextInput{
        //     id:text_MainCarbinLength
        //     anchors.left: text_PodTotaloLength.left
        //     anchors.top: text_PodTotaloLength.bottom
        //     anchors.topMargin: 20
        //     title: "主舱长(mm):"
        //     pixelSize: 18
        //     titleWidth: pixelSize * 5.5
        //     width: 200
        //     height: 30
        // }

        // CTextInput{
        //     id:text_FrontHoodLength
        //     anchors.left: text_MainCarbinLength.left
        //     anchors.top: text_MainCarbinLength.bottom
        //     anchors.topMargin: 20
        //     title: "前罩长(mm):"
        //     pixelSize: 18
        //     titleWidth: pixelSize * 5.5
        //     width: 200
        //     height: 30
        // }

        // CTextInput{
        //     id:text_BackHoodLength
        //     anchors.left: text_FrontHoodLength.left
        //     anchors.top: text_FrontHoodLength.bottom
        //     anchors.topMargin: 20
        //     title: "后罩长(mm):"
        //     pixelSize: 18
        //     titleWidth: pixelSize * 5.5
        //     width: 200
        //     height: 30
        // }

        // CTextInput{
        //     id:text_MainCarbinSection
        //     anchors.left: text_PodTotaloLength.right
        //     anchors.leftMargin: 20
        //     anchors.top: text_PodTotaloLength.top
        //     title: "主舱截面(mm):"
        //     pixelSize: 18
        //     titleWidth: pixelSize * 6.5
        //     width: 200
        //     height: 30
        // }

        CTextInput{
            id:text_SinglePodWeight
            anchors.left: text_MainCarbinSection.left
            anchors.top: text_MainCarbinSection.bottom
            anchors.topMargin: 20
            title: "单吊舱自重(Kg):"
            pixelSize: 18
            titleWidth: pixelSize * 7.5
            width: 240
            height: 30
        }



        CTextInput{
            id:text_SinglePodFullLoadWeight
            anchors.left: text_SinglePodWeight.right
            anchors.leftMargin: 30
            anchors.top: text_MainCarbinSection.bottom
            anchors.topMargin: 20
            title: "单吊舱满载最大重量(Kg):"
            pixelSize: 18
            titleWidth: pixelSize * 11.5
            width: 500
            height: 30
        }

        CText{
            id:text_InterferenceBand
            anchors.left: text_SinglePodWeight.left
            anchors.top: text_SinglePodWeight.bottom
            anchors.topMargin: 30
            text: "干扰波段:"
            pixelSize: 18
            color: mainColor
            width: pixelSize * 4.5
            height: pixelSize
            bold: true
        }

        CButton{
            id:btn_InterferenceBand
            width: 160
            height: 36
            color:"#ffddaa00"
            borderColor: "#ffddaa00"
            borderHigtColor: "#ffeebb22"
            anchors.left: text_InterferenceBand.right
            anchors.verticalCenter: text_InterferenceBand.verticalCenter
            pixelSize: 20
            text: loadState == 1 ? "查看" : "请选择"/*{
                if(iBand < 0)
                {
                    return "波段1"
                }
                else
                {
                    if(listmodel_Box_Band.count > 0)
                        listmodel_Box_Band.get(iBand).m_TypeName
                }
            }*/
            onClicked: {
                view_List_Band.visible = !view_List_Band.visible
            }
        }

        ListView{
            //干扰波段ListView   多选
            id:view_List_Band
            width: btn_InterferenceBand.width
            height: btn_InterferenceBand.height * 5
            anchors.left: btn_InterferenceBand.left
            anchors.leftMargin: btn_InterferenceBand.width/2 - width/2
            anchors.top: btn_InterferenceBand.bottom
            anchors.topMargin: 2
            visible: false
            clip: true
            z: 1
            model:ListModel{
                id:listmodel_Box_Band
            }
            delegate:Component{
                Item{
                    id:item_Delegate
                    width: view_List_Band.width
                    height: 36
                    CButton{
                        id:comp_TypeBtn
                        anchors.fill: parent
                        text:m_TypeName
                        color:"#ffddaa00"
                        borderColor: "#ffddaa00"
                        pixelSize: 18
                        isSelect: m_SelectState
                        onClicked: {
                            view_List_Band.visible = false
                            iBand = index
                            m_SelectState = !m_SelectState
                        }
                    }
                }
            }
            Component.onCompleted: {
                listmodel_Box_Band.append({m_PlanNumber:1,m_SelectState:false,m_TypeName:"2cm"})
                listmodel_Box_Band.append({m_PlanNumber:2,m_SelectState:false,m_TypeName:"3cm"})
                listmodel_Box_Band.append({m_PlanNumber:3,m_SelectState:false,m_TypeName:"5cm"})
                listmodel_Box_Band.append({m_PlanNumber:4,m_SelectState:false,m_TypeName:"10cm"})
                listmodel_Box_Band.append({m_PlanNumber:5,m_SelectState:false,m_TypeName:"22cm"})
            }
        }

        CText{
            id:text_InterferenceIntensity
            anchors.left: btn_InterferenceBand.right
            anchors.leftMargin: 30
            anchors.top: text_SinglePodWeight.bottom
            anchors.topMargin: 30
            text: "干扰强度:"
            pixelSize: 18
            color: mainColor
            width: pixelSize * 4.5
            height: pixelSize
            bold: true
        }

        CButton{
            id:btn_InterferenceIntensity
            width: 160
            height: 36
            color:"#ffddaa00"
            borderColor: "#ffddaa00"
            borderHigtColor: "#ffeebb22"
            anchors.left: text_InterferenceIntensity.right
            anchors.verticalCenter: text_InterferenceIntensity.verticalCenter
            pixelSize: 20
            text:{
                if(iIntensity < 0)
                {
                    return "强度1(轻度干扰)"
                }
                else
                {
                    if(listmodel_Box_Intensity.count > 0)
                        listmodel_Box_Intensity.get(iIntensity).m_TypeName
                }
            }
            onClicked: {
                view_List_InterferenceIntensity.visible = !view_List_InterferenceIntensity.visible
            }
        }

        ListView{
            //干扰强度ListView  单选
            id:view_List_InterferenceIntensity
            width: btn_InterferenceIntensity.width
            height: btn_InterferenceIntensity.height * 5
            anchors.left: btn_InterferenceIntensity.left
            anchors.leftMargin: btn_InterferenceIntensity.width/2 - width/2
            anchors.top: btn_InterferenceIntensity.bottom
            anchors.topMargin: 2
            visible: false
            clip: true
            z:3
            model:ListModel{
                id:listmodel_Box_Intensity
            }
            delegate:Component{
                Item{
                    id:item_Delegate
                    width: view_List_InterferenceIntensity.width
                    height: 36
                    CButton{
                        id:comp_TypeBtn
                        anchors.fill: parent
                        text:m_TypeName
                        color:"#ffddaa00"
                        borderColor: "#ffddaa00"
                        pixelSize: 18
                        onClicked: {
                            view_List_InterferenceIntensity.visible = false
                            iIntensity = index
                            m_SelectState = !m_SelectState
                        }
                    }
                }
            }
            Component.onCompleted: {
                listmodel_Box_Intensity.append({m_PlanNumber:1,m_SelectState:false,m_TypeName:"强度1(轻度干扰)"})
                listmodel_Box_Intensity.append({m_PlanNumber:2,m_SelectState:false,m_TypeName:"强度2(中度干扰)"})
                listmodel_Box_Intensity.append({m_PlanNumber:3,m_SelectState:false,m_TypeName:"强度3(重度干扰)"})
            }
        }


        CText{
            id:text_LaunchControlType
            anchors.left: btn_InterferenceIntensity.right
            anchors.leftMargin: 30
            anchors.top: text_SinglePodWeight.bottom
            anchors.topMargin: 30
            text: "控制方式:"
            pixelSize: 18
            color: mainColor
            width: pixelSize * 4.5
            height: pixelSize
            bold: true
        }

        CButton{
            id:btn_LaunchControlType
            width: 160
            height: 36
            color:"#ffddaa00"
            borderColor: "#ffddaa00"
            borderHigtColor: "#ffeebb22"
            anchors.left: text_LaunchControlType.right
            anchors.verticalCenter: text_LaunchControlType.verticalCenter
            pixelSize: 20
            text: /*loadState == 1 ? "查看" : "请选择" */{
                if(iLaunchControlType < 0)
                {
                    return "人工控制"
                }
                else
                {
                    if(listmodel_Box_LaunchControlType.count > 0)
                        listmodel_Box_LaunchControlType.get(iLaunchControlType).m_TypeName
                }
            }
            onClicked: {
                view_List_LaunchControlType.visible = !view_List_LaunchControlType.visible
            }
        }

        ListView{
            //投放控制方式ListView  多选
            id:view_List_LaunchControlType
            width: btn_LaunchControlType.width
            height: btn_LaunchControlType.height * 5
            anchors.left: btn_LaunchControlType.left
            anchors.leftMargin: btn_LaunchControlType.width/2 - width/2
            anchors.top: btn_LaunchControlType.bottom
            anchors.topMargin: 2
            visible: false
            clip: true
            z:3
            model:ListModel{
                id:listmodel_Box_LaunchControlType
            }
            delegate:Component{
                Item{
                    id:item_Delegate
                    width: view_List_LaunchControlType.width
                    height: 36
                    CButton{
                        id:comp_TypeBtn
                        anchors.fill: parent
                        text:m_TypeName
                        color:"#ffddaa00"
                        borderColor: "#ffddaa00"
                        pixelSize: 18
//                        isSelect: m_SelectState
                        onClicked: {
                            view_List_LaunchControlType.visible = false
                            iLaunchControlType = index
                            m_SelectState = !m_SelectState
                        }
                    }
                }
            }
            Component.onCompleted: {
                listmodel_Box_LaunchControlType.append({m_PlanNumber:1,m_SelectState:false,m_TypeName:"人工控制"})
                listmodel_Box_LaunchControlType.append({m_PlanNumber:2,m_SelectState:false,m_TypeName:"自动控制"})
            }
        }

        CButton{
            id:btn_EffectiveReflectionArea
            width: 240
            height: 36
            color:"#ffddaa00"
            borderColor: "#ffddaa00"
            borderHigtColor: "#ffeebb22"
            anchors.left: text_InterferenceBand.left
            anchors.top: text_InterferenceBand.bottom
            anchors.topMargin: 30
            pixelSize: 20
            text: "有效反射面积"
            onClicked: {
                //弹出窗口
                comp_EffectiveReflectionArea.visible = !comp_EffectiveReflectionArea.visible
            }
        }

        CButton{
            id:btn_LaunchSpeed
            width: 240
            height: 36
            color:"#ffddaa00"
            borderColor: "#ffddaa00"
            borderHigtColor: "#ffeebb22"
            anchors.left: btn_EffectiveReflectionArea.right
            anchors.top: text_InterferenceBand.bottom
            anchors.leftMargin: 30
            anchors.topMargin: 30
            pixelSize: 20
            text: "投放速度"
            onClicked: {
                //弹出窗口
                comp_InterferencePodDropSpeed.visible = !comp_InterferencePodDropSpeed.visible
            }
        }


        Rectangle{
            id:rect_Describe
            anchors.top: btn_EffectiveReflectionArea.bottom
            anchors.left: btn_EffectiveReflectionArea.left
            width:770
            //height: 300
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 50
            anchors.leftMargin: 0
            anchors.topMargin: 10
            // anchors.right: addAmmo.right
            // anchors.bottom: custom_PassiveInterferencePod.bottom
            color:"#50000000"
            radius: 10

            CText {
                id: text_DescribeTitle
                text: qsTr("用途描述:")
                pixelSize: 18
                color: "#4EC4FF"
                anchors.left: parent.left
                anchors.leftMargin: 0
                anchors.top: parent.top
                anchors.topMargin: 20
                horizontalAlignment: Text.AlignLeft

            }
            TextArea {
                id: usageDescriptionText
                anchors.top: text_DescribeTitle.bottom
                anchors.topMargin: 15
                anchors.left: text_DescribeTitle.left
                anchors.right: parent.right
                anchors.rightMargin: 5
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 5
                // 边框样式
                    background: Rectangle {
                        border.color: "#cccccc"
                        radius: 10
                    }

                // 多行显示关键配置
                wrapMode: Text.Wrap                   // 自动换行
                placeholderText: "请输入多行描述..."    // 占位提示
                textFormat: Text.PlainText            // 文本格式
                selectByMouse: true                   // 允许鼠标选择
                inputMethodHints: Qt.ImhMultiLine      // 启用多行输入法支持
                font.family: "黑体"
                font.pixelSize: 20
                onTextChanged: {
                    //ammoData.ammoDescription =text
                    console.log("Text content changed to: " + text)

                }
            }
        }

        Rectangle {
            id: rect_ImageShow
            visible: true
            width:520
            anchors.right: parent.right
            anchors.rightMargin: 30
            anchors.top: title.bottom
            anchors.topMargin: 20
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 20
            color: "transparent"

            Rectangle{
                id:rect_Image
                width: parent.width
                anchors.bottom: btn_Cancel.top
                anchors.bottomMargin: 10
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.right: parent.right
                color: "#ECF2FE"
                Image {
                    id: ammunitionImg
                    anchors.fill: parent
                }
                CText {
                    anchors.centerIn: parent
                    text: "图片展示区域"
                    color: "#9E9E9E"
                    visible: ammunitionImg.status == Image.Loading
                }
                MouseArea {
                    id:uavImagSelect
                    anchors.fill: parent
                    enabled: loadState != 1
                    onClicked: {
                        fileDialog.open()
                    }
                }
            }

            CButton{
                id:btn_Cancel
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 5
                anchors.right: parent.right
                anchors.rightMargin: 5
                height: pixelSize * 2
                width: pixelSize * 4
                pixelSize: 20
                text: "取消"
                onClicked: {
                    backPayloadRecord()
                    custom_PassiveInterferencePod.visible = false
                }
            }

            CButton{
                id:btn_Save
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 5
                anchors.right: btn_Cancel.left
                anchors.rightMargin: 10
                height: pixelSize * 2
                width: pixelSize * 4
                pixelSize: 20
                text: "保存"
                onClicked: {
                    backPayloadRecord()
                    custom_PassiveInterferencePod.visible = false
                    if(loadState == 1)
                    {
                        return
                    }
                    else
                    {
                        saveInterferencePodData()
                    }
                }
            }
        }

        FileDialog {
            id: fileDialog
            title: "选择图片"
            nameFilters: ["图片文件 (*.png *.jpg *.jpeg)"]
            onAccepted: {
                ammunitionImg.source = fileUrls[0]
            }
        }

    }

    EffectiveReflectionArea_add{
        id:comp_EffectiveReflectionArea
        anchors.centerIn: parent
        visible: false
    }

    InterferencePodDropSpeed_add{
        id:comp_InterferencePodDropSpeed
        anchors.centerIn: parent
        visible: false
    }

    //判断是否加载新增、查看、编辑
    function loadView(){
        var viewType = processInfo.loadViewType
        if(processInfo.loadViewType === "addUavData"){
            //新增
            loadState = 0;

        }else if(processInfo.loadViewType === "query"){
            //查看
            loadState = 1;
            loadInterferencePodData()
        }else if(processInfo.loadViewType === "update"){
            //编辑
            loadState = 2;
            loadInterferencePodData()
        }else{
            console.log("processInfo.loadViewType Unknown")
        }
    }

    function loadInterferencePodData(){
        //加载数据
        var podData = interferencePodDaoTableModel.queryInterferencePodData(processInfo.podJsonStr)

        text_PodName.text = podData.interferencePodName//名称
        text_FrontHoodLength.text = podData.frontCoverLength//前罩长
        text_BackHoodLength.text = podData.rearCoverLength//后罩长
        text_MainCarbinSection.text = podData.mainCabinSection//主舱截面
        text_MainCarbinLength.text = podData.mainLength//主舱长度
        text_PodTotaloLength.text = podData.interferenceLength//吊舱总长度
        text_LoadCapacity.text = podData.loadingCapacity//装载容量
        text_SinglePodFullLoadWeight.text = podData.maximumWeightPodFullyLoaded//单吊舱满载最大重量
        text_SinglePodWeight.text = podData.mass//单吊舱质量
        //波段
        var bandArray = (podData.interferenceBand).split(",")
        for(var band of bandArray)
        {
            for(var index = 0; index < listmodel_Box_Band.count; index++)
            {
                if(listmodel_Box_Band.get(index).m_PlanNumber === Number.parseInt(band))
                {
                    listmodel_Box_Band.set(index,{m_SelectState:true})
                }
            }
        }

        //控制方式
        iLaunchControlType = Number.parseInt(podData.deliveryControlWay) - 1   //index值比存储值小1
        //干扰强度
        iIntensity = Number.parseInt(podData.interferenceIntensity) - 1   //index值比存储值小1
        ammunitionImg.source = "file:///" + podData.image_url
        //有效反射面积
        effectiveReflectionArea = podData.effectiveReflectionArea.split(";")
        comp_EffectiveReflectionArea.initListData(effectiveReflectionArea)
        console.log("有效反射面积：",effectiveReflectionArea)
    }

    function textToFloat(data){
        // 检查是否以小数点结尾
        if (data.endsWith(".")) {
            data = data.slice(0, -1); // 去掉小数点
        }
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

    //
    function saveInterferencePodData(){

        var interferencePodData = {
            id:0,
            interferencePodName:"",
            interferencePodType:"",
            interferencePodId:"",
            usedUavModels:"",  //选择的机型
            description:"",  //描述
            mainLength:0.0,//主舱长度
            interferenceLength:0.0,//吊舱长度
            mass:0.0,//单吊舱质量
            frontCoverLength:0.0,//前罩长(mm)
            rearCoverLength:0.0,//后罩长(mm)
            mainCabinSection:0.0,//主舱截面(mm)
            maximumWeightPodFullyLoaded:0.0,//单吊舱满载最大重量(kg)
            interferenceBand:"",//干扰波段
            effectiveReflectionArea:"",//有效反射面积
            deliveryControlWay:"",//投放控制方式
            deliverySpeed:"",//投放速度
            loadingCapacity:0.0,//装载容量(kg)
            interferenceIntensity:"",//干扰强度
            image_name:"",
            image_url:""
        }
        //名称
        interferencePodData.interferencePodName = text_PodName.text
        interferencePodData.description = usageDescriptionText.text
        interferencePodData.usedUavModels  = custom_PassiveInterferencePod.useToUavArray.join(",")
        //主舱长度
        interferencePodData.mainLength = textToFloat(text_MainCarbinLength.text)
        //吊舱长度
        interferencePodData.interferenceLength = textToFloat(text_PodTotaloLength.text)
        //主舱截面(m)
        interferencePodData.mainCabinSection = textToFloat(text_MainCarbinSection.text)
        //单吊舱质量
        interferencePodData.mass = textToFloat(text_SinglePodWeight.text)
        //前罩长(m)
        interferencePodData.frontCoverLength = textToFloat(text_FrontHoodLength.text)
        //后罩长(m)
        interferencePodData.rearCoverLength = textToFloat(text_BackHoodLength.text)
        //单吊舱满载最大重量(kg)
        interferencePodData.maximumWeightPodFullyLoaded = textToFloat(text_SinglePodFullLoadWeight.text)
        //干扰波段
        var bandStr = ""
        for(var i=0; i<listmodel_Box_Band.count; i++)
        {
            if(listmodel_Box_Band.get(i).m_SelectState)
            {
                bandStr += (listmodel_Box_Band.get(i).m_PlanNumber).toString()
                bandStr += ","
            }
        }
        if(bandStr.endsWith(","))
            interferencePodData.interferenceBand = bandStr.slice(0,-1)

        //干扰强度
        interferencePodData.interferenceIntensity = (listmodel_Box_Intensity.get(iIntensity).m_PlanNumber).toString()

        //控制方式
        interferencePodData.deliveryControlWay = (listmodel_Box_LaunchControlType.get(iLaunchControlType).m_PlanNumber).toString()

        //装载容量(kg)
        interferencePodData.loadingCapacity = textToFloat(text_LoadCapacity.text)

        //图片地址
        interferencePodData.image_url = ammunitionImg.source.toString()

        var temp = ""
        for(var i = 0; i < effectiveReflectionArea.length; i++)
        {
            temp += effectiveReflectionArea[i]
            temp += ";"
        }
        if(temp.endsWith(";"))
            interferencePodData.effectiveReflectionArea = temp.slice(0,-1)

        var succ
        if(loadState == 0)//新增
            succ = interferencePodDaoTableModel.insertInterferencePodData(interferencePodData)
        else if(loadState == 2)
        {//更新
            interferencePodData.id = parseInt(processInfo.podJsonStr.recordId)
            succ = interferencePodDaoTableModel.updateInterferencePodData(interferencePodData)
        }
        if(succ)
            console.log("成功！！！")
        else
            console.log("失败！！！")
    }
}
