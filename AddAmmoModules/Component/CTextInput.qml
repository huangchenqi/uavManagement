import QtQuick 2.0
import QtQuick.Controls 2.12
//通用类-自定义TextInput控件
Item {
    id:item_TextInput
    ////控件基础属性
    //标题
    property string title:""
    //字体大小
    property int pixelSize:(12)
    //只读
    property bool readOnly:false
    //显示线
    property bool showLine:true
    //文本内容
    property string text: ""
    //颜色
    property string color:readOnly ? "#ff909090":"#fff0cc55"
    //输入控件
    property alias input:text_input_NightVision
    //标题宽度
    property var  titleWidth: (54)
    //隐藏边框
    property bool borderVisible: true

    property bool onlyNum: true

    property var horizontalAlignment: Text.AlignLeft

    Component {
        id: doubleValidatorComponent
        DoubleValidator {
            bottom: -9999999
            top: 9999999
            notation: DoubleValidator.StandardNotation
            decimals: 5
        }
    }
    ////控件属性Change信号
    ////自定义属性
    ////自定义函数
    ////包含组件
    Rectangle{
        id:rect_NightVision
        anchors.fill: parent
        border.color: item_TextInput.color
        border.width: borderVisible? 1:0
        color:"transparent"
        radius: (5)
        CText{
            id: text_NightVision
            width: titleWidth
            height: parent.height
            anchors.left: parent.left
            anchors.leftMargin: 5
            anchors.top:parent.top
            pixelSize: item_TextInput.pixelSize//12
            bold: true
            color:item_TextInput.color
            verticalAlignment: Text.AlignVCenter
            text:title
        }
        TextInput{
            id: text_input_NightVision
            width: rect_NightVision.width - text_NightVision.width - anchors.leftMargin * 2
            height: parent.height
            anchors.left: text_NightVision.right
            anchors.leftMargin: (5)
            anchors.top:parent.top
            font.pixelSize: item_TextInput.pixelSize//12
            readOnly: item_TextInput.readOnly
            font.family: "simhei"
            font.bold: true
            color:"#ffffffff"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: item_TextInput.horizontalAlignment
            clip: true
            text:item_TextInput.text
            onTextChanged: {
                if(text.includes(" "))
                    text = text.replace(/\s+/g, "")  // 移除所有空格
                item_TextInput.text = text
            }
            selectByMouse: true
            selectedTextColor: "#ffffffff"
            selectionColor: "#ffdddd88"
            validator:{
                if(onlyNum)
                {
                    return doubleValidatorComponent.createObject()
                }
                else return null
            }
        }
    }
}
