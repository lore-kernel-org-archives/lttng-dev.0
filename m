From: Suchakrapani Datt Sharma <suchakrapani.sharma@polymtl.ca>
Subject: Re: Out of Tree Kernel Module
Date: Wed, 21 Jan 2015 21:37:06 +0000
Message-ID: <20150121213706.Horde.EkD1qrgURzpW7ku7eEJIag1__29368.9883001663$1421876224$gmane$org@www.imp.polymtl.ca>
References: <1421873728.21263.3.camel@c00941> <54C01651.9010102@voxpopuli.im>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"; DelSp="Yes"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.polymtl.ca ([132.207.4.11])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <suchakrapani.sharma@polymtl.ca>) id 1YE2x0-0003Vq-E7
 for lttng-dev@lists.lttng.org; Wed, 21 Jan 2015 16:36:35 -0500
Received: from horde5.polymtl.ca (horde5.polymtl.ca [132.207.4.156])
 by smtp.polymtl.ca (8.14.3/8.14.3) with ESMTP id t0LLaXch025331
 for <lttng-dev@lists.lttng.org>; Wed, 21 Jan 2015 16:36:34 -0500
In-Reply-To: <54C01651.9010102@voxpopuli.im>
Content-Disposition: inline
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

I believe this issue is not related to what Jon was looking for. It  
seems to be a problem of proper inclusion of the tp header.

I followed the guide to build out-of-kernel LTTng modules recently and  
was able to do it properly for a random test module I did recently  
[1]. However it was done as a new addition to the current  
lttng-modules, so I was in the lttng source tree. But I believe it  
will clear up some doubts you have. I have not seen all macros  
properly and I might be wrong but I think your problem might be  
related to this [1] :

#define TRACE_INCLUDE_PATH ../instrumentation/events/lttng-module

#include "../instrumentation/events/lttng-module/net_filt.h"

Also, I might be way off in solving your problem, but you can use the  
patch as a reference while building your own module as well. If you  
are just testing, you can also have a look at lttng addons [3]. Its  
almost the same thing as a new module I think.

[1] https://gist.github.com/tuxology/4235d49b6a5fa87fa760
[2]  
https://gist.github.com/tuxology/4235d49b6a5fa87fa760#file-filter-example-patch-L541
[3] https://github.com/giraldeau/lttng-modules/tree/addons

--
Suchakra

Quoting Alexandre Montplaisir <alexmonthy@voxpopuli.im>:

> Hi,
>
> I have never tried this myself, but a similar question was asked on  
> StackOverflow recently:
> http://stackoverflow.com/questions/27950396/is-it-possible-to-build-lttng-probe-module-outside-of-lttng-modules-tree
>
> and the author found a solution. Maybe this can help?
>
> Cheers,
> Alex
>
>
>
> On 01/21/2015 03:55 PM, Jonathan Haws wrote:
>> I am developing an out-of-tree kernel module and would like to
>> instrument it for tracing.  I understand I will need to create an LTTng
>> probe in the modules source tree, however when I try to build my module,
>> I get errors stating that a header file for the subsystem doesn't exist
>> in the source tree.
>>
>> Here is my trace event file:
>>
>> #undef TRACE_SYSTEM
>> #define TRACE_SYSTEM sigma
>>
>> #if !defined(_TRACE_SIGMA_H) || defined(TRACE_HEADER_MULTI_READ)
>> #define _TRACE_SIGMA_H
>>
>> #include <linux/tracepoint.h>
>>
>> TRACE_EVENT(
>>     sigma_exarioctl,
>>     TP_PROTO(int cmd, int pin, int value),
>>     TP_ARGS(cmd, pin, value),
>>
>>     /* LTTng doesn't need those */
>>     TP_STRUCT__entry(),
>>     TP_fast_assign(),
>>     TP_printk("", 0)
>> );
>>
>> #endif
>>
>> /* this part must be outside protection */
>> #include <trace/define_trace.h>
>>
>>
>> When I include that in my module, I do this:
>>
>> #define CREATE_TRACE_POINTS
>> #include "exartrace.h"
>>
>>
>> However, when I build, I get the error:
>> <KERNELDIR>/include/trace/define_trace.h:83:43: fatal error:
>> trace/events/sigma.h: No such file or directory
>>  #include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
>>
>>
>> Any thoughts on what I am doing wrong?
>>
>> Thanks!
>> Jon
>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
