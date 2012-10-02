From: Bernd Hufmann <Bernd.Hufmann@ericsson.com>
Subject: consumerd crashes (streaming)
Date: Tue, 2 Oct 2012 15:04:49 -0400
Message-ID: <506B3AD1.6080200__19063.0276258618$1349204740$gmane$org@ericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from imr4.ericy.com ([198.24.6.9])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <bernd.hufmann@ericsson.com>) id 1TJ7mA-0004ax-3S
	for lttng-dev@lists.lttng.org; Tue, 02 Oct 2012 15:05:02 -0400
Received: from eusaamw0711.eamcs.ericsson.se ([147.117.20.178])
	by imr4.ericy.com (8.14.3/8.14.3/Debian-9.1ubuntu1) with ESMTP id
	q92JC8rD001827
	for <lttng-dev@lists.lttng.org>; Tue, 2 Oct 2012 14:12:09 -0500
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hello

I'm using lttng-tools 2.1 RC4 to stream traces over the network. I 
noticed a crash of the consumerd for the following scenario:

host1> lttng-relayd

host2> lttng create mySession -U <network URL>
host2> lttng enable-event -u -a
host2> lttng start
host2> lttng stop

After that, I stopped the relayd on host1. Then, when destroying the 
session on host2, the consumerd crashes and remains as a zombi process 
(<defunct>). I was able to reproduce this multiple times. However, the 
screen print-out varied. See at end of mail for an example of the 
output. I hope this output helps to find the problem. Could someone 
please have a look?

Thanks
Bernd

PERROR: recvmsg inet: Connection reset by peer [in 
lttcomm_recvmsg_inet_sock() at inet.c:227]
PERROR: sendmsg inet: Connection reset by peer [in 
lttcomm_sendmsg_inet_sock() at inet.c:271]
PERROR: Error in file write: Bad file descriptor [in 
lttng_consumer_on_read_subbuffer_mmap() at consumer.c:1214]
Error: Error writing to tracefile (ret: -1 != len: 4096 != subbuf_size: 56)
PERROR: Error in file write: Bad file descriptor [in 
lttng_consumer_on_read_subbuffer_mmap() at consumer.c:1214]
Error: Error writing to tracefile (ret: -1 != len: 4096 != subbuf_size: 37)
*** glibc detected *** lttng-consumerd: free(): invalid pointer: 
0xb5c02738 ***
======= Backtrace: =========
/lib/i386-linux-gnu/libc.so.6(+0x73e42)[0x282e42]
lttng-consumerd(lttng_consumer_thread_poll_metadata+0x294)[0x804b6c4]
/lib/i386-linux-gnu/libpthread.so.0(+0x6d4c)[0xd84d4c]
/lib/i386-linux-gnu/libc.so.6(clone+0x5e)[0x2f9ace]
======= Memory map: ========
00110000-0012c000 r-xp 00000000 08:01 524197     
/lib/i386-linux-gnu/libgcc_s.so.1
0012c000-0012d000 r--p 0001b000 08:01 524197     
/lib/i386-linux-gnu/libgcc_s.so.1
0012d000-0012e000 rw-p 0001c000 08:01 524197     
/lib/i386-linux-gnu/libgcc_s.so.1
0020e000-0020f000 r-xp 00000000 00:00 0          [vdso]
0020f000-003ae000 r-xp 00000000 08:01 542235     
/lib/i386-linux-gnu/libc-2.15.so
003ae000-003b0000 r--p 0019f000 08:01 542235     
/lib/i386-linux-gnu/libc-2.15.so
003b0000-003b1000 rw-p 001a1000 08:01 542235     
/lib/i386-linux-gnu/libc-2.15.so
003b1000-003b4000 rw-p 00000000 00:00 0
00694000-0069b000 r-xp 00000000 08:01 542251     
/lib/i386-linux-gnu/librt-2.15.so
0069b000-0069c000 r--p 00006000 08:01 542251     
/lib/i386-linux-gnu/librt-2.15.so
0069c000-0069d000 rw-p 00007000 08:01 542251     
/lib/i386-linux-gnu/librt-2.15.so
0087f000-0089d000 r-xp 00000000 08:01 654290     
/usr/local/lib/liblttng-ust-ctl.so.0.0.0
0089d000-0089e000 r--p 0001d000 08:01 654290     
/usr/local/lib/liblttng-ust-ctl.so.0.0.0
0089e000-0089f000 rw-p 0001e000 08:01 654290     
/usr/local/lib/liblttng-ust-ctl.so.0.0.0
00921000-00925000 r-xp 00000000 08:01 654175     
/usr/local/lib/liburcu.so.1.0.0
00925000-00926000 r--p 00003000 08:01 654175     
/usr/local/lib/liburcu.so.1.0.0
00926000-00927000 rw-p 00004000 08:01 654175     
/usr/local/lib/liburcu.so.1.0.0
00a1c000-00a3c000 r-xp 00000000 08:01 523325     
/lib/i386-linux-gnu/ld-2.15.so
00a3c000-00a3d000 r--p 0001f000 08:01 523325     
/lib/i386-linux-gnu/ld-2.15.so
00a3d000-00a3e000 rw-p 00020000 08:01 523325     
/lib/i386-linux-gnu/ld-2.15.so
00a5e000-00a63000 r-xp 00000000 08:01 654191     
/usr/local/lib/liburcu-bp.so.1.0.0
00a63000-00a64000 r--p 00004000 08:01 654191     
/usr/local/lib/liburcu-bp.so.1.0.0
00a64000-00a65000 rw-p 00005000 08:01 654191     
/usr/local/lib/liburcu-bp.so.1.0.0
00d7e000-00d95000 r-xp 00000000 08:01 542249     
/lib/i386-linux-gnu/libpthread-2.15.so
00d95000-00d96000 r--p 00016000 08:01 542249     
/lib/i386-linux-gnu/libpthread-2.15.so
00d96000-00d97000 rw-p 00017000 08:01 542249     
/lib/i386-linux-gnu/libpthread-2.15.so
00d97000-00d99000 rw-p 00000000 00:00 0
08048000-08062000 r-xp 00000000 08:01 654329     
/usr/local/lib/lttng/libexec/lttng-consumerd
08062000-08063000 r--p 0001a000 08:01 654329     
/usr/local/lib/lttng/libexec/lttng-consumerd
08063000-08064000 rw-p 0001b000 08:01 654329     
/usr/local/lib/lttng/libexec/lttng-consumerd
08064000-08066000 rw-p 00000000 00:00 0
09b9e000-09bbf000 rw-p 00000000 00:00 0          [heap]
b53ff000-b5400000 ---p 00000000 00:00 0
b5400000-b5c00000 rw-p 00000000 00:00 0
b5c00000-b5c21000 rw-p 00000000 00:00 0
b5c21000-b5d00000 ---p 00000000 00:00 0
b5e00000-b5e21000 rw-p 00000000 00:00 0
b5e21000-b5f00000 ---p 00000000 00:00 0
b5fd7000-b5fdd000 rw-s 00000000 00:12 27685      
/run/shm/ust-shm-tmp-3bEkF7 (deleted)
b5fdd000-b5fe1000 rw-s 00000000 00:12 27723      
/run/shm/ust-shm-tmp-YwqSPR (deleted)
b5fe1000-b5fe2000 ---p 00000000 00:00 0
b5fe2000-b67e2000 rw-p 00000000 00:00 0
b67e2000-b67e3000 ---p 00000000 00:00 0
b67e3000-b6fe3000 rw-p 00000000 00:00 0
b6fe3000-b6fe4000 ---p 00000000 00:00 0
b6fe4000-b77e7000 rw-p 00000000 00:00 0
b77e7000-b77ed000 rw-s 00000000 00:12 27681      
/run/shm/ust-shm-tmp-7Lo767 (deleted)
b77ed000-b77f1000 rw-s 00000000 00:12 27719      
/run/shm/ust-shm-tmp-uEFKcS (deleted)
b77fa000-b77fd000 rw-p 00000000 00:00 0
bfa07000-bfa28000 rw-p 00000000 00:00 0          [stack]
Error: consumer err socket second poll error
Error: Health error occurred in thread_manage_consumer







-- 
This Communication is Confidential. We only send and receive email on 
the basis of the terms set out at www.ericsson.com/email_disclaimer
