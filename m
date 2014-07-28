From: Adam Crume <adamcrume@gmail.com>
Subject: Re: Duplicate registration of tracepoint probes
Date: Mon, 28 Jul 2014 09:18:13 -0700
Message-ID: <CAFu9Dv1+BHCu140egVwU8AfQ0+WJcUdnxnZxOpNNhg0ORFSUiw__32337.1858838529$1406567047$gmane$org@mail.gmail.com>
References: <CAFu9Dv2S1UOWopG1KfCqW+LnCMm7DCYdBGok1uQMQ92xbjsi2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-oi0-f50.google.com ([209.85.218.50])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <adamcrume@gmail.com>) id 1XBncx-0004i6-4G
 for lttng-dev@lists.lttng.org; Mon, 28 Jul 2014 12:18:24 -0400
Received: by mail-oi0-f50.google.com with SMTP id a141so6246496oig.23
 for <lttng-dev@lists.lttng.org>; Mon, 28 Jul 2014 09:18:13 -0700 (PDT)
In-Reply-To: <CAFu9Dv2S1UOWopG1KfCqW+LnCMm7DCYdBGok1uQMQ92xbjsi2g@mail.gmail.com>
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

I figured it out.  The duplicate __tracepoint__init_urcu_sym symbols
apparently aren't an issue.  The problem is that I had tracepoints in
a static library that was then linked into the main executable as well
as a dynamic library loaded by the executable.  (It wasn't obvious
because the relevant symbols in the dynamic library were not
exported.)  Anyway, mixing static and dynamic linking is a bad idea.
:)

Adam

On Wed, Jul 23, 2014 at 5:06 PM, Adam Crume <adamcrume@gmail.com> wrote:
> I have an application which compiles and links fine, but at runtime it fails
> with:
>
> LTTng-UST: Error (-17) while registering tracepoint probe. Duplicate
> registration of tracepoint probes having the same name is not allowed.
> Aborted (core dumped)
>
> What's the best way to debug this?  I've seen this before when a library
> gets linked in multiple times, but that doesn't seem to be the case this
> time (as far as I can tell).  I ran nm on the app, and all of the probes
> (__event_probe__*) are unique.  I do see duplicates for
> __tracepoint__init_urcu_sym, type 't'.  I also see duplicates for
> __tracepoint_ptrs_registered, __tracepoint_registered, and
> tracepoint_dlopen, all of type 'V'.
>
> I have multiple *.tp files, which each get compiled and linked into their
> own library, and I'm using -DTRACEPOINT_PROBE_DYNAMIC_LINKAGE.
>
> Can anyone tell me what's wrong, or how to fix it?
>
> Thanks,
> Adam
