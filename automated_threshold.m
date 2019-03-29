
%first we load previously got results with and predicted values

alarm = zeros (1, z);
result = zeros(1, z);

for k = 1:z
    
    suma_predicted (k, 1) = sum(predicted(k, :));
        
    % Notification
    if (sum(predicted(k, :)) > 550)
        result (k) = 1;
    else
        result (k) = 0;
    end
    
    if (k <= 5)
        if (sum(result) >=3 )
            alarm (k) = 1
        end
    else
    if (sum(result(k-4:k)) >=3)
        alarm (k) = 1;
    end
    end
 

end