From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: UST assert due to file descriptors being closed
	by	applications
Date: Tue, 4 Oct 2016 16:31:23 +0000 (UTC)
Message-ID: <1441427648.45668.1475598683490.JavaMail.zimbra__10162.0188019753$1475598668$gmane$org@efficios.com>
References: <CACd+_b5br_uqwWMP-ZdHxr2ajKuqrMmWrYdT+z7ea58hFDm1_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6312283813632670883=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 4DC6AA444C
 for <lttng-dev@lists.lttng.org>; Tue,  4 Oct 2016 16:31:54 +0000 (UTC)
In-Reply-To: <CACd+_b5br_uqwWMP-ZdHxr2ajKuqrMmWrYdT+z7ea58hFDm1_Q@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Aravind HT <aravind.ht@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============6312283813632670883==
Content-Type: multipart/alternative;
	boundary="=_482f6520-266f-41aa-8fb0-b1afe0da51f8"

--=_482f6520-266f-41aa-8fb0-b1afe0da51f8
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

----- On Sep 2, 2016, at 9:35 AM, Aravind HT <aravind.ht@gmail.com> wrote: 

> Hi,
> This is with respect to the following bugs caused by applications doing bulk
> close() of file descriptors soon after forking.
> [ https://bugs.lttng.org/issues/253 | https://bugs.lttng.org/issues/253 ]
> [ https://bugs.lttng.org/issues/626 | https://bugs.lttng.org/issues/626 ]

> I am using LTTNG UST 2.6.0 and am forwarding a fix that I am trying out in the
> form of an LTTNG UST API int lttng_ust_safe_close_fd(int fd) , that can be
> called by apps instead of the close(). The solution that was being considered,
> going by the discussion on the above bugs was to see if close() can be
> LD_PRELOADED and that had a few complexities. For the meantime, the new LTTNG
> UST API being proposed here can be used.

> Please review. Due to time constraints, I am not able provide a patch on the
> latest version of UST, but think this can be done with reasonably low effort as
> nothing major seems to have changed.

Hi Aravind, 

Thanks for the patch. Indeed tracking the file descriptors used by lttng-ust 
with a bitfield makes tons of sense. I however decided to take a slightly 
different approach. Rather than exposing a lttng-ust specific API, I 
implemented a helper library which overrides close and closeall. Also, 
locking had to be revisited. Here is the resulting string of commits: 

commit 95e6d2685eec83a144f533a447ffd355fadf9d79 
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com> 
Date: Mon Sep 12 12:04:13 2016 -0400 

Implement liblttng-ust-fd 

This library overrides close() and closeall() libc functions, and uses 
lttng_ust_safe_close_fd() to check whether the application can 
interact with the file descriptor or if it should be left to lttng-ust. 

This takes care of bugs caused by applications doing bulk close() or 
closefrom() of file descriptors soon after forking. 

Fixes: #253 
Fixes: #626 

CC: Aravind HT <aravind.ht@gmail.com> 
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com> 

commit 6548fca464f68be5ded73be6b9a479daf08e62d6 
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com> 
Date: Tue Sep 13 16:17:40 2016 -0400 

Introduce file descriptor tracker 

Introduce a tracker for file descriptors used by lttng-ust. It exposes 
a new API in an internal header lttng_ust_safe_close_fd(), which is 
meant to be used by a LD_PRELOADed library overriding close() and 
closefrom() (BSD). 

This takes care of bugs caused by applications doing bulk close() or 
closefrom() of file descriptors soon after forking. 

We need to hold the ust_lock() to protect the fd tracker lock against 
fork. Since the fd tracker is needed across connect() (which allocates a 
file descriptor), we need to hold the ust_lock across connect(). 

Fixes: #253 
Fixes: #626 

Suggested-by: Aravind HT <aravind.ht@gmail.com> 
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com> 

commit 451d66b27efb332bd16f79dcee374b6a2c85186f 
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com> 
Date: Tue Sep 13 16:17:04 2016 -0400 

Fix: honor send timeout on unix socket connect 

Needed if we want to hold the ust_lock() while we connect to the session 
daemon without blocking the application forever if the session daemon is 
hung on SIGSTOP. 

This only triggers if we launchs _many_ applications with a session 
daemon SIGSTOP'd (e.g. 1000 in parallel), so we fill the socket queue, 
and applications hang there until the session daemon is SIGCONT'd. 

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com> 

Thanks, 

Mathieu 

> Some applications use fork() and immediately in the child, close() a certain
> range of file
> descriptors from a loop. This could also be closing not just the descriptors
> that are
> inherited from parent, but also those valid descriptors being used by the
> lttng-ust. To
> avoid this, a new API lttng_ust_safe_close(int fd) has been provided for
> applications to
> call in the above scenarios instead of close()

> diff -Naur ./include/ust-comm.h ./include/ust-comm.h
> --- ./include/ust-comm.h	2016-08-25 02:46:01.792925791 -0700
> +++ ./include/ust-comm.h	2016-08-25 02:49:02.480750516 -0700
> @@ -238,4 +238,11 @@
>  int ustcomm_setsockopt_rcv_timeout(int sock, unsigned int msec);
>  int ustcomm_setsockopt_snd_timeout(int sock, unsigned int msec);

> +void init_fd_list();
> +void add_fd_to_list(int fd);
> +void delete_fd_from_list(int fd);
> +int lttng_ust_safe_close_fd(int fd);
> +void lock_fd_list();
> +void unlock_fd_list();
> +
>  #endif	/* _LTTNG_UST_COMM_H */
> diff -Naur ./liblttng-ust/lttng-tracer-core.h ./liblttng-ust/lttng-tracer-core.h
> --- ./liblttng-ust/lttng-tracer-core.h	2016-08-25 02:46:01.824925048 -0700
> +++ ./liblttng-ust/lttng-tracer-core.h	2016-08-25 02:49:02.504750108 -0700
> @@ -49,5 +49,4 @@
>  void lttng_ust_sockinfo_session_enabled(void *owner);

>  void lttng_ust_malloc_wrapper_init(void);
> -
>  #endif /* _LTTNG_TRACER_CORE_H */
> diff -Naur ./liblttng-ust/lttng-ust-abi.c ./liblttng-ust/lttng-ust-abi.c
> --- ./liblttng-ust/lttng-ust-abi.c	2016-08-25 02:46:01.824925048 -0700
> +++ ./liblttng-ust/lttng-ust-abi.c	2016-08-25 02:49:02.504750108 -0700
> @@ -550,11 +550,13 @@
>  invalid:
>  	{
>  		int close_ret;
> -
> +		lock_fd_list();
> +		delete_fd_from_list(wakeup_fd);
>  		close_ret = close(wakeup_fd);
>  		if (close_ret) {
>  			PERROR("close");
>  		}
> +		unlock_fd_list();
>  	}
>  	free(chan_data);
>  	return ret;
> diff -Naur ./liblttng-ust/lttng-ust-comm.c ./liblttng-ust/lttng-ust-comm.c
> --- ./liblttng-ust/lttng-ust-comm.c	2016-08-25 02:46:01.824925048 -0700
> +++ ./liblttng-ust/lttng-ust-comm.c	2016-08-25 02:54:06.053741701 -0700
> @@ -24,7 +24,6 @@
>  #include <sys/socket.h>
>  #include <sys/mman.h>
>  #include <sys/stat.h>
> -#include <sys/types.h>
>  #include <sys/wait.h>
>  #include <fcntl.h>
>  #include <unistd.h>
> @@ -1090,17 +1089,27 @@
>  		goto error;
>  	}

> +	lock_fd_list();
>  	wait_shm_fd = get_wait_shm(sock_info, page_size);
>  	if (wait_shm_fd < 0) {
> +		unlock_fd_list();
>  		goto error;
>  	}
> +	add_fd_to_list(wait_shm_fd);
> +	unlock_fd_list();
> +
>  	wait_shm_mmap = mmap(NULL, page_size, PROT_READ,
>  		  MAP_SHARED, wait_shm_fd, 0);
>  	/* close shm fd immediately after taking the mmap reference */
> +
> +	lock_fd_list();
>  	ret = close(wait_shm_fd);
>  	if (ret) {
>  		PERROR("Error closing fd");
>  	}
> +	delete_fd_from_list(wait_shm_fd);
> +	unlock_fd_list();
> +
>  	if (wait_shm_mmap == MAP_FAILED) {
>  		DBG("mmap error (can be caused by race with sessiond). Fallback to poll mode.");
>  		goto error;
> @@ -1192,6 +1201,8 @@
>  	}

>  	if (sock_info->socket != -1) {
> +
> +		/* FD list will be updated by ustcomm_close_unix_sock() */
>  		ret = ustcomm_close_unix_sock(sock_info->socket);
>  		if (ret) {
>  			ERR("Error closing %s ust cmd socket",
> @@ -1200,6 +1211,8 @@
>  		sock_info->socket = -1;
>  	}
>  	if (sock_info->notify_socket != -1) {
> +
> +		/* FD list will be updated by ustcomm_close_unix_sock() */
>  		ret = ustcomm_close_unix_sock(sock_info->notify_socket);
>  		if (ret) {
>  			ERR("Error closing %s ust notify socket",
> @@ -1216,8 +1229,10 @@
>  	 * first connect registration message.
>  	 */
>  	/* Connect cmd socket */
> +	lock_fd_list();
>  	ret = ustcomm_connect_unix_sock(sock_info->sock_path);
>  	if (ret < 0) {
> +		unlock_fd_list();
> 		DBG("Info: sessiond not accepting connections to %s apps socket",
>  		sock_info->name);
>  		prev_connect_failed = 1;

> @@ -1235,6 +1250,8 @@
>  		goto restart;
>  	}
>  	sock_info->socket = ret;
> +	add_fd_to_list(ret);
> +	unlock_fd_list();

>  	if (ust_lock()) {
>  		goto quit;
> @@ -1272,8 +1289,10 @@
>  	ust_unlock();

>  	/* Connect notify socket */
> +	lock_fd_list();
>  	ret = ustcomm_connect_unix_sock(sock_info->sock_path);
>  	if (ret < 0) {
> +		unlock_fd_list();
> 		DBG("Info: sessiond not accepting connections to %s apps socket",
>  		sock_info->name);
>  		prev_connect_failed = 1;

> @@ -1291,6 +1310,8 @@
>  		goto restart;
>  	}
>  	sock_info->notify_socket = ret;
> +	add_fd_to_list(ret);
> +	unlock_fd_list();

>  	timeout = get_notify_sock_timeout();
>  	if (timeout >= 0) {
> @@ -1424,6 +1445,7 @@
>  	if (uatomic_xchg(&initialized, 1) == 1)
>  		return;

> +	init_fd_list();
>  	/*
>  	 * Fixup interdependency between TLS fixup mutex (which happens
>  	 * to be the dynamic linker mutex) and ust_lock, taken within
> diff -Naur ./liblttng-ust-comm/lttng-ust-comm.c
> ./liblttng-ust-comm/lttng-ust-comm.c
> --- ./liblttng-ust-comm/lttng-ust-comm.c	2016-08-25 02:46:01.800925601 -0700
> +++ ./liblttng-ust-comm/lttng-ust-comm.c	2016-08-25 02:49:02.488750470 -0700
> @@ -25,6 +25,10 @@
>  #include <sys/socket.h>
>  #include <sys/stat.h>
>  #include <sys/types.h>
> +#include <sys/select.h>
> +#include <sys/resource.h>
> +#include <sys/time.h>
> +#include <fcntl.h>
>  #include <sys/un.h>
>  #include <unistd.h>
>  #include <assert.h>
> @@ -45,6 +49,17 @@

>  #define USTCOMM_MAX_SEND_FDS	4

> +/* Operations on the fd set */
> +#define IS_FD_VALID(fd)			((fd) >= 0 && (fd) < lttng_ust_max_fd)
> +#define GET_FD_SET_FOR_FD(fd, fd_sets)	(&((fd_sets)[(fd) / FD_SETSIZE]))
> +#define CALC_INDEX_TO_SET(fd)		((fd) % FD_SETSIZE)
> +
> +/* Check fd validity before calling these */
> +#define ADD_FD_TO_SET(fd, fd_sets)	FD_SET(CALC_INDEX_TO_SET(fd),
> GET_FD_SET_FOR_FD(fd, fd_sets))
> +#define IS_FD_SET(fd, fd_sets)		FD_ISSET(CALC_INDEX_TO_SET(fd),
> GET_FD_SET_FOR_FD(fd, fd_sets))
> +#define DEL_FD_FROM_SET(fd, fd_sets)	FD_CLR(CALC_INDEX_TO_SET(fd),
> GET_FD_SET_FOR_FD(fd, fd_sets))
> + int fd_added, fd_removed;
> +
>  /*
>   * Human readable error message.
>   */
> @@ -63,6 +78,111 @@
> 	[ USTCOMM_CODE_OFFSET(LTTNG_UST_ERR_UNSUP_MAJOR) ] = "Unsupported major
>  	version",
>  };

> +/* Protect the lttng_fd_set */
> +pthread_mutex_t ust_safe_guard_fd_mutex = PTHREAD_MUTEX_INITIALIZER;
> +/* fd_set used to book keep fd's being used by lttng-ust */
> +static fd_set *lttng_fd_set;
> +static int lttng_ust_max_fd;
> +static int num_fd_sets;
> +
> +/*
> + * Allocate the fd set array based on the hard limit set for this
> + * process. This will get called  during the constructor execution
> + * and will also be called in the child after fork via lttng_ust_init
> + */
> +void init_fd_list()
> +{
> +	int i = 0;
> +	struct rlimit rlim = {0};
> +
> +	/* Get the current possible max number of fd for this process */
> +	if (getrlimit(RLIMIT_NOFILE, &rlim) < 0) {
> +		assert(0);
> +	}
> +	/*
> +	 * FD set array size determined using the hard limit. Even if
> +	 * the process wishes to increase its limit using setrlimit, it
> +	 * can only do so with the softlimit which will be less than the
> +	 * hard limit.
> +	 */
> +	lttng_ust_max_fd = rlim.rlim_max;
> +	num_fd_sets = lttng_ust_max_fd / FD_SETSIZE;
> +	if (lttng_ust_max_fd % FD_SETSIZE) {
> +		++num_fd_sets;
> +	}
> +
> +	if (lttng_fd_set != NULL) {
> +		free(lttng_fd_set);
> +		lttng_fd_set = NULL;
> +	}
> +	lttng_fd_set = (fd_set *)malloc((num_fd_sets)*(sizeof(fd_set)));
> +	assert(lttng_fd_set);
> +
> +	for (i = 0 ; i < num_fd_sets ; i++) {
> +		FD_ZERO((&lttng_fd_set[i]));
> +	}
> +}
> +
> +void lock_fd_list()
> +{
> +	pthread_mutex_lock(&ust_safe_guard_fd_mutex);
> +}
> +
> +void unlock_fd_list()
> +{
> +	pthread_mutex_unlock(&ust_safe_guard_fd_mutex);
> +}
> +
> +/*
> + * Needs to be called with  ust_safe_guard_fd_mutex held when opening the fd.
> + * Has strict checking of fd validity.
> + */
> +void add_fd_to_list(int fd)
> +{
> +	/* Trying to add an fd which we can not accommodate */
> +	assert(IS_FD_VALID(fd));
> +	fd_added++;
> +	/* Setting an fd thats already set */
> +	assert(!IS_FD_SET(fd, lttng_fd_set));
> +
> +	ADD_FD_TO_SET(fd, lttng_fd_set);
> +}
> +
> +/*
> + * Needs to be called with  ust_safe_guard_fd_mutex held when opening the fd.
> + * Has strict checking for fd validity.
> + */
> +void delete_fd_from_list(int fd)
> +{
> +	/* Not a valid fd */
> +	assert(IS_FD_VALID(fd));
> +	fd_removed++;
> +	/* deleting an fd which was not set */
> +	assert(IS_FD_SET(fd, lttng_fd_set));
> +
> +	DEL_FD_FROM_SET(fd,lttng_fd_set);
> +}
> +
> +/*
> + * Check to see if the given fd is being used, else we close
> + * it here even if its not a valid fd as asked by the app.
> + */
> +int lttng_ust_safe_close_fd(int fd)
> +{
> +	int ret = 0;
> +
> +	lock_fd_list();
> +	if (IS_FD_VALID(fd) && IS_FD_SET(fd, lttng_fd_set)) {
> +		ret = 0;
> +	} else {
> +		ret = close(fd);
> +	}
> +	unlock_fd_list();
> +
> +	return ret;
> +}
> +
> +
>  /*
>   * lttng_ust_strerror
>   *
> @@ -244,7 +364,10 @@
>  {
>  	int ret;

> +	lock_fd_list();
> +	delete_fd_from_list(sock);
>  	ret = close(sock);
> +	unlock_fd_list();
>  	if (ret < 0) {
>  		PERROR("close");
>  		ret = -errno;
> @@ -578,8 +701,10 @@
>  		goto error_recv;
>  	}
>  	/* recv wakeup fd */
> +	lock_fd_list();
>  	nr_fd = ustcomm_recv_fds_unix_sock(sock, &wakeup_fd, 1);
>  	if (nr_fd <= 0) {
> +		unlock_fd_list();
>  		if (nr_fd < 0) {
>  			len = nr_fd;
>  			goto error_recv;
> @@ -589,6 +714,9 @@
>  		}
>  	}
>  	*_wakeup_fd = wakeup_fd;
> +	/* only one fd requested above */
> +	add_fd_to_list(wakeup_fd);
> +	unlock_fd_list();
>  	*_chan_data = chan_data;
>  	return len;

> @@ -608,8 +736,10 @@
>  	int fds[2];

>  	/* recv shm fd and wakeup fd */
> +	lock_fd_list();
>  	len = ustcomm_recv_fds_unix_sock(sock, fds, 2);
>  	if (len <= 0) {
> +		unlock_fd_list();
>  		if (len < 0) {
>  			ret = len;
>  			goto error;
> @@ -620,6 +750,9 @@
>  	}
>  	*shm_fd = fds[0];
>  	*wakeup_fd = fds[1];
> +	add_fd_to_list(fds[0]);
> +	add_fd_to_list(fds[1]);
> +	unlock_fd_list();
>  	return 0;

>  error:
> diff -Naur ./libringbuffer/ring_buffer_frontend.c
> ./libringbuffer/ring_buffer_frontend.c
> --- ./libringbuffer/ring_buffer_frontend.c	2016-08-25 02:46:01.800925601 -0700
> +++ ./libringbuffer/ring_buffer_frontend.c	2016-08-26 02:22:43.479803492 -0700
> @@ -651,11 +651,11 @@
>  }

>  static void channel_free(struct channel *chan,
> -		struct lttng_ust_shm_handle *handle)
> +		struct lttng_ust_shm_handle *handle, int consumer)
>  {
>  	channel_backend_free(&chan->backend, handle);
>  	/* chan is freed by shm teardown */
> -	shm_object_table_destroy(handle->table);
> +	shm_object_table_destroy(handle->table, consumer);
>  	free(handle);
>  }

> @@ -770,7 +770,7 @@

>  error_backend_init:
>  error_append:
> -	shm_object_table_destroy(handle->table);
> +	shm_object_table_destroy(handle->table, 1);
>  error_table_alloc:
>  	free(handle);
>  	return NULL;
> @@ -802,7 +802,7 @@
>  	return handle;

>  error_table_object:
> -	shm_object_table_destroy(handle->table);
> +	shm_object_table_destroy(handle->table, 1);
>  error_table_alloc:
>  	free(handle);
>  	return NULL;
> @@ -830,9 +830,9 @@
>  }

>  static
> -void channel_release(struct channel *chan, struct lttng_ust_shm_handle *handle)
> +void channel_release(struct channel *chan, struct lttng_ust_shm_handle *handle,
> int consumer)
>  {
> -	channel_free(chan, handle);
> +	channel_free(chan, handle, consumer);
>  }

>  /**
> @@ -864,7 +864,7 @@
>  	 * sessiond/consumer are keeping a reference on the shm file
>  	 * descriptor directly. No need to refcount.
>  	 */
> -	channel_release(chan, handle);
> +	channel_release(chan, handle, consumer);
>  	return;
>  }

> diff -Naur ./libringbuffer/shm.c ./libringbuffer/shm.c
> --- ./libringbuffer/shm.c	2016-08-25 02:46:01.800925601 -0700
> +++ ./libringbuffer/shm.c	2016-08-26 01:35:38.480446245 -0700
> @@ -399,7 +399,7 @@
>  }

>  static
> -void shmp_object_destroy(struct shm_object *obj)
> +void shmp_object_destroy(struct shm_object *obj, int consumer)
>  {
>  	switch (obj->type) {
>  	case SHM_OBJECT_SHM:
> @@ -411,7 +411,15 @@
>  			PERROR("umnmap");
>  			assert(0);
>  		}
> +
> +		/* Delete FD's only if called from UST and not consumer */
> +		if (consumer == 0) {
> +			lock_fd_list();
> +			delete_fd_from_list(obj->shm_fd);
> +			unlock_fd_list();
> +		}
>  		ret = close(obj->shm_fd);
> +
>  		if (ret) {
>  			PERROR("close");
>  			assert(0);
> @@ -419,7 +427,14 @@
>  		for (i = 0; i < 2; i++) {
>  			if (obj->wait_fd[i] < 0)
>  				continue;
> +
> +			if (consumer == 0) {
> +				lock_fd_list();
> +				delete_fd_from_list(obj->wait_fd[i]);
> +				unlock_fd_list();
> +			}
>  			ret = close(obj->wait_fd[i]);
> +
>  			if (ret) {
>  				PERROR("close");
>  				assert(0);
> @@ -434,7 +449,14 @@
>  		for (i = 0; i < 2; i++) {
>  			if (obj->wait_fd[i] < 0)
>  				continue;
> +
> +			if (consumer == 0) {
> +				lock_fd_list();
> +				delete_fd_from_list(obj->wait_fd[i]);
> +				unlock_fd_list();
> +			}
>  			ret = close(obj->wait_fd[i]);
> +
>  			if (ret) {
>  				PERROR("close");
>  				assert(0);
> @@ -448,12 +470,12 @@
>  	}
>  }

> -void shm_object_table_destroy(struct shm_object_table *table)
> +void shm_object_table_destroy(struct shm_object_table *table, int consumer)
>  {
>  	int i;

>  	for (i = 0; i < table->allocated_len; i++)
> -		shmp_object_destroy(&table->objects[i]);
> +		shmp_object_destroy(&table->objects[i], consumer);
>  	free(table);
>  }

> diff -Naur ./libringbuffer/shm.h ./libringbuffer/shm.h
> --- ./libringbuffer/shm.h	2016-08-25 02:46:01.800925601 -0700
> +++ ./libringbuffer/shm.h	2016-08-26 01:55:00.678044935 -0700
> @@ -95,7 +95,7 @@
>  /* mem ownership is passed to shm_object_table_append_mem(). */
>  struct shm_object *shm_object_table_append_mem(struct shm_object_table *table,
>  			void *mem, size_t memory_map_size, int wakeup_fd);
> -void shm_object_table_destroy(struct shm_object_table *table);
> +void shm_object_table_destroy(struct shm_object_table *table, int consumer);

>  /*
>   * zalloc_shm - allocate memory within a shm object.

> Regards,
> Aravind.

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers 
EfficiOS Inc. 
http://www.efficios.com 

--=_482f6520-266f-41aa-8fb0-b1afe0da51f8
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div><br></div><div><br></div><span id=3D"zwchr"=
 data-marker=3D"__DIVIDER__">----- On Sep 2, 2016, at 9:35 AM, Aravind HT &=
lt;aravind.ht@gmail.com&gt; wrote:<br></span><div data-marker=3D"__QUOTED_T=
EXT__"><blockquote style=3D"border-left:2px solid #1010FF;margin-left:5px;p=
adding-left:5px;color:#000;font-weight:normal;font-style:normal;text-decora=
tion:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt;"><div dir=
=3D"ltr">Hi,<br><div>This is with respect to the following bugs caused by a=
pplications doing bulk close() of file descriptors soon after forking.</div=
><div><a href=3D"https://bugs.lttng.org/issues/253" target=3D"_blank">https=
://bugs.lttng.org/issues/253</a><br></div><div><a href=3D"https://bugs.lttn=
g.org/issues/626" target=3D"_blank">https://bugs.lttng.org/issues/626</a><b=
r></div><br><div>I am using LTTNG UST 2.6.0 and am forwarding a fix that I =
am trying out in the form of an LTTNG UST API&nbsp;<span style=3D"color:rgb=
(0,0,0);white-space:pre-wrap">int lttng_ust_safe_close_fd(int fd) , </span>=
that can be called by apps instead of the close(). The solution that was be=
ing considered, going by the discussion on the above bugs was to see if clo=
se() can be LD_PRELOADED and that had a few complexities. For the meantime,=
 the new LTTNG UST API being proposed here can be used.</div><br><div>Pleas=
e review. Due to time constraints, I am not able provide a patch on the lat=
est version of UST, but think this can be done with reasonably low effort a=
s nothing major seems to have changed.</div></div></blockquote><div><br></d=
iv><div>Hi Aravind,<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=
=3D"1"></div><div>Thanks for the patch. Indeed tracking the file descriptor=
s used by lttng-ust</div><div>with a bitfield makes tons of sense. I howeve=
r decided to take a slightly</div><div>different approach. Rather than expo=
sing a lttng-ust specific API, I</div><div>implemented a helper library whi=
ch overrides close and closeall. Also,</div><div>locking had to be revisite=
d. Here is the resulting string of commits:<br></div><div><br data-mce-bogu=
s=3D"1"></div><div>commit 95e6d2685eec83a144f533a447ffd355fadf9d79<br>Autho=
r: Mathieu Desnoyers &lt;mathieu.desnoyers@efficios.com&gt;<br>Date:&nbsp;&=
nbsp; Mon Sep 12 12:04:13 2016 -0400<br><br>&nbsp;&nbsp;&nbsp; Implement li=
blttng-ust-fd<br>&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp; This library ove=
rrides close() and closeall() libc functions, and uses<br>&nbsp;&nbsp;&nbsp=
; lttng_ust_safe_close_fd() to check whether the application can<br>&nbsp;&=
nbsp;&nbsp; interact with the file descriptor or if it should be left to lt=
tng-ust.<br>&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp; This takes care of bu=
gs caused by applications doing bulk close() or<br>&nbsp;&nbsp;&nbsp; close=
from() of file descriptors soon after forking.<br>&nbsp;&nbsp;&nbsp; <br>&n=
bsp;&nbsp;&nbsp; Fixes: #253<br>&nbsp;&nbsp;&nbsp; Fixes: #626<br>&nbsp;&nb=
sp;&nbsp; <br>&nbsp;&nbsp;&nbsp; CC: Aravind HT &lt;aravind.ht@gmail.com&gt=
;<br>&nbsp;&nbsp;&nbsp; Signed-off-by: Mathieu Desnoyers &lt;mathieu.desnoy=
ers@efficios.com&gt;<br><br>commit 6548fca464f68be5ded73be6b9a479daf08e62d6=
<br>Author: Mathieu Desnoyers &lt;mathieu.desnoyers@efficios.com&gt;<br>Dat=
e:&nbsp;&nbsp; Tue Sep 13 16:17:40 2016 -0400<br><br>&nbsp;&nbsp;&nbsp; Int=
roduce file descriptor tracker<br>&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp;=
 Introduce a tracker for file descriptors used by lttng-ust. It exposes<br>=
&nbsp;&nbsp;&nbsp; a new API in an internal header lttng_ust_safe_close_fd(=
), which is<br>&nbsp;&nbsp;&nbsp; meant to be used by a LD_PRELOADed librar=
y overriding close() and<br>&nbsp;&nbsp;&nbsp; closefrom() (BSD).<br>&nbsp;=
&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp; This takes care of bugs caused by appli=
cations doing bulk close() or<br>&nbsp;&nbsp;&nbsp; closefrom() of file des=
criptors soon after forking.<br>&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp; W=
e need to hold the ust_lock() to protect the fd tracker lock against<br>&nb=
sp;&nbsp;&nbsp; fork. Since the fd tracker is needed across connect() (whic=
h allocates a<br>&nbsp;&nbsp;&nbsp; file descriptor), we need to hold the u=
st_lock across connect().<br>&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp; Fixe=
s: #253<br>&nbsp;&nbsp;&nbsp; Fixes: #626<br>&nbsp;&nbsp;&nbsp; <br>&nbsp;&=
nbsp;&nbsp; Suggested-by: Aravind HT &lt;aravind.ht@gmail.com&gt;<br>&nbsp;=
&nbsp;&nbsp; Signed-off-by: Mathieu Desnoyers &lt;mathieu.desnoyers@efficio=
s.com&gt;<br><br>commit 451d66b27efb332bd16f79dcee374b6a2c85186f<br>Author:=
 Mathieu Desnoyers &lt;mathieu.desnoyers@efficios.com&gt;<br>Date:&nbsp;&nb=
sp; Tue Sep 13 16:17:04 2016 -0400<br><br>&nbsp;&nbsp;&nbsp; Fix: honor sen=
d timeout on unix socket connect<br>&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbs=
p; Needed if we want to hold the ust_lock() while we connect to the session=
<br>&nbsp;&nbsp;&nbsp; daemon without blocking the application forever if t=
he session daemon is<br>&nbsp;&nbsp;&nbsp; hung on SIGSTOP.<br>&nbsp;&nbsp;=
&nbsp; <br>&nbsp;&nbsp;&nbsp; This only triggers if we launchs _many_ appli=
cations with a session<br>&nbsp;&nbsp;&nbsp; daemon SIGSTOP'd (e.g. 1000 in=
 parallel), so we fill the socket queue,<br>&nbsp;&nbsp;&nbsp; and applicat=
ions hang there until the session daemon is SIGCONT'd.<br>&nbsp;&nbsp;&nbsp=
; <br>&nbsp;&nbsp;&nbsp; Signed-off-by: Mathieu Desnoyers &lt;mathieu.desno=
yers@efficios.com&gt;<br><br data-mce-bogus=3D"1"></div><div><br data-mce-b=
ogus=3D"1"></div><div>Thanks,<br data-mce-bogus=3D"1"></div><div><br data-m=
ce-bogus=3D"1"></div><div>Mathieu<br data-mce-bogus=3D"1"></div><div><br da=
ta-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div><br data-=
mce-bogus=3D"1"></div><blockquote style=3D"border-left:2px solid #1010FF;ma=
rgin-left:5px;padding-left:5px;color:#000;font-weight:normal;font-style:nor=
mal;text-decoration:none;font-family:Helvetica,Arial,sans-serif;font-size:1=
2pt;"><div dir=3D"ltr"><br><div><pre style=3D"color:rgb(0,0,0);word-wrap:br=
eak-word;white-space:pre-wrap">Some applications use fork() and immediately=
 in the child, close() a certain range of file
descriptors from a loop. This could also be closing not just the descriptor=
s that are
inherited from parent, but also those valid descriptors being used by the l=
ttng-ust. To
avoid this, a new API lttng_ust_safe_close(int fd) has been provided for ap=
plications to
call in the above scenarios instead of close()

diff -Naur ./include/ust-comm.h ./include/ust-comm.h
--- ./include/ust-comm.h=092016-08-25 02:46:01.792925791 -0700
+++ ./include/ust-comm.h=092016-08-25 02:49:02.480750516 -0700
@@ -238,4 +238,11 @@
 int ustcomm_setsockopt_rcv_timeout(int sock, unsigned int msec);
 int ustcomm_setsockopt_snd_timeout(int sock, unsigned int msec);

+void init_fd_list();
+void add_fd_to_list(int fd);
+void delete_fd_from_list(int fd);
+int lttng_ust_safe_close_fd(int fd);
+void lock_fd_list();
+void unlock_fd_list();
+
 #endif=09/* _LTTNG_UST_COMM_H */
diff -Naur ./liblttng-ust/lttng-tracer-core.h ./liblttng-ust/lttng-tracer-c=
ore.h
--- ./liblttng-ust/lttng-tracer-core.h=092016-08-25 02:46:01.824925048 -070=
0
+++ ./liblttng-ust/lttng-tracer-core.h=092016-08-25 02:49:02.504750108 -070=
0
@@ -49,5 +49,4 @@
 void lttng_ust_sockinfo_session_enabled(void *owner);

 void lttng_ust_malloc_wrapper_init(void);
-
 #endif /* _LTTNG_TRACER_CORE_H */
diff -Naur ./liblttng-ust/lttng-ust-abi.c ./liblttng-ust/lttng-ust-abi.c
--- ./liblttng-ust/lttng-ust-abi.c=092016-08-25 02:46:01.824925048 -0700
+++ ./liblttng-ust/lttng-ust-abi.c=092016-08-25 02:49:02.504750108 -0700
@@ -550,11 +550,13 @@
 invalid:
 =09{
 =09=09int close_ret;
-
+=09=09lock_fd_list();
+=09=09delete_fd_from_list(wakeup_fd);
 =09=09close_ret =3D close(wakeup_fd);
 =09=09if (close_ret) {
 =09=09=09PERROR("close");
 =09=09}
+=09=09unlock_fd_list();
 =09}
 =09free(chan_data);
 =09return ret;
diff -Naur ./liblttng-ust/lttng-ust-comm.c ./liblttng-ust/lttng-ust-comm.c
--- ./liblttng-ust/lttng-ust-comm.c=092016-08-25 02:46:01.824925048 -0700
+++ ./liblttng-ust/lttng-ust-comm.c=092016-08-25 02:54:06.053741701 -0700
@@ -24,7 +24,6 @@
 #include &lt;sys/socket.h&gt;
 #include &lt;sys/mman.h&gt;
 #include &lt;sys/stat.h&gt;
-#include &lt;sys/types.h&gt;
 #include &lt;sys/wait.h&gt;
 #include &lt;fcntl.h&gt;
 #include &lt;unistd.h&gt;
@@ -1090,17 +1089,27 @@
 =09=09goto error;
 =09}

+=09lock_fd_list();
 =09wait_shm_fd =3D get_wait_shm(sock_info, page_size);
 =09if (wait_shm_fd &lt; 0) {
+=09=09unlock_fd_list();
 =09=09goto error;
 =09}
+=09add_fd_to_list(wait_shm_fd);
+=09unlock_fd_list();
+
 =09wait_shm_mmap =3D mmap(NULL, page_size, PROT_READ,
 =09=09  MAP_SHARED, wait_shm_fd, 0);
 =09/* close shm fd immediately after taking the mmap reference */
+
+=09lock_fd_list();
 =09ret =3D close(wait_shm_fd);
 =09if (ret) {
 =09=09PERROR("Error closing fd");
 =09}
+=09delete_fd_from_list(wait_shm_fd);
+=09unlock_fd_list();
+
 =09if (wait_shm_mmap =3D=3D MAP_FAILED) {
 =09=09DBG("mmap error (can be caused by race with sessiond). Fallback to p=
oll mode.");
 =09=09goto error;
@@ -1192,6 +1201,8 @@
 =09}

 =09if (sock_info-&gt;socket !=3D -1) {
+
+=09=09/* FD list will be updated by ustcomm_close_unix_sock() */
 =09=09ret =3D ustcomm_close_unix_sock(sock_info-&gt;socket);
 =09=09if (ret) {
 =09=09=09ERR("Error closing %s ust cmd socket",
@@ -1200,6 +1211,8 @@
 =09=09sock_info-&gt;socket =3D -1;
 =09}
 =09if (sock_info-&gt;notify_socket !=3D -1) {
+
+=09=09/* FD list will be updated by ustcomm_close_unix_sock() */
 =09=09ret =3D ustcomm_close_unix_sock(sock_info-&gt;notify_socket);
 =09=09if (ret) {
 =09=09=09ERR("Error closing %s ust notify socket",
@@ -1216,8 +1229,10 @@
 =09 * first connect registration message.
 =09 */
 =09/* Connect cmd socket */
+=09lock_fd_list();
 =09ret =3D ustcomm_connect_unix_sock(sock_info-&gt;sock_path);
 =09if (ret &lt; 0) {
+=09=09unlock_fd_list();
 =09=09DBG("Info: sessiond not accepting connections to %s apps socket", so=
ck_info-&gt;name);
 =09=09prev_connect_failed =3D 1;

@@ -1235,6 +1250,8 @@
 =09=09goto restart;
 =09}
 =09sock_info-&gt;socket =3D ret;
+=09add_fd_to_list(ret);
+=09unlock_fd_list();

 =09if (ust_lock()) {
 =09=09goto quit;
@@ -1272,8 +1289,10 @@
 =09ust_unlock();

 =09/* Connect notify socket */
+=09lock_fd_list();
 =09ret =3D ustcomm_connect_unix_sock(sock_info-&gt;sock_path);
 =09if (ret &lt; 0) {
+=09=09unlock_fd_list();
 =09=09DBG("Info: sessiond not accepting connections to %s apps socket", so=
ck_info-&gt;name);
 =09=09prev_connect_failed =3D 1;

@@ -1291,6 +1310,8 @@
 =09=09goto restart;
 =09}
 =09sock_info-&gt;notify_socket =3D ret;
+=09add_fd_to_list(ret);
+=09unlock_fd_list();

 =09timeout =3D get_notify_sock_timeout();
 =09if (timeout &gt;=3D 0) {
@@ -1424,6 +1445,7 @@
 =09if (uatomic_xchg(&amp;initialized, 1) =3D=3D 1)
 =09=09return;

+=09init_fd_list();
 =09/*
 =09 * Fixup interdependency between TLS fixup mutex (which happens
 =09 * to be the dynamic linker mutex) and ust_lock, taken within
diff -Naur ./liblttng-ust-comm/lttng-ust-comm.c ./liblttng-ust-comm/lttng-u=
st-comm.c
--- ./liblttng-ust-comm/lttng-ust-comm.c=092016-08-25 02:46:01.800925601 -0=
700
+++ ./liblttng-ust-comm/lttng-ust-comm.c=092016-08-25 02:49:02.488750470 -0=
700
@@ -25,6 +25,10 @@
 #include &lt;sys/socket.h&gt;
 #include &lt;sys/stat.h&gt;
 #include &lt;sys/types.h&gt;
+#include &lt;sys/select.h&gt;
+#include &lt;sys/resource.h&gt;
+#include &lt;sys/time.h&gt;
+#include &lt;fcntl.h&gt;
 #include &lt;sys/un.h&gt;
 #include &lt;unistd.h&gt;
 #include &lt;assert.h&gt;
@@ -45,6 +49,17 @@

 #define USTCOMM_MAX_SEND_FDS=094

+/* Operations on the fd set */
+#define IS_FD_VALID(fd)=09=09=09((fd) &gt;=3D 0 &amp;&amp; (fd) &lt; lttng=
_ust_max_fd)
+#define GET_FD_SET_FOR_FD(fd, fd_sets)=09(&amp;((fd_sets)[(fd) / FD_SETSIZ=
E]))
+#define CALC_INDEX_TO_SET(fd)=09=09((fd) % FD_SETSIZE)
+
+/* Check fd validity before calling these */
+#define ADD_FD_TO_SET(fd, fd_sets)=09FD_SET(CALC_INDEX_TO_SET(fd), GET_FD_=
SET_FOR_FD(fd, fd_sets))
+#define IS_FD_SET(fd, fd_sets)=09=09FD_ISSET(CALC_INDEX_TO_SET(fd), GET_FD=
_SET_FOR_FD(fd, fd_sets))
+#define DEL_FD_FROM_SET(fd, fd_sets)=09FD_CLR(CALC_INDEX_TO_SET(fd), GET_F=
D_SET_FOR_FD(fd, fd_sets))
+ int fd_added, fd_removed;
+
 /*
  * Human readable error message.
  */
@@ -63,6 +78,111 @@
 =09[ USTCOMM_CODE_OFFSET(LTTNG_UST_ERR_UNSUP_MAJOR) ] =3D "Unsupported maj=
or version",
 };

+/* Protect the lttng_fd_set */
+pthread_mutex_t ust_safe_guard_fd_mutex =3D PTHREAD_MUTEX_INITIALIZER;
+/* fd_set used to book keep fd's being used by lttng-ust */
+static fd_set *lttng_fd_set;
+static int lttng_ust_max_fd;
+static int num_fd_sets;
+
+/*
+ * Allocate the fd set array based on the hard limit set for this
+ * process. This will get called  during the constructor execution
+ * and will also be called in the child after fork via lttng_ust_init
+ */
+void init_fd_list()
+{
+=09int i =3D 0;
+=09struct rlimit rlim =3D {0};
+
+=09/* Get the current possible max number of fd for this process */
+=09if (getrlimit(RLIMIT_NOFILE, &amp;rlim) &lt; 0) {
+=09=09assert(0);
+=09}
+=09/*
+=09 * FD set array size determined using the hard limit. Even if
+=09 * the process wishes to increase its limit using setrlimit, it
+=09 * can only do so with the softlimit which will be less than the
+=09 * hard limit.
+=09 */
+=09lttng_ust_max_fd =3D rlim.rlim_max;
+=09num_fd_sets =3D lttng_ust_max_fd / FD_SETSIZE;
+=09if (lttng_ust_max_fd % FD_SETSIZE) {
+=09=09++num_fd_sets;
+=09}
+
+=09if (lttng_fd_set !=3D NULL) {
+=09=09free(lttng_fd_set);
+=09=09lttng_fd_set =3D NULL;
+=09}
+=09lttng_fd_set =3D (fd_set *)malloc((num_fd_sets)*(sizeof(fd_set)));
+=09assert(lttng_fd_set);
+
+=09for (i =3D 0 ; i &lt; num_fd_sets ; i++) {
+=09=09FD_ZERO((&amp;lttng_fd_set[i]));
+=09}
+}
+
+void lock_fd_list()
+{
+=09pthread_mutex_lock(&amp;ust_safe_guard_fd_mutex);
+}
+
+void unlock_fd_list()
+{
+=09pthread_mutex_unlock(&amp;ust_safe_guard_fd_mutex);
+}
+
+/*
+ * Needs to be called with  ust_safe_guard_fd_mutex held when opening the =
fd.
+ * Has strict checking of fd validity.
+ */
+void add_fd_to_list(int fd)
+{
+=09/* Trying to add an fd which we can not accommodate */
+=09assert(IS_FD_VALID(fd));
+=09fd_added++;
+=09/* Setting an fd thats already set */
+=09assert(!IS_FD_SET(fd, lttng_fd_set));
+
+=09ADD_FD_TO_SET(fd, lttng_fd_set);
+}
+
+/*
+ * Needs to be called with  ust_safe_guard_fd_mutex held when opening the =
fd.
+ * Has strict checking for fd validity.
+ */
+void delete_fd_from_list(int fd)
+{
+=09/* Not a valid fd */
+=09assert(IS_FD_VALID(fd));
+=09fd_removed++;
+=09/* deleting an fd which was not set */
+=09assert(IS_FD_SET(fd, lttng_fd_set));
+
+=09DEL_FD_FROM_SET(fd,lttng_fd_set);
+}
+
+/*
+ * Check to see if the given fd is being used, else we close
+ * it here even if its not a valid fd as asked by the app.
+ */
+int lttng_ust_safe_close_fd(int fd)
+{
+=09int ret =3D 0;
+
+=09lock_fd_list();
+=09if (IS_FD_VALID(fd) &amp;&amp; IS_FD_SET(fd, lttng_fd_set)) {
+=09=09ret =3D 0;
+=09} else {
+=09=09ret =3D close(fd);
+=09}
+=09unlock_fd_list();
+
+=09return ret;
+}
+
+
 /*
  * lttng_ust_strerror
  *
@@ -244,7 +364,10 @@
 {
 =09int ret;

+=09lock_fd_list();
+=09delete_fd_from_list(sock);
 =09ret =3D close(sock);
+=09unlock_fd_list();
 =09if (ret &lt; 0) {
 =09=09PERROR("close");
 =09=09ret =3D -errno;
@@ -578,8 +701,10 @@
 =09=09goto error_recv;
 =09}
 =09/* recv wakeup fd */
+=09lock_fd_list();
 =09nr_fd =3D ustcomm_recv_fds_unix_sock(sock, &amp;wakeup_fd, 1);
 =09if (nr_fd &lt;=3D 0) {
+=09=09unlock_fd_list();
 =09=09if (nr_fd &lt; 0) {
 =09=09=09len =3D nr_fd;
 =09=09=09goto error_recv;
@@ -589,6 +714,9 @@
 =09=09}
 =09}
 =09*_wakeup_fd =3D wakeup_fd;
+=09/* only one fd requested above */
+=09add_fd_to_list(wakeup_fd);
+=09unlock_fd_list();
 =09*_chan_data =3D chan_data;
 =09return len;

@@ -608,8 +736,10 @@
 =09int fds[2];

 =09/* recv shm fd and wakeup fd */
+=09lock_fd_list();
 =09len =3D ustcomm_recv_fds_unix_sock(sock, fds, 2);
 =09if (len &lt;=3D 0) {
+=09=09unlock_fd_list();
 =09=09if (len &lt; 0) {
 =09=09=09ret =3D len;
 =09=09=09goto error;
@@ -620,6 +750,9 @@
 =09}
 =09*shm_fd =3D fds[0];
 =09*wakeup_fd =3D fds[1];
+=09add_fd_to_list(fds[0]);
+=09add_fd_to_list(fds[1]);
+=09unlock_fd_list();
 =09return 0;

 error:
diff -Naur ./libringbuffer/ring_buffer_frontend.c ./libringbuffer/ring_buff=
er_frontend.c
--- ./libringbuffer/ring_buffer_frontend.c=092016-08-25 02:46:01.800925601 =
-0700
+++ ./libringbuffer/ring_buffer_frontend.c=092016-08-26 02:22:43.479803492 =
-0700
@@ -651,11 +651,11 @@
 }

 static void channel_free(struct channel *chan,
-=09=09struct lttng_ust_shm_handle *handle)
+=09=09struct lttng_ust_shm_handle *handle, int consumer)
 {
 =09channel_backend_free(&amp;chan-&gt;backend, handle);
 =09/* chan is freed by shm teardown */
-=09shm_object_table_destroy(handle-&gt;table);
+=09shm_object_table_destroy(handle-&gt;table, consumer);
 =09free(handle);
 }

@@ -770,7 +770,7 @@

 error_backend_init:
 error_append:
-=09shm_object_table_destroy(handle-&gt;table);
+=09shm_object_table_destroy(handle-&gt;table, 1);
 error_table_alloc:
 =09free(handle);
 =09return NULL;
@@ -802,7 +802,7 @@
 =09return handle;

 error_table_object:
-=09shm_object_table_destroy(handle-&gt;table);
+=09shm_object_table_destroy(handle-&gt;table, 1);
 error_table_alloc:
 =09free(handle);
 =09return NULL;
@@ -830,9 +830,9 @@
 }

 static
-void channel_release(struct channel *chan, struct lttng_ust_shm_handle *ha=
ndle)
+void channel_release(struct channel *chan, struct lttng_ust_shm_handle *ha=
ndle, int consumer)
 {
-=09channel_free(chan, handle);
+=09channel_free(chan, handle, consumer);
 }

 /**
@@ -864,7 +864,7 @@
 =09 * sessiond/consumer are keeping a reference on the shm file
 =09 * descriptor directly. No need to refcount.
 =09 */
-=09channel_release(chan, handle);
+=09channel_release(chan, handle, consumer);
 =09return;
 }

diff -Naur ./libringbuffer/shm.c ./libringbuffer/shm.c
--- ./libringbuffer/shm.c=092016-08-25 02:46:01.800925601 -0700
+++ ./libringbuffer/shm.c=092016-08-26 01:35:38.480446245 -0700
@@ -399,7 +399,7 @@
 }

 static
-void shmp_object_destroy(struct shm_object *obj)
+void shmp_object_destroy(struct shm_object *obj, int consumer)
 {
 =09switch (obj-&gt;type) {
 =09case SHM_OBJECT_SHM:
@@ -411,7 +411,15 @@
 =09=09=09PERROR("umnmap");
 =09=09=09assert(0);
 =09=09}
+
+=09=09/* Delete FD's only if called from UST and not consumer */
+=09=09if (consumer =3D=3D 0) {
+=09=09=09lock_fd_list();
+=09=09=09delete_fd_from_list(obj-&gt;shm_fd);
+=09=09=09unlock_fd_list();
+=09=09}
 =09=09ret =3D close(obj-&gt;shm_fd);
+
 =09=09if (ret) {
 =09=09=09PERROR("close");
 =09=09=09assert(0);
@@ -419,7 +427,14 @@
 =09=09for (i =3D 0; i &lt; 2; i++) {
 =09=09=09if (obj-&gt;wait_fd[i] &lt; 0)
 =09=09=09=09continue;
+
+=09=09=09if (consumer =3D=3D 0) {
+=09=09=09=09lock_fd_list();
+=09=09=09=09delete_fd_from_list(obj-&gt;wait_fd[i]);
+=09=09=09=09unlock_fd_list();
+=09=09=09}
 =09=09=09ret =3D close(obj-&gt;wait_fd[i]);
+
 =09=09=09if (ret) {
 =09=09=09=09PERROR("close");
 =09=09=09=09assert(0);
@@ -434,7 +449,14 @@
 =09=09for (i =3D 0; i &lt; 2; i++) {
 =09=09=09if (obj-&gt;wait_fd[i] &lt; 0)
 =09=09=09=09continue;
+
+=09=09=09if (consumer =3D=3D 0) {
+=09=09=09=09lock_fd_list();
+=09=09=09=09delete_fd_from_list(obj-&gt;wait_fd[i]);
+=09=09=09=09unlock_fd_list();
+=09=09=09}
 =09=09=09ret =3D close(obj-&gt;wait_fd[i]);
+
 =09=09=09if (ret) {
 =09=09=09=09PERROR("close");
 =09=09=09=09assert(0);
@@ -448,12 +470,12 @@
 =09}
 }

-void shm_object_table_destroy(struct shm_object_table *table)
+void shm_object_table_destroy(struct shm_object_table *table, int consumer=
)
 {
 =09int i;

 =09for (i =3D 0; i &lt; table-&gt;allocated_len; i++)
-=09=09shmp_object_destroy(&amp;table-&gt;objects[i]);
+=09=09shmp_object_destroy(&amp;table-&gt;objects[i], consumer);
 =09free(table);
 }

diff -Naur ./libringbuffer/shm.h ./libringbuffer/shm.h
--- ./libringbuffer/shm.h=092016-08-25 02:46:01.800925601 -0700
+++ ./libringbuffer/shm.h=092016-08-26 01:55:00.678044935 -0700
@@ -95,7 +95,7 @@
 /* mem ownership is passed to shm_object_table_append_mem(). */
 struct shm_object *shm_object_table_append_mem(struct shm_object_table *ta=
ble,
 =09=09=09void *mem, size_t memory_map_size, int wakeup_fd);
-void shm_object_table_destroy(struct shm_object_table *table);
+void shm_object_table_destroy(struct shm_object_table *table, int consumer=
);

 /*
  * zalloc_shm - allocate memory within a shm object.</pre></div><br><div>R=
egards,</div><div>Aravind.</div></div><br>_________________________________=
______________<br>lttng-dev mailing list<br>lttng-dev@lists.lttng.org<br>ht=
tps://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev<br></blockquote></=
div><br><div data-marker=3D"__SIG_POST__">-- <br></div><div>Mathieu Desnoye=
rs<br>EfficiOS Inc.<br>http://www.efficios.com</div></div></body></html>
--=_482f6520-266f-41aa-8fb0-b1afe0da51f8--



--===============6312283813632670883==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============6312283813632670883==--
