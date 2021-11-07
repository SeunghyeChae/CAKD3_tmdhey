print('Loadding')

import bone 
import numpy as np
import sys
import matplotlib.pyplot as plt
from sklearn.linear_model import LinearRegression
import glob
import math
from datetime import datetime
import cv2
import re
import torch
import os
import tensorflow.keras as tf
# path ----------------------------------------------------------------------
os.chdir('yolov5')

model_path = 'ui/model.pt'
tjnet_path = 'ui/tjnet24.h5'

# tjnet = tf.models.load_model(tjnet_path, compile=False)
yolo = torch.load(model_path, map_location='cpu')

while True:
    try:
        path = input("경로를 입력하세요. (exit : 종료) > ")
        if path == 'exit':
            sys.exit()
        gender = input("성별을 입력하세요. Female : 0, Male : 1 > ")
        if gender != 1 or gender

        now = datetime.now()
        formattedDate = now.strftime("%Y%m%d_%H%M%S")
        filename = formattedDate +'.jpg'
        save_path = './img_save/' + filename

        original_img = bone.read_img(path)
        mask = bone.make_mask(original_img)
        masked = bone.cut_mask(original_img, mask)
        rotated_img = bone.img_rotation(masked)
        bone_img = bone.Decomposing(rotated_img,60,55,50,25)
        # cv2.rectangle(bone_img, 
        #     (400,620),
        #     (540,660),
        #     (0,0,255),
        #     thickness=2, 
        #     lineType=cv2.LINE_AA) 
        # cv2.imshow('bone_img',bone_img)
        # cv2.waitKey()

        cv2.imwrite(save_path, bone_img)
        crops, img, result = bone.yolo_crop_img(save_path, yolo) 
        X = bone.out_crop_img(crops, gender) 
        # prediction_BA = bone.predict_zscore(X , gender, save_path, tjnet)

        # ------------------------------------------------------------
        # 이미지 예측값 넣고 띄우기
        cv2.rectangle(img, 
            (400,620),
            (540,660),
            (0,0,255),
            thickness=2, 
            lineType=cv2.LINE_AA) 
        
        cv2.putText(img,
            "prediction_BA",
            (410,625),
            cv2.FONT_HERSHEY_SIMPLEX,
            1,
            (1,255,0),
            2)

        cv2.imshow('bone_img', img)
        cv2.waitKey()
        # print('예측 골연령 : ' ,prediction_BA)
        # cv2.destroyWindow('bone_img')

        while True:
            stop = input("종료하시겠습니까 [y/n]. > ")
            if stop == 'y':
                sys.exit()
            elif stop == 'n':
                print('처음부터 다시 시작합니다.')
                break
            else:
                print('입력이 잘못되었습니다. 다시 입력해 주세요.')
                continue
                
            
    except Exception as e : 
        print('error', e)
        print('fixed error and try again')