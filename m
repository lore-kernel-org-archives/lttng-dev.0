From: =?iso-8859-1?Q?J=E9r=E9mie?= Galarneau <jeremie.galarneau@efficios.com>
Subject: Re: [RFC PATCH lttng-tools stable-2.11/master] Fix:
 reintroduce lazy kernel modules load, fix empty syscall list
Date: Thu, 5 Sep 2019 17:02:54 -0400
Message-ID: <20190905210254.GE20141__37365.9308928595$1567717407$gmane$org@gmail.com>
References: <20190523191150.8538-1-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qk1-f195.google.com (mail-qk1-f195.google.com
 [209.85.222.195])
 by lists.lttng.org (Postfix) with ESMTPS id 46PY764yzjzsPj
 for <lttng-dev@lists.lttng.org>; Thu,  5 Sep 2019 17:02:58 -0400 (EDT)
Received: by mail-qk1-f195.google.com with SMTP id 201so3558975qkd.13
 for <lttng-dev@lists.lttng.org>; Thu, 05 Sep 2019 14:02:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20190523191150.8538-1-mathieu.desnoyers@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org, jgalar@efficios.com
List-Id: lttng-dev@lists.lttng.org

Merged in master and stable-2.11.

Thanks!
J=E9r=E9mie

On Thu, May 23, 2019 at 03:11:50PM -0400, Mathieu Desnoyers wrote:
> Up and including to lttng 2.10, if the lttng-modules are not available
> when the session daemon starts, an attempt is made to load them each
> time a command try to interact with the kernel domain.
> =

> 2.11-rc introduces a change in behavior which removes this lazy
> initialization. This is an issue for distribution packaging (e.g.
> Ubuntu) where there is no strong dependency between lttng-tools and
> lttng-modules (because either is optional). So we can be unlucky and
> find ourselves in a situation where the modules are not available when
> the session daemon is launched at installation, but only afterwards.
> =

> Re-introduce the lazy kernel module load behavior, since this is
> expected by users.
> =

> Also, fix an issue with empty syscall list in those lazy initialization
> scenario by moving invocation of syscall_init_table() from main() to
> init_kernel_tracer().
> =

> While we are there, cleanup the following in session daemon:
> =

> - move kernel_tracer_fd from globals.c to kernel.c. It becomes a static
>   variable,
> - move module_proc_lttng from main.c to kernel.c,
> - move init_kernel_tracer() from main.c to kernel.c,
> - introduce kernel.c:cleanup_kernel_tracer(), invoke it from program
>   cleanup,
> - introduce kernel_tracer_is_initialized() to check the state of
>   kernel tracer initialization,
> - adapt kernel.c functions to use the static kernel_tracer_fd rather
>   than expect it as parameter,
> - update syscall_init_table, invoked from kernel.c, to pass the
>   kernel_tracer_fd as parameter.
> =

> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> ---
>  src/bin/lttng-sessiond/client.c                    |  11 +-
>  src/bin/lttng-sessiond/cmd.c                       |  24 ++--
>  src/bin/lttng-sessiond/globals.c                   |   1 -
>  src/bin/lttng-sessiond/kernel.c                    | 136 +++++++++++++++=
++++--
>  src/bin/lttng-sessiond/kernel.h                    |  14 ++-
>  src/bin/lttng-sessiond/lttng-sessiond.h            |   1 -
>  src/bin/lttng-sessiond/lttng-syscall.c             |   4 +-
>  src/bin/lttng-sessiond/lttng-syscall.h             |   2 +-
>  src/bin/lttng-sessiond/main.c                      |  98 +--------------
>  .../lttng-sessiond/notification-thread-events.c    |   3 +-
>  10 files changed, 160 insertions(+), 134 deletions(-)
> =

> diff --git a/src/bin/lttng-sessiond/client.c b/src/bin/lttng-sessiond/cli=
ent.c
> index 4565a18c..dda778d8 100644
> --- a/src/bin/lttng-sessiond/client.c
> +++ b/src/bin/lttng-sessiond/client.c
> @@ -478,7 +478,7 @@ static int create_kernel_session(struct ltt_session *=
session)
>  =

>  	DBG("Creating kernel session");
>  =

> -	ret =3D kernel_create_session(session, kernel_tracer_fd);
> +	ret =3D kernel_create_session(session);
>  	if (ret < 0) {
>  		ret =3D LTTNG_ERR_KERN_SESS_FAIL;
>  		goto error_create;
> @@ -877,6 +877,15 @@ static int process_client_msg(struct command_ctx *cm=
d_ctx, int sock,
>  			goto error;
>  		}
>  =

> +		/* Kernel tracer check */
> +		if (!kernel_tracer_is_initialized()) {
> +			/* Basically, load kernel tracer modules */
> +			ret =3D init_kernel_tracer();
> +			if (ret !=3D 0) {
> +				goto error;
> +			}
> +		}
> +
>  		/* Consumer is in an ERROR state. Report back to client */
>  		if (uatomic_read(&kernel_consumerd_state) =3D=3D CONSUMER_ERROR) {
>  			ret =3D LTTNG_ERR_NO_KERNCONSUMERD;
> diff --git a/src/bin/lttng-sessiond/cmd.c b/src/bin/lttng-sessiond/cmd.c
> index 01efcaf0..39985f79 100644
> --- a/src/bin/lttng-sessiond/cmd.c
> +++ b/src/bin/lttng-sessiond/cmd.c
> @@ -1210,7 +1210,7 @@ error:
>  /*
>   * Start a kernel session by opening all necessary streams.
>   */
> -static int start_kernel_session(struct ltt_kernel_session *ksess, int wp=
ipe)
> +static int start_kernel_session(struct ltt_kernel_session *ksess)
>  {
>  	int ret;
>  	struct ltt_kernel_channel *kchan;
> @@ -1262,7 +1262,7 @@ static int start_kernel_session(struct ltt_kernel_s=
ession *ksess, int wpipe)
>  	}
>  =

>  	/* Quiescent wait after starting trace */
> -	kernel_wait_quiescent(wpipe);
> +	kernel_wait_quiescent();
>  =

>  	ksess->active =3D 1;
>  =

> @@ -1294,7 +1294,7 @@ int cmd_disable_channel(struct ltt_session *session,
>  			goto error;
>  		}
>  =

> -		kernel_wait_quiescent(kernel_tracer_fd);
> +		kernel_wait_quiescent();
>  		break;
>  	}
>  	case LTTNG_DOMAIN_UST:
> @@ -1352,7 +1352,7 @@ int cmd_track_pid(struct ltt_session *session, enum=
 lttng_domain_type domain,
>  			goto error;
>  		}
>  =

> -		kernel_wait_quiescent(kernel_tracer_fd);
> +		kernel_wait_quiescent();
>  		break;
>  	}
>  	case LTTNG_DOMAIN_UST:
> @@ -1403,7 +1403,7 @@ int cmd_untrack_pid(struct ltt_session *session, en=
um lttng_domain_type domain,
>  			goto error;
>  		}
>  =

> -		kernel_wait_quiescent(kernel_tracer_fd);
> +		kernel_wait_quiescent();
>  		break;
>  	}
>  	case LTTNG_DOMAIN_UST:
> @@ -1483,7 +1483,7 @@ int cmd_enable_channel(struct ltt_session *session,
>  	switch (domain->type) {
>  	case LTTNG_DOMAIN_KERNEL:
>  	{
> -		if (kernel_supports_ring_buffer_snapshot_sample_positions(kernel_trace=
r_fd) !=3D 1) {
> +		if (kernel_supports_ring_buffer_snapshot_sample_positions() !=3D 1) {
>  			/* Sampling position of buffer is not supported */
>  			WARN("Kernel tracer does not support buffer monitoring. "
>  					"Setting the monitor interval timer to 0 "
> @@ -1534,7 +1534,7 @@ int cmd_enable_channel(struct ltt_session *session,
>  			goto error;
>  		}
>  =

> -		kernel_wait_quiescent(kernel_tracer_fd);
> +		kernel_wait_quiescent();
>  		break;
>  	}
>  	case LTTNG_DOMAIN_UST:
> @@ -1669,7 +1669,7 @@ int cmd_disable_event(struct ltt_session *session,
>  			goto error_unlock;
>  		}
>  =

> -		kernel_wait_quiescent(kernel_tracer_fd);
> +		kernel_wait_quiescent();
>  		break;
>  	}
>  	case LTTNG_DOMAIN_UST:
> @@ -2119,7 +2119,7 @@ static int _cmd_enable_event(struct ltt_session *se=
ssion,
>  			goto error;
>  		}
>  =

> -		kernel_wait_quiescent(kernel_tracer_fd);
> +		kernel_wait_quiescent();
>  		break;
>  	}
>  	case LTTNG_DOMAIN_UST:
> @@ -2387,7 +2387,7 @@ ssize_t cmd_list_tracepoints(enum lttng_domain_type=
 domain,
>  =

>  	switch (domain) {
>  	case LTTNG_DOMAIN_KERNEL:
> -		nb_events =3D kernel_list_events(kernel_tracer_fd, events);
> +		nb_events =3D kernel_list_events(events);
>  		if (nb_events < 0) {
>  			ret =3D LTTNG_ERR_KERN_LIST_FAIL;
>  			goto error;
> @@ -2671,7 +2671,7 @@ int cmd_start_trace(struct ltt_session *session)
>  	/* Kernel tracing */
>  	if (ksession !=3D NULL) {
>  		DBG("Start kernel tracing session %s", session->name);
> -		ret =3D start_kernel_session(ksession, kernel_tracer_fd);
> +		ret =3D start_kernel_session(ksession);
>  		if (ret !=3D LTTNG_OK) {
>  			goto error;
>  		}
> @@ -2746,7 +2746,7 @@ int cmd_stop_trace(struct ltt_session *session)
>  			goto error;
>  		}
>  =

> -		kernel_wait_quiescent(kernel_tracer_fd);
> +		kernel_wait_quiescent();
>  =

>  		/* Flush metadata after stopping (if exists) */
>  		if (ksession->metadata_stream_fd >=3D 0) {
> diff --git a/src/bin/lttng-sessiond/globals.c b/src/bin/lttng-sessiond/gl=
obals.c
> index efe80baa..c829d1fd 100644
> --- a/src/bin/lttng-sessiond/globals.c
> +++ b/src/bin/lttng-sessiond/globals.c
> @@ -30,7 +30,6 @@ struct notification_thread_handle *notification_thread_=
handle;
>  =

>  struct lttng_ht *agent_apps_ht_by_sock =3D NULL;
>  =

> -int kernel_tracer_fd =3D -1;
>  struct lttng_kernel_tracer_version kernel_tracer_version;
>  struct lttng_kernel_tracer_abi_version kernel_tracer_abi_version;
>  =

> diff --git a/src/bin/lttng-sessiond/kernel.c b/src/bin/lttng-sessiond/ker=
nel.c
> index b4fc995c..975655de 100644
> --- a/src/bin/lttng-sessiond/kernel.c
> +++ b/src/bin/lttng-sessiond/kernel.c
> @@ -22,18 +22,22 @@
>  #include <string.h>
>  #include <unistd.h>
>  #include <inttypes.h>
> +#include <sys/types.h>
>  =

>  #include <common/common.h>
>  #include <common/kernel-ctl/kernel-ctl.h>
>  #include <common/kernel-ctl/kernel-ioctl.h>
>  #include <common/sessiond-comm/sessiond-comm.h>
>  =

> +#include "lttng-sessiond.h"
> +#include "lttng-syscall.h"
>  #include "consumer.h"
>  #include "kernel.h"
>  #include "kernel-consumer.h"
>  #include "kern-modules.h"
>  #include "utils.h"
>  #include "rotate.h"
> +#include "modprobe.h"
>  =

>  /*
>   * Key used to reference a channel between the sessiond and the consumer=
. This
> @@ -41,6 +45,10 @@
>   */
>  static uint64_t next_kernel_channel_key;
>  =

> +static const char *module_proc_lttng =3D "/proc/lttng";
> +
> +static int kernel_tracer_fd =3D -1;
> +
>  #include <lttng/userspace-probe.h>
>  #include <lttng/userspace-probe-internal.h>
>  /*
> @@ -91,7 +99,7 @@ error:
>   * Create a new kernel session, register it to the kernel tracer and add=
 it to
>   * the session daemon session.
>   */
> -int kernel_create_session(struct ltt_session *session, int tracer_fd)
> +int kernel_create_session(struct ltt_session *session)
>  {
>  	int ret;
>  	struct ltt_kernel_session *lks;
> @@ -106,7 +114,7 @@ int kernel_create_session(struct ltt_session *session=
, int tracer_fd)
>  	}
>  =

>  	/* Kernel tracer session creation */
> -	ret =3D kernctl_create_session(tracer_fd);
> +	ret =3D kernctl_create_session(kernel_tracer_fd);
>  	if (ret < 0) {
>  		PERROR("ioctl kernel create session");
>  		goto error;
> @@ -834,9 +842,10 @@ error:
>  /*
>   * Make a kernel wait to make sure in-flight probe have completed.
>   */
> -void kernel_wait_quiescent(int fd)
> +void kernel_wait_quiescent(void)
>  {
>  	int ret;
> +	int fd =3D kernel_tracer_fd;
>  =

>  	DBG("Kernel quiescent wait on %d", fd);
>  =

> @@ -995,7 +1004,7 @@ error:
>  /*
>   * Get the event list from the kernel tracer and return the number of el=
ements.
>   */
> -ssize_t kernel_list_events(int tracer_fd, struct lttng_event **events)
> +ssize_t kernel_list_events(struct lttng_event **events)
>  {
>  	int fd, ret;
>  	char *event;
> @@ -1005,7 +1014,7 @@ ssize_t kernel_list_events(int tracer_fd, struct lt=
tng_event **events)
>  =

>  	assert(events);
>  =

> -	fd =3D kernctl_tracepoint_list(tracer_fd);
> +	fd =3D kernctl_tracepoint_list(kernel_tracer_fd);
>  	if (fd < 0) {
>  		PERROR("kernel tracepoint list");
>  		goto error;
> @@ -1079,13 +1088,12 @@ error:
>  /*
>   * Get kernel version and validate it.
>   */
> -int kernel_validate_version(int tracer_fd,
> -		struct lttng_kernel_tracer_version *version,
> +int kernel_validate_version(struct lttng_kernel_tracer_version *version,
>  		struct lttng_kernel_tracer_abi_version *abi_version)
>  {
>  	int ret;
>  =

> -	ret =3D kernctl_tracer_version(tracer_fd, version);
> +	ret =3D kernctl_tracer_version(kernel_tracer_fd, version);
>  	if (ret < 0) {
>  		ERR("Failed to retrieve the lttng-modules version");
>  		goto error;
> @@ -1097,7 +1105,7 @@ int kernel_validate_version(int tracer_fd,
>  			version->major, VERSION_MAJOR);
>  		goto error_version;
>  	}
> -	ret =3D kernctl_tracer_abi_version(tracer_fd, abi_version);
> +	ret =3D kernctl_tracer_abi_version(kernel_tracer_fd, abi_version);
>  	if (ret < 0) {
>  		ERR("Failed to retrieve lttng-modules ABI version");
>  		goto error;
> @@ -1372,12 +1380,12 @@ int kernel_syscall_mask(int chan_fd, char **sysca=
ll_mask, uint32_t *nr_bits)
>   * Return 1 on success, 0 when feature is not supported, negative value =
in case
>   * of errors.
>   */
> -int kernel_supports_ring_buffer_snapshot_sample_positions(int tracer_fd)
> +int kernel_supports_ring_buffer_snapshot_sample_positions(void)
>  {
>  	int ret =3D 0; // Not supported by default
>  	struct lttng_kernel_tracer_abi_version abi;
>  =

> -	ret =3D kernctl_tracer_abi_version(tracer_fd, &abi);
> +	ret =3D kernctl_tracer_abi_version(kernel_tracer_fd, &abi);
>  	if (ret < 0) {
>  		ERR("Failed to retrieve lttng-modules ABI version");
>  		goto error;
> @@ -1459,3 +1467,109 @@ error:
>  	rcu_read_unlock();
>  	return status;
>  }
> +
> +/*
> + * Setup necessary data for kernel tracer action.
> + */
> +LTTNG_HIDDEN
> +int init_kernel_tracer(void)
> +{
> +	int ret;
> +	bool is_root =3D !getuid();
> +
> +	/* Modprobe lttng kernel modules */
> +	ret =3D modprobe_lttng_control();
> +	if (ret < 0) {
> +		goto error;
> +	}
> +
> +	/* Open debugfs lttng */
> +	kernel_tracer_fd =3D open(module_proc_lttng, O_RDWR);
> +	if (kernel_tracer_fd < 0) {
> +		DBG("Failed to open %s", module_proc_lttng);
> +		goto error_open;
> +	}
> +
> +	/* Validate kernel version */
> +	ret =3D kernel_validate_version(&kernel_tracer_version,
> +			&kernel_tracer_abi_version);
> +	if (ret < 0) {
> +		goto error_version;
> +	}
> +
> +	ret =3D modprobe_lttng_data();
> +	if (ret < 0) {
> +		goto error_modules;
> +	}
> +
> +	ret =3D kernel_supports_ring_buffer_snapshot_sample_positions();
> +	if (ret < 0) {
> +		goto error_modules;
> +	}
> +
> +	if (ret < 1) {
> +		WARN("Kernel tracer does not support buffer monitoring. "
> +			"The monitoring timer of channels in the kernel domain "
> +			"will be set to 0 (disabled).");
> +	}
> +
> +	DBG("Kernel tracer fd %d", kernel_tracer_fd);
> +
> +	ret =3D syscall_init_table(kernel_tracer_fd);
> +	if (ret < 0) {
> +		ERR("Unable to populate syscall table. Syscall tracing won't "
> +			"work for this session daemon.");
> +	}
> +	return 0;
> +
> +error_version:
> +	modprobe_remove_lttng_control();
> +	ret =3D close(kernel_tracer_fd);
> +	if (ret) {
> +		PERROR("close");
> +	}
> +	kernel_tracer_fd =3D -1;
> +	return LTTNG_ERR_KERN_VERSION;
> +
> +error_modules:
> +	ret =3D close(kernel_tracer_fd);
> +	if (ret) {
> +		PERROR("close");
> +	}
> +
> +error_open:
> +	modprobe_remove_lttng_control();
> +
> +error:
> +	WARN("No kernel tracer available");
> +	kernel_tracer_fd =3D -1;
> +	if (!is_root) {
> +		return LTTNG_ERR_NEED_ROOT_SESSIOND;
> +	} else {
> +		return LTTNG_ERR_KERN_NA;
> +	}
> +}
> +
> +LTTNG_HIDDEN
> +void cleanup_kernel_tracer(void)
> +{
> +	int ret;
> +
> +	DBG2("Closing kernel fd");
> +	if (kernel_tracer_fd >=3D 0) {
> +		ret =3D close(kernel_tracer_fd);
> +		if (ret) {
> +			PERROR("close");
> +		}
> +		kernel_tracer_fd =3D -1;
> +	}
> +	DBG("Unloading kernel modules");
> +	modprobe_remove_lttng_all();
> +	free(syscall_table);
> +}
> +
> +LTTNG_HIDDEN
> +bool kernel_tracer_is_initialized(void)
> +{
> +	return kernel_tracer_fd >=3D 0;
> +}
> diff --git a/src/bin/lttng-sessiond/kernel.h b/src/bin/lttng-sessiond/ker=
nel.h
> index 9b0c15cd..462f16b4 100644
> --- a/src/bin/lttng-sessiond/kernel.h
> +++ b/src/bin/lttng-sessiond/kernel.h
> @@ -34,7 +34,7 @@
>  =

>  int kernel_add_channel_context(struct ltt_kernel_channel *chan,
>  		struct ltt_kernel_context *ctx);
> -int kernel_create_session(struct ltt_session *session, int tracer_fd);
> +int kernel_create_session(struct ltt_session *session);
>  int kernel_create_channel(struct ltt_kernel_session *session,
>  		struct lttng_channel *chan);
>  int kernel_create_event(struct lttng_event *ev, struct ltt_kernel_channe=
l *channel,
> @@ -52,10 +52,9 @@ int kernel_flush_buffer(struct ltt_kernel_channel *cha=
nnel);
>  int kernel_metadata_flush_buffer(int fd);
>  int kernel_start_session(struct ltt_kernel_session *session);
>  int kernel_stop_session(struct ltt_kernel_session *session);
> -ssize_t kernel_list_events(int tracer_fd, struct lttng_event **event_lis=
t);
> -void kernel_wait_quiescent(int fd);
> -int kernel_validate_version(int tracer_fd,
> -		struct lttng_kernel_tracer_version *kernel_tracer_version,
> +ssize_t kernel_list_events(struct lttng_event **event_list);
> +void kernel_wait_quiescent(void);
> +int kernel_validate_version(struct lttng_kernel_tracer_version *kernel_t=
racer_version,
>  		struct lttng_kernel_tracer_abi_version *kernel_tracer_abi_version);
>  void kernel_destroy_session(struct ltt_kernel_session *ksess);
>  void kernel_destroy_channel(struct ltt_kernel_channel *kchan);
> @@ -68,6 +67,9 @@ enum lttng_error_code kernel_rotate_session(struct ltt_=
session *session);
>  int init_kernel_workarounds(void);
>  ssize_t kernel_list_tracker_pids(struct ltt_kernel_session *session,
>  		int **_pids);
> -int kernel_supports_ring_buffer_snapshot_sample_positions(int tracer_fd);
> +int kernel_supports_ring_buffer_snapshot_sample_positions(void);
> +int init_kernel_tracer(void);
> +void cleanup_kernel_tracer(void);
> +bool kernel_tracer_is_initialized(void);
>  =

>  #endif /* _LTT_KERNEL_CTL_H */
> diff --git a/src/bin/lttng-sessiond/lttng-sessiond.h b/src/bin/lttng-sess=
iond/lttng-sessiond.h
> index d321fced..2647c0e9 100644
> --- a/src/bin/lttng-sessiond/lttng-sessiond.h
> +++ b/src/bin/lttng-sessiond/lttng-sessiond.h
> @@ -71,7 +71,6 @@ extern const char default_home_dir[],
>  	default_global_apps_pipe[];
>  =

>  /* Set in main.c at boot time of the daemon */
> -extern int kernel_tracer_fd;
>  extern struct lttng_kernel_tracer_version kernel_tracer_version;
>  extern struct lttng_kernel_tracer_abi_version kernel_tracer_abi_version;
>  =

> diff --git a/src/bin/lttng-sessiond/lttng-syscall.c b/src/bin/lttng-sessi=
ond/lttng-syscall.c
> index 9a45a8af..50b1133d 100644
> --- a/src/bin/lttng-sessiond/lttng-syscall.c
> +++ b/src/bin/lttng-sessiond/lttng-syscall.c
> @@ -39,7 +39,7 @@ static size_t syscall_table_nb_entry;
>   * Return 0 on success and the syscall table is allocated. On error, a n=
egative
>   * value is returned.
>   */
> -int syscall_init_table(void)
> +int syscall_init_table(int tracer_fd)
>  {
>  	int ret, fd, err;
>  	size_t nbmem;
> @@ -52,7 +52,7 @@ int syscall_init_table(void)
>  =

>  	DBG3("Syscall init system call table");
>  =

> -	fd =3D kernctl_syscall_list(kernel_tracer_fd);
> +	fd =3D kernctl_syscall_list(tracer_fd);
>  	if (fd < 0) {
>  		ret =3D fd;
>  		PERROR("kernelctl syscall list");
> diff --git a/src/bin/lttng-sessiond/lttng-syscall.h b/src/bin/lttng-sessi=
ond/lttng-syscall.h
> index a2708619..50da7cc7 100644
> --- a/src/bin/lttng-sessiond/lttng-syscall.h
> +++ b/src/bin/lttng-sessiond/lttng-syscall.h
> @@ -51,7 +51,7 @@ struct syscall {
>  extern struct syscall *syscall_table;
>  =

>  /* Use to list kernel system calls. */
> -int syscall_init_table(void);
> +int syscall_init_table(int tracer_fd);
>  ssize_t syscall_table_list(struct lttng_event **events);
>  =

>  #endif /* LTTNG_SYSCALL_H */
> diff --git a/src/bin/lttng-sessiond/main.c b/src/bin/lttng-sessiond/main.c
> index 57324820..ad9bb0cb 100644
> --- a/src/bin/lttng-sessiond/main.c
> +++ b/src/bin/lttng-sessiond/main.c
> @@ -61,7 +61,6 @@
>  #include "event.h"
>  #include "kernel.h"
>  #include "kernel-consumer.h"
> -#include "modprobe.h"
>  #include "shm.h"
>  #include "ust-ctl.h"
>  #include "ust-consumer.h"
> @@ -75,7 +74,6 @@
>  #include "notification-thread.h"
>  #include "notification-thread-commands.h"
>  #include "rotation-thread.h"
> -#include "lttng-syscall.h"
>  #include "agent.h"
>  #include "ht-cleanup.h"
>  #include "sessiond-config.h"
> @@ -155,8 +153,6 @@ static int apps_cmd_notify_pipe[2] =3D { -1, -1 };
>   */
>  static struct ust_cmd_queue ust_cmd_queue;
>  =

> -static const char *module_proc_lttng =3D "/proc/lttng";
> -
>  /*
>   * Section name to look for in the daemon configuration file.
>   */
> @@ -339,16 +335,7 @@ static void sessiond_cleanup(void)
>  	buffer_reg_destroy_registries();
>  =

>  	if (is_root && !config.no_kernel) {
> -		DBG2("Closing kernel fd");
> -		if (kernel_tracer_fd >=3D 0) {
> -			ret =3D close(kernel_tracer_fd);
> -			if (ret) {
> -				PERROR("close");
> -			}
> -		}
> -		DBG("Unloading kernel modules");
> -		modprobe_remove_lttng_all();
> -		free(syscall_table);
> +		cleanup_kernel_tracer();
>  	}
>  =

>  	close_consumer_sockets();
> @@ -372,81 +359,6 @@ static void sessiond_cleanup_options(void)
>  	run_as_destroy_worker();
>  }
>  =

> -/*
> - * Setup necessary data for kernel tracer action.
> - */
> -static int init_kernel_tracer(void)
> -{
> -	int ret;
> -
> -	/* Modprobe lttng kernel modules */
> -	ret =3D modprobe_lttng_control();
> -	if (ret < 0) {
> -		goto error;
> -	}
> -
> -	/* Open debugfs lttng */
> -	kernel_tracer_fd =3D open(module_proc_lttng, O_RDWR);
> -	if (kernel_tracer_fd < 0) {
> -		DBG("Failed to open %s", module_proc_lttng);
> -		goto error_open;
> -	}
> -
> -	/* Validate kernel version */
> -	ret =3D kernel_validate_version(kernel_tracer_fd, &kernel_tracer_versio=
n,
> -			&kernel_tracer_abi_version);
> -	if (ret < 0) {
> -		goto error_version;
> -	}
> -
> -	ret =3D modprobe_lttng_data();
> -	if (ret < 0) {
> -		goto error_modules;
> -	}
> -
> -	ret =3D kernel_supports_ring_buffer_snapshot_sample_positions(
> -			kernel_tracer_fd);
> -	if (ret < 0) {
> -		goto error_modules;
> -	}
> -
> -	if (ret < 1) {
> -		WARN("Kernel tracer does not support buffer monitoring. "
> -			"The monitoring timer of channels in the kernel domain "
> -			"will be set to 0 (disabled).");
> -	}
> -
> -	DBG("Kernel tracer fd %d", kernel_tracer_fd);
> -	return 0;
> -
> -error_version:
> -	modprobe_remove_lttng_control();
> -	ret =3D close(kernel_tracer_fd);
> -	if (ret) {
> -		PERROR("close");
> -	}
> -	kernel_tracer_fd =3D -1;
> -	return LTTNG_ERR_KERN_VERSION;
> -
> -error_modules:
> -	ret =3D close(kernel_tracer_fd);
> -	if (ret) {
> -		PERROR("close");
> -	}
> -
> -error_open:
> -	modprobe_remove_lttng_control();
> -
> -error:
> -	WARN("No kernel tracer available");
> -	kernel_tracer_fd =3D -1;
> -	if (!is_root) {
> -		return LTTNG_ERR_NEED_ROOT_SESSIOND;
> -	} else {
> -		return LTTNG_ERR_KERN_NA;
> -	}
> -}
> -
>  static int string_match(const char *str1, const char *str2)
>  {
>  	return (str1 && str2) && !strcmp(str1, str2);
> @@ -1633,14 +1545,6 @@ int main(int argc, char **argv)
>  		/* Setup kernel tracer */
>  		if (!config.no_kernel) {
>  			init_kernel_tracer();
> -			if (kernel_tracer_fd >=3D 0) {
> -				ret =3D syscall_init_table();
> -				if (ret < 0) {
> -					ERR("Unable to populate syscall table. "
> -						"Syscall tracing won't work "
> -						"for this session daemon.");
> -				}
> -			}
>  		}
>  =

>  		/* Set ulimit for open files */
> diff --git a/src/bin/lttng-sessiond/notification-thread-events.c b/src/bi=
n/lttng-sessiond/notification-thread-events.c
> index 052689a0..bdbac0c4 100644
> --- a/src/bin/lttng-sessiond/notification-thread-events.c
> +++ b/src/bin/lttng-sessiond/notification-thread-events.c
> @@ -1860,8 +1860,7 @@ int condition_is_supported(struct lttng_condition *=
condition)
>  		 * buffers. Therefore, we reject triggers that require that
>  		 * mechanism to be available to be evaluated.
>  		 */
> -		ret =3D kernel_supports_ring_buffer_snapshot_sample_positions(
> -				kernel_tracer_fd);
> +		ret =3D kernel_supports_ring_buffer_snapshot_sample_positions();
>  		break;
>  	}
>  	default:
> -- =

> 2.11.0
> =
