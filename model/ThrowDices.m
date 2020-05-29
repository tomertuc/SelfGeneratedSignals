function [ b ] = ThrowDices( p )
%THROWDICES return 1 with probability b, ow 0
r=rand();

if r<=p
    b=1;
else
    b=0;
end

end

