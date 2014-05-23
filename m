From: Jon Bernard <jbernard@debian.org>
Subject: Re: Debian specific userspace RCU configure override
Date: Fri, 23 May 2014 18:21:24 -0400
Message-ID: <20140523222124.GA25594__4810.16531489349$1400883766$gmane$org@helmut>
References: <30703453.22036.1400852842509.JavaMail.zimbra@efficios.com>
 <247206510.22055.1400853567137.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from out3-smtp.messagingengine.com ([66.111.4.27])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jbernard@debian.org>) id 1WnxqG-0004wi-Qh
 for lttng-dev@lists.lttng.org; Fri, 23 May 2014 18:21:42 -0400
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
 by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 654CD21419
 for <lttng-dev@lists.lttng.org>; Fri, 23 May 2014 18:21:25 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <247206510.22055.1400853567137.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, =?utf-8?B?T25kxZllaiBTdXLDvQ==?= <ondrej@debian.org>, Michael Jeanson <mjeanson@efficios.com>
List-Id: lttng-dev@lists.lttng.org

* Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> Hi,
> 
> I recently stumbled on this patch:
> 
> http://sprunge.us/jYcJ
> 
> It overrides the generated config.h to ensure the
> "dmb" instruction is not used.
> 
> However, the proper checks seems to be in place within
> configure.ac to automatically detect whether to use dmb
> or not:
> 
> # ARM-specific checks
> AS_IF([test "x$ARCHTYPE" = "xarm"],[
>         AC_MSG_CHECKING([for dmb instruction])
>         AC_COMPILE_IFELSE([AC_LANG_SOURCE([[
>                                 int main()
>                                 {
>                                         asm volatile("dmb":::"memory");
>                                         return 0;
>                                 }
>                 ]])
>         ],[
>                 AC_MSG_RESULT([yes])
>                 AC_DEFINE([CONFIG_RCU_ARM_HAVE_DMB], [1])
>         ],[
>                 AC_MSG_RESULT([no])
>         ])
> ])
> 
> My thinking here is that perhaps inappropriate compiler flags
> are used when the compiler is invoked from within "configure",
> which leads it to think that it targets an ARMv7+ with dmb.
> The Debian "armel" architecture AFAIU needs to target older
> ARM architectures.

I also wonder if there are some differences between of the arm build
machines.  I don't have shell access to the machine on which urcu was
built so I cannot check, but perhaps that particular machine has dmb.

> It would be much better to fix the compiler flags passed to
> configure and let urcu autodetection do what it is intended
> to do rather than override the generated file.

I'll gather and post the compiler flags used for urcu and we'll see.

-- 
Jon
