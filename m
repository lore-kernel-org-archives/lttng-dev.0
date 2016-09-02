From: Aravind HT <aravind.ht@gmail.com>
Subject: UST assert due to file descriptors being closed by
	applications
Date: Fri, 2 Sep 2016 19:05:27 +0530
Message-ID: <CACd+_b5br_uqwWMP-ZdHxr2ajKuqrMmWrYdT+z7ea58hFDm1_Q__43270.123555749$1472823351$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3061236841908615698=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-it0-f68.google.com (mail-it0-f68.google.com
 [209.85.214.68])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id A4C0AA2A03
 for <lttng-dev@lists.lttng.org>; Fri,  2 Sep 2016 13:36:02 +0000 (UTC)
Received: by mail-it0-f68.google.com with SMTP id g185so1807964ith.0
 for <lttng-dev@lists.lttng.org>; Fri, 02 Sep 2016 06:35:29 -0700 (PDT)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============3061236841908615698==
Content-Type: multipart/alternative; boundary=001a1143b92e4e8e91053b866783

--001a1143b92e4e8e91053b866783
Content-Type: text/plain; charset=UTF-8

Hi,

This is with respect to the following bugs caused by applications doing
bulk close() of file descriptors soon after forking.
https://bugs.lttng.org/issues/253
https://bugs.lttng.org/issues/626

I am using LTTNG UST 2.6.0 and am forwarding a fix that I am trying out in
the form of an LTTNG UST API int lttng_ust_safe_close_fd(int fd) , that can
be called by apps instead of the close(). The solution that was being
considered, going by the discussion on the above bugs was to see if close()
can be LD_PRELOADED and that had a few complexities. For the meantime, the
new LTTNG UST API being proposed here can be used.

Please review. Due to time constraints, I am not able provide a patch on
the latest version of UST, but think this can be done with reasonably low
effort as nothing major seems to have changed.

Some applications use fork() and immediately in the child, close() a
certain range of file
descriptors from a loop. This could also be closing not just the
descriptors that are
inherited from parent, but also those valid descriptors being used by
the lttng-ust. To
avoid this, a new API lttng_ust_safe_close(int fd) has been provided
for applications to
call in the above scenarios instead of close()

diff -Naur ./include/ust-comm.h ./include/ust-comm.h
--- ./include/ust-comm.h	2016-08-25 02:46:01.792925791 -0700
+++ ./include/ust-comm.h	2016-08-25 02:49:02.480750516 -0700
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
 #endif	/* _LTTNG_UST_COMM_H */
diff -Naur ./liblttng-ust/lttng-tracer-core.h ./liblttng-ust/lttng-tracer-core.h
--- ./liblttng-ust/lttng-tracer-core.h	2016-08-25 02:46:01.824925048 -0700
+++ ./liblttng-ust/lttng-tracer-core.h	2016-08-25 02:49:02.504750108 -0700
@@ -49,5 +49,4 @@
 void lttng_ust_sockinfo_session_enabled(void *owner);

 void lttng_ust_malloc_wrapper_init(void);
-
 #endif /* _LTTNG_TRACER_CORE_H */
diff -Naur ./liblttng-ust/lttng-ust-abi.c ./liblttng-ust/lttng-ust-abi.c
--- ./liblttng-ust/lttng-ust-abi.c	2016-08-25 02:46:01.824925048 -0700
+++ ./liblttng-ust/lttng-ust-abi.c	2016-08-25 02:49:02.504750108 -0700
@@ -550,11 +550,13 @@
 invalid:
 	{
 		int close_ret;
-
+		lock_fd_list();
+		delete_fd_from_list(wakeup_fd);
 		close_ret = close(wakeup_fd);
 		if (close_ret) {
 			PERROR("close");
 		}
+		unlock_fd_list();
 	}
 	free(chan_data);
 	return ret;
diff -Naur ./liblttng-ust/lttng-ust-comm.c ./liblttng-ust/lttng-ust-comm.c
--- ./liblttng-ust/lttng-ust-comm.c	2016-08-25 02:46:01.824925048 -0700
+++ ./liblttng-ust/lttng-ust-comm.c	2016-08-25 02:54:06.053741701 -0700
@@ -24,7 +24,6 @@
 #include <sys/socket.h>
 #include <sys/mman.h>
 #include <sys/stat.h>
-#include <sys/types.h>
 #include <sys/wait.h>
 #include <fcntl.h>
 #include <unistd.h>
@@ -1090,17 +1089,27 @@
 		goto error;
 	}

+	lock_fd_list();
 	wait_shm_fd = get_wait_shm(sock_info, page_size);
 	if (wait_shm_fd < 0) {
+		unlock_fd_list();
 		goto error;
 	}
+	add_fd_to_list(wait_shm_fd);
+	unlock_fd_list();
+
 	wait_shm_mmap = mmap(NULL, page_size, PROT_READ,
 		  MAP_SHARED, wait_shm_fd, 0);
 	/* close shm fd immediately after taking the mmap reference */
+
+	lock_fd_list();
 	ret = close(wait_shm_fd);
 	if (ret) {
 		PERROR("Error closing fd");
 	}
+	delete_fd_from_list(wait_shm_fd);
+	unlock_fd_list();
+
 	if (wait_shm_mmap == MAP_FAILED) {
 		DBG("mmap error (can be caused by race with sessiond). Fallback to
poll mode.");
 		goto error;
@@ -1192,6 +1201,8 @@
 	}

 	if (sock_info->socket != -1) {
+
+		/* FD list will be updated by ustcomm_close_unix_sock() */
 		ret = ustcomm_close_unix_sock(sock_info->socket);
 		if (ret) {
 			ERR("Error closing %s ust cmd socket",
@@ -1200,6 +1211,8 @@
 		sock_info->socket = -1;
 	}
 	if (sock_info->notify_socket != -1) {
+
+		/* FD list will be updated by ustcomm_close_unix_sock() */
 		ret = ustcomm_close_unix_sock(sock_info->notify_socket);
 		if (ret) {
 			ERR("Error closing %s ust notify socket",
@@ -1216,8 +1229,10 @@
 	 * first connect registration message.
 	 */
 	/* Connect cmd socket */
+	lock_fd_list();
 	ret = ustcomm_connect_unix_sock(sock_info->sock_path);
 	if (ret < 0) {
+		unlock_fd_list();
 		DBG("Info: sessiond not accepting connections to %s apps socket",
sock_info->name);
 		prev_connect_failed = 1;

@@ -1235,6 +1250,8 @@
 		goto restart;
 	}
 	sock_info->socket = ret;
+	add_fd_to_list(ret);
+	unlock_fd_list();

 	if (ust_lock()) {
 		goto quit;
@@ -1272,8 +1289,10 @@
 	ust_unlock();

 	/* Connect notify socket */
+	lock_fd_list();
 	ret = ustcomm_connect_unix_sock(sock_info->sock_path);
 	if (ret < 0) {
+		unlock_fd_list();
 		DBG("Info: sessiond not accepting connections to %s apps socket",
sock_info->name);
 		prev_connect_failed = 1;

@@ -1291,6 +1310,8 @@
 		goto restart;
 	}
 	sock_info->notify_socket = ret;
+	add_fd_to_list(ret);
+	unlock_fd_list();

 	timeout = get_notify_sock_timeout();
 	if (timeout >= 0) {
@@ -1424,6 +1445,7 @@
 	if (uatomic_xchg(&initialized, 1) == 1)
 		return;

+	init_fd_list();
 	/*
 	 * Fixup interdependency between TLS fixup mutex (which happens
 	 * to be the dynamic linker mutex) and ust_lock, taken within
diff -Naur ./liblttng-ust-comm/lttng-ust-comm.c
./liblttng-ust-comm/lttng-ust-comm.c
--- ./liblttng-ust-comm/lttng-ust-comm.c	2016-08-25 02:46:01.800925601 -0700
+++ ./liblttng-ust-comm/lttng-ust-comm.c	2016-08-25 02:49:02.488750470 -0700
@@ -25,6 +25,10 @@
 #include <sys/socket.h>
 #include <sys/stat.h>
 #include <sys/types.h>
+#include <sys/select.h>
+#include <sys/resource.h>
+#include <sys/time.h>
+#include <fcntl.h>
 #include <sys/un.h>
 #include <unistd.h>
 #include <assert.h>
@@ -45,6 +49,17 @@

 #define USTCOMM_MAX_SEND_FDS	4

+/* Operations on the fd set */
+#define IS_FD_VALID(fd)			((fd) >= 0 && (fd) < lttng_ust_max_fd)
+#define GET_FD_SET_FOR_FD(fd, fd_sets)	(&((fd_sets)[(fd) / FD_SETSIZE]))
+#define CALC_INDEX_TO_SET(fd)		((fd) % FD_SETSIZE)
+
+/* Check fd validity before calling these */
+#define ADD_FD_TO_SET(fd, fd_sets)	FD_SET(CALC_INDEX_TO_SET(fd),
GET_FD_SET_FOR_FD(fd, fd_sets))
+#define IS_FD_SET(fd, fd_sets)		FD_ISSET(CALC_INDEX_TO_SET(fd),
GET_FD_SET_FOR_FD(fd, fd_sets))
+#define DEL_FD_FROM_SET(fd, fd_sets)	FD_CLR(CALC_INDEX_TO_SET(fd),
GET_FD_SET_FOR_FD(fd, fd_sets))
+ int fd_added, fd_removed;
+
 /*
  * Human readable error message.
  */
@@ -63,6 +78,111 @@
 	[ USTCOMM_CODE_OFFSET(LTTNG_UST_ERR_UNSUP_MAJOR) ] = "Unsupported
major version",
 };

+/* Protect the lttng_fd_set */
+pthread_mutex_t ust_safe_guard_fd_mutex = PTHREAD_MUTEX_INITIALIZER;
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
+	int i = 0;
+	struct rlimit rlim = {0};
+
+	/* Get the current possible max number of fd for this process */
+	if (getrlimit(RLIMIT_NOFILE, &rlim) < 0) {
+		assert(0);
+	}
+	/*
+	 * FD set array size determined using the hard limit. Even if
+	 * the process wishes to increase its limit using setrlimit, it
+	 * can only do so with the softlimit which will be less than the
+	 * hard limit.
+	 */
+	lttng_ust_max_fd = rlim.rlim_max;
+	num_fd_sets = lttng_ust_max_fd / FD_SETSIZE;
+	if (lttng_ust_max_fd % FD_SETSIZE) {
+		++num_fd_sets;
+	}
+
+	if (lttng_fd_set != NULL) {
+		free(lttng_fd_set);
+		lttng_fd_set = NULL;
+	}
+	lttng_fd_set = (fd_set *)malloc((num_fd_sets)*(sizeof(fd_set)));
+	assert(lttng_fd_set);
+
+	for (i = 0 ; i < num_fd_sets ; i++) {
+		FD_ZERO((&lttng_fd_set[i]));
+	}
+}
+
+void lock_fd_list()
+{
+	pthread_mutex_lock(&ust_safe_guard_fd_mutex);
+}
+
+void unlock_fd_list()
+{
+	pthread_mutex_unlock(&ust_safe_guard_fd_mutex);
+}
+
+/*
+ * Needs to be called with  ust_safe_guard_fd_mutex held when opening the fd.
+ * Has strict checking of fd validity.
+ */
+void add_fd_to_list(int fd)
+{
+	/* Trying to add an fd which we can not accommodate */
+	assert(IS_FD_VALID(fd));
+	fd_added++;
+	/* Setting an fd thats already set */
+	assert(!IS_FD_SET(fd, lttng_fd_set));
+
+	ADD_FD_TO_SET(fd, lttng_fd_set);
+}
+
+/*
+ * Needs to be called with  ust_safe_guard_fd_mutex held when opening the fd.
+ * Has strict checking for fd validity.
+ */
+void delete_fd_from_list(int fd)
+{
+	/* Not a valid fd */
+	assert(IS_FD_VALID(fd));
+	fd_removed++;
+	/* deleting an fd which was not set */
+	assert(IS_FD_SET(fd, lttng_fd_set));
+
+	DEL_FD_FROM_SET(fd,lttng_fd_set);
+}
+
+/*
+ * Check to see if the given fd is being used, else we close
+ * it here even if its not a valid fd as asked by the app.
+ */
+int lttng_ust_safe_close_fd(int fd)
+{
+	int ret = 0;
+
+	lock_fd_list();
+	if (IS_FD_VALID(fd) && IS_FD_SET(fd, lttng_fd_set)) {
+		ret = 0;
+	} else {
+		ret = close(fd);
+	}
+	unlock_fd_list();
+
+	return ret;
+}
+
+
 /*
  * lttng_ust_strerror
  *
@@ -244,7 +364,10 @@
 {
 	int ret;

+	lock_fd_list();
+	delete_fd_from_list(sock);
 	ret = close(sock);
+	unlock_fd_list();
 	if (ret < 0) {
 		PERROR("close");
 		ret = -errno;
@@ -578,8 +701,10 @@
 		goto error_recv;
 	}
 	/* recv wakeup fd */
+	lock_fd_list();
 	nr_fd = ustcomm_recv_fds_unix_sock(sock, &wakeup_fd, 1);
 	if (nr_fd <= 0) {
+		unlock_fd_list();
 		if (nr_fd < 0) {
 			len = nr_fd;
 			goto error_recv;
@@ -589,6 +714,9 @@
 		}
 	}
 	*_wakeup_fd = wakeup_fd;
+	/* only one fd requested above */
+	add_fd_to_list(wakeup_fd);
+	unlock_fd_list();
 	*_chan_data = chan_data;
 	return len;

@@ -608,8 +736,10 @@
 	int fds[2];

 	/* recv shm fd and wakeup fd */
+	lock_fd_list();
 	len = ustcomm_recv_fds_unix_sock(sock, fds, 2);
 	if (len <= 0) {
+		unlock_fd_list();
 		if (len < 0) {
 			ret = len;
 			goto error;
@@ -620,6 +750,9 @@
 	}
 	*shm_fd = fds[0];
 	*wakeup_fd = fds[1];
+	add_fd_to_list(fds[0]);
+	add_fd_to_list(fds[1]);
+	unlock_fd_list();
 	return 0;

 error:
diff -Naur ./libringbuffer/ring_buffer_frontend.c
./libringbuffer/ring_buffer_frontend.c
--- ./libringbuffer/ring_buffer_frontend.c	2016-08-25 02:46:01.800925601 -0700
+++ ./libringbuffer/ring_buffer_frontend.c	2016-08-26 02:22:43.479803492 -0700
@@ -651,11 +651,11 @@
 }

 static void channel_free(struct channel *chan,
-		struct lttng_ust_shm_handle *handle)
+		struct lttng_ust_shm_handle *handle, int consumer)
 {
 	channel_backend_free(&chan->backend, handle);
 	/* chan is freed by shm teardown */
-	shm_object_table_destroy(handle->table);
+	shm_object_table_destroy(handle->table, consumer);
 	free(handle);
 }

@@ -770,7 +770,7 @@

 error_backend_init:
 error_append:
-	shm_object_table_destroy(handle->table);
+	shm_object_table_destroy(handle->table, 1);
 error_table_alloc:
 	free(handle);
 	return NULL;
@@ -802,7 +802,7 @@
 	return handle;

 error_table_object:
-	shm_object_table_destroy(handle->table);
+	shm_object_table_destroy(handle->table, 1);
 error_table_alloc:
 	free(handle);
 	return NULL;
@@ -830,9 +830,9 @@
 }

 static
-void channel_release(struct channel *chan, struct lttng_ust_shm_handle *handle)
+void channel_release(struct channel *chan, struct
lttng_ust_shm_handle *handle, int consumer)
 {
-	channel_free(chan, handle);
+	channel_free(chan, handle, consumer);
 }

 /**
@@ -864,7 +864,7 @@
 	 * sessiond/consumer are keeping a reference on the shm file
 	 * descriptor directly. No need to refcount.
 	 */
-	channel_release(chan, handle);
+	channel_release(chan, handle, consumer);
 	return;
 }

diff -Naur ./libringbuffer/shm.c ./libringbuffer/shm.c
--- ./libringbuffer/shm.c	2016-08-25 02:46:01.800925601 -0700
+++ ./libringbuffer/shm.c	2016-08-26 01:35:38.480446245 -0700
@@ -399,7 +399,7 @@
 }

 static
-void shmp_object_destroy(struct shm_object *obj)
+void shmp_object_destroy(struct shm_object *obj, int consumer)
 {
 	switch (obj->type) {
 	case SHM_OBJECT_SHM:
@@ -411,7 +411,15 @@
 			PERROR("umnmap");
 			assert(0);
 		}
+
+		/* Delete FD's only if called from UST and not consumer */
+		if (consumer == 0) {
+			lock_fd_list();
+			delete_fd_from_list(obj->shm_fd);
+			unlock_fd_list();
+		}
 		ret = close(obj->shm_fd);
+
 		if (ret) {
 			PERROR("close");
 			assert(0);
@@ -419,7 +427,14 @@
 		for (i = 0; i < 2; i++) {
 			if (obj->wait_fd[i] < 0)
 				continue;
+
+			if (consumer == 0) {
+				lock_fd_list();
+				delete_fd_from_list(obj->wait_fd[i]);
+				unlock_fd_list();
+			}
 			ret = close(obj->wait_fd[i]);
+
 			if (ret) {
 				PERROR("close");
 				assert(0);
@@ -434,7 +449,14 @@
 		for (i = 0; i < 2; i++) {
 			if (obj->wait_fd[i] < 0)
 				continue;
+
+			if (consumer == 0) {
+				lock_fd_list();
+				delete_fd_from_list(obj->wait_fd[i]);
+				unlock_fd_list();
+			}
 			ret = close(obj->wait_fd[i]);
+
 			if (ret) {
 				PERROR("close");
 				assert(0);
@@ -448,12 +470,12 @@
 	}
 }

-void shm_object_table_destroy(struct shm_object_table *table)
+void shm_object_table_destroy(struct shm_object_table *table, int consumer)
 {
 	int i;

 	for (i = 0; i < table->allocated_len; i++)
-		shmp_object_destroy(&table->objects[i]);
+		shmp_object_destroy(&table->objects[i], consumer);
 	free(table);
 }

diff -Naur ./libringbuffer/shm.h ./libringbuffer/shm.h
--- ./libringbuffer/shm.h	2016-08-25 02:46:01.800925601 -0700
+++ ./libringbuffer/shm.h	2016-08-26 01:55:00.678044935 -0700
@@ -95,7 +95,7 @@
 /* mem ownership is passed to shm_object_table_append_mem(). */
 struct shm_object *shm_object_table_append_mem(struct shm_object_table *table,
 			void *mem, size_t memory_map_size, int wakeup_fd);
-void shm_object_table_destroy(struct shm_object_table *table);
+void shm_object_table_destroy(struct shm_object_table *table, int consumer);

 /*
  * zalloc_shm - allocate memory within a shm object.


Regards,
Aravind.

--001a1143b92e4e8e91053b866783
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>This is with respect to the followi=
ng bugs caused by applications doing bulk close() of file descriptors soon =
after forking.</div><div><a href=3D"https://bugs.lttng.org/issues/253">http=
s://bugs.lttng.org/issues/253</a><br></div><div><a href=3D"https://bugs.ltt=
ng.org/issues/626">https://bugs.lttng.org/issues/626</a><br></div><div><br>=
</div><div>I am using LTTNG UST 2.6.0 and am forwarding a fix that I am try=
ing out in the form of an LTTNG UST API=C2=A0<span style=3D"color:rgb(0,0,0=
);white-space:pre-wrap">int lttng_ust_safe_close_fd(int fd) , </span>that c=
an be called by apps instead of the close(). The solution that was being co=
nsidered, going by the discussion on the above bugs was to see if close() c=
an be LD_PRELOADED and that had a few complexities. For the meantime, the n=
ew LTTNG UST API being proposed here can be used.</div><div><br></div><div>=
Please review. Due to time constraints, I am not able provide a patch on th=
e latest version of UST, but think this can be done with reasonably low eff=
ort as nothing major seems to have changed.</div><div><br></div><div><pre s=
tyle=3D"color:rgb(0,0,0);word-wrap:break-word;white-space:pre-wrap">Some ap=
plications use fork() and immediately in the child, close() a certain range=
 of file
descriptors from a loop. This could also be closing not just the descriptor=
s that are
inherited from parent, but also those valid descriptors being used by the l=
ttng-ust. To
avoid this, a new API lttng_ust_safe_close(int fd) has been provided for ap=
plications to
call in the above scenarios instead of close()

diff -Naur ./include/ust-comm.h ./include/ust-comm.h
--- ./include/ust-comm.h	2016-08-25 02:46:01.792925791 -0700
+++ ./include/ust-comm.h	2016-08-25 02:49:02.480750516 -0700
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
 #endif	/* _LTTNG_UST_COMM_H */
diff -Naur ./liblttng-ust/lttng-tracer-core.h ./liblttng-ust/lttng-tracer-c=
ore.h
--- ./liblttng-ust/lttng-tracer-core.h	2016-08-25 02:46:01.824925048 -0700
+++ ./liblttng-ust/lttng-tracer-core.h	2016-08-25 02:49:02.504750108 -0700
@@ -49,5 +49,4 @@
 void lttng_ust_sockinfo_session_enabled(void *owner);

 void lttng_ust_malloc_wrapper_init(void);
-
 #endif /* _LTTNG_TRACER_CORE_H */
diff -Naur ./liblttng-ust/lttng-ust-abi.c ./liblttng-ust/lttng-ust-abi.c
--- ./liblttng-ust/lttng-ust-abi.c	2016-08-25 02:46:01.824925048 -0700
+++ ./liblttng-ust/lttng-ust-abi.c	2016-08-25 02:49:02.504750108 -0700
@@ -550,11 +550,13 @@
 invalid:
 	{
 		int close_ret;
-
+		lock_fd_list();
+		delete_fd_from_list(wakeup_fd);
 		close_ret =3D close(wakeup_fd);
 		if (close_ret) {
 			PERROR(&quot;close&quot;);
 		}
+		unlock_fd_list();
 	}
 	free(chan_data);
 	return ret;
diff -Naur ./liblttng-ust/lttng-ust-comm.c ./liblttng-ust/lttng-ust-comm.c
--- ./liblttng-ust/lttng-ust-comm.c	2016-08-25 02:46:01.824925048 -0700
+++ ./liblttng-ust/lttng-ust-comm.c	2016-08-25 02:54:06.053741701 -0700
@@ -24,7 +24,6 @@
 #include &lt;sys/socket.h&gt;
 #include &lt;sys/mman.h&gt;
 #include &lt;sys/stat.h&gt;
-#include &lt;sys/types.h&gt;
 #include &lt;sys/wait.h&gt;
 #include &lt;fcntl.h&gt;
 #include &lt;unistd.h&gt;
@@ -1090,17 +1089,27 @@
 		goto error;
 	}

+	lock_fd_list();
 	wait_shm_fd =3D get_wait_shm(sock_info, page_size);
 	if (wait_shm_fd &lt; 0) {
+		unlock_fd_list();
 		goto error;
 	}
+	add_fd_to_list(wait_shm_fd);
+	unlock_fd_list();
+
 	wait_shm_mmap =3D mmap(NULL, page_size, PROT_READ,
 		  MAP_SHARED, wait_shm_fd, 0);
 	/* close shm fd immediately after taking the mmap reference */
+
+	lock_fd_list();
 	ret =3D close(wait_shm_fd);
 	if (ret) {
 		PERROR(&quot;Error closing fd&quot;);
 	}
+	delete_fd_from_list(wait_shm_fd);
+	unlock_fd_list();
+
 	if (wait_shm_mmap =3D=3D MAP_FAILED) {
 		DBG(&quot;mmap error (can be caused by race with sessiond). Fallback to =
poll mode.&quot;);
 		goto error;
@@ -1192,6 +1201,8 @@
 	}

 	if (sock_info-&gt;socket !=3D -1) {
+
+		/* FD list will be updated by ustcomm_close_unix_sock() */
 		ret =3D ustcomm_close_unix_sock(sock_info-&gt;socket);
 		if (ret) {
 			ERR(&quot;Error closing %s ust cmd socket&quot;,
@@ -1200,6 +1211,8 @@
 		sock_info-&gt;socket =3D -1;
 	}
 	if (sock_info-&gt;notify_socket !=3D -1) {
+
+		/* FD list will be updated by ustcomm_close_unix_sock() */
 		ret =3D ustcomm_close_unix_sock(sock_info-&gt;notify_socket);
 		if (ret) {
 			ERR(&quot;Error closing %s ust notify socket&quot;,
@@ -1216,8 +1229,10 @@
 	 * first connect registration message.
 	 */
 	/* Connect cmd socket */
+	lock_fd_list();
 	ret =3D ustcomm_connect_unix_sock(sock_info-&gt;sock_path);
 	if (ret &lt; 0) {
+		unlock_fd_list();
 		DBG(&quot;Info: sessiond not accepting connections to %s apps socket&quo=
t;, sock_info-&gt;name);
 		prev_connect_failed =3D 1;

@@ -1235,6 +1250,8 @@
 		goto restart;
 	}
 	sock_info-&gt;socket =3D ret;
+	add_fd_to_list(ret);
+	unlock_fd_list();

 	if (ust_lock()) {
 		goto quit;
@@ -1272,8 +1289,10 @@
 	ust_unlock();

 	/* Connect notify socket */
+	lock_fd_list();
 	ret =3D ustcomm_connect_unix_sock(sock_info-&gt;sock_path);
 	if (ret &lt; 0) {
+		unlock_fd_list();
 		DBG(&quot;Info: sessiond not accepting connections to %s apps socket&quo=
t;, sock_info-&gt;name);
 		prev_connect_failed =3D 1;

@@ -1291,6 +1310,8 @@
 		goto restart;
 	}
 	sock_info-&gt;notify_socket =3D ret;
+	add_fd_to_list(ret);
+	unlock_fd_list();

 	timeout =3D get_notify_sock_timeout();
 	if (timeout &gt;=3D 0) {
@@ -1424,6 +1445,7 @@
 	if (uatomic_xchg(&amp;initialized, 1) =3D=3D 1)
 		return;

+	init_fd_list();
 	/*
 	 * Fixup interdependency between TLS fixup mutex (which happens
 	 * to be the dynamic linker mutex) and ust_lock, taken within
diff -Naur ./liblttng-ust-comm/lttng-ust-comm.c ./liblttng-ust-comm/lttng-u=
st-comm.c
--- ./liblttng-ust-comm/lttng-ust-comm.c	2016-08-25 02:46:01.800925601 -070=
0
+++ ./liblttng-ust-comm/lttng-ust-comm.c	2016-08-25 02:49:02.488750470 -070=
0
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

 #define USTCOMM_MAX_SEND_FDS	4

+/* Operations on the fd set */
+#define IS_FD_VALID(fd)			((fd) &gt;=3D 0 &amp;&amp; (fd) &lt; lttng_ust_m=
ax_fd)
+#define GET_FD_SET_FOR_FD(fd, fd_sets)	(&amp;((fd_sets)[(fd) / FD_SETSIZE]=
))
+#define CALC_INDEX_TO_SET(fd)		((fd) % FD_SETSIZE)
+
+/* Check fd validity before calling these */
+#define ADD_FD_TO_SET(fd, fd_sets)	FD_SET(CALC_INDEX_TO_SET(fd), GET_FD_SE=
T_FOR_FD(fd, fd_sets))
+#define IS_FD_SET(fd, fd_sets)		FD_ISSET(CALC_INDEX_TO_SET(fd), GET_FD_SET=
_FOR_FD(fd, fd_sets))
+#define DEL_FD_FROM_SET(fd, fd_sets)	FD_CLR(CALC_INDEX_TO_SET(fd), GET_FD_=
SET_FOR_FD(fd, fd_sets))
+ int fd_added, fd_removed;
+
 /*
  * Human readable error message.
  */
@@ -63,6 +78,111 @@
 	[ USTCOMM_CODE_OFFSET(LTTNG_UST_ERR_UNSUP_MAJOR) ] =3D &quot;Unsupported =
major version&quot;,
 };

+/* Protect the lttng_fd_set */
+pthread_mutex_t ust_safe_guard_fd_mutex =3D PTHREAD_MUTEX_INITIALIZER;
+/* fd_set used to book keep fd&#39;s being used by lttng-ust */
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
+	int i =3D 0;
+	struct rlimit rlim =3D {0};
+
+	/* Get the current possible max number of fd for this process */
+	if (getrlimit(RLIMIT_NOFILE, &amp;rlim) &lt; 0) {
+		assert(0);
+	}
+	/*
+	 * FD set array size determined using the hard limit. Even if
+	 * the process wishes to increase its limit using setrlimit, it
+	 * can only do so with the softlimit which will be less than the
+	 * hard limit.
+	 */
+	lttng_ust_max_fd =3D rlim.rlim_max;
+	num_fd_sets =3D lttng_ust_max_fd / FD_SETSIZE;
+	if (lttng_ust_max_fd % FD_SETSIZE) {
+		++num_fd_sets;
+	}
+
+	if (lttng_fd_set !=3D NULL) {
+		free(lttng_fd_set);
+		lttng_fd_set =3D NULL;
+	}
+	lttng_fd_set =3D (fd_set *)malloc((num_fd_sets)*(sizeof(fd_set)));
+	assert(lttng_fd_set);
+
+	for (i =3D 0 ; i &lt; num_fd_sets ; i++) {
+		FD_ZERO((&amp;lttng_fd_set[i]));
+	}
+}
+
+void lock_fd_list()
+{
+	pthread_mutex_lock(&amp;ust_safe_guard_fd_mutex);
+}
+
+void unlock_fd_list()
+{
+	pthread_mutex_unlock(&amp;ust_safe_guard_fd_mutex);
+}
+
+/*
+ * Needs to be called with  ust_safe_guard_fd_mutex held when opening the =
fd.
+ * Has strict checking of fd validity.
+ */
+void add_fd_to_list(int fd)
+{
+	/* Trying to add an fd which we can not accommodate */
+	assert(IS_FD_VALID(fd));
+	fd_added++;
+	/* Setting an fd thats already set */
+	assert(!IS_FD_SET(fd, lttng_fd_set));
+
+	ADD_FD_TO_SET(fd, lttng_fd_set);
+}
+
+/*
+ * Needs to be called with  ust_safe_guard_fd_mutex held when opening the =
fd.
+ * Has strict checking for fd validity.
+ */
+void delete_fd_from_list(int fd)
+{
+	/* Not a valid fd */
+	assert(IS_FD_VALID(fd));
+	fd_removed++;
+	/* deleting an fd which was not set */
+	assert(IS_FD_SET(fd, lttng_fd_set));
+
+	DEL_FD_FROM_SET(fd,lttng_fd_set);
+}
+
+/*
+ * Check to see if the given fd is being used, else we close
+ * it here even if its not a valid fd as asked by the app.
+ */
+int lttng_ust_safe_close_fd(int fd)
+{
+	int ret =3D 0;
+
+	lock_fd_list();
+	if (IS_FD_VALID(fd) &amp;&amp; IS_FD_SET(fd, lttng_fd_set)) {
+		ret =3D 0;
+	} else {
+		ret =3D close(fd);
+	}
+	unlock_fd_list();
+
+	return ret;
+}
+
+
 /*
  * lttng_ust_strerror
  *
@@ -244,7 +364,10 @@
 {
 	int ret;

+	lock_fd_list();
+	delete_fd_from_list(sock);
 	ret =3D close(sock);
+	unlock_fd_list();
 	if (ret &lt; 0) {
 		PERROR(&quot;close&quot;);
 		ret =3D -errno;
@@ -578,8 +701,10 @@
 		goto error_recv;
 	}
 	/* recv wakeup fd */
+	lock_fd_list();
 	nr_fd =3D ustcomm_recv_fds_unix_sock(sock, &amp;wakeup_fd, 1);
 	if (nr_fd &lt;=3D 0) {
+		unlock_fd_list();
 		if (nr_fd &lt; 0) {
 			len =3D nr_fd;
 			goto error_recv;
@@ -589,6 +714,9 @@
 		}
 	}
 	*_wakeup_fd =3D wakeup_fd;
+	/* only one fd requested above */
+	add_fd_to_list(wakeup_fd);
+	unlock_fd_list();
 	*_chan_data =3D chan_data;
 	return len;

@@ -608,8 +736,10 @@
 	int fds[2];

 	/* recv shm fd and wakeup fd */
+	lock_fd_list();
 	len =3D ustcomm_recv_fds_unix_sock(sock, fds, 2);
 	if (len &lt;=3D 0) {
+		unlock_fd_list();
 		if (len &lt; 0) {
 			ret =3D len;
 			goto error;
@@ -620,6 +750,9 @@
 	}
 	*shm_fd =3D fds[0];
 	*wakeup_fd =3D fds[1];
+	add_fd_to_list(fds[0]);
+	add_fd_to_list(fds[1]);
+	unlock_fd_list();
 	return 0;

 error:
diff -Naur ./libringbuffer/ring_buffer_frontend.c ./libringbuffer/ring_buff=
er_frontend.c
--- ./libringbuffer/ring_buffer_frontend.c	2016-08-25 02:46:01.800925601 -0=
700
+++ ./libringbuffer/ring_buffer_frontend.c	2016-08-26 02:22:43.479803492 -0=
700
@@ -651,11 +651,11 @@
 }

 static void channel_free(struct channel *chan,
-		struct lttng_ust_shm_handle *handle)
+		struct lttng_ust_shm_handle *handle, int consumer)
 {
 	channel_backend_free(&amp;chan-&gt;backend, handle);
 	/* chan is freed by shm teardown */
-	shm_object_table_destroy(handle-&gt;table);
+	shm_object_table_destroy(handle-&gt;table, consumer);
 	free(handle);
 }

@@ -770,7 +770,7 @@

 error_backend_init:
 error_append:
-	shm_object_table_destroy(handle-&gt;table);
+	shm_object_table_destroy(handle-&gt;table, 1);
 error_table_alloc:
 	free(handle);
 	return NULL;
@@ -802,7 +802,7 @@
 	return handle;

 error_table_object:
-	shm_object_table_destroy(handle-&gt;table);
+	shm_object_table_destroy(handle-&gt;table, 1);
 error_table_alloc:
 	free(handle);
 	return NULL;
@@ -830,9 +830,9 @@
 }

 static
-void channel_release(struct channel *chan, struct lttng_ust_shm_handle *ha=
ndle)
+void channel_release(struct channel *chan, struct lttng_ust_shm_handle *ha=
ndle, int consumer)
 {
-	channel_free(chan, handle);
+	channel_free(chan, handle, consumer);
 }

 /**
@@ -864,7 +864,7 @@
 	 * sessiond/consumer are keeping a reference on the shm file
 	 * descriptor directly. No need to refcount.
 	 */
-	channel_release(chan, handle);
+	channel_release(chan, handle, consumer);
 	return;
 }

diff -Naur ./libringbuffer/shm.c ./libringbuffer/shm.c
--- ./libringbuffer/shm.c	2016-08-25 02:46:01.800925601 -0700
+++ ./libringbuffer/shm.c	2016-08-26 01:35:38.480446245 -0700
@@ -399,7 +399,7 @@
 }

 static
-void shmp_object_destroy(struct shm_object *obj)
+void shmp_object_destroy(struct shm_object *obj, int consumer)
 {
 	switch (obj-&gt;type) {
 	case SHM_OBJECT_SHM:
@@ -411,7 +411,15 @@
 			PERROR(&quot;umnmap&quot;);
 			assert(0);
 		}
+
+		/* Delete FD&#39;s only if called from UST and not consumer */
+		if (consumer =3D=3D 0) {
+			lock_fd_list();
+			delete_fd_from_list(obj-&gt;shm_fd);
+			unlock_fd_list();
+		}
 		ret =3D close(obj-&gt;shm_fd);
+
 		if (ret) {
 			PERROR(&quot;close&quot;);
 			assert(0);
@@ -419,7 +427,14 @@
 		for (i =3D 0; i &lt; 2; i++) {
 			if (obj-&gt;wait_fd[i] &lt; 0)
 				continue;
+
+			if (consumer =3D=3D 0) {
+				lock_fd_list();
+				delete_fd_from_list(obj-&gt;wait_fd[i]);
+				unlock_fd_list();
+			}
 			ret =3D close(obj-&gt;wait_fd[i]);
+
 			if (ret) {
 				PERROR(&quot;close&quot;);
 				assert(0);
@@ -434,7 +449,14 @@
 		for (i =3D 0; i &lt; 2; i++) {
 			if (obj-&gt;wait_fd[i] &lt; 0)
 				continue;
+
+			if (consumer =3D=3D 0) {
+				lock_fd_list();
+				delete_fd_from_list(obj-&gt;wait_fd[i]);
+				unlock_fd_list();
+			}
 			ret =3D close(obj-&gt;wait_fd[i]);
+
 			if (ret) {
 				PERROR(&quot;close&quot;);
 				assert(0);
@@ -448,12 +470,12 @@
 	}
 }

-void shm_object_table_destroy(struct shm_object_table *table)
+void shm_object_table_destroy(struct shm_object_table *table, int consumer=
)
 {
 	int i;

 	for (i =3D 0; i &lt; table-&gt;allocated_len; i++)
-		shmp_object_destroy(&amp;table-&gt;objects[i]);
+		shmp_object_destroy(&amp;table-&gt;objects[i], consumer);
 	free(table);
 }

diff -Naur ./libringbuffer/shm.h ./libringbuffer/shm.h
--- ./libringbuffer/shm.h	2016-08-25 02:46:01.800925601 -0700
+++ ./libringbuffer/shm.h	2016-08-26 01:55:00.678044935 -0700
@@ -95,7 +95,7 @@
 /* mem ownership is passed to shm_object_table_append_mem(). */
 struct shm_object *shm_object_table_append_mem(struct shm_object_table *ta=
ble,
 			void *mem, size_t memory_map_size, int wakeup_fd);
-void shm_object_table_destroy(struct shm_object_table *table);
+void shm_object_table_destroy(struct shm_object_table *table, int consumer=
);

 /*
  * zalloc_shm - allocate memory within a shm object.</pre></div><div><br><=
/div><div>Regards,</div><div>Aravind.</div></div>

--001a1143b92e4e8e91053b866783--

--===============3061236841908615698==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============3061236841908615698==--
