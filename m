From: Lai Jiangshan <laijs@cn.fujitsu.com>
Subject: Re: urcu rfc: privatize urcu/futex.h
Date: Wed, 08 Aug 2012 09:03:49 +0800
Message-ID: <5021BAF5.4080507__30799.6103926145$1344387800$gmane$org@cn.fujitsu.com>
References: <5020DBFF.3020702@cn.fujitsu.com> <20120807140616.GA29280@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <laijs@cn.fujitsu.com>) id 1Syufl-0002L7-2r
	for lttng-dev@lists.lttng.org; Tue, 07 Aug 2012 21:02:53 -0400
In-Reply-To: <20120807140616.GA29280@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-Id: lttng-dev@lists.lttng.org

On 08/07/2012 10:06 PM, Mathieu Desnoyers wrote:
> Hi Lai,
> 
> * Lai Jiangshan (laijs@cn.fujitsu.com) wrote:
>> futex.h is in urcu/, it means it can be used by users out of the library.
>>
>> But
>>
>> If the user's system has futex, he should use #include <linux/futex.h>.
>> If the user's system don't have futex, it is not good that if the user
>> use this compat_futex.
>>
>> Because the compat_futex_async()'s behavior is different from the
>> futex in linux.  If the caller don't change the value of @uaddr, the
>> futex(FUTEX_WAKE) in linux can also wake a thread, but
>> compat_futex_async() don't.  (I guess no one use this behavior, but if
>> there are someone, we give them a wrong thing)
> 
> Hrm, passing a NULL uaddr parameter is really not the targeted use-case.
> We could probably just document that uaddr should not be NULL when using
> compat_futex ?

Sorry, I wanted to show you such un-normal behavior:

/* keep the value of *uaddr unchanged, wake up a thread to do something */
futex(FUTEX_WAKE, uaddr, ...).

This can't not wake up any thread for current compat_futex_async() implement.
But the sys_futex() can.
