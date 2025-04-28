import QtQuick 2.12
import QtQuick.Window 2.12
//import QtCharts 2.3
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.5
import QtQuick.Dialogs 1.3  // 引入 QtQuick.Dialogs 模块

import "qrc:/"
import "qrc:/AddAmmoModules/Component"
import "qrc:/AddAmmoModules/"
import AmmoDaoModel 1.0
Rectangle {
    id:addAmmoAllDatView
    visible: true
    width: 920
    height: 800
    z: 100
    //property var ammoSelecttype: ""
    property string selectedType: ""//判断是否是新增、查看、修改
    property string viewType: ""
    property string mainColor:"#fff0cc55"
    property var uavArray: []
    property var ammoData: new Object // 记录ammo的数据在保存、修改、加载时候
    readonly property string mainBackgroundSource: "file:Resources/Background/bg_MainBackground.png"
    signal backAmmoRecord()
    Component.onCompleted: {
        loadViewType()
        initAmmoData()
    }
    AmmoDaoTableModel{
        id:ammoDaoModel
    }
    // 定义警告对话框
    Popup {
            id: warningPopup
            width: 200
            height: 100
            x: (parent.width - width) / 2
            y: (parent.height - height) / 2
            modal: true
            focus: true
            closePolicy: Popup.NoAutoClose // 禁止点击外部关闭

            background: Rectangle {
                color: "#ffeb3b"
                border.color: "#fbc02d"
                radius: 5
            }

            contentItem: Text {
                id:warningItem
                //text: "您查询的是全部数据！"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: 16
            }
        }
    Timer {
            id: autoCloseTimer
            interval: 500 // 2秒
            onTriggered: warningPopup.close()
        }
    Item {
        anchors.fill: parent
        Image {
            id: backGround
            anchors.fill: parent
            sourceSize: Qt.size(width,height)
            source: mainBackgroundSource
        }

    }

    //通用属性
    AddAmmoCommonData{
        id:addAmmo
        anchors.left: parent.left
        anchors.leftMargin: 5
        anchors.top: parent.top
        anchors.topMargin: 10
    }
    FanTanKeZiMu{
           id:custom_FanTanKeZiMu
           anchors.left: parent.left
           anchors.leftMargin: 5
           anchors.top: addAmmo.bottom
           anchors.topMargin: 10
           visible: viewType == "航空反坦克子母弹"
       }

    //无源干扰吊舱
    PassiveInterferencePod{
        id:custom_PassiveInterferencePod
        anchors.left: parent.left
        anchors.leftMargin: 5
        anchors.top: addAmmo.bottom
        anchors.topMargin: 10
        visible: viewType == "无源干扰吊舱"//true
    }
    //航空燃料炸弹
    FuelAirBomb{
        id:custom_FuelAirBomb
        anchors.left: parent.left
        anchors.leftMargin: 5
        anchors.top: addAmmo.bottom
        anchors.topMargin: 10
        visible: viewType == "燃料空气炸弹"//false
    }
    //航空半穿甲炸弹
    HalfarmorPiercingBullet{
        id:custom_HalfarmorPiercingBullet
        anchors.left: parent.left
        anchors.leftMargin: 5
        anchors.top: addAmmo.bottom
        anchors.topMargin: 10
        visible: viewType == "航空半穿甲炸弹"//false
    }
    //歼-6炸弹航空爆破炸弹
    J6Missile{
        id:custom_J6Missile
        anchors.left: parent.left
        anchors.leftMargin: 5
        anchors.top: addAmmo.bottom
        anchors.topMargin: 10
        visible: viewType == "航空爆破炸弹" //false
    }
    //航空区域封锁字母弹
    QuYuFengSuoZiMu{
        id:custom_QuYuFengSuoZiMu
        anchors.left: parent.left
        anchors.leftMargin: 5
        anchors.top: addAmmo.bottom
        anchors.topMargin: 10
        visible: viewType == "航空区域封锁字母弹" //false
    }
    //航空燃料炸弹
    RanShaoDan{
        id:custom_RanShaoDan
        anchors.left: parent.left
        anchors.leftMargin: 5
        anchors.top: addAmmo.bottom
        anchors.topMargin: 10
        visible: viewType == "航空燃料炸弹" //false
    }
    //航空杀伤爆破炸弹
    ShaShangBaoPo{
        id:custom_ShaShangBaoPo
        anchors.left: parent.left
        anchors.leftMargin: 5
        anchors.top: addAmmo.bottom
        anchors.topMargin: 10
        visible: viewType == "航空杀伤爆破炸弹" //false
    }
    //航空碳纤维炸弹
    TanQianWeiBomb{
        id:custom_TanQianWeiBomb
        anchors.left: parent.left
        anchors.leftMargin: 5
        anchors.top: addAmmo.bottom
        anchors.topMargin: 10
        visible: viewType == "航空碳纤维炸弹" //false
    }


    //航空宣传宣传炸弹
    XuanChuanBomb{
        id:custom_XuanChuanBomb
        anchors.left: parent.left
        anchors.leftMargin: 5
        anchors.top: addAmmo.bottom
        anchors.topMargin: 10
        visible: viewType == "航空宣传宣传炸弹" //false
    }

    Rectangle{
        id:rect_Describe
        anchors.top: custom_PassiveInterferencePod.top
        anchors.left: custom_PassiveInterferencePod.right
        anchors.leftMargin: 10
        anchors.right: addAmmo.right
        anchors.bottom: custom_PassiveInterferencePod.bottom
        color:"#50000000"
        radius: 10

        CText {
            id: text_DescribeTitle
            text: qsTr("用途描述:")
            pixelSize: 25
            color: "#4EC4FF"
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.top: parent.top
            anchors.topMargin: 20
            horizontalAlignment: Text.AlignLeft

        }
        TextArea {
            id: usageDescriptionText
            anchors.top: text_DescribeTitle.bottom
            anchors.topMargin: 15
            anchors.left: text_DescribeTitle.left
            anchors.right: parent.right
            anchors.rightMargin: 5
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 5
            // 边框样式
                background: Rectangle {
                    border.color: "#cccccc"
                    radius: 10
                }

            // 多行显示关键配置
            wrapMode: Text.Wrap                   // 自动换行
            placeholderText: "请输入多行描述..."    // 占位提示
            textFormat: Text.PlainText            // 文本格式
            selectByMouse: true                   // 允许鼠标选择
            inputMethodHints: Qt.ImhMultiLine      // 启用多行输入法支持
            font.family: "黑体"
            font.pixelSize: 20
            onTextChanged: {
                ammoData.ammoDescription =text
                console.log("Text content changed to: " + text)

            }
        }
    }

    Rectangle {
        id: rect_ImageShow
        visible: true
        width:500
        height: 600
        anchors.left: addAmmo.right
        anchors.leftMargin: 10
        anchors.top: addAmmo.top
        color: "#ECF2FE"
        border.color: "#BDBDBD"
        // 点击区域
        MouseArea {
            id:uavImagSelect
            anchors.fill: parent
            onClicked: {
                fileDialog.open()
            }
        }
        FileDialog {
            id: fileDialog
            title: "选择图片"
            nameFilters: ["图片文件 (*.png *.jpg *.jpeg)"]
            onAccepted: {
                ammunitionImg.source = fileUrls[0]
                //addUavModelData.image_name = uavImg.source.toString()
                ammoData.image_url = ammunitionImg.source.toString()
                var currentModel = navBar.currentIndex === 0 ? droneModel : schemeModel
                for(var i = 0; i < currentModel.count; i++){
                    if(currentModel.get(i).expanded){
                        currentModel.get(i).items.push({
                            name: "新条目",
                            selected: false
                        });
                        break;
                    }
                }
            }
            // onAccepted: {
            //             // 获取选中的文件路径
            //             var filePath = fileDialog.fileUrl.toString()
            //             // 去掉 "file://" 前缀
            //             filePath = filePath.replace("file://", "")
            //             // 加载图片
            //             uavImg.source = filePath
            //         }
        }
        Image {
            id: ammunitionImg
            anchors.fill: parent
            source: {
                if(processInfo.loadViewType === "addUavData"){
                    return ""
                }else if(processInfo.loadViewType === "query"){
                    rect_ImageShow.enabled = false

                    //return processInfo.imagUrl
                }else if(processInfo.loadViewType === "update"){
                    //return processInfo.imagUrl
                    //console.log("addUavDataView"+processInfo.loadViewType)
                }else{
                    console.log("uav Image processInfo.loadViewType Unknown")
                }
            }
        }

        CText {
            anchors.centerIn: parent
            text: "图片展示区域"
            color: "#9E9E9E"
        }
    }

    CButton{
        id:btn_Cancel
        anchors.top: rect_ImageShow.bottom
        anchors.topMargin: 5
        anchors.right: rect_ImageShow.right
        anchors.rightMargin: 5
        height: pixelSize * 2
        width: pixelSize * 4
        text: "取消"
        onClicked: {
            backAmmoRecord()
            addAmmoAllDatView.visible = false
        }
    }
    CButton{
        id:btn_Save
        anchors.top: rect_ImageShow.bottom
        anchors.topMargin: 5
        anchors.right: btn_Cancel.left
        anchors.rightMargin: 10
        height: pixelSize * 2
        width: pixelSize * 4
        text: "保存"
        onClicked: {

            saveAmmoData()
            backAmmoRecord()
            addAmmoAllDatView.visible = false
        }
    }
    function loadViewType(){
        if(processInfo.loadViewType === "addition"){
           addAmmo.selectType = 0 //0 代表新增，1代表查看，2代表修改。
        }else if(processInfo.loadViewType === "query"){
            addAmmo.selectType = 1
        }else if(processInfo.loadViewType === "update"){
            addAmmo.selectType = 2
        }else{
            console.log("Unknown processInfo.loadViewType!")
        }
    }

    function initAmmoData(){
        //#pragma db not_null column("ammo_name")//            VARCHAR(100) NOT NULL ,--COMMENT '名称',
        addAmmoAllDatView.ammoData.ammoName = ""
        //#pragma db not_null column("short_name")//    short_name VARCHAR(50) ,--COMMENT '简称',
        addAmmoAllDatView.ammoData.shortName = ""
        //#pragma db not_null column("ammo_type")             // 弹药类型ammo_type VARCHAR(50) ,--COMMENT '炸弹类型',
        addAmmoAllDatView.ammoData.ammoType = ""
        //#pragma db not_null column("ammo_id")                        // 弹药编号
        addAmmoAllDatView.ammoData.ammoId = ""
        //#pragma db not_null column("used_uav_models")                        // used_uav_models VARCHAR(200) NOT NULL ,--COMMENT '使用机型'
        addAmmoAllDatView.ammoData.ammoToUavModel = ""
        //#pragma db not_null column("description")                        //         description TEXT ,--COMMENT '用途描述',
        addAmmoAllDatView.ammoData.ammoDescription = ""
        //#pragma db not_null column("length")                        //-- 基础物理特性        length REAL NOT NULL ,--COMMENT '炸弹长度(m)',
        addAmmoAllDatView.ammoData.ammoLenth   = 0.0
        //#pragma db not_null column("mass")    //mass REAL NOT NULL ,--COMMENT '炸弹质量(kg)',
        addAmmoAllDatView.ammoData.ammoMass   = 0.0
        //#pragma db not_null column("diameter")   //        diameter REAL NOT NULL ,--COMMENT '直径(m)',
        addAmmoAllDatView.ammoData.ammoDiameter   = 0.0
        //#pragma db not_null column("wingspan") //wingspan REAL NOT NULL ,--COMMENT '翼展(m)',
        addAmmoAllDatView.ammoData.ammoWingspan   = 0.0
        //#pragma db not_null column("warhead_cg_distance") //warhead_cg_distance REAL NOT NULL ,--COMMENT '弹头端面至重心距离(m)',
        addAmmoAllDatView.ammoData.ammoWarheadCgDistance   = 0.0
        //#pragma db not_null column("charge_mass") //charge_mass REAL NOT NULL ,--COMMENT '炸弹装药质量(kg)',
        addAmmoAllDatView.ammoData.ammoChargeMass   = 0.0
        //#pragma db not_null column("charge_coefficient") //charge_coefficient REAL NOT NULL ,--COMMENT '装填系数',
         addAmmoAllDatView.ammoData.ammoChargeCoefficient   = 0.0
         //#pragma db not_null column("max_release_height") //max_release_height REAL NOT NULL ,--COMMENT '投弹高度(最大)(m)',
         addAmmoAllDatView.ammoData.ammoMaxReleaseHeight   = 0.0
         //#pragma db not_null column("min_release_height") //min_release_height REAL NOT NULL ,--COMMENT '投弹高度(最小)(m)',
         addAmmoAllDatView.ammoData.ammoMinReleaseHeight = 0.0
        //#pragma db not_null column("min_release_speed") //min_release_speed REAL NOT NULL ,--COMMENT '投弹速度(最小)(m/s)',
         addAmmoAllDatView.ammoData.ammoMinReleaseSpeed   = 0.0
        //#pragma db not_null column("max_release_speed") //max_release_speed REAL NOT NULL ,--COMMENT '投弹速度(最大)(m/s)',
         addAmmoAllDatView.ammoData.ammoMaxReleaseSpeed   = 0.0
        //#pragma db not_null column("tail_length") //tail_length REAL NOT NULL ,--COMMENT '弹尾长(m)',
         addAmmoAllDatView.ammoData.ammoTailLength   = 0.0
        //#pragma db not_null column("lug_spacing") //lug_spacing REAL NOT NULL ,--COMMENT '弹耳间距(m)',
         addAmmoAllDatView.ammoData.ammoLugSpacing   = 0.0
        //#pragma db not_null column("killing_way") //-- 结构参数killing_way VARCHAR(50) ,--COMMENT '杀伤方式',
        addAmmoAllDatView.ammoData.ammoKillingWay   =  ""
        addAmmoAllDatView.ammoData.ammoPenetrationDepth   = 0.0//penetration_depth REAL NOT NULL ,--COMMENT '侵彻深度',
        addAmmoAllDatView.ammoData.ammoQuantitySoilThrown   = 0.0//quantity_soil_thrown REAL NOT NULL ,--COMMENT '抛土量',
        addAmmoAllDatView.ammoData.ammoCraterDiameter   = 0.0//  crater_diameter REAL NOT NULL ,--COMMENT '弹坑直径',
        addAmmoAllDatView.ammoData.ammoCraterDepth   = 0.0//  crater_depth REAL NOT NULL ,--COMMENT '弹坑深度',
        addAmmoAllDatView.ammoData.ammoDamagedArea   = 0.0//damaged_area REAL NOT NULL ,--COMMENT '破坏面积',
        //dense_killing_radius REAL NOT NULL ,--COMMENT '密集杀伤半径',
            addAmmoAllDatView.ammoData.ammoDenseKillingRadius   = 0.0
         //initial_velocity_fragments REAL NOT NULL ,--COMMENT '破片初速',
            addAmmoAllDatView.ammoData.ammoInitialVelocityFragments   = 0.0
        //number_fragments INT NOT NULL ,--COMMENT '破片数量',
            addAmmoAllDatView.ammoData.ammoNumberFragments   = 0
        //armor_breaking_ability VARCHAR(50) ,--COMMENT '破甲能力',
            addAmmoAllDatView.ammoData.ammoArmorBreakingAbility   = ""
        //bullet_density_range_minimum INT NOT NULL ,--COMMENT '子弹密度范围(最小)',
            addAmmoAllDatView.ammoData.bullet_density_range_minimum   = 0
         //bullet_density_range_maximum INT NOT NULL ,--COMMENT '子弹密度范围(最大)',
           addAmmoAllDatView.ammoData.bullet_density_range_maximum   = 0
         //ground_ignition_rate  REAL NOT NULL ,--COMMENT '对地发火率',
            addAmmoAllDatView.ammoData.ground_ignition_rate   = 0.0
        ////#pragma db not_null column("combustion_temperature") // combustion_temperature REAL NOT NULL ,--COMMENT '燃烧温度',
            addAmmoAllDatView.ammoData.combustion_temperature   = 0.0
        //#pragma db not_null column("combustion_time") //combustion_time REAL NOT NULL ,--COMMENT '燃烧时间',
            addAmmoAllDatView.ammoData.combustion_time   = 0.0
        //#pragma db not_null column("combustion_agent_spread_range")  //combustion_agent_spread_range REAL NOT NULL ,--COMMENT '烧剂散步范围',
            addAmmoAllDatView.ammoData.combustion_agent_spread_range   = 0.0
        //#pragma db not_null column("number_of_fragments")  //number_of_fragments INT NOT NULL ,--COMMENT '弹片数量',
            addAmmoAllDatView.ammoData.number_of_fragments   = 0
        //#pragma db not_null column("breakdown_distance") //breakdown_distance REAL NOT NULL ,--COMMENT '击穿距离',
            addAmmoAllDatView.ammoData.breakdown_distance   = 0.0
        //#pragma db not_null column("maximum_inclusive_coverage_quantity") //maximum_inclusive_coverage_quantity INT NOT NULL ,--COMMENT '最大包容覆盖数量',
            addAmmoAllDatView.ammoData.maximum_inclusive_coverage_quantity   = 0
        //#pragma db not_null column("number_of_spread")  //number_of_spread INT NOT NULL ,--COMMENT '散步数量',
            addAmmoAllDatView.ammoData.number_of_spread   = 0
        //#pragma db not_null column("surface_dc_resistivity") //surface_dc_resistivity REAL NOT NULL ,--COMMENT '表面直流电阻率',
            addAmmoAllDatView.ammoData.surface_dc_resistivity   = 0.0
        //#pragma db not_null column("probability_of_arc_discharge") //probability_of_arc_discharge REAL NOT NULL ,--COMMENT '引弧放电概率',
            addAmmoAllDatView.ammoData.probability_of_arc_discharge   = 0.0
        //#pragma db not_null column("fuel_dispersion_radius") //fuel_dispersion_radius  REAL NOT NULL ,--COMMENT '燃料分散半径',
            addAmmoAllDatView.ammoData.fuel_dispersion_radius   = 0.0
        //#pragma db not_null column("distance_from_center_explosion")  //distance_from_center_explosion REAL NOT NULL ,--COMMENT '距离爆心距离',
            addAmmoAllDatView.ammoData.distance_from_center_explosion   = 0.0
        //#pragma db not_null column("shock_wave_overpressure_value")  //shock_wave_overpressure_value REAL NOT NULL ,--COMMENT '冲击波超压值',
            addAmmoAllDatView.ammoData.shock_wave_overpressure_value   = 0.0
        //#pragma db not_null column("spread_area")  //-- 作战性能参数 spread_area REAL NOT NULL ,--COMMENT '散步面积',
            addAmmoAllDatView.ammoData.spread_area   = 0.0
        //#pragma db not_null column("use_description") //use_description TEXT ,--COMMENT '用途描述',
            addAmmoAllDatView.ammoData.use_description   = ""
        //#pragma db not_null column("interference_duration") //interference_duration REAL NOT NULL ,--COMMENT '干扰时长',
            addAmmoAllDatView.ammoData.interference_duration   = 0.0
        //#pragma db not_null column("interference_length_minimum") //Interference_length_minimum REAL NOT NULL ,--COMMENT '干扰长度(最小)',
            addAmmoAllDatView.ammoData.interference_length_minimum   = 0.0
        //#pragma db not_null column("interference_length_maximum")  //Interference_length_maximum REAL NOT NULL ,--COMMENT '干扰长度(最大)',
           addAmmoAllDatView.ammoData.interference_length_maximum   = 0.0
        //#pragma db not_null column("interference_width_minimum")  //interference_width_minimum REAL NOT NULL ,--COMMENT '干扰宽度(最小)',
            addAmmoAllDatView.ammoData.interference_width_minimum   = 0.0
        //#pragma db not_null column("interference_width_maximum")  //interference_width_maximum REAL NOT NULL ,--COMMENT '干扰宽度(最大)',
            addAmmoAllDatView.ammoData.interference_width_maximum   = 0.0
        //#pragma db not_null column("fuze_model") //fuze_model VARCHAR(50) ,--COMMENT '引信型号',
            addAmmoAllDatView.ammoData.fuze_model   = ""
        //#pragma db not_null column("number_of_fuses") //number_of_fuses INT NOT NULL ,--COMMENT '引信数量',
            addAmmoAllDatView.ammoData.number_of_fuses   = 0
        //#pragma db not_null column("storage_life") //storage_life REAL NOT NULL ,--COMMENT '储存寿命'
            addAmmoAllDatView.ammoData.storage_life   = 0.0

        //#pragma db not_null column("action_time") //action_time REAL NOT NULL ,--COMMENT '作用时间',
            addAmmoAllDatView.ammoData.action_time   = 0.0
        //#pragma db not_null column("available_extension_time") //available_extension_time REAL NOT NULL ,--COMMENT '可用延解时间',
            addAmmoAllDatView.ammoData.available_extension_time   = 0.0
        //#pragma db not_null column("rudder_width") //rudder_width REAL NOT NULL ,--COMMENT '舵宽',
            addAmmoAllDatView.ammoData.rudder_width   = 0.0
        //#pragma db not_null column("aerodynamic_configuration") //aerodynamic_configuration VARCHAR(50) ,--COMMENT '气动布局',
            addAmmoAllDatView.ammoData.aerodynamic_configuration   = ""
        //#pragma db not_null column("working_conditions")  //working_conditions  VARCHAR(50) ,--COMMENT '工作条件(白天/夜晚)(day/night)',
            addAmmoAllDatView.ammoData.working_conditions   = ""
        //#pragma db not_null column("working_temperature") //working_temperature REAL NOT NULL ,--COMMENT '工作环境温度',
            addAmmoAllDatView.ammoData.working_temperature   = 0.0
        //#pragma db not_null column("working_altitude") //working_altitude REAL NOT NULL ,--COMMENT '工作海拔高度',
            addAmmoAllDatView.ammoData.working_altitude   = 0.0
        //#pragma db not_null column("launch_way") //launch_way VARCHAR(50) ,--COMMENT '发射方式',
            addAmmoAllDatView.ammoData.launch_way   = ""

        //#pragma db not_null column("guidance_rule")  //guidance_rule VARCHAR(50) ,--COMMENT '导引规律',
            addAmmoAllDatView.ammoData.guidance_rule   = ""
        //#pragma db not_null column("minimum_visibility_emission") //minimum_visibility_emission REAL NOT NULL ,--COMMENT '发射最小能见度',
            addAmmoAllDatView.ammoData.minimum_visibility_emission   = 0.0
        //#pragma db not_null column("maximum_launch_altitude") //maximum_launch_altitude REAL NOT NULL ,--COMMENT '发射最大发射海拔高度',
            addAmmoAllDatView.ammoData.maximum_launch_altitude   = 0.0
        //#pragma db not_null column("launch_maximum_target_altitude") //launch_maximum_target_altitude REAL NOT NULL ,--COMMENT '发射最大目标海拔高度',
            addAmmoAllDatView.ammoData.launch_maximum_target_altitude   = 0.0
        //#pragma db not_null column("maximum_launch_relative_height") //maximum_launch_relative_height REAL NOT NULL ,--COMMENT '发射最大发射相对高度',
            addAmmoAllDatView.ammoData.maximum_launch_relative_height   = 0.0
        //#pragma db not_null column("minimum_relative_height_launch")  //minimum_relative_height_launch REAL NOT NULL ,--COMMENT '发射最小发射相对高度',
            addAmmoAllDatView.ammoData.minimum_relative_height_launch   = 0.0
        //#pragma db not_null column("launch_speed") //launch_speed REAL NOT NULL ,--COMMENT '发射速度',
            addAmmoAllDatView.ammoData.launch_speed   = 0.0
        //#pragma db not_null column("launch_conditions") //launch_conditions VARCHAR(50) ,--COMMENT '发射条件天气限制',
            addAmmoAllDatView.ammoData.launch_conditions   = ""
        //#pragma db not_null column("launch_off_axis_angle") //launch_off_axis_angle REAL NOT NULL ,--COMMENT '发射离轴角',
            addAmmoAllDatView.ammoData.launch_off_axis_angle   = 0.0
        //#pragma db not_null column("guidance_way") //guidance_way VARCHAR(50) ,--COMMENT '制导方式',
            addAmmoAllDatView.ammoData.guidance_way   = ""
        //#pragma db not_null column("effective_range") //effective_range REAL NOT NULL ,--COMMENT '射程',
            addAmmoAllDatView.ammoData.effective_range   = 0.0

        //#pragma db not_null column("hit_accuracy")  //hit_accuracy REAL NOT NULL ,--COMMENT '命中精度',
            addAmmoAllDatView.ammoData.hit_accuracy   = 0.0
        //#pragma db not_null column("hit_probability") // hit_probability REAL NOT NULL ,--COMMENT '命中概率',
            addAmmoAllDatView.ammoData.hit_probability   = 0.0
        //#pragma db not_null column("preparation_time") //preparation_time REAL NOT NULL ,--COMMENT '准备时间',
            addAmmoAllDatView.ammoData.preparation_time   = 0.0
        //#pragma db not_null column("allow_continuous_flight_time") //allow_continuous_flight_time REAL NOT NULL ,--COMMENT '允许连续载飞时间',
            addAmmoAllDatView.ammoData.allow_continuous_flight_time   = 0.0
        //#pragma db not_null column("guided_flight_time")  //guided_flight_time REAL NOT NULL ,--COMMENT '制导飞行时间',
            addAmmoAllDatView.ammoData.guided_flight_time   = 0.0
        //#pragma db not_null column("maximum_speed_of_missile")  //maximum_speed_of_missile REAL NOT NULL ,--COMMENT '导弹最大速度',
            addAmmoAllDatView.ammoData.maximum_speed_of_missile   = 0.0
        //#pragma db not_null column("guiding_head_working_wavelength")  //guiding_head_working_wavelength REAL NOT NULL ,--COMMENT '导引头工作波长(激光波长) (laser wavelength)',
            addAmmoAllDatView.ammoData.guiding_head_working_wavelength   = 0.0
        //#pragma db not_null column("guidance_head_operating_distance")  //guidance_head_operating_distance REAL NOT NULL ,--COMMENT '导引头作用距离',
            addAmmoAllDatView.ammoData.guidance_head_operating_distance   = 0.0
        //#pragma db not_null column("blind_spot_of_guidance_head")  //blind_spot_of_guidance_head REAL NOT NULL ,--COMMENT '导引头盲区',
            addAmmoAllDatView.ammoData.blind_spot_of_guidance_head   = 0.0
        //#pragma db not_null column("guidance_head_frame_angle")  //guidance_head_frame_angle REAL NOT NULL ,--COMMENT '导引头框架角',
            addAmmoAllDatView.ammoData.guidance_head_frame_angle   = 0.0
        //#pragma db not_null column("guidance_head_field_of_view_angle")  //guidance_head_field_of_view_angle REAL NOT NULL ,--COMMENT '导引头视场角',
            addAmmoAllDatView.ammoData.guidance_head_field_of_view_angle   = 0.0
            addAmmoAllDatView.ammoData.guidance_head_field_of_view_angle_linearregion   = 0.0 //线性区
            addAmmoAllDatView.ammoData.guidance_head_field_of_view_angle_instantaneous   = 0.0 //瞬时区


        //#pragma db not_null column("adaptability_of_guidance_head_sunlight")  //adaptability_of_guidance_head_sunlight VARCHAR(50) ,--COMMENT '导引头对太阳光的适应性',
            addAmmoAllDatView.ammoData.adaptability_of_guidance_head_sunlight   = ""
        //#pragma db not_null column("guidance_head_operating_frequency")  //guidance_head_operating_frequency REAL NOT NULL ,--COMMENT '导引头工作频率',
            addAmmoAllDatView.ammoData.guidance_head_operating_frequency   = 0.0
        //#pragma db not_null column("fuse_firing_rate") //fuse_firing_rate REAL NOT NULL ,--COMMENT '引信发火率',
            addAmmoAllDatView.ammoData.fuse_firing_rate   = 0.0
        //#pragma db not_null column("fuse_type") //fuse_type VARCHAR(50) ,--COMMENT '引信类型',
            addAmmoAllDatView.ammoData.fuse_type   = ""
        //#pragma db not_null column("fuse_length") //fuse_length REAL NOT NULL ,--COMMENT '引信长度',
            addAmmoAllDatView.ammoData.fuse_length   = 0.0
        //#pragma db not_null column("fuse_diameter")  //fuse_diameter REAL NOT NULL ,--COMMENT '引信直径',
            addAmmoAllDatView.ammoData.fuse_diameter   = 0.0
        //#pragma db not_null column("fuze_quality")  //fuze_quality REAL NOT NULL ,--COMMENT '引信质量',
            addAmmoAllDatView.ammoData.fuze_quality   = 0.0
        //#pragma db not_null column("safe_distance_of_fuse")  //safe_distance_of_fuse REAL NOT NULL ,--COMMENT '引信安全距离',
            addAmmoAllDatView.ammoData.safe_distance_of_fuse   = 0.0
        //#pragma db not_null column("time_disarming_fuse")  //time_disarming_fuse REAL NOT NULL ,--COMMENT '引信解除保险时间',
            addAmmoAllDatView.ammoData.time_disarming_fuse   = 0.0
        //#pragma db not_null column("first_level_release_time_of_fuse")  //first_level_release_time_of_fuse REAL NOT NULL ,--COMMENT '引信一级解除保险时间',
            addAmmoAllDatView.ammoData.first_level_release_time_of_fuse   = 0.0
        //#pragma db not_null column("secondary_release_time_of_fuse")  //secondary_release_time_of_fuse REAL NOT NULL ,--COMMENT '引信二级解除保险时间',
            addAmmoAllDatView.ammoData.secondary_release_time_of_fuse   = 0.0
        //#pragma db not_null column("reliability_rate_of_fuse_action")  //reliability_rate_of_fuse_action REAL NOT NULL ,--COMMENT '引信作用可靠率',
            addAmmoAllDatView.ammoData.reliability_rate_of_fuse_action   = 0.0
        //#pragma db not_null column("fuse_self_destruct_time")  //fuse_self_destruct_time REAL NOT NULL ,--COMMENT '引信自毁时间',
            addAmmoAllDatView.ammoData.fuse_self_destruct_time   = 0.0
        //#pragma db not_null column("combat_department_quality")  //combat_department_quality REAL NOT NULL ,--COMMENT '战斗部质量',
            addAmmoAllDatView.ammoData.combat_department_quality   = 0.0
        //#pragma db not_null column("combat_quantity")  //combat_quantity REAL NOT NULL ,--COMMENT '战斗部装药量',
            addAmmoAllDatView.ammoData.combat_quantity   = 0.0
        //#pragma db not_null column("combat_unit_type")  //combat_unit_type VARCHAR(50) ,--COMMENT '战斗部类型',
            addAmmoAllDatView.ammoData.combat_unit_type   = ""
        //#pragma db not_null column("combat_length")  //combat_length  REAL NOT NULL ,--COMMENT '战斗部长度',
            addAmmoAllDatView.ammoData.combat_length   = 0.0

        //#pragma db not_null column("combat_diameter")  //combat_diameter REAL NOT NULL ,--COMMENT '战斗部直径',
            addAmmoAllDatView.ammoData.combat_diameter   = 0.0
        //#pragma db not_null column("combat_main_charge_type")  //combat_main_charge_type VARCHAR(50) ,--COMMENT '战斗部主装药类型',
            addAmmoAllDatView.ammoData.combat_main_charge_type   = ""
        //#pragma db not_null column("combat_charge_density")  //combat_charge_density REAL NOT NULL ,--COMMENT '战斗部装药密度',
            addAmmoAllDatView.ammoData.combat_charge_density   = 0.0
        //#pragma db not_null column("combat_loading_factor")  //combat_loading_factor REAL NOT NULL ,--COMMENT '战斗部装填系数',
            addAmmoAllDatView.ammoData.combat_loading_factor   = 0.0
        //#pragma db not_null column("combat_explosive")  //combat_explosive REAL NOT NULL ,--COMMENT '战斗部扩爆药',
            addAmmoAllDatView.ammoData.combat_explosive   = 0.0
        //#pragma db not_null column("combat_fragments_number")  //combat_fragments_number INT NOT NULL ,--COMMENT '战斗部破片数量',
            addAmmoAllDatView.ammoData.combat_fragments_number   = 0
        //#pragma db not_null column("combat_unit_invasion_capability")  //combat_unit_invasion_capability VARCHAR(50) ,--COMMENT '战斗部侵袭能力',
            addAmmoAllDatView.ammoData.combat_unit_invasion_capability   = ""
        //#pragma db not_null column("combat_effective_killing_radius_vehicles")  //combat_effective_killing_radius_vehicles REAL NOT NULL ,--COMMENT '战斗部对车辆的有效杀伤半径',
            addAmmoAllDatView.ammoData.combat_effective_killing_radius_vehicles   = 0.0
        //#pragma db not_null column("combat_effective_killing_radius_personnel")   //combat_effective_killing_radius_personnel REAL NOT NULL ,--COMMENT '战斗部对人员的有效杀伤半径',
            addAmmoAllDatView.ammoData.combat_effective_killing_radius_personnel   = 0.0
        //#pragma db not_null column("combat_vertical_static_armor_penetration_depth")  //combat_vertical_static_armor_penetration_depth REAL NOT NULL ,--COMMENT '战斗部垂直静破甲深度',
            addAmmoAllDatView.ammoData.combat_vertical_static_armor_penetration_depth   = 0.0
        //#pragma db not_null column("combat_department_quality_add")  //combat_department_quality_add REAL NOT NULL ,--COMMENT '第二个战斗部质量',
            addAmmoAllDatView.ammoData.combat_department_quality_add   = 0.0
        //#pragma db not_null column("combat_quantity_add")  //combat_quantity_add REAL NOT NULL ,--COMMENT '第二个战斗部装药量',
            addAmmoAllDatView.ammoData.combat_quantity_add   = 0.0

        //#pragma db not_null column("combat_unit_type_add")  //combat_unit_type_add VARCHAR(50) ,--COMMENT '第二个战斗部类型',
            addAmmoAllDatView.ammoData.combat_unit_type_add   = ""
        //#pragma db not_null column("combat_length_add")  //combat_length_add  REAL NOT NULL ,--COMMENT '第二个战斗部长度',
            addAmmoAllDatView.ammoData.combat_length_add   = 0.0
        //#pragma db not_null column("combat_diameter_add")  //combat_diameter_add REAL NOT NULL ,--COMMENT '第二个战斗部直径',
            addAmmoAllDatView.ammoData.combat_diameter_add   = 0.0
        //#pragma db not_null column("combat_main_charge_type_add")  //combat_main_charge_type_add VARCHAR(50) ,--COMMENT '第二个战斗部主装药类型',
            addAmmoAllDatView.ammoData.combat_main_charge_type_add   = ""
        //#pragma db not_null column("combat_charge_density_add")  //combat_charge_density_add REAL NOT NULL ,--COMMENT '第二个战斗部装药密度',
            addAmmoAllDatView.ammoData.combat_charge_density_add   = 0.0
        //#pragma db not_null column("combat_loading_factor_add")  //combat_loading_factor_add REAL NOT NULL ,--COMMENT '第二个战斗部装填系数',
            addAmmoAllDatView.ammoData.combat_loading_factor_add   = 0.0
        //#pragma db not_null column("combat_explosive_add")  //combat_explosive_add REAL NOT NULL ,--COMMENT '第二个战斗部扩爆药',
            addAmmoAllDatView.ammoData.combat_explosive_add   = 0.0
        //#pragma db not_null column("combat_fragments_number_add")  //combat_fragments_number_add INT NOT NULL ,--COMMENT '第二个战斗部破片数量',
            addAmmoAllDatView.ammoData.combat_fragments_number_add   = 0
        //#pragma db not_null column("combat_unit_invasion_capability_add")  //combat_unit_invasion_capability_add VARCHAR(50) ,--COMMENT '第二个战斗部侵袭能力',
            addAmmoAllDatView.ammoData.combat_unit_invasion_capability_add   = ""
        //#pragma db not_null column("combat_effective_killing_radius_vehicles_add")  //combat_effective_killing_radius_vehicles_add REAL NOT NULL ,--COMMENT '第二个战斗部对车辆的有效杀伤半径',
            addAmmoAllDatView.ammoData.combat_effective_killing_radius_vehicles_add   = 0.0

        //#pragma db not_null column("combat_effective_killing_radius_personnel_add")  //combat_effective_killing_radius_personnel_add REAL NOT NULL ,--COMMENT '第二个战斗部对人员的有效杀伤半径',
            addAmmoAllDatView.ammoData.combat_effective_killing_radius_personnel_add   = 0.0
        //#pragma db not_null column("combat_vertical_static_armor_penetration_depth_add")  //combat_vertical_static_armor_penetration_depth_add REAL NOT NULL ,--COMMENT '第二个战斗部垂直静破甲深度',
            addAmmoAllDatView.ammoData.combat_vertical_static_armor_penetration_depth_add   = 0.0
        //#pragma db not_null column("service_life")  //service_life REAL NOT NULL ,--COMMENT '使用寿命',
            addAmmoAllDatView.ammoData.service_life   = 0.0
        //#pragma db not_null column("distance_between_center_mass_end")  //distance_between_center_mass_end REAL NOT NULL ,--COMMENT '质心距弹头端面距离',
            addAmmoAllDatView.ammoData.distance_between_center_mass_end   = 0.0
        //#pragma db not_null column("lifting_lug")  //lifting_lug VARCHAR(50) ,--COMMENT '吊耳',
            addAmmoAllDatView.ammoData.lifting_lug   = ""
        //#pragma db not_null column("distance_suspension_lifting_lug")  //distance_suspension_lifting_lug  REAL NOT NULL ,--COMMENT '吊耳间距',
            addAmmoAllDatView.ammoData.distance_suspension_lifting_lug   = 0.0
        //#pragma db not_null column("image_name")  //image_name VARCHAR(50) ,--COMMENT '图片名称',
            addAmmoAllDatView.ammoData.image_name   = ""
        //#pragma db not_null column("image_url")   //image_url VARCHAR(50) ,--COMMENT '图片路径',
            addAmmoAllDatView.ammoData.image_url   = ""
        //#pragma db not_null column("record_creation_time") type("timestamp(0)") options("DEFAULT CURRENT_TIMESTAMP") //record_creation_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ,--COMMENT '记录创建时间',
            addAmmoAllDatView.ammoData.record_creation_time = Qt.formatDateTime(new Date(), "yyyy-MM-dd HH:mm:ss")
        //#pragma db not_null column("use_status")  // use_status bool  --COMMENT '使用状态',
            addAmmoAllDatView.ammoData.use_status   = true

    }
    function saveAmmoData(){

         ammoData.ammoType = addAmmoAllDatView.viewType
         ammoData.ammoToUavModel =   addAmmoAllDatView.uavArray.join(",")
         console.log("ammoData.push"+JSON.stringify(ammoData))
          let result = ammoDaoModel.insertAmmoData(ammoData)
            if(result === true){
                warningItem.text = "^_^航弹新增数据成功!^_^"
                warningPopup.open()
                // 2秒后自动关闭
                autoCloseTimer.start()
            }else if(result === false){
                warningItem.text = "^_^航弹新增数据失败!^_^"
                warningPopup.open()
                // 2秒后自动关闭
                autoCloseTimer.start()
             }else{
                console.log("unknown deleteMountLocation")
            }
    }

    function loadAmmoComponentData(){
        addAmmo.selectType = 0;
       return true
    }
    function updateAmmoData(){  //函数不能大写开头
      return true
    }


}
