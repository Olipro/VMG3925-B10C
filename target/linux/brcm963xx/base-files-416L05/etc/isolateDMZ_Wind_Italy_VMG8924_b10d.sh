#  LAN1    LAN2    LAN3    LAN4
#  0x3106  0x3104  0x3102  0x3100
#  eth0.0  eth1.0  eth2.0  eth3.0
#  0x8     0x4     0x2     0x1
if [ "$1" == "remap" ]; then
  # if interface group is configurred, please call the script after interface group is performed.
  rm /tmp/pbvcr
  echo "rm /tmp/pbvcr"
  sleep 5
fi
if [ -e /tmp/pbvcr ]; then
  regs=`cat /tmp/pbvcr`
  for reg in $regs; do
    addr=`echo ${reg:0:6}`
    val=`echo 0x${reg:7}`
    ethswctl -c regaccess -v $addr -l 2 -d $val -n 1 > /dev/null 2
  done
else
  echo 0x3100:`ethswctl -c regaccess -v 0x3100 -l 2 -n 1 | awk 'FNR==1 {print $3}'` > /tmp/pbvcr
  echo 0x3102:`ethswctl -c regaccess -v 0x3102 -l 2 -n 1 | awk 'FNR==1 {print $3}'` >> /tmp/pbvcr
  echo 0x3104:`ethswctl -c regaccess -v 0x3104 -l 2 -n 1 | awk 'FNR==1 {print $3}'` >> /tmp/pbvcr
  echo 0x3106:`ethswctl -c regaccess -v 0x3106 -l 2 -n 1 | awk 'FNR==1 {print $3}'` >> /tmp/pbvcr
fi
dmzEbtables=`ebtables -t filter -L DMZ`
if [ "$dmzEbtables" == "" ]; then
  ebtables -t filter -N DMZ -P RETURN
  ebtables -t filter -I FORWARD 1 -j DMZ
fi
ebtables -t filter -F DMZ
dmz=`cfg nat_conf get | grep 'Default Server Address' | awk '{print $5}'`
if [ "$dmz" != "" ] && [ "$dmz" != "0.0.0.0" ]; then
  ip -s -s neigh flush all
  ping "$dmz" -w 10 > /dev/null
  dmzMac=`arp -a | grep "$dmz" | awk '{print $4}'`
  if [ "$dmzMac" != "" ]; then
    br=`ip route get "$dmz" | grep 'br' | awk '{print $3}'`
    gw=`ip route get "$dmz" | grep 'br' | awk '{print $5}'`
    subnet=`ip -o -f inet addr show | grep "$br" | awk '{print $4}'`
    dmzPort=`brctl showmacs "$br" | grep "$dmzMac" | awk '{print $5}'`
    if [ "$gw" != "" ] && [ "$subnet" != "" ] && [ "$dmzPort" != "" ]; then
      ebtables -t filter -A DMZ -p IPv4 --ip-src "$subnet" --ip-dst "$gw" -j ACCEPT
      ebtables -t filter -A DMZ -p IPv4 --ip-src "$gw" --ip-dst "$subnet" -j ACCEPT
      ebtables -t filter -A DMZ -p IPv4 --ip-src "$subnet" --ip-dst "$dmz" -j DROP
      ebtables -t filter -A DMZ -p IPv4 --ip-src "$dmz" --ip-dst "$subnet" -j DROP
      ifconfig "$dmzPort" down
      ip -s -s neigh flush all
      ifconfig "$dmzPort" up
    fi
    if [ "$dmzPort" == "eth0.0" ]; then
      echo "DMZ is connected to eth0.0"
      val=0x`ethswctl -c regaccess -v 0x3106 -l 2 -n 1 | awk 'FNR==1 {print $3}'`
      val=$((val & 0xfffffff8))
      ethswctl -c regaccess -v 0x3106 -l 2 -d $val -n 1
      val=0x`ethswctl -c regaccess -v 0x3104 -l 2 -n 1 | awk 'FNR==1 {print $3}'`
      val=$((val & 0xfffffff7))
      ethswctl -c regaccess -v 0x3104 -l 2 -d $val -n 1
      val=0x`ethswctl -c regaccess -v 0x3102 -l 2 -n 1 | awk 'FNR==1 {print $3}'`
      val=$((val & 0xfffffff7))
      ethswctl -c regaccess -v 0x3102 -l 2 -d $val -n 1
      val=0x`ethswctl -c regaccess -v 0x3100 -l 2 -n 1 | awk 'FNR==1 {print $3}'`
      val=$((val & 0xfffffff7))
      ethswctl -c regaccess -v 0x3100 -l 2 -d $val -n 1
      echo 0x3100 0x`ethswctl -c regaccess -v 0x3100 -l 2 -n 1 | awk 'FNR==1 {print $3}'`
      echo 0x3102 0x`ethswctl -c regaccess -v 0x3102 -l 2 -n 1 | awk 'FNR==1 {print $3}'`
      echo 0x3104 0x`ethswctl -c regaccess -v 0x3104 -l 2 -n 1 | awk 'FNR==1 {print $3}'`
      echo 0x3106 0x`ethswctl -c regaccess -v 0x3106 -l 2 -n 1 | awk 'FNR==1 {print $3}'`
      exit 0
    elif [ "$dmzPort" == "eth1.0" ]; then
      echo "DMZ is connected to eth1.0"
      val=0x`ethswctl -c regaccess -v 0x3106 -l 2 -n 1 | awk 'FNR==1 {print $3}'`
      val=$((val & 0xfffffffb))
      ethswctl -c regaccess -v 0x3106 -l 2 -d $val -n 1
      val=0x`ethswctl -c regaccess -v 0x3104 -l 2 -n 1 | awk 'FNR==1 {print $3}'`
      val=$((val & 0xfffffff4))
      ethswctl -c regaccess -v 0x3104 -l 2 -d $val -n 1
      val=0x`ethswctl -c regaccess -v 0x3102 -l 2 -n 1 | awk 'FNR==1 {print $3}'`
      val=$((val & 0xfffffffb))
      ethswctl -c regaccess -v 0x3102 -l 2 -d $val -n 1
      val=0x`ethswctl -c regaccess -v 0x3100 -l 2 -n 1 | awk 'FNR==1 {print $3}'`
      val=$((val & 0xfffffffb))
      ethswctl -c regaccess -v 0x3100 -l 2 -d $val -n 1
      echo 0x3100 0x`ethswctl -c regaccess -v 0x3100 -l 2 -n 1 | awk 'FNR==1 {print $3}'`
      echo 0x3102 0x`ethswctl -c regaccess -v 0x3102 -l 2 -n 1 | awk 'FNR==1 {print $3}'`
      echo 0x3104 0x`ethswctl -c regaccess -v 0x3104 -l 2 -n 1 | awk 'FNR==1 {print $3}'`
      echo 0x3106 0x`ethswctl -c regaccess -v 0x3106 -l 2 -n 1 | awk 'FNR==1 {print $3}'`
      exit 0
    elif [ "$dmzPort" == "eth2.0" ]; then
      echo "DMZ is connected to eth2.0"
      val=0x`ethswctl -c regaccess -v 0x3106 -l 2 -n 1 | awk 'FNR==1 {print $3}'`
      val=$((val & 0xfffffffd))
      ethswctl -c regaccess -v 0x3106 -l 2 -d $val -n 1
      val=0x`ethswctl -c regaccess -v 0x3104 -l 2 -n 1 | awk 'FNR==1 {print $3}'`
      val=$((val & 0xfffffffd))
      ethswctl -c regaccess -v 0x3104 -l 2 -d $val -n 1
      val=0x`ethswctl -c regaccess -v 0x3102 -l 2 -n 1 | awk 'FNR==1 {print $3}'`
      val=$((val & 0xfffffff2))
      ethswctl -c regaccess -v 0x3102 -l 2 -d $val -n 1
      val=0x`ethswctl -c regaccess -v 0x3100 -l 2 -n 1 | awk 'FNR==1 {print $3}'`
      val=$((val & 0xfffffffd))
      ethswctl -c regaccess -v 0x3100 -l 2 -d $val -n 1
      echo 0x3100 0x`ethswctl -c regaccess -v 0x3100 -l 2 -n 1 | awk 'FNR==1 {print $3}'`
      echo 0x3102 0x`ethswctl -c regaccess -v 0x3102 -l 2 -n 1 | awk 'FNR==1 {print $3}'`
      echo 0x3104 0x`ethswctl -c regaccess -v 0x3104 -l 2 -n 1 | awk 'FNR==1 {print $3}'`
      echo 0x3106 0x`ethswctl -c regaccess -v 0x3106 -l 2 -n 1 | awk 'FNR==1 {print $3}'`
      exit 0
    elif [ "$dmzPort" == "eth3.0" ]; then
      echo "DMZ is connected to eth3.0"
      val=0x`ethswctl -c regaccess -v 0x3106 -l 2 -n 1 | awk 'FNR==1 {print $3}'`
      val=$((val & 0xfffffffe))
      ethswctl -c regaccess -v 0x3106 -l 2 -d $val -n 1
      val=0x`ethswctl -c regaccess -v 0x3104 -l 2 -n 1 | awk 'FNR==1 {print $3}'`
      val=$((val & 0xfffffffe))
      ethswctl -c regaccess -v 0x3104 -l 2 -d $val -n 1
      val=0x`ethswctl -c regaccess -v 0x3102 -l 2 -n 1 | awk 'FNR==1 {print $3}'`
      val=$((val & 0xfffffffe))
      ethswctl -c regaccess -v 0x3102 -l 2 -d $val -n 1
      val=0x`ethswctl -c regaccess -v 0x3100 -l 2 -n 1 | awk 'FNR==1 {print $3}'`
      val=$((val & 0xfffffff1))
      ethswctl -c regaccess -v 0x3100 -l 2 -d $val -n 1
      echo 0x3100 0x`ethswctl -c regaccess -v 0x3100 -l 2 -n 1 | awk 'FNR==1 {print $3}'`
      echo 0x3102 0x`ethswctl -c regaccess -v 0x3102 -l 2 -n 1 | awk 'FNR==1 {print $3}'`
      echo 0x3104 0x`ethswctl -c regaccess -v 0x3104 -l 2 -n 1 | awk 'FNR==1 {print $3}'`
      echo 0x3106 0x`ethswctl -c regaccess -v 0x3106 -l 2 -n 1 | awk 'FNR==1 {print $3}'`
      exit 0
    fi
  fi
fi
echo "DMZ did not exist."
ebtables -t filter -F DMZ
echo 0x3100 0x`ethswctl -c regaccess -v 0x3100 -l 2 -n 1 | awk 'FNR==1 {print $3}'`
echo 0x3102 0x`ethswctl -c regaccess -v 0x3102 -l 2 -n 1 | awk 'FNR==1 {print $3}'`
echo 0x3104 0x`ethswctl -c regaccess -v 0x3104 -l 2 -n 1 | awk 'FNR==1 {print $3}'`
echo 0x3106 0x`ethswctl -c regaccess -v 0x3106 -l 2 -n 1 | awk 'FNR==1 {print $3}'`
exit 0
