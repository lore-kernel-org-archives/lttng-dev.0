From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: build error: ltt-control package
Date: Wed, 13 Mar 2013 10:01:52 -0400
Message-ID: <20130313140152.GB16186__30262.3956733898$1363183364$gmane$org@Krystal>
References: <201303130125186687389@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UFmFd-0003Am-Qc
	for lttng-dev@lists.lttng.org; Wed, 13 Mar 2013 10:01:53 -0400
Content-Disposition: inline
In-Reply-To: <201303130125186687389@gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: OSDepend <osdepend@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

* OSDepend (osdepend@gmail.com) wrote:
> Hi, all,
> 
> I met some trouble when i tried to "make" the ltt-control-0.88-09242010. The code is list below:
> 
> make[2]: Leaving directory `/usr/src/ltt-control-0.88-09242010/liblttd'
> Making all in lttd
> make[2]: Entering directory `/usr/src/ltt-control-0.88-09242010/lttd'
> gcc -DHAVE_CONFIG_H -I.. -I..     -g -O2 -MT lttd.o -MD -MP -MF .deps/lttd.Tpo -c -o lttd.o lttd.c
> mv -f .deps/lttd.Tpo .deps/lttd.Po
> /bin/sh ../libtool --tag=CC   --mode=link gcc  -g -O2   -o lttd lttd.o ../liblttd/liblttd.la -lpthread
> libtool: link: gcc -g -O2 -o .libs/lttd lttd.o  ../liblttd/.libs/liblttd.so -lpthread
> ../liblttd/.libs/liblttd.so: undefined reference to `sync_file_range'
> collect2: ld returned 1 exit status
> make[2]: *** [lttd] Error 1
> make[2]: Leaving directory `/usr/src/ltt-control-0.88-09242010/lttd'
> make[1]: *** [all-recursive] Error 1
> make[1]: Leaving directory `/usr/src/ltt-control-0.88-09242010'
> make: *** [all] Error 2
> 
> My workstation is Centos 5.5, glibc-2.5.
> It seems like a design bug in centos which ignore the sysycall sync_file_range, so seems the only way for me is to just delete the related code.
> Is there any other way to make it through? please help me out!!

I'm afraid this old LTTng 0.x version is not supported anymore. Please
move to 2.x series.

However, removing the sync_file_range call should keep things working.
You might also want to replace that call with fdatasync() for older
distros.

Thanks,

Mathieu

> 
> 2013-03-13
> 
> 
> 
> zhengchen

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
