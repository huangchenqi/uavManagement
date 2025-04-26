import QtQuick 2.12
import QtQuick.Window 2.12
//import QtCharts 2.3
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.5
import "qrc:/"
import "qrc:/AddAmmoModules/Component"
import "qrc:/AddAmmoModules/"
Item {
    id:newAmmoData
    visible: true
    width: 1920
    height: 1080
    z: 100
    property string mainColor:"#fff0cc55"
    signal backAvAmmoRecord()
    readonly property string mainBackgroundSource: "file:Resources/Background/bg_MainBackground.png"
    //弹药类型
    property int missileType: -1

    Item {
        anchors.fill: parent
        Image {
            id: backGround
            anchors.fill: parent
            sourceSize: Qt.size(width,height)
            source: mainBackgroundSource
        }

    }

    //新弹的通用基本参数
    NewMissileBaseData{
        id:custom_NewMissileBaseData
        anchors.left: parent.left
        anchors.leftMargin: 5
        anchors.top: parent.top
        anchors.topMargin: 10
    }

    //用途描述
    Rectangle{
        id:rect_Describe
        anchors.top: custom_WorkData.bottom
        anchors.topMargin: 10
        anchors.left: custom_WorkData.left
        anchors.right: addAmmo.right
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        color:"#50000000"
        radius: 10

        CText {
            id: text_DescribeTitle
            text: qsTr("用途描述:")
            pixelSize: 25
            color: "#4EC4FF"
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.top: parent.top
            anchors.topMargin: 20
            horizontalAlignment: Text.AlignLeft
        }
        TextArea {
            id: usageDescriptionText
            anchors.top: text_DescribeTitle.bottom
            anchors.topMargin: 15
            anchors.left: text_DescribeTitle.left
            anchors.right: parent.right
            anchors.rightMargin: 5
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 5
            // 边框样式
                background: Rectangle {
                    border.color: "#cccccc"
                    radius: 10
                }

            // 多行显示关键配置
            wrapMode: Text.Wrap                   // 自动换行
            placeholderText: "请输入多行描述..."    // 占位提示
            textFormat: Text.PlainText            // 文本格式
            selectByMouse: true                   // 允许鼠标选择
            inputMethodHints: Qt.ImhMultiLine      // 启用多行输入法支持
            font.family: "黑体"
            font.pixelSize: 20
        }
    }

    NewMissileWorkData{
        id:custom_WorkData
        anchors.left: parent.left
        anchors.leftMargin: 5
        anchors.top: custom_NewMissileBaseData.bottom
        anchors.topMargin: 10
    }

    Rectangle {
        id: rect_ImageShow
        visible: true
        width:500
        height: 600
        anchors.left: custom_NewMissileBaseData.right
        anchors.leftMargin: 10
        anchors.top: custom_NewMissileBaseData.top
        color: "#ECF2FE"
        border.color: "#BDBDBD"

        Image {
            id: ammunitionImg
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            width: parent.width - btn_Cancel.width
        }
        CText {
            anchors.centerIn: parent
            text: "图片展示区域"
            color: "#9E9E9E"
        }
        CButton{
            id:btn_Cancel
            anchors.top: parent.bottom
            anchors.topMargin: 5
            anchors.right: parent.right
            anchors.rightMargin: 5
            height: pixelSize * 2
            width: pixelSize * 4
            text: "取消"
            onClicked: {
                backAvAmmoRecord()
                newAmmoData.visible = false
            }
        }

        CButton{
            id:btn_Save
            anchors.top: parent.bottom
            anchors.topMargin: 5
            anchors.right: btn_Cancel.left
            anchors.rightMargin: 10
            height: pixelSize * 2
            width: pixelSize * 4
            text: "保存"
        }

    }

    Rectangle{
        id:rect_BtnControl
        color:"#50000000"
        radius: 10
        anchors.left: custom_LaunchData.left
        anchors.top: custom_LaunchData.bottom
        anchors.topMargin: 10
        anchors.right: custom_LaunchData.right
        height: 50

        CButton{
            id:btn_Fuse
            anchors.left: parent.left
            anchors.leftMargin: 5
            anchors.top: parent.top
            anchors.topMargin: 5
            text: "引信"
            pixelSize: 20
            width: (parent.width / 4) - 10
            height: 36
            onClicked: {
                addAmmoComponentFusePopup.open()//custom_Fuse.visible = !custom_Fuse.visible
            }
        }

        CButton{
            id:btn_LaunchCondition
            anchors.left: btn_Fuse.right
            anchors.leftMargin: 10
            anchors.top: parent.top
            anchors.topMargin: 5
            text: "发射条件"
            pixelSize: 20
            width: (parent.width / 4) - 10
            height: 36
            onClicked: {
                addAmmoComponentLaunchconditionsPopup.open()//custom_LaunchCondition.visible = !custom_LaunchCondition.visible
            }
        }

        CButton{
            id:btn_Seeker
            anchors.left: btn_LaunchCondition.right
            anchors.leftMargin: 5
            anchors.top: parent.top
            anchors.topMargin: 5
            text: "导引头"
            pixelSize: 20
            width: (parent.width / 4) - 10
            height: 36
            onClicked: {
                addAmmoComponentSeekerPopup.open()//custom_Seeker.visible = !custom_Seeker.visible
            }
        }

        CButton{
            id:btn_Warhead
            anchors.left: btn_Seeker.right
            anchors.leftMargin: 5
            anchors.top: parent.top
            anchors.topMargin: 5
            text: "战斗部"
            pixelSize: 20
            width: (parent.width / 4) - 10
            height: 36
            onClicked: {
                addAmmoComponentWarheadPopup.open()//custom_Warhead.visible = !custom_Warhead.visible
            }
        }
    }

    NewMissileLaunchData{
        id:custom_LaunchData
        anchors.left: custom_WorkData.right
        anchors.leftMargin: 5
        anchors.top: custom_WorkData.top
        anchors.right: custom_NewMissileBaseData.right
    }

    Popup {
        id: addAmmoComponentFusePopup
        width: 530
        height: 460
        modal: true
        focus: true
        anchors.centerIn: Overlay.overlay // 居中显示
        closePolicy: Popup.NoAutoClose    // 完全禁用自动关闭

        // 直接引用 admin.qml
          AddAmmoComponentFuse{  // 假设 admin.qml 的根元素是 Admin 类型
                id: addAmmoComponentFusePanel
                anchors.centerIn: parent
                onClose: addAmmoComponentFusePopup.close() // 连接关闭信号
            }

    }
    Popup {
        id: addAmmoComponentLaunchconditionsPopup
        width: 520
        height: 360
        modal: true
        focus: true
        anchors.centerIn: Overlay.overlay // 居中显示
        closePolicy: Popup.NoAutoClose    // 完全禁用自动关闭

        // 直接引用 admin.qml
          AddAmmoComponentLaunchconditions{  // 假设 admin.qml 的根元素是 Admin 类型
                id: addAmmoComponentLaunchconditionsPanel
                anchors.centerIn: parent
                onClose: addAmmoComponentLaunchconditionsPopup.close() // 连接关闭信号
            }

    }
    Popup {
        id: addAmmoComponentSeekerPopup
        width: 540
        height: 360
        modal: true
        focus: true
        anchors.centerIn: Overlay.overlay // 居中显示
        closePolicy: Popup.NoAutoClose    // 完全禁用自动关闭

        // 直接引用 admin.qml
          AddAmmoComponentSeeker{  // 假设 admin.qml 的根元素是 Admin 类型
                id: addAmmoComponentSeekerPanel
                anchors.centerIn: parent
                onClose: addAmmoComponentSeekerPopup.close() // 连接关闭信号
            }

    }
    Popup {
        id: addAmmoComponentWarheadPopup
        width: 600
        height: 500
        modal: true
        focus: true
        anchors.centerIn: Overlay.overlay // 居中显示
        closePolicy: Popup.NoAutoClose    // 完全禁用自动关闭

        // 直接引用 admin.qml
          AddAmmoComponentWarhead{  // 假设 admin.qml 的根元素是 Admin 类型
                id: addAmmoComponentWarheadPanel
                anchors.centerIn: parent
                onClose: addAmmoComponentWarheadPopup.close() // 连接关闭信号
            }

    }
    //引信设置窗口
//    AddAmmoComponentFuse{
//        id:custom_Fuse
//        anchors.centerIn: parent
//        visible: false
//    }
    //发射条件设置窗口
//    AddAmmoComponentLaunchconditions{
//        id:custom_LaunchCondition
//        anchors.centerIn: parent
//        visible: false
//    }
    //导引头设置窗口
//    AddAmmoComponentSeeker{
//        id:custom_Seeker
//        anchors.centerIn: parent
//        visible: false
//    }
    //战斗部设置窗口
//    AddAmmoComponentWarhead{
//        id:custom_Warhead
//        anchors.centerIn: parent
//        visible: false
//    }

}
