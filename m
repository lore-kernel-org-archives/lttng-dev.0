From: Philippe Proulx <eeppeliteloop@gmail.com>
Subject: Re: CTF 2.0 and lttng indexes
Date: Wed, 8 Apr 2015 15:44:01 -0400
Message-ID: <CAB4xu_2wiicqTA8L5dg=jTC56hTHXGu33eiiJxvZ_bffe00ZNw__48265.7249471687$1428522351$gmane$org@mail.gmail.com>
References: <5523E325.9010602@ericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-la0-f52.google.com ([209.85.215.52])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <eeppeliteloop@gmail.com>) id 1Yfvtu-0007uw-18
 for lttng-dev@lists.lttng.org; Wed, 08 Apr 2015 15:44:47 -0400
Received: by labbd9 with SMTP id bd9so62627936lab.2
 for <lttng-dev@lists.lttng.org>; Wed, 08 Apr 2015 12:44:32 -0700 (PDT)
In-Reply-To: <5523E325.9010602@ericsson.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Matthew Khouzam <matthew.khouzam@ericsson.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

On Tue, Apr 7, 2015 at 10:01 AM, Matthew Khouzam
<matthew.khouzam@ericsson.com> wrote:
>
> Hi all,
>
> Will the lttng indexes or something more generic be specified in the CTF
> 2.0 spec?

Mathieu needs to confirm, but AFAIK, I don't think so.

However, here's an idea following what was proposed for the integration
of base addresses and symbol informations: use CTF events to record
the packet indexes within stream files. That is, everytime a packet is
closed by the tracer, append an event to its packet indexes stream,
following this description:

    event {
        name = "packet-index";
        fields := struct {
            typalias integer {
                size = 64;
            } := uint64_t;

            uint64_t offset; /* in bits */
            uint64_t size; /* in bits */
            uint64_t ts_begin;
            uint64_t ts_end;
        };
    };

size, ts_begin, and ts_end are actually not needed, but could be useful to
avoid reading the target stream file when searching for a packet. Since
all the "packet-index" events have the same size/alignment, a half-interval
search is possible.

So, one such stream of "packet-index" events per actual stream file...
what do you think? There are situations to consider, like the trace file
rotation feature of LTTng, in which case the packet index stream files should
follow the rotation.

BTW I think this conversation should be moved to the DiaMon ML since
it's about CTF.

Phil

>
>
> Thanks
> Matthew
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
