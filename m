From: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Subject: Re: [PATCH lttng-tools v2] Fix: timeout for connect is
 not respected
Date: Fri, 9 Nov 2018 13:52:47 -0500
Message-ID: <20181109185247.GA18673__35251.4476202943$1541789457$gmane$org@joraj-alpa>
References: <237752dff54ba084bc7dcb4b117a66e6@polymtl.ca>
 <20181109153728.10409-1-jonathan.rajotte-julien@efficios.com>
 <189861781.3267.1541782550119.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 42s8RR6hdfzqYS
 for <lttng-dev@lists.lttng.org>; Fri,  9 Nov 2018 13:52:51 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <189861781.3267.1541782550119.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, Jeremie Galarneau <jgalar@efficios.com>
List-Id: lttng-dev@lists.lttng.org

> > diff --git a/src/common/sessiond-comm/inet.c b/src/common/sessiond-comm=
/inet.c
> > index e0b3e7a96..94a3c3a67 100644
> > --- a/src/common/sessiond-comm/inet.c
> > +++ b/src/common/sessiond-comm/inet.c
> > @@ -119,16 +119,28 @@ static
> > unsigned long time_diff_ms(struct timespec *time_a,
> > 		struct timespec *time_b)
> > {
> > -	time_t sec_diff;
> > -	long nsec_diff;
> > -	unsigned long result_ms;
> > +	struct timespec diff;
> > =

> > -	sec_diff =3D time_a->tv_sec - time_b->tv_sec;
> > -	nsec_diff =3D time_a->tv_nsec - time_b->tv_nsec;
> > +	diff.tv_sec =3D time_a->tv_sec - time_b->tv_sec;
> > +	diff.tv_nsec =3D time_a->tv_nsec - time_b->tv_nsec;
> > =

> > -	result_ms =3D sec_diff * MSEC_PER_SEC;
> > -	result_ms +=3D nsec_diff / NSEC_PER_MSEC;
> > -	return result_ms;
> > +	if (diff.tv_nsec < 0) {
> > +		/* Perform borrow operation */
> > +		diff.tv_sec -=3D 1;
> > +		diff.tv_nsec +=3D NSEC_PER_SEC;
> > +	}
> > +
> > +	if (diff.tv_sec < 0) {
> > +		/* We went back in time. Put all to zero */
> > +		diff.tv_sec =3D 0;
> > +		diff.tv_nsec =3D 0;
> > +	}
> =

> Why would a diff operation implicitly floor everything to 0 when
> time_a < time_b ?

Sure I can implement it as a real difference without the same "assumptions"=
 of
time_a > time_b since we are comparing passing time.

Make sure to tell this to past Mathieu ;).

> =

> > +
> > +	/*
> > +	 * Transform into MSEC, diff.tv_nsec is always positive due to borrow
> > +	 * operation. diff.tb_sec is always positive.
> =

> tb_sec -> tv_nsec

Fixed.

> =

> =

> > +	 */
> > +	return (diff.tv_sec * MSEC_PER_SEC) + (diff.tv_nsec / NSEC_PER_MSEC);
> =

> How do we handle time delta difference that overflows unsigned long ?

Let's do a quick calculation. Correct me if anything is wrong here.

How many msec does a unsigned long hold?
A long is *minimum* 32 bits. Yielding a maximum value of 4294967295. [1]

Lets assume that the nanoseconds part of the diff struct is maxed out. The
nanoseconds part yield 99 ms.

4294967295 - 99 =3D 4294967196ms

How big would the second field of diff be a problem?

4294967196/ MSEC_PER_SEC =3D 4294967s or 49 days.

I would err on the side of "that it's enough". We also have to take into
account that for this to happen either something is going horribly wrong du=
ring
getting the current time or the user purposely set the timeout to this value
since we sample every 200ms.
Which at this point goes into the PEBKAC category.

Do you agree?

[1] http://www.open-std.org/jtc1/sc22/wg14/www/docs/n1256.pdf p.22 =A75.2.4=
.2.1

> =

> > }
> > =

> > static
> > diff --git a/src/common/sessiond-comm/inet6.c b/src/common/sessiond-com=
m/inet6.c
> > index dfb5fc5d1..07043e93f 100644
> > --- a/src/common/sessiond-comm/inet6.c
> > +++ b/src/common/sessiond-comm/inet6.c
> > @@ -117,16 +117,28 @@ static
> > unsigned long time_diff_ms(struct timespec *time_a,
> > 		struct timespec *time_b)
> =

> This should be moved to a common implementation file. It's a cut and
> paste from inet.c.

Past Mathieu did not seems to bother here.

I'm open into doing this in two patches since this should be backported. Do=
 you
have a suggestion regarding where to put it?

> =

> Thanks,
> =

> Mathieu
> =

> > {
> > -	time_t sec_diff;
> > -	long nsec_diff;
> > -	unsigned long result_ms;
> > +	struct timespec diff;
> > =

> > -	sec_diff =3D time_a->tv_sec - time_b->tv_sec;
> > -	nsec_diff =3D time_a->tv_nsec - time_b->tv_nsec;
> > +	diff.tv_sec =3D time_a->tv_sec - time_b->tv_sec;
> > +	diff.tv_nsec =3D time_a->tv_nsec - time_b->tv_nsec;
> > =

> > -	result_ms =3D sec_diff * MSEC_PER_SEC;
> > -	result_ms +=3D nsec_diff / NSEC_PER_MSEC;
> > -	return result_ms;
> > +	if (diff.tv_nsec < 0) {
> > +		/* Perform borrow operation */
> > +		diff.tv_sec -=3D 1;
> > +		diff.tv_nsec +=3D NSEC_PER_SEC;
> > +	}
> > +
> > +	if (diff.tv_sec < 0) {
> > +		/* We went back in time. Put all to zero */
> > +		diff.tv_sec =3D 0;
> > +		diff.tv_nsec =3D 0;
> > +	}
> > +
> > +	/*
> > +	 * Transform into MSEC, diff.tv_nsec is always positive due to borrow
> > +	 * operation. diff.tb_sec is always positive.
> > +	 */
> > +	return (diff.tv_sec * MSEC_PER_SEC) + (diff.tv_nsec / NSEC_PER_MSEC);
> > }
> > =

> > static
> > --
> > 2.17.1
> > =

> > _______________________________________________
> > lttng-dev mailing list
> > lttng-dev@lists.lttng.org
> > https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> =

> -- =

> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com

-- =

Jonathan Rajotte-Julien
EfficiOS
