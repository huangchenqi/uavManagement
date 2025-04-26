import QtQuick 2.12
import QtQuick.Controls 2.12
import "qrc:/AddAmmoModules/Component"

//航空碳纤维炸弹

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
                    width: pixelSize * 8.5
                    height: parent.height
                    anchors.left: parent.left
                    anchors.top: parent.top
                    pixelSize: 20
                    horizontalAlignment: Text.AlignLeft
                    color:mainColor
                    text:"最大包容覆盖数量: "
                }
                Item{
                    width: parent.width - text_Title1.width - 5
                    height: parent.height
                    anchors.left:text_Title1.right
                    anchors.top: parent.top
                    TextInput{
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
                        // onTextChanged: {
                        //     if(text != "")
                        //     {

                        //     }
                        // }
                        onEditingFinished: {
                            ammoData.maximum_inclusive_coverage_quantity =text
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
                id: rect_data2
                height: 20
                color: "transparent"
                anchors.left: rect_data1.left
                anchors.top: rect_data1.bottom
                anchors.topMargin: 15
                width:( parent.width ) - 10

                CText{
                    id:text_Title2
                    width: pixelSize * 4.5
                    height: parent.height
                    anchors.left: parent.left
                    anchors.top: parent.top
                    pixelSize: 20
                    horizontalAlignment: Text.AlignLeft
                    color:mainColor
                    text:"散步数量: "
                }
                Item{
                    width: parent.width - text_Title2.width - 5
                    height: parent.height
                    anchors.left:text_Title2.right
                    anchors.top: parent.top
                    TextInput{
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
                        // onTextChanged: {
                        //     if(text != "")
                        //     {

                        //     }
                        // }
                        onEditingFinished: {
                            ammoData.number_of_spread =text
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
                id: rect_data3
                height: 20
                color: "transparent"
                anchors.left: rect_data2.left
                anchors.top: rect_data2.bottom
                anchors.topMargin: 15
                width:( parent.width ) - 10

                CText{
                    id:text_Title3
                    width: pixelSize * 10.5
                    height: parent.height
                    anchors.left: parent.left
                    anchors.top: parent.top
                    pixelSize: 20
                    horizontalAlignment: Text.AlignLeft
                    color:mainColor
                    text:"表面直流电阻率(Ω/m): "
                }
                Item{
                    width: parent.width - text_Title3.width - 5
                    height: parent.height
                    anchors.left:text_Title3.right
                    anchors.top: parent.top
                    TextInput{
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
                        // onTextChanged: {
                        //     if(text != "")
                        //     {

                        //     }
                        // }
                        onEditingFinished: {
                            ammoData.surface_dc_resistivity =text
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
                id: rect_data4
                height: 20
                color: "transparent"
                anchors.left: rect_data3.left
                anchors.top: rect_data3.bottom
                anchors.topMargin: 15
                width:( parent.width ) - 10

                CText{
                    id:text_Title4
                    width: pixelSize * 8
                    height: parent.height
                    anchors.left: parent.left
                    anchors.top: parent.top
                    pixelSize: 20
                    horizontalAlignment: Text.AlignLeft
                    color:mainColor
                    text:"引弧放电概率(%): "
                }
                Item{
                    width: parent.width - text_Title4.width - 5
                    height: parent.height
                    anchors.left:text_Title4.right
                    anchors.top: parent.top
                    TextInput{
                        anchors.fill: parent
                        color:"#ffffffff"
                        font.family:text_Title4.family
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
                            ammoData.probability_of_arc_discharge =text
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
