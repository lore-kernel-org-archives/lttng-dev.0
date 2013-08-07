From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Names collisions with LTTng-UST
Date: Tue, 6 Aug 2013 21:17:37 -0400
Message-ID: <20130807011737.GE19407__29643.6299606741$1375838308$gmane$org@Krystal>
References: <CAFXXi0kt1KfRfEPm4T-NqPqEsKQO0n96P2df4Ds6TyJBJPh26Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1V6sNe-0003PH-9t
	for lttng-dev@lists.lttng.org; Tue, 06 Aug 2013 21:17:41 -0400
Content-Disposition: inline
In-Reply-To: <CAFXXi0kt1KfRfEPm4T-NqPqEsKQO0n96P2df4Ds6TyJBJPh26Q@mail.gmail.com>
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

* Simon Marchi (simon.marchi@polymtl.ca) wrote:
> Hello tracing bending units,
> 
> I encountered a problem while trying to put UST tracepoints in GDB
> today. Since GDB defines a struct tracepoint, it conflicts with
> LTTng's struct tracepoint. Renaming all struct tracepoint in UST to
> struct ust_tracepoint, and rebuilding/installing, provided a simple
> workaround. Would it be possible to do change something in LTTng to
> avoid conflicts like this in the future?

Changing "struct tracepoint" would break tracepoint.h API. E.g. an
application doing

sizeof(struct tracepoint)

might start to fail if we change this.

I'm _very_, _very_ reluctant about changing the API, even though this is
not a part of the API that we expect applications to explicitly use.

Also, I think it might be an issue for debugging information if we
change the structure name.

The easiest way would be to work-around this locally in gdb.

Arguably, we should have called this struct lttng_tracepoint from the
beginning, but now is too late.

Thanks,

Mathieu

> 
> Thanks
> 
> Simon
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
