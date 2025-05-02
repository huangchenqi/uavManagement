import QtQuick 2.12
import QtQuick.Controls 2.12
import "qrc:/"
import "qrc:/AddAmmoModules/Component"
import UavDaoModel 1.0
Item{

    id:missileCommonData
    width: 1000
    height: 230

    property int selectType:0
    onSelectTypeChanged: {
        if(missileCommonData.selectType === 1 ){
            console.log("<><><>")
            loadAmmoData()
            allComponentEnable()
        }else if(missileCommonData.selectType === 2){
            loadAmmoData()
        }else{
            console.log("Unknown selectType!")
        }
    }
    UavModelDaoTableModel{
        id:uavModelDao
    }
    Rectangle {
        id:controlAmmunition
        anchors.fill: parent
        color:"#50000000"
        border.width: 1
        radius: 10
        CText {
            id: title
            text: qsTr("基本参数:")
            pixelSize: 25
            color: "#4EC4FF"
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.top: parent.top
            anchors.topMargin: 20
            horizontalAlignment: Text.AlignLeft
        }

        CText{
            id:ammoName
            text: "弹药名称:"
            anchors.left: title.left
            anchors.top: title.bottom
            anchors.topMargin: 30
            pixelSize: 20
            width: pixelSize * 4.5
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
                id:text_Input_Name
                anchors.fill: parent
                color:"#ffffffff"
                font.family:ammoName.family
                font.pixelSize:(18)
                selectByMouse: true
                selectionColor: "#ffcc8800"
                onTextChanged: {
                    // 使用正则表达式移除首尾的空白字符（包括空格、tab、换行）
                    var newText = text.replace(/^[\s\uFEFF\xA0]+|[\s\uFEFF\xA0]+$/g, '')
                    text_Input_Name.text = newText;
                    // 判断是否需要更新（避免无限循环）
                    // if (newText !== text) {
                    //     // 保存当前光标位置
                    //     var cursorPos = cursorPosition

                    //     // 更新文本
                    //     text = newText

                    //     // 恢复光标位置（考虑文本缩短的情况）
                    //     cursorPosition = Math.min(cursorPos, newText.length)
                    // }
                    newAmmoData.ammoData.ammoName =text
                    console.log("Text content changed to: " + text)
                }
                // onTextChanged: {
                //     if(text != "")
                //     {

                //     }
                // }
                onEditingFinished: {
                    newAmmoData.ammoData.ammoName =text
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

        Rectangle{
            id:rect_baseParam
            width: parent.width
            height: 40
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.top: title.bottom
            anchors.topMargin: 5
            color: "transparent"

        }

        Rectangle{
            color: "transparent"
            border.width: 1
            border.color: mainColor
            anchors.left: parent.left
            anchors.top: rect_baseParam.bottom
            anchors.topMargin: 15
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 15
            width: rect_baseParam.width - 5

            Rectangle{
                id:rect_missileParam
                color: "transparent"
                border.width: 0
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.topMargin: 15
                width: (rect_baseParam.width / 4 ) - (2 * rect_missileParam2.anchors.leftMargin)
                height: 200
                Rectangle{
                    anchors.left: parent.left
                    anchors.leftMargin: 5
                    anchors.top: parent.top
                    anchors.topMargin: 5
                    anchors.right: parent.right
                    anchors.rightMargin: 5
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 5
                    color: "transparent"

                    Column{
                        id:custom_colum
                        anchors.fill: parent
                        spacing: 20
                        //目标名
                        Item {
                            id: item_MissileRange
                            width: custom_colum.width
                            height: 20
                            CText{
                                id:text_MissileRangeTitle
                                width: pixelSize * 6
                                height: parent.height
                                anchors.left: parent.left
                                anchors.top: parent.top
                                pixelSize: 20
                                horizontalAlignment: Text.AlignLeft
                                color:mainColor
                                text:"弹药长度(m): "
                            }
                            Item{
                                width: parent.width - text_MissileRangeTitle.width
                                height: parent.height
                                anchors.left:text_MissileRangeTitle.right
                                anchors.top: parent.top
                                TextInput{
                                    id:text_Input_MissileRange
                                    anchors.fill: parent
                                    color:"#ffffffff"
                                    font.family:text_MissileRangeTitle.family
                                    font.pixelSize:(18)
                                    selectByMouse: true
                                    selectionColor: "#ffcc8800"
                                    validator: DoubleValidator {
                                                       bottom: -9999999
                                                       top: 9999999
                                                       notation: DoubleValidator.StandardNotation
                                                       decimals: 5
                                    }
                                    onTextChanged: {
                                        // if(text != "")
                                        // {

                                        // }
                                        newAmmoData.ammoData.ammoLenth = textToFloat(text)
                                        console.log("Text content changed to: " + text)
                                    }
                                    // onEditingFinished: {
                                    //     newAmmoData.ammoData.ammoLenth =text
                                    //     console.log("Text content changed to: " + text)
                                    // }
                                }
                                Rectangle{
                                    width: parent.width
                                    height: (2)
                                    anchors.left: parent.left
                                    anchors.bottom: parent.bottom
                                    color:mainColor
                                }
                            }
                        }
                        Item {
                            id: item_MissileDiameter
                            width: custom_colum.width
                            height: 20
                            CText{
                                id:text_MissileDiameterTitle
                                width: pixelSize * 6
                                height: parent.height
                                anchors.left: parent.left
                                anchors.top: parent.top
                                pixelSize: 20
                                horizontalAlignment: Text.AlignLeft
                                color:mainColor
                                text:"弹药直径(m): "
                            }
                            Item{
                                width: parent.width - text_MissileDiameterTitle.width
                                height: parent.height
                                anchors.left:text_MissileDiameterTitle.right
                                anchors.top: parent.top
                                TextInput{
                                    id:text_Input_MissileDiameter
                                    anchors.fill: parent
                                    color:"#ffffffff"
                                    font.family:text_MissileDiameterTitle.family
                                    font.pixelSize:(18)
                                    selectByMouse: true
                                    selectionColor: "#ffcc8800"
                                    validator: DoubleValidator {
                                                       bottom: -9999999
                                                       top: 9999999
                                                       notation: DoubleValidator.StandardNotation
                                                       decimals: 5
                                    }
                                    onTextChanged: {
                                        // if(text != "")
                                        // {

                                        // }
                                        newAmmoData.ammoData.ammoDiameter = textToFloat(text)
                                        console.log("Text content changed to: " + text)
                                    }
                                    // onEditingFinished: {
                                    //     newAmmoData.ammoData.ammoDiameter =text
                                    //     console.log("Text content changed to: " + text)
                                    // }
                                }
                                Rectangle{
                                    width: parent.width
                                    height: (2)
                                    anchors.left: parent.left
                                    anchors.bottom: parent.bottom
                                    color:mainColor
                                }
                            }
                        }
                        Item {
                            id: item_MissileWeight
                            width: custom_colum.width
                            height: 20
                            CText{
                                id:text_MissileWeightTitle
                                width: pixelSize * 6.5
                                height: parent.height
                                anchors.left: parent.left
                                anchors.top: parent.top
                                pixelSize: 20
                                horizontalAlignment: Text.AlignLeft
                                color:mainColor
                                text:"弹药重量(Kg): "
                            }
                            Item{
                                width: parent.width - text_MissileWeightTitle.width
                                height: parent.height
                                anchors.left:text_MissileWeightTitle.right
                                anchors.top: parent.top
                                TextInput{
                                    id:text_Input_MissileWeight
                                    anchors.fill: parent
                                    color:"#ffffffff"
                                    font.family:text_MissileWeightTitle.family
                                    font.pixelSize:(18)
                                    selectByMouse: true
                                    selectionColor: "#ffcc8800"
                                    validator: DoubleValidator {
                                                       bottom: -9999999
                                                       top: 9999999
                                                       notation: DoubleValidator.StandardNotation
                                                       decimals: 5
                                    }
                                    onTextChanged: {
                                        // if(text != "")
                                        // {

                                        // }
                                        newAmmoData.ammoData.ammoMass = textToFloat(text)
                                        console.log("Text content changed to: " + text)
                                    }
                                    // onEditingFinished: {
                                    //     newAmmoData.ammoData.ammoMass =text
                                    //     console.log("Text content changed to: " + text)
                                    // }
                                }
                                Rectangle{
                                    width: parent.width
                                    height: (2)
                                    anchors.left: parent.left
                                    anchors.bottom: parent.bottom
                                    color:mainColor
                                }
                            }
                        }
                    }
                }
            }

            Rectangle{
                id:rect_missileParam2
                color: "transparent"
                border.width: 0
                anchors.left: rect_missileParam.right
                anchors.leftMargin: 10
                anchors.top: rect_missileParam.top

                width: (rect_baseParam.width / 4 ) - (2 * rect_missileParam2.anchors.leftMargin)
                height: 200
                Rectangle{
                    anchors.left: parent.left
                    anchors.leftMargin: 5
                    anchors.top: parent.top
                    anchors.topMargin: 5
                    anchors.right: parent.right
                    anchors.rightMargin: 5
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 5
                    color: "transparent"

                    Column{
                        id:custom_colum2
                        anchors.fill: parent
                        spacing: 20
                        Item {
                            id: item_Wingspan
                            width: custom_colum2.width
                            height: 20
                            CText{
                                id:text_WingspanTitle
                                width: pixelSize * 4
                                height: parent.height
                                anchors.left: parent.left
                                anchors.top: parent.top
                                pixelSize: 20
                                horizontalAlignment: Text.AlignLeft
                                color:mainColor
                                text:"翼展(m): "
                            }
                            Item{
                                width: parent.width - text_WingspanTitle.width
                                height: parent.height
                                anchors.left:text_WingspanTitle.right
                                anchors.top: parent.top
                                TextInput{
                                    id:text_Input_Wingspan
                                    anchors.fill: parent
                                    color:"#ffffffff"
                                    font.family:text_WingspanTitle.family
                                    font.pixelSize:(18)
                                    selectByMouse: true
                                    selectionColor: "#ffcc8800"
                                    validator: DoubleValidator {
                                                       bottom: -9999999
                                                       top: 9999999
                                                       notation: DoubleValidator.StandardNotation
                                                       decimals: 5
                                    }
                                    onTextChanged: {
                                        // if(text != "")
                                        // {

                                        // }
                                        newAmmoData.ammoData.ammoWingspan = textToFloat(text)
                                        console.log("Text content changed to: " + text)

                                    }
                                    // onEditingFinished: {
                                    //     newAmmoData.ammoData.ammoWingspan =text
                                    //     console.log("Text content changed to: " + text)
                                    // }
                                }
                                Rectangle{
                                    width: parent.width
                                    height: (2)
                                    anchors.left: parent.left
                                    anchors.bottom: parent.bottom
                                    color:mainColor
                                }
                            }
                        }
                        Item {
                            id: item_MissileSheCheng
                            width: custom_colum2.width
                            height: 20
                            CText{
                                id:text_MissileSheChengTitle
                                width: pixelSize * 4.5
                                height: parent.height
                                anchors.left: parent.left
                                anchors.top: parent.top
                                pixelSize: 20
                                horizontalAlignment: Text.AlignLeft
                                color:mainColor
                                text:"射程(Km): "
                            }
                            Item{
                                width: parent.width - text_MissileSheChengTitle.width
                                height: parent.height
                                anchors.left:text_MissileSheChengTitle.right
                                anchors.top: parent.top
                                TextInput{
                                    id:text_Input_MissileSheCheng
                                    anchors.fill: parent
                                    color:"#ffffffff"
                                    font.family:text_MissileSheChengTitle.family
                                    font.pixelSize:(18)
                                    selectByMouse: true
                                    selectionColor: "#ffcc8800"
                                    validator: DoubleValidator {
                                                       bottom: -9999999
                                                       top: 9999999
                                                       notation: DoubleValidator.StandardNotation
                                                       decimals: 5
                                    }
                                    onTextChanged: {
                                        // if(text != "")
                                        // {

                                        // }
                                        newAmmoData.ammoData.effective_range = textToFloat(text)
                                        console.log("Text content changed to: " + text)

                                    }
                                    // onEditingFinished: {
                                    //     newAmmoData.ammoData.effective_range =text
                                    //     console.log("Text content changed to: " + text)
                                    // }
                                }
                                Rectangle{
                                    width: parent.width
                                    height: (2)
                                    anchors.left: parent.left
                                    anchors.bottom: parent.bottom
                                    color:mainColor
                                }
                            }
                        }
                        Item {
                            id: item_DanErJuli
                            width: custom_colum2.width
                            height: 20
                            CText{
                                id:text_DanErJuliTitle
                                width: pixelSize * 6
                                height: parent.height
                                anchors.left: parent.left
                                anchors.top: parent.top
                                pixelSize: 20
                                horizontalAlignment: Text.AlignLeft
                                color:mainColor
                                text:"准备时间(s): "
                            }
                            Item{
                                width: parent.width - text_DanErJuliTitle.width
                                height: parent.height
                                anchors.left:text_DanErJuliTitle.right
                                anchors.top: parent.top
                                TextInput{
                                    id:text_action_time
                                    anchors.fill: parent
                                    color:"#ffffffff"
                                    font.family:text_DanErJuliTitle.family
                                    font.pixelSize:(18)
                                    selectByMouse: true
                                    selectionColor: "#ffcc8800"
                                    validator: DoubleValidator {
                                                       bottom: -9999999
                                                       top: 9999999
                                                       notation: DoubleValidator.StandardNotation
                                                       decimals: 5
                                    }
                                    onTextChanged: {
                                        // if(text != "")
                                        // {

                                        // }
                                        newAmmoData.ammoData.preparation_time = textToFloat(text)
                                        console.log("Text content changed to: " + text)

                                    }
                                    // onEditingFinished: {
                                    //     newAmmoData.ammoData.preparation_time =text
                                    //     console.log("Text content changed to: " + text)
                                    // }
                                }
                                Rectangle{
                                    width: parent.width
                                    height: (2)
                                    anchors.left: parent.left
                                    anchors.bottom: parent.bottom
                                    color:mainColor
                                }
                            }
                        }
                    }
                }
            }

            Rectangle{
                id:rect_missileParam3
                color: "transparent"
                border.width: 0
                anchors.left: rect_missileParam2.right
                anchors.leftMargin: 10
                anchors.top: rect_missileParam2.top

                width: (rect_baseParam.width / 4 ) - (2 * rect_missileParam2.anchors.leftMargin)
                height: 200
                Rectangle{
                    anchors.left: parent.left
                    anchors.leftMargin: 5
                    anchors.top: parent.top
                    anchors.topMargin: 5
                    anchors.right: parent.right
                    anchors.rightMargin: 5
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 5
                    color: "transparent"

                    Column{
                        id:custom_colum3
                        anchors.fill: parent
                        spacing: 20
                        Item {
                            id: item_BombSpeedMin
                            width: custom_colum3.width
                            height: 20
                            CText{
                                id:text_BombSpeedMinTitle
                                width: pixelSize * 4.5
                                height: parent.height
                                anchors.left: parent.left
                                anchors.top: parent.top
                                pixelSize: 20
                                horizontalAlignment: Text.AlignLeft
                                color:mainColor
                                text:"命中精度: "
                            }
                            Item{
                                id:item_InputBombSpeedMin
                                width: parent.width - text_BombSpeedMinTitle.width
                                height: parent.height
                                anchors.left:text_BombSpeedMinTitle.right
                                anchors.top: parent.top
                                TextInput{
                                    id:text_hit_accuracy
                                    anchors.fill: parent
                                    color:"#ffffffff"
                                    font.family:text_BombSpeedMinTitle.family
                                    font.pixelSize:(18)
                                    selectByMouse: true
                                    selectionColor: "#ffcc8800"
                                    validator: DoubleValidator {
                                                       bottom: -9999999
                                                       top: 9999999
                                                       notation: DoubleValidator.StandardNotation
                                                       decimals: 5
                                    }
                                    onTextChanged: {
                                        // if(text != "")
                                        // {

                                        // }
                                        newAmmoData.ammoData.hit_accuracy = textToFloat(text)
                                        console.log("Text content changed to: " + text)
                                    }
                                    // onEditingFinished: {
                                    //     newAmmoData.ammoData.hit_accuracy =text
                                    //     console.log("Text content changed to: " + text)
                                    // }
                                }
                                Rectangle{
                                    width: parent.width
                                    height: (2)
                                    anchors.left: parent.left
                                    anchors.bottom: parent.bottom
                                    color:mainColor
                                }
                            }
                        }
                        Item {
                            id: item_BombSpeedMax
                            width: custom_colum3.width
                            height: 20
                            CText{
                                id:text_BombSpeedMaxTitle
                                width: pixelSize * 6
                                height: parent.height
                                anchors.left: parent.left
                                anchors.top: parent.top
                                pixelSize: 20
                                horizontalAlignment: Text.AlignLeft
                                color:mainColor
                                text:"命中概率(%): "
                            }
                            Item{
                                width: parent.width - text_BombSpeedMaxTitle.width
                                height: parent.height
                                anchors.left:text_BombSpeedMaxTitle.right
                                anchors.top: parent.top
                                TextInput{
                                    id:text_hit_probability
                                    anchors.fill: parent
                                    color:"#ffffffff"
                                    font.family:text_BombSpeedMaxTitle.family
                                    font.pixelSize:(18)
                                    selectByMouse: true
                                    selectionColor: "#ffcc8800"
                                    validator: DoubleValidator {
                                                       bottom: -9999999
                                                       top: 9999999
                                                       notation: DoubleValidator.StandardNotation
                                                       decimals: 5
                                    }
                                    onTextChanged: {
                                        // if(text != "")
                                        // {

                                        // }
                                        newAmmoData.ammoData.hit_probability = textToFloat(text)
                                        console.log("Text content changed to: " + text)
                                    }
                                    // onEditingFinished: {
                                    //     newAmmoData.ammoData.hit_probability =text
                                    //     console.log("Text content changed to: " + text)
                                    // }
                                }
                                Rectangle{
                                    width: parent.width
                                    height: (2)
                                    anchors.left: parent.left
                                    anchors.bottom: parent.bottom
                                    color:mainColor
                                }
                            }
                        }

                        Item {
                            id: item_BombHeightMin
                            width: custom_colum3.width
                            height: 20
                            CText{
                                id:text_BombHeightTitle
                                width: pixelSize * 4.5
                                height: parent.height
                                anchors.left: parent.left
                                anchors.top: parent.top
                                pixelSize: 20
                                horizontalAlignment: Text.AlignLeft
                                color:mainColor
                                text:"舵宽(mm): "
                            }
                            Item{
                                id:item_InputBombHeightMin
                                width: parent.width - text_BombHeightTitle.width
                                height: parent.height
                                anchors.left:text_BombHeightTitle.right
                                anchors.top: parent.top
                                TextInput{
                                    id:text_rudder_width
                                    anchors.fill: parent
                                    color:"#ffffffff"
                                    font.family:text_BombHeightTitle.family
                                    font.pixelSize:(18)
                                    selectByMouse: true
                                    selectionColor: "#ffcc8800"
                                    validator: DoubleValidator {
                                                       bottom: -9999999
                                                       top: 9999999
                                                       notation: DoubleValidator.StandardNotation
                                                       decimals: 5
                                    }
                                    onTextChanged: {
                                        // if(text != "")
                                        // {

                                        // }
                                        newAmmoData.ammoData.rudder_width = textToFloat(text)
                                        console.log("Text content changed to: " + text)
                                    }
                                    // onEditingFinished: {
                                    //     newAmmoData.ammoData.rudder_width =text
                                    //     console.log("Text content changed to: " + text)
                                    // }
                                }
                                Rectangle{
                                    width: parent.width
                                    height: (2)
                                    anchors.left: parent.left
                                    anchors.bottom: parent.bottom
                                    color:mainColor
                                }
                            }
                        }
                    }
                }
            }

            Rectangle{
                id:rect_missileParam4
                color: "transparent"
                anchors.left: rect_missileParam3.right
                anchors.leftMargin: 10
                anchors.top: rect_missileParam3.top

                width: (rect_baseParam.width / 4 ) + (2 * rect_missileParam2.anchors.leftMargin)
                height: parent.height
                Rectangle{
                    anchors.left: parent.left
                    anchors.leftMargin: 5
                    anchors.top: parent.top
                    anchors.topMargin: 5
                    anchors.right: parent.right
                    anchors.rightMargin: 5
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 5
                    color: "transparent"

                    Column{
                        id:custom_colum4
                        anchors.fill: parent
                        spacing: 20
                        Item {
                            id: item_FlightTime
                            width: custom_colum4.width
                            height: 20
                            CText{
                                id:text_FlightTimeTitle
                                width: pixelSize * 9
                                height: parent.height
                                anchors.left: parent.left
                                anchors.top: parent.top
                                pixelSize: 20
                                horizontalAlignment: Text.AlignLeft
                                color:mainColor
                                text:"连续载飞时间(min): "
                            }
                            Item{
                                width: parent.width - text_FlightTimeTitle.width
                                height: parent.height
                                anchors.left:text_FlightTimeTitle.right
                                anchors.top: parent.top
                                TextInput{
                                    id:text_Input_FlightTime
                                    anchors.fill: parent
                                    color:"#ffffffff"
                                    font.family:text_FlightTimeTitle.family
                                    font.pixelSize:(18)
                                    selectByMouse: true
                                    selectionColor: "#ffcc8800"
                                    validator: DoubleValidator {
                                                       bottom: -9999999
                                                       top: 9999999
                                                       notation: DoubleValidator.StandardNotation
                                                       decimals: 5
                                    }
                                    onTextChanged: {
                                        // if(text != "")
                                        // {

                                        // }
                                        newAmmoData.ammoData.allow_continuous_flight_time = textToFloat(text)
                                        console.log("Text content changed to: " + text)
                                    }
                                    // onEditingFinished: {
                                    //     newAmmoData.ammoData.allow_continuous_flight_time =text
                                    //     console.log("Text content changed to: " + text)
                                    // }
                                }
                                Rectangle{
                                    width: parent.width
                                    height: (2)
                                    anchors.left: parent.left
                                    anchors.bottom: parent.bottom
                                    color:mainColor
                                }
                            }
                        }

                        Item {
                            id: item_GuidFlightTime
                            width: custom_colum4.width
                            height: 20
                            CText{
                                id:text_GuidFlightTimeTitle
                                width: pixelSize * 8
                                height: parent.height
                                anchors.left: parent.left
                                anchors.top: parent.top
                                pixelSize: 20
                                horizontalAlignment: Text.AlignLeft
                                color:mainColor
                                text:"制导飞行时间(h): "
                            }
                            Item{
                                width: parent.width - text_GuidFlightTimeTitle.width
                                height: parent.height
                                anchors.left:text_GuidFlightTimeTitle.right
                                anchors.top: parent.top
                                TextInput{
                                    id:text_Input_GuidFlightTime
                                    anchors.fill: parent
                                    color:"#ffffffff"
                                    font.family:text_GuidFlightTimeTitle.family
                                    font.pixelSize:(18)
                                    selectByMouse: true
                                    selectionColor: "#ffcc8800"
                                    validator: DoubleValidator {
                                                       bottom: -9999999
                                                       top: 9999999
                                                       notation: DoubleValidator.StandardNotation
                                                       decimals: 5
                                    }
                                    onTextChanged: {
                                        // if(text != "")
                                        // {

                                        // }
                                        newAmmoData.ammoData.guided_flight_time = textToFloat(text)
                                        console.log("Text content changed to: " + text)
                                    }
                                    // onEditingFinished: {
                                    //     newAmmoData.ammoData.guided_flight_time =text
                                    //     console.log("Text content changed to: " + text)
                                    // }
                                }
                                Rectangle{
                                    width: parent.width
                                    height: (2)
                                    anchors.left: parent.left
                                    anchors.bottom: parent.bottom
                                    color:mainColor
                                }
                            }
                        }

                        Item {
                            id: item_MaxSpeed
                            width: custom_colum4.width
                            height: 20
                            CText{
                                id:text_MaxSpeedTitle
                                width: pixelSize * 9.5
                                height: parent.height
                                anchors.left: parent.left
                                anchors.top: parent.top
                                pixelSize: 20
                                horizontalAlignment: Text.AlignLeft
                                color:mainColor
                                text:"导弹最大速度(Km/h): "
                            }
                            Item{
                                width: parent.width - text_MaxSpeedTitle.width
                                height: parent.height
                                anchors.left:text_MaxSpeedTitle.right
                                anchors.top: parent.top
                                TextInput{
                                    id:text_Input_MaxSpeed
                                    anchors.fill: parent
                                    color:"#ffffffff"
                                    font.family:text_MaxSpeedTitle.family
                                    font.pixelSize:(18)
                                    selectByMouse: true
                                    selectionColor: "#ffcc8800"
                                    validator: DoubleValidator {
                                                       bottom: -9999999
                                                       top: 9999999
                                                       notation: DoubleValidator.StandardNotation
                                                       decimals: 5
                                    }
                                    onTextChanged: {
                                        // if(text != "")
                                        // {

                                        // }
                                        newAmmoData.ammoData.maximum_speed_of_missile = textToFloat(text)
                                        console.log("Text content changed to: " + text)
                                    }
                                    // onEditingFinished: {
                                    //     newAmmoData.ammoData.maximum_speed_of_missile =text
                                    //     console.log("Text content changed to: " + text)
                                    // }
                                }
                                Rectangle{
                                    width: parent.width
                                    height: (2)
                                    anchors.left: parent.left
                                    anchors.bottom: parent.bottom
                                    color:mainColor
                                }
                            }
                        }
                    }
                }
            }

        }

        Label{
            id:uavType
            text: "对应无人机类型:"
            anchors.left: item_NameInput.right
            anchors.leftMargin: 10
            anchors.verticalCenter: ammoName.verticalCenter
            font.pixelSize: 20
            font.bold: true
            color: mainColor
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
                            selectType = index
                            m_SelectState = !m_SelectState
                            isSelect = m_SelectState                            
                            // 检查数组中是否已经存在该数字
                                var uavIndex = uavArray.indexOf(m_PlanNumber)

                                if (uavIndex === -1) {
                                    // 数字不存在，添加到数组
                                    uavArray.push(m_PlanNumber)
                                    console.log("Number added: " + m_PlanNumber)
                                } else {
                                    // 数字已存在，从数组中删除
                                    uavArray.splice(uavIndex, 1)
                                    console.log("Number removed: " + m_PlanNumber)
                                }
                            // 检查数组中是否已经存在该数字
                            // if (!newAmmoData.uavArray.includes(m_PlanNumber)) {
                            //     newAmmoData.uavArray.push(m_PlanNumber) // 添加数字到数组
                            //     console.log("Number added: " + m_PlanNumber)
                            // } else {
                            //     console.log("Number already exists: " + m_PlanNumber)
                            // }
                            console.log("uavArray"+newAmmoData.uavArray)

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
            anchors.verticalCenter: uavType.verticalCenter
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

    }
    function allComponentEnable(){
        text_Input_Name.enabled = false
        text_Input_MissileRange.enabled = false
        text_Input_MissileDiameter.enabled = false
        text_Input_MissileWeight.enabled = false
        text_Input_Wingspan.enabled = false
        text_Input_MissileSheCheng.enabled = false

       // newAmmoData.ammoSelectData.ammoToUavModel = ""
        text_action_time.enabled = false
        text_hit_accuracy.enabled = false
        text_hit_probability.enabled = false
        text_rudder_width.enabled = false
        text_Input_FlightTime.enabled = false
        text_Input_GuidFlightTime.enabled = false
        text_Input_MaxSpeed.enabled = false

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

   function loadAmmoData(){

       //#pragma db not_null column("ammo_name")//            VARCHAR(100) NOT NULL ,--COMMENT '名称',
       text_Input_Name.text  = newAmmoData.ammoSelectData.ammoName

       //#pragma db not_null column("used_uav_models")                        // used_uav_models VARCHAR(200) NOT NULL ,--COMMENT '使用机型'
      // newAmmoData.ammoSelectData.ammoToUavModel = ""

     text_Input_MissileRange.text = newAmmoData.ammoSelectData.ammoLenth
       //#pragma db not_null column("mass")    //mass REAL NOT NULL ,--COMMENT '炸弹质量(kg)',
     text_Input_MissileWeight.text =  newAmmoData.ammoSelectData.ammoMass
       //#pragma db not_null column("diameter")   //        diameter REAL NOT NULL ,--COMMENT '直径(m)',
     text_Input_MissileDiameter.text =  newAmmoData.ammoSelectData.ammoDiameter
       //#pragma db not_null column("wingspan") //wingspan REAL NOT NULL ,--COMMENT '翼展(m)',
     text_Input_Wingspan.text   =  newAmmoData.ammoSelectData.ammoWingspan
       //#pragma db not_null column("effective_range") //effective_range REAL NOT NULL ,--COMMENT '射程',
       text_Input_MissileSheCheng.text  =  newAmmoData.ammoSelectData.effective_range
       text_action_time.text =   newAmmoData.ammoSelectData.action_time
       text_hit_accuracy.text  = newAmmoData.ammoSelectData.hit_accuracy
       text_hit_probability.text =  newAmmoData.ammoSelectData.hit_probability
       text_rudder_width.text =  newAmmoData.ammoSelectData.rudder_width
       text_Input_FlightTime.text  =  newAmmoData.ammoSelectData.allow_continuous_flight_time
       text_Input_GuidFlightTime.text  = newAmmoData.ammoSelectData.guided_flight_time
       text_Input_MaxSpeed.text =  newAmmoData.ammoSelectData.maximum_speed_of_missile
       //view_List_TypeSelect

    }

}

