function CheckCollision(x1,y1,w1,h1, x2,y2,w2,h2)
  return x1 < x2+w2 and
         x2 < x1+w1 and
         y1 < y2+h2 and
         y2 < y1+h1
end

function CheckPointInBox(x,y, x1,y1,w1,h1)
    return x > x1 and
    	   x < (x1 + w1) and
    	   y > y1 and
    	   y < (y1 + h1)
end