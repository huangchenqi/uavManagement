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
        id:controlUav
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
                            text: qsTr("侦察载荷管理");
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
                                    id:uavType
                                    text: "侦察载荷类型:"
                                    height: 50
                                    width:100
                                    // anchors.left: parent.left //锚点属性与锚点边距一起用。
                                    // anchors.leftMargin: 10
                                    Layout.leftMargin: 10

                                }

                                ComboBox{
                                    id:uavTypeSelect
                                    width:100
                                    height:50
                                    model:["侦察无人机","攻击无人机","查打一体无人机"]
                                }

                                Label{
                                    id:uavName
                                    text: "侦察精度(m):"
                                    height: 50
                                    width:100
                                }
                                TextField{
                                    id: uavNameText
                                    width: 120
                                }
                                Label{
                                    id:uavId
                                    text: "数据回传时限(s):"
                                    height: 50
                                    width:100
                                }
                                TextField{
                                    id: uavIdText
                                    width: 120
                                }
                            }


                            RowLayout {
                                // anchors.fill: parent
                                Layout.fillWidth: true
                                // Layout.fillHeight: true
                                spacing: 10
                                Label{
                                    id:workHeight
                                    text: "工作高度范围(m):"
                                    height: 50
                                    width:100
                                    // anchors.left: parent.left //锚点属性与锚点边距一起用。
                                    // anchors.leftMargin: 10
                                    Layout.leftMargin: 10

                                }

                                TextField{
                                    id: workHeightMinText
                                    Layout.preferredWidth: 80
                                    //width: 50
                                }
                                Label{
                                    id:uavWorkHeight
                                    text: "-"
                                    height: 50
                                    width:100
                                }
                                TextField{
                                    id: workHeightMaxText
                                    Layout.preferredWidth: 80
                                    //width: 50
                                }

                                Label{
                                    id:workSpeed
                                    text: "工作速度范围(Km/h):"
                                    height: 50
                                    width:100
                                }
                                TextField{
                                    id: workSpeedMin
                                    //width: 120
                                    Layout.preferredWidth: 80
                                }
                                Label{
                                    id:uavWorkSpped
                                    text: "-"
                                    height: 50
                                    width:100
                                }
                                TextField{
                                    id: workSpeedMax
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
                                    id:workingElevationRange
                                    text: "工作俯仰范围(°):"
                                    height: 50
                                    width:100
                                    // anchors.left: parent.left //锚点属性与锚点边距一起用。
                                    // anchors.leftMargin: 10
                                    Layout.leftMargin: 10

                                }

                                TextField{
                                    id: workingElevationMin
                                    //width: 50
                                    Layout.preferredWidth: 50
                                    //Layout.preferredHeight: 50
                                }
                                Label{
                                    id:uavWorkingElevation
                                    text: "-"
                                    height: 50
                                    width:10
                                }
                                TextField{
                                    id: workingElevationMax
                                    //width: 50
                                    Layout.preferredWidth: 50
                                    //Layout.preferredHeight: 50
                                }

                                Label{
                                    id:workOrientationScope
                                    text: "工作方位范围(°):"
                                    height: 50
                                    width:100
                                }
                                TextField{
                                    id: workOrientationMin
                                    Layout.preferredWidth: 50
                                }
                                Label{
                                    id:workOrientation
                                    text: "-"
                                    height: 50
                                    width:10
                                }
                                TextField{
                                    id: workOrientationMax
                                    Layout.preferredWidth: 50
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
                                    id: uavImg
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
                    FileDialog {
                        id: fileDialog
                        title: "选择图片"
                        nameFilters: ["图片文件 (*.png *.jpg *.jpeg)"]
                        onAccepted: {
                            uavImg.source = fileUrls[0]
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


    function saveUavData(){
        console.log("uavTypeSelevtContent"+uavTypeSelect.currentText+"-"+"testValue"+uavTypeSelect.currentValue)

        var uavData = {
            uavTypeSelectContent:"",
            uavNameTextContent:"",
            uavIdTextContent:"",
            uavLengthTextContent:"",
            uavWidthTextContent:"",
            uavHeightTextContent:"",
            uavInvisibilitySelectContent:"",
            uavFlightHeightTextContent:"",
            uavFlightSpeedTextContent:"",
            uavFlightDistanceRangeTextContent:"",
            uavFlightTimeRangeTextContent:"",
            uavTakeoffDistanceTextContent:"",
            uavLandDistanceTextContent:"",
            uavTurningRadiusRangeTextContent:"",
            uavOperatioanalRadiusTextContent:"",
            uavInvestigationPayloadTypeGroupContent:"",
            uavBombingmethodGroupContent:"",
            uavLoadReconnaissanceRangeTextContent:"",
            uavLoadReconnaissanceAccuracyTextContent:"",
            uavRecoverymodeGroupContent:"",
            uavLowAltitudeBreakthroughSpeedTextContent:"",
            uavHangingpointsTextContent:"",
            uavPayloadcapacityTextContent:"",
            uavRadarCrossSectionTextContent:""
        };


        var uavInvestigationPayloadTypeJson = getSelectedPayloads(uavInvestigationPayloadTypeGroup.buttons)
        console.log("有效载荷选择:", JSON.stringify(uavInvestigationPayloadTypeJson))
        var uavInvestigationPayloadTypeJsonStr = JSON.stringify(uavInvestigationPayloadTypeJson)
        var uavInvestigationPayloadTypeJsonStrresult = convertToJsonArray(uavInvestigationPayloadTypeJson);
        console.log(uavInvestigationPayloadTypeJsonStrresult);

        var uavBombingmethodGroupJson = getSelectedPayloads(uavBombingmethodGroup.buttons)
        console.log("投弹方式:", JSON.stringify(uavBombingmethodGroupJson))
        var uavBombingmethodGroupStr = JSON.stringify(uavInvestigationPayloadTypeJson)
        var uavBombingmethodGroupJsonStrresult = convertToJsonArray(uavBombingmethodGroupJson);
        console.log(uavBombingmethodGroupJsonStrresult);

        var uavRecoverymodeGroupJson = getSelectedPayloads(uavRecoverymodeGroup.buttons)
        console.log("回收方式:", JSON.stringify(uavRecoverymodeGroupJson))
        var uavRecoverymodeGroupJsonStr = JSON.stringify(uavRecoverymodeGroupJson)
        var uavRecoverymodeGroupJsonStrresult = convertToJsonArray(uavRecoverymodeGroupJson);
        console.log(uavRecoverymodeGroupJsonStrresult);

        var uavTypeSelectContent = uavTypeSelect.currentText
        var uavNameTextContent = uavNameText.text
        var uavIdTextContent = uavIdText.text
        var uavLengthTextContent = uavLengthText.text
        var uavWidthTextContent = uavWidthText.text
        var uavHeightTextContent = uavHeightText.text
        var uavInvisibilitySelectContent = uavInvisibilitySelect.currentText
        var uavFlightHeightTextContent = uavFlightHeightText.text
        var uavFlightSpeedTextContent = uavFlightSpeedText.text
        var uavFlightDistanceRangeTextContent = uavFlightDistanceRangeText.text
        var uavFlightTimeRangeTextContent = uavFlightTimeRangeText.text
        var uavTakeoffDistanceTextContent = uavTakeoffDistanceText.text
        var uavLandDistanceTextContent = uavLandDistanceText.text
        var uavTurningRadiusRangeTextContent = uavTurningRadiusRangeText.text
        var uavOperatioanalRadiusTextContent = uavOperatioanalRadiusText.text
        var uavInvestigationPayloadTypeGroupContent = uavInvestigationPayloadTypeJsonStrresult
        var uavBombingmethodGroupContent = uavBombingmethodGroupJsonStrresult
        var uavLoadReconnaissanceRangeTextContent = uavLoadReconnaissanceRangeText.text
        var uavLoadReconnaissanceAccuracyTextContent = uavLoadReconnaissanceAccuracyText.text
        var uavRecoverymodeGroupContent = uavRecoverymodeGroupJsonStrresult
        var uavLowAltitudeBreakthroughSpeedTextContent = uavLowAltitudeBreakthroughSpeedText.text
        var uavHangingpointsTextContent = uavHangingpointsText.text
        var uavPayloadcapacityTextContent = uavPayloadcapacityText.text
        var uavRadarCrossSectionTextContent = uavRadarCrossSectionText.text

        uavData.uavTypeSelectContent = uavTypeSelectContent
        uavData.uavNameTextContent = uavNameTextContent
        uavData.uavIdTextContent = uavIdTextContent
        uavData.uavLengthTextContent = uavLengthTextContent
        uavData.uavWidthTextContent = uavWidthTextContent
        uavData.uavHeightTextContent = uavHeightTextContent
        uavData.uavInvisibilitySelectContent = uavInvisibilitySelectContent
        uavData.uavFlightHeightTextContent = uavFlightHeightTextContent
        uavData.uavFlightSpeedTextContent = uavFlightSpeedTextContent
        uavData.uavFlightDistanceRangeTextContent = uavFlightDistanceRangeTextContent
        uavData.uavFlightTimeRangeTextContent = uavFlightTimeRangeTextContent
        uavData.uavTakeoffDistanceTextContent = uavTakeoffDistanceTextContent
        uavData.uavLandDistanceTextContent = uavLandDistanceTextContent
        uavData.uavTurningRadiusRangeTextContent = uavTurningRadiusRangeTextContent
        uavData.uavOperatioanalRadiusTextContent = uavOperatioanalRadiusTextContent
        uavData.uavInvestigationPayloadTypeGroupContent = uavInvestigationPayloadTypeGroupContent
        uavData.uavBombingmethodGroupContent = uavBombingmethodGroupContent
        uavData.uavLoadReconnaissanceRangeTextContent = uavLoadReconnaissanceRangeTextContent
        uavData.uavLoadReconnaissanceAccuracyTextContent = uavLoadReconnaissanceAccuracyTextContent
        uavData.uavRecoverymodeGroupContent = uavRecoverymodeGroupContent
        uavData.uavLowAltitudeBreakthroughSpeedTextContent = uavLowAltitudeBreakthroughSpeedTextContent
        uavData.uavHangingpointsTextContent = uavHangingpointsTextContent
        uavData.uavPayloadcapacityTextContent = uavPayloadcapacityTextContent
        uavData.uavRadarCrossSectionTextContent = uavRadarCrossSectionTextContent

        var jsonString = JSON.stringify(uavData);
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
