From: Gerlando Falauto <gerlando.falauto@keymile.com>
Subject: Re: [lttng-tools PATCH] Add new thread in consumer for
	metadata handling
Date: Tue, 18 Sep 2012 10:59:45 +0200
Message-ID: <50583801.4030205__40456.7576050342$1347958827$gmane$org@keymile.com>
References: <1347389351-19792-1-git-send-email-dgoulet@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.ch.keymile.com ([193.17.201.103])
	by ltt.polymtl.ca with smtp (Exim 4.72)
	(envelope-from <Gerlando.Falauto@keymile.com>) id 1TDtes-0001vZ-JR
	for lttng-dev@lists.lttng.org; Tue, 18 Sep 2012 04:59:54 -0400
In-Reply-To: <1347389351-19792-1-git-send-email-dgoulet@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: David Goulet <dgoulet@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hi David,

On 09/11/2012 08:49 PM, David Goulet wrote:
> To prioritize the consumption of the metadata, this patch introduce a
> new thread in the consumer which exclusively handles metadata in order
> to separate them from the trace data.
[...]
> +			/* Check the metadata pipe for incoming metadata. */
> +			if (pollfd == ctx->consumer_metadata_pipe[0]) {
> +				if (revents&  (LPOLLERR | LPOLLHUP | LPOLLNVAL)) {
> +					DBG("Metadata thread pipe hung up");
> +					/*
> +					 * Remove the pipe from the poll set and continue the loop

Since we don't HAVE_EPOLL, we get:

consumer.c: In function 'lttng_consumer_thread_poll_metadata':
consumer.c:1700:42: error: 'LPOLLNVAL' undeclared (first use in this 
function)
consumer.c:1700:42: note: each undeclared identifier is reported only 
once for each function it appears in

For some reason, compat/poll.h defines:
        LPOLLERR = POLLERR,
        LPOLLHUP = POLLHUP | POLLNVAL,
        /* Close on exec feature does not exist for poll(2) */
        LTTNG_CLOEXEC = 0xdead,

Whereas with HAVE_EPOLL we have:
        LPOLLHUP = EPOLLHUP,
        LPOLLNVAL = EPOLLHUP,
        LPOLLRDHUP = EPOLLRDHUP,

I would patch this myself but I'm a bit confused by the above...

Thanks!
Gerlando
