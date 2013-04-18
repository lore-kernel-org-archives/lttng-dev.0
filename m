From: Alexandre Montplaisir <alexmonthy@voxpopuli.im>
Subject: Re: Limitations on subbuf_size / num_subbuf?
Date: Thu, 18 Apr 2013 13:18:39 -0400
Message-ID: <51702AEF.7010508__11177.7153601453$1366305697$gmane$org@voxpopuli.im>
References: <OFC51F8E88.28285A69-ONC2257B4D.003B3B3E-C2257B4D.003B6399@il.ibm.com>
	<516C0D60.1050503@ericsson.com>
	<OFC6774750.9138DA2C-ONC2257B51.002189D3-C2257B51.0021DDB3@il.ibm.com>
	<51702491.1000007@voxpopuli.im>
	<20130418170748.GA32330@Krystal> <20130418171120.GA460@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.182])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <alexmonthy@voxpopuli.im>) id 1USsWL-0005L9-Gz
	for lttng-dev@lists.lttng.org; Thu, 18 Apr 2013 13:21:17 -0400
In-Reply-To: <20130418171120.GA460@Krystal>
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

On 13-04-18 01:11 PM, Mathieu Desnoyers wrote:
> * Mathieu Desnoyers (mathieu.desnoyers@efficios.com) wrote:
>> * Alexandre Montplaisir (alexmonthy@voxpopuli.im) wrote:
>>> On 13-04-18 02:11 AM, Amit Margalit wrote:
>>>> Hi,
>>>>
>>>> Thank for the quick response. Here is the missing data:
>>>>
>>>> UST
>>>> 2.6.32.12-205 (I had to make a tiny patch to make it compile)
>>>> MemTotal:       24628852 kB
>>>> lttng-ust-2.1.2
>>>> lttng-tools-2.1.1
>>>> lttng-modules-2.1.1
>>>> babeltrace-1.1.0
>>>> userspace-rcu-0.7.6
>>>>
>>>> Which patch for 4MB?
>>> Hi,
>>>
>>> Not sure if it's specifically this one that Matthew was talking about,
>>> but we have such a patch in the PPA packages. See:
>>> http://bazaar.launchpad.net/~lttng/lttng-tools/packaging-daily/view/head:/patches/0002-Increase-default-subbuffer-size-to-4MB.patch
>> First, it should be noted that lttng enable-channel allow overriding the
>> subbuffer size.
>>
>> It should be noted that lttng-modules 2.2 is going to output even _more_
>> events, so I don't think just making the buffers larger by default is
>> the right approach.
> Oh, and I notice that the PPA changes the UST default to 4MB per
> subbuffer too.
>
> That's not going to be pretty for per-pid tracing (which is the default)
> on a system with 16 CPUs, tracing 100 processes with UST. 4x4MBx16x100 =
> 25600 MB (25GB) of buffers just for UST.

Ok good to know, we will have to update it then.

> Messing with defaults in packaging seems odd.

Actually, it's a pretty common practice ;)


Cheers,
Alex

>
> Mathieu
>
>> I think we need to port the "loglevel" from UST to lttng-modules ASAP,
>> and assign a "debug" loglevel to events we don't care about by default.
>>
>> Thoughts ?
>>
>> Thanks,
>>
>> Mathieu
>>
>>>> Thanks,
>>>>
>>>> Amit Margalit
>>>> IBM XIV - Storage Reinvented
>>>> XIV-NAS Development Team
>>>> Tel. 03-689-7774
>>>> Fax. 03-689-7230
>>>>
>>>>
>>>>
>>>> From:   Matthew Khouzam <matthew.khouzam@ericsson.com>
>>>> To:     <lttng-dev@lists.lttng.org>
>>>> Date:   04/15/2013 05:24 PM
>>>> Subject:        Re: [lttng-dev] Limitations on subbuf_size / num_subbuf?
>>>>
>>>>
>>>>
>>>> Not at all a n00b question, but could you give some more info? what is 
>>>> your version of LTTng tools, are you using UST or kernel tracing? How much 
>>>> ram is on your system? Kernel version? 
>>>>
>>>> I actually have the patched lttng that has standard subbuffer sizes of 4 
>>>> mb, so I have not personnaly seen that problem. But the first thing I 
>>>> would do is upgrade to the latest stable.
>>>>
>>>> On 13-04-14 06:49 AM, Amit Margalit wrote:
>>>> Hello, 
>>>>
>>>> Sorry for the noob question. I seem to be unable to define the total of 
>>>> subbuf_size * num_subbuf higher than 4MB. I am getting ~30% discarded 
>>>> tracepoint data. 
>>>>
>>>> Any assistance would be greatly appreciated. 
>>>>
>>>> Amit Margalit 
>>>> IBM XIV - Storage Reinvented 
>>>> XIV-NAS Development Team 
>>>> Tel. 03-689-7774 
>>>> Fax. 03-689-7230 
>>>
>>> _______________________________________________
>>> lttng-dev mailing list
>>> lttng-dev@lists.lttng.org
>>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>> -- 
>> Mathieu Desnoyers
>> EfficiOS Inc.
>> http://www.efficios.com
>>
>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
