set ns [new Simulator]
set tf [open p4.tr w]
$ns trace-all $tf
set nf [open p4.nam w]
$ns namtrace-all $nf

set server [$ns node]
set client [$ns node]
$server label "server"
$client label "client"

$ns duplex-link $server $client 2Mb 2ms DropTail
$ns duplex-link-op $client $server orient right

set tcp [new Agent/TCP]
$ns attach-agent $server $tcp
set sink [new Agent/TCPSink]
$ns attach-agent $client $sink
$ns connect $tcp $sink

set ftp [new Application/FTP]
$ftp attach-agent $tcp
$tcp set packetsize_ 1500 
$ns at 1.0 "$ftp start"
$ns at 10.0 "finish"

proc finish {} {
global ns tf nf
$ns flush-trace
close $tf
close $nf
exec awk -f p4transfer.awk p4.tr &
exec awk -f p4convert.awk p4.tr > convert.tr
exec xgraph convert.tr -geometry 800*400 -t bytes_recieved_at_client -x time_in_sec -y bytes_per_sec &
exit 0
}
$ns run
