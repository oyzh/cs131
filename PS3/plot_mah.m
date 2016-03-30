clear all;

x0 = [0 , 3]';
x1 = [-3, 0]';
x2 = [3, 0]';
SIGMA = [2 1; 1 2];

f = figure;
hold;

x = [-10:0.05:10];
y = [-10:0.05:10];

m0=[];
n0=[];
m1=[];
n1=[];
m2=[];
n2=[];

for i=x
    for j=y
        d0 = Mah([i,j]', x0, SIGMA);
        d1 = Mah([i,j]', x1, SIGMA);
        d2 = Mah([i,j]' ,x2, SIGMA);
        d = [d0, d1, d2];
        color = find(d == min(d),1);
        if color == 1
            m0 = [m0, i];
            n0 = [n0,j];
        elseif color == 2
            m1 = [m1,i];
            n1 = [n1,j];
        else
            m2 = [m2,i];
            n2 = [n2,j];
        end
    end
end
plot(m0,n0,'r.');
plot(m1,n1,'g.');
plot(m2,n2,'b.');

plot(x0(1), x0(2), 'o',  'MarkerSize', 10);
plot(x1(1), x1(2), 'o' , 'MarkerSize', 10);
plot(x2(1), x2(2), 'o', 'MarkerSize', 10);

text(x0(1)+0.5, x0(2)+0.5 , 'x0');
text(x1(1)-0.5, x1(2)-0.5 ,'x1');
text(x2(1)-0.5,x2(2)-0.5,'x2');

saveas(f, 'Mah.png');

