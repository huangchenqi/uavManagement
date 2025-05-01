import QtQuick 2.12
import QtQuick.Controls 2.12
import "qrc:/"
import "qrc:/AddAmmoModules/Component"
import UavDaoModel 1.0
import AmmoDaoModel 1.0
Item{//航空导弹与航空炸弹
    id:missileCommonData
    width: 800
    height: 300

    property int selectType:0 //0 代表新增，1代表查看，2代表修改。

    property int shaShangType: 0
    property string text: ""

    AmmoDaoTableModel{
        id:ammoDaoModel
    }
    onSelectTypeChanged: {
        if(missileCommonData.selectType === 1 || missileCommonData.selectType === 2){
            console.log("<><><>")
            loadAmmoData()
        }

    }
    UavModelDaoTableModel{
        id:uavModelDao
    }
    Component.onCompleted: {
    }

    Rectangle {
        id:controlAmmunition
        anchors.fill: parent
        color:"#50000000"
        border.width: 1
        radius: 10
        CText {
            id: title
            text: qsTr("弹药基础属性:")
            pixelSize: 25
            color: "#4EC4FF"
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.top: parent.top
            anchors.topMargin: 20
            horizontalAlignment: Text.AlignLeft


        }

        Label{
            id:ammoName
            text: "弹药名称:"
            anchors.left: title.left
            anchors.leftMargin: 5
            anchors.top: title.bottom
            anchors.topMargin: 25
            font.pixelSize: 20
            font.bold: true
            color: mainColor
        }

        TextField{
            id:input_name
            anchors.left: ammoName.right
            anchors.leftMargin: 5
            width: 200
            anchors.verticalCenter: ammoName.verticalCenter
            font.pixelSize: 20
            font.bold: true

            onTextChanged: {
                // 使用正则表达式移除首尾的空白字符（包括空格、tab、换行）
                var newText = text.replace(/^[\s\uFEFF\xA0]+|[\s\uFEFF\xA0]+$/g, '')
                input_name.text = newText;
                // 判断是否需要更新（避免无限循环）
                // if (newText !== text) {
                //     // 保存当前光标位置
                //     var cursorPos = cursorPosition

                //     // 更新文本
                //     text = newText

                //     // 恢复光标位置（考虑文本缩短的情况）
                //     cursorPosition = Math.min(cursorPos, newText.length)
                // }
            }

            onEditingFinished: {
                ammoData.ammoName =text
                console.log("Text content changed to: " + text)
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
            anchors.left: rect_baseParam.left
            anchors.top: rect_baseParam.bottom
            anchors.topMargin: 15
            width: rect_baseParam.width - 15
            height: 200

            Rectangle{
                id:rect_missileParam
                color: "transparent"
                border.width: 0
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.topMargin: 15
                width: rect_baseParam.width / 4
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
                                    // onTextChanged: {
                                    //     if(text != "")
                                    //     {

                                    //     }
                                    // }
                                    onEditingFinished: {
                                        ammoData.ammoLenth =text
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
                                    // onTextChanged: {
                                    //     if(text != "")
                                    //     {

                                    //     }
                                    // }
                                    onEditingFinished: {
                                        ammoData.ammoDiameter =text
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
                                    // onTextChanged: {
                                    //     if(text != "")
                                    //     {

                                    //     }
                                    // }
                                    onEditingFinished: {
                                        ammoData.ammoMass =text
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
                        }
                        Item {
                            id: item_FillWeight
                            width: custom_colum.width
                            height: 20
                            CText{
                                id:text_FillWeightTitle
                                width: pixelSize * 6.5
                                height: parent.height
                                anchors.left: parent.left
                                anchors.top: parent.top
                                pixelSize: 20
                                horizontalAlignment: Text.AlignLeft
                                color:mainColor
                                text:"装药质量(Kg): "
                            }
                            Item{
                                width: parent.width - text_FillWeightTitle.width
                                height: parent.height
                                anchors.left:text_FillWeightTitle.right
                                anchors.top: parent.top
                                TextInput{
                                    id:text_Input_FillWeight
                                    anchors.fill: parent
                                    color:"#ffffffff"
                                    font.family:text_FillWeightTitle.family
                                    font.pixelSize:(18)
                                    selectByMouse: true
                                    selectionColor: "#ffcc8800"
                                    validator: DoubleValidator {
                                                       bottom: -9999999
                                                       top: 9999999
                                                       notation: DoubleValidator.StandardNotation
                                                       decimals: 5
                                    }
                                    // onTextChanged: {
                                    //     if(text != "")
                                    //     {

                                    //     }
                                    // }
                                    onEditingFinished: {
                                        ammoData.ammoChargeMass =text
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

                width: rect_baseParam.width / 4
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
                                width: pixelSize * 4.5
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
                                    // onTextChanged: {
                                    //     if(text != "")
                                    //     {

                                    //     }
                                    // }
                                    onEditingFinished: {
                                        ammoData.ammoWingspan =text
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
                                    // onTextChanged: {
                                    //     if(text != "")
                                    //     {

                                    //     }
                                    // }
                                    onEditingFinished: {
                                        ammoData.effective_range =text
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
                        }
                        Item {
                            id: item_DanErJuli
                            width: custom_colum2.width
                            height: 20
                            CText{
                                id:text_DanErJuliTitle
                                width: pixelSize * 7
                                height: parent.height
                                anchors.left: parent.left
                                anchors.top: parent.top
                                pixelSize: 20
                                horizontalAlignment: Text.AlignLeft
                                color:mainColor
                                text:"弹耳间距(mm): "
                            }
                            Item{
                                width: parent.width - text_DanErJuliTitle.width
                                height: parent.height
                                anchors.left:text_DanErJuliTitle.right
                                anchors.top: parent.top
                                TextInput{
                                    id:text_Input_DanErJuli
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
                                    // onTextChanged: {
                                    //     if(text != "")
                                    //     {

                                    //     }
                                    // }
                                    onEditingFinished: {
                                        ammoData.ammoLugSpacing =text
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
                        }

                        Item {
                            id: item_ShaShangFangshi
                            width: custom_colum2.width
                            height: 20
                            CText{
                                id:text_ShaShangFangshiTitle
                                width: pixelSize * 4.5
                                height: parent.height
                                anchors.left: parent.left
                                anchors.top: parent.top
                                pixelSize: 20
                                horizontalAlignment: Text.AlignLeft
                                color:mainColor
                                text:"杀伤方式: "
                            }
                            CButton{
                                id:text_Input_ShaShangFangshi
                                width: parent.width - text_ShaShangFangshiTitle.width
                                height: 36
                                anchors.left:text_ShaShangFangshiTitle.right
                                color:"#ffddaa00"
                                borderColor: "#ffddaa00"
                                borderHigtColor: "#ffeebb22"
                                anchors.verticalCenter: text_ShaShangFangshiTitle.verticalCenter
                                pixelSize: 20
                                text:{
                                    if(shaShangType < 0)
                                    {
                                        return "方式1"
                                    }
                                    else
                                    {
                                        if(listmodel_Box_ShaSHangType.count > 0)
                                          return  listmodel_Box_ShaSHangType.get(shaShangType).m_TypeName
                                    }
                                }
                                onClicked: {
                                    view_List_ShaShangTypeSelect.visible = !view_List_ShaShangTypeSelect.visible
                                }
                            }
                            ListView{
                                id:view_List_ShaShangTypeSelect
                                width: text_Input_ShaShangFangshi.width
                                height: text_Input_ShaShangFangshi.height * 5
                                anchors.left: text_Input_ShaShangFangshi.left
                                anchors.leftMargin: text_Input_ShaShangFangshi.width/2 - width/2
                                anchors.top: text_Input_ShaShangFangshi.bottom
                                anchors.topMargin: 2
                                visible: false
                                clip: true
                                model:ListModel{
                                    id:listmodel_Box_ShaSHangType
                                }
                                delegate:Component{
                                    Item{
                                        id:item_Delegate
                                        width: view_List_ShaShangTypeSelect.width
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
                                                view_List_ShaShangTypeSelect.visible = false
                                                shaShangType = index
                                                // m_SelectState = !m_SelectState
                                                console.log(text_Input_ShaShangFangshi.text)
                                            }
                                        }
                                    }
                                }
                                Component.onCompleted: {
                                    listmodel_Box_ShaSHangType.append({m_TypeName:"方式1",m_SelectState:false})
                                    listmodel_Box_ShaSHangType.append({m_TypeName:"方式2",m_SelectState:false})
                                    listmodel_Box_ShaSHangType.append({m_TypeName:"方式3",m_SelectState:false})

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

                width: rect_baseParam.width / 4
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
                                width: pixelSize * 9.5
                                height: parent.height
                                anchors.left: parent.left
                                anchors.top: parent.top
                                pixelSize: 20
                                horizontalAlignment: Text.AlignLeft
                                color:mainColor
                                text:"最小投弹速度(Km/h): "
                            }
                            Item{
                                id:item_InputBombSpeedMin
                                width: parent.width - text_BombSpeedMinTitle.width
                                height: parent.height
                                anchors.left:text_BombSpeedMinTitle.right
                                anchors.top: parent.top
                                TextInput{
                                    id:text_Input_BombSpeedMin
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
                                    // onTextChanged: {
                                    //     if(text != "")
                                    //     {

                                    //     }
                                    // }
                                    onEditingFinished: {
                                        ammoData.ammoMinReleaseSpeed =text
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
                        }
                        Item {
                            id: item_BombSpeedMax
                            width: custom_colum3.width
                            height: 20
                            CText{
                                id:text_BombSpeedMaxTitle
                                width: pixelSize * 9.5
                                height: parent.height
                                anchors.left: parent.left
                                anchors.top: parent.top
                                pixelSize: 20
                                horizontalAlignment: Text.AlignLeft
                                color:mainColor
                                text:"最大投弹速度(Km/h): "
                            }
                            Item{
                                width: parent.width - text_BombSpeedMaxTitle.width
                                height: parent.height
                                anchors.left:text_BombSpeedMaxTitle.right
                                anchors.top: parent.top
                                TextInput{
                                    id:text_Input_BombSpeedMax
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
                                    // onTextChanged: {
                                    //     if(text != "")
                                    //     {

                                    //     }
                                    // }
                                    onEditingFinished: {
                                        ammoData.ammoMaxReleaseSpeed =text
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
                        }

                        Item {
                            id: item_BombHeightMin
                            width: custom_colum3.width
                            height: 20
                            CText{
                                id:text_BombHeightTitle
                                width: pixelSize * 8.5
                                height: parent.height
                                anchors.left: parent.left
                                anchors.top: parent.top
                                pixelSize: 20
                                horizontalAlignment: Text.AlignLeft
                                color:mainColor
                                text:"最小投弹高度(Km): "
                            }
                            Item{
                                id:item_InputBombHeightMin
                                width: parent.width - text_BombHeightTitle.width
                                height: parent.height
                                anchors.left:text_BombHeightTitle.right
                                anchors.top: parent.top
                                TextInput{
                                    id:text_Input_BombHeightMin
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
                                    // onTextChanged: {
                                    //     if(text != "")
                                    //     {

                                    //     }
                                    // }
                                    onEditingFinished: {
                                        ammoData.ammoMinReleaseHeight =text
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
                        }
                        Item {
                            id: item_BombHeightMax
                            width: custom_colum3.width
                            height: 20
                            CText{
                                id:text_BombHeightMaxTitle
                                width: pixelSize * 8.5
                                height: parent.height
                                anchors.left: parent.left
                                anchors.top: parent.top
                                pixelSize: 20
                                horizontalAlignment: Text.AlignLeft
                                color:mainColor
                                text:"最大投弹高度(Km): "
                            }
                            Item{
                                width: parent.width - text_BombHeightMaxTitle.width
                                height: parent.height
                                anchors.left:text_BombHeightMaxTitle.right
                                anchors.top: parent.top
                                TextInput{
                                    id:text_Input_BombHeightMax
                                    anchors.fill: parent
                                    color:"#ffffffff"
                                    font.family:text_BombHeightMaxTitle.family
                                    font.pixelSize:(18)
                                    selectByMouse: true
                                    selectionColor: "#ffcc8800"
                                    validator: DoubleValidator {
                                                       bottom: -9999999
                                                       top: 9999999
                                                       notation: DoubleValidator.StandardNotation
                                                       decimals: 5
                                    }
                                    // onTextChanged: {
                                    //     if(text != "")
                                    //     {

                                    //     }
                                    // }
                                    onEditingFinished: {
                                        ammoData.ammoMaxReleaseHeight =text
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
                        }
                    }
                }
            }


            Rectangle {
                id: item_FuzeModel
                height: 20
                color: "transparent"
                anchors.left: rect_missileParam3.right
                anchors.leftMargin: 5
                anchors.top: rect_missileParam3.top
                anchors.topMargin: 10
                anchors.right: parent.right
                anchors.rightMargin: 5

                CText{
                    id:text_FuzeModelTitle
                    width: pixelSize * 4.5
                    height: parent.height
                    anchors.left: parent.left
                    anchors.top: parent.top
                    pixelSize: 20
                    horizontalAlignment: Text.AlignLeft
                    color:mainColor
                    text:"引信型号: "
                }
                Item{
                    width: parent.width - text_FuzeModelTitle.width
                    height: parent.height
                    anchors.left:text_FuzeModelTitle.right
                    anchors.top: parent.top
                    TextInput{
                        id:text_Input_FuzeModel
                        anchors.fill: parent
                        color:"#ffffffff"
                        font.family:text_FuzeModelTitle.family
                        font.pixelSize:(18)
                        selectByMouse: true
                        selectionColor: "#ffcc8800"
                        // onTextChanged: {
                        //     if(text != "")
                        //     {

                        //     }
                        // }
                        onEditingFinished: {
                            ammoData.fuze_model =text
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
            }

            Rectangle{
                id:item_FuzeNum
                height: 20
                color: "transparent"
                anchors.left: item_FuzeModel.left
                anchors.top: item_FuzeModel.bottom
                anchors.topMargin: 20
                anchors.right: parent.right
                anchors.rightMargin: 5
                CText{
                    id:text_FuzeNumTitle
                    width: pixelSize * 4.5
                    height: parent.height
                    anchors.left: parent.left
                    anchors.top: parent.top
                    pixelSize: 20
                    horizontalAlignment: Text.AlignLeft
                    color:mainColor
                    text:"引信数量: "
                }
                Item{
                    width: parent.width - text_FuzeNumTitle.width
                    height: parent.height
                    anchors.left:text_FuzeNumTitle.right
                    anchors.top: parent.top
                    TextInput{
                        id:text_Input_FuzeNum
                        anchors.fill: parent
                        color:"#ffffffff"
                        font.family:text_FuzeNumTitle.family
                        font.pixelSize:(18)
                        selectByMouse: true
                        selectionColor: "#ffcc8800"
                        validator: DoubleValidator {
                                           bottom: -9999999
                                           top: 9999999
                                           notation: DoubleValidator.StandardNotation
                                           decimals: 5
                        }
                        // onTextChanged: {
                        //     if(text != "")
                        //     {

                        //     }
                        // }
                        onEditingFinished: {
                            ammoData.number_of_fuses =text
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
            }

            Rectangle {
                id: item_ActionTime
                height: 20
                color: "transparent"
                anchors.left: item_FuzeNum.left
                anchors.top: item_FuzeNum.bottom
                anchors.topMargin: 20
                anchors.right: parent.right
                anchors.rightMargin: 5
                CText{
                    id:text_ActionTimeTitle
                    width: pixelSize * 6
                    height: parent.height
                    anchors.left: parent.left
                    anchors.top: parent.top
                    pixelSize: 20
                    horizontalAlignment: Text.AlignLeft
                    color:mainColor
                    text:"作用时间(s): "
                }
                Item{
                    width: parent.width - text_ActionTimeTitle.width - 5
                    height: parent.height
                    anchors.left:text_ActionTimeTitle.right
                    anchors.top: parent.top
                    TextInput{
                        id:text_Input_ActionTime
                        anchors.fill: parent
                        color:"#ffffffff"
                        font.family:text_ActionTimeTitle.family
                        font.pixelSize:(18)
                        selectByMouse: true
                        selectionColor: "#ffcc8800"
                        validator: DoubleValidator {
                                           bottom: -9999999
                                           top: 9999999
                                           notation: DoubleValidator.StandardNotation
                                           decimals: 5
                        }
                        // onTextChanged: {
                        //     if(text != "")
                        //     {

                        //     }
                        // }
                        onEditingFinished: {
                            ammoData.action_time =text
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
            }

            Rectangle {
                id: item_DelayTime
                height: 20
                color: "transparent"
                anchors.left: item_ActionTime.left
                anchors.top: item_ActionTime.bottom
                anchors.topMargin: 20
                anchors.right: parent.right
                anchors.rightMargin: 5
                CText{
                    id:text_DelayTimeTitle
                    width: pixelSize * 6
                    height: parent.height
                    anchors.left: parent.left
                    anchors.top: parent.top
                    pixelSize: 20
                    horizontalAlignment: Text.AlignLeft
                    color:mainColor
                    text:"延解时间(s): "
                }
                Item{
                    width: parent.width - text_DelayTimeTitle.width - 5
                    height: parent.height
                    anchors.left:text_DelayTimeTitle.right
                    anchors.top: parent.top
                    TextInput{
                        id:text_Input_DelayTime
                        anchors.fill: parent
                        color:"#ffffffff"
                        font.family:text_ActionTimeTitle.family
                        font.pixelSize:(18)
                        selectByMouse: true
                        selectionColor: "#ffcc8800"
                        validator: DoubleValidator {
                                           bottom: -9999999
                                           top: 9999999
                                           notation: DoubleValidator.StandardNotation
                                           decimals: 5
                        }
                        // onTextChanged: {
                        //     if(text != "")
                        //     {

                        //     }
                        // }
                        onEditingFinished: {
                            ammoData.available_extension_time =text
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
            }

        }

        Label{
            id:uavType
            text: "对应无人机类型:"
            anchors.left: input_name.right
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
                            // if (!addAmmoAllDatView.uavArray.includes(m_PlanNumber)) {
                            //     addAmmoAllDatView.uavArray.push(m_PlanNumber) // 添加数字到数组
                            //     console.log("Number added: " + m_PlanNumber)
                            // } else {
                            //     console.log("Number already exists: " + m_PlanNumber)
                            // }
                            console.log("uavArray"+addAmmoAllDatView.uavArray)
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
    function loadAmmoData(){
        input_name.text = addAmmoAllDatView.ammoSelectData.ammoName

        text_Input_MissileRange.text = addAmmoAllDatView.ammoSelectData.ammoLenth
        text_Input_MissileDiameter.text = addAmmoAllDatView.ammoSelectData.ammoDiameter
        text_Input_MissileWeight.text = addAmmoAllDatView.ammoSelectData.ammoMass
        text_Input_FillWeight.text = addAmmoAllDatView.ammoSelectData.ammoChargeMass
        text_Input_Wingspan.text = addAmmoAllDatView.ammoSelectData.ammoWingspan
        text_Input_MissileSheCheng.text = addAmmoAllDatView.ammoSelectData.effective_range
        text_Input_DanErJuli.text = addAmmoAllDatView.ammoSelectData.ammoLugSpacing
        // text_Input_ShaShangFangshi.text = addAmmoAllDatView.ammoSelectData.ammoKillingWay
        text_Input_BombSpeedMin.text = addAmmoAllDatView.ammoSelectData.ammoMinReleaseSpeed
        text_Input_BombSpeedMax.text = addAmmoAllDatView.ammoSelectData.ammoMaxReleaseSpeed
        text_Input_BombHeightMin.text = addAmmoAllDatView.ammoSelectData.ammoMinReleaseHeight
        text_Input_BombHeightMax.text = addAmmoAllDatView.ammoSelectData.ammoMaxReleaseHeight
        text_Input_FuzeModel.text = addAmmoAllDatView.ammoSelectData.fuze_model
        text_Input_FuzeNum.text = addAmmoAllDatView.ammoSelectData.number_of_fuses
        text_Input_ActionTime.text = addAmmoAllDatView.ammoSelectData.action_time
        text_Input_DelayTime.text = addAmmoAllDatView.ammoSelectData.available_extension_time
        console.log("loadAmmoData()"+addAmmoAllDatView.ammoSelectData.ammoToUavModel)



    }

}

