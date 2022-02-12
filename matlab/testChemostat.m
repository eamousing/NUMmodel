function bSuccess = testChemostat

sim = baserunChemostat(1.0);

sumB = sum(sim.B(:));
if ( sumB > 2e7 && sumB < 2.1e7 )
    bSuccess = true;
else
    bSuccess = false;
    fprintf(2,"sum(B) = %f\n",sumB);
end

