From: David Goulet <dgoulet@efficios.com>
Subject: Re: [PATCH lttng-tools] Add kernel modules loading for
 new probes
Date: Mon, 07 Jan 2013 15:07:19 -0500
Message-ID: <50EB2AF7.90108__46198.6089860604$1357589285$gmane$org@efficios.com>
References: <1355168223-6704-1-git-send-email-andrew_gabbasov@mentor.com>
	<20121210195057.GB17705@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([213.239.202.151])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1TsIyg-0002Wt-H1
	for lttng-dev@lists.lttng.org; Mon, 07 Jan 2013 15:07:22 -0500
In-Reply-To: <20121210195057.GB17705@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org, Andrew Gabbasov <andrew_gabbasov@mentor.com>
List-Id: lttng-dev@lists.lttng.org

Merged in master!

Cheers!
David

Mathieu Desnoyers:
> * Andrew Gabbasov (andrew_gabbasov@mentor.com) wrote:
>> New probes introduced by commit b87700e318c27267890cbd6fb5e50b687279131b
>> in lttng-modules.
> 
> David, these probes are 2.2 material. So feel free to either include
> this patch in 2.1 or keep it for 2.2. Since the modprobe error is
> ignored, it won't make much difference.
> 
> Thanks,
> 
> Acked-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> 
>>
>> Signed-off-by: Andrew Gabbasov <andrew_gabbasov@mentor.com>
>> ---
>>  src/bin/lttng-sessiond/modprobe.c |   11 +++++++++++
>>  1 file changed, 11 insertions(+)
>>
>> diff --git a/src/bin/lttng-sessiond/modprobe.c b/src/bin/lttng-sessiond/modprobe.c
>> index 8e5cc94..1a5a1b7 100644
>> --- a/src/bin/lttng-sessiond/modprobe.c
>> +++ b/src/bin/lttng-sessiond/modprobe.c
>> @@ -46,7 +46,10 @@ const struct kern_modules_param kern_modules_list[] = {
>>  	{ "lttng-types", 0 },
>>  	{ "lttng-probe-asoc", 0 },
>>  	{ "lttng-probe-block", 0 },
>> +	{ "lttng-probe-btrfs", 0 },
>> +	{ "lttng-probe-compaction", 0 },
>>  	{ "lttng-probe-ext3", 0 },
>> +	{ "lttng-probe-ext4", 0 },
>>  	{ "lttng-probe-gpio", 0 },
>>  	{ "lttng-probe-irq", 0 },
>>  	{ "lttng-probe-jbd", 0 },
>> @@ -58,16 +61,24 @@ const struct kern_modules_param kern_modules_list[] = {
>>  	{ "lttng-probe-napi", 0 },
>>  	{ "lttng-probe-net", 0 },
>>  	{ "lttng-probe-power", 0 },
>> +	{ "lttng-probe-printk", 0 },
>> +	{ "lttng-probe-random", 0 },
>> +	{ "lttng-probe-rcu", 0 },
>> +	{ "lttng-probe-regmap", 0 },
>>  	{ "lttng-probe-regulator", 0 },
>> +	{ "lttng-probe-rpm", 0 },
>>  	{ "lttng-probe-sched", 0 },
>>  	{ "lttng-probe-scsi", 0 },
>>  	{ "lttng-probe-signal", 0 },
>>  	{ "lttng-probe-skb", 0 },
>>  	{ "lttng-probe-sock", 0 },
>>  	{ "lttng-probe-statedump", 0 },
>> +	{ "lttng-probe-sunrpc", 0 },
>>  	{ "lttng-probe-timer", 0 },
>>  	{ "lttng-probe-udp", 0 },
>>  	{ "lttng-probe-vmscan", 0 },
>> +	{ "lttng-probe-workqueue", 0 },
>> +	{ "lttng-probe-writeback", 0 },
>>  };
>>  
>>  /*
>> -- 
>> 1.7.10.4
>>
>>
>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> 
