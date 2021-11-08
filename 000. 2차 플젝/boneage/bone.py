# 모듈 import
import numpy as np
import cv2
import matplotlib.pyplot as plt
from sklearn.linear_model import LinearRegression
import glob
import math
import re

#-----------------------------------------------------------------------------------
# read_img(path) -> original_img
# make_mask(original_img) -> mask
# cut_mask(original_img, mask) -> masked
# img_rotation(masked) ->rotated_img

# ---- morphology_value_1, morphology_value_2, filter_value(a,b)
# Decomposing(rotated_img,a,b,d,e) -> bone_extraction 
#-----------------------------------------------------------------------------------

# 이미지 경로에서 불러오기.
def read_img(path):
    original_img = cv2.imread(path)
    return original_img


# 원본 이미지를 넣어서 마스크 만드는 함수.
########## Making mask for removing background #############
def make_mask(original_img):
    ## change to lab for making mask
    img_mask = original_img.copy()
    img_mask = cv2.cvtColor(img_mask, cv2.COLOR_RGB2BGR)
    img_mask = cv2.cvtColor(img_mask, cv2.COLOR_BGR2Lab)
    
    ## blur _02 
    # kernel_size = odds / value = img.mean()


    blur_k = int((img_mask.mean()*0.5)//2)*2+1
    img_mask = cv2.medianBlur(img_mask, blur_k)
    
    ## change to Grayscale for threshold

    img_mask = cv2.cvtColor(img_mask, cv2.COLOR_Lab2BGR)
    img_mask = cv2.cvtColor(img_mask, cv2.COLOR_BGR2GRAY)

    ## binary / value = img.mean()

    if img_mask.mean() > 100 : 
      th = img_mask.mean()*0.94
    else : 
      th = img_mask.mean()

    ret, img_mask = cv2.threshold(img_mask, th, 255, cv2.THRESH_BINARY)

    ## mask based Max value of contours

    contours, hierarchy = cv2.findContours(img_mask, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)
    max_cnt = max(contours, key=cv2.contourArea)
    mask = np.zeros(img_mask.shape, dtype=np.uint8)
    cv2.drawContours(mask, [max_cnt], -1, (255,255,255), -1)
    
    ## Applying for dilation

    k = cv2.getStructuringElement(cv2.MORPH_RECT, (8,8))
    mask = cv2.dilate(mask,k)
    return mask


# 마스크를 이용하여 원본이미지의 배경을 자르는 함수.
######## background cut based mask ##########
def cut_mask(original_img, mask):

    ## copying
    img_for_cut = original_img.copy()

    ## H/W
    height, width = img_for_cut.shape[:2]

    ## mask
    mask_list = mask.tolist()
    
    for y in range(int(height*0.05),height):
        if max(mask[y,int(width*0.3):int(width*0.7)]) > 0:
            start_y = y-int(height*0.05)
            break
            
    for x in range(int(width*0.05),width):
        if max(mask[int(height*0.3):int(height*0.7),x]) > 0:
            start_x = x-int(width*0.05)
            break
            
    for x in range(int(width*0.95),-1,-1):
        if max(mask[int(height*0.3):int(height*0.7),x]) > 0:
            end_x = x+int(width*0.05)
            break
            
    cut_index = 0
    if mask_list[height-1][-1] == 255 or mask_list[height-1][0] == 255:
        for n in reversed(range(height)):
            if mask_list[n][0] == 0 or mask_list[n][-1] == 0:
                cut_index = n
                break
                
    if cut_index == 0:
        cut_index = height

    ## converting color
    img_for_cut = cv2.cvtColor(img_for_cut, cv2.COLOR_BGR2GRAY) 

    img_for_cut = img_for_cut[start_y:(cut_index-1),start_x:end_x]
    mask = mask[start_y:(cut_index-1),start_x:end_x]

    ## remove background
    masked = cv2.bitwise_and(img_for_cut, mask)

    return masked


# 마스크씌어진 이미지를 회전시키는 함수.
######## Rotation ########
def img_rotation(masked):
    ## copying img
    before_rot_img = masked.copy()

    
    h, w = before_rot_img.shape[:2]
    before_rot_img = cv2.cvtColor(before_rot_img, cv2.COLOR_RGB2BGR)
    gray = cv2.cvtColor(before_rot_img, cv2.COLOR_BGR2GRAY)
    ret, th = cv2.threshold(gray, 10, 255, cv2.THRESH_BINARY)
    th_li = th.tolist()

    ## Rotation stage 01
    # lower = first black spot

    for i in reversed(range(h)):
        if th_li[i][0] == 0 and th_li[i][-1] == 0:
            lower = i
            break

    # lower = condition ; bottom = lower / img * 0.95

    if lower == h - 1:
        lower = int(h*0.9)

    # upper = condition ; lower + lower * 0.05

    slice5 = int(len(th)*0.05)
    upper = lower - slice5

    # x, y = between upper and lower (5%) / wrist center

    x,y = [],[]
    for i in range(slice5):
        cnt = th_li[i + upper].count(255)
        index = th_li[i + upper].index(255)
        x.append([i+upper])
        y.append([int((index*2 + cnt - 1)/2)])

    # x, y / draw regression line

    model = LinearRegression()
    model.fit(X=x,y=y)

    ####################################################

    ## Rotation stage 02
    angle = math.atan2(h - 0, int(model.predict([[h]])) - int(model.predict([[0]])))*180/math.pi
    M = cv2.getRotationMatrix2D((w/2,h/2), angle-90, 1)
    rotate = cv2.warpAffine(before_rot_img, M, (w, h))

    # Cutting img (rotated img)

    for i in range(len(th[-1])):
        if th[-1][i] == 255:
            start_x = i
            break

    for i in range(len(th[-1])):
        if th[-1][i] == 255:
            end_x = i
            

    s_point = h - int((int(model.predict([[h]])-start_x)) * math.tan(math.pi*((90-angle)/180)))
    e_point = h - int((end_x - int(model.predict([[h]]))) * math.tan(math.pi*((angle-90)/180)))
    point = max(s_point, e_point)
    rotated_img = rotate[:point]
    return rotated_img



# 이미지 발기조절, 대비, 필터링 작업으로 뼈 추출하는 함수
### img, morphology_value_1, morphology_value_2, filter_value(a,b)
def Decomposing(rotated_img,a,b,d,e):

    ######## Decomposing_stage_1 / [ Contours , Mask ] ########
    decomp_img_1 = rotated_img.copy()

    ## Adjusting brighness
    d_img1 = decomp_img_1.copy()
    cols, rows = d_img1.shape[:2]
    brightness1 = np.sum(d_img1) / (255 * cols * rows)

    if brightness1 > 0.8:
        decomp_img_1 = np.clip(decomp_img_1 - 80., 0, 255).astype(np.uint8)
    elif brightness1 > 0.75:
        decomp_img_1 = np.clip(decomp_img_1 - 50., 0, 255).astype(np.uint8)
    elif brightness1 > 0.65:
        decomp_img_1 = np.clip(decomp_img_1 - 30., 0, 255).astype(np.uint8)
    else: decomp_img_1 = np.clip(decomp_img_1 - 10., 0, 255).astype(np.uint8)


    ## change to Lab
    decomp_img_1 = cv2.cvtColor(decomp_img_1, cv2.COLOR_RGB2BGR)
    decomp_img_1 = cv2.cvtColor(decomp_img_1, cv2.COLOR_BGR2Lab)

    ## Morphology
    k = cv2.getStructuringElement(cv2.MORPH_CROSS, (a, a))
    decomp_img_1 = cv2.morphologyEx(decomp_img_1, cv2.MORPH_TOPHAT, k) # Emphasis

    ## Filter
    decomp_img_1 = cv2.bilateralFilter(decomp_img_1,-1, d, e)

    ## Lab to gray for binary
    decomp_img_1 = cv2.cvtColor(decomp_img_1, cv2.COLOR_Lab2BGR)
    decomp_img_1 = cv2.cvtColor(decomp_img_1, cv2.COLOR_BGR2GRAY)

    ## img_normalization
    decomp_img_1 = cv2.normalize(decomp_img_1, None, 0, 255, cv2.NORM_MINMAX)

    ## CLAHE
    decomp_img_1 = cv2.equalizeHist(decomp_img_1)
    clahe = cv2.createCLAHE(clipLimit=1.0, tileGridSize=(3,3)) 
    decomp_img_1= clahe.apply(decomp_img_1)          


    ## Threshold / value = img.mean()
    ret, mask = cv2.threshold(decomp_img_1,
                            np.mean(decomp_img_1),
                            255,
                            cv2.THRESH_BINARY) 

    ## Extract object / same value pixels

    contours, hierarchy = cv2.findContours(mask, 
                                            cv2.RETR_EXTERNAL, # only outline
                                            cv2.CHAIN_APPROX_SIMPLE) # Contour vertex coordinate

    ## drawing Contours
    cv2.drawContours(mask, contours, -1, (255,255,255), -1) # -1: 모든 컨트어 표시 /color/ fill


        
    ######## Decomposing_stage_2 / [ Brightness_Empahsis ] ########
    decomp_img_2 = rotated_img.copy()

    ## Brightness_Empahsis
    d_img2 = decomp_img_2.copy()
    cols, rows = d_img2.shape[:2]
    brightness2 = np.sum(d_img2) / (255 * cols * rows)

    ## Empahsis
    if brightness2 > 0.8:
        decomp_img_2 = np.clip(decomp_img_2 - 80., 0, 255).astype(np.uint8)
    elif brightness2 > 0.75:
        decomp_img_2 = np.clip(decomp_img_2 - 50., 0, 255).astype(np.uint8)
    elif brightness2 > 0.65:
        decomp_img_2 = np.clip(decomp_img_2 - 30., 0, 255).astype(np.uint8)
    else: decomp_img_2 = np.clip(decomp_img_2 - 10., 0, 255).astype(np.uint8)


    ## Morphology
    k2 = cv2.getStructuringElement(cv2.MORPH_CROSS,(b,b))
    decomp_img_2 = cv2.morphologyEx(decomp_img_2, cv2.MORPH_TOPHAT, k2)

    ## contrast
    decomp_img_2 = cv2.cvtColor(decomp_img_2, cv2.COLOR_BGR2RGB)
    decomp_img_2 = cv2.cvtColor(decomp_img_2, cv2.COLOR_BGR2GRAY)

    if decomp_img_2.mean() <= 15:
        low = decomp_img_2.mean() * 3.2
        high = decomp_img_2.mean() * 3.6
    elif decomp_img_2.mean() <= 20:
        low = decomp_img_2.mean() * 3
        high = decomp_img_2.mean() * 3.6
    else:
        low = decomp_img_2.mean() * 3
        high = decomp_img_2.mean() * 3.7

    decomp_img_2 = cv2.blur(decomp_img_2,(2,2))
    h, w = decomp_img_2.shape
    img_ = np.zeros(decomp_img_2.shape, dtype=np.uint8)

    for y in range(h):
        for x in range(w):
            temp = int((255 / (high - low)) * (decomp_img_2[y][x] - low))
            if temp > 255:
                img_[y][x] = 255
            elif temp < 0:
                img_[y][x] = 0
            else:
                img_[y][x] = temp

    decomp_img_2 = img_.copy()


    ######## Decomposing_Final_stage / [ Result ] ########
    ### Bone empahsis / bitwise (mask)
    ## Morphology
    ## Contours
    contours, hierarchy = cv2.findContours(decomp_img_2, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)
    cv2.drawContours(decomp_img_2, contours, -1, (255, 255, 255), -1)

    ## Bitwise (mask) / print white parts

    decomp_img_2 = cv2.bitwise_and(decomp_img_2, mask) 

    decomp_img_2 = cv2.cvtColor(decomp_img_2, cv2.COLOR_GRAY2BGR)
    decomp_img_2 = cv2.blur(decomp_img_2,(2,2))

    bone_extraction = cv2.resize(decomp_img_2, (600, 800))

    return bone_extraction



def Bone_extraction(bone, path):
    try:
        original_img = bone.read_img(path)
        mask = bone.make_mask(original_img)
        masked = bone.cut_mask(original_img, mask)
        rotated_img = bone.img_rotation(masked)
        bone = bone.Decomposing(rotated_img,60,55,50,25)
        global bone_path
        bone_path = cv2.imwrite(path, bone)
        return bone_path

    except:
        print('ERROR > Please check again' )

#########################################################
# -------------------------------------------------------
# yolo 이용
# out_crop_img, crop 이미지 출력
def out_crop_img(crop, gender):
    gender = np.array(gender).reshape(1,1)

    for i in range(7):
        carpal = re.compile('CARPAL.')
        ip = re.compile('IP.')
        lmcp = re.compile('LMCP.')
        lpip = re.compile('LPIP.')
        mmcp = re.compile('MMCP.')
        mpip = re.compile('MPIP.')
        tmcp = re.compile('TMCP.')

        if carpal.search(crop[i]['label']):
            CARPAL_img = crop[i]['im']
            CARPAL_img = cv2.resize(CARPAL_img, (224,224),cv2.INTER_AREA)
            CARPAL_img = np.expand_dims(CARPAL_img, axis=0)

        if ip.search(crop[i]['label']):
            IP_img = crop[i]['im']
            IP_img = cv2.resize(IP_img, (75,75),cv2.INTER_AREA)
            IP_img = np.expand_dims(IP_img, axis=0)
            
        if lmcp.search(crop[i]['label']):
            LMCP_img = crop[i]['im']
            LMCP_img = cv2.resize(LMCP_img, (75,75),cv2.INTER_AREA)
            LMCP_img = np.expand_dims(LMCP_img, axis=0)

        if lpip.search(crop[i]['label']):
            LPIP_img = crop[i]['im']
            LPIP_img = cv2.resize(LPIP_img, (75,75),cv2.INTER_AREA)
            LPIP_img = np.expand_dims(LPIP_img, axis=0)
        
        if mmcp.search(crop[i]['label']):
            MMCP_img = crop[i]['im']
            MMCP_img = cv2.resize(MMCP_img, (75,75),cv2.INTER_AREA)
            MMCP_img = np.expand_dims(MMCP_img, axis=0)
            
        if mpip.search(crop[i]['label']):
            MPIP_img = crop[i]['im']
            MPIP_img = cv2.resize(MPIP_img, (75,75),cv2.INTER_AREA)
            MPIP_img = np.expand_dims(MPIP_img, axis=0)

        if tmcp.search(crop[i]['label']):
            TMCP_img = crop[i]['im']
            TMCP_img = cv2.resize(TMCP_img, (75,75),cv2.INTER_AREA)
            TMCP_img = np.expand_dims(TMCP_img, axis=0)

        else : continue
    X = [CARPAL_img, LMCP_img, MMCP_img,TMCP_img, LPIP_img, MPIP_img, IP_img, gender]

    return X



# yolo_crop_img
def yolo_crop_img(save_path, yolo):
        result = yolo(save_path)
        crops = result.crop(save=False)
        img = np.squeeze(result.render())
        return crops, img, result

##  predict_zscore  ##

def predict_zscore(X, tjnet):

    # Function connection line ; yolo_crop_img(4)
    # global yolo
    # yolo_crop_img(save_path, yolo)  # yolo, 

    # X = out_crop_img(crops, gender)
    y_predict = tjnet.predict(X)
    pred = y_predict[0][0] 

    BA_mean = 115.41626213592232                                             
    BA_std = 48.02950411666953 

    prediction_BA = (pred * BA_std + BA_mean)/12
    return prediction_BA


#######################################################3
# 이미지 출력 함수
def bone_age_window(img, gender, predicted_bone_age ):
    img1 = cv2.resize(img, dsize=(450, 600))
    img2 = np.full((600, 450, 3), 255, np.uint8)
    
    cv2.putText(img2,
        "Gender={}".format(gender),
        (140,100),
        cv2.FONT_HERSHEY_SIMPLEX,
        0.6, (0,0,0))

    cv2.rectangle(img2, 
                (70,120),
                (380,230),
                (100,100,100),
                thickness=1, 
                lineType=cv2.LINE_AA) 

    cv2.putText(img2,
        "Predicted Bone Age",
        (100,150),
        cv2.FONT_HERSHEY_SIMPLEX,
        0.8, (0,0,0))

    cv2.putText(img2,
        "(MAE: 4.6)",
        (180,215),
        cv2.FONT_HERSHEY_SIMPLEX,
        0.6, (0,0,0))


    cv2.putText(img2,
        "{}".format(predicted_bone_age),
        (180,195),
        cv2.FONT_HERSHEY_SIMPLEX,
        1.3, (255,0,0))

    predict_result = np.concatenate((img1,img2), axis=1)
    # cv2.imshow('bone_age',predict_result)
    # cv2.waitKey()
    return predict_result

