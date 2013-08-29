From: Francis Giraldeau <francis.giraldeau@gmail.com>
Subject: Re: [Solved] ust libc and fork wrapper question
Date: Thu, 29 Aug 2013 12:59:53 -0400
Message-ID: <CAC6yHM7EUyTLFWYYwj9_BT+A2HAE9jrBoX9PdtTk5UdW9pHCOA__29026.6457632699$1377795653$gmane$org@mail.gmail.com>
References: <521E3BCF.5060500@ericsson.com>
	<521E45D9.9000909@ericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-pb0-f42.google.com ([209.85.160.42])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <francis.giraldeau@gmail.com>) id 1VF5Zf-0001Rd-2Q
	for lttng-dev@lists.lttng.org; Thu, 29 Aug 2013 13:00:04 -0400
Received: by mail-pb0-f42.google.com with SMTP id un15so718790pbc.29
	for <lttng-dev@lists.lttng.org>; Thu, 29 Aug 2013 09:59:53 -0700 (PDT)
In-Reply-To: <521E45D9.9000909@ericsson.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Matthew Khouzam <matthew.khouzam@ericsson.com>, "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Everybody I know that uses LTTng are in fact redoing all over again a
small script that setup a session, enable events, start tracing, run a
command and then stop the tracing and destroy the session. Compared to
that, perf makes tracing a snap: just run "perf record ./myapp"
without fuzz. They traded flexibility for easy of use. Let's bring
both to lttng!

Libc wrapper is a good example of a great feature that is hard to use.
Setting environment variable is an additional burden, and it's a kind
of hidden feature. Imagine, I ended up coded this feature, and then
realized that it was already implemented! And you need to setup the
right way, otherwise you end up tracing malloc/free in a whole lot of
processes. Here is how to enable libc wrapper with lttng-simple:

lttng-simple --enable-lib-wrapper -u -- ./myapp

Another example. Let's say that you want to compare malloc'ed memory
and real pages allocated by the kernel to a process (mm_page_alloc and
free). To simplify the analysis and because it's very focused on
memory allocation, let's save PID/TID as event context. Here is the
command with lttng-simple:

lttng-simple --enable-libc-wrapper -u -k evlist --stateless -- ./myapp

evlist file contains:
mm_page_alloc
mm_page_free

Here is an exerpt of such trace:

[15:12:01.327415421] (+0.000002216) blob:augparse:8343
ust_libc:malloc: { cpu_id = 2 }, { vtid = 8343, vpid = 8343 }, { size
= 776, ptr = 0x1E6AE60 }
[15:12:01.327420997] (+0.000005576) blob mm_page_alloc: { cpu_id = 2
}, { tid = 8343, pid = 8343 }, { page = 0xFFFFEA000460B780, order = 0,
gfp_flags = 2131152, migratetype = 0 }

I was thinking to make it a separate project from workload-kit,
because it's useful by itself. Right now, lttng-simple just executes
lttng commands in background, but it's cumbersome and it could be cool
to use the python API instead.

On a side note, malloc/free are _very_ high frequency on anything else
than a dummy hello world. It's likely that you will see dropped events
with default channel settings, even if the trace is saved on SSD disk.
lttng-simple increases the buffer size to reduce the risk of lost
events, but it's impossible with LTTng to slow down the app such that
we guarantee no events will be lost. Be ready to use snapshot to get
the tail of events in a reliable way for long running processes, but
then the initial value of malloc'ed memory of the execution window is
unknown. I understand that we can't sleep while writing kernel events,
but it would be easy to do in user space. What others think about
having a reliable and complete user space trace at the cost of
application slowdown as an additional option
(--please-save-all-events)?

Happy tracing!

Francis Giraldeau

2013/8/28 Matthew Khouzam <matthew.khouzam@ericsson.com>:
> Firefox uses its owm memory manager. After running tux-racer, it appears
> all is well.
>
>
> On 13-08-28 02:05 PM, Matthew Khouzam wrote:
>> Hello tracing sages,
>>
>> I was trying out the libc wrapper in ust. It works very well but does
>> not follow forks. (to be expected)
>>
>> So I copied "liblttng-ust-fork.so" into my .libs directory along with
>> "liblttng-libc-wrapper.so".
>>
>> I then run
>>
>> $lttng create thing
>> $lttng enable-channel chan --buffer-uid
>> $lttng enable-event -a -u <for david>
>> $lttng start
>> $LD_PRELOAD="liblttng-ust-fork.so liblttng-libc-wrapper.so" firefox
>> $lttng stop
>> $lttng destroy
>>
>> Aaaaaaaaaaand my trace has no events!
>>
>> I am certain I am doing something wrong, any suggestions?
>>
>> Matthew
>>
>>
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
