From: Julien Desfossez <jdesfossez@efficios.com>
Subject: Re: [LTTNG-TOOLS PATCH] Fix: get the stream_id when
 generating live beacons
Date: Tue, 01 Jul 2014 12:17:11 -0400
Message-ID: <53B2DF07.9040107__13103.4977421679$1404231489$gmane$org@efficios.com>
References: <1404231052-20970-1-git-send-email-jdesfossez@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fukushima.klipix.org ([85.12.144.25])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jdesfossez@efficios.com>) id 1X20kA-0006S0-R3
 for lttng-dev@lists.lttng.org; Tue, 01 Jul 2014 12:17:22 -0400
In-Reply-To: <1404231052-20970-1-git-send-email-jdesfossez@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: dgoulet@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Forget this patch, I'll send a new version soon.
Need to check the domain before...

On 14-07-01 12:10 PM, Julien Desfossez wrote:
> When we send an empty index (beacon), we need to extract the stream_id
> to avoid stalling the client on inactive streams on startup.
> 
> This patch should also be backported to 2.4.x.
> 
> Signed-off-by: Julien Desfossez <jdesfossez@efficios.com>
> ---
>  src/common/consumer-timer.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/src/common/consumer-timer.c b/src/common/consumer-timer.c
> index c659bf6..c13577f 100644
> --- a/src/common/consumer-timer.c
> +++ b/src/common/consumer-timer.c
> @@ -118,8 +118,16 @@ static int send_empty_index(struct lttng_consumer_stream *stream, uint64_t ts)
>  {
>  	int ret;
>  	struct ctf_packet_index index;
> +	uint64_t stream_id;
> +
> +	ret = kernctl_get_stream_id(stream->wait_fd, &stream_id);
> +	if (ret < 0) {
> +		PERROR("kernctl_get_stream_id");
> +		goto error;
> +	}
>  
>  	memset(&index, 0, sizeof(index));
> +	index.stream_id = htobe64(stream_id);
>  	index.timestamp_end = htobe64(ts);
>  	ret = consumer_stream_write_index(stream, &index);
>  	if (ret < 0) {
> 
