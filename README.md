# Digital-Signal-Processing

## Abstract
針對一段有雜訊干擾的音樂作處理，首先需要分析原音檔的噪聲形式，並著手設計濾波器將雜訊消除  
此專題中使用兩種方式來處理:
1. Matlab Toolbox中的Comb filter
2. Chebyshev type1 IIR filter + Butterworth bandstop IIR filter  
最後重新觀察頻譜確認雜訊是否被消除，並輸出成新的音檔

---

## 1. 原始音檔分析
```matlab
[y, fs] = audioread('Lisa_noise.wav');
sound(y ,fs)
```
播放原音檔可以透過人耳聽出有一嗡嗡作響的蜂鳴聲，推測有兩種可能:  
可能是**單頻**或者是**以某一頻率整數倍頻的諧波**所組成  
(人類可聽到20-20000Hz，日常說話為100-6000Hz)
進一步印出相關資訊及頻譜可以觀察到:  
![](https://i.imgur.com/kEcItiv.png)  
![](https://i.imgur.com/uqQn3zc.png)  
1. 原音檔的sampling rate為 44100Hz
2. 音檔維度為1460000x2，為左右聲道立體聲之資料，音訊取樣後的長度為1460000個採樣點
![](https://i.imgur.com/YiO6uJC.png)  
![](https://i.imgur.com/s1dfMva.png)  
![](https://i.imgur.com/lpean5t.png)  
為了更佳觀察雜訊與音樂之間訊號的關聯性並顯示高頻部分較微弱的雜訊成分，將聲音訊號經FFT後取abs，  
可以幫助我們不去忽略在高頻區域，大小較微弱的300Hz諧波雜訊
(經由頻譜觀察雜訊相隔10000個取樣點，10000x44100/1460000=300Hz)
配合上圖左右聲道的頻譜圖可以判斷雜訊為**某一頻率整數倍頻的諧波**所組成的複頻雜訊

## 2. 使用Comb filter之原因以及參數決定

## 3. 使用Chebyshev type1 IIR filter + Butterworth bandstop IIR filter  

## 4. 結果

## 5. 結論
