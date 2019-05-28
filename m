From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [lttng-ust RFC v2] Add setuid wrapper for per-UID
 buffers
Date: Tue, 28 May 2019 11:24:20 -0400 (EDT)
Message-ID: <2016516752.15887.1559057060068.JavaMail.zimbra__12562.6566283003$1559057088$gmane$org@efficios.com>
References: <20190522154855.20846-1-gabriel.pollo-guilbert@efficios.com>
 <641634709.7665.1558542262099.JavaMail.zimbra@efficios.com>
 <14935434.8382.1558557526205.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 45CyLh6VK0z12MC
 for <lttng-dev@lists.lttng.org>; Tue, 28 May 2019 11:24:28 -0400 (EDT)
In-Reply-To: <14935434.8382.1558557526205.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Gabriel-Andrew Pollo-Guilbert <gabriel.pollo-guilbert@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

----- On May 22, 2019, at 4:38 PM, Gabriel-Andrew Pollo-Guilbert gabriel.pollo-guilbert@efficios.com wrote:

> After reading some man pages (mainly credentials(7) and capabilities(7)), I've
> come to the conclusion that the definition of a "user" is kind of unclear.
> 
> RUID and EUID are pretty much the same, except that when a process wants to
> drop its previlieges temporarily, it only needs to change the EUID. Usually,
> a process will use the value saved in SUID to regain the original previlieges.

OK, so permission-wise, if the process can "regain" prior privileged, we don't
care if it still has access to the ring buffers of that UID.

> 
> As of right now, the per-UID buffers are created using getuid(3) which returns
> the __real__ user ID (RUID).
> 
> setfsuid(2): may change FSUID, not RUID, same buffers would be used after
> seteuid(2): may change EUID, not RUID, same behavior
> setuid(2): may change RUID, EUID and SUID, the should be a wrapper
> setreuid(2): may change RUID and EUID, there should be a wrapper
> setresuid(2): may change RUID, EUID and SUID, the should be a wrapper
> 
> That said, I don't know if `per-RUID` buffers is the actual behavior we want.
> Lots of application only changes EUID in order to drop previlieges.

Yes, but if they change EUID, AFAIU they can change their EUID back as
long as they keep the same RUID, right ? And it would seem to be natural
to quickly go back-and-forth between EUID, so we don't want to hurt performance
of that use-case too much.

So it would seem appropriate to only track changes of real user ID (RUID).

> 
> On a side note, I can also add a check in the wrappers so that if the RUID
> doesn't change, we don't re-register the application for nothing. Sounds good?

Sure, it works for me!

Thanks,

Mathieu


> 
> ----- Original Message -----
> From: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
> To: "Gabriel-Andrew Pollo-Guilbert" <gabriel.pollo-guilbert@efficios.com>
> Cc: "lttng-dev" <lttng-dev@lists.lttng.org>
> Sent: Wednesday, May 22, 2019 12:24:22 PM
> Subject: Re: [lttng-dev] [lttng-ust RFC v2] Add setuid wrapper for per-UID
> buffers
> 
> ----- On May 22, 2019, at 11:48 AM, Gabriel-Andrew Pollo-Guilbert
> gabriel.pollo-guilbert@efficios.com wrote:
> 
>> In case of a per-UID buffer, events following a setuid() call should be
>> forwarded to buffers of the new UID. In order to do so, we add a wrapper around
>> setuid() that unregister and re-register the application from the session
>> daemon.
> 
> SETUID(2)
> 
> SEE ALSO
> [...]
> seteuid(2), setfsuid(2), setreuid(2)
> 
> and:
> 
> setresuid(2)
> 
> What should we do about those ? What's the policy we want ?
> 
> Considering that lttng-ust can be used on BSD systems, we may also want
> to check the semantic there.
> 
> Thanks,
> 
> Mathieu
> 
>> 
>> Signed-off-by: Gabriel-Andrew Pollo-Guilbert
>> <gabriel.pollo-guilbert@efficios.com>
>> ---
>> Makefile.am                     |  1 +
>> configure.ac                    |  1 +
>> doc/man/lttng-ust.3.txt         | 11 ++++++++
>> include/lttng/ust.h             |  1 +
>> liblttng-ust-setuid/Makefile.am | 10 +++++++
>> liblttng-ust-setuid/ustsetuid.c | 47 +++++++++++++++++++++++++++++++++
>> liblttng-ust/lttng-ust-comm.c   | 29 ++++++++++++++++++--
>> 7 files changed, 98 insertions(+), 2 deletions(-)
>> create mode 100644 liblttng-ust-setuid/Makefile.am
>> create mode 100644 liblttng-ust-setuid/ustsetuid.c
>> 
>> diff --git a/Makefile.am b/Makefile.am
>> index 810761ca..e8812e59 100644
>> --- a/Makefile.am
>> +++ b/Makefile.am
>> @@ -5,6 +5,7 @@ SUBDIRS = . include snprintf libringbuffer liblttng-ust-comm \
>> 		liblttng-ust-ctl \
>> 		liblttng-ust-fd \
>> 		liblttng-ust-fork \
>> +		liblttng-ust-setuid \
>> 		liblttng-ust-libc-wrapper \
>> 		liblttng-ust-cyg-profile \
>> 		tools
>> diff --git a/configure.ac b/configure.ac
>> index 52fc3f68..95780dba 100644
>> --- a/configure.ac
>> +++ b/configure.ac
>> @@ -522,6 +522,7 @@ AC_CONFIG_FILES([
>> 	liblttng-ust/Makefile
>> 	liblttng-ust-ctl/Makefile
>> 	liblttng-ust-fork/Makefile
>> +	liblttng-ust-setuid/Makefile
>> 	liblttng-ust-dl/Makefile
>> 	liblttng-ust-fd/Makefile
>> 	liblttng-ust-java/Makefile
>> diff --git a/doc/man/lttng-ust.3.txt b/doc/man/lttng-ust.3.txt
>> index 5c9c9f5d..b252c11d 100644
>> --- a/doc/man/lttng-ust.3.txt
>> +++ b/doc/man/lttng-ust.3.txt
>> @@ -744,6 +744,17 @@ library before you start the application. Typical use cases
>> include
>> daemons closing all file descriptors after man:fork(2), and buggy
>> applications doing ``double-closes''.
>> 
>> +Using LTTng-UST with applications that change user
>> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> +If your application is traced using per-UID buffers and changes user ID using
>> +man:setuid(2), the library `liblttng-ust-setuid.so` needs to be preloaded
>> +before starting the application with the `LD_PRELOAD` environment variable (see
>> +man:ld.so(8)). This way, events generated after the UID change will be fowarded
>> +to the correct buffer.
>> +
>> +This workaround requires that the tracing session be global (root
>> +lttng-sessiond) in order to avoid permission problems between a session
>> +daemon started by another user.
>> 
>> Context information
>> ~~~~~~~~~~~~~~~~~~~
>> diff --git a/include/lttng/ust.h b/include/lttng/ust.h
>> index 2779d7a7..5495e564 100644
>> --- a/include/lttng/ust.h
>> +++ b/include/lttng/ust.h
>> @@ -32,6 +32,7 @@ extern "C" {
>> extern void ust_before_fork(sigset_t *save_sigset);
>> extern void ust_after_fork_parent(sigset_t *restore_sigset);
>> extern void ust_after_fork_child(sigset_t *restore_sigset);
>> +extern void ust_after_setuid(void);
>> 
>> #ifdef __cplusplus
>> }
>> diff --git a/liblttng-ust-setuid/Makefile.am b/liblttng-ust-setuid/Makefile.am
>> new file mode 100644
>> index 00000000..df3cd622
>> --- /dev/null
>> +++ b/liblttng-ust-setuid/Makefile.am
>> @@ -0,0 +1,10 @@
>> +AM_CPPFLAGS = -I$(top_srcdir)/include
>> +AM_CFLAGS += -fno-strict-aliasing
>> +
>> +lib_LTLIBRARIES = liblttng-ust-setuid.la
>> +liblttng_ust_setuid_la_SOURCES = ustsetuid.c
>> +liblttng_ust_setuid_la_LIBADD = \
>> +	$(top_builddir)/liblttng-ust/liblttng-ust.la \
>> +	$(DL_LIBS)
>> +
>> +liblttng_ust_setuid_la_CFLAGS = -DUST_COMPONENT=liblttng-ust-setuid
>> $(AM_CFLAGS)
>> diff --git a/liblttng-ust-setuid/ustsetuid.c b/liblttng-ust-setuid/ustsetuid.c
>> new file mode 100644
>> index 00000000..8cae9a43
>> --- /dev/null
>> +++ b/liblttng-ust-setuid/ustsetuid.c
>> @@ -0,0 +1,47 @@
>> +/*
>> + * Copyright (C) 2019 Gabriel-Andrew Pollo-Guilbert
>> + *
>> + * This library is free software; you can redistribute it and/or
>> + * modify it under the terms of the GNU Lesser General Public
>> + * License as published by the Free Software Foundation; version 2.1 of
>> + * the License.
>> + *
>> + * This library is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
>> + * Lesser General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU Lesser General Public
>> + * License along with this library; if not, write to the Free Software
>> + * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301
>> USA
>> + */
>> +
>> +#define _GNU_SOURCE
>> +#include <unistd.h>
>> +#include <errno.h>
>> +#include <stdio.h>
>> +#include <lttng/ust-dlfcn.h>
>> +#include <lttng/ust.h>
>> +
>> +int setuid(uid_t uid)
>> +{
>> +	static int (*plibc_func)(uid_t) = NULL;
>> +	int retval;
>> +
>> +	if (plibc_func == NULL) {
>> +		plibc_func = dlsym(RTLD_NEXT, "setuid");
>> +		if (plibc_func == NULL) {
>> +			fprintf(stderr, "libustsetuid: unable to find \"setuid\" symbol\n");
>> +			errno = ENOSYS;
>> +			return -1;
>> +		}
>> +	}
>> +
>> +	retval = plibc_func(uid);
>> +	if (retval < 0)
>> +		return retval;
>> +
>> +	ust_after_setuid();
>> +
>> +	return retval;
>> +}
>> diff --git a/liblttng-ust/lttng-ust-comm.c b/liblttng-ust/lttng-ust-comm.c
>> index 61dbb41b..0d0b9eb4 100644
>> --- a/liblttng-ust/lttng-ust-comm.c
>> +++ b/liblttng-ust/lttng-ust-comm.c
>> @@ -225,10 +225,12 @@ void ust_unlock(void)
>>  *   daemon problems).
>>  */
>> static sem_t constructor_wait;
>> +
>> /*
>>  * Doing this for both the global and local sessiond.
>>  */
>> -static int sem_count = { 2 };
>> +#define LTTNG_UST_INIT_SEM_COUNT 2
>> +static int sem_count = { LTTNG_UST_INIT_SEM_COUNT };
>> 
>> /*
>>  * Counting nesting within lttng-ust. Used to ensure that calling fork()
>> @@ -1922,7 +1924,7 @@ void lttng_ust_cleanup(int exiting)
>> 	exit_tracepoint();
>> 	if (!exiting) {
>> 		/* Reinitialize values for fork */
>> -		sem_count = 2;
>> +		sem_count = LTTNG_UST_INIT_SEM_COUNT;
>> 		lttng_ust_comm_should_quit = 0;
>> 		initialized = 0;
>> 	}
>> @@ -2072,3 +2074,26 @@ void lttng_ust_sockinfo_session_enabled(void *owner)
>> 	struct sock_info *sock_info = owner;
>> 	sock_info->statedump_pending = 1;
>> }
>> +
>> +/*
>> + * Re-register the application when changing user ID. This is especially
>> + * important for per-UID buffers. It is not strictly needed for per-PID
>> + * buffers, but a slight extra overhead when changing user ID is considered
>> + * harmless for a relatively infrequent operation.
>> + */
>> +void ust_after_setuid(void)
>> +{
>> +	DBG("Unregistering the process");
>> +	lttng_ust_fixup_tls();
>> +	lttng_ust_exit();
>> +
>> +	sem_count = LTTNG_UST_INIT_SEM_COUNT;
>> +	lttng_ust_comm_should_quit = 0;
>> +	initialized = 0;
>> +
>> +	global_apps.wait_shm_mmap = NULL;
>> +	local_apps.wait_shm_mmap = NULL;
>> +
>> +	DBG("Registering the process under new UID=%u", getuid());
>> +	lttng_ust_init();
>> +}
>> --
>> 2.21.0
>> 
>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> 
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
