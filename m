From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-tools] Fix: Missing read locks
	on	access to consumerd's channel hash table
Date: Mon, 8 Jul 2013 11:49:56 -0400
Message-ID: <20130708154956.GL29362__45482.4627996006$1373298628$gmane$org@Krystal>
References: <1370315999-8598-1-git-send-email-jeremie.galarneau@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UwDhN-0006Dx-TK
	for lttng-dev@lists.lttng.org; Mon, 08 Jul 2013 11:49:57 -0400
Content-Disposition: inline
In-Reply-To: <1370315999-8598-1-git-send-email-jeremie.galarneau@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?iso-8859-1?Q?J=E9r=E9mie?= Galarneau <jeremie.galarneau@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* J=E9r=E9mie Galarneau (jeremie.galarneau@efficios.com) wrote:
> Signed-off-by: J=E9r=E9mie Galarneau <jeremie.galarneau@efficios.com>

this had been merged into lttng-tools as:

commit c7260a81b6c99282da7c59b6124381f92c637658
Author: J=E9r=E9mie Galarneau <jeremie.galarneau@efficios.com>
Date:   Mon Jun 3 23:19:59 2013 -0400

    Fix: Missing RCU locks on access to consumerd's channel ht
    =

    Signed-off-by: J=E9r=E9mie Galarneau <jeremie.galarneau@efficios.com>
    Signed-off-by: David Goulet <dgoulet@efficios.com>

For both stable-2.2 and master.


> ---
>  src/common/consumer.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> =

> diff --git a/src/common/consumer.c b/src/common/consumer.c
> index 3709092..5f38375 100644
> --- a/src/common/consumer.c
> +++ b/src/common/consumer.c
> @@ -2716,16 +2716,21 @@ restart:
>  =

>  						lttng_ht_node_init_u64(&chan->wait_fd_node,
>  							chan->wait_fd);
> +						rcu_read_lock();
>  						lttng_ht_add_unique_u64(channel_ht,
>  								&chan->wait_fd_node);
> +						rcu_read_unlock();
>  						/* Add channel to the global poll events list */
>  						lttng_poll_add(&events, chan->wait_fd,
>  								LPOLLIN | LPOLLPRI);
>  						break;
>  					case CONSUMER_CHANNEL_DEL:
>  					{
> +						rcu_read_lock();
>  						chan =3D consumer_find_channel(key);
> +
>  						if (!chan) {
> +							rcu_read_unlock();
>  							ERR("UST consumer get channel key %" PRIu64 " not found for del c=
hannel", key);
>  							break;
>  						}
> @@ -2741,6 +2746,7 @@ restart:
>  						if (!uatomic_sub_return(&chan->refcount, 1)) {
>  							consumer_del_channel(chan);
>  						}
> +						rcu_read_unlock();
>  						goto restart;
>  					}
>  					case CONSUMER_CHANNEL_QUIT:
> -- =

> 1.8.2.3
> =

> =

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- =

Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
