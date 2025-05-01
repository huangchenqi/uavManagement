import QtQuick 2.0
import QtQuick 2.10
import QtQuick.Controls 2.10
import QtQuick.Layouts 1.10
//import "qrc:/Components"
//import "qrc:/page"

Item {
    id: mainWindow

    // Root item properties for layout
    property int activeView: 0  // Default active view
    // 添加expandedMenus属性用于存储菜单展开状态
    property var expandedMenus: ({})

    // Backend interface for getting data
    property var navigationItems: [
        {
            id: 0,
            name: "型号管理"
        },
        {
            id: 1,
            name: "组件管理"
        },
        {
            id: 2,
            name: "方案管理"
        }
        // {
        //     name: "任务分析",
        //     children:[
        //         {
        //             id: 2,
        //             name: "实兵"
        //         },
        //         {
        //             id: 3,
        //             name: "实装"
        //         }
        //     ]
        // }
    ]

    // Function to switch views
    function switchView(viewId) {
        activeView = viewId;
    }
    
    // 切换菜单展开状态
    function toggleMenuExpand(menuName) {
        // 如果当前是undefined或false，则设为true，否则设为false
        expandedMenus[menuName] = !expandedMenus[menuName]
        // 强制属性通知变化
        expandedMenus = Object.assign({}, expandedMenus)
    }

    // Main layout - Row with navigation on left, content on right
    RowLayout {
        anchors.fill: parent
        spacing: 0

        // Left navigation panel
        Rectangle {
            Layout.preferredWidth: 180
            Layout.fillHeight: true
            color: "#f0f0f0"

            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 10
                spacing: 8

                // App title/header
                // Rectangle {
                //     Layout.fillWidth: true
                //     Layout.preferredHeight: 50
                //     color: "#2c3e50"
                //     radius: 4

                //     Text {
                //         anchors.centerIn: parent
                //         text: "无人机型号管理软件"
                //         color: "white"
                //         font.pixelSize: 14
                //         font.bold: true
                //     }
                // }

                // Dynamic navigation tree
                ListView {
                    id: navigationList
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    model: navigationItems
                    spacing: 5
                    
                    // Navigation item delegate - handles both parent and children
                    delegate: Column {
                        id: navItem
                        width: navigationList.width
                        
                        // 判断是否有子项
                        property bool hasChildren: modelData.children !== undefined
                        // 从全局状态获取展开状态
                        property bool isExpanded: hasChildren ? expandedMenus[modelData.name] === true : false
                        
                        // 主导航项
                        Rectangle {
                            id: mainNavItem
                            width: navigationList.width
                            height: 48
                            radius: 4
                            // 如果是叶子节点才检查activeView
                            color: !hasChildren && modelData.id === activeView ? "#3498db" : "#ffffff"
                            border.color: "#dddddd"
                            border.width: 1

                            MouseArea {
                                anchors.fill: parent
                                onClicked: {
                                    if (hasChildren) {
                                        // 切换展开状态 - 使用全局函数
                                        toggleMenuExpand(modelData.name)
                                    } else {
                                        // 切换视图
                                        switchView(modelData.id)
                                    }
                                }
                            }

                            RowLayout {
                                anchors.fill: parent
                                anchors.margins: 10
                                spacing: 10

                                Image {
                                    Layout.preferredWidth: 24
                                    Layout.preferredHeight: 24
                                    source: modelData.icon
                                    visible: modelData.icon !== undefined
                                }

                                Text {
                                    Layout.fillWidth: true
                                    text: modelData.name
                                    font.pixelSize: 14
                                    color: !hasChildren && modelData.id === activeView ? "#ffffff" : "#333333"
                                    font.bold: hasChildren
                                }
                                
                                // 展开/折叠图标
                                Text {
                                    id: expandIcon
                                    visible: hasChildren
                                    text: "▶"
                                    font.pixelSize: 12
                                    color: "#333333"
                                    
                                    // 添加旋转动画
                                    rotation: navItem.isExpanded ? 90 : 0
                                    
                                    Behavior on rotation {
                                        NumberAnimation {
                                            duration: 200
                                            easing.type: Easing.InOutQuad
                                        }
                                    }
                                }
                            }
                        }
                        
                        // 子导航项容器
                        Item {
                            id: childrenContainer
                            visible: hasChildren
                            width: parent.width
                            // 使用高度动画来控制展开/折叠
                            height: navItem.isExpanded ? childColumn.height : 0
                            clip: true
                            
                            Behavior on height {
                                NumberAnimation {
                                    duration: 200
                                    easing.type: Easing.InOutQuad
                                }
                            }
                            
                            Column {
                                id: childColumn
                                width: parent.width
                                leftPadding: 15
                                // anchors.leftMargin: 15
                                
                                // 为每个子项创建导航按钮
                                Repeater {
                                    model: hasChildren ? modelData.children : 0
                                    
                                    Rectangle {
                                        width: navigationList.width - 15
                                        height: 40
                                        radius: 4
                                        color: modelData.id === activeView ? "#3498db" : "#ffffff"
                                        border.color: "#dddddd"
                                        border.width: 1
                                        
                                        MouseArea {
                                            anchors.fill: parent
                                            onClicked: switchView(modelData.id)
                                        }
                                        
                                        RowLayout {
                                            anchors.fill: parent
                                            anchors.margins: 8
                                            spacing: 8
                                            
                                            Image {
                                                Layout.preferredWidth: 20
                                                Layout.preferredHeight: 20
                                                source: modelData.icon
                                                visible: modelData.icon !== undefined
                                            }
                                            
                                            Text {
                                                Layout.fillWidth: true
                                                text: modelData.name
                                                font.pixelSize: 13
                                                color: modelData.id === activeView ? "#ffffff" : "#333333"
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }

        // Right content area
        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: "#ffffff"

            StackLayout {
                anchors.fill: parent
                anchors.margins: 15
                currentIndex: activeView
                //型号管理记录
                UavManageCommon{}
                //组件记录
                UavExternalMountingManagement{}
                //方案记录
                MountingSchemeManagement{}

            }
        }
    }
}
