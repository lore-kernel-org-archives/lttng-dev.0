From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-modules] fix: use user ns wrapper code
 in new id trackers
Date: Tue, 17 Dec 2019 12:23:33 -0500 (EST)
Message-ID: <1879153712.8837.1576603413126.JavaMail.zimbra__23148.9095532865$1576603457$gmane$org@efficios.com>
References: <20191217171111.6782-1-mjeanson@efficios.com>
 <20191217171111.6782-2-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 47clNQ03ZWz1BRT
 for <lttng-dev@lists.lttng.org>; Tue, 17 Dec 2019 12:23:33 -0500 (EST)
In-Reply-To: <20191217171111.6782-2-mjeanson@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Michael Jeanson <mjeanson@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Merged into master, thanks!

Mathieu

----- On Dec 17, 2019, at 12:11 PM, Michael Jeanson mjeanson@efficios.com wrote:

> These wrappers are required to translate kuid on kernels prior to v3.5.
> 
> Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
> ---
> probes/lttng-tracepoint-event-impl.h | 18 +++++++++---------
> 1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/probes/lttng-tracepoint-event-impl.h
> b/probes/lttng-tracepoint-event-impl.h
> index 39454fb..321cdfa 100644
> --- a/probes/lttng-tracepoint-event-impl.h
> +++ b/probes/lttng-tracepoint-event-impl.h
> @@ -11,7 +11,6 @@
> #include <linux/rculist.h>
> #include <asm/byteorder.h>
> #include <linux/swab.h>
> -#include <linux/uidgid.h>
> 
> #include <probes/lttng.h>
> #include <probes/lttng-types.h>
> @@ -20,6 +19,7 @@
> #include <wrapper/ringbuffer/frontend_types.h>
> #include <wrapper/ringbuffer/backend.h>
> #include <wrapper/rcu.h>
> +#include <wrapper/user_namespace.h>
> #include <lttng-events.h>
> #include <lttng-tracer-core.h>
> #include <lttng-tp-mempool.h>
> @@ -1146,19 +1146,19 @@ static void __event_probe__##_name(void *__data, _proto)
> 		      \
> 		return;							      \
> 	__lf = lttng_rcu_dereference(__session->uid_tracker.p);		      \
> 	if (__lf && likely(!lttng_id_tracker_lookup(__lf,		      \
> -			from_kuid(&init_user_ns, current_uid()))))	      \
> +			lttng_current_uid())))				      \
> 		return;							      \
> 	__lf = lttng_rcu_dereference(__session->vuid_tracker.p);	      \
> 	if (__lf && likely(!lttng_id_tracker_lookup(__lf,		      \
> -			from_kuid(current_user_ns(), current_uid()))))	      \
> +			lttng_current_vuid())))				      \
> 		return;							      \
> 	__lf = lttng_rcu_dereference(__session->gid_tracker.p);		      \
> 	if (__lf && likely(!lttng_id_tracker_lookup(__lf,		      \
> -			from_kgid(&init_user_ns, current_gid()))))	      \
> +			lttng_current_gid())))				      \
> 		return;							      \
> 	__lf = lttng_rcu_dereference(__session->vgid_tracker.p);	      \
> 	if (__lf && likely(!lttng_id_tracker_lookup(__lf,		      \
> -			from_kgid(current_user_ns(), current_gid()))))	      \
> +			lttng_current_vgid())))				      \
> 		return;							      \
> 	__orig_dynamic_len_offset = this_cpu_ptr(&lttng_dynamic_len_stack)->offset; \
> 	__dynamic_len_idx = __orig_dynamic_len_offset;			      \
> @@ -1239,19 +1239,19 @@ static void __event_probe__##_name(void *__data)
> 			      \
> 		return;							      \
> 	__lf = lttng_rcu_dereference(__session->uid_tracker.p);		      \
> 	if (__lf && likely(!lttng_id_tracker_lookup(__lf,		      \
> -			from_kuid(&init_user_ns, current_uid()))))	      \
> +			lttng_current_uid())))				      \
> 		return;							      \
> 	__lf = lttng_rcu_dereference(__session->vuid_tracker.p);	      \
> 	if (__lf && likely(!lttng_id_tracker_lookup(__lf,		      \
> -			from_kuid(current_user_ns(), current_uid()))))	      \
> +			lttng_current_vuid())))				      \
> 		return;							      \
> 	__lf = lttng_rcu_dereference(__session->gid_tracker.p);		      \
> 	if (__lf && likely(!lttng_id_tracker_lookup(__lf,		      \
> -			from_kgid(&init_user_ns, current_gid()))))	      \
> +			lttng_current_gid())))				      \
> 		return;							      \
> 	__lf = lttng_rcu_dereference(__session->vgid_tracker.p);	      \
> 	if (__lf && likely(!lttng_id_tracker_lookup(__lf,		      \
> -			from_kgid(current_user_ns(), current_gid()))))	      \
> +			lttng_current_vgid())))				      \
> 		return;							      \
> 	__orig_dynamic_len_offset = this_cpu_ptr(&lttng_dynamic_len_stack)->offset; \
> 	__dynamic_len_idx = __orig_dynamic_len_offset;			      \
> --
> 2.17.1

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
