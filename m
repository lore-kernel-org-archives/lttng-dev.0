From: David Goulet <dgoulet@efficios.com>
Subject: Re: [PATCH lttng-tools] Fix: health monitoring (various
 fixes)
Date: Tue, 24 Jul 2012 12:19:45 -0400
Message-ID: <500ECB21.8030204__18234.5774177977$1343146821$gmane$org@efficios.com>
References: <20120723180041.GA12458@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([213.239.202.151])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1Sthpu-0008Kg-D5
	for lttng-dev@lists.lttng.org; Tue, 24 Jul 2012 12:19:50 -0400
In-Reply-To: <20120723180041.GA12458@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org, dgoulet@efficios.com
List-Id: lttng-dev@lists.lttng.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

I just merged this commit with small modifications here and there on
the comments and error messages but all in all, these fixes are the
same and upstream.

Thanks!
David

Mathieu Desnoyers:
> * Fix modulo operation bug on #define HEALTH_IS_IN_CODE(x) (x %
> HEALTH_POLL_VALUE) which is causing the check to think it is never
> within code. (x % 1 always equals 0). Simplify this by using a
> simple & on the poll value, and remove the IS_IN_CODE, using ! on
> IS_IN_POLL instead (which removes nothing to clarity). * Atomic
> operations should apply to at most "unsigned long" (32-bit on 
> 32-bit arch) rather than uint64_t. * Separate the "error" condition
> from the counters. We clearly cannot use the "0" value as an error
> on 32-bit counters anymore, because they can easily wrap. *
> Introduce "exit" condition, will be useful for state tracking in
> the future. Error and exit conditions implemented as flags. * Add
> "APP_MANAGE" in addition to "APP_REG" health check, to monitor the 
> app registration thread (which was missing, only the app manager 
> thread was checked, under the name "APP_REG", which was
> misleading). * Comment the last, current and flag values in struct
> health state, especially how they are accessed. * Remove bogus
> usage of uatomic_xchg() in health_check_state(): It is not needed
> to update the "last" value, since the last value is read and
> written to by a single thread. Moreover, this specific use of xchg
> was not exchanging anything: it was just setting the last value to
> the "current" one, and doing nothing with the return value. 
> Whatever was expected to be achieved by using uatomic_xchg()
> clearly wasn't. * Because the health check thread could still be
> answering a request concurrently sessiond teardown, we need to
> ensure that all threads only set the "error" condition if they
> reach teardown paths due to an actual error, not on "normal"
> teardown condition (thread quit pipe being closed). Flagging
> threads as being in error condition upon all exit paths would lead
> to false "errors" sent to the client, which we want to avoid, since
> the client could then think it needs to kill a sessiond when the
> sessiond might be in the process of gracefully restarting.
> 
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com> 
> CC: David Goulet <dgoulet@efficios.com> --- diff --git
> a/include/lttng/lttng.h b/include/lttng/lttng.h index
> 6823579..7754bcd 100644 --- a/include/lttng/lttng.h +++
> b/include/lttng/lttng.h @@ -134,6 +134,7 @@ enum
> lttng_calibrate_type { /* Health component for the health check
> function. */ enum lttng_health_component { LTTNG_HEALTH_CMD, +
> LTTNG_HEALTH_APP_MANAGE, LTTNG_HEALTH_APP_REG, 
> LTTNG_HEALTH_KERNEL, LTTNG_HEALTH_CONSUMER, diff --git
> a/src/bin/lttng-sessiond/health.c
> b/src/bin/lttng-sessiond/health.c index 58f804e..d7d25cf 100644 ---
> a/src/bin/lttng-sessiond/health.c +++
> b/src/bin/lttng-sessiond/health.c @@ -32,33 +32,29 @@ */ int
> health_check_state(struct health_state *state) { -	int ret; -
> uint64_t current; -	uint64_t last; +	unsigned long current, last; +
> int ret = 1;
> 
> assert(state);
> 
> +	last = state->last; current = uatomic_read(&state->current); -
> last = uatomic_read(&state->last);
> 
> /* -	 * Here are the conditions for a bad health. Current state set
> to 0 or the -	 * current state is the same as the last one and we
> are NOT waiting for a -	 * poll() call. +	 * Here are the
> conditions for a bad health. Either flag +	 * HEALTH_ERROR is set,
> or the progress counter is the same as +	 * the last one and we are
> NOT waiting for a poll() call. */ -	if (current == 0 || (current ==
> last && HEALTH_IS_IN_CODE(current))) { +	if
> ((uatomic_read(&state->flags) & HEALTH_ERROR) +			|| (current ==
> last && !HEALTH_IS_IN_POLL(current))) { +		/* error */ ret = 0; -
> goto error; }
> 
> -	/* All good */ -	ret = 1; - -error: DBG("Health state current %"
> PRIu64 ", last %" PRIu64 ", ret %d", current, last, ret);
> 
> -	/* Exchange current state counter into last one */ -
> uatomic_xchg(&state->last, state->current); +	/* update last
> counter */ +	state->last = current; return ret; } diff --git
> a/src/bin/lttng-sessiond/health.h
> b/src/bin/lttng-sessiond/health.h index 9a1ef39..b268860 100644 ---
> a/src/bin/lttng-sessiond/health.h +++
> b/src/bin/lttng-sessiond/health.h @@ -25,20 +25,35 @@ * These are
> the value added to the current state depending of the position in *
> the thread where is either waiting on a poll() or running in the
> code. */ -#define HEALTH_POLL_VALUE 1 -#define HEALTH_CODE_VALUE 2 
> +#define HEALTH_POLL_VALUE 	(1UL << 0) +#define HEALTH_CODE_VALUE
> (1UL << 1)
> 
> -#define HEALTH_IS_IN_POLL(x) (x % HEALTH_CODE_VALUE) -#define
> HEALTH_IS_IN_CODE(x) (x % HEALTH_POLL_VALUE) +#define
> HEALTH_IS_IN_POLL(x)	((x) & HEALTH_POLL_VALUE) + +enum health_flags
> { +	HEALTH_EXIT = (1U << 0), +	HEALTH_ERROR = (1U << 1), +};
> 
> struct health_state { -	uint64_t last; -	uint64_t current; +	/* +
> * last counter is only read and updated by the health_check +	 *
> thread (single updater). +	 */ +	unsigned long last; +	/* +	 *
> current and flags are updated by multiple threads concurrently. +
> */ +	unsigned long current;		/* progress counter, updated
> atomically */ +	enum health_flags flags;	/* other flags, updated
> atomically */ };
> 
> /* Health state counters for the client command thread */ extern
> struct health_state health_thread_cmd;
> 
> +/* Health state counters for the application management thread */ 
> +extern struct health_state health_thread_app_manage; + /* Health
> state counters for the application registration thread */ extern
> struct health_state health_thread_app_reg;
> 
> @@ -46,36 +61,41 @@ extern struct health_state
> health_thread_app_reg; extern struct health_state
> health_thread_kernel;
> 
> /* - * Update current counter by 1 to indicate that the thread is
> in a blocking - * state cause by a poll(). + * Update current
> counter by 1 to indicate that the thread entered or + * left a
> blocking state caused by a poll(). */ static inline void
> health_poll_update(struct health_state *state) { assert(state); - 
> uatomic_add(&state->current, HEALTH_POLL_VALUE); }
> 
> /* - * Update current counter by 2 which indicates that we are
> currently running in - * a thread and NOT blocked at a poll(). + *
> Update current counter by 2 indicates progress in execution of a +
> * thread. */ static inline void health_code_update(struct
> health_state *state) { assert(state); - 
> uatomic_add(&state->current, HEALTH_CODE_VALUE); }
> 
> /* - * Reset health state. A value of zero indicate a bad health
> state. + * Set health "exit" flag. */ -static inline void
> health_reset(struct health_state *state) +static inline void
> health_exit(struct health_state *state) { assert(state); +
> uatomic_or(&state->flags, HEALTH_EXIT); +}
> 
> -	uatomic_set(&state->current, 0); -	uatomic_set(&state->last, 0); 
> +/* + * Set health "error" flag. + */ +static inline void
> health_error(struct health_state *state) +{ +	assert(state); +
> uatomic_or(&state->flags, HEALTH_ERROR); }
> 
> /* @@ -84,9 +104,9 @@ static inline void health_reset(struct
> health_state *state) static inline void health_init(struct
> health_state *state) { assert(state); - uatomic_set(&state->last,
> 0); -	uatomic_set(&state->current, HEALTH_CODE_VALUE); +
> uatomic_set(&state->current, 0); +	uatomic_set(&state->flags, 0); 
> }
> 
> int health_check_state(struct health_state *state); diff --git
> a/src/bin/lttng-sessiond/main.c b/src/bin/lttng-sessiond/main.c 
> index 5664b0b..c699f1b 100644 --- a/src/bin/lttng-sessiond/main.c 
> +++ b/src/bin/lttng-sessiond/main.c @@ -216,6 +216,7 @@ static
> unsigned int relayd_net_seq_idx;
> 
> /* Used for the health monitoring of the session daemon. See
> health.h */ struct health_state health_thread_cmd; +struct
> health_state health_thread_app_manage; struct health_state
> health_thread_app_reg; struct health_state health_thread_kernel;
> 
> @@ -716,7 +717,7 @@ static void update_ust_app(int app_sock) */ 
> static void *thread_manage_kernel(void *data) { -	int ret, i,
> pollfd, update_poll_flag = 1; +	int ret, i, pollfd,
> update_poll_flag = 1, err = -1; uint32_t revents, nb_fd; char tmp; 
> struct lttng_poll_event events; @@ -789,7 +790,8 @@ static void
> *thread_manage_kernel(void *data) /* Thread quit pipe has been
> closed. Killing thread. */ ret = check_thread_quit_pipe(pollfd,
> revents); if (ret) { -				goto error; +				err = 0; +				goto
> exit; }
> 
> /* Check for data on kernel pipe */ @@ -817,10 +819,15 @@ static
> void *thread_manage_kernel(void *data) } }
> 
> +exit: error: lttng_poll_clean(&events); error_poll_create: -
> health_reset(&health_thread_kernel); +	if (err) { +		DBG("An error
> occurred in %s", __func__); +
> health_error(&health_thread_kernel); +	} +
> health_exit(&health_thread_kernel); DBG("Kernel thread dying"); 
> return NULL; } @@ -830,7 +837,7 @@ error_poll_create: */ static
> void *thread_manage_consumer(void *data) { -	int sock = -1, i, ret,
> pollfd; +	int sock = -1, i, ret, pollfd, err = -1; uint32_t
> revents, nb_fd; enum lttcomm_return_code code; struct
> lttng_poll_event events; @@ -888,7 +895,8 @@ restart: /* Thread
> quit pipe has been closed. Killing thread. */ ret =
> check_thread_quit_pipe(pollfd, revents); if (ret) { -			goto
> error; +			err = 0; +			goto exit; }
> 
> /* Event on the registration socket */ @@ -976,7 +984,8 @@
> restart_poll: /* Thread quit pipe has been closed. Killing thread.
> */ ret = check_thread_quit_pipe(pollfd, revents); if (ret) { -
> goto error; +			err = 0; +			goto exit; }
> 
> /* Event on the kconsumerd socket */ @@ -1000,6 +1009,7 @@
> restart_poll:
> 
> ERR("consumer return code : %s",
> lttcomm_get_readable_code(-code));
> 
> +exit: error: /* Immediately set the consumerd state to stopped */ 
> if (consumer_data->type == LTTNG_CONSUMER_KERNEL) { @@ -1038,7
> +1048,11 @@ error: lttng_poll_clean(&events); error_poll: 
> error_listen: -	health_reset(&consumer_data->health); +	if (err) { 
> +		DBG("An error occurred in %s", __func__); +
> health_error(&consumer_data->health); +	} +
> health_exit(&consumer_data->health); DBG("consumer thread cleanup
> completed");
> 
> return NULL; @@ -1049,7 +1063,7 @@ error_listen: */ static void
> *thread_manage_apps(void *data) { -	int i, ret, pollfd; +	int i,
> ret, pollfd, err = -1; uint32_t revents, nb_fd; struct ust_command
> ust_cmd; struct lttng_poll_event events; @@ -1059,7 +1073,7 @@
> static void *thread_manage_apps(void *data) rcu_register_thread(); 
> rcu_thread_online();
> 
> -	health_code_update(&health_thread_app_reg); +
> health_code_update(&health_thread_app_manage);
> 
> ret = create_thread_poll_set(&events, 2); if (ret < 0) { @@ -1071,7
> +1085,7 @@ static void *thread_manage_apps(void *data) goto error; 
> }
> 
> -	health_code_update(&health_thread_app_reg); +
> health_code_update(&health_thread_app_manage);
> 
> while (1) { /* Zeroed the events structure */ @@ -1083,9 +1097,9 @@
> static void *thread_manage_apps(void *data)
> 
> /* Inifinite blocking call, waiting for transmission */ restart: -
> health_poll_update(&health_thread_app_reg); +
> health_poll_update(&health_thread_app_manage); ret =
> lttng_poll_wait(&events, -1); -
> health_poll_update(&health_thread_app_reg); +
> health_poll_update(&health_thread_app_manage); if (ret < 0) { /* *
> Restart interrupted system call. @@ -1101,12 +1115,13 @@ static
> void *thread_manage_apps(void *data) revents =
> LTTNG_POLL_GETEV(&events, i); pollfd = LTTNG_POLL_GETFD(&events,
> i);
> 
> -			health_code_update(&health_thread_app_reg); +
> health_code_update(&health_thread_app_manage);
> 
> /* Thread quit pipe has been closed. Killing thread. */ ret =
> check_thread_quit_pipe(pollfd, revents); if (ret) { -				goto
> error; +				err = 0; +				goto exit; }
> 
> /* Inspect the apps cmd pipe */ @@ -1122,7 +1137,7 @@ static void
> *thread_manage_apps(void *data) goto error; }
> 
> -					health_code_update(&health_thread_app_reg); +
> health_code_update(&health_thread_app_manage);
> 
> /* Register applicaton to the session daemon */ ret =
> ust_app_register(&ust_cmd.reg_msg, @@ -1133,7 +1148,7 @@ static
> void *thread_manage_apps(void *data) break; }
> 
> -					health_code_update(&health_thread_app_reg); +
> health_code_update(&health_thread_app_manage);
> 
> /* * Validate UST version compatibility. @@ -1147,7 +1162,7 @@
> static void *thread_manage_apps(void *data) 
> update_ust_app(ust_cmd.sock); }
> 
> -					health_code_update(&health_thread_app_reg); +
> health_code_update(&health_thread_app_manage);
> 
> ret = ust_app_register_done(ust_cmd.sock); if (ret < 0) { @@
> -1172,7 +1187,7 @@ static void *thread_manage_apps(void *data) 
> ust_cmd.sock); }
> 
> -					health_code_update(&health_thread_app_reg); +
> health_code_update(&health_thread_app_manage);
> 
> break; } @@ -1194,14 +1209,19 @@ static void
> *thread_manage_apps(void *data) } }
> 
> -			health_code_update(&health_thread_app_reg); +
> health_code_update(&health_thread_app_manage); } }
> 
> +exit: error: lttng_poll_clean(&events); error_poll_create: -
> health_reset(&health_thread_app_reg); +	if (err) { +		DBG("An error
> occurred in %s", __func__); +
> health_error(&health_thread_app_manage); +	} +
> health_exit(&health_thread_app_manage); DBG("Application
> communication apps thread cleanup complete"); 
> rcu_thread_offline(); rcu_unregister_thread(); @@ -1277,7 +1297,7
> @@ error: */ static void *thread_registration_apps(void *data) { -
> int sock = -1, i, ret, pollfd; +	int sock = -1, i, ret, pollfd, err
> = -1; uint32_t revents, nb_fd; struct lttng_poll_event events; /* 
> @@ -1323,7 +1343,9 @@ static void *thread_registration_apps(void
> *data)
> 
> /* Inifinite blocking call, waiting for transmission */ restart: +
> health_poll_update(&health_thread_app_reg); ret =
> lttng_poll_wait(&events, -1); +
> health_poll_update(&health_thread_app_reg); if (ret < 0) { /* *
> Restart interrupted system call. @@ -1335,6 +1357,8 @@ static void
> *thread_registration_apps(void *data) }
> 
> for (i = 0; i < nb_fd; i++) { +
> health_code_update(&health_thread_app_reg); + /* Fetch once the
> poll data */ revents = LTTNG_POLL_GETEV(&events, i); pollfd =
> LTTNG_POLL_GETFD(&events, i); @@ -1342,7 +1366,8 @@ static void
> *thread_registration_apps(void *data) /* Thread quit pipe has been
> closed. Killing thread. */ ret = check_thread_quit_pipe(pollfd,
> revents); if (ret) { -				goto error; +				err = 0; +				goto
> exit; }
> 
> /* Event on the registration socket */ @@ -1378,6 +1403,7 @@ static
> void *thread_registration_apps(void *data) sock = -1; continue; } +
> health_code_update(&health_thread_app_reg); ret =
> lttcomm_recv_unix_sock(sock, &ust_cmd->reg_msg, sizeof(struct
> ust_register_msg)); if (ret < 0 || ret < sizeof(struct
> ust_register_msg)) { @@ -1395,6 +1421,7 @@ static void
> *thread_registration_apps(void *data) sock = -1; continue; } +
> health_code_update(&health_thread_app_reg);
> 
> ust_cmd->sock = sock; sock = -1; @@ -1422,7 +1449,14 @@ static void
> *thread_registration_apps(void *data) } }
> 
> +exit: error: +	if (err) { +		DBG("An error occurred in %s",
> __func__); +		health_error(&health_thread_app_reg); +	} +
> health_exit(&health_thread_app_reg); + /* Notify that the
> registration thread is gone */ notify_ust_apps(0);
> 
> @@ -1742,15 +1776,15 @@ error: }
> 
> /* - * Compute health status of each consumer. + * Compute health
> status of each consumer. If one of them is zero (bad + * state), we
> return 0. */ static int check_consumer_health(void) { int ret;
> 
> -	ret = -		health_check_state(&kconsumer_data.health) & -
> health_check_state(&ustconsumer32_data.health) & +	ret =
> health_check_state(&kconsumer_data.health) && +
> health_check_state(&ustconsumer32_data.health) && 
> health_check_state(&ustconsumer64_data.health);
> 
> DBG3("Health consumer check %d", ret); @@ -4627,7 +4661,7 @@
> init_setup_error: */ static void *thread_manage_health(void *data) 
> { -	int sock = -1, new_sock, ret, i, pollfd; +	int sock = -1,
> new_sock, ret, i, pollfd, err = -1; uint32_t revents, nb_fd; struct
> lttng_poll_event events; struct lttcomm_health_msg msg; @@ -4691,7
> +4725,8 @@ restart: /* Thread quit pipe has been closed. Killing
> thread. */ ret = check_thread_quit_pipe(pollfd, revents); if (ret)
> { -				goto error; +				err = 0; +				goto exit; }
> 
> /* Event on the registration socket */ @@ -4726,6 +4761,9 @@
> restart: case LTTNG_HEALTH_CMD: reply.ret_code =
> health_check_state(&health_thread_cmd); break; +		case
> LTTNG_HEALTH_APP_MANAGE: +			reply.ret_code =
> health_check_state(&health_thread_app_manage); +			break; case
> LTTNG_HEALTH_APP_REG: reply.ret_code =
> health_check_state(&health_thread_app_reg); break; @@ -4736,13
> +4774,12 @@ restart: reply.ret_code = check_consumer_health(); 
> break; case LTTNG_HEALTH_ALL: -			ret = check_consumer_health(); - 
> reply.ret_code = -				health_check_state(&health_thread_app_reg) & 
> -				health_check_state(&health_thread_cmd) & -
> health_check_state(&health_thread_kernel) & -				ret; +
> health_check_state(&health_thread_app_manage) && +
> health_check_state(&health_thread_app_reg) && +
> health_check_state(&health_thread_cmd) && +
> health_check_state(&health_thread_kernel) && +
> check_consumer_health(); break; default: reply.ret_code =
> LTTCOMM_UND; @@ -4774,7 +4811,11 @@ restart: new_sock = -1; }
> 
> +exit: error: +	if (err) { +		DBG("An error occurred in %s",
> __func__); +	} DBG("Health check thread dying"); 
> unlink(health_unix_sock_path); if (sock >= 0) { @@ -4802,7 +4843,7
> @@ error: */ static void *thread_manage_clients(void *data) { -	int
> sock = -1, ret, i, pollfd; +	int sock = -1, ret, i, pollfd, err =
> -1; int sock_error; uint32_t revents, nb_fd; struct command_ctx
> *cmd_ctx = NULL; @@ -4873,7 +4914,8 @@ static void
> *thread_manage_clients(void *data) /* Thread quit pipe has been
> closed. Killing thread. */ ret = check_thread_quit_pipe(pollfd,
> revents); if (ret) { -				goto error; +				err = 0; +				goto
> exit; }
> 
> /* Event on the registration socket */ @@ -4993,8 +5035,13 @@
> static void *thread_manage_clients(void *data) 
> health_code_update(&health_thread_cmd); }
> 
> +exit: error: -	health_reset(&health_thread_cmd); +	if (err) { +
> DBG("An error occurred in %s", __func__); +
> health_error(&health_thread_cmd); +	} +
> health_exit(&health_thread_cmd);
> 
> DBG("Client thread dying"); unlink(client_unix_sock_path); @@
> -5740,6 +5787,7 @@ int main(int argc, char **argv) /* Init all
> health thread counters. */ health_init(&health_thread_cmd); 
> health_init(&health_thread_kernel); +
> health_init(&health_thread_app_manage); 
> health_init(&health_thread_app_reg);
> 
> /*
> 
-----BEGIN PGP SIGNATURE-----

iQEbBAEBCgAGBQJQDsshAAoJEELoaioR9I025PIH+K9c/w3jrNU+Uw9ML3EpBaiP
yqVPzUUVvR0Om3PnAHmAxYgtCDLTI1s7bV71RCyAX9BZvYYsGaWRtM9rOq+lit0y
k9hmj0UNpLdHj9yHFhtXRiumTcnGvj0Nzp4wAF1Co0/T7v7MPWDr6IcoZsyS4Hkw
XIJBe6kbT84sz4ioCl2O2lqLT/QyolZMF7fRzRqik+uIFD28ZFYsncnNaZ91V0TO
Q2ZrPTfvPEyIUo89tMTY+2GE7uLHN0PXySFXadWri0fkUdT2Myw1x9aVf3fzxUPa
ZKIfHH7QXj4fh2Ka6U/TUJkvtNirIdy8l6oFLt4Gew3285BFQN0kZsnIxwzZmg==
=gUIY
-----END PGP SIGNATURE-----
