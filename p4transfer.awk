  BEGIN{
  time_in_sec =0;
  bytes_recieved_at_client =0;
  bytes_sent_by_server = 0;
  }
  {
    if($1==r && $4==1 && $5 == tcp) {
      bytes_recieved_at_client += $6;
     }
     
     if ($1=="+" && $4==0 && $5 == "tcp") {
      bytes_sent_by_server += $6;
     
     }
     }
     
     END{
     system ("clear");
     printf("HELLO");
     }
     
