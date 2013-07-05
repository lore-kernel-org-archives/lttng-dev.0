From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-tools 2.2] Fix: consumer: use	uint64_t
	for all sessiond_id
Date: Fri, 5 Jul 2013 19:33:51 -0400
Message-ID: <20130705233351.GC28784__116.963548544113$1373067271$gmane$org@Krystal>
References: <20130628161834.GA21417@Krystal> <20130705233116.GB28784@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UvFVg-0001Rg-FE
	for lttng-dev@lists.lttng.org; Fri, 05 Jul 2013 19:33:52 -0400
Content-Disposition: inline
In-Reply-To: <20130705233116.GB28784@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: dgoulet@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* Mathieu Desnoyers (mathieu.desnoyers@efficios.com) wrote:
> Ping ? This is still not merged.

As a precision: this bugfix applies to both master and stable-2.2.

It's only merged in stable-2.2, but should also be pulled into master.

Thanks,

Mathieu

> 
> * Mathieu Desnoyers (mathieu.desnoyers@efficios.com) wrote:
> > Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > ---
> > diff --git a/src/common/consumer.c b/src/common/consumer.c
> > index d810de1..a1a99b4 100644
> > --- a/src/common/consumer.c
> > +++ b/src/common/consumer.c
> > @@ -1162,7 +1162,7 @@ struct lttng_consumer_local_data *lttng_consumer_create(
> >  			struct lttng_consumer_local_data *ctx),
> >  		int (*recv_channel)(struct lttng_consumer_channel *channel),
> >  		int (*recv_stream)(struct lttng_consumer_stream *stream),
> > -		int (*update_stream)(int stream_key, uint32_t state))
> > +		int (*update_stream)(uint64_t stream_key, uint32_t state))
> >  {
> >  	int ret;
> >  	struct lttng_consumer_local_data *ctx;
> > @@ -3074,7 +3074,7 @@ void lttng_consumer_init(void)
> >  int consumer_add_relayd_socket(uint64_t net_seq_idx, int sock_type,
> >  		struct lttng_consumer_local_data *ctx, int sock,
> >  		struct pollfd *consumer_sockpoll,
> > -		struct lttcomm_relayd_sock *relayd_sock, unsigned int sessiond_id)
> > +		struct lttcomm_relayd_sock *relayd_sock, uint64_t sessiond_id)
> >  {
> >  	int fd = -1, ret = -1, relayd_created = 0;
> >  	enum lttng_error_code ret_code = LTTNG_OK;
> > @@ -3095,7 +3095,7 @@ int consumer_add_relayd_socket(uint64_t net_seq_idx, int sock_type,
> >  			ret_code = LTTCOMM_CONSUMERD_ENOMEM;
> >  			ret = -ENOMEM;
> >  		} else {
> > -			relayd->sessiond_session_id = (uint64_t) sessiond_id;
> > +			relayd->sessiond_session_id = sessiond_id;
> >  			relayd_created = 1;
> >  		}
> >  
> > diff --git a/src/common/consumer.h b/src/common/consumer.h
> > index 3cfcb87..a5a758b 100644
> > --- a/src/common/consumer.h
> > +++ b/src/common/consumer.h
> > @@ -340,7 +340,7 @@ struct lttng_consumer_local_data {
> >  	 *   == 0 (success, FD is left to library)
> >  	 *    < 0 (error)
> >  	 */
> > -	int (*on_update_stream)(int sessiond_key, uint32_t state);
> > +	int (*on_update_stream)(uint64_t sessiond_key, uint32_t state);
> >  	enum lttng_consumer_type type;
> >  	/* socket to communicate errors with sessiond */
> >  	int consumer_error_socket;
> > @@ -502,7 +502,7 @@ struct lttng_consumer_local_data *lttng_consumer_create(
> >  			struct lttng_consumer_local_data *ctx),
> >  		int (*recv_channel)(struct lttng_consumer_channel *channel),
> >  		int (*recv_stream)(struct lttng_consumer_stream *stream),
> > -		int (*update_stream)(int sessiond_key, uint32_t state));
> > +		int (*update_stream)(uint64_t sessiond_key, uint32_t state));
> >  void lttng_consumer_destroy(struct lttng_consumer_local_data *ctx);
> >  ssize_t lttng_consumer_on_read_subbuffer_mmap(
> >  		struct lttng_consumer_local_data *ctx,
> > @@ -528,7 +528,7 @@ int lttng_consumer_on_recv_stream(struct lttng_consumer_stream *stream);
> >  int consumer_add_relayd_socket(uint64_t net_seq_idx, int sock_type,
> >  		struct lttng_consumer_local_data *ctx, int sock,
> >  		struct pollfd *consumer_sockpoll, struct lttcomm_relayd_sock *relayd_sock,
> > -		unsigned int sessiond_id);
> > +		uint64_t sessiond_id);
> >  void consumer_flag_relayd_for_destroy(
> >  		struct consumer_relayd_sock_pair *relayd);
> >  int consumer_data_pending(uint64_t id);
> > 
> > -- 
> > Mathieu Desnoyers
> > EfficiOS Inc.
> > http://www.efficios.com
> > 
> > _______________________________________________
> > lttng-dev mailing list
> > lttng-dev@lists.lttng.org
> > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> 
> -- 
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
