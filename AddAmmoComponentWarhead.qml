import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtQuick.Window 2.12
import QtQuick.Dialogs 1.2
import "qrc:/"
import "qrc:/AddAmmoModules/Component"

Rectangle{//航空弹药的组件战斗部
    id:addAmmoComponentWarheadRoot
    visible: true
    width: 600
    height: 500
    color:"skyblue"
    property int loadStatus: 0 //先于selectedWarhead赋值确保在查看与修改时候先加载数据
    property var selectedWarhead: "first"
    onSelectedWarheadChanged: {
        if(addAmmoComponentWarheadRoot.loadStatus === 0){
           console.log("新增战斗部数据!")
        }else if(addAmmoComponentWarheadRoot.loadStatus === 1){
           loadAmmoData()
           allComponentEnable()

        }else if(addAmmoComponentWarheadPanel.loadStatus === 2){
            loadAmmoData()
        }else{
            console.log("未知的加载方式!")
        }

        if(addAmmoComponentWarheadRoot.selectedWarhead === "first"){
            topTitle.text = "增强型杀爆战斗部"
            warheadTypeText.visible = true
            warheadWeightText.visible = true
            warheadLengthText.visible = true
            warheadDiameterText.visible = true
            warheadMainChargeTypeText.visible = true
            warheadChargeQualityText.visible = true
            warheadChargingDensityText.visible = true
            warheadFillingCoefficientText.visible = true
            warheadBoosterText.visible = true
            warheadfragmentsNumberText.visible = true
            warheadVehiclesEffectiveKillingRadiusText.visible = true
            warheadPeopleEffectiveKillingRadiusText.visible = true
            warheadInvasivenessText.visible = true
            warheadVerticalStaticArmorPenetrationDepthText.visible = true
        }else if(addAmmoComponentWarheadRoot.selectedWarhead === "second"){
            topTitle.text = "侵爆战斗部"
            warheadTypeText.visible = false
            warheadWeightText.visible = false
            warheadLengthText.visible = false
            warheadDiameterText.visible = false
            warheadMainChargeTypeText.visible = false
            warheadChargeQualityText.visible = false
            warheadChargingDensityText.visible = false
            warheadFillingCoefficientText.visible = false
            warheadBoosterText.visible = false
            warheadfragmentsNumberText.visible = false
            warheadVehiclesEffectiveKillingRadiusText.visible = false
            warheadPeopleEffectiveKillingRadiusText.visible = false
            warheadInvasivenessText.visible = false
            warheadVerticalStaticArmorPenetrationDepthText.visible = false
            // warheadTypeText_add.visible = true
            // warheadWeightText_add.visible = true
            // warheadLengthText_add.visible = true
            // warheadMainChargeTypeText_add.visible = true
            // warheadDiameterText_add.visible = true
            // warheadChargeQualityText_add.visible = true
            // warheadChargingDensityText_add.visible = true
            // warheadFillingCoefficientText_add.visible = true
            // warheadBoosterText_add.visible = true
            // warheadfragmentsNumberText_add.visible = true
            // warheadVehiclesEffectiveKillingRadiusText_add.visible = true
            // warheadPeopleEffectiveKillingRadiusText_add.visible = true
            // warheadInvasivenessText_add.visible = true
            // warheadVerticalStaticArmorPenetrationDepthText_add.visible = true
        }else if(addAmmoComponentWarheadRoot.selectedWarhead === "third"){
            topTitle.text = "战斗部"
            warheadTypeText.visible = true
            warheadWeightText.visible = true
            warheadLengthText.visible = true
            warheadDiameterText.visible = true
            warheadMainChargeTypeText.visible = true
            warheadChargeQualityText.visible = true
            warheadChargingDensityText.visible = true
            warheadFillingCoefficientText.visible = true
            warheadBoosterText.visible = true
            warheadfragmentsNumberText.visible = true
            warheadVehiclesEffectiveKillingRadiusText.visible = true
            warheadPeopleEffectiveKillingRadiusText.visible = true
            warheadInvasivenessText.visible = true
            warheadVerticalStaticArmorPenetrationDepthText.visible = true
        }else{
            console.log("Unkown selectedWarhead!")
        }
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
        color: "transparent"

        CText{
            id:topTitle
            text: "未知战斗部"
            // {    if(addAmmoComponentWarheadRoot.selectedWarhead === "first"){
            //               return ""

            //       }else if(addAmmoComponentWarheadRoot.selectedWarhead === "second"){
            //               return ""
            //       }else if(addAmmoComponentWarheadRoot.selectedWarhead === "second"){
            //               return ""

            //       }else{
            //              console.log("Unkown selectedWarhead!")
            //     }

            // }

            anchors.top: parent.top
            anchors.topMargin: 15
            anchors.horizontalCenter: parent.horizontalCenter
            color: mainColor
            pixelSize: 28
        }


        Grid{
            anchors.top: topTitle.bottom
            anchors.topMargin: 20
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.right: parent.right
            anchors.rightMargin: 10
            height: 300
            //columnSpacing: 10
            //rowSpacing: 20
            columns: 2

            CTextInput{
                id:warheadTypeText
                title: "类型:"
                pixelSize: 18
                titleWidth: pixelSize * 2.5
                width: parent.width/2 - 10
                height: 30
                onlyNum: false
                onTextChanged: {

                    ammoData.combat_unit_type =text

                    console.log("Text content changed to: " + text)
                }
            }
            CTextInput{
                id:warheadTypeText_add
                title: "类型:"
                pixelSize: 18
                titleWidth: pixelSize * 2.5
                width: parent.width/2 - 10
                height: 30
                visible: !warheadTypeText.visible
                onlyNum: false
                onTextChanged: {
                    ammoData.combat_unit_type_add =text

                    console.log("Text content changed to: " + text)
                }
            }
            CTextInput{
                id:warheadWeightText
                title: "重量(Kg):"
                pixelSize: 18
                titleWidth: pixelSize * 4.5
                width: parent.width/2 - 10
                height: 30
                onTextChanged: {
                    ammoData.combat_department_quality =text
                    console.log("Text content changed to: " + text)
                }
            }
            CTextInput{
                id:warheadWeightText_add
                title: "重量(Kg):"
                pixelSize: 18
                titleWidth: pixelSize * 4.5
                width: parent.width/2 - 10
                height: 30
                visible: !warheadWeightText.visible
                onTextChanged: {

                    ammoData.combat_department_quality_add =text
                    console.log("Text content changed to: " + text)
                }
            }

            CTextInput{
                id:warheadLengthText
                title: "长度(mm):"
                pixelSize: 18
                titleWidth: pixelSize * 4.5
                width: parent.width/2 - 10
                height: 30
                onTextChanged: {
                    ammoData.combat_length =text
                    console.log("Text content changed to: " + text)
                }
            }
            CTextInput{
                id:warheadLengthText_add
                title: "长度(mm):"
                pixelSize: 18
                titleWidth: pixelSize * 4.5
                width: parent.width/2 - 10
                height: 30
                visible: !warheadLengthText.visible
                onTextChanged: {

                    ammoData.combat_length_add =text
                    console.log("Text content changed to: " + text)
                }
            }

            CTextInput{
                id:warheadDiameterText
                title: "直径(mm):"
                pixelSize: 18
                titleWidth: pixelSize * 4.5
                width: parent.width/2 - 10
                height: 30
                onTextChanged: {
                    ammoData.combat_diameter =text
                    console.log("Text content changed to: " + text)
                }
            }
            CTextInput{
                id:warheadDiameterText_add
                title: "直径(mm):"
                pixelSize: 18
                titleWidth: pixelSize * 4.5
                width: parent.width/2 - 10
                height: 30
                visible: !warheadDiameterText.visible
                onTextChanged: {
                    ammoData.combat_diameter_add =text
                    console.log("Text content changed to: " + text)
                }
            }

            CTextInput{
                id:warheadMainChargeTypeText
                title: "装药类型:"
                pixelSize: 18
                titleWidth: pixelSize * 4.5
                width: parent.width/2 - 10
                height: 30
                onlyNum: false
                onTextChanged: {
                    ammoData.combat_main_charge_type =text
                    console.log("Text content changed to: " + text)
                }
            }
            CTextInput{
                id:warheadMainChargeTypeText_add
                title: "装药类型:"
                pixelSize: 18
                titleWidth: pixelSize * 4.5
                width: parent.width/2 - 10
                height: 30
                visible: !warheadMainChargeTypeText.visible
                onlyNum: false
                onTextChanged: {
                    ammoData.combat_main_charge_type_add =text
                    console.log("Text content changed to: " + text)
                }
            }

            CTextInput{
                id:warheadChargeQualityText
                title: "装药质量(Kg):"
                pixelSize: 18
                titleWidth: pixelSize * 6.5
                width: parent.width/2 - 10
                height: 30
                onTextChanged: {
                    ammoData.combat_quantity =text
                    console.log("Text content changed to: " + text)
                }
            }
            CTextInput{
                id:warheadChargeQualityText_add
                title: "装药质量(Kg):"
                pixelSize: 18
                titleWidth: pixelSize * 6.5
                width: parent.width/2 - 10
                height: 30
                visible: !warheadChargeQualityText.visible
                onTextChanged: {
                    ammoData.combat_quantity_add =text
                    console.log("Text content changed to: " + text)
                }
            }

            CTextInput{
                id:warheadChargingDensityText
                title: "装药密度(/m³):"
                pixelSize: 18
                titleWidth: pixelSize * 6.5
                width: parent.width/2 - 10
                height: 30
                onTextChanged: {
                    ammoData.combat_charge_density =text
                    console.log("Text content changed to: " + text)
                }
            }
            CTextInput{
                id:warheadChargingDensityText_add
                title: "装药密度(/m³):"
                pixelSize: 18
                titleWidth: pixelSize * 6.5
                width: parent.width/2 - 10
                height: 30
                visible: !warheadChargingDensityText.visible
                onTextChanged: {
                    ammoData.combat_charge_density_add =text
                    console.log("Text content changed to: " + text)
                }
            }

            CTextInput{
                id:warheadFillingCoefficientText
                title: "装填系数:"
                pixelSize: 18
                titleWidth: pixelSize * 4.5
                width: parent.width/2 - 10
                height: 30
                onTextChanged: {
                    ammoData.combat_loading_factor =text
                    console.log("Text content changed to: " + text)
                }
            }
            CTextInput{
                id:warheadFillingCoefficientText_add
                title: "装填系数:"
                pixelSize: 18
                titleWidth: pixelSize * 4.5
                width: parent.width/2 - 10
                height: 30
                visible: !warheadFillingCoefficientText.visible
                onTextChanged: {
                    ammoData.combat_loading_factor_add =text
                    console.log("Text content changed to: " + text)
                }
            }

            CTextInput{
                id:warheadBoosterText
                title: "扩爆药(g):"
                pixelSize: 18
                titleWidth: pixelSize * 5
                width: parent.width/2 - 10
                height: 30
                onTextChanged: {
                    ammoData.combat_explosive =text
                    console.log("Text content changed to: " + text)
                }
            }
            CTextInput{
                id:warheadBoosterText_add
                title: "扩爆药(g):"
                pixelSize: 18
                titleWidth: pixelSize * 5
                width: parent.width/2 - 10
                height: 30
                visible: !warheadBoosterText.visible
                onTextChanged: {
                    ammoData.combat_explosive_add =text
                    console.log("Text content changed to: " + text)
                }
            }

            CTextInput{
                id:warheadfragmentsNumberText
                title: "破片数量:"
                pixelSize: 18
                titleWidth: pixelSize * 4.5
                width: parent.width/2 - 10
                height: 30
                onTextChanged: {
                    ammoData.combat_fragments_number =text
                    console.log("Text content changed to: " + text)
                }
            }
            CTextInput{
                id:warheadfragmentsNumberText_add
                title: "破片数量:"
                pixelSize: 18
                titleWidth: pixelSize * 4.5
                width: parent.width/2 - 10
                height: 30
                visible: !warheadfragmentsNumberText.visible
                onTextChanged: {
                    ammoData.combat_fragments_number_add =text
                    console.log("Text content changed to: " + text)
                }
            }

            CTextInput{
                id:warheadVehiclesEffectiveKillingRadiusText
                title: "有效杀伤半径[车辆](m):"
                pixelSize: 18
                titleWidth: pixelSize * 11.5
                width: parent.width/2 - 10
                height: 30
                onTextChanged: {
                    ammoData.combat_effective_killing_radius_vehicles =text
                    console.log("Text content changed to: " + text)
                }
            }
            CTextInput{
                id:warheadVehiclesEffectiveKillingRadiusText_add
                title: "有效杀伤半径[车辆](m):"
                pixelSize: 18
                titleWidth: pixelSize * 11.5
                width: parent.width/2 - 10
                height: 30
                visible: !warheadVehiclesEffectiveKillingRadiusText.visible
                onTextChanged: {
                    ammoData.combat_effective_killing_radius_vehicles_add =text
                    console.log("Text content changed to: " + text)
                }
            }

            CTextInput{
                id:warheadPeopleEffectiveKillingRadiusText
                title: "有效杀伤半径[人](m):"
                pixelSize: 18
                titleWidth: pixelSize * 10.5
                width: parent.width/2 - 10
                height: 30
                onTextChanged: {
                    ammoData.combat_effective_killing_radius_personnel =text
                    console.log("Text content changed to: " + text)
                }
            }
            CTextInput{
                id:warheadPeopleEffectiveKillingRadiusText_add
                title: "有效杀伤半径[人](m):"
                pixelSize: 18
                titleWidth: pixelSize * 10.5
                width: parent.width/2 - 10
                height: 30
                visible: !warheadPeopleEffectiveKillingRadiusText.visible
                onTextChanged: {
                    ammoData.combat_effective_killing_radius_personnel_add =text
                    console.log("Text content changed to: " + text)
                }
            }

            CTextInput{
                id:warheadInvasivenessText
                title: "侵袭能力:"
                pixelSize: 18
                titleWidth: pixelSize * 4.5
                width: parent.width/2 - 10
                height: 30
                onTextChanged: {
                    ammoData.combat_unit_invasion_capability =text
                    console.log("Text content changed to: " + text)
                }
            }
            CTextInput{
                id:warheadInvasivenessText_add
                title: "侵袭能力:"
                pixelSize: 18
                titleWidth: pixelSize * 4.5
                width: parent.width/2 - 10
                height: 30
                visible: !warheadInvasivenessText.visible
                onTextChanged: {
                    ammoData.combat_unit_invasion_capability_add =text
                    console.log("Text content changed to: " + text)
                }
            }

            CTextInput{
                id:warheadVerticalStaticArmorPenetrationDepthText
                title: "垂直静破甲深度:"
                pixelSize: 18
                titleWidth: pixelSize * 7.5
                width: parent.width/2 - 10
                height: 30
                onTextChanged: {
                    ammoData.combat_vertical_static_armor_penetration_depth =text
                    console.log("Text content changed to: " + text)
                }
            }
            CTextInput{
                id:warheadVerticalStaticArmorPenetrationDepthText_add
                title: "垂直静破甲深度:"
                pixelSize: 18
                titleWidth: pixelSize * 7.5
                width: parent.width/2 - 10
                height: 30
                visible: !warheadVerticalStaticArmorPenetrationDepthText.visible
                onTextChanged: {
                    ammoData.combat_vertical_static_armor_penetration_depth_add =text
                    console.log("Text content changed to: " + text)
                }
            }
        }

        CButton {
            id:saveButton
            anchors.right: cancleButton.left
            anchors.rightMargin: 15
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 10
            width: 100
            height: 40
            text: "保存"
            onClicked:{
//                                saveammunitionData()
                //addAmmoComponentWarheadRoot.visible = false
                addAmmoComponentWarheadPopup.close()
            }
        }

        CButton {
            id:cancleButton
            anchors.right: parent.right
            anchors.rightMargin: 10
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 10
            width: 100
            height: 40
            text: "返回"
            onClicked: {
                //addAmmoComponentWarheadRoot.visible = false
                addAmmoComponentWarheadPopup.close()
            }
        }

    }
    function allComponentEnable(){
        warheadTypeText.enabled = false
        warheadWeightText.enabled = false
        warheadLengthText.enabled = false
        warheadDiameterText.enabled = false
        warheadMainChargeTypeText.enabled = false
        warheadChargeQualityText.enabled = false
        warheadChargingDensityText.enabled = false
        warheadFillingCoefficientText.enabled = false
        warheadBoosterText.enabled = false
        warheadfragmentsNumberText.enabled = false
        warheadVehiclesEffectiveKillingRadiusText.enabled = false
        warheadPeopleEffectiveKillingRadiusText.enabled = false
        warheadInvasivenessText.enabled = false
        warheadVerticalStaticArmorPenetrationDepthText.enabled = false
        warheadTypeText_add.enabled = false
        warheadWeightText_add.enabled = false
        warheadLengthText_add.enabled = false
        warheadMainChargeTypeText_add.enabled = false
        warheadDiameterText_add.enabled = false
        warheadChargeQualityText_add.enabled = false
        warheadChargingDensityText_add.enabled = false
        warheadFillingCoefficientText_add.enabled = false
        warheadBoosterText_add.enabled = false
        warheadfragmentsNumberText_add.enabled = false
        warheadVehiclesEffectiveKillingRadiusText_add.enabled = false
        warheadPeopleEffectiveKillingRadiusText_add.enabled = false
        warheadInvasivenessText_add.enabled = false
        warheadVerticalStaticArmorPenetrationDepthText_add.enabled = false
    }

    function loadAmmoData() {

        if(addAmmoComponentWarheadRoot.selectedWarhead === "first"){
            //        topTitle.text = "增强型杀爆战斗部"
            //#pragma db not_null column("combat_department_quality")  //combat_department_quality REAL NOT NULL ,--COMMENT '战斗部质量',
            warheadWeightText.text  =   newAmmoData.ammoSelectData.combat_department_quality
            //#pragma db not_null column("combat_quantity")  //combat_quantity REAL NOT NULL ,--COMMENT '战斗部装药量',
            warheadChargeQualityText.text =    newAmmoData.ammoSelectData.combat_quantity
            //#pragma db not_null column("combat_unit_type")  //combat_unit_type VARCHAR(50) ,--COMMENT '战斗部类型',
             warheadTypeText.text =  newAmmoData.ammoSelectData.combat_unit_type
            //#pragma db not_null column("combat_length")  //combat_length  REAL NOT NULL ,--COMMENT '战斗部长度',
            warheadLengthText.text  =   newAmmoData.ammoSelectData.combat_length

            //#pragma db not_null column("combat_diameter")  //combat_diameter REAL NOT NULL ,--COMMENT '战斗部直径',
            warheadDiameterText.text  =   newAmmoData.ammoSelectData.combat_diameter
            //#pragma db not_null column("combat_main_charge_type")  //combat_main_charge_type VARCHAR(50) ,--COMMENT '战斗部主装药类型',
            warheadMainChargeTypeText.text =    newAmmoData.ammoSelectData.combat_main_charge_type
            //#pragma db not_null column("combat_charge_density")  //combat_charge_density REAL NOT NULL ,--COMMENT '战斗部装药密度',
            warheadChargingDensityText.text  =   newAmmoData.ammoSelectData.combat_charge_density
            //#pragma db not_null column("combat_loading_factor")  //combat_loading_factor REAL NOT NULL ,--COMMENT '战斗部装填系数',
            warheadFillingCoefficientText.text =    newAmmoData.ammoSelectData.combat_loading_factor
            //#pragma db not_null column("combat_explosive")  //combat_explosive REAL NOT NULL ,--COMMENT '战斗部扩爆药',
            warheadBoosterText.text  =   newAmmoData.ammoSelectData.combat_explosive
            //#pragma db not_null column("combat_fragments_number")  //combat_fragments_number INT NOT NULL ,--COMMENT '战斗部破片数量',
            warheadfragmentsNumberText.text  =   newAmmoData.ammoSelectData.combat_fragments_number
            //#pragma db not_null column("combat_unit_invasion_capability")  //combat_unit_invasion_capability VARCHAR(50) ,--COMMENT '战斗部侵袭能力',
            warheadInvasivenessText.text  =   newAmmoData.ammoSelectData.combat_unit_invasion_capability
            //#pragma db not_null column("combat_effective_killing_radius_vehicles")  //combat_effective_killing_radius_vehicles REAL NOT NULL ,--COMMENT '战斗部对车辆的有效杀伤半径',
            warheadVehiclesEffectiveKillingRadiusText.text =    newAmmoData.ammoSelectData.combat_effective_killing_radius_vehicles
            //#pragma db not_null column("combat_effective_killing_radius_personnel")   //combat_effective_killing_radius_personnel REAL NOT NULL ,--COMMENT '战斗部对人员的有效杀伤半径',
            warheadPeopleEffectiveKillingRadiusText.text =    newAmmoData.ammoSelectData.combat_effective_killing_radius_personnel
            //#pragma db not_null column("combat_vertical_static_armor_penetration_depth")  //combat_vertical_static_armor_penetration_depth REAL NOT NULL ,--COMMENT '战斗部垂直静破甲深度',
            warheadVerticalStaticArmorPenetrationDepthText.text =    newAmmoData.ammoSelectData.combat_vertical_static_armor_penetration_depth
        }else if(addAmmoComponentWarheadRoot.selectedWarhead === "second"){

            //#pragma db not_null column("combat_department_quality_add")  //combat_department_quality_add REAL NOT NULL ,--COMMENT '第二个战斗部质量',
            warheadWeightText_add.text  =  newAmmoData.ammoSelectData.combat_department_quality_add
            //#pragma db not_null column("combat_quantity_add")  //combat_quantity_add REAL NOT NULL ,--COMMENT '第二个战斗部装药量',
            warheadChargeQualityText_add.text =    newAmmoData.ammoSelectData.combat_quantity_add

            //#pragma db not_null column("combat_unit_type_add")  //combat_unit_type_add VARCHAR(50) ,--COMMENT '第二个战斗部类型',
            warheadTypeText_add.text  =   newAmmoData.ammoSelectData.combat_unit_type_add
            //#pragma db not_null column("combat_length_add")  //combat_length_add  REAL NOT NULL ,--COMMENT '第二个战斗部长度',
            warheadLengthText_add.text =    newAmmoData.ammoSelectData.combat_length_add
            //#pragma db not_null column("combat_diameter_add")  //combat_diameter_add REAL NOT NULL ,--COMMENT '第二个战斗部直径',
            warheadDiameterText_add.text  =   newAmmoData.ammoSelectData.combat_diameter_add
            //#pragma db not_null column("combat_main_charge_type_add")  //combat_main_charge_type_add VARCHAR(50) ,--COMMENT '第二个战斗部主装药类型',
            warheadMainChargeTypeText_add.text  =   newAmmoData.ammoSelectData.combat_main_charge_type_add
            //#pragma db not_null column("combat_charge_density_add")  //combat_charge_density_add REAL NOT NULL ,--COMMENT '第二个战斗部装药密度',
            warheadChargingDensityText_add.text  =   newAmmoData.ammoSelectData.combat_charge_density_add
            //#pragma db not_null column("combat_loading_factor_add")  //combat_loading_factor_add REAL NOT NULL ,--COMMENT '第二个战斗部装填系数',
            warheadFillingCoefficientText_add.text  =   newAmmoData.ammoSelectData.combat_loading_factor_add
            //#pragma db not_null column("combat_explosive_add")  //combat_explosive_add REAL NOT NULL ,--COMMENT '第二个战斗部扩爆药',
            warheadBoosterText_add.text   =  newAmmoData.ammoSelectData.combat_explosive_add
            //#pragma db not_null column("combat_fragments_number_add")  //combat_fragments_number_add INT NOT NULL ,--COMMENT '第二个战斗部破片数量',
            warheadfragmentsNumberText_add.text  =   newAmmoData.ammoSelectData.combat_fragments_number_add
            //#pragma db not_null column("combat_unit_invasion_capability_add")  //combat_unit_invasion_capability_add VARCHAR(50) ,--COMMENT '第二个战斗部侵袭能力',
            warheadInvasivenessText_add.text  =   newAmmoData.ammoSelectData.combat_unit_invasion_capability_add
            //#pragma db not_null column("combat_effective_killing_radius_vehicles_add")  //combat_effective_killing_radius_vehicles_add REAL NOT NULL ,--COMMENT '第二个战斗部对车辆的有效杀伤半径',
             warheadVehiclesEffectiveKillingRadiusText_add.text =   newAmmoData.ammoSelectData.combat_effective_killing_radius_vehicles_add

            //#pragma db not_null column("combat_effective_killing_radius_personnel_add")  //combat_effective_killing_radius_personnel_add REAL NOT NULL ,--COMMENT '第二个战斗部对人员的有效杀伤半径',
            warheadPeopleEffectiveKillingRadiusText_add.text  =   newAmmoData.ammoSelectData.combat_effective_killing_radius_personnel_add
            //#pragma db not_null column("combat_vertical_static_armor_penetration_depth_add")  //combat_vertical_static_armor_penetration_depth_add REAL NOT NULL ,--COMMENT '第二个战斗部垂直静破甲深度',
            warheadVerticalStaticArmorPenetrationDepthText_add.text  =   newAmmoData.ammoSelectData.combat_vertical_static_armor_penetration_depth_add
        }else if(addAmmoComponentWarheadRoot.selectedWarhead === "third"){
            //topTitle.text = "战斗部"
            //#pragma db not_null column("combat_department_quality")  //combat_department_quality REAL NOT NULL ,--COMMENT '战斗部质量',
            warheadWeightText.text  =   newAmmoData.ammoSelectData.combat_department_quality
            //#pragma db not_null column("combat_quantity")  //combat_quantity REAL NOT NULL ,--COMMENT '战斗部装药量',
            warheadChargeQualityText.text =    newAmmoData.ammoSelectData.combat_quantity
            //#pragma db not_null column("combat_unit_type")  //combat_unit_type VARCHAR(50) ,--COMMENT '战斗部类型',
             warheadTypeText.text =  newAmmoData.ammoSelectData.combat_unit_type
            //#pragma db not_null column("combat_length")  //combat_length  REAL NOT NULL ,--COMMENT '战斗部长度',
            warheadLengthText.text  =   newAmmoData.ammoSelectData.combat_length

            //#pragma db not_null column("combat_diameter")  //combat_diameter REAL NOT NULL ,--COMMENT '战斗部直径',
            warheadDiameterText.text  =   newAmmoData.ammoSelectData.combat_diameter
            //#pragma db not_null column("combat_main_charge_type")  //combat_main_charge_type VARCHAR(50) ,--COMMENT '战斗部主装药类型',
            warheadMainChargeTypeText.text =    newAmmoData.ammoSelectData.combat_main_charge_type
            //#pragma db not_null column("combat_charge_density")  //combat_charge_density REAL NOT NULL ,--COMMENT '战斗部装药密度',
            warheadChargingDensityText.text  =   newAmmoData.ammoSelectData.combat_charge_density
            //#pragma db not_null column("combat_loading_factor")  //combat_loading_factor REAL NOT NULL ,--COMMENT '战斗部装填系数',
            warheadFillingCoefficientText.text =    newAmmoData.ammoSelectData.combat_loading_factor
            //#pragma db not_null column("combat_explosive")  //combat_explosive REAL NOT NULL ,--COMMENT '战斗部扩爆药',
            warheadBoosterText.text  =   newAmmoData.ammoSelectData.combat_explosive
            //#pragma db not_null column("combat_fragments_number")  //combat_fragments_number INT NOT NULL ,--COMMENT '战斗部破片数量',
            warheadfragmentsNumberText.text  =   newAmmoData.ammoSelectData.combat_fragments_number
            //#pragma db not_null column("combat_unit_invasion_capability")  //combat_unit_invasion_capability VARCHAR(50) ,--COMMENT '战斗部侵袭能力',
            warheadInvasivenessText.text  =   newAmmoData.ammoSelectData.combat_unit_invasion_capability
            //#pragma db not_null column("combat_effective_killing_radius_vehicles")  //combat_effective_killing_radius_vehicles REAL NOT NULL ,--COMMENT '战斗部对车辆的有效杀伤半径',
            warheadVehiclesEffectiveKillingRadiusText.text =    newAmmoData.ammoSelectData.combat_effective_killing_radius_vehicles
            //#pragma db not_null column("combat_effective_killing_radius_personnel")   //combat_effective_killing_radius_personnel REAL NOT NULL ,--COMMENT '战斗部对人员的有效杀伤半径',
            warheadPeopleEffectiveKillingRadiusText =    newAmmoData.ammoSelectData.combat_effective_killing_radius_personnel
            //#pragma db not_null column("combat_vertical_static_armor_penetration_depth")  //combat_vertical_static_armor_penetration_depth REAL NOT NULL ,--COMMENT '战斗部垂直静破甲深度',
            warheadVerticalStaticArmorPenetrationDepthText.text =    newAmmoData.ammoSelectData.combat_vertical_static_armor_penetration_depth
        }else{
            console.log("Unkown selectedWarhead!")
        }


    }

    function saveAmmunitionData(){

    }

}

