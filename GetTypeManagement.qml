import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtQuick.Window 2.12
import QtQuick.Dialogs 1.2
//测试使用Popup打开GetTypeManagement.qml
Item {
        id:payLoadType
        visible: true
        width: 500
        height: 300
        property string managementType: "";
        ColumnLayout {
            anchors.fill: parent
            //Layout.fillWidth: true
            //Layout.fillHeight: true
            spacing: 10
            RowLayout{
                anchors.fill: parent
                spacing: 10
                TextField {
                    id: payLoadTypeText
                    height: 50
                    width: 80
                    anchors.left: parent.left
                    anchors.leftMargin: 10

                }

                Button{
                    id:payLoadTypeAdd
                    height: 50
                    width: payLoadType.managementType === "attackTargetType" ? 180 : 100
                    //当有三个及其以上的选择时怎么调转宽度
                    //方法一
                    // width: payLoadType.managementType === "attackTargetType" ? 180 :
                    //        (payLoadType.managementType === "bombingMethod" ? 160 : 100)
                    //方法二
                    // width: {
                    //         if (payLoadType.managementType === "attackTargetType") return 180;
                    //         else if (payLoadType.managementType === "bombingMethod") return 160;
                    //         else return 100;
                    //     }
                    text: if (payLoadType.managementType === "loadType") {
                              return "新增载荷类型";
                          } else if (payLoadType.managementType === "uavHanging") {
                              return "新增挂载位置";
                          } else if (payLoadType.managementType === "bombingMethod") {
                              return "新增投弹方式";
                          } else if (payLoadType.managementType === "recoveryMode") {
                              return "新增回收方式";
                          }else if (payLoadType.managementType === "operationType") {
                              return "新增操控方式";
                          }else if (payLoadType.managementType === "ammunitionType") {
                              return "新增弹药类型";
                          }else if (payLoadType.managementType === "guidanceType") {
                              return "新增制导类型";
                          }else if (payLoadType.managementType === "deliveryMethod") {
                              return "新增投放方式";
                          }else if (payLoadType.managementType === "attackTargetType") {
                              return "新增打击目标类型";
                          }else if (payLoadType.managementType === "killingMethod") {
                              return "新增杀伤方式";
                          } else {
                              return "未知操作";
                          }
                    Layout.leftMargin: 10
                }
                Button{
                    id:payLoadTypeDel
                    height: 50
                    width: 100
                    text: if (payLoadType.managementType === "loadType") {
                              return "删除载荷类型";
                          } else if (payLoadType.managementType === "uavHanging") {
                              return "删除挂载位置";
                          } else if (payLoadType.managementType === "bombingMethod") {
                              return "删除投弹方式";
                          } else if (payLoadType.managementType === "recoveryMode") {
                              return "删除回收方式";
                          }else if (payLoadType.managementType === "operationType") {
                              return "删除操控方式";
                          }else if (payLoadType.managementType === "ammunitionType") {
                              return "删除弹药类型";
                          }else if (payLoadType.managementType === "guidanceType") {
                              return "删除制导类型";
                          }else if (payLoadType.managementType === "deliveryMethod") {
                              return "删除投放方式";
                          }else if (payLoadType.managementType === "attackTargetType") {
                              return "删除打击目标类型";
                          }else if (payLoadType.managementType === "killingMethod") {
                              return "删除杀伤方式";
                          }else {
                              return "未知操作";
                          }
                }
                Button {
                    id: payLoadTypeBack
                    height: 50
                    width: 100
                    // Layout.preferredWidth: 100
                    // Layout.preferredHeight: 50
                    text: "返回"
                    onClicked: {
                        payloadTypeManagementPopup.close()// 或myPopup.visible = false
                        uavManagementroot.enabled = true
                        uavManagementroot.visible = true
                    }
                }
            }
            Rectangle{
                id:showPayLoadType
                anchors.left: parent.left
                anchors.leftMargin: 10
                height: 300
                width: 530
                color: "skyblue"
                // 表格内容

            }
        }
        // 定义关闭信号
        signal close()

    function addData(){
    }
    function deleteData(){
    }
}
