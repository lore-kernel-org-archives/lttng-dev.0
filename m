From: David Goulet <dgoulet@efficios.com>
Subject: Re: [PATCH lttng-tools] Change wfq usages for wfcq
Date: Mon, 28 Jul 2014 14:50:19 -0400
Message-ID: <20140728185019.GF5591__3498.65331450037$1406573492$gmane$org@thessa>
References: <1406352416-11364-1-git-send-email-simon.marchi@polymtl.ca>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1642528789=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from albert.ini-tech.com ([192.99.35.19] helo=smtp.ini-tech.com)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <dgoulet@efficios.com>) id 1XBq0B-0005fg-B2
 for lttng-dev@lists.lttng.org; Mon, 28 Jul 2014 14:50:33 -0400
In-Reply-To: <1406352416-11364-1-git-send-email-simon.marchi@polymtl.ca>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Simon Marchi <simon.marchi@polymtl.ca>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org


--===============1642528789==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cz6wLo+OExbGG7q/"
Content-Disposition: inline


--cz6wLo+OExbGG7q/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

So there is quite an issue with that which is that tools does not work
with urcu 0.7 anymore.

That would mean urcu 0.8 and later would be the requirement from now on.

Not sure I'm comfortable with that but again I don't see why we should
not do that also....

David

On 26 Jul (01:26:56), Simon Marchi wrote:
> This removes the deprecated warnings when building lttng-tools. We can
> now build with -Werror, woohoo!
>=20
> Verified by running make check.
> ---
>  configure.ac                            |  8 ++++----
>  src/bin/lttng-relayd/connection.h       |  4 ++--
>  src/bin/lttng-relayd/live.c             | 12 +++++++-----
>  src/bin/lttng-relayd/lttng-relayd.h     |  5 +++--
>  src/bin/lttng-relayd/main.c             | 12 +++++++-----
>  src/bin/lttng-sessiond/lttng-sessiond.h |  7 ++++---
>  src/bin/lttng-sessiond/main.c           | 10 +++++-----
>  7 files changed, 32 insertions(+), 26 deletions(-)
>=20
> diff --git a/configure.ac b/configure.ac
> index a6f5b0b..3d59a20 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -177,11 +177,11 @@ liburcu_version=3D">=3D 0.7.2"
>  AC_CHECK_DECL([cds_list_add], [],
>  	[AC_MSG_ERROR([liburcu $liburcu_version or newer is needed])], [[#inclu=
de <urcu/list.h>]]
>  )
> -AC_CHECK_DECL([cds_wfq_init], [],
> -	[AC_MSG_ERROR([liburcu $liburcu_version or newer is needed])], [[#inclu=
de <urcu/wfqueue.h>]]
> +AC_CHECK_DECL([cds_wfcq_init], [],
> +	[AC_MSG_ERROR([liburcu $liburcu_version or newer is needed])], [[#inclu=
de <urcu/wfcqueue.h>]]
>  )
> -AC_CHECK_DECL([cds_wfq_dequeue_blocking], [],
> -    [AC_MSG_ERROR([liburcu $liburcu_version or newer is needed])], [[#in=
clude <urcu/wfqueue.h>]]
> +AC_CHECK_DECL([cds_wfcq_dequeue_blocking], [],
> +    [AC_MSG_ERROR([liburcu $liburcu_version or newer is needed])], [[#in=
clude <urcu/wfcqueue.h>]]
>  )
>  AC_CHECK_DECL([futex_async], [],
>  	[AC_MSG_ERROR([liburcu $liburcu_version or newer is needed])], [[#inclu=
de <urcu/futex.h>]]
> diff --git a/src/bin/lttng-relayd/connection.h b/src/bin/lttng-relayd/con=
nection.h
> index fc4a590..70fe4ba 100644
> --- a/src/bin/lttng-relayd/connection.h
> +++ b/src/bin/lttng-relayd/connection.h
> @@ -23,7 +23,7 @@
>  #include <inttypes.h>
>  #include <pthread.h>
>  #include <urcu.h>
> -#include <urcu/wfqueue.h>
> +#include <urcu/wfcqueue.h>
>  #include <urcu/list.h>
> =20
>  #include <common/hashtable/hashtable.h>
> @@ -46,7 +46,7 @@ struct relay_connection {
>  	struct lttcomm_sock *sock;
>  	struct relay_session *session;
>  	struct relay_viewer_session *viewer_session;
> -	struct cds_wfq_node qnode;
> +	struct cds_wfcq_node qnode;
>  	struct lttng_ht_node_ulong sock_n;
>  	struct rcu_head rcu_node;
>  	enum connection_type type;
> diff --git a/src/bin/lttng-relayd/live.c b/src/bin/lttng-relayd/live.c
> index 8c716db..5684608 100644
> --- a/src/bin/lttng-relayd/live.c
> +++ b/src/bin/lttng-relayd/live.c
> @@ -558,11 +558,12 @@ restart:
>  				new_conn->sock =3D newsock;
> =20
>  				/* Enqueue request for the dispatcher thread. */
> -				cds_wfq_enqueue(&viewer_conn_queue.queue, &new_conn->qnode);
> +				cds_wfcq_enqueue(&viewer_conn_queue.head, &viewer_conn_queue.tail,
> +						 &new_conn->qnode);
> =20
>  				/*
>  				 * Wake the dispatch queue futex. Implicit memory barrier with
> -				 * the exchange in cds_wfq_enqueue.
> +				 * the exchange in cds_wfcq_enqueue.
>  				 */
>  				futex_nto1_wake(&viewer_conn_queue.futex);
>  			}
> @@ -601,7 +602,7 @@ void *thread_dispatcher(void *data)
>  {
>  	int err =3D -1;
>  	ssize_t ret;
> -	struct cds_wfq_node *node;
> +	struct cds_wfcq_node *node;
>  	struct relay_connection *conn =3D NULL;
> =20
>  	DBG("[thread] Live viewer relay dispatcher started");
> @@ -624,7 +625,8 @@ void *thread_dispatcher(void *data)
>  			health_code_update();
> =20
>  			/* Dequeue commands */
> -			node =3D cds_wfq_dequeue_blocking(&viewer_conn_queue.queue);
> +			node =3D cds_wfcq_dequeue_blocking(&viewer_conn_queue.head,
> +							 &viewer_conn_queue.tail);
>  			if (node =3D=3D NULL) {
>  				DBG("Woken up but nothing in the live-viewer "
>  						"relay command queue");
> @@ -2113,7 +2115,7 @@ int live_start_threads(struct lttng_uri *uri,
>  	}
> =20
>  	/* Init relay command queue. */
> -	cds_wfq_init(&viewer_conn_queue.queue);
> +	cds_wfcq_init(&viewer_conn_queue.head, &viewer_conn_queue.tail);
> =20
>  	/* Set up max poll set size */
>  	lttng_poll_set_max_size();
> diff --git a/src/bin/lttng-relayd/lttng-relayd.h b/src/bin/lttng-relayd/l=
ttng-relayd.h
> index 55ce25e..896925f 100644
> --- a/src/bin/lttng-relayd/lttng-relayd.h
> +++ b/src/bin/lttng-relayd/lttng-relayd.h
> @@ -22,7 +22,7 @@
>  #define _LGPL_SOURCE
>  #include <limits.h>
>  #include <urcu.h>
> -#include <urcu/wfqueue.h>
> +#include <urcu/wfcqueue.h>
> =20
>  #include <common/hashtable/hashtable.h>
> =20
> @@ -30,7 +30,8 @@
>   * Queue used to enqueue relay requests
>   */
>  struct relay_conn_queue {
> -	struct cds_wfq_queue queue;
> +	struct cds_wfcq_head head;
> +	struct cds_wfcq_tail tail;
>  	int32_t futex;
>  };
> =20
> diff --git a/src/bin/lttng-relayd/main.c b/src/bin/lttng-relayd/main.c
> index 3a6beba..a3b8016 100644
> --- a/src/bin/lttng-relayd/main.c
> +++ b/src/bin/lttng-relayd/main.c
> @@ -882,11 +882,12 @@ restart:
>  				new_conn->sock =3D newsock;
> =20
>  				/* Enqueue request for the dispatcher thread. */
> -				cds_wfq_enqueue(&relay_conn_queue.queue, &new_conn->qnode);
> +				cds_wfcq_enqueue(&relay_conn_queue.head, &relay_conn_queue.tail,
> +						 &new_conn->qnode);
> =20
>  				/*
>  				 * Wake the dispatch queue futex. Implicit memory barrier with
> -				 * the exchange in cds_wfq_enqueue.
> +				 * the exchange in cds_wfcq_enqueue.
>  				 */
>  				futex_nto1_wake(&relay_conn_queue.futex);
>  			}
> @@ -933,7 +934,7 @@ void *relay_thread_dispatcher(void *data)
>  {
>  	int err =3D -1;
>  	ssize_t ret;
> -	struct cds_wfq_node *node;
> +	struct cds_wfcq_node *node;
>  	struct relay_connection *new_conn =3D NULL;
> =20
>  	DBG("[thread] Relay dispatcher started");
> @@ -956,7 +957,8 @@ void *relay_thread_dispatcher(void *data)
>  			health_code_update();
> =20
>  			/* Dequeue commands */
> -			node =3D cds_wfq_dequeue_blocking(&relay_conn_queue.queue);
> +			node =3D cds_wfcq_dequeue_blocking(&relay_conn_queue.head,
> +							 &relay_conn_queue.tail);
>  			if (node =3D=3D NULL) {
>  				DBG("Woken up but nothing in the relay command queue");
>  				/* Continue thread execution */
> @@ -2762,7 +2764,7 @@ int main(int argc, char **argv)
>  	}
> =20
>  	/* Init relay command queue. */
> -	cds_wfq_init(&relay_conn_queue.queue);
> +	cds_wfcq_init(&relay_conn_queue.head, &relay_conn_queue.tail);
> =20
>  	/* Set up max poll set size */
>  	lttng_poll_set_max_size();
> diff --git a/src/bin/lttng-sessiond/lttng-sessiond.h b/src/bin/lttng-sess=
iond/lttng-sessiond.h
> index 0f4c668..f3fb750 100644
> --- a/src/bin/lttng-sessiond/lttng-sessiond.h
> +++ b/src/bin/lttng-sessiond/lttng-sessiond.h
> @@ -21,7 +21,7 @@
> =20
>  #define _LGPL_SOURCE
>  #include <urcu.h>
> -#include <urcu/wfqueue.h>
> +#include <urcu/wfcqueue.h>
> =20
>  #include <common/sessiond-comm/sessiond-comm.h>
>  #include <common/compat/poll.h>
> @@ -55,7 +55,7 @@ struct command_ctx {
>  struct ust_command {
>  	int sock;
>  	struct ust_register_msg reg_msg;
> -	struct cds_wfq_node node;
> +	struct cds_wfcq_node node;
>  };
> =20
>  /*
> @@ -64,7 +64,8 @@ struct ust_command {
>   */
>  struct ust_cmd_queue {
>  	int32_t futex;
> -	struct cds_wfq_queue queue;
> +	struct cds_wfcq_head head;
> +	struct cds_wfcq_tail tail;
>  };
> =20
>  /*
> diff --git a/src/bin/lttng-sessiond/main.c b/src/bin/lttng-sessiond/main.c
> index a8751c6..2e53b0a 100644
> --- a/src/bin/lttng-sessiond/main.c
> +++ b/src/bin/lttng-sessiond/main.c
> @@ -1685,7 +1685,7 @@ error_create:
>  static void *thread_dispatch_ust_registration(void *data)
>  {
>  	int ret, err =3D -1;
> -	struct cds_wfq_node *node;
> +	struct cds_wfcq_node *node;
>  	struct ust_command *ust_cmd =3D NULL;
>  	struct ust_reg_wait_node *wait_node =3D NULL, *tmp_wait_node;
>  	struct ust_reg_wait_queue wait_queue =3D {
> @@ -1723,7 +1723,7 @@ static void *thread_dispatch_ust_registration(void =
*data)
> =20
>  			health_code_update();
>  			/* Dequeue command for registration */
> -			node =3D cds_wfq_dequeue_blocking(&ust_cmd_queue.queue);
> +			node =3D cds_wfcq_dequeue_blocking(&ust_cmd_queue.head, &ust_cmd_queu=
e.tail);
>  			if (node =3D=3D NULL) {
>  				DBG("Woken up but nothing in the UST command queue");
>  				/* Continue thread execution */
> @@ -2077,11 +2077,11 @@ static void *thread_registration_apps(void *data)
>  					 * Lock free enqueue the registration request. The red pill
>  					 * has been taken! This apps will be part of the *system*.
>  					 */
> -					cds_wfq_enqueue(&ust_cmd_queue.queue, &ust_cmd->node);
> +					cds_wfcq_enqueue(&ust_cmd_queue.head, &ust_cmd_queue.tail, &ust_cmd=
->node);
> =20
>  					/*
>  					 * Wake the registration queue futex. Implicit memory
> -					 * barrier with the exchange in cds_wfq_enqueue.
> +					 * barrier with the exchange in cds_wfcq_enqueue.
>  					 */
>  					futex_nto1_wake(&ust_cmd_queue.futex);
>  				}
> @@ -5256,7 +5256,7 @@ int main(int argc, char **argv)
>  	buffer_reg_init_pid_registry();
> =20
>  	/* Init UST command queue. */
> -	cds_wfq_init(&ust_cmd_queue.queue);
> +	cds_wfcq_init(&ust_cmd_queue.head, &ust_cmd_queue.tail);
> =20
>  	/*
>  	 * Get session list pointer. This pointer MUST NOT be free(). This list=
 is
> --=20
> 2.0.0
>=20
>=20
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--cz6wLo+OExbGG7q/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQF8BAEBAgBmBQJT1ptrXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNzQ0MTdFRERGMjJBQzlGOUU5MEY0OTE0
MkU4NkEyQTExRjQ4RDM2AAoJEELoaioR9I02BxIH/10KdBarfgJ74n/dtVF+JpV6
/gE1Nu530mTTGLYSH0elUsMqwLcxQMOCcDTvvtPcgxVMbpGWo7bk/Go4kvL2NcC9
hm5EwrFvzUs+t6rdRHi+uQpLpeI4OXkkVNDDmMNpcxK5+dGVRRtiSqqTAlYisvNF
nknn6S5FQovw5qOHCrCXA4nYMR1vHkA9lPkOUKiIqq+ihGVLETHnT4J+ERVpXICa
D97+mtFLd78gjbzE9R921sooqA2rNJ+n3zucOK7pKyduVUA6FDaAhO0z+WreM/G1
DccJVa0N9nGor9XrZiUsvTbAG8mSPY/qdea69MmPNAgJJijZFLpkE+DvsAsbgCk=
=UICU
-----END PGP SIGNATURE-----

--cz6wLo+OExbGG7q/--


--===============1642528789==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1642528789==--
