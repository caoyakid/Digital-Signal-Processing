function y = unit_step_fun(n)
y =zeros(1,length(n)); 
for i=1:length(n)
if n(i)>= 0
    y(i)= 1;
end
end