From: Julien Desfossez <jdesfossez@efficios.com>
Subject: Re: [MODULES RFC PATCH] Extract the bitmask of FDs set
 in select syscall
Date: Thu, 8 Oct 2015 09:53:01 -0400
Message-ID: <20151008135301.GF4504__30624.6224944063$1444312458$gmane$org@sinkpad>
References: <1443826866-24477-1-git-send-email-jdesfossez@efficios.com>
 <1105641809.21377.1444147156884.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from albert.ini-tech.com ([192.99.35.19] helo=smtp.ini-tech.com)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jdesfossez@efficios.com>) id 1ZkBd6-0006t3-I4
 for lttng-dev@lists.lttng.org; Thu, 08 Oct 2015 09:53:13 -0400
Content-Disposition: inline
In-Reply-To: <1105641809.21377.1444147156884.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

> > +#define OVERRIDE_64_select
> > +SC_LTTNG_TRACEPOINT_EVENT_CODE(select,
> > +	TP_PROTO(sc_exit(long ret,) int n, fd_set __user * inp, fd_set __user * outp,
> > +		fd_set __user * exp, struct timeval * tvp),
> > +	TP_ARGS(sc_exit(ret,) n, inp, outp, exp, tvp),
> > +	TP_locvar(
> > +		unsigned long fds_in[__FD_SETSIZE / (8 * sizeof(long))],
> > +			fds_out[__FD_SETSIZE / (8 * sizeof(long))],
> > +			fds_ex[__FD_SETSIZE / (8 * sizeof(long))];
> > +		int nb_in, nb_out, nb_ex;
> > +	),
> > +	TP_code(
> > +		sc_inout(
> > +		{
> > +			unsigned long nr;
> > +			int ret;
> > +
> > +			nr = FDS_BYTES(n);
> > +			tp_locvar->nb_in = 0;
> > +			tp_locvar->nb_out = 0;
> > +			tp_locvar->nb_ex = 0;
> 
> You could initialize them to 0 in TP_locvar (definition).
Hum apparently I can't do anything other than just declaring variables
in the TP_locvar section. Assigning a value to it (at declare time or
afterward) generates a lot of errors.

Julien
