From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Debian specific userspace RCU configure override
Date: Fri, 23 May 2014 13:59:27 +0000 (UTC)
Message-ID: <247206510.22055.1400853567137.JavaMail.zimbra__7440.34294407374$1400853625$gmane$org@efficios.com>
References: <30703453.22036.1400852842509.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1Wnq0Q-000257-Tn
 for lttng-dev@lists.lttng.org; Fri, 23 May 2014 09:59:36 -0400
In-Reply-To: <30703453.22036.1400852842509.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?utf-8?Q?Ond=C5=99ej_Sur=C3=BD?= <ondrej@debian.org>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, Michael Jeanson <mjeanson@efficios.com>
List-Id: lttng-dev@lists.lttng.org

Hi,

I recently stumbled on this patch:

http://sprunge.us/jYcJ

It overrides the generated config.h to ensure the
"dmb" instruction is not used.

However, the proper checks seems to be in place within
configure.ac to automatically detect whether to use dmb
or not:

# ARM-specific checks
AS_IF([test "x$ARCHTYPE" = "xarm"],[
        AC_MSG_CHECKING([for dmb instruction])
        AC_COMPILE_IFELSE([AC_LANG_SOURCE([[
                                int main()
                                {
                                        asm volatile("dmb":::"memory");
                                        return 0;
                                }
                ]])
        ],[
                AC_MSG_RESULT([yes])
                AC_DEFINE([CONFIG_RCU_ARM_HAVE_DMB], [1])
        ],[
                AC_MSG_RESULT([no])
        ])
])

My thinking here is that perhaps inappropriate compiler flags
are used when the compiler is invoked from within "configure",
which leads it to think that it targets an ARMv7+ with dmb.
The Debian "armel" architecture AFAIU needs to target older
ARM architectures.

It would be much better to fix the compiler flags passed to
configure and let urcu autodetection do what it is intended
to do rather than override the generated file.

Thoughts ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
