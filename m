From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: lttng-dev Digest, Vol 67, Issue 48
Date: Tue, 4 Feb 2014 17:44:25 +0000 (UTC)
Message-ID: <1531748088.18942.1391535865844.JavaMail.zimbra__30242.3518420712$1391535929$gmane$org@efficios.com>
References: <mailman.1320.1384681007.2186.lttng-dev@lists.lttng.org>
	<63008C666A72BB4F892767155D012B30390BFB4D@eusaamb105.ericsson.se>
	<20140204171736.GE7182@thessa>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@efficios.com>) id 1WAk2w-00006B-11
	for lttng-dev@lists.lttng.org; Tue, 04 Feb 2014 12:44:36 -0500
In-Reply-To: <20140204171736.GE7182@thessa>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: David Goulet <dgoulet@efficios.com>
Cc: lttng-dev@lists.lttng.org, Jim Dumont <jim.dumont@ericsson.com>
List-Id: lttng-dev@lists.lttng.org

----- Original Message -----
> From: "David Goulet" <dgoulet@efficios.com>
> To: "Jim Dumont" <jim.dumont@ericsson.com>
> Cc: lttng-dev@lists.lttng.org
> Sent: Tuesday, February 4, 2014 12:17:36 PM
> Subject: Re: [lttng-dev] lttng-dev Digest, Vol 67, Issue 48
> 
> On 17 Jan (17:26:13), Jim Dumont wrote:
> > Hi there,
> > 
> > Was there a follow-up to the series of questions raised by Daniel below and
> > referenced here:
> > 
> > http://lists.lttng.org/pipermail/lttng-dev/2013-November/021844.html
> > 
> > I didn't see one in the mailing list.
> > 
> > BR,
> > 
> > /Jim
> > 
> > 
> > > 1) Live support. It's now possible to stream traces (kernel and UST)
> > > while they being extracted meaning a relayd can now receive traces
> > > live and a viewer can attach to it to process the trace while running.
> > > The "--live" has been added to lttng create command that sets up a
> > > live tracing session.
> > >
> > > See doc/live-reading-howto.txt and doc/live-reading-protocol.txt for
> > > more detail on that feature.
> > 
> >    Does this mean you can't do a "live" trace to local storage?
> 
> You can use local storage for the live feature BUT you always need a
> relayd thus there will be some streaming happening on the loopback
> interface.
> 
> However, you *can't* start a live viewer by directly pointing to a trace
> on disk. It may works but we do NOT recommend it since you'll probably
> end up in a bad state or have synchronization issue.
> 
> > 
> > > 2) Java Util Logging support. With a special LTTngAgent located in
> > > lttng-ust project (liblttng-ust-jul) to trace JUL events and gather
> > > UST traces with them.
> > >
> > > The -j/--jul domain has been added to lttng command line so you can
> > > list the possible JUL Logger object and enable/disable them. It is the
> > > same as using the UST or Kernel domain.
> > >
> > > As of now, filters and loglevel are ignored with the JUL domain.
> > 
> >    Saying "It is the same as using the UST or Kernel domain" leaves a lot
> >    of questions unanswered, since the kernel and user-space behave *very*
> >    differently on a lot of points.
> > 
> > 1) Does --jul require root privileges?
> 
> No. JUL actually acts exactly like UST since it uses it thus a Java
> application connect to the session daemon that it can talk to.
> 
> > 2) I suppose the various commands have --kernel pre-empting --userspace
> > pre-empting --ul?
> 
> Yup. This is actually not mention anywhere but looking at "lttng"
> command line code, the domain's order is: kernel, ust, jul. Probably we
> should actually output an error if the user uses multiple domain...
> 
> > 3) add-context: does --jul have the same possible context types as
> > --userspace (i.e. ip, pthread_id, procname, vpid, vtid)?
> 
> Nope.
> 
> > 4) enable-channel:
> > 4.1) Are the --jul --subbuf-size, --num-subbuf and --read-timer defaults
> > the same as with --userspace?
> 
> Nope. JUL uses it's internal channel so basically enable channel does
> NOT support the jul domain thus not having -j in the help/man.
> 
> > 4.2) Presumably --output can only be mmap?
> 
> Yes. Same as UST but again you can't use enable-channel with JUl domain.
> 
> > 4.3) Are the --jul buffering schemes the same as with --userspace (i.e.
> > --buffers-pid and --buffers-uid)?
> 
> Always per UID. You can't change it.
> 
> > 4.4) If yes, won't they all degenerate to the virtual machine's user and
> > process IDs?
> 
> Not sure I understand this one?
> 
> > 5) enable-event:
> > 5.1) Can you assign --jul events to multiple channels like you can in
> > --userspace?
> 
> No.
> 
> > 5.2) Is the --jul event type --tracepoint or something else entirely?
> 
> It is tracepoint yes. For the JUL domain, ALL UST tracepoints are
> enabled (there is only one for now with the lttng-ust library we use
> (liblttng-ust-jul)).
> 
> > 5.3) Can the trailing wild card (and exclusion option) be used in the event
> > name when enabling/disabling --jul events?
> 
> Wild card are NOT supported for the JUL domain. Thus for instance "lttng
> enable-event -j my_event_subsystem42_*" will not work. Only the "*" will
> work enabling every Loggers.
> 
> > 6) list: Does bug #654 also apply to --jul?
> 
> Yes most probably. The session name is ignored.
> 
> 
> Now after answering all this, I feel like either creating a lttng-jul
> man page or adding a special section in "lttng.1" for the JUL domain
> explaining all this. Thoughts?

I guess adding a JUL domain section to lttng.1 might be the way to go.
Otherwise, it's unclear that people will find the lttng-jul man page,
given it is related to the "lttng" command.

Thanks,

Mathieu

> 
> Cheers!
> David
> 
-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
