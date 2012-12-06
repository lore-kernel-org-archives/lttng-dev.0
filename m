From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Request change name of function lookup_enum
	in	libbabeltrace to make GDB use this lib
Date: Thu, 6 Dec 2012 11:24:59 -0500
Message-ID: <20121206162459.GB17469__26059.5042295337$1354811146$gmane$org@Krystal>
References: <CANFwon2s-eJoCrhzJmxhoGx9G2NeOAFf-FDFk1SoxD1OhPxWsg@mail.gmail.com>
	<20121205120845.GA31696@Krystal> <50C0C06A.40207@redhat.com>
	<50C0C5C1.4070101@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1TgeFw-0000DA-Vu
	for lttng-dev@lists.lttng.org; Thu, 06 Dec 2012 11:25:01 -0500
Content-Disposition: inline
In-Reply-To: <50C0C5C1.4070101@redhat.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Pedro Alves <palves@redhat.com>, Julien Desfossez <jdesfossez@efficios.com>
Cc: Tom Tromey <tromey@redhat.com>, gdb@sourceware.org, lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

* Pedro Alves (palves@redhat.com) wrote:
> On 12/06/2012 03:57 PM, Pedro Alves wrote:
> > On 12/05/2012 12:08 PM, Mathieu Desnoyers wrote:
> >> * Hui Zhu (teawater@gmail.com) wrote:
> >>> Hi,
> >>>
> >>> I am working on add CTF support to GDB.  You can see my patch review threads in:
> >>> http://sourceware.org/ml/gdb-patches/2012-11/msg00552.html
> >>> http://sourceware.org/ml/gdb-patches/2012-11/msg00554.html
> >>> http://sourceware.org/ml/gdb-patches/2012-11/msg00553.html
> >>> http://sourceware.org/ml/gdb-patches/2012-11/msg00555.html
> >>> http://sourceware.org/ml/gdb-patches/2012-11/msg00556.html
> >>>
> >>> To make GDB support CTF read, I use libbabeltrace with GDB.  You can
> >>> see the patch in
> >>> http://sourceware.org/ml/gdb-patches/2012-11/msg00555.html.
> >>> I have a issue is  libbabeltrace have a function called lookup_enum
> >>> that is same with a GDB function.
> >>> I change the function name of GDB to handle this issue in my patch.
> >>>
> >>> But Tom said let libbabeltrace to change function name is better.
> >>> So I send this mail to ask do you mind change the function name of
> >>> lookup_enum?   If you can change the function name that will be really
> >>> helpful for us.  Thanks a lot.
> >>> And I post a patch about change the function name in libbabeltrace.
> >>
> >> I'm CCing Julien Desfossez on this one. From what I see,
> >> include/babeltrace/types.h is not included into the system, so it should
> >> not be considered to be a public header of libbabeltrace.
> > 
> > I've just built and installed babeltrace 1.0.0 (where's the mainline repository,
> > BTW?), and indeed, I'm not seeing the types.h file anywhere in the
> > installed tree:
> 
> (found mainline at http://www.efficios.com/babeltrace)
> 
> I installed mainline, and quickly skimmed the headers.  It seems most of the
> symbols are already namespace clean, using bt_ or babeltrace_ as prefix,
> but I did spot some problems:
> 
>  context.h:
> 
>  struct bt_context;
>  struct stream_pos;
>  ^^^^^^^^^^^^^^^^^
>  struct bt_ctf_event;

Good catch. Yes this one is installed.

> 
> 
>  ctf/events.h:
> 
>  struct definition;
>  ^^^^^^^^^^^^^^^^^
>  struct declaration;
>  ^^^^^^^^^^^^^^^^^^
>  struct bt_ctf_event;
>  struct bt_ctf_event_decl;
>  struct bt_ctf_field_decl;

Yes.

> It'd be very good if those (and any others I might have missed) were bt_ prefixed too.

Indeed. Julien, can you review all those public headers and ensure they
are correctly namespaced ?

Thanks,

Mathieu

> 
> Thanks,
> -- 
> Pedro Alves
> 

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
