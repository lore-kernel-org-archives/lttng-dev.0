From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Running 32bit sessiond on 64bit host
Date: Mon, 3 Feb 2014 16:12:00 +0000 (UTC)
Message-ID: <1088723708.18175.1391443920124.JavaMail.zimbra__37080.157621722$1391443976$gmane$org@efficios.com>
References: <6DB83340B9D38C4A9C0ECD8B6FBABDFB1A251458@ESESSMB105.ericsson.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@efficios.com>) id 1WAM7w-0004qW-9z
	for lttng-dev@lists.lttng.org; Mon, 03 Feb 2014 11:12:09 -0500
In-Reply-To: <6DB83340B9D38C4A9C0ECD8B6FBABDFB1A251458@ESESSMB105.ericsson.se>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Stanislav Vovk <stanislav.vovk@ericsson.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

----- Original Message -----
> From: "Stanislav Vovk" <stanislav.vovk@ericsson.com>
> To: lttng-dev@lists.lttng.org
> Sent: Thursday, September 26, 2013 9:44:07 AM
> Subject: [lttng-dev] Running 32bit sessiond on 64bit host
> 
> Hi,
> 
> Running a 32bit session deamon on a 64 bit host fails when creating a
> channel. The following  error message is given,
> 
> Default snapshot output set to: /tmp/ltt
> Snapshot mode set. Every channel enabled for that session will be set in
> overwrite mode and mmap output.
> Error: Channel ch_tri: 32-bit UST consumer start failed (session tri)
> Warning: Some command(s) went wrong
> 
> Running on,
> uname -a
> Linux esekilxxen3020 3.0.13-0.27-xen #1 SMP Wed Feb 15 13:33:49 UTC 2012
> (d73692b) x86_64 x86_64 x86_64 GNU/Linux
> 
> Is this intended to work or are there some limitations for this scenario?

Just for the records, you need to compile and install a 32-bit consumer
daemon in your system if you want to trace 32-bit applications on a system
containing 32-bit and 64-bit applications. The session daemon will
take care of dispatching application to consumer daemons with the appropriate
bitness. So if you want to trace both 32-bit and 64-bit applications, you
need to have both 32-bit and 64-bit consumer daemons.

Thanks,

Mathieu

> 
> Thanks,
> Stanislav
> 
> 
> 
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
