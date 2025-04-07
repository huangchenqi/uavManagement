import QtQuick 2.12
import QtQuick.Controls 2.14
import QtQuick.Layouts 1.14

Item {
    id:root
    visible: true
    width: 1600
    height: 830
    Rectangle{
        id: uavManageMentMain
        visible: true
        width: 1400
        height: 800
        // 全局可用性控制属性
        // 全局可用性控制属性

        //background: Rectangle { color: "#ffffff" }//#f0f0f0
        Component.onCompleted: {
            //loadData()
        }
        ColumnLayout{
            anchors.fill: parent
            spacing: 0 // 关键：移除子项之间的默认间距
                TabBar{
                    id:tabBar
                    Layout.fillWidth: true
                    //如果TabBar是放在一个支持这些属性的布局中（如ColumnLayout或RowLayout，但请注意TabBar通常不直接放在这些布局中），可以
                    //尝试设置这些属性来影响布局对 TabButton 的大小分配。
                    Layout.preferredHeight: 40//注意调节这个值会造成TaBar与Page{}中的间距过大
                    padding: 0
                    //spacing: 4
                    TabButton{
                        id:reconnaissancePayoadManagement
                        height: 50
                        width: 100
                        //Layout.leftMargin: 2
                        text: "侦察载荷管理"
                        // 设置字体大小
                        font.pixelSize: 12  // 可以根据需要调整这个值

                        // 设置Tab的背景颜色
                        background: Rectangle {
                            color: parent.checked ? "#87CEEB" : "#D3E1FE"
                        }

                        onClicked: {

                            stackLayout.currentIndex = 0
                            // 重置其他按钮的背景颜色
                            //resetTabColors();
                            //background.color = "#87CEEB";

                        }
                    }
                    TabButton{
                        id:ammunitionLoadManagement
                        height: 50
                        width: 100
                        text: "弹药载荷管理"
                        // 设置字体大小
                        font.pixelSize: 12  // 可以根据需要调整这个值
                        background: Rectangle {
                            color: parent.checked ? "#87CEEB" : "#D3E1FE"
                        }

                        onClicked: {

                            stackLayout.currentIndex = 1

                            //resetTabColors();
                            //background.color = "#87CEEB";
                            // 重置其他按钮的背景颜色
                        }

                    }

                }

            StackLayout{
                id: stackLayout
                Layout.fillWidth: true
                Layout.fillHeight: true
                currentIndex: 0


                // // 在 StackLayout 加载完成后设置背景颜色
                Component.onCompleted: {
                    //uavManagement.background.color = "#87CEEB";

                }
                Page{
                    padding: 0

                    // Rectangle{
                    //     id:payloadTest

                    //     height: parent.height
                    //     width: parent.width
                    //     color: "blue"
                    // }
                    Loader {
                               id: uavManagementLoader
                               source: "./UavReconnaissancePayloadManagement.qml" // 这里指定你想要加载的QML文件的路径
                               onLoaded: {

                               }

                           }

                           // 如果需要，你可以在Loader加载完成后访问其项（item）并进行操作
                   Component.onCompleted: {
                       //myLoader.item.someProperty = someValue // 假设OtherFile.qml的根元素有一个名为someProperty的属性
                   }
                }
                Page{

                    padding: 0
                    Loader {
                               id: ammunitionLoadManagementLoader
                               source: "./UavAmmunitionLoadManagement.qml" // 这里指定你想要加载的QML文件的路径
                           }

                           // 如果需要，你可以在Loader加载完成后访问其项（item）并进行操作
                   Component.onCompleted: {
                       //myLoader.item.someProperty = someValue // 假设OtherFile.qml的根元素有一个名为someProperty的属性
                   }
                }
                Page{
                    Text {
                        id: thname
                        anchors.centerIn: parent
                        text: qsTr("textpage3")
                    }
                }
            }
        }


        function loadData(){
            //uavManagement.background.col="#87CEEB"

        }

    }

    // 重置所有标签按钮的背景颜色
    // function resetTabColors() {
    //     uavManagement.background.color = "#D3E1FE";
    //     partManagement.background.color = "#D3E1FE";
    //     methodManagement.background.color = "#D3E1FE";

    // }
}
