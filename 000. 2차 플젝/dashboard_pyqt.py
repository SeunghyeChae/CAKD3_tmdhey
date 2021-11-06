# -*- coding: utf-8 -*-

# Form implementation generated from reading ui file 'dashboard_pyqt.ui'
#
# Created by: PyQt5 UI code generator 5.9.2
#
# WARNING! All changes made in this file will be lost!

from PyQt5 import QtCore, QtGui, QtWidgets

class Ui_Dialog(object):
    def setupUi(self, Dialog):
        Dialog.setObjectName("Dialog")
        Dialog.resize(1054, 796)
        icon = QtGui.QIcon()
        icon.addPixmap(QtGui.QPixmap("hand_bone_sh.png"), QtGui.QIcon.Normal, QtGui.QIcon.Off)
        Dialog.setWindowIcon(icon)
        Dialog.setStyleSheet("background-color:rgb(31, 31, 31)")
        self.img_button = QtWidgets.QPushButton(Dialog)
        self.img_button.setGeometry(QtCore.QRect(30, 670, 141, 61))
        font = QtGui.QFont()
        font.setFamily("Arial")
        font.setPointSize(11)
        self.img_button.setFont(font)
        self.img_button.setStyleSheet("background-color: rgb(236, 236, 236);\n"
"border:none;\n"
"border-bottom: 2px solid rgb(35, 35, 35);\n"
"color: rgb(50, 50, 50);\n"
"border-bottom-right-radius: 8px;\n"
"border-bottom-left-radius: 8px;\n"
"border-top-right-radius: 8px;\n"
"border-top-left-radius: 8px;\n"
"\n"
"QPushButton#pushButton:pressed{\n"
"    padding-left:5px;\n"
"    padding-top:5px;\n"
"    background-color: rgb(194, 194, 194);\n"
"}")
        self.img_button.setObjectName("img_button")
        self.input_info = QtWidgets.QLabel(Dialog)
        self.input_info.setGeometry(QtCore.QRect(560, 130, 331, 371))
        self.input_info.setStyleSheet("background-color: rgb(255, 255, 255);\n"
"border-bottom-right-radius: 30px;\n"
"border-bottom-left-radius: 30px;\n"
"border-top-right-radius: 30px;\n"
"border-top-left-radius: 30px;")
        self.input_info.setText("")
        self.input_info.setObjectName("input_info")
        self.label = QtWidgets.QLabel(Dialog)
        self.label.setGeometry(QtCore.QRect(690, 140, 61, 41))
        font = QtGui.QFont()
        font.setFamily("Arial")
        font.setPointSize(18)
        self.label.setFont(font)
        self.label.setStyleSheet("background-color:rgb(255, 255, 255);\n"
"color: rgb(42, 42, 42)")
        self.label.setObjectName("label")
        self.input_name = QtWidgets.QLineEdit(Dialog)
        self.input_name.setGeometry(QtCore.QRect(580, 210, 280, 50))
        font = QtGui.QFont()
        font.setFamily("Arial")
        font.setPointSize(11)
        self.input_name.setFont(font)
        self.input_name.setStyleSheet("background-color: rgb(255, 255, 255);\n"
"border:none;\n"
"border-bottom: 2px solid rgb(35, 35, 35);\n"
"color: rgb(124, 124, 124);\n"
"padding-bottom: 7px;")
        self.input_name.setObjectName("input_name")
        self.input_age = QtWidgets.QLineEdit(Dialog)
        self.input_age.setGeometry(QtCore.QRect(580, 280, 280, 50))
        font = QtGui.QFont()
        font.setFamily("Arial")
        font.setPointSize(11)
        self.input_age.setFont(font)
        self.input_age.setStyleSheet("background-color: rgb(255, 255, 255);\n"
"border:none;\n"
"border-bottom: 2px solid rgb(35, 35, 35);\n"
"color: rgb(124, 124, 124);\n"
"padding-bottom: 7px;")
        self.input_age.setObjectName("input_age")
        self.input_height = QtWidgets.QLineEdit(Dialog)
        self.input_height.setGeometry(QtCore.QRect(580, 350, 280, 50))
        font = QtGui.QFont()
        font.setFamily("Arial")
        font.setPointSize(11)
        self.input_height.setFont(font)
        self.input_height.setStyleSheet("background-color: rgb(255, 255, 255);\n"
"border:none;\n"
"border-bottom: 2px solid rgb(35, 35, 35);\n"
"color: rgb(124, 124, 124);\n"
"padding-bottom: 7px;")
        self.input_height.setObjectName("input_height")
        self.pushButton = QtWidgets.QPushButton(Dialog)
        self.pushButton.setGeometry(QtCore.QRect(670, 430, 111, 41))
        font = QtGui.QFont()
        font.setFamily("Arial")
        font.setPointSize(11)
        self.pushButton.setFont(font)
        self.pushButton.setStyleSheet("background-color: rgb(42, 42, 42);\n"
"border:none;\n"
"border-bottom: 2px solid rgb(35, 35, 35);\n"
"color: rgb(214, 214, 214);\n"
"border-bottom-right-radius: 5px;\n"
"border-bottom-left-radius: 5px;\n"
"border-top-right-radius: 5px;\n"
"border-top-left-radius: 5px;\n"
"\n"
"QPushButton#pushButton:pressed{\n"
"    padding-left:5px;\n"
"    padding-top:5px;\n"
"    background-color: rgb(194, 194, 194);\n"
"}")
        self.pushButton.setObjectName("pushButton")
        self.image_frame = QtWidgets.QGraphicsView(Dialog)
        self.image_frame.setGeometry(QtCore.QRect(30, 30, 481, 621))
        self.image_frame.setStyleSheet("background-color : rgb(250, 250, 250)")
        self.image_frame.setObjectName("image_frame")
        self.next_button = QtWidgets.QPushButton(Dialog)
        self.next_button.setGeometry(QtCore.QRect(870, 690, 141, 61))
        font = QtGui.QFont()
        font.setFamily("Arial")
        font.setPointSize(11)
        self.next_button.setFont(font)
        self.next_button.setStyleSheet("background-color: rgb(236, 236, 236);\n"
"border:none;\n"
"border-bottom: 2px solid rgb(35, 35, 35);\n"
"color: rgb(50, 50, 50);\n"
"border-bottom-right-radius: 8px;\n"
"border-bottom-left-radius: 8px;\n"
"border-top-right-radius: 8px;\n"
"border-top-left-radius: 8px;\n"
"\n"
"QPushButton#pushButton:pressed{\n"
"    padding-left:5px;\n"
"    padding-top:5px;\n"
"    background-color: rgb(194, 194, 194);\n"
"}")
        self.next_button.setObjectName("next_button")

        self.retranslateUi(Dialog)
        QtCore.QMetaObject.connectSlotsByName(Dialog)

    def retranslateUi(self, Dialog):
        _translate = QtCore.QCoreApplication.translate
        Dialog.setWindowTitle(_translate("Dialog", "Bone Age"))
        self.img_button.setText(_translate("Dialog", "select"))
        self.label.setText(_translate("Dialog", "Info"))
        self.input_name.setPlaceholderText(_translate("Dialog", "Name"))
        self.input_age.setPlaceholderText(_translate("Dialog", "Age"))
        self.input_height.setPlaceholderText(_translate("Dialog", "Height"))
        self.pushButton.setText(_translate("Dialog", "o k"))
        self.next_button.setText(_translate("Dialog", "NEXT >>"))


if __name__ == "__main__":
    import sys
    app = QtWidgets.QApplication(sys.argv)
    Dialog = QtWidgets.QDialog()
    ui = Ui_Dialog()
    ui.setupUi(Dialog)
    Dialog.show()
    sys.exit(app.exec_())

