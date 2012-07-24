From: David Goulet <dgoulet@efficios.com>
Subject: Re: [PATCH lttng-tools] Fix: health check and time
Date: Tue, 24 Jul 2012 13:32:12 -0400
Message-ID: <500EDC1C.1030803__33997.1859743402$1343151165$gmane$org@efficios.com>
References: <20120723191204.GA12711@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([213.239.202.151])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1Stixz-0000Sv-BB
	for lttng-dev@lists.lttng.org; Tue, 24 Jul 2012 13:32:15 -0400
In-Reply-To: <20120723191204.GA12711@Krystal>
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

I've just notice something here during testing.

Refer to the comment below.

> +/* * Check health of a specific health state counter. * * Return 0
> if health is bad or else 1. @@ -33,28 +79,55 @@ int
> health_check_state(struct health_state *state) { unsigned long
> current, last; -	int ret = 1; +	struct timespec current_time; +	int
> retval = 1, ret;
> 
> assert(state);
> 
> last = state->last; current = uatomic_read(&state->current); +	ret
> = clock_gettime(CLOCK_MONOTONIC, &current_time); +	if (ret) { +
> PERROR("Error reading time\n"); +		/* error */ +		retval = 0; +
> goto end; +	}
> 
> /* -	 * Here are the conditions for a bad health. Either flag -	 *
> HEALTH_ERROR is set, or the progress counter is the same as -	 *
> the last one and we are NOT waiting for a poll() call. +	 * Thread
> is in are in bad health if flag HEALTH_ERROR is set. It +	 * is
> also in bad health if, after the delta delay has passed, +	 * its
> the progress counter has not moved and it has NOT been +	 * waiting
> for a poll() call. */ -	if ((uatomic_read(&state->flags) &
> HEALTH_ERROR) -			|| (current == last &&
> !HEALTH_IS_IN_POLL(current))) { -		/* error */ -		ret = 0; +	if
> (uatomic_read(&state->flags) & HEALTH_ERROR) { +		retval = 0; +
> goto end; +	} + +	/* +	 * Initial condition need to update the last
> counter and sample +	 * time, but should not check health in this
> initial case, +	 * because we don't know how much time has passed. 
> +	 */ +	if (state->last_time.tv_sec == 0 &&
> state->last_time.tv_nsec == 0) { +		/* update last counter and last
> sample time */ +		state->last = current; +
> memcpy(&state->last_time, &current_time, sizeof(current_time)); +	}
> else { +		if (time_diff_gt(&current_time, &state->last_time,
> &time_delta)) { +			if (current == last &&
> !HEALTH_IS_IN_POLL(current)) { +				/* error */ +				retval = 0;

I think this should "goto end" and NOT followed by an update to the
last counter and time since this makes two health_check return
respectively BAD and OK.

Considering two health check made by let say two applications or/and
users, the second one will indicate a good health which is not true.

Cheers!
David

> +			} +			/* update last counter and last sample time */ +
> state->last = current; +			memcpy(&state->last_time, &current_time,
> sizeof(current_time)); +		} }
> 
> +end: DBG("Health state current %" PRIu64 ", last %" PRIu64 ", ret
> %d", current, last, ret); - -	/* update last counter */ -
> state->last = current; -	return ret; +	return retval; } diff --git
> a/src/bin/lttng-sessiond/health.h
> b/src/bin/lttng-sessiond/health.h index b268860..8f19fe8 100644 ---
> a/src/bin/lttng-sessiond/health.h +++
> b/src/bin/lttng-sessiond/health.h @@ -20,6 +20,7 @@
> 
> #include <stdint.h> #include <urcu/uatomic.h> +#include <time.h>
> 
> /* * These are the value added to the current state depending of
> the position in @@ -37,10 +38,12 @@ enum health_flags {
> 
> struct health_state { /* -	 * last counter is only read and updated
> by the health_check -	 * thread (single updater). +	 * last counter
> and last_time are only read and updated by the +	 * health_check
> thread (single updater). */ unsigned long last; +	struct timespec
> last_time; + /* * current and flags are updated by multiple threads
> concurrently. */ @@ -104,7 +107,9 @@ static inline void
> health_error(struct health_state *state) static inline void
> health_init(struct health_state *state) { assert(state); -
> uatomic_set(&state->last, 0); +	state->last = 0; +
> state->last_time.tv_sec = 0; +	state->last_time.tv_nsec = 0; 
> uatomic_set(&state->current, 0); uatomic_set(&state->flags, 0); }
> 
> 
-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJQDtwXAAoJEELoaioR9I02lDAIAIbNRBj+dB2/mn1RSM22j6hI
fnXckqmHkmdKqsw4UZUHGjrhFqlluwBggXjgQG9KEqZXdCrmv0x5+zam4cqMfHuU
Cu0d8qiqgjnYFtxvftI7FWR7lxOZu3r8r4OtNi27XcyAmKh76+eZc/izLOa8bUOh
keDnY0HYvxL5J4TBECrFdH+GzpMCtwE1zoc0uzp4YaQcXg+83We+KfPg8kCKJK/f
epxVRjsQzz44j1Rr+OcgTfGubAAxT6Tf+ziNu8U7GxFSwciJizVapqbGnj1V6SGs
BRj53xvqrW+DtIROWb/PIDKfddfkjhtWyou1CbkLHUxMEOEKTVnpFuIWSHQEoZk=
=roW8
-----END PGP SIGNATURE-----
