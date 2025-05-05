import QtQuick 2.12
import QtQuick.Controls 2.12
import "qrc:/AddAmmoModules/Component"

//航空燃料炸弹

Item {
    id:item_Missile
    width: 280
    height: 300
    property int loadDataWay: 0
    onLoadDataWayChanged: {
        if(item_Missile.loadDataWay === 1){
            loadAllAmmoData()
            allComponentEnable
        }else if(item_Missile.loadDataWay === 2){
            loadAllAmmoData()
        }else{
            console.log("航空爆破炸弹!")
        }
    }
    //——————对外参数接口——————
    Rectangle{
        id:rect_J_6Missile
        anchors.fill: parent
        color:"#50000000"
        border.width: 0

        CText{
            id:title
            text: "爆炸威力:"
            pixelSize: 25
            color: "#4EC4FF"
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.top: parent.top
            anchors.topMargin: 20
            horizontalAlignment: Text.AlignLeft
        }

        Rectangle{
            id:rect_Basedata
            anchors.left: title.left
            anchors.top: title.bottom
            anchors.topMargin: 15
            anchors.right: parent.right
            anchors.rightMargin: 10
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 15
            border.width: 1
            border.color: mainColor
            color: "transparent"

            Rectangle {
                id: rect_data1
                height: 20
                color: "transparent"
                anchors.left: parent.left
                anchors.leftMargin: 5
                anchors.top: parent.top
                anchors.topMargin: 15
                width:( parent.width ) - 10

                CText{
                    id:text_Title1
                    width: pixelSize * 8
                    height: parent.height
                    anchors.left: parent.left
                    anchors.top: parent.top
                    pixelSize: 20
                    horizontalAlignment: Text.AlignLeft
                    color:mainColor
                    text:"燃料分散半径(m): "
                }
                Item{
                    width: parent.width - text_Title1.width - 5
                    height: parent.height
                    anchors.left:text_Title1.right
                    anchors.top: parent.top
                    TextInput{
                        id:fuel_dispersion_radius_text
                        anchors.fill: parent
                        color:"#ffffffff"
                        font.family:text_Title1.family
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
                            ammoData.fuel_dispersion_radius = textToFloat(text)
                            console.log("Text content changed to: " + text)
                        }
                        // onEditingFinished: {

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
            Rectangle {
                id: rect_data2
                height: 20
                color: "transparent"
                anchors.left: rect_data1.left
                anchors.top: rect_data1.bottom
                anchors.topMargin: 15
                width:( parent.width ) - 10

                CText{
                    id:text_Title2
                    width: pixelSize * 8
                    height: parent.height
                    anchors.left: parent.left
                    anchors.top: parent.top
                    pixelSize: 20
                    horizontalAlignment: Text.AlignLeft
                    color:mainColor
                    text:"距离爆心距离(m): "
                }
                Item{
                    width: parent.width - text_Title2.width - 5
                    height: parent.height
                    anchors.left:text_Title2.right
                    anchors.top: parent.top
                    TextInput{
                        id:distance_from_center_explosion_text
                        anchors.fill: parent
                        color:"#ffffffff"
                        font.family:text_Title2.family
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
                            ammoData.distance_from_center_explosion = textToFloat(text)
                            console.log("Text content changed to: " + text)
                        }
                        // onEditingFinished: {

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
            Rectangle {
                id: rect_data3
                height: 20
                color: "transparent"
                anchors.left: rect_data2.left
                anchors.top: rect_data2.bottom
                anchors.topMargin: 15
                width:( parent.width ) - 10

                CText{
                    id:text_Title3
                    width: pixelSize * 9
                    height: parent.height
                    anchors.left: parent.left
                    anchors.top: parent.top
                    pixelSize: 20
                    horizontalAlignment: Text.AlignLeft
                    color:mainColor
                    text:"冲击波超压值(MPa): "
                }
                Item{
                    width: parent.width - text_Title3.width - 5
                    height: parent.height
                    anchors.left:text_Title3.right
                    anchors.top: parent.top
                    TextInput{
                        id:shock_wave_overpressure_value_text
                        anchors.fill: parent
                        color:"#ffffffff"
                        font.family:text_Title3.family
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
                            ammoData.shock_wave_overpressure_value = textToFloat(text)
                            console.log("Text content changed to: " + text)
                        }
                        // onEditingFinished: {

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
    function loadAllAmmoData(){
       fuel_dispersion_radius_text.text  = addAmmoAllDatView.ammoSelectData.fuel_dispersion_radius
       distance_from_center_explosion_text.text  = addAmmoAllDatView.ammoSelectData.distance_from_center_explosion
       shock_wave_overpressure_value_text.text = addAmmoAllDatView.ammoSelectData.shock_wave_overpressure_value
    }
    function allComponentEnable(){
        fuel_dispersion_radius_text.enabled = false
        distance_from_center_explosion_text.enabled = false
        shock_wave_overpressure_value_text.enabled = false
    }
}
