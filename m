From: David Goulet <dgoulet@efficios.com>
Subject: Re: [lttng-tools PATCH] Add new thread in consumer for
	metadata handling
Date: Tue, 18 Sep 2012 11:22:33 -0400
Message-ID: <505891B9.8040809__40203.8690554493$1347981790$gmane$org@efficios.com>
References: <1347389351-19792-1-git-send-email-dgoulet@efficios.com>
	<50583801.4030205@keymile.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([213.239.202.151])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1TDzdF-00054B-MV
	for lttng-dev@lists.lttng.org; Tue, 18 Sep 2012 11:22:37 -0400
In-Reply-To: <50583801.4030205@keymile.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Gerlando Falauto <gerlando.falauto@keymile.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

Hi Gerlando,

I've fix this upstream:

commit 4adabd6161a6decfcd21108b45df6959c34de74c
Author: David Goulet <dgoulet@efficios.com>
Date:   Tue Sep 18 11:13:33 2012 -0400

    Fix: Remove LPOLLNVAL from consumer metadata revents

    Without epoll(7), this value does not exist in the compat layer. For
    now, this poll error is set within the LPOLLHUP in the poll(2) compat
    header and POLLNVAL of epoll is set to POLLHUP so we basically don't
    need it at all if we simply use the LPOLLHUP code.

    Signed-off-by: David Goulet <dgoulet@efficios.com>

Thanks for reporting!

David

Gerlando Falauto:
> Hi David,
> 
> On 09/11/2012 08:49 PM, David Goulet wrote:
>> To prioritize the consumption of the metadata, this patch 
>> introduce a new thread in the consumer which exclusively handles 
>> metadata in order to separate them from the trace data.
> [...]
>> +            /* Check the metadata pipe for incoming metadata. */
>> +            if (pollfd == ctx->consumer_metadata_pipe[0]) { + if
>> (revents&  (LPOLLERR | LPOLLHUP | LPOLLNVAL)) { + DBG("Metadata
>> thread pipe hung up"); +                    /* + * Remove the
>> pipe from the poll set and continue the loop
> 
> Since we don't HAVE_EPOLL, we get:
> 
> consumer.c: In function 'lttng_consumer_thread_poll_metadata': 
> consumer.c:1700:42: error: 'LPOLLNVAL' undeclared (first use in 
> this function) consumer.c:1700:42: note: each undeclared
> identifier is reported only once for each function it appears in
> 
> For some reason, compat/poll.h defines: LPOLLERR = POLLERR, 
> LPOLLHUP = POLLHUP | POLLNVAL, /* Close on exec feature does not 
> exist for poll(2) */ LTTNG_CLOEXEC = 0xdead,
> 
> Whereas with HAVE_EPOLL we have: LPOLLHUP = EPOLLHUP, LPOLLNVAL = 
> EPOLLHUP, LPOLLRDHUP = EPOLLRDHUP,
> 
> I would patch this myself but I'm a bit confused by the above...
> 
> Thanks! Gerlando
-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJQWJG1AAoJEELoaioR9I02rq8IAIB9fk+gOPK5wCat4ASe2Q69
vr9kcUktlNt9QKdWxHd8p9bOQe4oHtMEK9hk/CwTUuEFb4dygbWi1PkxiVFj/OZR
RECc+EmuMBx1GWnYFfBKlRLTlcANGipC4co4CcKpe4m4ja12M9OmfJBfa6VHh1m3
gVPPlZ5Sa/lWYijK1dIf6RkqIiOu4daIsU+orxLr3F4buxnVnvs1WJVoI/SLb8AO
hAu5XDacJW6i3XMKnY6qSCBL8XwJH9YRPZxahV6Xw94yKaAPtNjwkYUzav9ow6O1
IlGQ8F93vvk7nDf2AaqPSvYQBJw9zl/5MLjltA4pnlZkoLBhcUTji/VFCeP4Bo8=
=dO2o
-----END PGP SIGNATURE-----
