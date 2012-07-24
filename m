From: David Goulet <dgoulet@efficios.com>
Subject: Re: [PATCH lttng-tools] Fix: health check and time
Date: Tue, 24 Jul 2012 14:19:22 -0400
Message-ID: <500EE72A.8050907__19013.5075165474$1343153995$gmane$org@efficios.com>
References: <20120723191204.GA12711@Krystal> <500EDC1C.1030803@efficios.com>
	<20120724181629.GA2285@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([213.239.202.151])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1Stjhc-0000qa-Vy
	for lttng-dev@lists.lttng.org; Tue, 24 Jul 2012 14:19:25 -0400
In-Reply-To: <20120724181629.GA2285@Krystal>
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

Makes sense to me.

I'll push that!

Thanks!
David

Mathieu Desnoyers:
> * David Goulet (dgoulet@efficios.com) wrote:
>> -----BEGIN PGP SIGNED MESSAGE----- Hash: SHA512
>> 
>> I've just notice something here during testing.
>> 
>> Refer to the comment below.
>> 
> [...]
>> I think this should "goto end" and NOT followed by an update to
>> the last counter and time since this makes two health_check
>> return respectively BAD and OK.
>> 
>> Considering two health check made by let say two applications
>> or/and users, the second one will indicate a good health which is
>> not true.
>> 
>> Cheers! David
> 
> How about the following fix ?
> 
> Fix: set health to bad state for good when error state detected
> 
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com> 
> --- diff --git a/src/bin/lttng-sessiond/health.c
> b/src/bin/lttng-sessiond/health.c index 7bf41c8..3637225 100644 ---
> a/src/bin/lttng-sessiond/health.c +++
> b/src/bin/lttng-sessiond/health.c @@ -114,6 +114,7 @@ int
> health_check_state(struct health_state *state) if
> (time_diff_gt(&current_time, &state->last_time, &time_delta)) { if
> (current == last && !HEALTH_IS_IN_POLL(current)) { /* error */ +
> uatomic_or(&state->flags, HEALTH_ERROR); retval = 0; } /* update
> last counter and last sample time */
> 
-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJQDucnAAoJEELoaioR9I027TMIAKzW18p6B8q/ZvJzzjsQ6Je3
sspGevoHwxMydjuoVA8fuVHp/+IwN1g4SFGfROXHdNP8736PFYopjKDSI1L4gFFA
au2jGgYVoMWvbQoyqVnlaLayE+g9EvlQQPkNdDYVSFQEeqOpfCICvhGBboZYRuwa
bFPyId6mgJQtMEAdut2dh8J79qUzw0pqsKTXs7hSZsaXjGowU6GvrL7QGe/mtQlL
jhWlLd4KrwxHaTpCutfdjQJEe1bpyaniBMKT84k3eWPYX4aguoMtJ7QgYw5db5iL
dKy+Elpd4vRkVnr9R9ZL+jIWzlYi3EJ6gb0zfYBijwfecxEzQ9Jq6top04Uubok=
=21s5
-----END PGP SIGNATURE-----
