From: David Goulet <dgoulet@efficios.com>
Subject: Re: [PATCH lttng-tools 09/14] Added ashmem framework
 support for ust apps and sessiond
Date: Mon, 06 May 2013 15:21:59 -0400
Message-ID: <518802D7.4080803__43318.0820699365$1367868161$gmane$org@efficios.com>
References: <1367864331-15212-1-git-send-email-charlesbriere.flatzo@gmail.com>
	<1367864331-15212-9-git-send-email-charlesbriere.flatzo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([5.9.158.244])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1UZQz9-0000w7-4l
	for lttng-dev@lists.lttng.org; Mon, 06 May 2013 15:22:07 -0400
In-Reply-To: <1367864331-15212-9-git-send-email-charlesbriere.flatzo@gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Charles Briere <charlesbriere.flatzo@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

I'm wondering here if it's possible to make a compat layer for SHM. We
*really* try to avoid #ifdef/#endif inside functions. This is basically
what the compat layer was made for.

Here maybe you could create a lttng_shm_open() (and other calls) wrapper
that uses a compat call based on the OS.

Charles Briere:
> From: Pierre-Luc St-Charles <pierre-luc.st-charles@polymtl.ca>
> 
> Signed-off-by: Pierre-Luc St-Charles <pierre-luc.st-charles@polymtl.ca>
> ---
>  src/bin/lttng-consumerd/lttng-consumerd.c |  6 +++
>  src/bin/lttng-sessiond/shm.c              | 75 +++++++++++++++++++++++++++++++
>  src/bin/lttng-sessiond/shm.h              | 16 +++++++
>  3 files changed, 97 insertions(+)
> 
> diff --git a/src/bin/lttng-consumerd/lttng-consumerd.c b/src/bin/lttng-consumerd/lttng-consumerd.c
> index edf1f15..cbd610c 100644
> --- a/src/bin/lttng-consumerd/lttng-consumerd.c
> +++ b/src/bin/lttng-consumerd/lttng-consumerd.c
> @@ -28,7 +28,11 @@
>  #include <string.h>
>  #include <sys/ipc.h>
>  #include <sys/resource.h>
> +#ifdef __ANDROID__
> +#include <linux/shm.h>
> +#else
>  #include <sys/shm.h>
> +#endif
>  #include <sys/socket.h>
>  #include <sys/stat.h>
>  #include <sys/types.h>
> @@ -39,7 +43,9 @@
>  #include <assert.h>
>  #include <config.h>
>  #include <urcu/compiler.h>
> +#ifndef __ANDROID__
>  #include <ulimit.h>
> +#endif
>  
>  #include <common/defaults.h>
>  #include <common/common.h>
> diff --git a/src/bin/lttng-sessiond/shm.c b/src/bin/lttng-sessiond/shm.c
> index b94f4eb..80c7b6f 100644
> --- a/src/bin/lttng-sessiond/shm.c
> +++ b/src/bin/lttng-sessiond/shm.c
> @@ -41,6 +41,8 @@
>  static int get_wait_shm(char *shm_path, size_t mmap_size, int global)
>  {
>  	int wait_shm_fd, ret;
> +
> +#ifndef __ANDROID__
>  	mode_t mode;
>  
>  	assert(shm_path);
> @@ -114,6 +116,23 @@ static int get_wait_shm(char *shm_path, size_t mmap_size, int global)
>  	}
>  #else
>  #warning "FreeBSD does not support setting file mode on shm FD. Remember that for secure use, lttng-sessiond should be started before applications linked on lttng-ust."
> +#endif // !__ANDROID__
> +#else
> +    /*
> +    * For ashmem, we must directly specify the ammount of mem we will need;
> +    * also, once the memory region is opened, nobody can directly reopen or
> +    * refer to it via its path (only via its fd).
> +    */
> +    wait_shm_fd = ashmem_create_region(shm_path, mmap_size);
> +    if (wait_shm_fd < 0) {
> +        PERROR("shm_open wait shm [ashmem_create_region]");
> +        goto error;
> +    }
> +    ret = ashmem_set_prot_region(wait_shm_fd, PROT_READ | PROT_WRITE);
> +    if (ret < 0) {
> +        PERROR("shm_open wait shm [ashmem_create_region, ASHMEM_SET_NAME]");
> +        goto error;
> +    }
>  #endif
>  
>  	DBG("Got the wait shm fd %d", wait_shm_fd);
> @@ -166,3 +185,59 @@ char *shm_ust_get_mmap(char *shm_path, int global)
>  error:
>  	return NULL;
>  }
> +
> +#ifdef __ANDROID__
> +#ifdef _CUTILS_ASHMEM_NO_NDK_H
> +#include <linux/ashmem.h>
> +#define ASHMEM_DEVICE "/dev/ashmem"

Document this function with at least the possible returned values.

> +int ashmem_create_region(const char *name, size_t size)
> +{
> +    int fd, ret;
> +
> +    fd = open(ASHMEM_DEVICE, O_RDWR);
> +    if (fd < 0)
> +        return fd;

Add {} for the if statement and you should make a goto error_open that
goes just after the close(fd) and return ret = -1. If you use gotos in
your function, it's important to use them for all error path and not
having both return and goto making the code more difficult to follow and
prone to errors in the long term if this code changes for instance. (mem
leaks, fd leaks, etc...).

> +
> +    if (name) {
> +        char buf[ASHMEM_NAME_LEN];
> +
> +        strlcpy(buf, name, sizeof(buf));
> +        ret = ioctl(fd, ASHMEM_SET_NAME, buf);
> +        if (ret < 0)
> +            goto error;

Add {} and add a PERROR() here so we can track why this fails in verbose
mode.

> +    }
> +
> +    ret = ioctl(fd, ASHMEM_SET_SIZE, size);
> +    if (ret < 0)
> +        goto error;

Same.

> +
> +    return fd;
> +
> +error:
> +    close(fd);
> +    return ret;
> +}
> +
> +int ashmem_set_prot_region(int fd, int prot)
> +{
> +    return ioctl(fd, ASHMEM_SET_PROT_MASK, prot);
> +}
> +
> +int ashmem_pin_region(int fd, size_t offset, size_t len)
> +{
> +    struct ashmem_pin pin = { offset, len };
> +    return ioctl(fd, ASHMEM_PIN, &pin);
> +}
> +
> +int ashmem_unpin_region(int fd, size_t offset, size_t len)
> +{
> +    struct ashmem_pin pin = { offset, len };
> +    return ioctl(fd, ASHMEM_UNPIN, &pin);
> +}
> +
> +int ashmem_get_size_region(int fd)
> +{
> +    return ioctl(fd, ASHMEM_GET_SIZE, NULL);
> +}
> +#endif //_CUTILS_ASHMEM_NO_NDK_H
> +#endif //__ANDROID__
> diff --git a/src/bin/lttng-sessiond/shm.h b/src/bin/lttng-sessiond/shm.h
> index bcce28b..abe965e 100644
> --- a/src/bin/lttng-sessiond/shm.h
> +++ b/src/bin/lttng-sessiond/shm.h
> @@ -21,4 +21,20 @@
>  
>  char *shm_ust_get_mmap(char *shm_path, int global);
>  
> +#ifdef __ANDROID__
> +/*
> + * Temporary fix for missing ashmem references when compiling with the NDK
> + * (instead of trying to port via Android makefiles)
> + */
> +#ifndef _CUTILS_ASHMEM_H
> +#define _CUTILS_ASHMEM_H
> +#define _CUTILS_ASHMEM_NO_NDK_H
> +int ashmem_create_region(const char *name, size_t size);
> +int ashmem_set_prot_region(int fd, int prot);
> +int ashmem_pin_region(int fd, size_t offset, size_t len);
> +int ashmem_unpin_region(int fd, size_t offset, size_t len);
> +int ashmem_get_size_region(int fd);
> +#endif //_CUTILS_ASHMEM_H
> +#endif //__ANDROID__
> +
>  #endif /* _LTT_SHM_H */
