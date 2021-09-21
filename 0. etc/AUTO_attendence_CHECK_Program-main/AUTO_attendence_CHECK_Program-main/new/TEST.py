#!/usr/bin/env python
# coding: utf-8

# In[10]:


import schedule
import time

def notification():
    from plyer import notification
    if __name__ == "__main__":
        notification.notify(
        title = "쉬는시간입니다!",
        message = "10분간 몸과 뇌를 새로고침하세요",
        app_name = 'CAKD3',
        app_icon= r'C:/Workspace/CAKD3-Github/-Projects/Lazy_project/AUTO_attendence_CHECK_Program/clock_icon.ico',
        timeout = 5)
    return


def lunch():
    from plyer import notification
    if __name__ == "__main__":
        notification.notify(
        title = "점심시간입니다!",
        message = "14:00까지 식사하고 쉬고 오세요",
        app_name = 'CAKD3',
        app_icon= r'C:\Workspace\CAKD3-Github\-Projects\Lazy_project\AUTO_attendence_CHECK_Program\lunch.ico',
        timeout = 5)
    return


def check():
    from plyer import notification
    if __name__ == "__main__":
        notification.notify(
        title = "신호출결!",
        message = "신호출결할 시간입니다.",
        app_name = 'CAKD3',
        app_icon= r'C:\Workspace\CAKD3-Github\-Projects\Lazy_project\AUTO_attendence_CHECK_Program\check.ico',
        timeout = 5)
    return



def capture():
    from plyer import notification
    if __name__ == "__main__":
        notification.notify(
        title = "화면캡쳐!",
        message = "화면캡쳐할 시간입니다.",
        app_name = 'CAKD3',
        app_icon= r'C:\Workspace\CAKD3-Github\-Projects\Lazy_project\AUTO_attendence_CHECK_Program\capture.ico',
        timeout = 5)
    return


def QR():
    from PIL import Image
    if __name__ == '__main__':
        im = Image.open('C:\Workspace\CAKD3-Github\-Projects\Lazy_project\AUTO_attendence_CHECK_Program\qrcode.png')
        im.show()
        
        
        
        
def test():
    from plyer import notification
    if __name__ == "__main__":
        notification.notify(
        title = "테스트!",
        message = "테스트.",
#         app_name = 'CAKD3',
#         app_icon= r'C:\Workspace\CAKD3-Github\-Projects\Lazy_project\AUTO_attendence_CHECK_Program\capture.ico',
        timeout = 5)
        
# schedule.every(1).minutes.do(notification)
# while True:
#     schedule.run_pending()
#     time.sleep(30)


# In[11]:


test()


# In[3]:


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
schedule.every().day.at("12:00:00").do(capture)
schedule.every().day.at("14:00:00").do(capture)
schedule.every().day.at("16:00:00").do(capture)
schedule.every().day.at("17:00:00").do(capture)



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




#Test
schedule.every(10).seconds.do(test)

while True:
    schedule.run_pending()
    time.sleep(1)


# In[ ]:




