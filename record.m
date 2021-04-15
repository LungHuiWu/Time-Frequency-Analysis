Sec = 3;    
Fs = 8000;
recorder = audiorecorder(Fs, 16, 1); 
recordblocking(recorder, Sec); 
audioarray = getaudiodata(recorder);

soundsc(audioarray, Fs);                     % 播放錄音的結果
t = [0:length(audioarray)-1]./Fs;
figure;
plot (t, audioarray);                             % 將錄音的結果用圖畫出來
xlabel('sec','FontSize',16);
audiowrite('test.wav',audioarray, Fs)    % 將錄音的結果存成 *.wav 檔

dt = 1/Fs;
X = fft(audioarray);
figure;
plot(abs(X)*dt);

