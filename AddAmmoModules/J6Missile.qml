import QtQuick 2.12
import QtQuick.Controls 2.12
import "qrc:/AddAmmoModules/Component"

//歼-6炸弹航空爆破炸弹

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
            id:rect_data
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
                id: rect_QinCheShenDu
                height: 20
                color: "transparent"
                anchors.left: parent.left
                anchors.leftMargin: 5
                anchors.top: parent.top
                anchors.topMargin: 15
                width:( parent.width ) - 10

                CText{
                    id:text_QinCheShenDuTitle
                    width: pixelSize * 6
                    height: parent.height
                    anchors.left: parent.left
                    anchors.top: parent.top
                    pixelSize: 20
                    horizontalAlignment: Text.AlignLeft
                    color:mainColor
                    text:"侵彻深度(m): "
                }
                Item{
                    width: parent.width - text_QinCheShenDuTitle.width - 5
                    height: parent.height
                    anchors.left:text_QinCheShenDuTitle.right
                    anchors.top: parent.top
                    TextInput{
                        id:text_Input_QinCheShenDu
                        anchors.fill: parent
                        color:"#ffffffff"
                        font.family:text_QinCheShenDuTitle.family
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
                            ammoData.ammoPenetrationDepth = textToFloat(text)
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
                id: rect_PaoTuLiang
                height: 20
                color: "transparent"
                anchors.left: rect_QinCheShenDu.left
                anchors.top: rect_QinCheShenDu.bottom
                anchors.topMargin: 15
                width:( parent.width ) - 10

                CText{
                    id:text_PaoTuLiangTitle
                    width: pixelSize * 5.5
                    height: parent.height
                    anchors.left: parent.left
                    anchors.top: parent.top
                    pixelSize: 20
                    horizontalAlignment: Text.AlignLeft
                    color:mainColor
                    text:"抛土量(m³): "
                }
                Item{
                    width: parent.width - text_PaoTuLiangTitle.width - 5
                    height: parent.height
                    anchors.left:text_PaoTuLiangTitle.right
                    anchors.top: parent.top
                    TextInput{
                        id:text_Input_PaoTuLiang
                        anchors.fill: parent
                        color:"#ffffffff"
                        font.family:text_PaoTuLiangTitle.family
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
                            ammoData.ammoQuantitySoilThrown = textToFloat(text)
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
       text_Input_QinCheShenDu.text  = addAmmoAllDatView.ammoSelectData.ammoPenetrationDepth
       text_Input_PaoTuLiang.text  = addAmmoAllDatView.ammoSelectData.ammoQuantitySoilThrown
    }
    function allComponentEnable(){
        text_Input_QinCheShenDu.enabled = false
        text_Input_PaoTuLiang.enabled = false
    }
}
