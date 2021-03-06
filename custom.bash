# Dave's customized Bash functions

# http://thirtysixthspan.com/posts/grep-history-for
# ghf - [G]rep [H]istory [F]or top ten commands and execute one
# usage:
#  Most frequent command in recent history
#   ghf
#  Most frequent instances of {command} in all history
#   ghf {command}
#  Execute {command-number} after a call to ghf
#   !! {command-number}
function latest-history { history | tail -n 50 ; }
function grepped-history { history | grep "$1" ; }
function chop-first-column { awk '{for (i=2; i<NF; i++) printf $i " "; print $NF}' ; }
function add-line-numbers { awk '{print NR " " $0}' ; }
function top-ten { sort | uniq -c | sort -r | head -n 10 ; }
function unique-history { chop-first-column | top-ten | chop-first-column | add-line-numbers ; }
function ghf {
  if [ $# -eq 0 ]; then latest-history | unique-history; fi
    if [ $# -eq 1 ]; then grepped-history "$1" | unique-history; fi
      if [ $# -eq 2 ]; then
        `grepped-history "$1" | unique-history | grep ^$2 | chop-first-column`;
      fi
}

#
# Tools for working with network namespaces
#
create_ns () {
   NETNS=$1
   DEV=$2
   IP=$3
   sudo ip netns add ${NETNS}
   sudo ip netns exec ${NETNS} ip addr add dev ${DEV} ${IP}
   sudo ip netns exec ${NETNS} ip link set dev lo up 
}

as_ns () {
  NETNS=$1
  shift
  sudo ip netns exec ${NETNS} $@
}

clear_ns() {
  for NETNS in $(sudo ip netns list); do
    sudo ip netns delete ${NETNS}
  done
}

#
# Tools for working with DPDK
#
DPDK_CHECKPATCH_PATH=~/src/linux
function _rte() {
   if [ "$1" != "" ]; then
       export RTE_SDK=`pwd`
       export RTE_TARGET=`basename $1`
       echo "RTE_SDK: "$RTE_SDK " RTE_TARGET: "$RTE_TARGET
   else
       echo "Currently RTE_SDK: "$RTE_SDK " RTE_TARGET: "$RTE_TARGET
   fi
}

function _bld() {
   echo make -C ${RTE_SDK} install T=${RTE_TARGET} $@ -j8
   make -C ${RTE_SDK} install T=${RTE_TARGET} $@ -j8
}

function _dbld() {
   echo make -C ${RTE_SDK} install T=${RTE_TARGET} EXTRA_CFLAGS="-g -O0" $@ -j8
   make -C ${RTE_SDK} install T=${RTE_TARGET} EXTRA_CFLAGS="-g -O0" $@ -j8
}

