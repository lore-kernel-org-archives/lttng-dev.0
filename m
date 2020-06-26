From: Michael Jeanson via lttng-dev <lttng-dev@lists.lttng.org>
Subject: Re: [PATCH] Fix: tracepoint.h: define SDT_USE_VARIADIC
 in pkg-config CFLAGS
Date: Fri, 26 Jun 2020 17:02:00 -0400 (EDT)
Message-ID: <1673641132.14590.1593205320791.JavaMail.zimbra@efficios.com>
References: <20200624160934.205881-1-stefanha@redhat.com>
Reply-To: Michael Jeanson <mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 49tq7t2PxTz15Hm
 for <lttng-dev@lists.lttng.org>; Fri, 26 Jun 2020 17:02:01 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 5545A2D637D
 for <lttng-dev@lists.lttng.org>; Fri, 26 Jun 2020 17:02:01 -0400 (EDT)
In-Reply-To: <20200624160934.205881-1-stefanha@redhat.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi Stefan,

I proposed a patch here[1] that addresses this problem in a generic way by
duplicating the macro and namespacing it under LTTNG_. Honestly this is more
of an sdt bug, the STAP_PROBEV should be in it's own include guard outside
of _SYS_SDT_H or in it's own header file but we have to work with what's there.

Can you have a look at the patch and confirm that it fixes your problem?

Cheers,

Michael

[1] https://review.lttng.org/c/lttng-ust/+/3685 


----- On 24 Jun, 2020, at 12:09, lttng-dev lttng-dev@lists.lttng.org wrote:

> LTTng Userspace Tracer 2.11 with sdt enabled can break builds of
> applications that include <sys/sdt.h> themselves. QEMU
> (https://qemu.org/) is one example.
> 
> When applications include <sys/sdt.h> themselves before LTTng Userspace
> Tracer header files and the SDT_USE_VARIADIC macro is not defined,
> compilation fails due to the absense of STAP_PROBEV() macro that LTTng
> Userspace Tracer requires.
> 
> Define SDT_USE_VARIADIC in the pkg-config file so that all compilation
> units that use LTTng Userspace Tracer are guaranteed to have the macro
> defined even if <sys/sdt.h> is included elsewhere before LTTng Userspace
> Tracer header files.
> 
> In other words, define SDT_USE_VARIADIC on the compiler command-line
> instead of in <lttng/tracepoint.h>. This way it will always been defined
> when <sys/sdt.h> is included.
> 
> Make sure to define SDT_USE_VARIADIC when <lttng/tracepoint.h> is
> included without it. This happens when applications do not use
> pkg-config.
> 
> Fixes: b2f60c7986bb69f81b79b68f1bfe83aafa3278a7 ("Add sdt.h integration")
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
> Warning: this patch doesn't work yet. SDT_CFLAGS also needs to be passed
> into LTTng Userspace Tracer's own CFLAGS so that compilation can
> succeed. I don't know the autoconf/automake syntax to do this and wanted
> to see what you think of this solution before investing more time.
