From: =?iso-8859-1?Q?J=E9r=E9mie?= Galarneau <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools] Fix: getgrnam is not MT-Safe,
 use getgrnam_r
Date: Thu, 25 Apr 2019 14:25:54 -0400
Message-ID: <20190425182553.GB4708__3387.04415350861$1556216774$gmane$org@gmail.com>
References: <20190401203341.29236-1-jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qt1-f196.google.com (mail-qt1-f196.google.com
 [209.85.160.196])
 by lists.lttng.org (Postfix) with ESMTPS id 44qlxK3HLzz1KmT
 for <lttng-dev@lists.lttng.org>; Thu, 25 Apr 2019 14:25:57 -0400 (EDT)
Received: by mail-qt1-f196.google.com with SMTP id d13so1221749qth.5
 for <lttng-dev@lists.lttng.org>; Thu, 25 Apr 2019 11:25:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20190401203341.29236-1-jonathan.rajotte-julien@efficios.com>
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
Cc: lttng-dev@lists.lttng.org, jgalar@efficios.com
List-Id: lttng-dev@lists.lttng.org

Merged in master, stable-2.11, and stable-2.10.

As discussed, I replaced the manual buffer allocations/resize to use
the lttng_dynamic_buffer util.

Thanks!
J=E9r=E9mie

On Mon, Apr 01, 2019 at 04:33:41PM -0400, Jonathan Rajotte wrote:
> Running the test suite under a Yocto musl build resulted in musl
> coredump due to double freeing.
> =

> We get the following backtraces:
> =

> 0  a_crash () at ./arch/x86_64/atomic_arch.h:108
> 1  unmap_chunk (self=3D<optimized out>) at src/malloc/malloc.c:515
> 2  free (p=3D<optimized out>) at src/malloc/malloc.c:526
> 3  0x00007f46d9dc3849 in __getgrent_a (f=3Df@entry=3D0x7f46d9d1f7e0, gr=
=3Dgr@entry=3D0x7f46d9e24460 <gr>, line=3Dline@entry=3D0x7f46d9e26058 <line=
>, size=3Dsize@entry=3D0x7f46d92db550, mem=3Dmem@entry=3D0x7f46d9e26050 <me=
m>, nmem=3Dnmem@entry=3D0x7f46d92db558, res=3D0x7f46d92db548) at src/passwd=
/getgrent_a.c:45
> 4  0x00007f46d9dc2e6b in __getgr_a (name=3D0x487242 "tracing", gid=3Dgid@=
entry=3D0, gr=3Dgr@entry=3D0x7f46d9e24460 <gr>, buf=3Dbuf@entry=3D0x7f46d9e=
26058 <line>, size=3Dsize@entry=3D0x7f46d92db550, mem=3Dmem@entry=3D0x7f46d=
9e26050 <mem>, nmem=3D0x7f46d92db558, res=3D0x7f46d92db548) at src/passwd/g=
etgr_a.c:30
> 5  0x00007f46d9dc3733 in getgrnam (name=3D<optimized out>) at src/passwd/=
getgrent.c:37
> 6  0x0000000000460b29 in utils_get_group_id (name=3D<optimized out>) at .=
./../../lttng-tools-2.10.6/src/common/utils.c:1241
> 7  0x000000000044ee69 in thread_manage_health (data=3D<optimized out>) at=
 ../../../../lttng-tools-2.10.6/src/bin/lttng-sessiond/main.c:4115
> 8  0x00007f46d9de1541 in start (p=3D<optimized out>) at src/thread/pthrea=
d_create.c:195
> 9  0x00007f46d9dee661 in __clone () at src/thread/x86_64/clone.s:22
> =

> From another run:
> =

> 0  a_crash () at ./arch/x86_64/atomic_arch.h:108
> 1  unmap_chunk (self=3D<optimized out>) at src/malloc/malloc.c:515
> 2  free (p=3D<optimized out>) at src/malloc/malloc.c:526
> 3  0x00007f5abc210849 in __getgrent_a (f=3Df@entry=3D0x7f5abc2733e0, gr=
=3Dgr@entry=3D0x7f5abc271460 <gr>, line=3Dline@entry=3D0x7f5abc273058 <line=
>, size=3Dsize@entry=3D0x7f5abaef5510, mem=3Dmem@entry=3D0x7f5abc273050 <me=
m>, nmem=3Dnmem@entry=3D0x7f5abaef5518, res=3D0x7f5abaef5508) at src/passwd=
/getgrent_a.c:45
> 4  0x00007f5abc20fe6b in __getgr_a (name=3D0x487242 "tracing", gid=3Dgid@=
entry=3D0, gr=3Dgr@entry=3D0x7f5abc271460 <gr>, buf=3Dbuf@entry=3D0x7f5abc2=
73058 <line>, size=3Dsize@entry=3D0x7f5abaef5510, mem=3Dmem@entry=3D0x7f5ab=
c273050 <mem>, nmem=3D0x7f5abaef5518, res=3D0x7f5abaef5508) at src/passwd/g=
etgr_a.c:30
> 5  0x00007f5abc210733 in getgrnam (name=3D<optimized out>) at src/passwd/=
getgrent.c:37
> 6  0x0000000000460b29 in utils_get_group_id (name=3D<optimized out>) at .=
./../../lttng-tools-2.10.6/src/common/utils.c:1241
> 7  0x000000000042dee4 in notification_channel_socket_create () at ../../.=
./../lttng-tools-2.10.6/src/bin/lttng-sessiond/notification-thread.c:238
> 8  init_thread_state (state=3D0x7f5abaef5560, handle=3D0x7f5abbf9be40) at=
 ../../../../lttng-tools-2.10.6/src/bin/lttng-sessiond/notification-thread.=
c:375
> 9  thread_notification (data=3D0x7f5abbf9be40) at ../../../../lttng-tools=
-2.10.6/src/bin/lttng-sessiond/notification-thread.c:495
> 10 0x00007f5abc22e541 in start (p=3D<optimized out>) at src/thread/pthrea=
d_create.c:195
> 11 0x00007f5abc23b661 in __clone () at src/thread/x86_64/clone.s:22
> =

> The problem was easily reproducible (~6 crash on ~300 runs). A prototype =
fix
> using mutex around the getgrnam yielded no crash in over 1000 runs. This
> patch yielded the same results as the prototype fix.
> =

> Unfortunately we cannot rely on a mutex in liblttng-ctl since we cannot
> enforce the locking for the application using the lib.
> =

> Use getgrnam_r instead.
> =

> The previous implementation of utils_get_group_id returned the gid of
> the root group (0) on error/not found. lttng_check_tracing_group needs
> to know if an error/not found occured, returning the root group is not
> enough. We now return the gid via the passed parameter. The caller is
> responsible for either defaulting to the root group or propagating the
> error.
> =

> We also do not want to warn when used in liblttng-ctl context. We might
> want to move the warning elsewhere in the future. For now, pass a bool
> if we need to warn or not.
> =

> Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
> ---
>  src/bin/lttng-consumerd/health-consumerd.c   | 10 ++-
>  src/bin/lttng-relayd/health-relayd.c         | 20 ++++--
>  src/bin/lttng-sessiond/health.c              | 10 ++-
>  src/bin/lttng-sessiond/main.c                | 14 +++-
>  src/bin/lttng-sessiond/notification-thread.c | 10 ++-
>  src/common/utils.c                           | 75 +++++++++++++++++---
>  src/common/utils.h                           |  4 +-
>  src/lib/lttng-ctl/lttng-ctl.c                |  8 +--
>  8 files changed, 122 insertions(+), 29 deletions(-)
> =

> diff --git a/src/bin/lttng-consumerd/health-consumerd.c b/src/bin/lttng-c=
onsumerd/health-consumerd.c
> index 1e2f31e48..6045401a4 100644
> --- a/src/bin/lttng-consumerd/health-consumerd.c
> +++ b/src/bin/lttng-consumerd/health-consumerd.c
> @@ -184,8 +184,14 @@ void *thread_manage_health(void *data)
>  	is_root =3D !getuid();
>  	if (is_root) {
>  		/* lttng health client socket path permissions */
> -		ret =3D chown(health_unix_sock_path, 0,
> -				utils_get_group_id(tracing_group_name));
> +		gid_t gid;
> +
> +		ret =3D utils_get_group_id(tracing_group_name, true, &gid);
> +		if (ret) {
> +			gid =3D 0; /* Default to root group. */
> +		}
> +
> +		ret =3D chown(health_unix_sock_path, 0, gid);
>  		if (ret < 0) {
>  			ERR("Unable to set group on %s", health_unix_sock_path);
>  			PERROR("chown");
> diff --git a/src/bin/lttng-relayd/health-relayd.c b/src/bin/lttng-relayd/=
health-relayd.c
> index ba996621b..962e88c47 100644
> --- a/src/bin/lttng-relayd/health-relayd.c
> +++ b/src/bin/lttng-relayd/health-relayd.c
> @@ -105,8 +105,14 @@ static int create_lttng_rundir_with_perm(const char =
*rundir)
>  		int is_root =3D !getuid();
>  =

>  		if (is_root) {
> -			ret =3D chown(rundir, 0,
> -					utils_get_group_id(tracing_group_name));
> +			gid_t gid;
> +
> +			ret =3D utils_get_group_id(tracing_group_name, true, &gid);
> +			if (ret) {
> +				gid =3D 0; /* Default to root group.*/
> +			}
> +
> +			ret =3D chown(rundir, 0, gid);
>  			if (ret < 0) {
>  				ERR("Unable to set group on %s", rundir);
>  				PERROR("chown");
> @@ -256,8 +262,14 @@ void *thread_manage_health(void *data)
>  	is_root =3D !getuid();
>  	if (is_root) {
>  		/* lttng health client socket path permissions */
> -		ret =3D chown(health_unix_sock_path, 0,
> -				utils_get_group_id(tracing_group_name));
> +		gid_t gid;
> +
> +		ret =3D utils_get_group_id(tracing_group_name, true, &gid);
> +		if (ret) {
> +			gid =3D 0; /* Default to root group */
> +		}
> +
> +		ret =3D chown(health_unix_sock_path, 0, gid);
>  		if (ret < 0) {
>  			ERR("Unable to set group on %s", health_unix_sock_path);
>  			PERROR("chown");
> diff --git a/src/bin/lttng-sessiond/health.c b/src/bin/lttng-sessiond/hea=
lth.c
> index 921b45261..9e639837b 100644
> --- a/src/bin/lttng-sessiond/health.c
> +++ b/src/bin/lttng-sessiond/health.c
> @@ -95,8 +95,14 @@ static void *thread_manage_health(void *data)
>  =

>  	if (is_root) {
>  		/* lttng health client socket path permissions */
> -		ret =3D chown(config.health_unix_sock_path.value, 0,
> -				utils_get_group_id(config.tracing_group_name.value));
> +		gid_t gid;
> +
> +		ret =3D utils_get_group_id(config.tracing_group_name.value, true, &gid=
);
> +		if (ret) {
> +			gid =3D 0; /* Default to root group. */
> +		}
> +
> +		ret =3D chown(config.health_unix_sock_path.value, 0, gid);
>  		if (ret < 0) {
>  			ERR("Unable to set group on %s", config.health_unix_sock_path.value);
>  			PERROR("chown");
> diff --git a/src/bin/lttng-sessiond/main.c b/src/bin/lttng-sessiond/main.c
> index 24855b976..1cbd3c14c 100644
> --- a/src/bin/lttng-sessiond/main.c
> +++ b/src/bin/lttng-sessiond/main.c
> @@ -1023,7 +1023,10 @@ static int set_permissions(char *rundir)
>  	int ret;
>  	gid_t gid;
>  =

> -	gid =3D utils_get_group_id(config.tracing_group_name.value);
> +	ret =3D utils_get_group_id(config.tracing_group_name.value, true, &gid);
> +	if (ret) {
> +		gid =3D 0; /* Default to root group */
> +	}
>  =

>  	/* Set lttng run dir */
>  	ret =3D chown(rundir, 0, gid);
> @@ -1134,7 +1137,14 @@ static int set_consumer_sockets(struct consumer_da=
ta *consumer_data)
>  		goto error;
>  	}
>  	if (is_root) {
> -		ret =3D chown(path, 0, utils_get_group_id(config.tracing_group_name.va=
lue));
> +		gid_t gid;
> +
> +		ret =3D utils_get_group_id(config.tracing_group_name.value, true, &gid=
);
> +		if (ret) {
> +			gid =3D 0; /* Default to root group */
> +		}
> +
> +		ret =3D chown(path, 0, gid);
>  		if (ret < 0) {
>  			ERR("Unable to set group on %s", path);
>  			PERROR("chown");
> diff --git a/src/bin/lttng-sessiond/notification-thread.c b/src/bin/lttng=
-sessiond/notification-thread.c
> index b42b282e1..5a625eb3c 100644
> --- a/src/bin/lttng-sessiond/notification-thread.c
> +++ b/src/bin/lttng-sessiond/notification-thread.c
> @@ -239,8 +239,14 @@ int notification_channel_socket_create(void)
>  	}
>  =

>  	if (getuid() =3D=3D 0) {
> -		ret =3D chown(sock_path, 0,
> -				utils_get_group_id(config.tracing_group_name.value));
> +		gid_t gid;
> +
> +		ret =3D  utils_get_group_id(config.tracing_group_name.value, true, &gi=
d);
> +		if (ret) {
> +			gid =3D 0; /* Default to root group. */
> +		}
> +
> +		ret =3D chown(sock_path, 0, gid);
>  		if (ret) {
>  			ERR("Failed to set the notification channel socket's group");
>  			ret =3D -1;
> diff --git a/src/common/utils.c b/src/common/utils.c
> index 4c000e9b4..c79906a29 100644
> --- a/src/common/utils.c
> +++ b/src/common/utils.c
> @@ -1477,24 +1477,77 @@ size_t utils_get_current_time_str(const char *for=
mat, char *dst, size_t len)
>  }
>  =

>  /*
> - * Return the group ID matching name, else 0 if it cannot be found.
> + * Return 0 on success and set *gid to the group_ID matching the passed =
name.
> + * Else -1 if it cannot be found or an error occurred.
>   */
>  LTTNG_HIDDEN
> -gid_t utils_get_group_id(const char *name)
> +int utils_get_group_id(const char *name, bool warn, gid_t *gid)
>  {
> -	struct group *grp;
> +	static volatile int warn_once;
>  =

> -	grp =3D getgrnam(name);
> -	if (!grp) {
> -		static volatile int warn_once;
> +	int ret;
> +	long sys_len;
> +	size_t len;
> +	struct group grp;
> +	struct group *result;
> +	char *buffer =3D NULL;
>  =

> -		if (!warn_once) {
> -			WARN("No tracing group detected");
> -			warn_once =3D 1;
> +	/* Get the system limit if it exists */
> +	sys_len =3D sysconf(_SC_GETGR_R_SIZE_MAX);
> +	if (sys_len =3D=3D -1) {
> +		len =3D 1024;
> +	} else {
> +		len =3D (size_t) sys_len;
> +	}
> +
> +	buffer =3D malloc(len);
> +	if (!buffer) {
> +		PERROR("getgrnam_r malloc");
> +		ret =3D -1;
> +		goto error;
> +	}
> +
> +	while ((ret =3D getgrnam_r(name, &grp, buffer, len, &result)) =3D=3D ER=
ANGE)
> +	{
> +		/* Buffer is not big enough, increase its size. */
> +		size_t new_len =3D 2 * len;
> +		char *new_buffer =3D NULL;
> +		if (new_len < len) {
> +			ERR("getgrnam_r buffer size overflow");
> +			ret =3D -1;
> +			goto error;
> +		}
> +		len =3D new_len;
> +		new_buffer =3D realloc(buffer, len);
> +		if (!new_buffer) {
> +			PERROR("getgrnam_r realloc");
> +			ret =3D -1;
> +			goto error;
>  		}
> -		return 0;
> +		buffer =3D new_buffer;
> +	}
> +	if (ret !=3D 0) {
> +		PERROR("getgrnam_r");
> +		ret =3D -1;
> +		goto error;
> +	}
> +
> +	/* Group not found. */
> +	if (!result) {
> +		ret =3D -1;
> +		goto error;
> +	}
> +
> +	*gid =3D result->gr_gid;
> +	ret =3D 0;
> +
> +error:
> +	free(buffer);
> +	if (ret && warn && !warn_once) {
> +		WARN("No tracing group detected");
> +		warn_once =3D 1;
>  	}
> -	return grp->gr_gid;
> +	return ret;
>  }
>  =

>  /*
> diff --git a/src/common/utils.h b/src/common/utils.h
> index 9e3fa60cd..9dc447378 100644
> --- a/src/common/utils.h
> +++ b/src/common/utils.h
> @@ -22,6 +22,8 @@
>  #include <unistd.h>
>  #include <stdint.h>
>  #include <getopt.h>
> +#include <stdbool.h>
> +#include <sys/types.h>
>  =

>  #define KIBI_LOG2 10
>  #define MEBI_LOG2 20
> @@ -54,7 +56,7 @@ int utils_get_count_order_u64(uint64_t x);
>  char *utils_get_home_dir(void);
>  char *utils_get_user_home_dir(uid_t uid);
>  size_t utils_get_current_time_str(const char *format, char *dst, size_t =
len);
> -gid_t utils_get_group_id(const char *name);
> +int utils_get_group_id(const char *name, bool warn, gid_t *gid);
>  char *utils_generate_optstring(const struct option *long_options,
>  		size_t opt_count);
>  int utils_create_lock_file(const char *filepath);
> diff --git a/src/lib/lttng-ctl/lttng-ctl.c b/src/lib/lttng-ctl/lttng-ctl.c
> index 165fef4dc..403aa092b 100644
> --- a/src/lib/lttng-ctl/lttng-ctl.c
> +++ b/src/lib/lttng-ctl/lttng-ctl.c
> @@ -241,15 +241,13 @@ end:
>  LTTNG_HIDDEN
>  int lttng_check_tracing_group(void)
>  {
> -	struct group *grp_tracing;	/* no free(). See getgrnam(3) */
> -	gid_t *grp_list;
> +	gid_t *grp_list, tracing_gid;
>  	int grp_list_size, grp_id, i;
>  	int ret =3D -1;
>  	const char *grp_name =3D tracing_group;
>  =

>  	/* Get GID of group 'tracing' */
> -	grp_tracing =3D getgrnam(grp_name);
> -	if (!grp_tracing) {
> +	if (utils_get_group_id(grp_name, false, &tracing_gid)) {
>  		/* If grp_tracing is NULL, the group does not exist. */
>  		goto end;
>  	}
> @@ -274,7 +272,7 @@ int lttng_check_tracing_group(void)
>  	}
>  =

>  	for (i =3D 0; i < grp_list_size; i++) {
> -		if (grp_list[i] =3D=3D grp_tracing->gr_gid) {
> +		if (grp_list[i] =3D=3D tracing_gid) {
>  			ret =3D 1;
>  			break;
>  		}
> -- =

> 2.17.1
> =
