From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-tools] UST periodical metadata flush
Date: Tue, 26 Mar 2013 16:34:41 -0400
Message-ID: <20130326203441.GA19637__47126.5592649162$1364330141$gmane$org@Krystal>
References: <1364320199-30440-1-git-send-email-dgoulet@efficios.com>
	<20130326185938.GA18985@Krystal> <5151F291.50205@efficios.com>
	<20130326191825.GA19325@Krystal> <5151F5C2.1090807@efficios.com>
	<20130326192925.GA19560@Krystal> <5151F8A3.7010006@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UKaZz-0005Oe-M6
	for lttng-dev@lists.lttng.org; Tue, 26 Mar 2013 16:34:47 -0400
Content-Disposition: inline
In-Reply-To: <5151F8A3.7010006@efficios.com>
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
> >>>>>>   * For a given application and session, push metadata to consumer. The session
> >>>>>>   * lock MUST be acquired here before calling this.
> >>>>>> + * Either sock or consumer is required : if sock is NULL, the default
> >>>>>> + * socket to send the metadata is retrieved from consumer, if sock
> >>>>>> + * is not NULL we use it to send the metadata.
> >>>>>>   *
> >>>>>>   * Return 0 on success else a negative error.
> >>>>>>   */
> >>>>>>  static int push_metadata(struct ust_registry_session *registry,
> >>>>>>  		struct consumer_output *consumer)
> >>>>>>  {
> >>>>>> -	int ret;
> >>>>>> -	char *metadata_str = NULL;
> >>>>>> -	size_t len, offset;
> >>>>>> +	int ret_val;
> >>>>>> +	ssize_t ret;
> >>>>>>  	struct consumer_socket *socket;
> >>>>>>  
> >>>>>>  	assert(registry);
> >>>>>> @@ -391,7 +447,7 @@ static int push_metadata(struct ust_registry_session *registry,
> >>>>>>  	 * no start has been done previously.
> >>>>>>  	 */
> >>>>>>  	if (!registry->metadata_key) {
> >>>>>> -		ret = 0;
> >>>>>> +		ret_val = 0;
> >>>>>>  		goto error_rcu_unlock;
> >>>>>>  	}
> >>>>>>  
> >>>>>> @@ -399,7 +455,7 @@ static int push_metadata(struct ust_registry_session *registry,
> >>>>>>  	socket = consumer_find_socket_by_bitness(registry->bits_per_long,
> >>>>>>  			consumer);
> >>>>>>  	if (!socket) {
> >>>>>> -		ret = -1;
> >>>>>> +		ret_val = -1;
> >>>>>>  		goto error_rcu_unlock;
> >>>>>>  	}
> >>>>>>  
> >>>>>> @@ -414,54 +470,19 @@ static int push_metadata(struct ust_registry_session *registry,
> >>>>>>  	 * ability to reorder the metadata it receives.
> >>>>>>  	 */
> >>>>>>  	pthread_mutex_lock(socket->lock);
> >>>>>> -	pthread_mutex_lock(&registry->lock);
> >>>
> >>> another question: We don't seem to need nesting of the registry lock
> >>> inside the socket lock anymore on the sessiond side. We probably have
> >>> some comments to update around those locks elsewhere ?
> >>
> >> Well not sure here. This function has been split in two where this one
> >> finds the socket and lock it then calls ust_app_push_metadata that
> >> *locks* the registry. So there is still nesting needed.
> >> ust_app_push_metadata() *MUST* be called with the socket lock (it is
> >> documented). So to that extent, the registry lock still nest in the
> >> socket lock.
> > 
> > Why do we need to lock the socket lock insite push_metadata() ?
> > 
> > We could probably take both locks one after the other (not nested)
> > within ust_app_push_metadata(), given that we now allow out-of-order
> > metadata segments ?
> 
> The problem is with the new way we request metadata coming from the
> consumer. We need to lock the socket through the receive command up to
> the push metadata call (ust_app_push_metadata). We have now two call
> sites that use this function so the split was needed where one function
> finds the socket object, lock it and calls the push metadata. (see
> ust_consumer_metadata_request() in sessiond/ust-consumer.c for the
> second call site).
> 
> You see a better way of doing it ?

After discussing over phone, we will nest the registry lock inside the
socket lock.

Thanks,

Mathieu

> 
> David
> 
> > 
> > Thanks,
> > 
> > Mathieu
> >

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
