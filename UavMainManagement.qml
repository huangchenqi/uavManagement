import QtQuick 2.12
import QtQuick.Controls 2.14
import QtQuick.Layouts 1.14

//ApplicationWindow {
Rectangle{
    id:root
    visible: true
    width: 1600
    height: 820
    //title: "无人机型号管理系统 - V1.4"

    Rectangle{
        id: uavManageMentMain
        visible: true
        width: 1600
        height: 820
        // 全局可用性控制属性
        // 全局可用性控制属性
        property bool componentsEnabled: true
        //background: Rectangle { color: "#ffffff" }//#f0f0f0
        Component.onCompleted: {
            //loadData()
        }

        // 自定义分类组件
       // Component {
       //      id: categoryComponent

       //     Column {
       //         width: parent.width
       //        spacing: 2

       //         Rectangle {
       //           width: parent.width
       //             height: 40
       //             color: model.expanded ? "#4CAF50" : "#607D8B"

       //           Text {
       //                anchors.centerIn: parent
       //                text: model.category
       //                color: "white"
       //                font.bold: true
       //            }

       //             MouseArea {
       //                anchors.fill: parent
       //                onClicked: {
       //                   if(navBar.currentIndex === 0) {
       //                        droneModel.setProperty(index, "expanded", !model.expanded)
       //                     } else {
       //                         schemeModel.setProperty(index, "expanded", !model.expanded)
       //                    }
       //                }
       //            }
       //       }

       //         Column {
       //             width: parent.width
       //              visible: model.expanded
       //             spacing: 1

       //            Repeater {
       //                 model: model.items

       //                 delegate: Rectangle {
       //                     width: parent.width
       //                    height: 35
       //                     color: selected ? "#E3F2FD" : "white"
       //                     border.color: "#BDBDBD"

       //                     TextInput {
       //                         anchors {
       //                            left: parent.left
       //                              verticalCenter: parent.verticalCenter
       //                             margins: 8
       //                         }
       //                         text: model.name
       //                         font.pixelSize: 14
       //                         onTextChanged: model.name = text
       //                     }

       //                     MouseArea {
       //                         anchors.fill: parent
       //                         onClicked: {
       //                             // 清除所有选中状态
       //                             if(navBar.currentIndex === 0) {
       //                                  clearSelection(droneModel)
       //                              } else {
       //                                  clearSelection(schemeModel)
       //                              }
       //                              model.selected = true
       //                          }
       //                      }
       //                  }
       //              }
       //          }
       //      }
       //  }

        RowLayout{
            anchors.fill: parent

            // Item {
            //         height: 20 // 设置你想要的顶部间距
            //         width: parent.width
            // }

            Rectangle{
                id:uavMain
                width:100
                height: uavManageMentMain.height
                color: "#D3E1FE"


                ColumnLayout {
                            id: tabColumn

                            Layout.fillWidth: true
                            //Layout.fillHeight: true
                            //spacing: 5

                // TabBar{
                //     id:tabBar
                //     Layout.fillWidth: true
                //     //如果TabBar是放在一个支持这些属性的布局中（如ColumnLayout或RowLayout，但请注意TabBar通常不直接放在这些布局中），可以
                //     //尝试设置这些属性来影响布局对 TabButton 的大小分配。
                //     Layout.preferredHeight: 80
                //     padding: 10
                //     spacing: 4
                    TabButton{
                        id:uavManagement
                        height: 80
                        width: 100
                        //Layout.leftMargin: 2
                        text: "型号管理"
                        // 设置字体大小
                        font.pixelSize: 20  // 可以根据需要调整这个值

                        // 设置Tab的背景颜色
                        background: Rectangle {
                            color: parent.checked ? "#87CEEB" : "#D3E1FE"
                        }

                        onClicked: {

                            stackLayout.currentIndex = 0
                            // 重置其他按钮的背景颜色
                            resetTabColors();
                            background.color = "#87CEEB";

                        }
                    }
                    TabButton{
                        id:partManagement
                        height: 80
                        text: "组件管理"
                        // 设置字体大小
                        font.pixelSize: 20  // 可以根据需要调整这个值
                        background: Rectangle {
                            color: parent.checked ? "#87CEEB" : "#D3E1FE"
                        }

                        onClicked: {

                            stackLayout.currentIndex = 1

                            resetTabColors();
                            background.color = "#87CEEB";
                            // 重置其他按钮的背景颜色
                        }

                    }
                    TabButton{
                        id:methodManagement
                        height: 80
                        text: "方案管理"
                        // 设置字体大小
                        font.pixelSize: 20  // 可以根据需要调整这个值
                        background: Rectangle {
                            color: parent.checked ? "#87CEEB" : "#D3E1FE"
                        }

                        onClicked: {

                            stackLayout.currentIndex = 2
                            // 重置其他按钮的背景颜色
                            resetTabColors();
                            background.color = "#87CEEB";
                        }
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
                    uavManagement.background.color = "#87CEEB";

                }
                Page{
                    UavManageCommon{
                        id:uavManagementCommon
                    }

                    //padding: 10

                    // width: 1500
                    // height: 800
                    // Loader {
                    //            id: uavManagementLoader
                    //            source: "./UavManageCommon.qml" // 这里指定你想要加载的QML文件的路径


                    //            onLoaded: {
                    //               // uavManagementLoader.item.onCustomSignal.connect(handleSignal)


                    //            }
                    //            function handleSignal(msg) {
                    //                uavManageMentMain.enabled = false
                    //                console.log("收到信号:", msg) // 直接连接信号
                    //                console.log(msg) }

                    //        }

                           // 如果需要，你可以在Loader加载完成后访问其项（item）并进行操作
                   Component.onCompleted: {
                       //myLoader.item.someProperty = someValue // 假设OtherFile.qml的根元素有一个名为someProperty的属性
                   }
                }
                Page{

                    padding: 10
                    MountComponentManagement{
                        id:uavLoadMountComponent
                    }

                    // Loader {
                    //            id: uavLoadMountComponentLoader
                    //            source: "./MountComponentManagement.qml" // 这里指定你想要加载的QML文件的路径
                    //        }

                           // 如果需要，你可以在Loader加载完成后访问其项（item）并进行操作
                   Component.onCompleted: {
                       //myLoader.item.someProperty = someValue // 假设OtherFile.qml的根元素有一个名为someProperty的属性
                   }
                }
                Page{
                    MountingSchemeManagement{
                        id:mountingSchemeManagement
                    }

                    // Text {
                    //     id: thname
                    //     anchors.centerIn: parent
                    //     text: qsTr("textpage3")
                    // }
                }
            }
        }


        function loadData(){
            //uavManagement.background.col="#87CEEB"

        }

    }

    // 重置所有标签按钮的背景颜色
    function resetTabColors() {
        uavManagement.background.color = "#D3E1FE";
        partManagement.background.color = "#D3E1FE";
        methodManagement.background.color = "#D3E1FE";

    }

}
