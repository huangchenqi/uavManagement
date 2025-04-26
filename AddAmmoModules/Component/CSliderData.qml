import QtQuick 2.12
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.0
Item {
    id:item_SliderDataComp
    //标题名
    property string titleName:""
    //值范围
    property double valueRange:10000.0//180.0
    //最小值
    property double valueMinimum:0
    //字体大小
    property int fontPixelSize:(12)
    //标题文本宽度
    property double textWidth:width * 0.15
    //值
    property double value:255
    //是否显示数值
    property bool isShowData:true
    onValueChanged: {
        valueChange()
    }
    //是否为整数类型
    property bool isInt:false
    //字体加粗
    property bool fontBold:true
    //拖拽区域
    property alias dragArea:area_DragArea
    //是否能够修改值
    property bool setting:false
    //能否右键设置
    property bool dontRightMouse:false
    //输入只读
    property bool inputReadonly:false
    //靠右侧的颜色
    property color rightColor:mainColor//"#ff304352"// "#ffe0bbff"
    onSettingChanged: {
        if(setting)
        {
            text_Input_ValueInput.text = value
            text_Input_MinValueInput.text = valueMinimum
            text_Input_MaxValueInput.text = valueRange
            area_DragArea.width = width
            area_DragArea.x = 0
        }
        else
        {
            if(value > valueRange)
                value = valueRange
            else if(value < valueMinimum)
                value = valueMinimum
            else
                value =Number(text_Input_ValueInput.text)

            valueMinimum = text_Input_MinValueInput.text
            valueRange = text_Input_MaxValueInput.text
            area_DragArea.width = width - text_TitleName.width - 4
            area_DragArea.x = text_TitleName.x +text_TitleName.width
        }
    }
    onWidthChanged: {
        valueChange()
    }
    Component.onCompleted: {
        valueChange()
    }

    //值被修改
    function valueChange(){
        if(value >= valueMinimum && value < valueRange)
        {
            rect_DragShowArea.width = area_DragArea.width * ((value - valueMinimum) / (valueRange - valueMinimum))
        }
        else if(value < valueMinimum)
        {
            rect_DragShowArea.width = 0
            value = valueMinimum
        }
        else
        {
            rect_DragShowArea.width = area_DragArea.width
            value = valueRange
        }
    }

    //主边框
    Rectangle{
        id:rect_MainBorderArea
        anchors.fill: parent
        border.color: mainColor
        border.width: 1
        color:"transparent"
        radius: (5)
        //标题（visible: !setting）
        CText{
            id:text_TitleName
            width: textWidth
            height: parent.height
            anchors.left: parent.left
            anchors.leftMargin: wt(5)
            anchors.top: parent.top
            pixelSize: fontPixelSize
            color:"#ffffffff"
            verticalAlignment: Text.AlignVCenter
            text:titleName
            visible: !setting
        }
        //值拖动显示（visible: !setting）
        Rectangle{
            id:rect_DragShowArea
            anchors.left: text_TitleName.right
            anchors.top: parent.top
            anchors.topMargin: ht(2.5)
            visible: !setting
            color:"#A0ffffff"
            height: parent.height - anchors.topMargin * 2
            radius: (5)
        }
        //渐变特效
        LinearGradient{
            width: rect_DragShowArea.width
            height: rect_DragShowArea.height
            x:rect_DragShowArea.x
            y:rect_DragShowArea.y
            visible: !setting
            source: rect_DragShowArea
            start:Qt.point(0,0)
            end:Qt.point(rect_DragShowArea.width,0)
            gradient: Gradient{
                GradientStop{id:gr_SaveFirstColor;position: 0.0;color:"#ffdddd88"}//"#ffcde7f4""#ffd7d2cc""#ffbbe0ff"}
                GradientStop{position: 1.0;color:rightColor}
            }
        }
        //值区域
        CText{
            id:text_Value
            width: parent.width - text_MinValue.width - text_MaxValue.width - wt(8)
            height: parent.height
            anchors.left: parent.left
            anchors.leftMargin: (2)
            anchors.top: parent.top
            pixelSize: fontPixelSize
            color:"#ffffffff"
            verticalAlignment: Text.AlignVCenter
            text:"值:"
            visible: setting
            //值输入框
            Rectangle{
                id:rect_ValueInputArea
                width: parent.width - wt(18)
                height: parent.height - anchors.topMargin * 2
                anchors.right: text_Value.right
                anchors.top: parent.top
                anchors.topMargin: (2.5)
                color:"transparent"
                radius: (5)
                border.width: 1
                border.color: "#ffffffff"
                TextInput{
                    id:text_Input_ValueInput
                    width: parent.width - anchors.leftMargin * 2
                    height: parent.height
                    anchors.left: parent.left
                    anchors.leftMargin: (2)
                    anchors.top: parent.top
                    verticalAlignment: Text.AlignVCenter
                    font.pixelSize: ht(10)
                    font.family: "simhei"
                    clip:true
                    color:"#ffffffff"
                    validator: RegExpValidator{regExp:!isInt ? /^(\d+)+(\.[0-9]{1,4})?$/ : /^(\d+)+(\.[0-9]{1,9})?$/}
                    selectByMouse: true
                    selectedTextColor: "#ffffffff"
                    selectionColor: "#ffdddd88"
                }
            }
        }
        //最小值区域
        CText{
            id:text_MinValue
            width: parent.width * 0.23 + (24)
            height: parent.height
            anchors.left: text_Value.right
            anchors.leftMargin: (2)
            anchors.top: parent.top
            pixelSize: fontPixelSize
            color:"#ffffffff"
            verticalAlignment: Text.AlignVCenter
            text:"Min:"
            visible: setting
            //值输入框
            Rectangle{
                id:rect_MinValueInputArea
                width: parent.width - (24)
                height: parent.height - anchors.topMargin * 2
                anchors.right: text_MinValue.right
                anchors.top: parent.top
                anchors.topMargin: (2.5)
                color:"transparent"
                radius: (5)
                border.width: 1
                border.color: "#ffffffff"
                TextInput{
                    id:text_Input_MinValueInput
                    width: parent.width - anchors.leftMargin * 2
                    height: parent.height
                    anchors.left: parent.left
                    anchors.leftMargin: (2)
                    anchors.top: parent.top
                    verticalAlignment: Text.AlignVCenter
                    font.pixelSize: (11)
                    font.family: "simhei"
                    clip:true
                    color:"#ffffffff"
                    validator: RegExpValidator{regExp:!isInt ? /^(\d+)+(\.[0-9]{1,4})?$/ : /^(\d+)+(\.[0-9]{1,9})?$/}
                    selectByMouse: true
                    selectedTextColor: "#ffffffff"
                    selectionColor: "#ffdddd88"
                    readOnly: inputReadonly
                }
            }
        }
        //最小值区域
        CText{
            id:text_MaxValue
            width: parent.width * 0.23 + (24)
            height: parent.height
            anchors.left: text_MinValue.right
            anchors.leftMargin: (2)
            anchors.top: parent.top
            pixelSize: fontPixelSize
            color:"#ffffffff"
            verticalAlignment: Text.AlignVCenter
            text:"Max:"
            visible: setting
            //值输入框
            Rectangle{
                id:rect_MaxValueInputArea
                width: parent.width - (24)
                height: parent.height - anchors.topMargin * 2
                anchors.right: text_MaxValue.right
                anchors.top: parent.top
                anchors.topMargin: (2.5)
                color:"transparent"
                radius: (5)
                border.width: 1
                border.color: "#ffffffff"
                TextInput{
                    id:text_Input_MaxValueInput
                    width: parent.width - anchors.leftMargin * 2
                    height: parent.height
                    anchors.left: parent.left
                    anchors.leftMargin: (2)
                    anchors.top: parent.top
                    verticalAlignment: Text.AlignVCenter
                    font.pixelSize: (11)
                    font.family: "simhei"
                    clip:true
                    color:"#ffffffff"
                    validator: RegExpValidator{regExp:!isInt ? /^(\d+)+(\.[0-9]{1,4})?$/ : /^(\d+)+(\.[0-9]{1,9})?$/}
                    selectByMouse: true
                    selectedTextColor: "#ffffffff"
                    selectionColor: "#ffdddd88"
                    readOnly: inputReadonly
                }
            }
        }
        //值显示
        CText{
            id:text_ShowValue
            width: parent.width - text_TitleName
            height: parent.height
            anchors.left:text_TitleName.right
            anchors.leftMargin: (7)
            pixelSize: fontPixelSize
            color:"#ffffffff"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            text:value
            visible: !setting && isShowData
        }
        //值拖动触发区域
        MouseArea{
            id:area_DragArea
            width: parent.width - text_TitleName.width - (4)
            height: parent.height
            x:text_TitleName.x +text_TitleName.width
            y:parent.y
            acceptedButtons: Qt.LeftButton | Qt.RightButton
            property bool isPressed:false
            onPositionChanged: {
                if(!setting)
                {
                    rect_DragShowArea.width = mouseX
                    value = valueMinimum + (valueRange - valueMinimum) * (rect_DragShowArea.width / width)
                    value = value.toFixed(4)
                    if(value < valueMinimum)
                    {
                        value = valueMinimum
                    }
                    if(value > valueRange)
                    {
                        value = valueRange
                    }
                    if(isInt)
                    {
                        value = Math.floor(value)

                    }
                }
            }
            onClicked: {
                if(mouse.button === Qt.RightButton && !dontRightMouse)
                {
                    setting = !setting
                    if(setting)
                    {
                        acceptedButtons = Qt.RightButton
                    }
                    else
                    {
                        acceptedButtons = Qt.LeftButton | Qt.RightButton
                    }
                    if(!setting)
                    {
                        valueChange()
                    }
                }
                else
                {

                    if(!setting)
                    {
                        rect_DragShowArea.width = mouseX
                        var data = (valueMinimum + (valueRange - valueMinimum) * (rect_DragShowArea.width / width))
                        value = data.toFixed(4)
                        if(isInt)
                        {
                            value = Math.floor(value)
                        }
                    }
                }
            }
        }
    }
}
