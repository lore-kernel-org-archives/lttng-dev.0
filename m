From: Klaus Dannecker <klaus.dannecker@gmx.de>
Subject: make a trace_event in a modul (driver)
Date: Sat, 09 Nov 2013 09:33:45 +0100
Message-ID: <527DF369.4020704__45114.5151201219$1383986068$gmane$org@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mout.gmx.net ([212.227.17.22])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <klaus.dannecker@gmx.de>) id 1Vf3z2-0002N7-AL
	for lttng-dev@lists.lttng.org; Sat, 09 Nov 2013 03:33:33 -0500
Received: from [192.168.178.21] ([94.217.92.33]) by mail.gmx.com (mrgmx103)
	with ESMTPSA (Nemesis) id 0LeNGL-1VxJJD04B3-00q9IX for
	<lttng-dev@lists.lttng.org>; Sat, 09 Nov 2013 09:33:26 +0100
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hi,
I want to write a driver with trace events.
In the first step i compile the example  trace-events-sample.c with the 
makefile:

ifneq ($(KERNELRELEASE),)
     obj-m  := modul_trace-events-sample.o
     modul_trace-events-sample-y := trace-events-sample.o
     ccflags-y := -I$(src)
else
     KDIR ?= /lib/modules/`uname -r`/build
default:
     $(MAKE) -C $(KDIR) M=$$PWD
endif

now i get the modul_trace-events-sample.ko File.
now:
insmod modul_trace-events-sample.ko
lttng create
lttng enable-event -k -a
lttng start
...wait...
lttng stop
lttng destroy

now i look the result in the eclise viewer, but i found event 
"trace_foo_bar" not in the session!
what am I doing wrong?

I use ubuntu 13.04 in a vmware

Thanks
