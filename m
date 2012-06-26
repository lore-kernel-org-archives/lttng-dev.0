From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Version of LTTng for kernel 2.6.25?
Date: Tue, 26 Jun 2012 12:49:57 -0400
Message-ID: <20120626164957.GB23255__36984.3332017355$1340729430$gmane$org@Krystal>
References: <p06240851cc0f70d951ac@[192.168.1.12]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1SjYxj-0002qX-7j
	for lttng-dev@lists.lttng.org; Tue, 26 Jun 2012 12:49:59 -0400
Content-Disposition: inline
In-Reply-To: <p06240851cc0f70d951ac@[192.168.1.12]>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Daniel Griscom <griscom@suitable.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* Daniel Griscom (griscom@suitable.com) wrote:
> I'd like to use LTTng, but I'm using an old kernel (and can't upgrade):
>
>> $ cat /proc/version
>> Linux version 2.6.25.10-prof (root@atmdev) (gcc version 3.4.6 (Gentoo 
>> Hardened 3.4.6-r1, ssp-3.4.5-1.0, pie-8.7.9)) #5 PREEMPT Sat Mar 3 
>> 16:51:19 EST 2012
>
> I understand that the latest kernel modules require kernel 2.6.38 or  
> later. What is the latest version of the kernel tools that I could run? 

You'll have to dig the old LTTng 0.x kernel tracer series (see legacy on
the website). Good luck with that, as it is not supported anymore.

> Are the user-space tools kernel-independent (and  
> LTTng-modules-independent)?

Yes, the user-space tracing part is kernel-independent and
lttng-modules-independent. However, you will not be able to control the
old lttng 0.x kernel tracer with the lttng 2.0 control tools.

Good luck!

Mathieu

>
>
> Thanks,
> Dan
>
> -- 
> Daniel T. Griscom             griscom@suitable.com
> Suitable Systems              http://www.suitable.com/
> 1 Centre Street, Suite 204    (781) 665-0053
> Wakefield, MA  01880-2400
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
