import QtQuick 2.0
import QtQuick.Controls 2.12
import QtQuick.Window 2.12

import "qrc:/"
import "qrc:/AddAmmoModules/Component"
import "qrc:/AddAmmoModules"

//import "qrc:/Code/QML/Component"
//import "qrc:/Code/QML"
//投放速度弹窗
Item {
    id:custom_InterferencePodDropSpeed
    width: 450
    height: 400
    property int loadDataType: 0  // 0:新增，1:查看,2:修改
    property int selectIndex: -1
    property int lastSelectIndex: -1
    onScaleChanged: {
        if(lastSelectIndex == selectIndex)
            return
        if(lastSelectIndex > -1)
            listmodel_.set(lastSelectIndex,{m_SelectState:fasle})
    }
    onLoadDataTypeChanged: {
        if(custom_InterferencePodDropSpeed.loadDataType === 1){
            allComponentEnable()
        }else if(custom_InterferencePodDropSpeed.loadDataType === 2){
        }else{
            console.log("Unknown custom_InterferencePodDropSpeed.loadDataType")
        }
    }


    Image {
        id: backGround
        source: mainBackgroundSource
        anchors.fill: parent
    }

    Rectangle{
        id:rect_Root
        anchors.fill: parent
        color: "#50000000"

        Rectangle{
            id:rect_DataShow
            color: "transparent"
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: btn_Confir.top
            anchors.bottomMargin: 10

            Rectangle{
                id:rect_Title
                anchors.top: parent.top
                anchors.left: parent.left
                width: parent.width
                color: "#1D0D0E"
                height: 50
                border.color: mainColor

                Rectangle{
                    id:rect_NumTitle
                    border.width: 1
                    border.color: mainColor
                    width: 50
                    color: "transparent"
                    height: parent.height
                    CText{
                        id:text_NumTitle
                        text: "序号"
                        color: mainColor
                        pixelSize: 18
                        anchors.centerIn: parent
                        anchors.verticalCenter: parent.verticalCenter
                        horizontalAlignment: Text.AlignHCenter
                    }
                }

                Rectangle{
                    id:rect_DropMethodTitle
                    height: parent.height
                    border.width: 1
                    border.color: mainColor
                    width: 200
                    color: "transparent"
                    anchors.left: rect_NumTitle.right
                    CText{
                        id:text_DropMethodTitle
                        pixelSize: 18
                        anchors.centerIn: parent
                        horizontalAlignment: Text.AlignHCenter
                        width: parent.width / 5
                        color: mainColor
                        text: "投放方式"
                    }
                }

                Rectangle{
                    id:rect_DropSpeedTitle
                    height: parent.height
                    border.width: 1
                    border.color: mainColor
                    width: 200
                    color: "transparent"
                    anchors.left: rect_DropMethodTitle.right
                    CText{
                        id:text_DropSpeeditle
                        pixelSize: 18
                        anchors.centerIn: parent
                        horizontalAlignment: Text.AlignHCenter
                        color: mainColor
                        text: "投放速度(盒/s)"
                    }
                }
            }

            ListView{
                id:listView_DataShow
                anchors.top: rect_Title.bottom
                anchors.left: parent.left
                width: parent.width
                height: parent.height - rect_Title.height
                visible: true
                clip: true

                model:ListModel{
                    id:listmodel_
                }
                delegate: Component{
                    Item {
                        id:item_Delegate
                        width: listView_DataShow.width
                        height: 50

                        Rectangle{
                            id:rect_Data
                            anchors.fill: parent
                            color: "transparent"
                            border.color: m_SelectState ? "red" : mainColor
                            border.width: m_SelectState ? 3 : 1
                            Rectangle{
                                id:rect_Num
                                border.width: m_SelectState ? 3 : 1
                                border.color: m_SelectState ? "red" : mainColor
                                width: 50
                                color: "transparent"
                                height: parent.height
                                CText{
                                    id:text_Num
                                    text: index + 1
                                    pixelSize: 18
                                    color: mainColor
                                    anchors.fill: parent
                                    horizontalAlignment: Text.AlignHCenter
                                }
                                MouseArea{
                                    anchors.fill: parent
                                    acceptedButtons: Qt.LeftButton | Qt.RightButton
                                    onClicked: {
                                        lastSelectIndex - selectIndex
                                        selectIndex = index
                                        m_SelectState = !m_SelectState
                                    }
                                }
                            }

                            Rectangle{
                                id:rect_DropMethod
                                height: parent.height
                                border.width: m_SelectState ? 3 : 1
                                border.color: m_SelectState ? "red" : mainColor
                                width: 200
                                color: "transparent"
                                anchors.left: rect_Num.right
//                                CText{
//                                    id:text_DropMethod
//                                    text: m_DropMethod
//                                    pixelSize: 18
//                                    color: mainColor
//                                    anchors.fill: parent
//                                    horizontalAlignment: Text.AlignHCenter
//                                }
                                CTextInput{
                                    id:text_DropMethod
                                    anchors.fill: parent
                                    pixelSize: 18
                                    titleWidth: 0
                                    anchors.centerIn: parent
                                    horizontalAlignment: Text.AlignHCenter
                                    borderVisible: false
                                    text: m_DropMethod
                                    onlyNum: false
                                    onTextChanged: {
                                        m_DropMethod = text
                                    }
                                }
                            }

                            Rectangle{
                                id:rect_DropSpeed
                                height: parent.height
                                border.width: m_SelectState ? 3 : 1
                                border.color: m_SelectState ? "red" : mainColor
                                width: 200
                                color: "transparent"
                                anchors.left: rect_DropMethod.right
//                                CText{
//                                    id:text_DropSpeed
//                                    text: m_DropSpeed
//                                    pixelSize: 18
//                                    color: mainColor
//                                    anchors.fill: parent
//                                    horizontalAlignment: Text.AlignHCenter
//                                }
                                CTextInput{
                                    id:text_DropSpeed
                                    anchors.fill: parent
                                    pixelSize: 18
                                    titleWidth: 0
                                    anchors.centerIn: parent
                                    horizontalAlignment: Text.AlignHCenter
                                    borderVisible: false
                                    text: m_DropSpeed
                                    onTextChanged: {
                                        m_DropSpeed = text
                                    }
                                }
                            }
                        }
                    }
                }
                Component.onCompleted: {
                    if(custom_InterferencePodDropSpeed.loadDataType === 0){
                        listmodel_.clear()
                        listmodel_.append({m_SelectState:false,m_DropMethod:"同时1",m_DropSpeed:""})
                        listmodel_.append({m_SelectState:false,m_DropMethod:"同时2",m_DropSpeed:""})
                        listmodel_.append({m_SelectState:false,m_DropMethod:"交替1",m_DropSpeed:""})
                        listmodel_.append({m_SelectState:false,m_DropMethod:"交替2",m_DropSpeed:""})
                        listmodel_.append({m_SelectState:false,m_DropMethod:"交替3",m_DropSpeed:""})
                    }else if(custom_InterferencePodDropSpeed.loadDataType === 1){

                    }else if(custom_InterferencePodDropSpeed.loadDataType === 2){

                    }else{
                        console.log("Unknown custom_InterferencePodDropSpeed.loadDataType")
                    }

                    // listmodel_.append({m_SelectState:false,m_DropMethod:"同时1",m_DropSpeed:"12"})
                    // listmodel_.append({m_SelectState:false,m_DropMethod:"同时2",m_DropSpeed:"5"})
                    // listmodel_.append({m_SelectState:false,m_DropMethod:"交替1",m_DropSpeed:"3.3"})
                    // listmodel_.append({m_SelectState:false,m_DropMethod:"交替2",m_DropSpeed:"2"})
                    // listmodel_.append({m_SelectState:false,m_DropMethod:"交替3",m_DropSpeed:"1.5"})
                }
            }

        }

        CButton{
            id:btn_Cancel
            anchors.right: parent.right
            anchors.rightMargin: 10
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 10
            text: "取消"
            pixelSize: 18
            width: 80
            height: 36
            onClicked: {
                //
                custom_InterferencePodDropSpeed.visible = false
            }
        }
        CButton{
            id:btn_Confir
            anchors.right: btn_Cancel.left
            anchors.rightMargin: 10
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 10
            text: "确认"
            pixelSize: 18
            width: 80
            height: 36
            onClicked: {
                //
               let iSpeedData = saveData(listmodel_)
                custom_PassiveInterferencePod.interencePodSpeed = iSpeedData
                console.log("iSpeedData"+iSpeedData+"<>"+custom_PassiveInterferencePod.interencePodSpeed)
                custom_InterferencePodDropSpeed.visible = false
            }
        }

    }
    //提取model中的数据封装成字符串
    function saveData(listModel) {
        var result = "";
        for (var i = 0; i < listModel.count; i++) {
            var item = listModel.get(i);
            if (item.m_DropMethod && item.m_DropSpeed) {
                if (result !== "") {
                    result += ";";
                }
                result += item.m_DropMethod + ":" + item.m_DropSpeed;
            }
        }
        return result;
    }
    //加载数据查看与修改
    function initListData(data) {
            listmodel_.clear()

            // 将字符串 "同时1:1;同时2:2;交替1:1;交替2:2;交替3:1" 转化为数组
            var pairs = data.split(";")
            var listModelArray = []

            for (var i = 0; i < pairs.length; i++) {
                var pair = pairs[i].split(":")
                if (pair.length === 2) {
                    listModelArray.push({
                        m_SelectState: false,
                        m_DropMethod: pair[0].trim(), // : 前的值
                        m_DropSpeed: pair[1].trim()  // : 后的值
                    })
                }
            }

            // 将数组中的对象添加到 ListModel
            for (var j = 0; j < listModelArray.length; j++) {
                listmodel_.append(listModelArray[j])
            }

    }
    function allComponentEnable(){
      listView_DataShow.enabled = false
      btn_Confir.text = "返回"
      btn_Cancel.visible = false
    }
}
