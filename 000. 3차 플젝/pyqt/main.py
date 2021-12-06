from typing import Counter
from PyQt5 import QtCore, QtGui, QtWidgets, uic
from PyQt5.QtCore import QDateTime
from PyQt5.QtWidgets import QLabel, QFileDialog, QMessageBox, QDialog, QFrame
from PyQt5.uic import loadUi


form_secondwindow =uic.loadUiType("page1.ui")[0]
global counter
counter = 31
class Ui_main(object):
    def setupUi(self, main):
        main.setObjectName("main")
        main.resize(1200, 900)
        icon = QtGui.QIcon()
        icon.addPixmap(QtGui.QPixmap("img/icon.png"), QtGui.QIcon.Normal, QtGui.QIcon.Off)
        main.setWindowIcon(icon)
        main.setStyleSheet("background-color: rgb(183, 207, 229); border-radius: 30px;")
        self.main_frame = QtWidgets.QFrame(main)
        self.main_frame.setGeometry(QtCore.QRect(10, 10, 1181, 881))
        self.main_frame.setStyleSheet("background-color: rgb(48, 75, 173);")
        self.main_frame.setFrameShape(QtWidgets.QFrame.StyledPanel)
        self.main_frame.setFrameShadow(QtWidgets.QFrame.Raised)
        self.main_frame.setObjectName("main_frame")
        self.title = QtWidgets.QLabel(self.main_frame)
        self.title.setGeometry(QtCore.QRect(100, 520, 1001, 261))
        font = QtGui.QFont()
        font.setFamily("Adobe 고딕 Std B")
        font.setPointSize(48)
        font.setBold(True)
        font.setWeight(75)
        self.title.setFont(font)
        self.title.setStyleSheet("color: rgb(255, 255, 255);")
        self.title.setAlignment(QtCore.Qt.AlignCenter)
        self.title.setObjectName("title")
        self.icon_img = QtWidgets.QLabel(self.main_frame)
        self.icon_img.setGeometry(QtCore.QRect(340, 80, 500, 500))
        self.icon_img.setStyleSheet("background-image: url('img/icon.png');")
        self.icon_img.setText("")
        self.icon_img.setObjectName("icon_img")
        self.progressBar = QtWidgets.QProgressBar(self.main_frame)
        self.progressBar.setGeometry(QtCore.QRect(350, 720, 500, 30))
        self.progressBar.setLayoutDirection(QtCore.Qt.LeftToRight)
        self.progressBar.setStyleSheet("QProgressBar{\n"
"    background-color: rgb(98, 114, 164);\n"
"    color:rgb(200,200,200);\n"
"    border-style: none;\n"
"    border-bottom-right-radius: 10px;\n"
"    border-bottom-left-radius: 10px;\n"
"    border-top-right-radius: 10px;\n"
"    border-top-left-radius: 10px;\n"
"    text-align: center;\n"
"}\n"
"QProgressBar::chunk{\n"
"    border-bottom-right-radius: 10px;\n"
"    border-bottom-left-radius: 10px;\n"
"    border-top-right-radius: 10px;\n"
"    border-top-left-radius: 10px;\n"
"    background-color: qlineargradient(spread:pad, x1:0, y1:0.511364, x2:1, y2:0.523, stop:0 rgba(254, 121, 199, 255), stop:1 rgba(170, 85, 255, 255));\n"
"}\n"
"\n"
"")
        self.progressBar.setProperty("value", 30)
        self.progressBar.setAlignment(QtCore.Qt.AlignCenter)
        self.progressBar.setTextVisible(True)
        self.progressBar.setInvertedAppearance(False)
        self.progressBar.setTextDirection(QtWidgets.QProgressBar.TopToBottom)
        self.progressBar.setObjectName("progressBar")
        self.loading = QtWidgets.QLabel(self.main_frame)
        self.loading.setGeometry(QtCore.QRect(540, 752, 111, 20))
        self.loading.setStyleSheet("color: rgb(200, 200, 200);")
        self.loading.setAlignment(QtCore.Qt.AlignCenter)
        self.loading.setObjectName("loading")

        # Timer---------------------------------
        self.timer = QtCore.QTimer()

        self.retranslateUi(main)
        QtCore.QMetaObject.connectSlotsByName(main)

    def retranslateUi(self, main):
        _translate = QtCore.QCoreApplication.translate
        main.setWindowTitle(_translate("main", "PDR"))
        self.title.setText(_translate("main", "Pulmonary Disease Reader"))
        self.loading.setText(_translate("main", "    loading..."))
        main.show()
        self.timer.start(34)
        self.timer.timeout.connect(self.progress)

        # 모델 넣는자리
        # import tensorflow.keras as tf

        # tjnet_path = './weight/tjnet24.h5'

        # global tjnet
        # tjnet = tf.models.load_model(tjnet_path, compile=False)

    def progress(self):
        # set value to progress bar
        global counter      
        self.progressBar.setProperty("value", counter)

        if counter > 100:
            #stop timer
            self.timer.stop()
            main.close()
            widget.show()

        counter +=1

        return counter

#--------------------------------------------------------------------------------------

class page1(QDialog, QFrame, form_secondwindow):
    def __init__(self):
        super(page1, self).__init__()
        loadUi("page1.ui", self)

        self.time.setDateTime(QDateTime.currentDateTime())
        self.image_frame = QLabel(self)
        self.progressBar_page1.setProperty("value", 0)

             # 이미지 불러오기
    def filedialog_open(self):
        global fname
        fname = QFileDialog.getOpenFileName(self, 'Open File', '',
                                            'All File(*);; Image File(*.png *.jpg)')
        if fname[0]:
            # QPixmap 객체
            global openpath
            openpath = fname[0]
            self.pixmap = QtGui.QPixmap(openpath)            
            self.pixmap = self.pixmap.scaled(481,621) # 이미지 스케일 변화
            self.image_frame.move(80,70) # 시작위치
            self.image_frame.setPixmap(self.pixmap)  # 이미지 세팅
            self.image_frame.setContentsMargins(0,0,0,0)
            self.image_frame.resize(550,640)  # 프레임 스케일

            global pred_txt
            pred_txt= "예측값"
            self.input_pred()

        else:
            QMessageBox.about(self, 'Warning', 'No file selected.')


    def input_pred(self):
        self.pred.setText(pred_txt)

      
    def show_exit(self):
        sys.exit(app.exec_())
              

if __name__ == "__main__":
    import sys
    app = QtWidgets.QApplication(sys.argv)
    main = QtWidgets.QWidget()
    ui = Ui_main()

    ui.setupUi(main)
    
    
    # 화면전환용 위젯 생성
    widget = QtWidgets.QStackedWidget()
    # 레이아웃 인스턴스 생성
    se = page1()
    
    # 위젯 추가
    widget.addWidget(se)

    # 프로그램 화면
    widget.setFixedHeight(900)
    widget.setFixedWidth(1200)
    
    widget.setWindowTitle('PDR')
    widget.setWindowIcon(QtGui.QIcon('img/icon.png'))

    sys.exit(app.exec_())
