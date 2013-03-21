From: David Goulet <dgoulet@efficios.com>
Subject: Re: [PATCH lttng-tools] Fix: Memory leak on error paths
	of relay_add_stream
Date: Thu, 21 Mar 2013 13:32:47 -0400
Message-ID: <514B443F.4010709__22698.1495776728$1363887222$gmane$org@efficios.com>
References: <1362084510-10072-1-git-send-email-christian.babeux@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([213.239.202.151])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1UIjMB-0005X4-4K
	for lttng-dev@lists.lttng.org; Thu, 21 Mar 2013 13:32:51 -0400
In-Reply-To: <1362084510-10072-1-git-send-email-christian.babeux@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Christian Babeux <christian.babeux@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Merged all 7!

David

Christian Babeux:
> On error paths the memory allocated for stream is never freed.
> 
> Also, fix undefined behavior on asprintf alloc failure. According to
> asprintf(3), the content of the pointer passed to it is undefined if
> an alloc failure occurs, so we could end up freeing a pointer in an
> undefined state. Force its value to NULL.
> 
> Signed-off-by: Christian Babeux <christian.babeux@efficios.com>
> ---
>  src/bin/lttng-relayd/main.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/src/bin/lttng-relayd/main.c b/src/bin/lttng-relayd/main.c
> index 4f9d742..00b7ea3 100644
> --- a/src/bin/lttng-relayd/main.c
> +++ b/src/bin/lttng-relayd/main.c
> @@ -941,6 +941,7 @@ int relay_add_stream(struct lttcomm_relayd_hdr *recv_hdr,
>  	ret = asprintf(&path, "%s/%s", root_path, stream_info.channel_name);
>  	if (ret < 0) {
>  		PERROR("asprintf stream path");
> +		path = NULL;
>  		goto end;
>  	}
>  
> @@ -963,13 +964,17 @@ int relay_add_stream(struct lttcomm_relayd_hdr *recv_hdr,
>  end:
>  	free(path);
>  	free(root_path);
> +
> +	reply.handle = htobe64(stream->stream_handle);
>  	/* send the session id to the client or a negative return code on error */
>  	if (ret < 0) {
>  		reply.ret_code = htobe32(LTTNG_ERR_UNK);
> +		/* stream was not properly added to the ht, so free it */
> +		free(stream);
>  	} else {
>  		reply.ret_code = htobe32(LTTNG_OK);
>  	}
> -	reply.handle = htobe64(stream->stream_handle);
> +
>  	send_ret = cmd->sock->ops->sendmsg(cmd->sock, &reply,
>  			sizeof(struct lttcomm_relayd_status_stream), 0);
>  	if (send_ret < 0) {
