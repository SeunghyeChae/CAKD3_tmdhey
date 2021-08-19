#!/usr/bin/env python
# coding: utf-8

# In[2]:


import schedule
import time

def notification():
    from plyer import notification
    if __name__ == "__main__":
        notification.notify(
        title = "쉬는시간입니다!",
        message = "10분간 몸과 뇌를 새로고침하세요",
        app_name = 'CAKD3',
        app_icon= r'C:\Workspace\CAKD3-Github\-Projects\Lazy_project\AUTO_attendence_CHECK_Program\clock_icon.ico',
        timeout = 5)
    return

schedule.every().day.at("09:50").do(notification)
schedule.every().day.at("10:50").do(notification)
schedule.every().day.at("11:50").do(notification)
schedule.every().day.at("13:50").do(notification)
schedule.every().day.at("14:50").do(notification)
schedule.every().day.at("15:50").do(notification)
schedule.every().day.at("16:50").do(notification)
while True:
    schedule.run_pending()
    time.sleep(1)


# In[ ]:




