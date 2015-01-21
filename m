From: Philippe Proulx <eeppeliteloop@gmail.com>
Subject: Re: Out of Tree Kernel Module
Date: Wed, 21 Jan 2015 16:23:21 -0500
Message-ID: <CAB4xu_3HiokfZFZsanRBK1bcNv7wxMn2P27yme3H84wxPhtF5w__24862.0308041156$1421875470$gmane$org@mail.gmail.com>
References: <1421873728.21263.3.camel@c00941>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-la0-f47.google.com ([209.85.215.47])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <eeppeliteloop@gmail.com>) id 1YE2kn-0003OA-Gg
 for lttng-dev@lists.lttng.org; Wed, 21 Jan 2015 16:23:59 -0500
Received: by mail-la0-f47.google.com with SMTP id hz20so9374544lab.6
 for <lttng-dev@lists.lttng.org>; Wed, 21 Jan 2015 13:23:51 -0800 (PST)
In-Reply-To: <1421873728.21263.3.camel@c00941>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Jonathan Haws <Jonathan.Haws@sdl.usu.edu>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

On Wed, Jan 21, 2015 at 3:55 PM, Jonathan Haws
<Jonathan.Haws@sdl.usu.edu> wrote:
> I am developing an out-of-tree kernel module and would like to
> instrument it for tracing.  I understand I will need to create an LTTng
> probe in the modules source tree, however when I try to build my module,
> I get errors stating that a header file for the subsystem doesn't exist
> in the source tree.
>
> Here is my trace event file:
>
> #undef TRACE_SYSTEM
> #define TRACE_SYSTEM sigma
>
> #if !defined(_TRACE_SIGMA_H) || defined(TRACE_HEADER_MULTI_READ)
> #define _TRACE_SIGMA_H
>
> #include <linux/tracepoint.h>
>
> TRACE_EVENT(
>     sigma_exarioctl,
>     TP_PROTO(int cmd, int pin, int value),
>     TP_ARGS(cmd, pin, value),
>
>     /* LTTng doesn't need those */
>     TP_STRUCT__entry(),
>     TP_fast_assign(),
>     TP_printk("", 0)
> );
>
> #endif
>
> /* this part must be outside protection */
> #include <trace/define_trace.h>
>
>
> When I include that in my module, I do this:
>
> #define CREATE_TRACE_POINTS
> #include "exartrace.h"
>
>
> However, when I build, I get the error:
> <KERNELDIR>/include/trace/define_trace.h:83:43: fatal error:
> trace/events/sigma.h: No such file or directory
>  #include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
>
Jonathan,

Did you try the procedure described here?
<http://lttng.org/docs/#doc-instrumenting-out-of-tree-linux-kernel>

Phil
>
> Any thoughts on what I am doing wrong?
>
> Thanks!
> Jon
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
