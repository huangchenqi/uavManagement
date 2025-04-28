import QtQuick 2.12
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.0
//通用组件
//通用纯文字组件
Item {
    id:item_Text
    //——————对外参数接口——————
    //文本内容
    property string text:""
    //文本颜色
    property string color:"#ffffffff"
    //文本水平对齐方式
    property int horizontalAlignment:Text.AlignHCenter
    //文本垂直对齐方式
    property int verticalAlignment:Text.AlignVCenter
    //字体
    property alias family: text_Content.font.family
    //文本是否加粗
    property bool bold:false
    //文本字号(pixel)
    property int pixelSize:(24)
    //换行方式
    property int wrapMode:Text.NoWrap
    //文本是否有下划线
    property bool underline:false
    //是否为数字
    property bool isNumber:false
    //文字是否有边框
    property bool isBorder:false
    //斜体
    property bool italic:false
    //——————————————————
    //按钮底框
    Rectangle{
        width: parent.width
        height: pixelSize
        anchors.left: text_Content.left
        anchors.top: text_Content.top
        visible: isBorder
        color:"#00000000"
        border.width: 1
        border.color: item_Text.color
    }
    //原生文本组件
    Text{
        id:text_Content
        anchors.fill: parent
        text:qsTr(item_Text.text)
        color:item_Text.color
        horizontalAlignment: item_Text.horizontalAlignment
        verticalAlignment: item_Text.verticalAlignment
        font.pixelSize: item_Text.pixelSize
        font.family: "黑体"
        font.bold: item_Text.bold
        font.underline: item_Text.underline
        font.italic:item_Text.italic
        //elide: Text.ElideRight
        clip: parent.clip
        wrapMode:item_Text.wrapMode


    }
}
