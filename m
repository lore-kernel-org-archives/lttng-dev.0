From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [RFC PATCH urcu] Fix: dynamic fallback to compat
 futex on sys_futex ENOSYS
Date: Sun, 13 Sep 2015 16:45:55 +0000 (UTC)
Message-ID: <1988019200.5748.1442162755472.JavaMail.zimbra__15133.5644921803$1442162819$gmane$org@efficios.com>
References: <1441982918-15047-1-git-send-email-mathieu.desnoyers@efficios.com>
 <20150913162906.GN4029@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1ZbAPq-0002Kq-Hg
 for lttng-dev@lists.lttng.org; Sun, 13 Sep 2015 12:46:13 -0400
In-Reply-To: <20150913162906.GN4029@linux.vnet.ibm.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

----- On Sep 13, 2015, at 12:29 PM, Paul E. McKenney paulmck@linux.vnet.ibm.com wrote:

> On Fri, Sep 11, 2015 at 10:48:38AM -0400, Mathieu Desnoyers wrote:
>> Some MIPS processors (e.g. Cavium Octeon II) dynamically check if the
>> CPU supports ll/sc within sys_futex, and return a ENOSYS errno if they
>> don't, even though the architecture implements sys_futex.
>> 
>> Handle this situation by always building the sys_futex compatibility
>> layer, and fall-back on it if sys_futex return a ENOSYS errno. This is
>> a tiny compat layer which adds very little space overhead.
>> 
>> This adds an unlikely branch on return from sys_futex, which should
>> not be an issue performance-wise (we've already taken a system call).
>> 
>> Since this is a fall-back mode, don't try to be clever, and don't cache
>> the result, so that the common cases (architectures with a properly
>> working sys_futex) don't get two conditional branches, just one.
> 
> Looks like a reasonable approach to me.
> 
> Acked-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

Merged into master, stable-0.8 and stable-0.7,

Thanks!

Mathieu

> 
>> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>> CC: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
>> CC: Michael Jeanson <mjeanson@efficios.com>
>> CC: Jon Bernard <jbernard@debian.org>
>> ---
>>  Makefile.am  |  2 --
>>  urcu/futex.h | 70 +++++++++++++++++++++++++++++++++++++++++++++++++-----------
>>  2 files changed, 57 insertions(+), 15 deletions(-)
>> 
>> diff --git a/Makefile.am b/Makefile.am
>> index 752510d..f9a8888 100644
>> --- a/Makefile.am
>> +++ b/Makefile.am
>> @@ -41,9 +41,7 @@ else
>>  COMPAT=
>>  endif
>> 
>> -if COMPAT_FUTEX
>>  COMPAT+=compat_futex.c
>> -endif
>> 
>>  RCULFHASH = rculfhash.c rculfhash-mm-order.c rculfhash-mm-chunk.c \
>>  		rculfhash-mm-mmap.c
>> diff --git a/urcu/futex.h b/urcu/futex.h
>> index 2be3bb6..13d2b1a 100644
>> --- a/urcu/futex.h
>> +++ b/urcu/futex.h
>> @@ -47,22 +47,66 @@ extern "C" {
>>   * (returns EINTR).
>>   */
>> 
>> +extern int compat_futex_noasync(int32_t *uaddr, int op, int32_t val,
>> +		const struct timespec *timeout, int32_t *uaddr2, int32_t val3);
>> +extern int compat_futex_async(int32_t *uaddr, int op, int32_t val,
>> +		const struct timespec *timeout, int32_t *uaddr2, int32_t val3);
>> +
>>  #ifdef CONFIG_RCU_HAVE_FUTEX
>> +
>> +#include <unistd.h>
>> +#include <errno.h>
>> +#include <urcu/compiler.h>
>>  #include <urcu/syscall-compat.h>
>> -#define futex(...)	syscall(__NR_futex, __VA_ARGS__)
>> -#define futex_noasync(uaddr, op, val, timeout, uaddr2, val3)	\
>> -		futex(uaddr, op, val, timeout, uaddr2, val3)
>> -#define futex_async(uaddr, op, val, timeout, uaddr2, val3)	\
>> -		futex(uaddr, op, val, timeout, uaddr2, val3)
>> +
>> +static inline int futex(int32_t *uaddr, int op, int32_t val,
>> +		const struct timespec *timeout, int32_t *uaddr2, int32_t val3)
>> +{
>> +	return syscall(__NR_futex, uaddr, op, val, timeout,
>> +			uaddr2, val3);
>> +}
>> +
>> +static inline int futex_noasync(int32_t *uaddr, int op, int32_t val,
>> +		const struct timespec *timeout, int32_t *uaddr2, int32_t val3)
>> +{
>> +	int ret;
>> +
>> +	ret = futex(uaddr, op, val, timeout, uaddr2, val3);
>> +	if (caa_unlikely(ret < 0 && errno == ENOSYS)) {
>> +		return compat_futex_noasync(uaddr, op, val, timeout,
>> +				uaddr2, val3);
>> +	}
>> +	return ret;
>> +
>> +}
>> +
>> +static inline int futex_async(int32_t *uaddr, int op, int32_t val,
>> +		const struct timespec *timeout, int32_t *uaddr2, int32_t val3)
>> +{
>> +	int ret;
>> +
>> +	ret = futex(uaddr, op, val, timeout, uaddr2, val3);
>> +	if (caa_unlikely(ret < 0 && errno == ENOSYS)) {
>> +		return compat_futex_async(uaddr, op, val, timeout,
>> +				uaddr2, val3);
>> +	}
>> +	return ret;
>> +}
>> +
>>  #else
>> -extern int compat_futex_noasync(int32_t *uaddr, int op, int32_t val,
>> -	const struct timespec *timeout, int32_t *uaddr2, int32_t val3);
>> -#define futex_noasync(uaddr, op, val, timeout, uaddr2, val3)	\
>> -		compat_futex_noasync(uaddr, op, val, timeout, uaddr2, val3)
>> -extern int compat_futex_async(int32_t *uaddr, int op, int32_t val,
>> -	const struct timespec *timeout, int32_t *uaddr2, int32_t val3);
>> -#define futex_async(uaddr, op, val, timeout, uaddr2, val3)	\
>> -		compat_futex_async(uaddr, op, val, timeout, uaddr2, val3)
>> +
>> +static inline int futex_noasync(int32_t *uaddr, int op, int32_t val,
>> +		const struct timespec *timeout, int32_t *uaddr2, int32_t val3)
>> +{
>> +	return compat_futex_noasync(uaddr, op, val, timeout, uaddr2, val3);
>> +}
>> +
>> +static inline int futex_async(int32_t *uaddr, int op, int32_t val,
>> +		const struct timespec *timeout, int32_t *uaddr2, int32_t val3)
>> +{
>> +	return compat_futex_async(uaddr, op, val, timeout, uaddr2, val3);
>> +}
>> +
>>  #endif
>> 
>>  #ifdef __cplusplus
>> --
>> 2.1.4

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
