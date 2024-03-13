BEGIN{
bytes =0;
time =0;
}
{
if ($1=="r" && $4==1 && $5=="tcp"){
bytes += $6;
time = $2;
printf("%f %f\n",time,bytes/1000000);
}
END{}
