clear all;
close all;

nitt = 50;
nrOcc = zeros(1, nitt);
k = 1;

nrInf = 0;
while k < 51

N = 5;
p = 0.3;

z = rand(2*N+1, 2*N+1);
lat = ones(2*N+1, 2*N+1, 3);
lat = lat/2;

occupied = [N N];
empty = [];
neighbours = [N-1 N; N+1 N; N N-1; N N+1];
newOccupied = [N N];

loop = true;

while loop
    newOccupied = [];

    for i = 1 : size(neighbours, 1)
        if neighbours(i, 1) < 1 || neighbours(i, 2) < 1 || neighbours(i, 1) > N*2+1 || neighbours(i, 2) > N*2+1
        else
            if z(neighbours(i, 1), neighbours(i, 2)) <= p
                occupied = [occupied; neighbours(i, :)];
                newOccupied = [newOccupied; neighbours(i, :)];
            else
                empty = [empty; neighbours(i, :)];
            end
        end
    end
    neighbours = [];
    
    x1 = [1 0];
    x2 = [-1 0];
    y1 = [0 -1];
    y2 = [0 1];
    
    for i = 1 : size(newOccupied, 1)
       
        curLoc = newOccupied(i, :);
        
        if curLoc(1) + 1 > 41
            
        else
            a = repmat(curLoc + x1, size(occupied, 1), 1);
            b = repmat(curLoc + x1, size(empty, 1), 1);
            c = repmat(curLoc + x1, size(neighbours, 1), 1);

            
            if sum(sum((a == occupied),2)>1) == 0
                if size(empty, 1) > 0
                    if sum(sum((b == empty),2)>1) == 0
                        if size(neighbours, 1) > 0
                            if sum(sum((c == neighbours), 2)>1) == 0
                                neighbours = [neighbours; curLoc + x1];
                            end
                        else
                                 neighbours = [neighbours; curLoc + x1]; 
                        end
                    end
                else
                        neighbours = [neighbours; curLoc + x1];
                end
            end
        end
        
        if curLoc(1) -1  < 1
           
        else
        
            a = repmat(curLoc + x2, size(occupied, 1), 1);
            b = repmat(curLoc + x2, size(empty, 1), 1);
            c = repmat(curLoc + x2, size(neighbours, 1), 1);

            %+1, 0
            if sum(sum((a == occupied),2)>1) == 0
                if size(empty, 1) > 0
                    if sum(sum((b == empty),2)>1) == 0
                        if size(neighbours, 1) > 0
                            if sum(sum((c == neighbours), 2)>1) == 0
                                neighbours = [neighbours; curLoc + x2];
                            end
                        else
                                 neighbours = [neighbours; curLoc + x2]; 
                        end
                    end
                else
                     neighbours = [neighbours; curLoc + x2];
                end
            end
        end
        
        if curLoc(2) + 1 > 41
           
        else
            a = repmat(curLoc + y1, size(occupied, 1), 1);
            b = repmat(curLoc + y1, size(empty, 1), 1);
            c = repmat(curLoc + y1, size(neighbours, 1), 1);
            %+1, 0
            if sum(sum((a == occupied),2)>1) == 0
                if size(empty, 1) > 0
                    if sum(sum((b == empty),2)>1) == 0
                        if size(neighbours, 1) > 0
                            if sum(sum((c == neighbours), 2)>1) == 0
                                neighbours = [neighbours; curLoc + y1];
                            end
                        else
                                 neighbours = [neighbours; curLoc + y1]; 
                        end
                    end
                else
                   neighbours = [neighbours; curLoc + y1];
                end
            end
        end
        
        if curLoc(2) -1 < 1
            
        else
            a = repmat(curLoc + y2, size(occupied, 1), 1);
            b = repmat(curLoc + y2, size(empty, 1), 1);
            c = repmat(curLoc + y2, size(neighbours, 1), 1);
            %+1, 0
            if sum(sum((a == occupied),2)>1) == 0
                if size(empty, 1) > 0
                    if sum(sum((b == empty),2)>1) == 0
                        if size(neighbours, 1) > 0
                            if sum(sum((c == neighbours), 2)>1) == 0
                                neighbours = [neighbours; curLoc + y2];
                            end
                        else
                                 neighbours = [neighbours; curLoc + y2]; 
                        end
                    end
                else
                    neighbours = [neighbours; curLoc + y2];
                end

            end   
        end
    end
        
   if size(neighbours, 1) == 0
      loop = false;
   end
                
    end

    for i = 1 : size(occupied, 1)
        lat(occupied(i,1), occupied(i,2), :) = [0 0 0];
    end
    
   for i = 1 : size(empty, 1)
        lat(empty(i,1), empty(i,2), :) = [1 1 1];
   end
 %   figure();
  % imshow(lat);
  if sum(sum(occupied < 2)) == 0 && sum(sum(occupied > N*2)) == 0
     nrOcc(k) = size(occupied, 1); 
     k = k + 1;
  else 
      nrInf = nrInf + 1;
  end
end 
figure();
bar(nrOcc);
   
mean(nrOcc)
std(nrOcc)
display(nrInf);
