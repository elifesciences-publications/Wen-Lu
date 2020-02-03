% normalize distance
% txt with 2 row (umpos,Grayvalue) get norm with nullpos and onepos
% plus 5% beyond and set to lenght 120 save in csv



clear all
close all

choice='Yes';
index=0;
P=1;

while P>0
index=index+1;

[donorName,donorPathName] = uigetfile('*.txt','txt_gree');%bild
A=importdata([donorPathName,donorName]);
X1=A.data(:,1);
Y1=A.data(:,2);


xnorm=X1;
ynorm=Y1;


prompt = ['What is the original null in um? from lenght max ' num2str(max(X1))];
null = inputdlg(prompt);
null=str2double(null);
prompt = ['What is the original eins in um? from lenght max ' num2str(max(X1))];
eins = inputdlg(prompt);
eins=str2double(eins);



%auf pixel pos 
% 
% prompt = ['What is zout pixel size um' num2str(max(X1))];
% pixelziye = inputdlg(prompt);
% pixelziye=str2double(pixelziye);
 %xnorm = round(X1./X1(2))


 einspixel=round(eins./X1(2));
 nullpixel=round(null./X1(2));

%00 prozent der l?nge von x
areabeyond=round((einspixel-nullpixel)*0.005)
xnorm=xnorm(nullpixel:einspixel);
ynorm=ynorm(nullpixel:einspixel);


% % normalize
% 
% 
% ynorm=(ynorm-min(Y1));


% normalize not
xnorm=xnorm-null;
xnorm=xnorm/(eins-null);


ynorm=ynorm;





%normieren der laenge auf 120
newNum = 100; % new number of elements in the "buffed" vector

%x120 and %y120, 10% area on each side makes new length
Xnormahunderzwanzig=interp1(linspace(0,1,numel(xnorm)), xnorm, linspace(0,1,newNum) );
Ynormahunderzwanzig=interp1(linspace(0,1,numel(ynorm)), ynorm, linspace(0,1,newNum) );

[pathstr,name,ext] = fileparts([donorPathName,donorName])


%plot figure)
figure(index)
plot(Xnormahunderzwanzig,Ynormahunderzwanzig,'g')
hold on

figure(index)
hold on
saveas(gcf,[donorPathName name ' frompos_' num2str(null) ' topos_' num2str(eins) '.tif'], 'tif') 


%save files
[pathstr,name,ext] = fileparts([donorPathName,donorName])

save([donorPathName name ' frompos_' num2str(null) ' topos_' num2str(eins)  '.mat'], 'Xnormahunderzwanzig','Ynormahunderzwanzig','null','eins' )

xlssave(:,1)=Xnormahunderzwanzig
xlssave(:,2)=Ynormahunderzwanzig
xlswrite([donorPathName name ' frompos_' num2str(null) ' topos_' num2str(eins)  '.xls'], xlssave,'A2:B122');

% next round?
choice=questdlg('one more?','take or not', 'default');
switch choice
    case 'Yes'
        P=1;
    case 'No'
        P=0;
    case 'cancel'
        P=0;
end

end

