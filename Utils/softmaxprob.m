function [smvalue] = softmaxprob(value,t)
%SOFTMAXPROB Calculate the probabilities based on a Gibbs distribution

numerator = zeros(size(value));
for a = 1:length(value)
    numerator(a) = exp(value(a)/t);
end

denominator = 0;
for b = 1:length(value)
    denominator = denominator + exp(value(b)/t);
end

smvalue = numerator./denominator;

end
