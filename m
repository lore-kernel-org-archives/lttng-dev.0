From: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Subject: Re: lost trace events
Date: Wed, 7 Nov 2018 10:31:20 -0500
Message-ID: <20181107153120.GA15594__43395.3244392343$1541604573$gmane$org@joraj-alpa>
References: <CADwgpi8TmCUgz4uF8CpPs-1-SooENXvYgA2ZqjXbcMgsSwzRdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 42qr414nlrzqZN
 for <lttng-dev@lists.lttng.org>; Wed,  7 Nov 2018 10:31:29 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <CADwgpi8TmCUgz4uF8CpPs-1-SooENXvYgA2ZqjXbcMgsSwzRdg@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Alok Priyadarshi <alokpr@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi,

On Wed, Oct 31, 2018 at 02:58:37PM -0700, Alok Priyadarshi wrote:
> We are tracing a multi-process application that generates high-frequency
> user-space trace events.
> 
> Environment:
> - Ubuntu 16.04 LTS
> - Lttng 2.10.4 - KeKriek
> 
> Session:
> - Snapshot mode
> - One channel with default config:
> overwrite=1, subbuf_size=524288, num_subbuf=4
> 
> We have noticed that a few events are missing. I understand that in

How did you notice those "missing" events?

Would you be able to share a small reproducer with us so that we can assess the
situation?

> overwrite mode we can lose entire sub-buffers but IIUC we would only lose
> events at the beginning, not in-between events in a sub-buffer.
> 
> Is it not true that only the oldest sub-buffer is overwritten and when
> overwrite happens, none of the latest events are discarded?

This is how it should work yes.

> 
> Few more things to note:
> - Before lttng-snapshot-record, we stop tracing as recommended by the
> documentation

Good.

> - Packet context field events_discarded is always set to 0
> - Event loss seems to happen around packet transition. I have noticed this
> in at least two traces

Please provide us with how you arrived to this conclusion and a small
reproducer if possible.

> 
> The snapshot mode seems perfect for our use case. It is OK to lose events
> from either ends of the snapshot, but it is essential to not lose any
> in-between events. I was under the impression that overwrite mode
> guarantees that.

It should.

Cheers

-- 
Jonathan Rajotte-Julien
EfficiOS
