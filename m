From: changz <zheng.chang@emc.com>
Subject: Re: Question about the performance of LTTng-UST
Date: Thu, 26 Jul 2012 12:54:27 +0800
Message-ID: <5010CD83.9050501__27463.5839778513$1343278518$gmane$org@emc.com>
References: <500FBEB3.8070106@emc.com> <20120725132937.GA14530@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from hop-nat-141.emc.com ([168.159.213.141]
	helo=mexforward.lss.emc.com) by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Zheng.Chang@emc.com>) id 1SuG69-0007jR-D5
	for lttng-dev@lists.lttng.org; Thu, 26 Jul 2012 00:54:53 -0400
In-Reply-To: <20120725132937.GA14530@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

On 7/25/2012 21:29 PM, Mathieu Desnoyers wrote:
> * changz (zheng.chang@emc.com) wrote:
>> Hi All,
>>
>> I wrote a very simple test code like this:
>>
>>          for (i = 0; i < 0xffffff; i++) {
>>                  tracepoint(sample_component, message, "This is a
>> performance test:","main",i);
>>          }
>>
>> And then I started lttng and ran the test code:
>> time  ./test
>> real0m16.120s
> This is indeed very high (96 microsecond per event). There is something
> wrong with your system (what architecture, kernel version do you use ?
> Getting you dmesg log would be useful too, especially to find out which
> clock source your kernel uses. Also, are you in a virtualized
> environment ? If yes, which ?)
Mathieu,

My OS is a X86 linux kernel 2.6.38 running on Vmware workstation for 
windows.
linux-gate.so was linked to my test code.
And here is a message found in dmesg output:
[2.228750] Switching to clocksource tsc

I found a benchmark data about vmware system call. It says the 
virtualization can cause ten times delay than it runs on host directly.
So I guess that's the reason why my test code ran slowly.

Could you provide more info about the impact introduced by different 
clock sources?

Thanks
Zheng
>> user0m8.280s
>> sys0m7.789s
>>
>>  From the result of time output, you can see sys time is about half of
>> the whole run-time. I wondered where the cost was from.
>> So I used strace to track it and found amount of system calls (get_cpu
>> and clock_gettime) during the run-time.
>> I know these system calls are used for ring-buffer. But I just think the
>> cost is a little heavy.
>>
>> What do you think?
> On x86, these calls are done through a kernel vDSO. Having those showing
> up in strace tells me that you kernel might be quite old, or use use an
> architecture that implements those as standard system calls rather than
> vDSO.
>
> Thanks,
>
> Mathieu
>
>> BR
>> Zheng
>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
