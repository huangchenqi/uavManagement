import QtQuick 2.12
import QtQuick.Controls 2.12
//通用组件
//通用常规按钮组件
Item {
    id:item_Button
    //——————对外参数接口——————
    //文本内容
    property string text:""
    //文本颜色
    property string color:"#ffcfab62"
    //边框颜色
    property string borderColor:"#ffefb05d"
    //边框高亮
    property string borderHigtColor:"#ffe4bf50"
    //选中文本颜色
    property string selectColor:"#ff62abcf"
    //选中边框颜色
    property string selectBorderColor:"#ff5db0ef"
    //选中边框高亮颜色
    property string selectBorderHigtColor:"#ff50bfe4"
    //文本水平对齐方式
    property int horizontalAlignment:Text.AlignHCenter
    //文本垂直对齐方式
    property int verticalAlignment:Text.AlignVCenter
    //文本水平对齐间距
    property int horizontalMargins:0
    //字体
    property alias family: text_Content.family
    //文本是否加粗
    property bool bold:false
    //文本字号(pixel)
    property int pixelSize:(24)
    //文本是否有下划线
    property bool underline:false
    //是否为数字
    property bool isNumber:false
    //文字是否有边框
    property bool isBorder:false
    //斜体
    property bool italic:false
    //按钮圆角半径
    property int radius:6
    //不响应点击事件
    property bool clickEvent:true
    //拖拽目标
    property var dragSource:null
    //拖拽事件
    property var dragActive:area_ClickArea.drag.active
    //是否具有选中
    property bool isSelect:false
    onIsSelectChanged: {
        rect_Background.border.color = isSelect ? selectBorderColor : borderColor
    }

    //点击信号
    signal clicked(var mouse)
    //进入信号
    signal entered
    //离开信号
    signal exited
    //按下信号
    signal pressed(int mouseX,int mouseY,var mouse)
    //抬起信号
    signal released(int mouseX,int mouseY,var mouse)
    //移动心海
    signal positionChanged(int mouseX,int mouseY)
    //——————————————————
    //光泽横幅进入动画
    PropertyAnimation{
        id:anim_Prop_BannerMoveIn
        target: canvas_BannerMove
        property: "x"
        to:rect_Background.width - canvas_BannerMove.width
        duration: 125
    }
    //光泽横幅退出动画
    PropertyAnimation{
        id:anim_Prop_BannerMoveOut
        target: canvas_BannerMove
        property: "x"
        to:-canvas_BannerMove.width
        duration: 125
    }
    //按钮底框
    Rectangle{
        id:rect_Background
        anchors.fill: parent
        visible: true
        color:"#ff202020"
        border.width: (2)
        border.color: isSelect ? selectBorderColor : borderColor
        radius: item_Button.radius
        clip: true
        //按钮边框
        Rectangle{
            id:rect_ButtonBorder
            anchors.fill: parent
            anchors.margins: (4)
            color:"#00000000"
            border.width: 1
            border.color: isSelect ? selectBorderColor : borderColor
            radius: item_Button.radius - (2)
        }
        //原生文本组件
        CText{
            id:text_Content
            height: parent.height
            width: parent.width - anchors.leftMargin * 2
            anchors.left: parent.left
            anchors.leftMargin: horizontalMargins
            text:item_Button.text
            family: item_Button.family
            bold:item_Button.bold
            color:isSelect ? item_Button.selectColor : item_Button.color
            pixelSize: item_Button.pixelSize
            underline: item_Button.underline
            italic: item_Button.italic
            verticalAlignment: item_Button.verticalAlignment
            horizontalAlignment: item_Button.horizontalAlignment
        }
        //光泽横幅
        Canvas{
            id:canvas_BannerMove
            width: height
            height: parent.height
            x:-width
            onPaint: {
                var pen = getContext("2d")
                pen.fillStyle = "#25ffffff"
                pen.beginPath()
                pen.moveTo(width * 0.333,0)
                pen.lineTo(width,0)
                pen.lineTo(width*0.667,height)
                pen.lineTo(0,height)
                pen.lineTo(width * 0.333,0)
                pen.fill()

            }
        }
    }
    //按钮点击区域
    MouseArea{
        id:area_ClickArea
        anchors.fill: parent
        hoverEnabled: clickEvent
        enabled: clickEvent
        drag.target: dragSource
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        onPositionChanged: {
            item_Button.positionChanged(mouseX,mouseY)
        }
        onPressed: {
            item_Button.pressed(mouseX,mouseY,mouse)
        }
        onReleased: {
            item_Button.released(mouseX,mouseY,mouse)
        }
        onEntered: {
            if(clickEvent)
            {
                rect_Background.color = "#ff404040"
                rect_Background.border.color = isSelect ? selectBorderHigtColor : borderHigtColor
                anim_Prop_BannerMoveIn.start()
                item_Button.entered()
            }
        }
        onExited: {
            if(clickEvent)
            {
                rect_Background.color = "#ff202020"
                rect_Background.border.color = isSelect ? selectBorderColor : borderColor
                anim_Prop_BannerMoveOut.start()
                item_Button.exited()
            }
        }
        onClicked: {
            if(clickEvent)
            {
                item_Button.clicked(mouse)
            }
        }
    }
}
