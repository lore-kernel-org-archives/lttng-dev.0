From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-tools] UST periodical metadata flush
Date: Tue, 26 Mar 2013 15:18:25 -0400
Message-ID: <20130326191825.GA19325__41725.9648828351$1364325557$gmane$org@Krystal>
References: <1364320199-30440-1-git-send-email-dgoulet@efficios.com>
	<20130326185938.GA18985@Krystal> <5151F291.50205@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UKZO6-0004mN-U6
	for lttng-dev@lists.lttng.org; Tue, 26 Mar 2013 15:18:27 -0400
Content-Disposition: inline
In-Reply-To: <5151F291.50205@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: David Goulet <dgoulet@efficios.com>
Cc: lttng-dev@lists.lttng.org, Julien Desfossez <jdesfossez@efficios.com>
List-Id: lttng-dev@lists.lttng.org

* David Goulet (dgoulet@efficios.com) wrote:
> 
> 
> Mathieu Desnoyers:
> > * David Goulet (dgoulet@efficios.com) wrote:

[...]
> >> +		/* Create the thread to manage the metadata periodic timers */
> >> +		ret = pthread_create(&metadata_timer_thread, NULL,
> >> +				consumer_timer_metadata_thread, (void *) ctx);
> >> +		if (ret != 0) {
> >> +			perror("pthread_create");
> >> +			goto metadata_timer_error;
> >> +		}
> >> +
> >> +		ret = pthread_detach(metadata_timer_thread);
> >> +		if (ret) {
> >> +			errno = ret;
> >> +			perror("pthread_detach");
> >> +		}
> > 
> > Hrm, if pthread_detach fails, maybe we should join the
> > metadata_timer_thread ?
> > 
> 
> Not sure... that thread as *no* way of getting out of it's main loop so
> this is going to wait for a LONG time :P.

OK, good enough.

[...]
> >>  
> >> -	/* Inifinite blocking call, waiting for transmission */
> >> +	/* Infinite blocking call, waiting for transmission */
> >>  restart_poll:
> >> -	health_poll_entry();
> >> -	ret = lttng_poll_wait(&events, -1);
> >> -	health_poll_exit();
> >> -	if (ret < 0) {
> >> -		/*
> >> -		 * Restart interrupted system call.
> >> -		 */
> >> -		if (errno == EINTR) {
> >> -			goto restart_poll;
> >> +	while (1) {
> > 
> > why are we getting this refactoring ? Is it necessary ?
> 
> It is. We've added a metadata socket that receives commands from the
> consumer so we need to poll at vitam eternam for that.

OK. we just need to review this code very carefully. I see it's mainly
an indentation change, so hopefully the change is not too intrusive.

[...]
> >>  /*
> >> + * Push metadata to consumer socket. The socket lock MUST be acquired.
> >> + *
> >> + * On success, return the len of metadata pushed or else a negative value.
> >> + */
> >> +ssize_t ust_app_push_metadata(struct ust_registry_session *registry,
> >> +		struct consumer_socket *socket)
> >> +{
> >> +	int ret;
> >> +	char *metadata_str = NULL;
> >> +	size_t len, offset;
> >> +	ssize_t ret_val;
> >> +
> >> +	assert(registry);
> >> +	assert(socket);
> >> +
> >> +	pthread_mutex_lock(&registry->lock);
> >> +
> >> +	offset = registry->metadata_len_sent;
> >> +	len = registry->metadata_len - registry->metadata_len_sent;
> >> +	if (len == 0) {
> >> +		DBG3("No metadata to push for metadata key %" PRIu64,
> >> +				registry->metadata_key);
> >> +		goto end;
> >> +	}
> >> +
> >> +	/* Allocate only what we have to send. */
> >> +	metadata_str = zmalloc(len);
> >> +	if (!metadata_str) {
> >> +		PERROR("zmalloc ust app metadata string");
> >> +		ret_val = -ENOMEM;
> >> +		goto error;
> >> +	}
> >> +	/* Copy what we haven't send out. */
> >> +	memcpy(metadata_str, registry->metadata + offset, len);
> >> +
> >> +	ret = consumer_push_metadata(socket, registry->metadata_key,
> >> +			metadata_str, len, offset);
> > 
> > I think consumer_push_metadata() sends metadata to consumerd. This is
> > done with the registry lock held. This should _not_ be done.
> > 
> > The registry lock _needs_ to be held only for short periods of time.
> 
> Hmmm indeed. I'll put back the lock around the registry below to update
> the len.

Yep, the lock is really only needed to "grab" the range to update from
the registry. All the reordering the might be needed on the consumer
side when it receives the data into its cache is done at reception.

> 
> > 
> >> +	if (ret < 0) {
> >> +		ret_val = ret;
> >> +		goto error;
> >> +	}
> >> +
> >> +	registry->metadata_len_sent += len;
> >> +
> >> +end:
> >> +	ret_val = len;
> >> +error:
> >> +	free(metadata_str);
> >> +	pthread_mutex_unlock(&registry->lock);
> >> +	return ret_val;
> >> +}
> >> +
> >> +/*
> >>   * For a given application and session, push metadata to consumer. The session
> >>   * lock MUST be acquired here before calling this.
> >> + * Either sock or consumer is required : if sock is NULL, the default
> >> + * socket to send the metadata is retrieved from consumer, if sock
> >> + * is not NULL we use it to send the metadata.
> >>   *
> >>   * Return 0 on success else a negative error.
> >>   */
> >>  static int push_metadata(struct ust_registry_session *registry,
> >>  		struct consumer_output *consumer)
> >>  {
> >> -	int ret;
> >> -	char *metadata_str = NULL;
> >> -	size_t len, offset;
> >> +	int ret_val;
> >> +	ssize_t ret;
> >>  	struct consumer_socket *socket;
> >>  
> >>  	assert(registry);
> >> @@ -391,7 +447,7 @@ static int push_metadata(struct ust_registry_session *registry,
> >>  	 * no start has been done previously.
> >>  	 */
> >>  	if (!registry->metadata_key) {
> >> -		ret = 0;
> >> +		ret_val = 0;
> >>  		goto error_rcu_unlock;
> >>  	}
> >>  
> >> @@ -399,7 +455,7 @@ static int push_metadata(struct ust_registry_session *registry,
> >>  	socket = consumer_find_socket_by_bitness(registry->bits_per_long,
> >>  			consumer);
> >>  	if (!socket) {
> >> -		ret = -1;
> >> +		ret_val = -1;
> >>  		goto error_rcu_unlock;
> >>  	}
> >>  
> >> @@ -414,54 +470,19 @@ static int push_metadata(struct ust_registry_session *registry,
> >>  	 * ability to reorder the metadata it receives.
> >>  	 */
> >>  	pthread_mutex_lock(socket->lock);
> >> -	pthread_mutex_lock(&registry->lock);

another question: We don't seem to need nesting of the registry lock
inside the socket lock anymore on the sessiond side. We probably have
some comments to update around those locks elsewhere ?

[...]
> >> +/*
> >> + * Commands sent from the consumerd to the sessiond to request
> >> + * if new metadata is available
> >> + */
> >> +struct lttcomm_metadata_request_msg {
> >> +	unsigned int session_id; /* Tracing session id */
> >> +	uint32_t bits_per_long; /* Consumer ABI */
> >> +	uint32_t uid;
> >> +	uint64_t key; /* Metadata channel key. */
> >> +} LTTNG_PACKED;
> > 
> > What happens for per-pid UST buffers ? This message seems to be quite
> > specific to per-uid buffers ?
> 
> We ignore every value and use the session id only for per PID. The
> consumer has no idea if the metadata channel is per UID or PID on the
> sessiond side so we lookup per uid using all of the values, if failure,
> per pid with only the session id.

OK, this should be clearly documented in the code.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
