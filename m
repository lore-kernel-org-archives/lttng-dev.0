From: Lai Jiangshan <laijs@cn.fujitsu.com>
Subject: Re: [PATCH V2] urcu: avoid false sharing for rcu_gp_ctr
Date: Wed, 12 Dec 2012 17:58:55 +0800
Message-ID: <50C8555F.1030607__21689.6750884645$1355306402$gmane$org@cn.fujitsu.com>
References: <50C19575.2070802@cn.fujitsu.com> <20121207163234.GB11975@Krystal>
	<CACvQF50Y2wC3t=VMJ==574aHVvod+ipGA1K5hR97r_dRbcegkw@mail.gmail.com>
	<20121207165748.GA12338@Krystal>
	<CACvQF50V_9T6T3j4AwbdBuEiHHbcxdNGgP1WF5T4OHpXZyMgEA@mail.gmail.com>
	<20121207172252.GA12525@Krystal>
	<20121210150417.GR2516@linux.vnet.ibm.com>
	<20121210180111.GA11209@Krystal>
	<20121210234854.GK2516@linux.vnet.ibm.com>
	<50C6D2AB.9070100@cn.fujitsu.com> <20121211123802.GA4356@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <laijs@cn.fujitsu.com>) id 1Tij5k-0008IF-At
	for lttng-dev@lists.lttng.org; Wed, 12 Dec 2012 04:59:15 -0500
In-Reply-To: <20121211123802.GA4356@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Lai Jiangshan <eag0628@gmail.com>, "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, paulmck@linux.vnet.ibm.com
List-Id: lttng-dev@lists.lttng.org

On 12/11/2012 08:38 PM, Mathieu Desnoyers wrote:
> * Lai Jiangshan (laijs@cn.fujitsu.com) wrote:
>> From 66f50786b9d5f1bcf2ad56e3a9ab905005c6cd90 Mon Sep 17 00:00:00 2001
>> From: Lai Jiangshan <laijs@cn.fujitsu.com>
>> Date: Tue, 11 Dec 2012 14:24:44 +0800
>> Subject: [PATCH] urcu: avoid false sharing for rcu_gp_ctr
>>
>> @rcu_gp_ctr and @registry share the same cache line, it causes
>> false sharing and slowdown both of the read site and update site.
>>
>> Fix: Use different cache line for them.
>>
>> Although rcu_gp_futex is updated less than rcu_gp_ctr, but
>> they always be accessed at almost the same time, so we also move rcu_gp_futex
>> to the cacheline of rcu_gp_ctr to reduce the cacheline-usage or cache-missing
>> of read site.
>>
>> test: (4X6=24 CPUs)
>>
>> Before patch:
>>
>> [root@localhost userspace-rcu]# ./tests/test_urcu_mb 20 1 20
>> SUMMARY ./tests/test_urcu_mb      testdur   20 nr_readers  20 rdur      0 wdur      0 nr_writers   1 wdelay      0 nr_reads   2100285330 nr_writes      3390219 nr_ops   2103675549
>> [root@localhost userspace-rcu]# ./tests/test_urcu_mb 20 1 20
>> SUMMARY ./tests/test_urcu_mb      testdur   20 nr_readers  20 rdur      0 wdur      0 nr_writers   1 wdelay      0 nr_reads   1619868562 nr_writes      3529478 nr_ops   1623398040
>> [root@localhost userspace-rcu]# ./tests/test_urcu_mb 20 1 20
>> SUMMARY ./tests/test_urcu_mb      testdur   20 nr_readers  20 rdur      0 wdur      0 nr_writers   1 wdelay      0 nr_reads   1949067038 nr_writes      3469334 nr_ops   1952536372
>>
>> after patch:
>>
>> [root@localhost userspace-rcu]# ./tests/test_urcu_mb 20 1 20
>> SUMMARY ./tests/test_urcu_mb      testdur   20 nr_readers  20 rdur      0 wdur      0 nr_writers   1 wdelay      0 nr_reads   3380191848 nr_writes      4903248 nr_ops   3385095096
>> [root@localhost userspace-rcu]# ./tests/test_urcu_mb 20 1 20
>> SUMMARY ./tests/test_urcu_mb      testdur   20 nr_readers  20 rdur      0 wdur      0 nr_writers   1 wdelay      0 nr_reads   3397637486 nr_writes      4129809 nr_ops   3401767295
>>
>> Signed-off-by: Lai Jiangshan <laijs@cn.fujitsu.com>
>> ---
>>  Makefile.am              |   10 +++++-----
>>  compat_rcu_gp.lds        |   25 +++++++++++++++++++++++++
>>  compat_rcu_gp_bp.lds     |   24 ++++++++++++++++++++++++
>>  compat_rcu_gp_mb.lds     |   25 +++++++++++++++++++++++++
>>  compat_rcu_gp_qsbr.lds   |   25 +++++++++++++++++++++++++
>>  compat_rcu_gp_signal.lds |   25 +++++++++++++++++++++++++
>>  urcu-bp.c                |   14 ++++----------
>>  urcu-qsbr.c              |   35 +++++++++++++++--------------------
>>  urcu.c                   |   34 +++++++++++++---------------------
>>  urcu/map/urcu-bp.h       |    3 +--
>>  urcu/map/urcu-qsbr.h     |    3 +--
>>  urcu/map/urcu.h          |    9 +++------
>>  urcu/static/urcu-bp.h    |   23 ++++++++++++++---------
>>  urcu/static/urcu-qsbr.h  |   39 ++++++++++++++++++++++++---------------
>>  urcu/static/urcu.h       |   38 ++++++++++++++++++++++++--------------
>>  15 files changed, 228 insertions(+), 104 deletions(-)
>>  create mode 100644 compat_rcu_gp.lds
>>  create mode 100644 compat_rcu_gp_bp.lds
>>  create mode 100644 compat_rcu_gp_mb.lds
>>  create mode 100644 compat_rcu_gp_qsbr.lds
>>  create mode 100644 compat_rcu_gp_signal.lds
>>
>> diff --git a/Makefile.am b/Makefile.am
>> index 0a4d357..b2b7b6a 100644
>> --- a/Makefile.am
>> +++ b/Makefile.am
>> @@ -56,21 +56,21 @@ lib_LTLIBRARIES = liburcu-common.la \
>>  #
>>  liburcu_common_la_SOURCES = wfqueue.c wfcqueue.c wfstack.c $(COMPAT)
>>  
>> -liburcu_la_SOURCES = urcu.c urcu-pointer.c $(COMPAT)
>> +liburcu_la_SOURCES = urcu.c urcu-pointer.c compat_rcu_gp.lds $(COMPAT)
> 
> Hrm, I tried your patch with "make V=1", and have not found any use of
> those "lds" files. I'm not sure adding them as SOURCES is enough.

Use liburcu_mb_la_LDFLAGS = -Xlinker compat_rcu_gp_mb.lds instead!

Result(nm .libs/liburcu-mb.so):
00000000002046e0 D rcu_flavor_mb
0000000000204a80 D rcu_gp_ctr_mb
0000000000204a88 A rcu_gp_futex_mb
0000000000204c60 b rcu_gp_lock
0000000000204a80 D rcu_gp_mb


The type "A" makes me nervous, Do we expect this?

And a new problem:
liburcu.so is RCU_MB actually in my system,
but compat_rcu_gp.lds uses rcu_gp_memb(RCU_MEMBARRIER),
it can't work in my system, how to fix it?


> 
>>  liburcu_la_LIBADD = liburcu-common.la
>>  
>> -liburcu_qsbr_la_SOURCES = urcu-qsbr.c urcu-pointer.c $(COMPAT)
>> +liburcu_qsbr_la_SOURCES = urcu-qsbr.c urcu-pointer.c compat_rcu_gp_qsbr.lds $(COMPAT)
>>  liburcu_qsbr_la_LIBADD = liburcu-common.la
>>  
>> -liburcu_mb_la_SOURCES = urcu.c urcu-pointer.c $(COMPAT)
>> +liburcu_mb_la_SOURCES = urcu.c urcu-pointer.c compat_rcu_gp_mb.lds $(COMPAT)
>>  liburcu_mb_la_CFLAGS = -DRCU_MB
>>  liburcu_mb_la_LIBADD = liburcu-common.la
