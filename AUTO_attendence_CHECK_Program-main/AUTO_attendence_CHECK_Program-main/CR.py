#!/usr/bin/env python
# coding: utf-8

# In[1]:


import schedule
import time
import pyautogui
import tkinter as tk
from tkinter import filedialog
import os

def notification():
    from plyer import notification
    if __name__ == "__main__":
        notification.notify(
        title = "쉬는시간입니다!",
        message = "10분간 몸과 뇌를 새로고침하세요",
        app_name = 'CAKD3',
        app_icon= 'clock_icon.ico',
        timeout = 5)
    return


def lunch():
    from plyer import notification
    if __name__ == "__main__":
        notification.notify(
        title = "점심시간입니다!",
        message = "14:00까지 식사하고 쉬고 오세요",
        app_name = 'CAKD3',
        app_icon= 'lunch.ico',
        timeout = 5)
    return


def check():
    from plyer import notification
    if __name__ == "__main__":
        notification.notify(
        title = "신호출결!",
        message = "신호출결할 시간입니다.",
        app_name = 'CAKD3',
        app_icon= 'check.ico',
        timeout = 5)
    return



def capture():
    from plyer import notification
    if __name__ == "__main__":
        notification.notify(
        title = "화면캡쳐!",
        message = "화면캡쳐할 시간입니다.",
        app_name = 'CAKD3',
        app_icon= 'capture.ico',
        timeout = 5)
    return






def tkinter():
    if __name__ == '__main__':
        root = tk.Tk()
        root.geometry("210x50+850+950")
        canvas1 = tk.Canvas(root,width=210,height=50)

        canvas1.pack()

        def takeScreenshot():
            myScreenshot = pyautogui.screenshot()

            file_path = filedialog.asksaveasfilename(initialdir='C:/workspace/',defaultextension='.png')
        #     file_path = filedialog.asksaveasfilename(initialdir='C:/workspace/', title='Save File', filetypes=(('png Files', 'png.*'), ('All Files', '*.*')))

            myScreenshot.save(file_path)

        myButton = tk.Button(text="캡처저장",command=takeScreenshot,bg='skyblue',fg='blue',font=10)

        canvas1.create_window(50,20,window=myButton)

        def open_folder():
            os.startfile('C:/workspace/')
            import webbrowser

            webbrowser.open_new_tab("https://drive.google.com/drive/folders/1SgyRIMz4sqFhLcaGUY9RF04eNpTtlCKC")



        myButton1 = tk.Button(text="저장폴더열기",command=open_folder,bg='green',fg='blue',font=10)    
        canvas1.create_window(150,20,window=myButton1)    


        root.mainloop()



def QR():
    from PIL import Image
    if __name__ == '__main__':
        im = Image.open('qrcode.png')
        im.show()
        
    


# In[ ]:


#QR
schedule.every().day.at("08:50:00").do(QR)
schedule.every().day.at("17:50:00").do(QR)

#check
schedule.every().day.at("09:59:57").do(check)
schedule.every().day.at("14:59:57").do(check)

#lunch
schedule.every().day.at("12:49:55").do(lunch)


#capture
schedule.every().day.at("11:00:00").do(capture)
schedule.every().day.at("11:00:00").do(tkinter)

schedule.every().day.at("12:00:00").do(capture)
schedule.every().day.at("12:00:00").do(tkinter)

schedule.every().day.at("14:00:00").do(capture)
schedule.every().day.at("14:00:00").do(tkinter)

schedule.every().day.at("16:00:00").do(capture)
schedule.every().day.at("16:00:00").do(tkinter)

schedule.every().day.at("17:00:00").do(capture)
schedule.every().day.at("17:00:00").do(tkinter)





#notification

#imported QR
schedule.every().day.at("09:49:57").do(notification)
#imported check
schedule.every().day.at("10:49:57").do(notification)
#imported capture 
schedule.every().day.at("11:49:57").do(notification)
#imported capture 

#imported lunch

#imported capture 
schedule.every().day.at("14:49:57").do(notification)
schedule.every().day.at("15:49:57").do(notification)
#imported capture 
schedule.every().day.at("16:49:57").do(notification)
#imported capture 


while True:
    schedule.run_pending()
    time.sleep(1)


# In[10]:


get_ipython().system('pip install tkinter')

