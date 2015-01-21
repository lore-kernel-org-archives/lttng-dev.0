From: Jonathan Haws <Jonathan.Haws@sdl.usu.edu>
Subject: Out of Tree Kernel Module
Date: Wed, 21 Jan 2015 20:55:28 +0000
Message-ID: <1421873728.21263.3.camel__8093.18703036315$1421873773$gmane$org@c00941>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from echo.usurf.usu.edu ([129.123.194.129])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Jonathan.Haws@sdl.usu.edu>) id 1YE2JK-00039R-VQ
 for lttng-dev@lists.lttng.org; Wed, 21 Jan 2015 15:55:37 -0500
Content-Language: en-US
Content-ID: <62C28223C4C99646A8342E261468C682@sdl.usu.edu>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

I am developing an out-of-tree kernel module and would like to
instrument it for tracing.  I understand I will need to create an LTTng
probe in the modules source tree, however when I try to build my module,
I get errors stating that a header file for the subsystem doesn't exist
in the source tree.

Here is my trace event file:

#undef TRACE_SYSTEM
#define TRACE_SYSTEM sigma

#if !defined(_TRACE_SIGMA_H) || defined(TRACE_HEADER_MULTI_READ)
#define _TRACE_SIGMA_H

#include <linux/tracepoint.h>

TRACE_EVENT(
    sigma_exarioctl,
    TP_PROTO(int cmd, int pin, int value),
    TP_ARGS(cmd, pin, value),

    /* LTTng doesn't need those */
    TP_STRUCT__entry(),
    TP_fast_assign(),
    TP_printk("", 0)
);

#endif

/* this part must be outside protection */
#include <trace/define_trace.h>


When I include that in my module, I do this:

#define CREATE_TRACE_POINTS
#include "exartrace.h"


However, when I build, I get the error:
<KERNELDIR>/include/trace/define_trace.h:83:43: fatal error:
trace/events/sigma.h: No such file or directory
 #include TRACE_INCLUDE(TRACE_INCLUDE_FILE)


Any thoughts on what I am doing wrong?

Thanks!
Jon
