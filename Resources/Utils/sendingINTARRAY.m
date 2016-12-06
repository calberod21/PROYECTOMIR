clear all;
u = udp('127.0.0.1',7000);  
fopen(u);
oscsend(u,'/test1','iii', 1, 2, 5);
fclose(u);