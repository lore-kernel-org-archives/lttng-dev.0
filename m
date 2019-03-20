From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-tools] Fix: use strcmp instead of
 strncmp for full match cases
Date: Wed, 20 Mar 2019 15:31:55 -0400 (EDT)
Message-ID: <1660311657.4595.1553110315190.JavaMail.zimbra__47680.5447878846$1553110327$gmane$org@efficios.com>
References: <20190320163313.15616-1-ylamarre@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 44Pg652xVyz17r7
 for <lttng-dev@lists.lttng.org>; Wed, 20 Mar 2019 15:31:56 -0400 (EDT)
In-Reply-To: <20190320163313.15616-1-ylamarre@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Yannick Lamarre <ylamarre@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, Jeremie Galarneau <jgalar@efficios.com>
List-Id: lttng-dev@lists.lttng.org

----- On Mar 20, 2019, at 12:33 PM, Yannick Lamarre ylamarre@efficios.com wrote:

> Except for a single case where the compared string is not ended with
> '\0', strncmp was replaced by strcmp in cases where a full string match
> was required. The exception was fixed with a length comparison prior
> the strncmp call.

I'm worried about the security implications associated with turning
strncmp into strcmp in situations where the input could be controlled
by an attacker.

This should come with a more thorough explanation detailing why this
change is needed, and how comes it does not introduce a security risk,
IOW, what is the scheme used to do input validation before using strcmp
on that input ?

Thanks,

MAthieu

> 
> Fixes: #987
> Signed-off-by: Yannick Lamarre <ylamarre@efficios.com>
> ---
> src/bin/lttng-sessiond/agent.c           | 3 +--
> src/bin/lttng-sessiond/cmd.c             | 2 +-
> src/bin/lttng-sessiond/snapshot.c        | 2 +-
> src/bin/lttng-sessiond/ust-registry.c    | 2 +-
> src/bin/lttng/commands/add_context.c     | 8 ++++----
> src/bin/lttng/commands/create.c          | 4 +---
> src/bin/lttng/commands/enable_channels.c | 4 ++--
> src/common/lttng-elf.c                   | 1 +
> src/common/testpoint/testpoint.c         | 4 ++--
> 9 files changed, 14 insertions(+), 16 deletions(-)
> 
> diff --git a/src/bin/lttng-sessiond/agent.c b/src/bin/lttng-sessiond/agent.c
> index 3b8acd2a..af65fa9c 100644
> --- a/src/bin/lttng-sessiond/agent.c
> +++ b/src/bin/lttng-sessiond/agent.c
> @@ -149,8 +149,7 @@ static int ht_match_event(struct cds_lfht_node *node,
> 	}
> 
> 	if (event->filter_expression) {
> -		if (strncmp(event->filter_expression, key->filter_expression,
> -				strlen(event->filter_expression)) != 0) {
> +		if (strcmp(event->filter_expression, key->filter_expression) != 0) {
> 			goto no_match;
> 		}
> 	}
> diff --git a/src/bin/lttng-sessiond/cmd.c b/src/bin/lttng-sessiond/cmd.c
> index d91869fa..52591383 100644
> --- a/src/bin/lttng-sessiond/cmd.c
> +++ b/src/bin/lttng-sessiond/cmd.c
> @@ -2310,7 +2310,7 @@ static int _cmd_enable_event(struct ltt_session *session,
> 		}
> 
> 		/* The wild card * means that everything should be enabled. */
> -		if (strncmp(event->name, "*", 1) == 0 && strlen(event->name) == 1) {
> +		if (!strcmp(event->name, "*")) {
> 			ret = event_agent_enable_all(usess, agt, event, filter,
> 					filter_expression);
> 		} else {
> diff --git a/src/bin/lttng-sessiond/snapshot.c
> b/src/bin/lttng-sessiond/snapshot.c
> index 447806bf..db7cfe77 100644
> --- a/src/bin/lttng-sessiond/snapshot.c
> +++ b/src/bin/lttng-sessiond/snapshot.c
> @@ -251,7 +251,7 @@ struct snapshot_output *snapshot_find_output_by_name(const
> char *name,
> 
> 	cds_lfht_for_each_entry(snapshot->output_ht->ht, &iter.iter, output,
> 		node.node) {
> -		if (!strncmp(output->name, name, strlen(name))) {
> +		if (!strcmp(output->name, name)) {
> 			return output;
> 		}
> 	}
> diff --git a/src/bin/lttng-sessiond/ust-registry.c
> b/src/bin/lttng-sessiond/ust-registry.c
> index a8db79ea..8045075a 100644
> --- a/src/bin/lttng-sessiond/ust-registry.c
> +++ b/src/bin/lttng-sessiond/ust-registry.c
> @@ -48,7 +48,7 @@ static int ht_match_event(struct cds_lfht_node *node, const
> void *_key)
> 	key = _key;
> 
> 	/* It has to be a perfect match. First, compare the event names. */
> -	if (strncmp(event->name, key->name, sizeof(event->name))) {
> +	if (strcmp(event->name, key->name)) {
> 		goto no_match;
> 	}
> 
> diff --git a/src/bin/lttng/commands/add_context.c
> b/src/bin/lttng/commands/add_context.c
> index 7aef4d50..3fd1ebd0 100644
> --- a/src/bin/lttng/commands/add_context.c
> +++ b/src/bin/lttng/commands/add_context.c
> @@ -885,15 +885,15 @@ int find_ctx_type_perf_raw(const char *ctx, struct
> ctx_type *type)
> 		cur_list = NULL;
> 		switch (field_pos) {
> 		case 0:
> -			if (strncmp(next, "perf", 4) != 0) {
> +			if (strcmp(next, "perf") != 0) {
> 				ret = -1;
> 				goto end;
> 			}
> 			break;
> 		case 1:
> -			if (strncmp(next, "cpu", 3) == 0) {
> +			if (strcmp(next, "cpu") == 0) {
> 				type->opt->ctx_type = CONTEXT_PERF_CPU_COUNTER;
> -			} else if (strncmp(next, "thread", 4) == 0) {
> +			} else if (strcmp(next, "thread") == 0) {
> 				type->opt->ctx_type = CONTEXT_PERF_THREAD_COUNTER;
> 			} else {
> 				ret = -1;
> @@ -901,7 +901,7 @@ int find_ctx_type_perf_raw(const char *ctx, struct ctx_type
> *type)
> 			}
> 			break;
> 		case 2:
> -			if (strncmp(next, "raw", 3) != 0) {
> +			if (strcmp(next, "raw") != 0) {
> 				ret = -1;
> 				goto end;
> 			}
> diff --git a/src/bin/lttng/commands/create.c b/src/bin/lttng/commands/create.c
> index d2741c37..aea02dd3 100644
> --- a/src/bin/lttng/commands/create.c
> +++ b/src/bin/lttng/commands/create.c
> @@ -264,9 +264,7 @@ static int create_session(void)
> 		 */
> 		if ((strncmp(opt_session_name, DEFAULT_SESSION_NAME "-",
> 					strlen(DEFAULT_SESSION_NAME) + 1) == 0) ||
> -				(strncmp(opt_session_name, DEFAULT_SESSION_NAME,
> -					strlen(DEFAULT_SESSION_NAME)) == 0 &&
> -				strlen(opt_session_name) == strlen(DEFAULT_SESSION_NAME))) {
> +				(strcmp(opt_session_name, DEFAULT_SESSION_NAME) == 0)) {
> 			ERR("%s is a reserved keyword for default session(s)",
> 					DEFAULT_SESSION_NAME);
> 			ret = CMD_ERROR;
> diff --git a/src/bin/lttng/commands/enable_channels.c
> b/src/bin/lttng/commands/enable_channels.c
> index b4e2942c..52d18bcc 100644
> --- a/src/bin/lttng/commands/enable_channels.c
> +++ b/src/bin/lttng/commands/enable_channels.c
> @@ -210,9 +210,9 @@ static int enable_channel(char *session_name)
> 
> 	/* Setting channel output */
> 	if (opt_output) {
> -		if (!strncmp(output_mmap, opt_output, strlen(output_mmap))) {
> +		if (!strcmp(output_mmap, opt_output)) {
> 			chan_opts.attr.output = LTTNG_EVENT_MMAP;
> -		} else if (!strncmp(output_splice, opt_output, strlen(output_splice))) {
> +		} else if (!strcmp(output_splice, opt_output)) {
> 			chan_opts.attr.output = LTTNG_EVENT_SPLICE;
> 		} else {
> 			ERR("Unknown output type %s. Possible values are: %s, %s\n",
> diff --git a/src/common/lttng-elf.c b/src/common/lttng-elf.c
> index cd10632c..2487e8bf 100644
> --- a/src/common/lttng-elf.c
> +++ b/src/common/lttng-elf.c
> @@ -975,6 +975,7 @@ int lttng_elf_get_sdt_probe_offsets(int fd, const char
> *provider_name,
> 		 * and go to the next 4 byte alignement.
> 		 */
> 		if (note_type != NOTE_STAPSDT_TYPE ||
> +			name_size != strlen(NOTE_STAPSDT_NAME) ||
> 			strncmp(curr_data_ptr, NOTE_STAPSDT_NAME, name_size) != 0) {
> 			continue;
> 		}
> diff --git a/src/common/testpoint/testpoint.c b/src/common/testpoint/testpoint.c
> index 8ce5b9d2..d94772bb 100644
> --- a/src/common/testpoint/testpoint.c
> +++ b/src/common/testpoint/testpoint.c
> @@ -20,7 +20,7 @@
> #define _LGPL_SOURCE
> #include <dlfcn.h>  /* for dlsym   */
> #include <stdlib.h> /* for getenv  */
> -#include <string.h> /* for strncmp */
> +#include <string.h> /* for strcmp */
> 
> #include "testpoint.h"
> 
> @@ -39,7 +39,7 @@ static void __attribute__((constructor))
> lttng_testpoint_check(void)
> 
> 	testpoint_env_val = getenv(lttng_testpoint_env_var);
> 	if (testpoint_env_val != NULL
> -			&& (strncmp(testpoint_env_val, "1", 1) == 0)) {
> +			&& strcmp(testpoint_env_val, "1") == 0) {
> 		lttng_testpoint_activated = 1;
> 	}
> }
> --
> 2.11.0
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
