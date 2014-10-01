From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [MODULES PATCH 1/2] Fix: redefinition of
	DEFINE_WRITEBACK_EVENT
Date: Wed, 1 Oct 2014 00:08:51 +0000 (UTC)
Message-ID: <741706753.1462.1412122131351.JavaMail.zimbra__26925.0961639502$1412122226$gmane$org@efficios.com>
References: <1412110173-3343-1-git-send-email-jdesfossez@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1XZ7Tq-0005bj-8w
 for lttng-dev@lists.lttng.org; Tue, 30 Sep 2014 20:09:25 -0400
In-Reply-To: <1412110173-3343-1-git-send-email-jdesfossez@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Julien Desfossez <jdesfossez@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Merged, thanks!

Mathieu

----- Original Message -----
> From: "Julien Desfossez" <jdesfossez@efficios.com>
> To: "mathieu desnoyers" <mathieu.desnoyers@efficios.com>
> Cc: lttng-dev@lists.lttng.org, "Julien Desfossez" <jdesfossez@efficios.com>
> Sent: Tuesday, September 30, 2014 4:49:32 PM
> Subject: [MODULES PATCH 1/2] Fix: redefinition of DEFINE_WRITEBACK_EVENT
> 
> Signed-off-by: Julien Desfossez <jdesfossez@efficios.com>
> ---
>  instrumentation/events/lttng-module/writeback.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/instrumentation/events/lttng-module/writeback.h
> b/instrumentation/events/lttng-module/writeback.h
> index 2dca4e4..5525fed 100644
> --- a/instrumentation/events/lttng-module/writeback.h
> +++ b/instrumentation/events/lttng-module/writeback.h
> @@ -99,6 +99,7 @@ LTTNG_TRACEPOINT_EVENT_CLASS(writeback_class,
>  		  __entry->name
>  	)
>  )
> +#undef DEFINE_WRITEBACK_EVENT
>  #define DEFINE_WRITEBACK_EVENT(name) \
>  LTTNG_TRACEPOINT_EVENT_INSTANCE(writeback_class, name, \
>  	TP_PROTO(struct backing_dev_info *bdi), \
> --
> 1.9.1
> 
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
