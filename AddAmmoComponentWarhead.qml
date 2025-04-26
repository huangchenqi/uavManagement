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
    color:"cyan"
    property var selectedWarhead: "first"
    onSelectedWarheadChanged: {
        if(addAmmoComponentWarheadRoot.selectedWarhead === "first"){

        }else if(addAmmoComponentWarheadRoot.selectedWarhead === "second"){

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
            text: //"战斗部"
            {    if(addAmmoComponentWarheadRoot.selectedWarhead === "first"){
                          return "增强型杀爆战斗部战斗部"

                  }else if(addAmmoComponentWarheadRoot.selectedWarhead === "second"){
                          return "侵爆战斗部"
                  }else{
                          return "战斗部"
                          console.log("Unkown selectedWarhead!")
                  }

            }

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
                onTextChanged: {
                    if(addAmmoComponentWarheadRoot.selectedWarhead === "first"){
                            ammoData.combat_unit_type =text

                    }else if(addAmmoComponentWarheadRoot.selectedWarhead === "second"){

                            ammoData.combat_unit_type_add =text
                    }else{
                              ammoData.combat_unit_type =text
                              console.log("Unkown selectedWarhead!")
                    }

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
                    if(addAmmoComponentWarheadRoot.selectedWarhead === "first"){
                            ammoData.combat_department_quality =text

                    }else if(addAmmoComponentWarheadRoot.selectedWarhead === "second"){
                             ammoData.combat_department_quality_add =text
                    }else{
                              ammoData.combat_department_quality =text
                              console.log("Unkown selectedWarhead!")
                    }

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
                    if(addAmmoComponentWarheadRoot.selectedWarhead === "first"){
                             ammoData.combat_length =text

                    }else if(addAmmoComponentWarheadRoot.selectedWarhead === "second"){
                             ammoData.combat_length_add =text
                    }else{
                              ammoData.combat_length =text
                              console.log("Unkown selectedWarhead!")
                    }

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
                    if(addAmmoComponentWarheadRoot.selectedWarhead === "first"){
                        ammoData.combat_diameter =text
                    }else if(addAmmoComponentWarheadRoot.selectedWarhead === "second"){
                        ammoData.combat_diameter_add =text
                    }else{
                        ammoData.combat_diameter =text
                              console.log("Unkown selectedWarhead!")
                    }

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
                onTextChanged: {
                    if(addAmmoComponentWarheadRoot.selectedWarhead === "first"){
                       ammoData.combat_main_charge_type =text

                    }else if(addAmmoComponentWarheadRoot.selectedWarhead === "second"){
                        ammoData.combat_main_charge_type_add =text
                    }else{
                      ammoData.combat_main_charge_type =text
                      console.log("Unkown selectedWarhead!")
                    }

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
                    if(addAmmoComponentWarheadRoot.selectedWarhead === "first"){
                      ammoData.combat_quantity =text

                    }else if(addAmmoComponentWarheadRoot.selectedWarhead === "second"){
                      ammoData.combat_quantity_add =text
                    }else{
                      ammoData.combat_quantity =text
                      console.log("Unkown selectedWarhead!")
                    }

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
                    if(addAmmoComponentWarheadRoot.selectedWarhead === "first"){
                             ammoData.combat_charge_density =text

                      }else if(addAmmoComponentWarheadRoot.selectedWarhead === "second"){
                             ammoData.combat_charge_density_add =text
                      }else{
                              ammoData.combat_charge_density =text
                              console.log("Unkown selectedWarhead!")
                      }

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
                    if(addAmmoComponentWarheadRoot.selectedWarhead === "first"){
                              ammoData.combat_loading_factor =text

                      }else if(addAmmoComponentWarheadRoot.selectedWarhead === "second"){
                              ammoData.combat_loading_factor_add =text
                      }else{
                              ammoData.combat_loading_factor =text
                              console.log("Unkown selectedWarhead!")
                      }

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
                    if(addAmmoComponentWarheadRoot.selectedWarhead === "first"){
                              ammoData.combat_explosive =text

                      }else if(addAmmoComponentWarheadRoot.selectedWarhead === "second"){
                              ammoData.combat_explosive_add =text
                      }else{
                              ammoData.combat_explosive =text
                              console.log("Unkown selectedWarhead!")
                      }

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
                    if(addAmmoComponentWarheadRoot.selectedWarhead === "first"){
                          ammoData.combat_fragments_number =text

                      }else if(addAmmoComponentWarheadRoot.selectedWarhead === "second"){
                        ammoData.combat_fragments_number_add =text
                      }else{
                          ammoData.combat_fragments_number =text
                          console.log("Unkown selectedWarhead!")
                      }

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
                    if(addAmmoComponentWarheadRoot.selectedWarhead === "first"){
                           ammoData.combat_effective_killing_radius_vehicles =text

                      }else if(addAmmoComponentWarheadRoot.selectedWarhead === "second"){
                            ammoData.combat_effective_killing_radius_vehicles_add =text
                      }else{
                          ammoData.combat_effective_killing_radius_vehicles =text
                          console.log("Unkown selectedWarhead!")
                      }

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
                    if(addAmmoComponentWarheadRoot.selectedWarhead === "first"){
                              ammoData.combat_effective_killing_radius_personnel =text

                      }else if(addAmmoComponentWarheadRoot.selectedWarhead === "second"){
                              ammoData.combat_effective_killing_radius_personnel_add =text
                      }else{
                              ammoData.combat_effective_killing_radius_personnel =text
                              console.log("Unkown selectedWarhead!")
                      }

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
                    if(addAmmoComponentWarheadRoot.selectedWarhead === "first"){
                            ammoData.combat_unit_invasion_capability =text

                      }else if(addAmmoComponentWarheadRoot.selectedWarhead === "second"){
                            ammoData.combat_unit_invasion_capability_add =text
                      }else{
                          ammoData.combat_unit_invasion_capability =text
                          console.log("Unkown selectedWarhead!")
                      }

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
                    if(addAmmoComponentWarheadRoot.selectedWarhead === "first"){
                              ammoData.combat_vertical_static_armor_penetration_depth =text

                      }else if(addAmmoComponentWarheadRoot.selectedWarhead === "second"){
                              ammoData.combat_vertical_static_armor_penetration_depth_add =text
                      }else{
                              ammoData.combat_vertical_static_armor_penetration_depth =text
                              console.log("Unkown selectedWarhead!")
                      }

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
                addAmmoComponentWarheadRoot.visible = false
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
                addAmmoComponentWarheadRoot.visible = false
                addAmmoComponentWarheadPopup.close()
            }
        }

    }


    function saveammunitionData(){

    }
    function convertToJsonArray(jsonData) {

    }

    function saveDeliveryRecord() {

    }

}

