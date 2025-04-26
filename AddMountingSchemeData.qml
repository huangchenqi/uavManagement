import QtQuick 2.12
import QtQuick.Controls 2.12
import "qrc:/"
import "qrc:/AddAmmoModules/Component"

Item {
    id:addMountSchemeData

    width: 800
    height: 700
    signal backMountingScheme()
    //1号挂点位置
    property var sMountNum1Place: "位置1"
    //2号挂点位置
    property var sMountNum2Place: "位置1"
    //3号挂点位置
    property var sMountNum3Place: "位置1"
    //4号挂点位置
    property var sMountNum4Place: "位置1"
    //5号挂点位置
    property var sMountNum5Place: "位置1"
    //6号挂点位置
    property var sMountNum6Place: "位置1"
    //7号挂点位置
    property var sMountNum7Place: "位置1"
    //8号挂点位置
    property var sMountNum8Place: "位置1"
    //9号挂点位置
    property var sMountNum9Place: "位置1"
    //10号挂点位置
    property var sMountNum10Place: "位置1"

    //挂点是否选择
    property bool isMount1Select: false
    property bool isMount2Select: false
    property bool isMount3Select: false
    property bool isMount4Select: false
    property bool isMount5Select: false
    property bool isMount6Select: false
    property bool isMount7Select: false
    property bool isMount8Select: false
    property bool isMount9Select: false
    property bool isMount10Select: false

    property var sMountNum1AmmoType: "弹药1"
    property var sMountNum2AmmoType: "弹药1"
    property var sMountNum3AmmoType: "弹药1"
    property var sMountNum4AmmoType: "弹药1"
    property var sMountNum5AmmoType: "弹药1"
    property var sMountNum6AmmoType: "弹药1"
    property var sMountNum7AmmoType: "弹药1"
    property var sMountNum8AmmoType: "弹药1"
    property var sMountNum9AmmoType: "弹药1"
    property var sMountNum10AmmoType: "弹药1"

    property int currentMountPlaceSelect: 0
    function openMountPlace(id){
        switch(id)
        {
        case 1:
            view_List_MountPlace.anchors.horizontalCenter = btn_MountNum1Place.horizontalCenter
//            view_List_MountPlace.x = btn_MountNum1Place.x + btn_MountNum1Place.width
            view_List_MountPlace.y = btn_MountNum1Place.y + btn_MountNum1Place.height
            view_List_MountPlace.visible = !view_List_MountPlace.visible
            break;
        case 2:
            view_List_MountPlace.anchors.horizontalCenter = btn_MountNum2Place.horizontalCenter
            view_List_MountPlace.y = btn_MountNum2Place.y + btn_MountNum2Place.height
            view_List_MountPlace.visible = !view_List_MountPlace.visible
            break;
        case 3:
            view_List_MountPlace.anchors.horizontalCenter = btn_MountNum3Place.horizontalCenter
            view_List_MountPlace.y = btn_MountNum3Place.y + btn_MountNum3Place.height
            view_List_MountPlace.visible = !view_List_MountPlace.visible
            break;
        case 4:
            view_List_MountPlace.anchors.horizontalCenter = btn_MountNum4Place.horizontalCenter
            view_List_MountPlace.y = btn_MountNum4Place.y + btn_MountNum4Place.height
            view_List_MountPlace.visible = !view_List_MountPlace.visible
            break;
        case 5:
            view_List_MountPlace.anchors.horizontalCenter = btn_MountNum5Place.horizontalCenter
            view_List_MountPlace.y = btn_MountNum5Place.y + btn_MountNum5Place.height
            view_List_MountPlace.visible = !view_List_MountPlace.visible
            break;
        case 6:
            view_List_MountPlace.anchors.horizontalCenter = btn_MountNum6Place.horizontalCenter
            view_List_MountPlace.y = btn_MountNum6Place.y + btn_MountNum6Place.height
            view_List_MountPlace.visible = !view_List_MountPlace.visible
            break;
        case 7:
            view_List_MountPlace.anchors.horizontalCenter = btn_MountNum7Place.horizontalCenter
            view_List_MountPlace.y = btn_MountNum7Place.y + btn_MountNum7Place.height
            view_List_MountPlace.visible = !view_List_MountPlace.visible
            break;
        case 8:
            view_List_MountPlace.anchors.horizontalCenter = btn_MountNum8Place.horizontalCenter
            view_List_MountPlace.y = btn_MountNum8Place.y + btn_MountNum8Place.height
            view_List_MountPlace.visible = !view_List_MountPlace.visible
            break;
        case 9:
            view_List_MountPlace.anchors.horizontalCenter = btn_MountNum9Place.horizontalCenter
            view_List_MountPlace.y = btn_MountNum9Place.y + btn_MountNum9Place.height
            view_List_MountPlace.visible = !view_List_MountPlace.visible
            break;
        case 10:
            view_List_MountPlace.anchors.horizontalCenter = btn_MountNum10Place.horizontalCenter
            view_List_MountPlace.y = btn_MountNum10Place.y + btn_MountNum10Place.height
            view_List_MountPlace.visible = !view_List_MountPlace.visible
            break;
        }
        currentMountPlaceSelect =id
    }

    property int currentAmmoTypeSelect: 0
    function openAmmoType(id){
        switch(id)
        {
        case 1:
            view_List_MountAmmoType.anchors.horizontalCenter = btn_MountNum1AmmoType.horizontalCenter
            view_List_MountAmmoType.y = btn_MountNum1AmmoType.y + btn_MountNum1AmmoType.height
            view_List_MountAmmoType.visible = !view_List_MountAmmoType.visible
            break;
        case 2:
            view_List_MountAmmoType.anchors.horizontalCenter = btn_MountNum2AmmoType.horizontalCenter
            view_List_MountAmmoType.y = btn_MountNum2AmmoType.y + btn_MountNum2AmmoType.height
            view_List_MountAmmoType.visible = !view_List_MountAmmoType.visible
            break;
        case 3:
            view_List_MountAmmoType.anchors.horizontalCenter = btn_MountNum3AmmoType.horizontalCenter
            view_List_MountAmmoType.y = btn_MountNum3AmmoType.y + btn_MountNum3AmmoType.height
            view_List_MountAmmoType.visible = !view_List_MountAmmoType.visible
            break;
        case 4:
            view_List_MountAmmoType.anchors.horizontalCenter = btn_MountNum4AmmoType.horizontalCenter
            view_List_MountAmmoType.y = btn_MountNum4AmmoType.y + btn_MountNum4AmmoType.height
            view_List_MountAmmoType.visible = !view_List_MountAmmoType.visible
            break;
        case 5:
            view_List_MountAmmoType.anchors.horizontalCenter = btn_MountNum5AmmoType.horizontalCenter
            view_List_MountAmmoType.y = btn_MountNum5AmmoType.y + btn_MountNum5AmmoType.height
            view_List_MountAmmoType.visible = !view_List_MountAmmoType.visible
            break;
        case 6:
            view_List_MountAmmoType.anchors.horizontalCenter = btn_MountNum6AmmoType.horizontalCenter
            view_List_MountAmmoType.y = btn_MountNum6AmmoType.y + btn_MountNum6AmmoType.height
            view_List_MountAmmoType.visible = !view_List_MountAmmoType.visible
            break;
        case 7:
            view_List_MountAmmoType.anchors.horizontalCenter = btn_MountNum7AmmoType.horizontalCenter
            view_List_MountAmmoType.y = btn_MountNum7AmmoType.y + btn_MountNum7AmmoType.height
            view_List_MountAmmoType.visible = !view_List_MountAmmoType.visible
            break;
        case 8:
            view_List_MountAmmoType.anchors.horizontalCenter = btn_MountNum8AmmoType.horizontalCenter
            view_List_MountAmmoType.y = btn_MountNum8AmmoType.y + btn_MountNum8AmmoType.height
            view_List_MountAmmoType.visible = !view_List_MountAmmoType.visible
            break;
        case 9:
            view_List_MountAmmoType.anchors.horizontalCenter = btn_MountNum9AmmoType.horizontalCenter
            view_List_MountAmmoType.y = btn_MountNum9AmmoType.y + btn_MountNum9AmmoType.height
            view_List_MountAmmoType.visible = !view_List_MountAmmoType.visible
            break;
        case 10:
            view_List_MountAmmoType.anchors.horizontalCenter = btn_MountNum10AmmoType.horizontalCenter
            view_List_MountAmmoType.y = btn_MountNum10AmmoType.y + btn_MountNum10AmmoType.height
            view_List_MountAmmoType.visible = !view_List_MountAmmoType.visible
            break;
        }
        currentAmmoTypeSelect =id
    }


    Rectangle{
        id:rect_Back
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.bottom: btn_Cancel.top
        anchors.bottomMargin: 10
        color: "#50000000"

        CText {
            id: top_title
            text: qsTr("挂载方案设置")
            pixelSize: 25
            width: pixelSize * 6
            color: "#4EC4FF"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 20
            horizontalAlignment: Text.AlignLeft
        }

        CText{
            id:text_PlanName
            text: "挂载方案名称:"
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.top: top_title.bottom
            anchors.topMargin: 30
            pixelSize: 20
            width: pixelSize * 6.5
            horizontalAlignment: Text.AlignLeft
            color: mainColor
        }

        Item{
            id:item_PlanNameInput
            width: 350 - text_PlanName.width
            height: 20
            anchors.left:text_PlanName.right
            anchors.top: text_PlanName.top
            anchors.topMargin: -5
            TextInput{
                id:planNameText
                anchors.fill: parent
                color:"#ffffffff"
                font.family:text_PlanName.family
                font.pixelSize:(18)
                selectByMouse: true
                selectionColor: "#ffcc8800"
                onTextChanged: {
                    if(text != "")
                    {

                    }
                }
                validator: RegExpValidator {
                    regExp: /[^\s]*/  // 不允许任何空格
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

        CText{
            id:text_UavName
            text: "无人机名称:"
            anchors.left: item_PlanNameInput.right
            anchors.leftMargin: 10
            anchors.verticalCenter: text_PlanName.verticalCenter
            pixelSize: 20
            width: pixelSize * 5.5
            horizontalAlignment: Text.AlignLeft
            color: mainColor
        }

        Item{
            id:item_UavNameInput
            width: 350 - text_UavName.width
            height: 20
            anchors.left:text_UavName.right
            anchors.top: text_UavName.top
            anchors.topMargin: -5
            TextInput{
                id:uavNameText
                anchors.fill: parent
                color:"#ffffffff"
                font.family:text_UavName.family
                font.pixelSize:(18)
                selectByMouse: true
                selectionColor: "#ffcc8800"
                onTextChanged: {
                    if(text != "")
                    {

                    }
                }
                validator: RegExpValidator {
                    regExp: /[^\s]*/  // 不允许任何空格
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

        CTextInput{
            id:text_MaxTakeOffWeight
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.top: text_PlanName.bottom
            anchors.topMargin: 30
            title: "无人机最大起飞重量(kg):"
            pixelSize: 18
            titleWidth: pixelSize * 11.5
            width: 350
            height: 30
        }

        CTextInput{
            id:text_UavEmptyWeight
            anchors.left: text_MaxTakeOffWeight.right
            anchors.leftMargin: 10
            anchors.top: text_PlanName.bottom
            anchors.topMargin: 30
            title: "无人机空机重量(kg):"
            pixelSize: 18
            titleWidth: pixelSize * 9.5
            width: 350
            height: 30
        }

        CTextInput{
            id:text_UavMaxFuelWeight
            anchors.left: text_MaxTakeOffWeight.left
            anchors.top: text_MaxTakeOffWeight.bottom
            anchors.topMargin: 20
            title: "无人机最大载油量(L):"
            pixelSize: 18
            titleWidth: pixelSize * 10
            width: 350
            height: 30
        }

        CTextInput{
            id:text_UavMaxExternalWeight
            anchors.left: text_UavMaxFuelWeight.right
            anchors.leftMargin: 10
            anchors.top: text_UavMaxFuelWeight.top
            title: "无人机最大外挂重量(kg):"
            pixelSize: 18
            titleWidth: pixelSize * 11.5
            width: 350
            height: 30
        }

        CTextInput{
            id:text_RunningDistance
            anchors.left: text_UavMaxFuelWeight.left
            anchors.top: text_UavMaxFuelWeight.bottom
            anchors.topMargin: 20
            title: "滑跑距离:"
            pixelSize: 18
            titleWidth: pixelSize * 4.5
            width: 170
            height: 30
        }

        CTextInput{
            id:text_FlightTime
            anchors.left: text_RunningDistance.right
            anchors.leftMargin: 10
            anchors.top: text_RunningDistance.top
            title: "航时(h):"
            pixelSize: 18
            titleWidth: pixelSize * 4
            width: 170
            height: 30
        }

        CTextInput{
            id:text_FightRadius
            anchors.left: text_FlightTime.right
            anchors.leftMargin: 10
            anchors.top: text_FlightTime.top
            title: "作战半径(km):"
            pixelSize: 18
            titleWidth: pixelSize * 6.5
            width: 170
            height: 30
        }

        Rectangle{
            id:rect_mountList
            anchors.left: text_RunningDistance.left
            anchors.top: text_RunningDistance.bottom
            anchors.topMargin: 20
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 10
            width: parent.width - 20
            color: "transparent"

            CText{
                id:text_Mount
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.topMargin: 25
                pixelSize: 20
                width: pixelSize * 3.5
                horizontalAlignment: Text.AlignLeft
                text: "挂载点："
            }

            CButton{
                id:btn_Mount1
                anchors.left: text_Mount.right
                anchors.leftMargin: 30
                anchors.verticalCenter: text_Mount.verticalCenter
                width: 40
                height: 40
                text: "1"
                radius: width / 2
                onClicked: {
                    isSelect = !isSelect
                    isMount1Select = isSelect
                    //
                }
            }

            CButton{
                id:btn_Mount2
                anchors.left: btn_Mount1.right
                anchors.leftMargin: 30
                anchors.verticalCenter: text_Mount.verticalCenter
                width: 40
                height: 40
                text: "2"
                radius: width / 2
                onClicked: {
                    isSelect = !isSelect
                    isMount2Select = isSelect
                    //
                }
            }

            CButton{
                id:btn_Mount3
                anchors.left: btn_Mount2.right
                anchors.leftMargin: 30
                anchors.verticalCenter: text_Mount.verticalCenter
                width: 40
                height: 40
                text: "3"
                radius: width / 2
                onClicked: {
                    isSelect = !isSelect
                    isMount3Select = isSelect
                    //
                }
            }

            CButton{
                id:btn_Mount4
                anchors.left: btn_Mount3.right
                anchors.leftMargin: 30
                anchors.verticalCenter: text_Mount.verticalCenter
                width: 40
                height: 40
                text: "4"
                radius: width / 2
                onClicked: {
                    isSelect = !isSelect
                    isMount4Select = isSelect
                    //
                }
            }

            CButton{
                id:btn_Mount5
                anchors.left: btn_Mount4.right
                anchors.leftMargin: 30
                anchors.verticalCenter: text_Mount.verticalCenter
                width: 40
                height: 40
                text: "5"
                radius: width / 2
                onClicked: {
                    isSelect = !isSelect
                    isMount5Select = isSelect
                    //
                }
            }

            CButton{
                id:btn_Mount6
                anchors.left: btn_Mount5.right
                anchors.leftMargin: 30
                anchors.verticalCenter: text_Mount.verticalCenter
                width: 40
                height: 40
                text: "6"
                radius: width / 2
                onClicked: {
                    isSelect = !isSelect
                    isMount6Select = isSelect
                    //
                }
            }

            CButton{
                id:btn_Mount7
                anchors.left: btn_Mount6.right
                anchors.leftMargin: 30
                anchors.verticalCenter: text_Mount.verticalCenter
                width: 40
                height: 40
                text: "7"
                radius: width / 2
                onClicked: {
                    isSelect = !isSelect
                    isMount7Select = isSelect
                    //
                }
            }

            CButton{
                id:btn_Mount8
                anchors.left: btn_Mount7.right
                anchors.leftMargin: 30
                anchors.verticalCenter: text_Mount.verticalCenter
                width: 40
                height: 40
                text: "8"
                radius: width / 2
                onClicked: {
                    isSelect = !isSelect
                    isMount8Select = isSelect
                    //
                }
            }

            CButton{
                id:btn_Mount9
                anchors.left: btn_Mount8.right
                anchors.leftMargin: 30
                anchors.verticalCenter: text_Mount.verticalCenter
                width: 40
                height: 40
                text: "9"
                radius: width / 2
                onClicked: {
                    isSelect = !isSelect
                    isMount9Select = isSelect
                    //
                }
            }

            CButton{
                id:btn_Mount10
                anchors.left: btn_Mount9.right
                anchors.leftMargin: 30
                anchors.verticalCenter: text_Mount.verticalCenter
                width: 40
                height: 40
                text: "10"
                radius: width / 2
                onClicked: {
                    isSelect = !isSelect
                    isMount10Select = isSelect
                    //
                }
            }


            CText{
                id:text_MountPlace
                anchors.left: parent.left
                anchors.top: text_Mount.bottom
                anchors.topMargin: 70
                pixelSize: 20
                width: pixelSize * 4.5
                horizontalAlignment: Text.AlignHCenter
//                color: "#4EC4FF"
                text: "挂点位置:"
            }


            Text{
                id:btn_MountNum1Place
                anchors.top: text_MountPlace.top
                anchors.horizontalCenter: btn_Mount1.horizontalCenter
                width: font.pixelSize
                color: mainColor
                font.pixelSize: 18
                font.family: "黑体"
                wrapMode: Text.WrapAnywhere
                horizontalAlignment: Text.AlignHCenter
                text:sMountNum1Place
                visible: isMount1Select
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        openMountPlace(1)
                    }
                }
            }

            Text{
                id:btn_MountNum2Place
                anchors.top: text_MountPlace.top
                anchors.horizontalCenter: btn_Mount2.horizontalCenter
                width: font.pixelSize
                color: mainColor
                font.pixelSize: 18
                font.family: "黑体"
                wrapMode: Text.WrapAnywhere
                horizontalAlignment: Text.AlignHCenter
                text:sMountNum2Place
                visible: isMount2Select
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        openMountPlace(2)
                    }
                }
            }

            Text{
                id:btn_MountNum3Place
                anchors.top: text_MountPlace.top
                anchors.horizontalCenter: btn_Mount3.horizontalCenter
                width: font.pixelSize
                color: mainColor
                font.pixelSize: 18
                font.family: "黑体"
                wrapMode: Text.WrapAnywhere
                horizontalAlignment: Text.AlignHCenter
                text:sMountNum3Place
                visible: isMount3Select
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        openMountPlace(3)
                    }
                }
            }

            Text{
                id:btn_MountNum4Place
                anchors.top: text_MountPlace.top
                anchors.horizontalCenter: btn_Mount4.horizontalCenter
                width: font.pixelSize
                color: mainColor
                font.pixelSize: 18
                font.family: "黑体"
                wrapMode: Text.WrapAnywhere
                horizontalAlignment: Text.AlignHCenter
                text:sMountNum4Place
                visible: isMount4Select
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        openMountPlace(4)
                    }
                }
            }

            Text{
                id:btn_MountNum5Place
                anchors.top: text_MountPlace.top
                anchors.horizontalCenter: btn_Mount5.horizontalCenter
                width: font.pixelSize
                color: mainColor
                font.pixelSize: 18
                font.family: "黑体"
                wrapMode: Text.WrapAnywhere
                horizontalAlignment: Text.AlignHCenter
                text:sMountNum5Place
                visible: isMount5Select
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        openMountPlace(5)
                    }
                }
            }

            Text{
                id:btn_MountNum6Place
                anchors.top: text_MountPlace.top
                anchors.horizontalCenter: btn_Mount6.horizontalCenter
                width: font.pixelSize
                color: mainColor
                font.pixelSize: 18
                font.family: "黑体"
                wrapMode: Text.WrapAnywhere
                horizontalAlignment: Text.AlignHCenter
                text:sMountNum6Place
                visible: isMount6Select
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        openMountPlace(6)
                    }
                }
            }

            Text{
                id:btn_MountNum7Place
                anchors.top: text_MountPlace.top
                anchors.horizontalCenter: btn_Mount7.horizontalCenter
                width: font.pixelSize
                color: mainColor
                font.pixelSize: 18
                font.family: "黑体"
                wrapMode: Text.WrapAnywhere
                horizontalAlignment: Text.AlignHCenter
                text:sMountNum7Place
                visible: isMount7Select
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        openMountPlace(7)
                    }
                }
            }

            Text{
                id:btn_MountNum8Place
                anchors.top: text_MountPlace.top
                anchors.horizontalCenter: btn_Mount8.horizontalCenter
                width: font.pixelSize
                color: mainColor
                font.pixelSize: 18
                font.family: "黑体"
                wrapMode: Text.WrapAnywhere
                horizontalAlignment: Text.AlignHCenter
                text:sMountNum8Place
                visible: isMount8Select
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        openMountPlace(8)
                    }
                }
            }

            Text{
                id:btn_MountNum9Place
                anchors.top: text_MountPlace.top
                anchors.horizontalCenter: btn_Mount9.horizontalCenter
                width: font.pixelSize
                color: mainColor
                font.pixelSize: 18
                font.family: "黑体"
                wrapMode: Text.WrapAnywhere
                horizontalAlignment: Text.AlignHCenter
                text:sMountNum9Place
                visible: isMount9Select
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        openMountPlace(9)
                    }
                }
            }


            Text{
                id:btn_MountNum10Place
                anchors.top: text_MountPlace.top
                anchors.horizontalCenter: btn_Mount10.horizontalCenter
                width: font.pixelSize
                color: mainColor
                font.pixelSize: 18
                font.family: "黑体"
                wrapMode: Text.WrapAnywhere
                horizontalAlignment: Text.AlignHCenter
                text:sMountNum10Place
                visible: isMount10Select
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        openMountPlace(10)
                    }
                }
            }

            CText{
                id:text_MountLoadingAmmo
                anchors.left: parent.left
                anchors.top: text_MountPlace.bottom
                anchors.topMargin: 100
                pixelSize: 20
                width: pixelSize * 4.5
                horizontalAlignment: Text.AlignHCenter
//                color: "#4EC4FF"
                text: "挂载弹药:"
            }

            Text{
                id:btn_MountNum1AmmoType
                anchors.top: text_MountLoadingAmmo.top
                anchors.horizontalCenter: btn_Mount1.horizontalCenter
                width: font.pixelSize
                color: mainColor
                font.pixelSize: 18
                font.family: "黑体"
                wrapMode: Text.WrapAnywhere
                horizontalAlignment: Text.AlignHCenter
                text:sMountNum1AmmoType
                visible: isMount1Select
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        openAmmoType(1)
                    }
                }
            }

            Text{
                id:btn_MountNum2AmmoType
                anchors.top: text_MountLoadingAmmo.top
                anchors.horizontalCenter: btn_Mount2.horizontalCenter
                width: font.pixelSize
                color: mainColor
                font.pixelSize: 18
                font.family: "黑体"
                wrapMode: Text.WrapAnywhere
                horizontalAlignment: Text.AlignHCenter
                text:sMountNum2AmmoType
                visible: isMount2Select
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        openAmmoType(2)
                    }
                }
            }

            Text{
                id:btn_MountNum3AmmoType
                anchors.top: text_MountLoadingAmmo.top
                anchors.horizontalCenter: btn_Mount3.horizontalCenter
                width: font.pixelSize
                color: mainColor
                font.pixelSize: 18
                font.family: "黑体"
                wrapMode: Text.WrapAnywhere
                horizontalAlignment: Text.AlignHCenter
                text:sMountNum3AmmoType
                visible: isMount3Select
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        openAmmoType(3)
                    }
                }
            }

            Text{
                id:btn_MountNum4AmmoType
                anchors.top: text_MountLoadingAmmo.top
                anchors.horizontalCenter: btn_Mount4.horizontalCenter
                width: font.pixelSize
                color: mainColor
                font.pixelSize: 18
                font.family: "黑体"
                wrapMode: Text.WrapAnywhere
                horizontalAlignment: Text.AlignHCenter
                text:sMountNum4AmmoType
                visible: isMount4Select
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        openAmmoType(4)
                    }
                }
            }

            Text{
                id:btn_MountNum5AmmoType
                anchors.top: text_MountLoadingAmmo.top
                anchors.horizontalCenter: btn_Mount5.horizontalCenter
                width: font.pixelSize
                color: mainColor
                font.pixelSize: 18
                font.family: "黑体"
                wrapMode: Text.WrapAnywhere
                horizontalAlignment: Text.AlignHCenter
                text:sMountNum5AmmoType
                visible: isMount5Select
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        openAmmoType(5)
                    }
                }
            }

            Text{
                id:btn_MountNum6AmmoType
                anchors.top: text_MountLoadingAmmo.top
                anchors.horizontalCenter: btn_Mount6.horizontalCenter
                width: font.pixelSize
                color: mainColor
                font.pixelSize: 18
                font.family: "黑体"
                wrapMode: Text.WrapAnywhere
                horizontalAlignment: Text.AlignHCenter
                text:sMountNum6AmmoType
                visible: isMount6Select
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        openAmmoType(6)
                    }
                }
            }

            Text{
                id:btn_MountNum7AmmoType
                anchors.top: text_MountLoadingAmmo.top
                anchors.horizontalCenter: btn_Mount7.horizontalCenter
                width: font.pixelSize
                color: mainColor
                font.pixelSize: 18
                font.family: "黑体"
                wrapMode: Text.WrapAnywhere
                horizontalAlignment: Text.AlignHCenter
                text:sMountNum7AmmoType
                visible: isMount7Select
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        openAmmoType(7)
                    }
                }
            }

            Text{
                id:btn_MountNum8AmmoType
                anchors.top: text_MountLoadingAmmo.top
                anchors.horizontalCenter: btn_Mount8.horizontalCenter
                width: font.pixelSize
                color: mainColor
                font.pixelSize: 18
                font.family: "黑体"
                wrapMode: Text.WrapAnywhere
                horizontalAlignment: Text.AlignHCenter
                text:sMountNum8AmmoType
                visible: isMount8Select
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        openAmmoType(8)
                    }
                }
            }

            Text{
                id:btn_MountNum9AmmoType
                anchors.top: text_MountLoadingAmmo.top
                anchors.horizontalCenter: btn_Mount9.horizontalCenter
                width: font.pixelSize
                color: mainColor
                font.pixelSize: 18
                font.family: "黑体"
                wrapMode: Text.WrapAnywhere
                horizontalAlignment: Text.AlignHCenter
                text:sMountNum9AmmoType
                visible: isMount9Select
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        openAmmoType(9)
                    }
                }
            }

            Text{
                id:btn_MountNum10AmmoType
                anchors.top: text_MountLoadingAmmo.top
                anchors.horizontalCenter: btn_Mount10.horizontalCenter
                width: font.pixelSize
                color: mainColor
                font.pixelSize: 18
                font.family: "黑体"
                wrapMode: Text.WrapAnywhere
                horizontalAlignment: Text.AlignHCenter
                text:sMountNum10AmmoType
                visible: isMount10Select
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        openAmmoType(10)
                    }
                }
            }

            ListView{
                //挂点位置 单选
                id:view_List_MountPlace
                width: 140
                height: 36 * 5
                x:btn_MountNum1Place.x + btn_MountNum1Place.width + 2
                visible: false
                clip: true
                model:ListModel{
                    id:listmodel_MountPlace
                }
                delegate:Component{
                    Item{
                        id:item_Delegate
                        width: view_List_MountPlace.width
                        height: 36
                        CButton{
                            id:comp_TypeBtn
                            anchors.fill: parent
                            text:m_TypeName
                            color:"#ffddaa00"
                            borderColor: "#ffddaa00"
                            pixelSize: 17
                            onClicked: {
                                view_List_MountPlace.visible = false
                                m_SelectState = !m_SelectState
                                switch(currentMountPlaceSelect)
                                {
                                case 1: sMountNum1Place = text
                                    break
                                case 2: sMountNum2Place = text
                                    break
                                case 3: sMountNum3Place = text
                                    break
                                case 4: sMountNum4Place = text
                                    break
                                case 5: sMountNum5Place = text
                                    break
                                case 6: sMountNum6Place = text
                                    break
                                case 7: sMountNum7Place = text
                                    break
                                case 8: sMountNum8Place = text
                                    break
                                case 9: sMountNum9Place = text
                                    break
                                case 10: sMountNum10Place = text
                                    break
                                }
                            }
                        }
                    }
                }

                Component.onCompleted: {
                    listmodel_MountPlace.append({m_PlanNumber:0,m_SelectState:false,m_TypeName:"位置1"})
                    listmodel_MountPlace.append({m_PlanNumber:1,m_SelectState:false,m_TypeName:"位置2"})
                    listmodel_MountPlace.append({m_PlanNumber:2,m_SelectState:false,m_TypeName:"位置3"})
                }
            }

            ListView{
                //弹药设置 单选
                id:view_List_MountAmmoType
                width: 140
                height: 36 * 5
                x:btn_MountNum1AmmoType.x + btn_MountNum1AmmoType.width + 2
                visible: false
                clip: true
                model:ListModel{
                    id:listmodel_MountAmmoType
                }
                delegate:Component{
                    Item{
                        id:item_Delegate
                        width: view_List_MountAmmoType.width
                        height: 36
                        CButton{
                            id:comp_TypeBtn
                            anchors.fill: parent
                            text:m_TypeName
                            color:"#ffddaa00"
                            borderColor: "#ffddaa00"
                            pixelSize: 17
                            onClicked: {
                                view_List_MountAmmoType.visible = false
                                m_SelectState = !m_SelectState

                                switch(currentAmmoTypeSelect)
                                {
                                case 1: sMountNum1AmmoType = text
                                    break
                                case 2: sMountNum2AmmoType = text
                                    break
                                case 3: sMountNum3AmmoType = text
                                    break
                                case 4: sMountNum4AmmoType = text
                                    break
                                case 5: sMountNum5AmmoType = text
                                    break
                                case 6: sMountNum6AmmoType = text
                                    break
                                case 7: sMountNum7AmmoType = text
                                    break
                                case 8: sMountNum8AmmoType = text
                                    break
                                case 9: sMountNum9AmmoType = text
                                    break
                                case 10: sMountNum10AmmoType = text
                                    break
                                }
                            }
                        }
                    }
                }

                Component.onCompleted: {
                    listmodel_MountAmmoType.append({m_PlanNumber:0,m_SelectState:false,m_TypeName:"弹药1"})
                    listmodel_MountAmmoType.append({m_PlanNumber:1,m_SelectState:false,m_TypeName:"弹药2"})
                    listmodel_MountAmmoType.append({m_PlanNumber:2,m_SelectState:false,m_TypeName:"弹药3"})
                }
            }
        }

    }


    CButton{
        id:btn_Cancel
        anchors.right: parent.right
        anchors.rightMargin: 10
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        width: 90
        height: 36
        text: "取消"
        onClicked: {
           backMountingScheme()
           addMountSchemeData.visible = false
        }
    }
    CButton{
        id:btn_Confir
        anchors.right: btn_Cancel.left
        anchors.rightMargin: 10
        anchors.top: btn_Cancel.top
        width: 90
        height: 36
        text: "确定"
        onClicked: {
            backMountingScheme()
            addMountSchemeData.visible = false
        }
    }
}
