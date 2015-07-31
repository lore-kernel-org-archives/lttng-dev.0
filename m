From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-ust] Rename Java Agent event names
	to	"event"
Date: Fri, 31 Jul 2015 02:06:45 +0000 (UTC)
Message-ID: <130248237.22.1438308405499.JavaMail.zimbra__4804.1493785151$1438308472$gmane$org@efficios.com>
References: <1438287115-3503-1-git-send-email-alexmonthy@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1ZKzis-0008VX-Pi
 for lttng-dev@lists.lttng.org; Thu, 30 Jul 2015 22:07:01 -0400
In-Reply-To: <1438287115-3503-1-git-send-email-alexmonthy@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Alexandre Montplaisir <alexmonthy@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, =?utf-8?B?SsOpcsOpbWll?= Galarneau <jgalar@efficios.com>
List-Id: lttng-dev@lists.lttng.org

Merged, thanks!

Mathieu

----- On Jul 30, 2015, at 4:11 PM, Alexandre Montplaisir alexmonthy@efficios.com wrote:

> Previously, separate event names were used for events targeting
> a root session daemon or a user one. Those were "sys_event" and
> "user_event", respectively.
> 
> Now that the Java side only sends one event type, we can rename
> it to simply "event".
> 
> This patch is dependant on a similar update on the lttng-tools
> side.
> 
> Signed-off-by: Alexandre Montplaisir <alexmonthy@efficios.com>
> ---
> liblttng-ust-java-agent/jni/jul/lttng_ust_jul.c     | 3 +--
> liblttng-ust-java-agent/jni/jul/lttng_ust_jul.h     | 3 +--
> liblttng-ust-java-agent/jni/log4j/lttng_ust_log4j.c | 3 +--
> liblttng-ust-java-agent/jni/log4j/lttng_ust_log4j.h | 3 +--
> 4 files changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/liblttng-ust-java-agent/jni/jul/lttng_ust_jul.c
> b/liblttng-ust-java-agent/jni/jul/lttng_ust_jul.c
> index 7363f65..0e86fbc 100644
> --- a/liblttng-ust-java-agent/jni/jul/lttng_ust_jul.c
> +++ b/liblttng-ust-java-agent/jni/jul/lttng_ust_jul.c
> @@ -41,8 +41,7 @@ JNIEXPORT void JNICALL
> Java_org_lttng_ust_agent_jul_LttngLogHandler_tracepoint(J
> 	const char *class_name_cstr = (*env)->GetStringUTFChars(env, class_name,
> 	&iscopy);
> 	const char *method_name_cstr = (*env)->GetStringUTFChars(env, method_name,
> 	&iscopy);
> 
> -	// FIXME Change "sys_event" to "event" once lttng-tools is updated
> -	tracepoint(lttng_jul, sys_event, msg_cstr, logger_name_cstr,
> +	tracepoint(lttng_jul, event, msg_cstr, logger_name_cstr,
> 			class_name_cstr, method_name_cstr, millis, log_level, thread_id);
> 
> 	(*env)->ReleaseStringUTFChars(env, msg, msg_cstr);
> diff --git a/liblttng-ust-java-agent/jni/jul/lttng_ust_jul.h
> b/liblttng-ust-java-agent/jni/jul/lttng_ust_jul.h
> index 1482d90..ebbe2c3 100644
> --- a/liblttng-ust-java-agent/jni/jul/lttng_ust_jul.h
> +++ b/liblttng-ust-java-agent/jni/jul/lttng_ust_jul.h
> @@ -27,8 +27,7 @@
> /*
>  * Tracepoint used by Java applications using the JUL handler.
>  */
> -// FIXME Change "sys_event" to "event" once lttng-tools is updated
> -TRACEPOINT_EVENT(lttng_jul, sys_event,
> +TRACEPOINT_EVENT(lttng_jul, event,
> 	TP_ARGS(
> 		const char *, msg,
> 		const char *, logger_name,
> diff --git a/liblttng-ust-java-agent/jni/log4j/lttng_ust_log4j.c
> b/liblttng-ust-java-agent/jni/log4j/lttng_ust_log4j.c
> index d5df70e..73d4eee 100644
> --- a/liblttng-ust-java-agent/jni/log4j/lttng_ust_log4j.c
> +++ b/liblttng-ust-java-agent/jni/log4j/lttng_ust_log4j.c
> @@ -45,8 +45,7 @@ JNIEXPORT void JNICALL
> Java_org_lttng_ust_agent_log4j_LttngLogAppender_tracepoin
> 	const char *file_name_cstr = (*env)->GetStringUTFChars(env, file_name, &iscopy);
> 	const char *thread_name_cstr = (*env)->GetStringUTFChars(env, thread_name,
> 	&iscopy);
> 
> -	// FIXME Change "sys_event" to "event" once lttng-tools is updated
> -	tracepoint(lttng_log4j, sys_event, msg_cstr, logger_name_cstr,
> +	tracepoint(lttng_log4j, event, msg_cstr, logger_name_cstr,
> 		   class_name_cstr, method_name_cstr, file_name_cstr,
> 		   line_number, timestamp, loglevel, thread_name_cstr);
> 
> diff --git a/liblttng-ust-java-agent/jni/log4j/lttng_ust_log4j.h
> b/liblttng-ust-java-agent/jni/log4j/lttng_ust_log4j.h
> index 7e20b69..d9b592d 100644
> --- a/liblttng-ust-java-agent/jni/log4j/lttng_ust_log4j.h
> +++ b/liblttng-ust-java-agent/jni/log4j/lttng_ust_log4j.h
> @@ -27,8 +27,7 @@
> /*
>  * Tracepoint used by Java applications using the log4j log appender.
>  */
> -// FIXME Change "sys_event" to "event" once lttng-tools is updated
> -TRACEPOINT_EVENT(lttng_log4j, sys_event,
> +TRACEPOINT_EVENT(lttng_log4j, event,
> 	TP_ARGS(
> 		const char *, msg,
> 		const char *, logger_name,
> --
> 2.5.0
> 
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
