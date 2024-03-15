from PyQt5 import QtWidgets
import qt_PitynaUI
import pityna

class MainWindow(QtWidgets.QMainWindow):  
    def __init__(self):
        super().__init__()
        self.pityna = pityna.Pityna('pityna')
        self.action = True
        self.ui = qt_PitynaUI.Ui_MainWindow()
        self.ui.setupUi(self)
        
    def putlog(self, str):
        self.ui.listWidgetLog.addItem(str)

    def prompt(self):
        p = self.pityna.get_name()
        if self.action == True:
            p += '：' + self.pityna.get_responder_name()
        return p + '> '
      
    def buttonTalkSlot(self):
        value = self.ui.lineEdit.text()
        
        if not value:
            self.ui.labelResponce.setText('なに?')
        else:
            response = self.pityna.dialogue(value)
            self.ui.labelResponce.setText(response)
            self.putlog('> ' + value)
            self.putlog(self.prompt() + response)
            self.ui.lineEdit.clear()
            
    def closeEvent(self, event):
        reply = QtWidgets.QMessageBox.question(
                self,
                '確認', 
                "プログラムを終了しますか?",
                buttons = QtWidgets.QMessageBox.Yes |
                          QtWidgets.QMessageBox.No
                )

        if reply == QtWidgets.QMessageBox.Yes:           
             event.accept()
        else:           
            event.ignore()

    def showResponderName(self):
        self.action = True
            
    def hiddenResponderName(self):
        self.action = False

