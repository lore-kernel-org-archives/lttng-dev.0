From: Simon Marchi <simon.marchi@polymtl.ca>
Subject: Re: How to check is tracepoint is currently enabled
	(UST)
Date: Wed, 25 Jun 2014 11:36:15 -0400
Message-ID: <CAFXXi0=XEwjPfLwxsGim6_FwRqGD-YM9o1zTVFRWbmyigGDPcw__41578.7631915466$1403710680$gmane$org@mail.gmail.com>
References: <48CF5AC71E61DB46B70D0F388054EFFD359C62DE@VAL-E-02.valcartier.drdc-rddc.gc.ca>
 <53AAE15C.3040100@ericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <thundersim@gmail.com>) id 1WzpFj-0000WM-Oq
 for lttng-dev@lists.lttng.org; Wed, 25 Jun 2014 11:37:03 -0400
Received: by mail-ie0-f173.google.com with SMTP id y20so1814349ier.32
 for <lttng-dev@lists.lttng.org>; Wed, 25 Jun 2014 08:36:46 -0700 (PDT)
In-Reply-To: <53AAE15C.3040100@ericsson.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Jonathan Rajotte-Julien <jonathan.rajotte-julien@ericsson.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

I am pretty sure that Dmitri is talking about a check that you can use
in your application, to see if a specific tracepoint is enabled. If
some data that you pass to the tracepoint is expensive to compute, yo
might want to avoid computing it when tracing is disabled.

> #define tracepoint_enabled(provider, name) caa_unlikely(__tracepoint_##provider##___##name.state)

Dmitri, that macro that you posted, does it work for you?

Otherwise, you can simply embed the code in the call to tracepoint:

    tracepoint(hello, world, expensive_work(data));

In the expansion of the "tracepoint" macro [1], expensive_work is only
called if the tracepoint is enabled, so you don't pay the cost if the
tracepoint is disabled.

If the code that you need to run to compute your data is not a single
function call, you can: (a) make it a function or (b) use gcc's
statement expressions [2]. For example, instead of:

    /* Here we call get_data and compute_median even if tracing is disabled. */
    struct data* data = get_data();
    int median = compute_median(data);
    free(data);
    tracepoint(hello, world, median);

you could do:
    /* Here we _don't_ call get_data and compute_median when tracing
is disabled. */
    tracepoint(hello, world, ({
        struct data* data = get_data();
        int median = compute_median(data);
        free(data);
        median;
    }));

The statement expression will only be executed if the tracepoint is
enabled (you can verify that by adding a printf in there).

Does it answer you question?

Simon

[1] http://git.lttng.org/?p=lttng-ust.git;a=blob;f=include/lttng/tracepoint.h;h=c5a09d815db1383e539c8c455e8477dda29a579a;hb=HEAD#l47
[2] https://gcc.gnu.org/onlinedocs/gcc/Statement-Exprs.html
