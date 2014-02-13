From: "Woegerer, Paul" <Paul_Woegerer@mentor.com>
Subject: Re: RFC: Fix crash in dlerror()
Date: Thu, 13 Feb 2014 19:44:35 +0000
Message-ID: <A30AF42E15BD64459E202697468DFFA77E387F33__13238.5442652323$1392320759$gmane$org@EU-MBX-04.mgc.mentorg.com>
References: <52F55511.2080309@mentor.com> <52FCCCD2.9050302@mentor.com>
	<610029715.24333.1392300717731.JavaMail.zimbra@efficios.com>
	<1692042945.24342.1392301795996.JavaMail.zimbra@efficios.com>
	<1119459836.24348.1392302831554.JavaMail.zimbra@efficios.com>
	<52FCE732.9090508@mentor.com>
	<581364674.24417.1392309613306.JavaMail.zimbra@efficios.com>
	<52FCF7F5.9070908@mentor.com>,
	<934762932.24558.1392317539645.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Paul_Woegerer@mentor.com>) id 1WE2DF-0002jJ-OL
	for lttng-dev@lists.lttng.org; Thu, 13 Feb 2014 14:44:51 -0500
In-Reply-To: <934762932.24558.1392317539645.JavaMail.zimbra@efficios.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "Seefeld, Stefan" <Stefan_Seefeld@mentor.com>, lttng-dev <lttng-dev@lists.lttng.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-Id: lttng-dev@lists.lttng.org

Sorry for the webmail reply ...

A sequence point is not a memory barrier.
(I will try to come back with more precise arguments tomorrow morning)

--
Thanks,
Paul
________________________________________
From: Mathieu Desnoyers [mathieu.desnoyers@efficios.com]
Sent: Thursday, February 13, 2014 19:52
To: Woegerer, Paul
Cc: Seefeld, Stefan; Paul E. McKenney; lttng-dev
Subject: Re: [lttng-dev] RFC: Fix crash in dlerror()

----- Original Message -----
> From: "Paul Woegerer" <Paul_Woegerer@mentor.com>
> To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
> Cc: "Stefan Seefeld" <Stefan_Seefeld@mentor.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, "lttng-dev"
> <lttng-dev@lists.lttng.org>
> Sent: Thursday, February 13, 2014 11:51:01 AM
> Subject: Re: [lttng-dev] RFC: Fix crash in dlerror()
>
> On 02/13/2014 05:40 PM, Mathieu Desnoyers wrote:
> > (adding back lttng-dev, and CC Paul E. McKenney. He may have
> > some interesting insight in this compiler reordering of store
> > vs function call.)
> >
> > ----- Original Message -----
> >> From: "Paul Woegerer" <Paul_Woegerer@mentor.com>
> >> To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
> >> Cc: "Stefan Seefeld" <Stefan_Seefeld@mentor.com>
> >> Sent: Thursday, February 13, 2014 10:39:30 AM
> >> Subject: Re: [lttng-dev] RFC: Fix crash in dlerror()
> >>
> >> On 02/13/2014 03:47 PM, Mathieu Desnoyers wrote:
> >>> ----- Original Message -----
> >>>> From: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
> >>>> To: "Paul Woegerer" <Paul_Woegerer@mentor.com>
> >>>> Cc: "Stefan Seefeld" <Stefan_Seefeld@mentor.com>
> >>>> Sent: Thursday, February 13, 2014 9:29:56 AM
> >>>> Subject: Re: [lttng-dev] RFC: Fix crash in dlerror()
> >>>>
> >>>> ----- Original Message -----
> >>>>> From: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
> >>>>> To: "Paul Woegerer" <Paul_Woegerer@mentor.com>
> >>>>> Cc: "Stefan Seefeld" <Stefan_Seefeld@mentor.com>
> >>>>> Sent: Thursday, February 13, 2014 9:11:57 AM
> >>>>> Subject: Re: [lttng-dev] RFC: Fix crash in dlerror()
> >>>>>
> >>>>> ----- Original Message -----
> >>>>>> From: "Paul Woegerer" <Paul_Woegerer@mentor.com>
> >>>>>> To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
> >>>>>> Cc: "Stefan Seefeld" <Stefan_Seefeld@mentor.com>
> >>>>>> Sent: Thursday, February 13, 2014 8:46:58 AM
> >>>>>> Subject: Re: [lttng-dev] RFC: Fix crash in dlerror()
> >>>>>>
> >>>>>> On 02/13/2014 02:17 PM, Mathieu Desnoyers wrote:
> > [...]
> >>>>> I've been able to reproduce with
> >>>>>
> >>>>> gcc version 4.8.2 (Debian 4.8.2-14)
> >>>>>
> >>>>> and indeed adding the volatile fixes the issue. But it seems wrong that
> >>>>> the
> >>>>> compiler thinks it is within its rights to assume it can move the store
> >>>>> to that structure after the call to dlsym().
> > [...]
> >
> >>> Adding a cmm_barrier() between the call to setup_static_allocator() and
> >>> the first dlsym() call fixes the issue too.
> >>>
> >>> Thoughts ?
> >> Intuitively I would have thought that the def-use analysis of the compiler
> >> recognizes the first def to the fields as redundant.
> >>
> >> e.g.
> >>
> >> def cur_alloc.calloc (1)
> >> def cur_alloc.calloc (2)
> >> use cur_alloc.calloc
> >>
> >> so from compiler perspective (1) is redundant.
> > Well actually, it's more:
> >
> > def cur_alloc.calloc (1)
> >
> >   calls to dlsym() (should act as a compiler memory barrier)
> >
> > def cur_alloc.calloc (2)
> >
> > (where the use of cur_alloc.calloc is within the dlsym() call)
> >
> > What seems to happen here is that gcc somehow assumes that dlsym() will
> > never
> > be interested in the value of the static variable cur_alloc.calloc. But I
> > doubt
> > this assumption is valid, because dlsym() could very well have access to a
> > function pointer leading to a function within the object containing
> > cur_alloc,
> > and thus have to access cur_alloc. How can this store be optimized away
> > without
>
> To assume that dlsym() has "access" to the local static variable
> cur_alloc is not something anyone should expect from the compiler. The
> fact that dlsym() does have "access" is only due to preloading and the
> circumstance that library functions that dlsym() itself uses are
> redirected to the ones defined in the wrapper.

Can you provide quotes of the relevant parts of the C99 standard supporting
this ?

My understanding is that there is a sequence point before the function call:

ISO/IEC 9899:TC2

5.1.2.3 Program execution

"2. Accessing a volatile object, modifying an object, modifying a file, or
calling a function that does any of those operations are all side effects,11)
which are changes in the state of the execution environment. Evaluation of an
expression may produce side effects. At certain specified points in the execution
sequence called sequence points, all side effects of previous evaluations shall
be complete and no side effects of subsequent evaluations shall have taken place.
(A summary of the sequence points is given in annex C.)"


6.5.2.2 Function calls

"10.  The order of evaluation of the function designator, the actual arguments, and
subexpressions within the actual arguments is unspecified, but there is a sequence
point before the actual call."

And this sequence point should ensure that the side-effects of stores to cur_alloc
should be complete before the call takes place.

Thoughts ?

Thanks,

Mathieu

>
> --
> Best,
> Paul
>
> > breaking sequential consistency ?
> >
> >> It cannot know about the indirect recursion via dlsym. To express this to
> >> the
> >> compiler you have to make the fields of your struct volatile.
> > AFAIK, the compiler should assume that there may be a call to a function
> > using
> > cur_alloc within dlsym().
> >
> >> BTW, for copying cur_alloc, let the compiler create the memcpy for you.
> > Good point!
> >
> > I don't see how volatile would be required here. Maybe it fixes the issue
> > (so does adding a compiler barrier), but I feel uneasy just fixing it up
> > within lttng-ust if there is a deeper issue in gcc 4.8.
> >
> > Thoughts ?
> >
> > Thanks,
> >
> > Mathieu
> >
> >
>
>
> --
> Paul Woegerer, SW Development Engineer
> Sourcery Analyzer <http://go.mentor.com/sourceryanalyzer>
> Mentor Graphics, Embedded Software Division
>
>

--
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
