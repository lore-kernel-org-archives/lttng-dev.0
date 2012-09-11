From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [lttng-tools PATCH] Add new thread in consumer
	for	metadata handling
Date: Tue, 11 Sep 2012 18:00:17 -0400
Message-ID: <20120911220016.GC11922__15876.3617313982$1347400842$gmane$org@Krystal>
References: <1347389351-19792-1-git-send-email-dgoulet@efficios.com>
	<20120911195235.GA11196@Krystal> <504F98B2.2020606@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1TBYVG-00042J-4B
	for lttng-dev@lists.lttng.org; Tue, 11 Sep 2012 18:00:18 -0400
Content-Disposition: inline
In-Reply-To: <504F98B2.2020606@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: David Goulet <dgoulet@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* David Goulet (dgoulet@efficios.com) wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA512
> 
> All fixed!
> 
> One comment:
> 
> Mathieu Desnoyers:
> > * David Goulet (dgoulet@efficios.com) wrote:
> >> @@ -1025,9 +1007,22 @@ struct lttng_consumer_local_data
> >> *lttng_consumer_create( goto error_thread_pipe; }
> >> 
> >> -	return ctx; +	ret =
> >> utils_create_pipe(ctx->consumer_metadata_pipe); +	if (ret < 0) { 
> >> +		goto error_metadata_pipe; +	}
> >> 
> >> +	ret = utils_create_pipe(ctx->consumer_splice_metadata_pipe); +
> >> if (ret < 0) { +		goto error_splice_pipe; +	} + +	return ctx;
> >> 
> >> +error_splice_pipe: +
> >> utils_close_pipe(ctx->consumer_metadata_pipe); 
> >> +error_metadata_pipe: +
> >> utils_close_pipe(ctx->consumer_thread_pipe); error_thread_pipe: 
> >> for (i = 0; i < 2; i++) { int err; @@ -1088,6 +1083,8 @@ void
> >> lttng_consumer_destroy(struct lttng_consumer_local_data *ctx) if
> >> (ret) { PERROR("close"); } +
> >> utils_close_pipe(ctx->consumer_splice_metadata_pipe);
> > 
> > hrm, utils_close_pipe(ctx->consumer_thread_pipe); too ?
> 
> It's already closed just before :)

Oh, right, I got mixed up.

Thanks,

Mathieu

> 
> Thanks
> David
> -----BEGIN PGP SIGNATURE-----
> 
> iQEcBAEBCgAGBQJQT5ivAAoJEELoaioR9I02baEIAMW35FGQeW15nOvQ9+uzBDIH
> 80Ug2rEQ6MyESzHdj8I9vyvuFD2LNGcY3Ltjz07LRc3pJp7mYU4JrWBDkamKcN7g
> jMkSmEUQuOY6oWv1VH0YQ9qnNGQrd1shrjh/oHtAZGq1nY+RMIoYPfClX0CbliRY
> vd3nsXcMJODlT4EStNqnevIDf03RXAEAPEwJT2tk1yByBpFvjbCG2oFym+064KAE
> b8oqbwVuN3Ffo0szY/1HoChQPkj5SWBuZolxhSNj438BBIF1tzo7iz9cFrdkUvW0
> 8oeJ5xVAlSy3wuoW1VucYItSsluASGvutbwx/V0jgykxi0BZnKgxZ8lBtbe6mqQ=
> =iANq
> -----END PGP SIGNATURE-----

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
