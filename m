From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH v2 lttng-tools] Fix: libc internal mutex
 races with run_as
Date: Thu, 17 Sep 2015 12:20:11 +0000 (UTC)
Message-ID: <2060291606.10420.1442492411120.JavaMail.zimbra__11575.8560052656$1442492512$gmane$org@efficios.com>
References: <1442468888-23539-1-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1ZcYAu-0004wB-G1
 for lttng-dev@lists.lttng.org; Thu, 17 Sep 2015 08:20:33 -0400
In-Reply-To: <1442468888-23539-1-git-send-email-mathieu.desnoyers@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Jeremie Galarneau <jgalar@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

I forgot to close the fd on the worker in open cmd, and I don't like that
killall does not get my argv[0] update trick. Update to come soon.

Thanks,

Mathieu

----- On Sep 17, 2015, at 1:48 AM, Mathieu Desnoyers mathieu.desnoyers@efficios.com wrote:

> Implement a proper run_as worker process scheme to fix internal libc
> mutex races. Those races lead to having the internal mutex held by
> another process when clone() is called, thus hanging the clone child.
> 
> Now that we create the worker process when the parent process is
> still single-threaded, we don't run into those issues. Implement a
> standard fork + file descriptor passing over unnamed unix sockets rather
> than the prior clone + shared file descriptor table, which was causing
> issues with valgrind.
> 
> This adds a new process called "lttng-runas" for each sessiond
> and consumerd process.
> 
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> ---
> src/bin/lttng-consumerd/lttng-consumerd.c |   4 +
> src/bin/lttng-sessiond/main.c             |   7 +
> src/common/Makefile.am                    |   4 +-
> src/common/consumer.c                     |   2 +
> src/common/hashtable/rculfhash.c          |   8 -
> src/common/runas.c                        | 527 ++++++++++++++++++++----------
> src/common/runas.h                        |  15 +-
> src/common/sessiond-comm/Makefile.am      |   2 +-
> src/common/sessiond-comm/unix.c           |  10 +
> src/common/sessiond-comm/unix.h           |   1 +
> 10 files changed, 396 insertions(+), 184 deletions(-)
> 
> diff --git a/src/bin/lttng-consumerd/lttng-consumerd.c
> b/src/bin/lttng-consumerd/lttng-consumerd.c
> index 0d34fee..7ecbe7a 100644
> --- a/src/bin/lttng-consumerd/lttng-consumerd.c
> +++ b/src/bin/lttng-consumerd/lttng-consumerd.c
> @@ -422,6 +422,10 @@ int main(int argc, char **argv)
> 		set_ulimit();
> 	}
> 
> +	if (run_as_create_worker(argv[0]) < 0) {
> +		goto exit_init_data;
> +	}
> +
> 	/* create the consumer instance with and assign the callbacks */
> 	ctx = lttng_consumer_create(opt_type, lttng_consumer_read_subbuffer,
> 		NULL, lttng_consumer_on_recv_stream, NULL);
> diff --git a/src/bin/lttng-sessiond/main.c b/src/bin/lttng-sessiond/main.c
> index 13bd649..5d098d7 100644
> --- a/src/bin/lttng-sessiond/main.c
> +++ b/src/bin/lttng-sessiond/main.c
> @@ -801,6 +801,8 @@ static void sessiond_cleanup_options(void)
> 	free(kmod_probes_list);
> 	free(kmod_extra_probes_list);
> 
> +	run_as_destroy_worker();
> +
> 	/* <fun> */
> 	DBG("%c[%d;%dm*** assert failed :-) *** ==> %c[%dm%c[%d;%dm"
> 			"Matthew, BEET driven development works!%c[%dm",
> @@ -5510,6 +5512,10 @@ int main(int argc, char **argv)
> 		}
> 	}
> 
> +	if (run_as_create_worker(argv[0]) < 0) {
> +		goto exit_create_run_as_worker_cleanup;
> +	}
> +
> 	/*
> 	 * Starting from here, we can create threads. This needs to be after
> 	 * lttng_daemonize due to RCU.
> @@ -6127,6 +6133,7 @@ exit_ht_cleanup_quit_pipe:
> 
> 	health_app_destroy(health_sessiond);
> exit_health_sessiond_cleanup:
> +exit_create_run_as_worker_cleanup:
> 
> exit_options:
> 	sessiond_cleanup_options();
> diff --git a/src/common/Makefile.am b/src/common/Makefile.am
> index 97d0ecc..64110e6 100644
> --- a/src/common/Makefile.am
> +++ b/src/common/Makefile.am
> @@ -18,7 +18,9 @@ libcommon_la_SOURCES = error.h error.c utils.c utils.h runas.c
> runas.h \
>                        common.h futex.c futex.h uri.c uri.h defaults.c \
>                        pipe.c pipe.h readwrite.c readwrite.h \
>                        mi-lttng.h mi-lttng.c \
> -                       daemonize.c daemonize.h
> +                       daemonize.c daemonize.h \
> +                       sessiond-comm/unix.c sessiond-comm/unix.h
> +
> libcommon_la_LIBADD = \
> 		-luuid \
> 		-lrt \
> diff --git a/src/common/consumer.c b/src/common/consumer.c
> index c8628e8..31846f1 100644
> --- a/src/common/consumer.c
> +++ b/src/common/consumer.c
> @@ -1212,6 +1212,8 @@ void lttng_consumer_cleanup(void)
> 	 * it.
> 	 */
> 	lttng_ht_destroy(consumer_data.stream_list_ht);
> +
> +	run_as_destroy_worker();
> }
> 
> /*
> diff --git a/src/common/hashtable/rculfhash.c b/src/common/hashtable/rculfhash.c
> index fb44640..9baf407 100644
> --- a/src/common/hashtable/rculfhash.c
> +++ b/src/common/hashtable/rculfhash.c
> @@ -281,14 +281,6 @@
> #include <common/common.h>
> 
> /*
> - * We need to lock pthread exit, which deadlocks __nptl_setxid in the runas
> - * clone.  This work-around will be allowed to be removed when runas.c gets
> - * changed to do an exec() before issuing seteuid/setegid. See
> - * http://sourceware.org/bugzilla/show_bug.cgi?id=10184 for details.
> - */
> -pthread_mutex_t lttng_libc_state_lock = PTHREAD_MUTEX_INITIALIZER;
> -
> -/*
>  * Split-counters lazily update the global counter each 1024
>  * addition/removal. It automatically keeps track of resize required.
>  * We use the bucket length as indicator for need to expand for small
> diff --git a/src/common/runas.c b/src/common/runas.c
> index 8dda209..8aa87ce 100644
> --- a/src/common/runas.c
> +++ b/src/common/runas.c
> @@ -33,58 +33,51 @@
> 
> #include <common/common.h>
> #include <common/utils.h>
> -#include <common/compat/mman.h>
> -#include <common/compat/clone.h>
> #include <common/compat/getenv.h>
> +#include <common/sessiond-comm/unix.h>
> 
> #include "runas.h"
> 
> -#define RUNAS_CHILD_STACK_SIZE	10485760
> -
> -#ifndef MAP_STACK
> -#define MAP_STACK		0
> -#endif
> -
> -#ifdef __FreeBSD__
> -/* FreeBSD MAP_STACK always return -ENOMEM */
> -#define LTTNG_MAP_STACK		0
> -#else
> -#define LTTNG_MAP_STACK		MAP_STACK
> -#endif
> -
> -#ifndef MAP_GROWSDOWN
> -#define MAP_GROWSDOWN		0
> -#endif
> -
> -#ifndef MAP_ANONYMOUS
> -#define MAP_ANONYMOUS		MAP_ANON
> -#endif
> -
> -struct run_as_data {
> -	int (*cmd)(void *data);
> -	void *data;
> -	uid_t uid;
> -	gid_t gid;
> -	int retval_pipe;
> -};
> +struct run_as_data;
> +typedef int (*run_as_fct)(struct run_as_data *data);
> 
> struct run_as_mkdir_data {
> -	const char *path;
> +	char path[PATH_MAX];
> 	mode_t mode;
> };
> 
> struct run_as_open_data {
> -	const char *path;
> +	char path[PATH_MAX];
> 	int flags;
> 	mode_t mode;
> };
> 
> struct run_as_unlink_data {
> -	const char *path;
> +	char path[PATH_MAX];
> };
> 
> -struct run_as_recursive_rmdir_data {
> -	const char *path;
> +struct run_as_rmdir_recursive_data {
> +	char path[PATH_MAX];
> +};
> +
> +enum run_as_cmd {
> +	RUN_AS_MKDIR,
> +	RUN_AS_OPEN,
> +	RUN_AS_UNLINK,
> +	RUN_AS_RMDIR_RECURSIVE,
> +	RUN_AS_MKDIR_RECURSIVE,
> +};
> +
> +struct run_as_data {
> +	enum run_as_cmd cmd;
> +	union {
> +		struct run_as_mkdir_data mkdir;
> +		struct run_as_open_data open;
> +		struct run_as_unlink_data unlink;
> +		struct run_as_rmdir_recursive_data rmdir_recursive;
> +	} u;
> +	uid_t uid;
> +	gid_t gid;
> };
> 
> struct run_as_ret {
> @@ -92,6 +85,17 @@ struct run_as_ret {
> 	int _errno;
> };
> 
> +struct run_as_worker {
> +	pid_t pid;	/* Worker PID. */
> +	int sockpair[2];
> +	char *procname;
> +};
> +
> +/* Single global worker per process (for now). */
> +static struct run_as_worker *global_worker;
> +/* Lock protecting the worker. */
> +static pthread_mutex_t worker_lock = PTHREAD_MUTEX_INITIALIZER;
> +
> #ifdef VALGRIND
> static
> int use_clone(void)
> @@ -113,75 +117,141 @@ int _utils_mkdir_recursive_unsafe(const char *path,
> mode_t mode);
>  * Create recursively directory using the FULL path.
>  */
> static
> -int _mkdir_recursive(void *_data)
> +int _mkdir_recursive(struct run_as_data *data)
> {
> -	struct run_as_mkdir_data *data = _data;
> 	const char *path;
> 	mode_t mode;
> 
> -	path = data->path;
> -	mode = data->mode;
> +	path = data->u.mkdir.path;
> +	mode = data->u.mkdir.mode;
> 
> 	/* Safe to call as we have transitioned to the requested uid/gid. */
> 	return _utils_mkdir_recursive_unsafe(path, mode);
> }
> 
> static
> -int _mkdir(void *_data)
> +int _mkdir(struct run_as_data *data)
> {
> -	struct run_as_mkdir_data *data = _data;
> +	return mkdir(data->u.mkdir.path, data->u.mkdir.mode);
> +}
> 
> -	return mkdir(data->path, data->mode);
> +static
> +int _open(struct run_as_data *data)
> +{
> +	return open(data->u.open.path, data->u.open.flags, data->u.open.mode);
> }
> 
> static
> -int _open(void *_data)
> +int _unlink(struct run_as_data *data)
> {
> -	struct run_as_open_data *data = _data;
> +	return unlink(data->u.unlink.path);
> +}
> 
> -	return open(data->path, data->flags, data->mode);
> +static
> +int _rmdir_recursive(struct run_as_data *data)
> +{
> +	return utils_recursive_rmdir(data->u.rmdir_recursive.path);
> }
> 
> static
> -int _unlink(void *_data)
> +run_as_fct run_as_enum_to_fct(enum run_as_cmd cmd)
> {
> -	struct run_as_unlink_data *data = _data;
> +	switch (cmd) {
> +	case RUN_AS_MKDIR:
> +		return _mkdir;
> +	case RUN_AS_OPEN:
> +		return _open;
> +	case RUN_AS_UNLINK:
> +		return _unlink;
> +	case RUN_AS_RMDIR_RECURSIVE:
> +		return _rmdir_recursive;
> +	case RUN_AS_MKDIR_RECURSIVE:
> +		return _mkdir_recursive;
> +	default:
> +		ERR("Unknown command %d", (int) cmd)
> +		return NULL;
> +	}
> +}
> 
> -	return unlink(data->path);
> +static
> +int do_send_fd(struct run_as_worker *worker,
> +		enum run_as_cmd cmd, int fd)
> +{
> +	ssize_t len;
> +
> +	switch (cmd) {
> +	case RUN_AS_OPEN:
> +		break;
> +	default:
> +		return 0;
> +	}
> +	len = lttcomm_send_fds_unix_sock(worker->sockpair[1], &fd, 1);
> +	if (len < 0) {
> +		PERROR("lttcomm_send_fds_unix_sock");
> +		return -1;
> +	}
> +	return 0;
> }
> 
> static
> -int _recursive_rmdir(void *_data)
> +int do_recv_fd(struct run_as_worker *worker,
> +		enum run_as_cmd cmd, int *fd)
> {
> -	struct run_as_recursive_rmdir_data *data = _data;
> +	ssize_t len;
> 
> -	return utils_recursive_rmdir(data->path);
> +	switch (cmd) {
> +	case RUN_AS_OPEN:
> +		break;
> +	default:
> +		return 0;
> +	}
> +	len = lttcomm_recv_fds_unix_sock(worker->sockpair[0], fd, 1);
> +	if (len < 0) {
> +		PERROR("lttcomm_recv_fds_unix_sock");
> +		return -1;
> +	}
> +	return 0;
> }
> 
> +/*
> + * Return < 0 on error, 0 if OK, 1 on hangup.
> + */
> static
> -int child_run_as(void *_data)
> +int handle_one_cmd(struct run_as_worker *worker)
> {
> 	int ret;
> -	struct run_as_data *data = _data;
> -	ssize_t writelen;
> +	struct run_as_data data;
> +	ssize_t readlen, writelen;
> 	struct run_as_ret sendret;
> +	run_as_fct cmd;
> +	uid_t prev_euid;
> +
> +	/* Read data */
> +	readlen = lttcomm_recv_unix_sock(worker->sockpair[1], &data, sizeof(data));
> +	if (readlen == 0) {
> +		/* hang up */
> +		return 1;
> +	}
> +	if (readlen < sizeof(data)) {
> +		PERROR("lttcomm_recv_unix_sock error");
> +		return -1;
> +	}
> 
> -	/*
> -	 * Child: it is safe to drop egid and euid while sharing the
> -	 * file descriptors with the parent process, since we do not
> -	 * drop "uid": therefore, the user we are dropping egid/euid to
> -	 * cannot attach to this process with, e.g. ptrace, nor map this
> -	 * process memory.
> -	 */
> -	if (data->gid != getegid()) {
> -		ret = setegid(data->gid);
> +	cmd = run_as_enum_to_fct(data.cmd);
> +	if (!cmd) {
> +		return -1;
> +	}
> +
> +	if (data.gid != getegid()) {
> +		ret = setegid(data.gid);
> 		if (ret < 0) {
> 			PERROR("setegid");
> 			goto write_return;
> 		}
> 	}
> -	if (data->uid != geteuid()) {
> -		ret = seteuid(data->uid);
> +	prev_euid = getuid();
> +	if (data.uid != prev_euid) {
> +		ret = seteuid(data.uid);
> 		if (ret < 0) {
> 			PERROR("seteuid");
> 			goto write_return;
> @@ -191,33 +261,77 @@ int child_run_as(void *_data)
> 	 * Also set umask to 0 for mkdir executable bit.
> 	 */
> 	umask(0);
> -	ret = (*data->cmd)(data->data);
> +	ret = (*cmd)(&data);
> 
> write_return:
> 	sendret.ret = ret;
> 	sendret._errno = errno;
> 	/* send back return value */
> -	writelen = lttng_write(data->retval_pipe, &sendret, sizeof(sendret));
> +	writelen = lttcomm_send_unix_sock(worker->sockpair[1], &sendret,
> sizeof(sendret));
> 	if (writelen < sizeof(sendret)) {
> -		PERROR("lttng_write error");
> +		PERROR("lttcomm_send_unix_sock error");
> +		return -1;
> +	}
> +	ret = do_send_fd(worker, data.cmd, ret);
> +	if (ret) {
> +		PERROR("do_send_fd error");
> +		return -1;
> +	}
> +	if (seteuid(prev_euid) < 0) {
> +		PERROR("seteuid");
> +		return -1;
> +	}
> +	return 0;
> +}
> +
> +static
> +int run_as_worker(struct run_as_worker *worker)
> +{
> +	ssize_t writelen;
> +	struct run_as_ret sendret;
> +	size_t proc_orig_len;
> +
> +	/*
> +	 * Initialize worker. Set a different process cmdline.
> +	 */
> +	proc_orig_len = strlen(worker->procname);
> +	memset(worker->procname, 0, proc_orig_len);
> +	strncpy(worker->procname, "lttng-runas", proc_orig_len);
> +
> +	sendret.ret = 0;
> +	sendret._errno = 0;
> +	writelen = lttcomm_send_unix_sock(worker->sockpair[1], &sendret,
> +			sizeof(sendret));
> +	if (writelen < sizeof(sendret)) {
> +		PERROR("lttcomm_send_unix_sock error");
> 		return EXIT_FAILURE;
> -	} else {
> -		return EXIT_SUCCESS;
> 	}
> +
> +	for (;;) {
> +		int ret;
> +
> +		ret = handle_one_cmd(worker);
> +		if (ret < 0) {
> +			return EXIT_FAILURE;
> +		} else if (ret > 0) {
> +			break;
> +		} else {
> +			continue;	/* Next command. */
> +		}
> +	}
> +	return EXIT_SUCCESS;
> }
> 
> static
> -int run_as_clone(int (*cmd)(void *data), void *data, uid_t uid, gid_t gid)
> +int run_as_cmd(struct run_as_worker *worker,
> +		enum run_as_cmd cmd,
> +		struct run_as_data *data,
> +		uid_t uid, gid_t gid)
> {
> -	struct run_as_data run_as_data;
> -	int ret = 0;
> -	ssize_t readlen;
> -	int status;
> -	pid_t pid;
> -	int retval_pipe[2];
> -	void *child_stack;
> +	ssize_t readlen, writelen;
> 	struct run_as_ret recvret;
> 
> +	pthread_mutex_lock(&worker_lock);
> 	/*
> 	 * If we are non-root, we can only deal with our own uid.
> 	 */
> @@ -231,78 +345,32 @@ int run_as_clone(int (*cmd)(void *data), void *data, uid_t
> uid, gid_t gid)
> 		}
> 	}
> 
> -	ret = pipe(retval_pipe);
> -	if (ret < 0) {
> +	data->cmd = cmd;
> +	data->uid = uid;
> +	data->gid = gid;
> +
> +	writelen = lttcomm_send_unix_sock(worker->sockpair[0], data, sizeof(*data));
> +	if (writelen < sizeof(*data)) {
> +		PERROR("Error writing message to run_as");
> 		recvret.ret = -1;
> 		recvret._errno = errno;
> -		PERROR("pipe");
> 		goto end;
> 	}
> -	run_as_data.data = data;
> -	run_as_data.cmd = cmd;
> -	run_as_data.uid = uid;
> -	run_as_data.gid = gid;
> -	run_as_data.retval_pipe = retval_pipe[1];	/* write end */
> -	child_stack = mmap(NULL, RUNAS_CHILD_STACK_SIZE,
> -		PROT_WRITE | PROT_READ,
> -		MAP_PRIVATE | MAP_GROWSDOWN | MAP_ANONYMOUS | LTTNG_MAP_STACK,
> -		-1, 0);
> -	if (child_stack == MAP_FAILED) {
> -		recvret.ret = -1;
> -		recvret._errno = ENOMEM;
> -		PERROR("mmap");
> -		goto close_pipe;
> -	}
> -	/*
> -	 * Pointing to the middle of the stack to support architectures
> -	 * where the stack grows up (HPPA).
> -	 */
> -	pid = lttng_clone_files(child_run_as, child_stack + (RUNAS_CHILD_STACK_SIZE /
> 2),
> -		&run_as_data);
> -	if (pid < 0) {
> -		recvret.ret = -1;
> -		recvret._errno = errno;
> -		PERROR("clone");
> -		goto unmap_stack;
> -	}
> +
> 	/* receive return value */
> -	readlen = lttng_read(retval_pipe[0], &recvret, sizeof(recvret));
> +	readlen = lttcomm_recv_unix_sock(worker->sockpair[0], &recvret,
> sizeof(recvret));
> 	if (readlen < sizeof(recvret)) {
> +		PERROR("Error reading response from run_as");
> 		recvret.ret = -1;
> 		recvret._errno = errno;
> 	}
> -
> -	/*
> -	 * Parent: wait for child to return, in which case the
> -	 * shared memory map will have been created.
> -	 */
> -	pid = waitpid(pid, &status, 0);
> -	if (pid < 0 || !WIFEXITED(status) || WEXITSTATUS(status) != 0) {
> +	if (do_recv_fd(worker, cmd, &recvret.ret)) {
> 		recvret.ret = -1;
> -		recvret._errno = errno;
> -		PERROR("wait");
> -	}
> -unmap_stack:
> -	ret = munmap(child_stack, RUNAS_CHILD_STACK_SIZE);
> -	if (ret < 0) {
> -		recvret.ret = -1;
> -		recvret._errno = errno;
> -		PERROR("munmap");
> -	}
> -close_pipe:
> -	ret = close(retval_pipe[0]);
> -	if (ret) {
> -		recvret.ret = -1;
> -		recvret._errno = errno;
> -		PERROR("close");
> -	}
> -	ret = close(retval_pipe[1]);
> -	if (ret) {
> -		recvret.ret = -1;
> -		recvret._errno = errno;
> -		PERROR("close");
> +		recvret._errno = -EIO;
> 	}
> +
> end:
> +	pthread_mutex_unlock(&worker_lock);
> 	errno = recvret._errno;
> 	return recvret.ret;
> }
> @@ -313,13 +381,20 @@ end:
>  * considered secure.
>  */
> static
> -int run_as_noclone(int (*cmd)(void *data), void *data, uid_t uid, gid_t gid)
> +int run_as_noclone(enum run_as_cmd cmd,
> +		struct run_as_data *data, uid_t uid, gid_t gid)
> {
> 	int ret, saved_errno;
> 	mode_t old_mask;
> +	run_as_fct fct;
> 
> +	fct = run_as_enum_to_fct(cmd);
> +	if (!fct) {
> +		errno = -ENOSYS;
> +		return -1;
> +	}
> 	old_mask = umask(0);
> -	ret = cmd(data);
> +	ret = fct(data);
> 	saved_errno = errno;
> 	umask(old_mask);
> 	errno = saved_errno;
> @@ -328,18 +403,18 @@ int run_as_noclone(int (*cmd)(void *data), void *data,
> uid_t uid, gid_t gid)
> }
> 
> static
> -int run_as(int (*cmd)(void *data), void *data, uid_t uid, gid_t gid)
> +int run_as(struct run_as_worker *worker,
> +		enum run_as_cmd cmd,
> +		struct run_as_data *data, uid_t uid, gid_t gid)
> {
> -	if (use_clone()) {
> +	if (worker) {
> 		int ret;
> 
> -		DBG("Using run_as_clone");
> -		pthread_mutex_lock(&lttng_libc_state_lock);
> -		ret = run_as_clone(cmd, data, uid, gid);
> -		pthread_mutex_unlock(&lttng_libc_state_lock);
> +		DBG("Using run_as worker");
> +		ret = run_as_cmd(worker, cmd, data, uid, gid);
> 		return ret;
> 	} else {
> -		DBG("Using run_as_noclone");
> +		DBG("Using run_as without worker");
> 		return run_as_noclone(cmd, data, uid, gid);
> 	}
> }
> @@ -347,25 +422,29 @@ int run_as(int (*cmd)(void *data), void *data, uid_t uid,
> gid_t gid)
> LTTNG_HIDDEN
> int run_as_mkdir_recursive(const char *path, mode_t mode, uid_t uid, gid_t gid)
> {
> -	struct run_as_mkdir_data data;
> +	struct run_as_worker *worker = global_worker;
> +	struct run_as_data data;
> 
> 	DBG3("mkdir() recursive %s with mode %d for uid %d and gid %d",
> 			path, mode, uid, gid);
> -	data.path = path;
> -	data.mode = mode;
> -	return run_as(_mkdir_recursive, &data, uid, gid);
> +	strncpy(data.u.mkdir.path, path, PATH_MAX - 1);
> +	data.u.mkdir.path[PATH_MAX - 1] = '\0';
> +	data.u.mkdir.mode = mode;
> +	return run_as(worker, RUN_AS_MKDIR_RECURSIVE, &data, uid, gid);
> }
> 
> LTTNG_HIDDEN
> int run_as_mkdir(const char *path, mode_t mode, uid_t uid, gid_t gid)
> {
> -	struct run_as_mkdir_data data;
> +	struct run_as_worker *worker = global_worker;
> +	struct run_as_data data;
> 
> 	DBG3("mkdir() %s with mode %d for uid %d and gid %d",
> 			path, mode, uid, gid);
> -	data.path = path;
> -	data.mode = mode;
> -	return run_as(_mkdir, &data, uid, gid);
> +	strncpy(data.u.mkdir.path, path, PATH_MAX - 1);
> +	data.u.mkdir.path[PATH_MAX - 1] = '\0';
> +	data.u.mkdir.mode = mode;
> +	return run_as(worker, RUN_AS_MKDIR, &data, uid, gid);
> }
> 
> /*
> @@ -375,34 +454,146 @@ int run_as_mkdir(const char *path, mode_t mode, uid_t
> uid, gid_t gid)
> LTTNG_HIDDEN
> int run_as_open(const char *path, int flags, mode_t mode, uid_t uid, gid_t gid)
> {
> -	struct run_as_open_data data;
> +	struct run_as_worker *worker = global_worker;
> +	struct run_as_data data;
> 
> 	DBG3("open() %s with flags %X mode %d for uid %d and gid %d",
> 			path, flags, mode, uid, gid);
> -	data.path = path;
> -	data.flags = flags;
> -	data.mode = mode;
> -	return run_as(_open, &data, uid, gid);
> +	strncpy(data.u.open.path, path, PATH_MAX - 1);
> +	data.u.open.path[PATH_MAX - 1] = '\0';
> +	data.u.open.flags = flags;
> +	data.u.open.mode = mode;
> +	return run_as(worker, RUN_AS_OPEN, &data, uid, gid);
> }
> 
> LTTNG_HIDDEN
> int run_as_unlink(const char *path, uid_t uid, gid_t gid)
> {
> -	struct run_as_unlink_data data;
> +	struct run_as_worker *worker = global_worker;
> +	struct run_as_data data;
> 
> 	DBG3("unlink() %s with for uid %d and gid %d",
> 			path, uid, gid);
> -	data.path = path;
> -	return run_as(_unlink, &data, uid, gid);
> +	strncpy(data.u.unlink.path, path, PATH_MAX - 1);
> +	data.u.unlink.path[PATH_MAX - 1] = '\0';
> +	return run_as(worker, RUN_AS_UNLINK, &data, uid, gid);
> }
> 
> LTTNG_HIDDEN
> -int run_as_recursive_rmdir(const char *path, uid_t uid, gid_t gid)
> +int run_as_rmdir_recursive(const char *path, uid_t uid, gid_t gid)
> {
> -	struct run_as_recursive_rmdir_data data;
> +	struct run_as_worker *worker = global_worker;
> +	struct run_as_data data;
> 
> -	DBG3("recursive_rmdir() %s with for uid %d and gid %d",
> +	DBG3("rmdir_recursive() %s with for uid %d and gid %d",
> 			path, uid, gid);
> -	data.path = path;
> -	return run_as(_recursive_rmdir, &data, uid, gid);
> +	strncpy(data.u.rmdir_recursive.path, path, PATH_MAX - 1);
> +	data.u.rmdir_recursive.path[PATH_MAX - 1] = '\0';
> +	return run_as(worker, RUN_AS_RMDIR_RECURSIVE, &data, uid, gid);
> +}
> +
> +int run_as_create_worker(char *procname)
> +{
> +	struct run_as_worker *worker;
> +	pid_t pid;
> +	ssize_t readlen;
> +	struct run_as_ret recvret;
> +	int i;
> +
> +	if (!use_clone()) {
> +		return 0;
> +	}
> +	worker = zmalloc(sizeof(*worker));
> +	if (!worker) {
> +		return -1;
> +	}
> +	worker->procname = procname;
> +	/* Create unix socket. */
> +	if (lttcomm_create_anon_unix_socketpair(worker->sockpair) < 0) {
> +		goto error_sock;
> +	}
> +	/* Fork worker. */
> +	pid = fork();
> +	if (pid < 0) {
> +		PERROR("fork");
> +		goto error_fork;
> +	} else if (pid == 0) {
> +		int ret;
> +
> +		/* Child */
> +
> +		/* Just close, no shutdown. */
> +		if (close(worker->sockpair[0])) {
> +			PERROR("close");
> +			exit(EXIT_FAILURE);
> +		}
> +		worker->sockpair[0] = -1;
> +		ret = run_as_worker(worker);
> +		if (lttcomm_close_unix_sock(worker->sockpair[1])) {
> +			PERROR("close");
> +			ret = -1;
> +		}
> +		worker->sockpair[1] = -1;
> +		if (ret) {
> +			exit(EXIT_FAILURE);
> +		} else {
> +			exit(EXIT_SUCCESS);
> +		}
> +	} else {
> +		/* Parent */
> +
> +		/* Just close, no shutdown. */
> +		if (close(worker->sockpair[1])) {
> +			PERROR("close");
> +		}
> +		worker->sockpair[1] = -1;
> +		worker->pid = pid;
> +		/* Wait for worker to become ready. */
> +		readlen = lttcomm_recv_unix_sock(worker->sockpair[0], &recvret,
> sizeof(recvret));
> +		if (readlen < sizeof(recvret)) {
> +			ERR("readlen: %zd", readlen);
> +			PERROR("Error reading response from run_as at creation");
> +			goto error_fork;
> +		}
> +		global_worker = worker;
> +	}
> +	return 0;
> +
> +	/* Error handling. */
> +error_fork:
> +	for (i = 0; i < 2; i++) {
> +		if (worker->sockpair[i] < 0) {
> +			continue;
> +		}
> +		if (lttcomm_close_unix_sock(worker->sockpair[i])) {
> +			PERROR("close");
> +		}
> +		worker->sockpair[i] = -1;
> +	}
> +error_sock:
> +	free(worker);
> +	return -1;
> +}
> +
> +void run_as_destroy_worker(void)
> +{
> +	struct run_as_worker *worker = global_worker;
> +	int status;
> +	pid_t pid;
> +
> +	if (!worker) {
> +		return;
> +	}
> +	/* Close unix socket */
> +	if (lttcomm_close_unix_sock(worker->sockpair[0])) {
> +		PERROR("close");
> +	}
> +	worker->sockpair[0] = -1;
> +	/* Wait for worker. */
> +	pid = waitpid(worker->pid, &status, 0);
> +	if (pid < 0 || !WIFEXITED(status) || WEXITSTATUS(status) != 0) {
> +		PERROR("wait");
> +	}
> +	free(worker);
> +	global_worker = NULL;
> }
> diff --git a/src/common/runas.h b/src/common/runas.h
> index dc25322..e1269a4 100644
> --- a/src/common/runas.h
> +++ b/src/common/runas.h
> @@ -26,12 +26,15 @@ int run_as_mkdir_recursive(const char *path, mode_t mode,
> uid_t uid, gid_t gid);
> int run_as_mkdir(const char *path, mode_t mode, uid_t uid, gid_t gid);
> int run_as_open(const char *path, int flags, mode_t mode, uid_t uid, gid_t gid);
> int run_as_unlink(const char *path, uid_t uid, gid_t gid);
> -int run_as_recursive_rmdir(const char *path, uid_t uid, gid_t gid);
> +int run_as_rmdir_recursive(const char *path, uid_t uid, gid_t gid);
> 
> -/*
> - * We need to lock pthread exit, which deadlocks __nptl_setxid in the
> - * clone.
> - */
> -extern pthread_mutex_t lttng_libc_state_lock;
> +/* Backward compat. */
> +static inline int run_as_recursive_rmdir(const char *path, uid_t uid, gid_t
> gid)
> +{
> +	return run_as_rmdir_recursive(path, uid, gid);
> +}
> +
> +int run_as_create_worker(char *procname);
> +void run_as_destroy_worker(void);
> 
> #endif /* _RUNAS_H */
> diff --git a/src/common/sessiond-comm/Makefile.am
> b/src/common/sessiond-comm/Makefile.am
> index fdffa40..32ec058 100644
> --- a/src/common/sessiond-comm/Makefile.am
> +++ b/src/common/sessiond-comm/Makefile.am
> @@ -4,6 +4,6 @@ AM_CPPFLAGS = -I$(top_srcdir)/include -I$(top_srcdir)/src
> noinst_LTLIBRARIES = libsessiond-comm.la
> 
> libsessiond_comm_la_SOURCES = sessiond-comm.c sessiond-comm.h \
> -                              unix.c unix.h inet.c inet.h inet6.c inet6.h \
> +                              inet.c inet.h inet6.c inet6.h \
>                               relayd.h agent.h
> libsessiond_comm_la_LIBADD = -lrt
> diff --git a/src/common/sessiond-comm/unix.c b/src/common/sessiond-comm/unix.c
> index a66bb75..4b64161 100644
> --- a/src/common/sessiond-comm/unix.c
> +++ b/src/common/sessiond-comm/unix.c
> @@ -93,6 +93,16 @@ int lttcomm_accept_unix_sock(int sock)
> 	return new_fd;
> }
> 
> +LTTNG_HIDDEN
> +int lttcomm_create_anon_unix_socketpair(int *fds)
> +{
> +	if (socketpair(PF_UNIX, SOCK_STREAM, 0, fds) < 0) {
> +		PERROR("socketpair");
> +		return -1;
> +	}
> +	return 0;
> +}
> +
> /*
>  * Creates a AF_UNIX local socket using pathname bind the socket upon creation
>  * and return the fd.
> diff --git a/src/common/sessiond-comm/unix.h b/src/common/sessiond-comm/unix.h
> index 19b91ce..6859cba 100644
> --- a/src/common/sessiond-comm/unix.h
> +++ b/src/common/sessiond-comm/unix.h
> @@ -27,6 +27,7 @@
> #include "sessiond-comm.h"
> 
> extern int lttcomm_create_unix_sock(const char *pathname);
> +extern int lttcomm_create_anon_unix_socketpair(int *fds);
> extern int lttcomm_connect_unix_sock(const char *pathname);
> extern int lttcomm_accept_unix_sock(int sock);
> extern int lttcomm_listen_unix_sock(int sock);
> --
> 2.1.4

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
