# Digital-Signal-Processing

## Abstract
針對一段有雜訊干擾的音樂作處理，首先需要分析原音檔的噪聲形式，並著手設計濾波器將雜訊消除  
此專題中使用兩種方式來處理:
1. Matlab Toolbox中的Comb filter
2. Chebyshev type1 IIR filter + Butterworth bandstop IIR filter  

最後重新觀察頻譜確認雜訊是否被消除，並輸出成新的音檔

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
經由快速傅立葉轉換fft，將音訊化成頻譜，可以得到上圖  
subplot第一張是該音訊中每個頻率的Magnitude，第二張則是在共計34秒長的音訊中，每秒時所有頻率的強度大小，第三張則是波型圖。

---

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
我們需要在頻域上消除300Hz及其諧波所組成的雜訊，因為Comb function的傅立葉轉換仍是Comb function，  
只需要在時域上，將原本的訊號和"以1/300秒間距組成的音頻，加總若干個週期後之平均"相減即可  
![](https://i.imgur.com/OtGmOau.png)  
- 參數決定:
1. Specify order = 147  
要設計以濾除300Hz及其整數倍諧波之雜訊的Comb filter，則在時域上以原信號減去「每1/300秒，即距離每147點（44100Hz / 300Hz）的採樣值加總一次，加總若干個週期後再平均」  
2. Bandwidth rejection = 2Hz  
觀察頻譜中雜訊，發現雜訊頻率與300Hz諧波之頻率相差皆小於0.5Hz，  
就理論而言，bandwidth rejection越小越好  
但在實作中，**過窄的bandwidth rejection和過大的衰減率，可能引發ring和phase distortion進而導致音質劣化**    
2Hz是try and error得出的結果，增加些許bandwidth rejection以換取600.1200.1800Hz三根特別大的雜訊能大幅衰減  
3. Apass = 20dB (雜訊衰減)
一樣觀察頻譜中雜訊，發現FFT後abs最高的值在600Hz處，大小為2.2x10^4，  
只需衰減至1/10，讓雜訊的振幅小於等於音樂訊號的振幅即可  

如此一來，就制定好Comb filter的規格了!

## 3. 使用Chebyshev type1 IIR filter + Butterworth bandstop IIR filter  
首先使用Chebyshev type1 IIR filter 濾除4500Hz以上的雜訊(因為人耳主要聽500-4000Hz)，4500是預留一些buffer。    
選擇cheby的原因是因其具有**equiripple in passband和flat in stopband**的性質  
在designfilt(resp, Name, Value)函式中決定StopbandFrequency為6500、PassbandFrequency為4500，  
主因是我們日常說話100-6000Hz(主要500-4000Hz)，並try and error試出來的，  
目的是盡可能保留原音訊且能去除不必要之雜訊   
- Chebyshev type1 IIR filter:
![](https://i.imgur.com/MOaCx4Z.png)  
  
經過Chebyshev type1 IIR filter後，可以發現4500Hz後的雜訊都被抑制了  
![](https://i.imgur.com/9YWU8C7.png)  
  
觀察發現需要設計其他的濾波器來處理600.1200.1800.2400.3000.3600.4200Hz的雜訊，  
設計7個Butterworth bandstop IIR filter相疊，  
在0-5000Hz之間，只有特定的7個頻率magnitude會衰減  
![](https://i.imgur.com/RFdNeDz.png)  

再經過Butterworth bandstop IIR filter後  
![](https://i.imgur.com/sXw4Bo0.png)

透過兩個濾波器各自的功用，將雜訊抑制，也能達到相同效果。

## 4. 結果
- 濾波前的左聲道頻譜  
![](https://i.imgur.com/lpean5t.png)  
- 濾波後的左聲道頻譜  
![](https://i.imgur.com/1RN8JzK.png)  
- 經過Comb濾波後
![](https://i.imgur.com/eyWD6Xx.png)  
- 經過Cheby I + Butterworth濾波後  
![](https://i.imgur.com/sXw4Bo0.png)  

## 5. 結論
在本專題中，實作了FIR與IIR filter  
Comb優點是方便，用於濾除一系列等間距的頻率  
Chebyshev + Butterworth雖較麻煩，但從頻譜可以看出在這份音檔，抑制雜訊效果較好

- 參考資料:  

http://www.ancad.com.tw/VS_Online_Help/ch03s02.html  

http://users.sussex.ac.uk/~pjly20/ras100.html 
![](https://i.imgur.com/DRzg3M2.png)  

