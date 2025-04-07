import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtQuick.Window 2.12
import QtQuick.Dialogs 1.2
import "qrc:/"

Window{
    id:controlWindow
    visible: true
    width: 1200
    height: 600
    title: qsTr("QML TableView example")
    Item {
        id:controlAmmunition
        // width: 1200
        // height: 600

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
                            text: qsTr("弹药管理");
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
                                    id:ammunitionType
                                    text: "弹药类型:"
                                    height: 50
                                    width:100
                                    // anchors.left: parent.left //锚点属性与锚点边距一起用。
                                    // anchors.leftMargin: 10
                                    Layout.leftMargin: 10

                                }

                                ComboBox{
                                    id:ammunitionTypeSelect
                                    width:100
                                    height:50
                                    model:["侦察无人机","攻击无人机","查打一体无人机"]
                                }

                                Label{
                                    id:ammunitionName
                                    text: "制导类型:"
                                    height: 50
                                    width:100
                                }
                                ComboBox{
                                        id: ammunitionNameText
                                        width:100
                                        height:50
                                        model:["侦察无人机","攻击无人机","查打一体无人机"]
                                }
                            }
                            RowLayout {
                                // anchors.fill: parent
                                Layout.fillWidth: true
                                // Layout.fillHeight: true
                                spacing: 10
                                Label{
                                    id:ammunitionIdLength
                                    text: "弹药长度(m):"
                                    height: 50
                                    width:100
                                    Layout.leftMargin: 10

                                }
                                TextField{
                                    id: ammunitionIdLengthText
                                    width: 50
                                }
                                Label{
                                    id:ammunitionDiameter
                                    text: "弹药直径(m):"
                                    height: 50
                                    width:100
                                }
                                TextField{
                                    id: ammunitionDiameterText
                                    width: 50
                                }
                                Label{
                                    id:ammunitionWeight
                                    text: "弹药重量(Kg):"
                                    height: 50
                                    width:100
                                }
                                TextField{
                                    id: ammunitionWeightText
                                    width: 50
                                }
                            }
                            RowLayout {
                                // anchors.fill: parent
                                Layout.fillWidth: true
                                // Layout.fillHeight: true
                                spacing: 10
                                Label{
                                    id:ammunitionFlightHeight
                                    text: "投放高度范围(Km):"
                                    height: 50
                                    width:100
                                    // anchors.left: parent.left //锚点属性与锚点边距一起用。
                                    // anchors.leftMargin: 10
                                    Layout.leftMargin: 10

                                }

                                TextField{
                                    id: ammunitionFlightHeightMin
                                    //width: 50
                                    Layout.preferredWidth: 50
                                    //Layout.preferredHeight: 50
                                }
                                Label{
                                    id:ammunitionFlightHeightRange
                                    text: "-"
                                    height: 50
                                    width:10
                                }
                                TextField{
                                    id: ammunitionFlightHeightMax
                                    //width: 50
                                    Layout.preferredWidth: 50
                                    //Layout.preferredHeight: 50
                                }

                                Label{
                                    id:ammunitionFlightSpeed
                                    text: "投放距离范围(Km):"
                                    height: 50
                                    width:100
                                }
                                TextField{
                                    id: ammunitionFlightSpeedMin
                                    Layout.preferredWidth: 50
                                }
                                Label{
                                    id:ammunitionFlightSpeedRange
                                    text: "-"
                                    height: 50
                                    width:10
                                }
                                TextField{
                                    id: ammunitionFlightSpeedMax
                                    Layout.preferredWidth: 50
                                }

                                Label{
                                    id:ammunitionFlightTimeRange
                                    text: "投放角度(°):"
                                    height: 50
                                    width:100
                                }
                                TextField{
                                    id: ammunitionFlightTime
                                    Layout.preferredWidth: 80
                                }
                            }
                            RowLayout {
                                // anchors.fill: parent
                                Layout.fillWidth: true
                                // Layout.fillHeight: true
                                spacing: 10
                                Label{
                                    id:ammunitionFlightDistanceRange
                                    text: "投放方式:"
                                    height: 50
                                    width:100
                                    // anchors.left: parent.left //锚点属性与锚点边距一起用。
                                    // anchors.leftMargin: 10
                                    Layout.leftMargin: 10

                                }
                                ComboBox{
                                        id: ammunitionFlightDistance
                                        width:100
                                        height:50
                                        model:["侦察无人机","攻击无人机","查打一体无人机"]
                                }
                                Label{
                                    id:ammunitionTakeoffDistance
                                    text: "可打击目标类型:"
                                    height: 50
                                    width:100
                                }
                                ComboBox{
                                        id: ammunitionTakeoffDistanceType
                                        width:100
                                        height:50
                                        model:["侦察无人机","攻击无人机","查打一体无人机"]
                                }
                            }
                            RowLayout {
                                // anchors.fill: parent
                                Layout.fillWidth: true
                                // Layout.fillHeight: true
                                spacing: 10
                                Label{
                                    id:lethalDose
                                    text: "杀伤药量(Kg):"
                                    height: 50
                                    width:100
                                    // anchors.left: parent.left //锚点属性与锚点边距一起用。
                                    // anchors.leftMargin: 10
                                    Layout.leftMargin: 10

                                }

                                TextField{
                                    id: ammunitionLandDistanceValue
                                    Layout.preferredWidth: 50
                                }
                                Label{
                                    id:ammunitionTurningRadiusRange
                                    text: "杀伤范围(Km):"
                                    height: 50
                                    width:100
                                }
                                TextField{
                                    id: ammunitionTurningRadiusMin
                                    Layout.preferredWidth: 80
                                }
                                Label{
                                    id:ammunitionFlightSpeedRangeValue
                                    text: "-"
                                    height: 50
                                    width:10
                                }
                                TextField{
                                    id: ammunitionTurningRadiusMax
                                    Layout.preferredWidth: 80
                                }
                            }
                            RowLayout {
                                // anchors.fill: parent
                                Layout.fillWidth: true
                                // Layout.fillHeight: true
                                spacing: 10
                                Label{
                                    id:killingMethod
                                    text: "杀伤方式:"
                                    height: 50
                                    width:100
                                    Layout.leftMargin: 10
                                }
                                ComboBox{
                                        id: killingMethodType
                                        width:100
                                        height:50
                                        model:["侦察无人机","攻击无人机","查打一体无人机"]
                                }
                                Label{
                                    id:ammunitionOperatioanalRadiusRange
                                    text: "杀伤深度(m):"
                                    height: 50
                                    width:100
                                }
                                TextField{
                                    id: ammunitionOperatioanalRadius
                                    Layout.preferredWidth: 80
                                }
                            }
                        }
                        ColumnLayout{
                            //anchors.fill: parent
                            //Layout.fillWidth: true
                            Layout.fillHeight: true
                            spacing: 10
                            Button{
                                id:imageSelect
                                width:100
                                height:50
                                anchors.right: parent.right
                                anchors.rightMargin: 2
                                anchors.top: parent.top
                                anchors.topMargin: 8
                                // anchors.bottom: parent.bottom
                                // anchors.bottomMargin: 10
                                text: "选择图片"
                                onClicked: {
                                    fileDialog.open()
                                }
                            }
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

                                Image {
                                    id: ammunitionImg
                                    //source: "qrc:/resource/1.jpg"
                                    anchors.fill: parent
                                }
                                Column {
                                    anchors.centerIn: parent
                                    spacing: 10

                                    Text {
                                        anchors.horizontalCenter: parent.horizontalCenter
                                        text: "图片展示区域"
                                        color: "#9E9E9E"
                                        font.italic: true
                                    }
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
                                saveammunitionData()
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
                    FileDialog {
                        id: fileDialog
                        title: "选择图片"
                        nameFilters: ["图片文件 (*.png *.jpg *.jpeg)"]
                        onAccepted: {
                            ammunitionImg.source = fileUrls[0]
                            var currentModel = navBar.currentIndex === 0 ? droneModel : schemeModel
                            for(var i = 0; i < currentModel.count; i++){
                                if(currentModel.get(i).expanded){
                                    currentModel.get(i).items.push({
                                        name: "新条目",
                                        selected: false
                                    });
                                    break;
                                }
                            }
                        }
                    }



        }



    }


    function saveammunitionData(){
        console.log("ammunitionTypeSelevtContent"+ammunitionTypeSelect.currentText+"-"+"testValue"+ammunitionTypeSelect.currentValue)

        var ammunitionData = {
            ammunitionTypeSelectContent:"",
            ammunitionNameTextContent:"",
            ammunitionIdTextContent:"",
            ammunitionLengthTextContent:"",
            ammunitionWidthTextContent:"",
            ammunitionHeightTextContent:"",
            ammunitionInvisibilitySelectContent:"",
            ammunitionFlightHeightTextContent:"",
            ammunitionFlightSpeedTextContent:"",
            ammunitionFlightDistanceRangeTextContent:"",
            ammunitionFlightTimeRangeTextContent:"",
            ammunitionTakeoffDistanceTextContent:"",
            ammunitionLandDistanceTextContent:"",
            ammunitionTurningRadiusRangeTextContent:"",
            ammunitionOperatioanalRadiusTextContent:"",
            ammunitionInvestigationPayloadTypeGroupContent:"",
            ammunitionBombingmethodGroupContent:"",
            ammunitionLoadReconnaissanceRangeTextContent:"",
            ammunitionLoadReconnaissanceAccuracyTextContent:"",
            ammunitionRecoverymodeGroupContent:"",
            ammunitionLowAltitudeBreakthroughSpeedTextContent:"",
            ammunitionHangingpointsTextContent:"",
            ammunitionPayloadcapacityTextContent:"",
            ammunitionRadarCrossSectionTextContent:""
        };


        var ammunitionInvestigationPayloadTypeJson = getSelectedPayloads(ammunitionInvestigationPayloadTypeGroup.buttons)
        console.log("有效载荷选择:", JSON.stringify(ammunitionInvestigationPayloadTypeJson))
        var ammunitionInvestigationPayloadTypeJsonStr = JSON.stringify(ammunitionInvestigationPayloadTypeJson)
        var ammunitionInvestigationPayloadTypeJsonStrresult = convertToJsonArray(ammunitionInvestigationPayloadTypeJson);
        console.log(ammunitionInvestigationPayloadTypeJsonStrresult);

        var ammunitionBombingmethodGroupJson = getSelectedPayloads(ammunitionBombingmethodGroup.buttons)
        console.log("投弹方式:", JSON.stringify(ammunitionBombingmethodGroupJson))
        var ammunitionBombingmethodGroupStr = JSON.stringify(ammunitionInvestigationPayloadTypeJson)
        var ammunitionBombingmethodGroupJsonStrresult = convertToJsonArray(ammunitionBombingmethodGroupJson);
        console.log(ammunitionBombingmethodGroupJsonStrresult);

        var ammunitionRecoverymodeGroupJson = getSelectedPayloads(ammunitionRecoverymodeGroup.buttons)
        console.log("回收方式:", JSON.stringify(ammunitionRecoverymodeGroupJson))
        var ammunitionRecoverymodeGroupJsonStr = JSON.stringify(ammunitionRecoverymodeGroupJson)
        var ammunitionRecoverymodeGroupJsonStrresult = convertToJsonArray(ammunitionRecoverymodeGroupJson);
        console.log(ammunitionRecoverymodeGroupJsonStrresult);

        var ammunitionTypeSelectContent = ammunitionTypeSelect.currentText
        var ammunitionNameTextContent = ammunitionNameText.text
        var ammunitionIdTextContent = ammunitionIdText.text
        var ammunitionLengthTextContent = ammunitionLengthText.text
        var ammunitionWidthTextContent = ammunitionWidthText.text
        var ammunitionHeightTextContent = ammunitionHeightText.text
        var ammunitionInvisibilitySelectContent = ammunitionInvisibilitySelect.currentText
        var ammunitionFlightHeightTextContent = ammunitionFlightHeightText.text
        var ammunitionFlightSpeedTextContent = ammunitionFlightSpeedText.text
        var ammunitionFlightDistanceRangeTextContent = ammunitionFlightDistanceRangeText.text
        var ammunitionFlightTimeRangeTextContent = ammunitionFlightTimeRangeText.text
        var ammunitionTakeoffDistanceTextContent = ammunitionTakeoffDistanceText.text
        var ammunitionLandDistanceTextContent = ammunitionLandDistanceText.text
        var ammunitionTurningRadiusRangeTextContent = ammunitionTurningRadiusRangeText.text
        var ammunitionOperatioanalRadiusTextContent = ammunitionOperatioanalRadiusText.text
        var ammunitionInvestigationPayloadTypeGroupContent = ammunitionInvestigationPayloadTypeJsonStrresult
        var ammunitionBombingmethodGroupContent = ammunitionBombingmethodGroupJsonStrresult
        var ammunitionLoadReconnaissanceRangeTextContent = ammunitionLoadReconnaissanceRangeText.text
        var ammunitionLoadReconnaissanceAccuracyTextContent = ammunitionLoadReconnaissanceAccuracyText.text
        var ammunitionRecoverymodeGroupContent = ammunitionRecoverymodeGroupJsonStrresult
        var ammunitionLowAltitudeBreakthroughSpeedTextContent = ammunitionLowAltitudeBreakthroughSpeedText.text
        var ammunitionHangingpointsTextContent = ammunitionHangingpointsText.text
        var ammunitionPayloadcapacityTextContent = ammunitionPayloadcapacityText.text
        var ammunitionRadarCrossSectionTextContent = ammunitionRadarCrossSectionText.text

        ammunitionData.ammunitionTypeSelectContent = ammunitionTypeSelectContent
        ammunitionData.ammunitionNameTextContent = ammunitionNameTextContent
        ammunitionData.ammunitionIdTextContent = ammunitionIdTextContent
        ammunitionData.ammunitionLengthTextContent = ammunitionLengthTextContent
        ammunitionData.ammunitionWidthTextContent = ammunitionWidthTextContent
        ammunitionData.ammunitionHeightTextContent = ammunitionHeightTextContent
        ammunitionData.ammunitionInvisibilitySelectContent = ammunitionInvisibilitySelectContent
        ammunitionData.ammunitionFlightHeightTextContent = ammunitionFlightHeightTextContent
        ammunitionData.ammunitionFlightSpeedTextContent = ammunitionFlightSpeedTextContent
        ammunitionData.ammunitionFlightDistanceRangeTextContent = ammunitionFlightDistanceRangeTextContent
        ammunitionData.ammunitionFlightTimeRangeTextContent = ammunitionFlightTimeRangeTextContent
        ammunitionData.ammunitionTakeoffDistanceTextContent = ammunitionTakeoffDistanceTextContent
        ammunitionData.ammunitionLandDistanceTextContent = ammunitionLandDistanceTextContent
        ammunitionData.ammunitionTurningRadiusRangeTextContent = ammunitionTurningRadiusRangeTextContent
        ammunitionData.ammunitionOperatioanalRadiusTextContent = ammunitionOperatioanalRadiusTextContent
        ammunitionData.ammunitionInvestigationPayloadTypeGroupContent = ammunitionInvestigationPayloadTypeGroupContent
        ammunitionData.ammunitionBombingmethodGroupContent = ammunitionBombingmethodGroupContent
        ammunitionData.ammunitionLoadReconnaissanceRangeTextContent = ammunitionLoadReconnaissanceRangeTextContent
        ammunitionData.ammunitionLoadReconnaissanceAccuracyTextContent = ammunitionLoadReconnaissanceAccuracyTextContent
        ammunitionData.ammunitionRecoverymodeGroupContent = ammunitionRecoverymodeGroupContent
        ammunitionData.ammunitionLowAltitudeBreakthroughSpeedTextContent = ammunitionLowAltitudeBreakthroughSpeedTextContent
        ammunitionData.ammunitionHangingpointsTextContent = ammunitionHangingpointsTextContent
        ammunitionData.ammunitionPayloadcapacityTextContent = ammunitionPayloadcapacityTextContent
        ammunitionData.ammunitionRadarCrossSectionTextContent = ammunitionRadarCrossSectionTextContent

        var jsonString = JSON.stringify(ammunitionData);
                console.log("jsonString"+jsonString);




    }
    function convertToJsonArray(jsonData) {
            return jsonData.map(function(item) {
                return item.name;
            });
    }

    function getSelectedPayloads(buttons) {
            return Array.from(buttons)
                .filter(btn => btn.checked)
                .map(btn => ({
                    name: btn.text,
                    code: btn.payloadCode
                }))
    }
    function saveDeliveryRecord() {
        // let recordobj = new Commons.DeliveryRecordEntity()
        // recordobj.setPlaneShape = modelSelector.currentText
        // recordobj.setBatchNo = batchCommbox.currentText
        // recordobj.setSortiesNo = beginSortieCommbox.currentText      // 架次
        // recordobj.setDeliveryId = deliveryUser.content     // 交装者
        // recordobj.setProfessionId = profSelector.currentText    // 专业
        // recordobj.setShippingSpace = shipSpaceSelector.contentText  // 舱位
        // recordobj.setInspectorId = inspectUser.content    // 检验员
        // recordobj.setLevel1Classify = level1Classify.currentText
        // recordobj.setLevel2Classify = level2Classify.currentText
        // recordobj.setLevel3Classify = level3Classify.currentText
        // recordobj.setPresenterId  = presenterSelector.content// 提出者
        // recordobj.setUnit  = unitSelector.content            //部队
        // recordobj.setProChartNo = productNoSelector.content      // 产品图号
        // recordobj.setProChartName = productNameSelector.content  // 产品名称
        // recordobj.setQualityNo = qualityNoSelector.content       // 质量编号
        // recordobj.setReceiptNo = receiptNoSelector.content       // 单据编号
        // recordobj.setProposedDate = proposedDate.content
        // recordobj.setProblemDesc = textArea.text     // 问题描述
        // recordobj.setProblemStatus = "处置中"
        // recordobj.setPhotoFile = photoFilename

        // recordobj.setDiscoveryMethod = discoveryMethod.currentText;
        // recordobj.setInfoChannel = infoChannel.currentText;
        // recordobj.setOccurChance = occurChance.currentText;

        // let jsonString = ""
        // let jsonObject = new Object
        // if (windowModel === 0 && recordId === "") {
        //     setRecordProcessInfo(recordobj, processInfo)

        //     jsonString = deliveryRecordModel.insert(recordobj)
        //     jsonObject = Commons.parseResponse(jsonString)
        //     if (jsonObject.code === 200) {
        //         toastModel.show("^_^记录保存成功^_^")
        //         saveButton.enabled = false
        //         saveButton.visible = false

        //         editButton.enabled = true
        //         editButton.visible = true

        //         // 保存已经的数据据主键值，用于编辑时更新
        //         if (jsonObject.hasOwnProperty("data")) {
        //             recordId = jsonObject.data.recordId
        //             savePhotoCacheList()
        //         }
        //         else {
        //             console.log("\"_\"没有相应的记录ID\"_\"")
        //         }
        //     }
        // }
        // else {
        //     //保存时TaskItem从本身的数据记录处获取
        //     setRecordProcessInfo(recordobj, recordEntity);

        //     jsonString = deliveryRecordModel.update(recordId, recordobj)
        //     jsonObject = Commons.parseResponse(jsonString)
        //     if (jsonObject.code === 200) {
        //         toastModel.show("^_^记录更新成功^_^")
        //         saveButton.enabled = false
        //         saveButton.visible = false

        //         editButton.enabled = true
        //         editButton.visible = true
        //     }
        //     else {
        //         toastModel.show("^_^记录更新失败^_^")
        //         print("deliveryRecordModel.update ", jsonString)
        //     }
        // }
    }

}
