From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Weird assertion failure
	in	__lttng_events_init__provider ()
	at	/usr/include/lttng/ust-tracepoint-event.h:687
Date: Tue, 18 Jun 2013 10:10:33 -0400
Message-ID: <20130618141033.GD14004__95.0108202689037$1371564677$gmane$org@Krystal>
References: <OF02578AAF.2F483DCE-ONC2257B8E.003BBD95-C2257B8E.003C1290@il.ibm.com>
	<20130618134708.GA14004@Krystal>
	<CAFXXi0nAUYhGXPFgnwUDTkujj9wiTP-oKmd+TB4YwSf6FDSrZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UowcE-0004gC-Ky
	for lttng-dev@lists.lttng.org; Tue, 18 Jun 2013 10:10:34 -0400
Content-Disposition: inline
In-Reply-To: <CAFXXi0nAUYhGXPFgnwUDTkujj9wiTP-oKmd+TB4YwSf6FDSrZw@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Simon Marchi <simon.marchi@polymtl.ca>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Now fixed, see commit:

commit 7d381d6e31531cf4f7bc5f4df955dd819731ba44
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Date:   Tue Jun 18 10:02:00 2013 -0400

    Clarify probe registration documentation/errors
    
    Fixes #513
    
    Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Thanks,

Mathieu

* Simon Marchi (simon.marchi@polymtl.ca) wrote:
> Glad to see I'm not the only one ;)
> 
> https://bugs.lttng.org/issues/513
> 
> On 18 June 2013 09:47, Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> > * Amit Margalit (AMITM@il.ibm.com) wrote:
> >> Hi,
> >>
> >> I'm getting an assertion failure as listed above. Any idea what this is?
> >>
> >> Program terminated with signal 6, Aborted.
> >> #0  0x00007fc304edb945 in raise () from /lib64/libc.so.6
> >> (gdb) bt
> >> #0  0x00007fc304edb945 in raise () from /lib64/libc.so.6
> >> #1  0x00007fc304edcf21 in abort () from /lib64/libc.so.6
> >> #2  0x00007fc304ed4810 in __assert_fail () from /lib64/libc.so.6
> >> #3  0x00007fc30a48d58a in __lttng_events_init__provider () at
> >> /usr/include/lttng/ust-tracepoint-event.h:687
> >>
> >> The change I made was to add 2 more tracepoints, in a separate file. The
> >> provider is the same.
> >
> > It looks like you have duplicated provider objects in your application.
> > E.g. twice the same provider name trying to register.
> >
> > Thanks,
> >
> > Mathieu
> >
> >>
> >> I am using --buffers-uid, btw. The code is stock 2.2.0rc2 + my LTTNG_HOME
> >> patch.
> >>
> >> Thanks,
> >>
> >>
> >> Amit Margalit
> >> IBM XIV - Storage Reinvented
> >> XIV-NAS Development Team
> >> Tel. 03-689-7774
> >> Fax. 03-689-7230
> >> _______________________________________________
> >> lttng-dev mailing list
> >> lttng-dev@lists.lttng.org
> >> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> >
> >
> > --
> > Mathieu Desnoyers
> > EfficiOS Inc.
> > http://www.efficios.com
> >
> > _______________________________________________
> > lttng-dev mailing list
> > lttng-dev@lists.lttng.org
> > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
