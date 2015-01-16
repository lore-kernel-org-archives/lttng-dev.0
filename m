From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Addition of the return address to
 liblttng-ust-libc-wrapper
Date: Fri, 16 Jan 2015 20:37:29 +0000 (UTC)
Message-ID: <453311416.43946.1421440649258.JavaMail.zimbra__20635.4299131364$1421440685$gmane$org@efficios.com>
References: <OF7097A1B1.090ABAC2-ONC1257DCC.0053FE7C-C1257DCC.00570880@LocalDomain>
 <1127206322.43789.1421439222351.JavaMail.zimbra@efficios.com>
 <CAFXXi0nzOHHPx+h5vUs-pCe1-zT0T=6jNq6L+EJN6z0Nh-_NMA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1YCDe5-00016t-Ge
 for lttng-dev@lists.lttng.org; Fri, 16 Jan 2015 15:37:33 -0500
In-Reply-To: <CAFXXi0nzOHHPx+h5vUs-pCe1-zT0T=6jNq6L+EJN6z0Nh-_NMA@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Simon Marchi <simon.marchi@polymtl.ca>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

----- Original Message -----
> From: "Simon Marchi" <simon.marchi@polymtl.ca>
> To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
> Cc: "Olivier Delbeke" <Olivier.Delbeke@awtce.be>, lttng-dev@lists.lttng.org
> Sent: Friday, January 16, 2015 3:32:56 PM
> Subject: Re: [lttng-dev] Addition of the return address to liblttng-ust-libc-wrapper
> 
> On 16 January 2015 at 15:13, Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
> >
> > ________________________________
> >
> > From: "Olivier Delbeke" <Olivier.Delbeke@awtce.be>
> > To: lttng-dev@lists.lttng.org
> > Sent: Tuesday, January 13, 2015 10:50:38 AM
> > Subject: [lttng-dev] Addition of the return address to
> > liblttng-ust-libc-wrapper
> >
> > Hi guys,
> >
> >
> > I am using liblttng-ust-libc-wrapper to detect memory leaks in my
> > applications.
> > In order to identify not only the thread where the unfreed allocations are
> > done, but also the calling function, I extended the
> > liblttng-ust-libc-wrapper to log the "return address"
> > (__builtin_return_address(0)) in addition to the parameters of malloc().
> > It solves my problem and does not affect Trace Compass.
> > Was this the right thing to do ?
> >
> >
> > You should be able to achieve the same thing with the "ip" context, e.g.:
> >
> > lttng create
> > lttng enable-event -u -a
> > lttng add-context -u -t ip
> > lttng start
> > ....
> >
> > All this dynamically without changing the instrumentation.
> >
> > Thanks,
> >
> > Mathieu
> 
> I might be wrong, but from what I understand, Olivier's patch recorded
> the address of the caller of malloc. Adding the ip context will record
> the ip of the location of the tracepoint macro call, which will always
> be the same (an address in liblttng-ust-malloc's malloc).
> 

Good point! In that case, adding the caller address as tracepoint parameter
could make sense indeed. Another approach would be to implement a full stack
dump as a context.

Thanks,

Mathieu

> Simon
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
