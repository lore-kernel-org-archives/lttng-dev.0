From: David Goulet <dgoulet@efficios.com>
Subject: Re: [lttng-tools PATCH] Add new thread in consumer for
 metadata handling
Date: Tue, 11 Sep 2012 16:01:54 -0400
Message-ID: <504F98B2.2020606__46974.5206334212$1347393742$gmane$org@efficios.com>
References: <1347389351-19792-1-git-send-email-dgoulet@efficios.com>
	<20120911195235.GA11196@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([213.239.202.151])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1TBWej-000372-L4
	for lttng-dev@lists.lttng.org; Tue, 11 Sep 2012 16:01:57 -0400
In-Reply-To: <20120911195235.GA11196@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

All fixed!

One comment:

Mathieu Desnoyers:
> * David Goulet (dgoulet@efficios.com) wrote:
>> @@ -1025,9 +1007,22 @@ struct lttng_consumer_local_data
>> *lttng_consumer_create( goto error_thread_pipe; }
>> 
>> -	return ctx; +	ret =
>> utils_create_pipe(ctx->consumer_metadata_pipe); +	if (ret < 0) { 
>> +		goto error_metadata_pipe; +	}
>> 
>> +	ret = utils_create_pipe(ctx->consumer_splice_metadata_pipe); +
>> if (ret < 0) { +		goto error_splice_pipe; +	} + +	return ctx;
>> 
>> +error_splice_pipe: +
>> utils_close_pipe(ctx->consumer_metadata_pipe); 
>> +error_metadata_pipe: +
>> utils_close_pipe(ctx->consumer_thread_pipe); error_thread_pipe: 
>> for (i = 0; i < 2; i++) { int err; @@ -1088,6 +1083,8 @@ void
>> lttng_consumer_destroy(struct lttng_consumer_local_data *ctx) if
>> (ret) { PERROR("close"); } +
>> utils_close_pipe(ctx->consumer_splice_metadata_pipe);
> 
> hrm, utils_close_pipe(ctx->consumer_thread_pipe); too ?

It's already closed just before :)

Thanks
David
-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJQT5ivAAoJEELoaioR9I02baEIAMW35FGQeW15nOvQ9+uzBDIH
80Ug2rEQ6MyESzHdj8I9vyvuFD2LNGcY3Ltjz07LRc3pJp7mYU4JrWBDkamKcN7g
jMkSmEUQuOY6oWv1VH0YQ9qnNGQrd1shrjh/oHtAZGq1nY+RMIoYPfClX0CbliRY
vd3nsXcMJODlT4EStNqnevIDf03RXAEAPEwJT2tk1yByBpFvjbCG2oFym+064KAE
b8oqbwVuN3Ffo0szY/1HoChQPkj5SWBuZolxhSNj438BBIF1tzo7iz9cFrdkUvW0
8oeJ5xVAlSy3wuoW1VucYItSsluASGvutbwx/V0jgykxi0BZnKgxZ8lBtbe6mqQ=
=iANq
-----END PGP SIGNATURE-----
