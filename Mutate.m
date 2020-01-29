function y = Mutate(x,mu)
 flag = (rand(size(x))) < mu;
 
    %logical Indexing
    y = x;
    y(flag) = 1-x(flag);
    

end