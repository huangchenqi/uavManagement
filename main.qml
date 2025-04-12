//main.qml
import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
Window {
    visible: true
    width: 1600
    height: 830
    title: qsTr("QQ群：910502689")
    property var processInfo: new Object // global记录对应行对象// 声明全局对象用于记录流程信息（可通过此对象跨组件传递数据）
    //property var processInfo: ({})//new Object() 是一种更传统的创建对象的方式。{} 是一种更简洁的字面量表示法。
    UavMainManagement{
        id:uavMain
    }
}
