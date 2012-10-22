From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: RFC : design notes for remote traces live reading
Date: Mon, 22 Oct 2012 11:57:39 -0400
Message-ID: <20121022155739.GA3205__34164.0744278722$1350921491$gmane$org@Krystal>
References: <50830BA3.6000508@efficios.com> <20121020225442.GA5020@Krystal>
	<5085639D.4030004@efficios.com> <20121022153802.GA3432@Krystal>
	<50856AFA.4040706@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1TQKNp-0004Oq-8C
	for lttng-dev@lists.lttng.org; Mon, 22 Oct 2012 11:57:41 -0400
Content-Disposition: inline
In-Reply-To: <50856AFA.4040706@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: David Goulet <dgoulet@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, Julien Desfossez <jdesfossez@efficios.com>
List-Id: lttng-dev@lists.lttng.org

* David Goulet (dgoulet@efficios.com) wrote:
 [...]
> > 
> >>
> >>>
> >>>>
> >>>> * Synchronization of streams
> >>>> Already discussed in an earlier RFC, summary :
> >>>> - at a predefined rate, the consumer sends a synchronization packet that
> >>>> contains the last sequence number that can be safely read by the viewer
> >>>> for each stream of the session, it happens as soon as possible when all
> >>>> streams are generating data, and also time-based to cover the case with
> >>>> streams not generating any data.
> >>>
> >>> Note: if the consumer has not sent any data whatsoever (on any stream)
> >>> since the last synchronization beacon, it can skip sending the next
> >>> beacon. This is a nice power consumption optimisation.
> >>>
> >>>> - the relay receives this packet, ensures all data packets and indexes
> >>>> are commited on disk (and sync'ed) and updates the synchronization with
> >>>> the viewers (discussed just below)
> >>>>
> >>>> * Cooperating viewers
> >>>> The viewers need to be aware that they are reading streamed data and
> >>>> play nicely with the synchronization algorithms in place. The proposed
> >>>> approach is using fcntl(2) "Advisory locking" to lock specific portions
> >>>> of the tracefiles. The viewers will have to test and make sure they are
> >>>> respecting the locks when they are switching packets.
> >>>> So in summary :
> >>>> - when the relay is ready to let the viewers access the data, it adds a
> >>>> new write lock on the region that cannot be safely read and removes the
> >>>> previous one
> >>>> - when a viewer needs to switch packet, it tests for the presence of a
> >>>> lock on the region of the file it needs to access, if there is no lock
> >>>> it can safely read the data, otherwise it blocks until the lock is removed.
> >>>> - when a data packet is lost on the network, an index is written, but
> >>>> the offset in the tracefile is set to an invalid value (-1) so the
> >>>> reader knows the data was lost in transit.
> >>>> - the viewers need also to be adapted to read on-disk indexes, support
> >>>> metadata updates, respect the locking.
> >>>
> >>> How do you expect to deal with streams coming during tracing ? How is
> >>> the viewer expected to be told a new stream needs to be read, and how
> >>> is the file creation / advisory locking vs file open (read) / advisory
> >>> locking expected to be handled ?
> >>>
> >>>>
> >>>> Not addressed here but mandatory : the metadata must be completely
> >>>> streamed before streaming trace data that correspond to this new metadata.
> >>>
> >>> Yes. We might want to think a little more about what happens when we
> >>> stream partially complete metadata that cuts it somewhere where it
> >>> cannot be parsed.. ?
> >>
> >> Of what I've experienced so far, there are times where the metadata is
> >> simply sent *only* when the stop command is done which uses a flush
> >> buffer operation and, since the trace throughput was so low so buffers
> >> don't get filled up.
> >>
> >> Considering this *strong* requirement that the metadata needs to be
> >> streamed completely, can we think of a ustctl/kernctl that forces the
> >> metadata extraction?
> > 
> > Not sure what you mean. We can simply flush the metadata buffer. Or we
> > could decide to change the way we grab metadata altogether so it becomes
> > more synchronous with the application. However, this might be an issue
> > with application crash dump.
> 
> Flush buffer can do the trick indeed for most of the use cases. But what
> happens here if new metadata comes in (after start tracing) and the app
> is very low throughput ? Don't we need the tracer to immediately notify
> the consumer that there is new metadata available?

Well the idea is that the periodical flush will apply to metadata too,
not just data channels. And we'll make sure to send metadata before data
when both are ready.

Mathieu

> 
> Thanks!
> David
> 
> > 
> > Thanks,
> > 
> > Mathieu
> > 
> >>
> >> And this will be especially useful for new metadata added during
> >> tracing! (Not sure how we can deal with that on the session daemon since
> >> we have no idea but the tracer knows so maybe it could wake up the
> >> stream fd whenever there is metadata available?).
> >>
> >> Cheers!
> >> David
> >>
> >>>
> >>> Thanks!
> >>>
> >>> Mathieu
> >>>
> >>>>
> >>>> Feedbacks, questions and improvement ideas welcome !
> >>>>
> >>>> Thanks,
> >>>>
> >>>> Julien
> >>>
> > 

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
