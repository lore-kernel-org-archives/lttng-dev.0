From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-tools 1/4] Rename consumer threads	and
	spawn them in daemon
Date: Mon, 15 Oct 2012 13:39:33 -0400
Message-ID: <20121015173933.GB9142__38649.8146727265$1350322820$gmane$org@Krystal>
References: <1350052235-12198-1-git-send-email-dgoulet@efficios.com>
	<20121013154113.GA29985@Krystal>
	<507C2E26.1030401@efficios.com> <20121015172807.GA9034@Krystal>
	<507C49C1.3000801@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1TNodc-0003QO-Cn
	for lttng-dev@lists.lttng.org; Mon, 15 Oct 2012 13:39:36 -0400
Content-Disposition: inline
In-Reply-To: <507C49C1.3000801@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: David Goulet <dgoulet@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* David Goulet (dgoulet@efficios.com) wrote:
> 
> 
> Mathieu Desnoyers:
> >>>> diff --git a/src/common/consumer.c b/src/common/consumer.c
> >>>> index 242b05b..055de1b 100644
> >>>> --- a/src/common/consumer.c
> >>>> +++ b/src/common/consumer.c
> >>>> @@ -1131,6 +1131,8 @@ void lttng_consumer_destroy(struct lttng_consumer_local_data *ctx)
> >>>>  		PERROR("close");
> >>>>  	}
> >>>>  	utils_close_pipe(ctx->consumer_splice_metadata_pipe);
> >>>> +	/* This should trigger the metadata thread to exit */
> >>>> +	close(ctx->consumer_metadata_pipe[1]);
> >>>
> >>> this is adding a close, but did not remove any other remove that might
> >>> previously be in place elsewhere.
> >>
> >> So we got two possible error path which is either the poll thread fails
> >> or the consumer could be destroy by hand even though the threads are
> >> working well.
> >>
> >> Actually, this close should check if the value is valid and close it. To
> >> be honest, this is just a shortcut since close(-1) does not fail and
> >> ignoring the close error here since we are in the cleanup path anyway so
> >> we don't necessarily care about the perror message.
> >>
> >> Anyhow, we have to handle both error path. An if plus set -1 after close
> >> can be done so not to confuse.
> > 
> > if two threads can concurrently perform close on the same fd value, how
> > can you prove there are no possible races ?
> 
> Nothing to prove, the race is possible. The point I was trying to
> explain is that it does not matter actually since we are in a cleanup
> code path.

what happens if we close FD 0, 1, 2 or another FD, due to this race ?

what happens if our code evolve to restart threads after errors, and we
leave this race in place, so it becomes hard to reproduce that in some
occasions we are closing random file descriptors ?

> Anyway, let's remove it since the data thread, when dying, will close
> the metadata pipe anyway.

my point exactly :)

> 
> This will avoid more discussion for this small detail :).

The devil is in the details, as someone famous said before me.

Thanks,

Mathieu

> 
> David
> 
> > 
> > Mathieu
> > 

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
