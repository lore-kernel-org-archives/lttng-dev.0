From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-tools v2 1/4] Save registration time
 for app
Date: Tue, 13 Aug 2019 16:28:33 -0400 (EDT)
Message-ID: <1548146053.2292.1565728113064.JavaMail.zimbra__7550.93043423898$1565728129$gmane$org@efficios.com>
References: <20190813202519.31043-1-jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 467PS16nBzzr88
 for <lttng-dev@lists.lttng.org>; Tue, 13 Aug 2019 16:28:33 -0400 (EDT)
In-Reply-To: <20190813202519.31043-1-jonathan.rajotte-julien@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, Jeremie Galarneau <jgalar@efficios.com>
List-Id: lttng-dev@lists.lttng.org

Merged this patch as well in my dev branch, thanks,

Mathieu

----- On Aug 13, 2019, at 4:25 PM, Jonathan Rajotte jonathan.rajotte-julien@efficios.com wrote:

> Reuse the registration time for path generation.
> 
> Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
> ---
> src/bin/lttng-sessiond/ust-app.c | 7 +++----
> src/bin/lttng-sessiond/ust-app.h | 5 +++++
> 2 files changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/src/bin/lttng-sessiond/ust-app.c b/src/bin/lttng-sessiond/ust-app.c
> index 4bee50496..443232e79 100644
> --- a/src/bin/lttng-sessiond/ust-app.c
> +++ b/src/bin/lttng-sessiond/ust-app.c
> @@ -1831,15 +1831,12 @@ static void shadow_copy_channel(struct ust_app_channel
> *ua_chan,
> static void shadow_copy_session(struct ust_app_session *ua_sess,
> 		struct ltt_ust_session *usess, struct ust_app *app)
> {
> -	time_t rawtime;
> 	struct tm *timeinfo;
> 	char datetime[16];
> 	int ret;
> 	char tmp_shm_path[PATH_MAX];
> 
> -	/* Get date and time for unique app path */
> -	time(&rawtime);
> -	timeinfo = localtime(&rawtime);
> +	timeinfo = localtime(&app->registration_time);
> 	strftime(datetime, sizeof(datetime), "%Y%m%d-%H%M%S", timeinfo);
> 
> 	DBG2("Shadow copy of session handle %d", ua_sess->handle);
> @@ -3376,6 +3373,8 @@ void ust_app_add(struct ust_app *app)
> 	assert(app);
> 	assert(app->notify_sock >= 0);
> 
> +	app->registration_time = time(NULL);
> +
> 	rcu_read_lock();
> 
> 	/*
> diff --git a/src/bin/lttng-sessiond/ust-app.h b/src/bin/lttng-sessiond/ust-app.h
> index b90ff4bce..d9279f0e4 100644
> --- a/src/bin/lttng-sessiond/ust-app.h
> +++ b/src/bin/lttng-sessiond/ust-app.h
> @@ -298,6 +298,11 @@ struct ust_app {
> 	 * to a negative value indicating that the agent application is gone.
> 	 */
> 	int agent_app_sock;
> +	/*
> +	 * Time at which the app is registred.
> +	 * Used for path creation
> +	 */
> +	time_t registration_time;
> };
> 
> #ifdef HAVE_LIBLTTNG_UST_CTL
> --
> 2.17.1
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
