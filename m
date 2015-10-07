From: Julien Desfossez <julien.desfossez@polymtl.ca>
Subject: Re: [MODULES RFC PATCH] Extract the bitmask of FDs set
 in select syscall
Date: Wed, 7 Oct 2015 14:37:23 -0400
Message-ID: <20151007183723.GI12230__10121.7271214866$1444243105$gmane$org@sinkpad>
References: <1443826866-24477-1-git-send-email-jdesfossez@efficios.com>
 <1105641809.21377.1444147156884.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from albert.ini-tech.com ([192.99.35.19] helo=smtp.ini-tech.com)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <julien.desfossez@polymtl.ca>) id 1Zjtam-000170-PI
 for lttng-dev@lists.lttng.org; Wed, 07 Oct 2015 14:37:34 -0400
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
Cc: lttng-dev <lttng-dev@lists.lttng.org>, Julien Desfossez <jdesfossez@efficios.com>
List-Id: lttng-dev@lists.lttng.org

> > .../x86-64-syscalls-3.10.0-rc7_pointers_override.h | 56 ++++++++++++++++++++++
> 
> Does it have to be a x86-64 specific override, or it could be used
> as an override for all architectures ?
Indeed I will move it as an override for all architectures.

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
Good point.

> > +			if (inp) {
> > +				ret = copy_from_user(tp_locvar->fds_in, inp, nr);
> 
> Why use copy_from_user() here rather than get_fd_set() ?
I had a problem with the memset to 0 on error, I don't remember why,
I'll try again with that.

> > +	TP_FIELDS(
> > +		sc_exit(ctf_integer(long, ret, ret))
> > +		sc_in(ctf_integer(int, n, n))
> > +		sc_inout(ctf_sequence_hex(unsigned long, fdset_in,
> > +				&tp_locvar->fds_in, unsigned long, tp_locvar->nb_in))
> 
> If we want to make this code portable, is it really an array of unsigned long in the
> trace ? What is the layout on a 32-bit architecture ?
This way of working is what is done by select() itself. On 64-bit we
have a maximum of 16 unsigned longs (to handle up to 16*8 = 1024 FDs),
on 32-bit it is 32 unsigned longs (32 * 4 = 1024).

I would also prefer a way to extract a clean list of FDs instead of a
bitmask and potentially waste stack space, but I don't see how without
needing to allocate/free memory or have an arbitrary limit.

Thanks

Julien
