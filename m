From: Jonathan Rajotte-Julien via lttng-dev <lttng-dev@lists.lttng.org>
Subject: Re: Need Help In trace generation for malloc(),
 free() calls etc
Date: Wed, 13 May 2020 11:33:12 -0400
Message-ID: <20200513153312.GA2381108@joraj-alpa>
References: <CAPC3ern8bkAJDnOwoYh2Om44Q2GWAPsh140FW_aPGVkdUmCwkw@mail.gmail.com>
 <CAPC3erkxTh9dSgahym7xsCjJXOV3D+kto-=UB-ApjSUOWYZVeA@mail.gmail.com>
Reply-To: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 49Mdww62x1z21tq
 for <lttng-dev@lists.lttng.org>; Wed, 13 May 2020 11:33:20 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 38C672BA064
 for <lttng-dev@lists.lttng.org>; Wed, 13 May 2020 11:33:14 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <CAPC3erkxTh9dSgahym7xsCjJXOV3D+kto-=UB-ApjSUOWYZVeA@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Abhinav Ranjan <abhi.abhinav240@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hi Abhinav,

Please refrain from using screenshots when pastebin could be used (code,
commands, etc).

On Wed, May 13, 2020 at 10:29:22AM +0530, Abhinav Ranjan via lttng-dev wrote:
>   Hello Sir,
> I am Abhinav from India.
> *Kindly Ignore the previous email.*
> Actually I am very new to the Embedded System Engineering profession. In
> fact I have been asked to do an independent project to instrumenting a c
> application using  LLTng concept to find/trace calls to malloc(), free()
> calls. In fact i tried capturing the same as below steps but didn't
> understand why after using LD_PRELOAD also malloc() and free() calls were
> not traced. I am not sure whether my app was correct!!
> 
>  I followed the steps provided to create executable using -lltng-ust -ldl
> 2.I executed it as: LD_PRELOAD=liblttng-ust-libc-wrapper.so ./executable
> (initially as ./exe arg))
> 3. Then I followed commands to create , capture the events. and destroyed
> it.

Based on the screenshot "creation_trace.PNG", it seems that you enable only the
event you defined (malloc_trace_investigation). Keep in mind that the libc
wrapper defines its own tracepoints and tracepoint providers.

It the case of the libc wrapper the tracepoint providers available are:
lttng_ust_libc and lttng_ust_pthread

Both have multiple tracepoints defined under them.

Hence what you want for you experiment is something like this:

    lttng enable-event -u malloc_trace:investigation
    lttng enable-event -u 'lttng_ust_libc:*'

Keep in mind that you can list the events available for a currently running app
using:

   lttng list -u


The app must be running for the listing work.

Cheers.
