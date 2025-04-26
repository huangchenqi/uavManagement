import QtQuick 2.12
import QtQuick.Controls 2.12
import "qrc:/AddAmmoModules/Component"

//航空半穿甲炸弹

Item {
    id:item_Missile
    width: 280
    height: 300
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
                id: rect_CraterRange
                height: 20
                color: "transparent"
                anchors.left: parent.left
                anchors.leftMargin: 5
                anchors.top: parent.top
                anchors.topMargin: 15
                width:( parent.width ) - 10

                CText{
                    id:text_CraterRangeTitle
                    width: pixelSize * 6
                    height: parent.height
                    anchors.left: parent.left
                    anchors.top: parent.top
                    pixelSize: 20
                    horizontalAlignment: Text.AlignLeft
                    color:mainColor
                    text:"弹坑直径(m): "
                }
                Item{
                    width: parent.width - text_CraterRangeTitle.width - 5
                    height: parent.height
                    anchors.left:text_CraterRangeTitle.right
                    anchors.top: parent.top
                    TextInput{
                        id:text_Input_CraterRange
                        anchors.fill: parent
                        color:"#ffffffff"
                        font.family:text_CraterRangeTitle.family
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
                            ammoData.ammoCraterDiameter =text
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
                id: rect_CraterDepth
                height: 20
                color: "transparent"
                anchors.left: rect_CraterRange.left
                anchors.top: rect_CraterRange.bottom
                anchors.topMargin: 15
                width:parent.width - 10

                CText{
                    id:text_CraterDepthTitle
                    width: pixelSize * 6
                    height: parent.height
                    anchors.left: parent.left
                    anchors.top: parent.top
                    pixelSize: 20
                    horizontalAlignment: Text.AlignLeft
                    color:mainColor
                    text:"弹坑深度(m): "
                }
                Item{
                    width: parent.width - text_CraterDepthTitle.width - 5
                    height: parent.height
                    anchors.left:text_CraterDepthTitle.right
                    anchors.top: parent.top
                    TextInput{
                        id:text_Input_CraterDepth
                        anchors.fill: parent
                        color:"#ffffffff"
                        font.family:text_CraterDepthTitle.family
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
                            ammoData.ammoCraterDepth =text
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
                id: rect_DamageArea
                height: 20
                color: "transparent"
                anchors.left: rect_CraterDepth.left
                anchors.top: rect_CraterDepth.bottom
                anchors.topMargin: 15
                width:( parent.width ) - 10

                CText{
                    id:text_DamageAreaTitle
                    width: pixelSize * 6.5
                    height: parent.height
                    anchors.left: parent.left
                    anchors.top: parent.top
                    pixelSize: 20
                    horizontalAlignment: Text.AlignLeft
                    color:mainColor
                    text:"破坏面积(m²): "
                }
                Item{
                    width: parent.width - text_DamageAreaTitle.width - 5
                    height: parent.height
                    anchors.left:text_DamageAreaTitle.right
                    anchors.top: parent.top
                    TextInput{
                        id:text_Input_DamageArea
                        anchors.fill: parent
                        color:"#ffffffff"
                        font.family:text_DamageAreaTitle.family
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
                            ammoData.ammoDamagedArea =text
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
