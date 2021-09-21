#!/usr/bin/env python
# coding: utf-8

# In[1]:


import time 
from plyer import notification
if __name__ == "__main__":
    while True:
        notification.notify(
            title = "쉬는시간입니다!",
            message = "10분간 몸과 뇌를 새로고침하세요",
            app_icon= r'C:\clock.ico',
            timeout = 5
        )
        time.sleep(30)


# In[ ]:




