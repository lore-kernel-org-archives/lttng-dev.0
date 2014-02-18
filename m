From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Extract lttng trace from kernel coredump
Date: Tue, 18 Feb 2014 21:02:15 +0000 (UTC)
Message-ID: <271092494.27125.1392757335976.JavaMail.zimbra__47185.5271062397$1392757406$gmane$org@efficios.com>
References: <52D46B33.4010401@acm.org> <20140114184243.GC8177@thessa>
	<52D5A08F.4020204@acm.org>
	<1303248645.9400.1390063653581.JavaMail.zimbra@efficios.com>
	<52DAC820.7000005@acm.org>
	<353610105.9520.1390071650232.JavaMail.zimbra@efficios.com>
	<5303B493.7080200@acm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@efficios.com>) id 1WFro1-00006t-KI
	for lttng-dev@lists.lttng.org; Tue, 18 Feb 2014 16:02:23 -0500
In-Reply-To: <5303B493.7080200@acm.org>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: minyard@acm.org
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

----- Original Message -----
> From: "Corey Minyard" <minyard@acm.org>
> To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
> Cc: "David Goulet" <dgoulet@efficios.com>, lttng-dev@lists.lttng.org
> Sent: Tuesday, February 18, 2014 2:29:23 PM
> Subject: Re: [lttng-dev] Extract lttng trace from kernel coredump
> 
> I have attached some gdb macros for dumping LTT buffers from a kernel
> coredump.  I haven't done a lot of testing, though.

Very cool! I'll have a look when things get less busy here. I hope my
earlier reply helps clearing things out.

> 
> I do have one question.  I've been getting the metadata by taking a
> snapshot right when the trace starts and saving that to stick into the
> trace output from the coredump.  Is that the best way, or is there some
> other way I can extract it?  There doesn't seem to be a metadata channel
> running in snapshot mode.

Actually, it's better if you grab the metadata near when you grab the
coredump. Grabbing the metadata at the beginning of your tracing session
will not have the info about other modules that might be coming and going
while tracing is active (which might contain tracepoints).

You could grab the metadata from the coredump actually, this would be the
best approach. Looking at lttng modules 2.4 rc, you will want to look at

 /lttng-events.h

struct lttng_session {
  ...
  struct lttng_metadata_cache *metadata_cache;
  ...
};

Which has the metadata string:

struct lttng_metadata_cache {
        char *data;                     /* Metadata cache */
        unsigned int cache_alloc;       /* Metadata allocated size (bytes) */
        unsigned int metadata_written;  /* Number of bytes written in metadata cache */
        struct kref refcount;           /* Metadata cache usage */
        struct list_head metadata_stream;       /* Metadata stream list */
};

You simply need to dump this metadata string into a "metadata" file, add a
"/* CTF 1.8 */\n line at the beginning, and this will generate a "text only
CTF metadata", which can be read by babeltrace.

If you happen to core dump while the metadata cache is being resized, you might
encounter a corrupted metadata. It should not happen frequently, but it's possible.
We could eventually change lttng_metadata_printf() so it makes sure to always
keep a readable metadata around (by e.g. using kcalloc rather than krealloc and
dealing carefully with cache_alloc vs data fields updates).

Thoughts ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
