import QtQuick 2.12
import QtQuick.Controls 2.14
import QtQuick.Layouts 1.14

Item {
    id:root
    visible: true
    // width: 1600
    // height: 830
    anchors.fill: parent
    Rectangle{
        id: uavManageMentMain
        visible: true
        anchors.fill: parent
        // 全局可用性控制属性
        // 全局可用性控制属性

        //background: Rectangle { color: "#ffffff" }//#f0f0f0
        Component.onCompleted: {
            //loadData()
            console.log("UavExternalMountingManagement初始化");
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
                            console.log("切换到侦察载荷管理选项卡");
                            stackLayout.currentIndex = 0
                            // 重置其他按钮的背景颜色
                            //resetTabColors();
                            //background.color = "#87CEEB";

                        }
                    }
                    TabButton{
                        id:reconnaissanceCommunicationManagement
                        height: 50
                        width: 100
                        //Layout.leftMargin: 2
                        text: "侦察通信管理"
                        // 设置字体大小
                        font.pixelSize: 12  // 可以根据需要调整这个值

                        // 设置Tab的背景颜色
                        background: Rectangle {
                            color: parent.checked ? "#87CEEB" : "#D3E1FE"
                        }

                        onClicked: {
                            console.log("切换到侦察通信管理选项卡");
                            stackLayout.currentIndex = 1
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
                            console.log("切换到弹药载荷管理选项卡");
                            stackLayout.currentIndex = 2

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
                    console.log("StackLayout初始化，当前索引: " + currentIndex);
                }
                
                // 干扰吊舱记录管理页面
                Page{
                    id: interferencePodPage
                    padding: 0
                    
                    // 使用Rectangle替代Loader作为测试
                    Rectangle {
                        id: testRect
                        anchors.fill: parent
                        color: "#f0f0f0"
                        visible: false
                        
                        Text {
                            anchors.centerIn: parent
                            text: "测试矩形 - 干扰吊舱记录管理"
                            font.pixelSize: 20
                            color: "#000000"
                        }
                    }
                    
                    // 使用相对路径加载干扰吊舱记录管理
                    Loader {
                        id: uavManagementLoader
                        anchors.fill: parent
                        source: "./InterferencePodRecordManagement.qml" //UavReconnaissancePayloadManagement
                        // asynchronous: false
                        // active: true
                        visible: true
                        
                        onLoaded: {
                            console.log("干扰吊舱记录管理界面加载完成");
                            if (item) {
                                console.log("加载项可用");
                                item.visible = true;
                            } else {
                                console.log("加载项不可用");
                                // 显示测试矩形
                                testRect.visible = true;
                            }
                        }
                        
                        onStatusChanged: {
                            if (status == Loader.Error) {
                                console.error("加载失败: " + source);
                                // 显示测试矩形
                                testRect.visible = true;
                            } else if (status == Loader.Loading) {
                                console.log("正在加载: " + source);
                            } else if (status == Loader.Ready) {
                                console.log("加载就绪: " + source);
                            }
                        }
                    }
                }
                
                // 侦察通信管理页面
                Page{
                    padding: 0
                    width: parent.width; height: parent.height
                    Loader {
                        id: uavReconnaissanceCommunicationLoader
                        anchors.fill: parent
                        source: "./ReconnaissanceCommunicationRecordManagement.qml"
                        // asynchronous: false
                        onLoaded: {
                            console.log("侦察通信管理界面加载完成");
                        }
                    }
                }
                
                // 弹药载荷管理页面
                Page{
                    padding: 0
                    width: parent.width; height: parent.height
                    Loader {
                        id: ammunitionLoadManagementLoader
                        anchors.fill: parent
                        source: "./AmmoRecordManagement.qml"
                        // asynchronous: false
                        onLoaded: {
                            console.log("弹药载荷管理界面加载完成");
                        }
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
    }

    // 重置所有标签按钮的背景颜色
    // function resetTabColors() {
    //     uavManagement.background.color = "#D3E1FE";
    //     partManagement.background.color = "#D3E1FE";
    //     methodManagement.background.color = "#D3E1FE";

    // }
}
