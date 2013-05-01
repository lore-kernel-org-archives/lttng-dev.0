From: Andre Bette <andreb@stud.fh-dortmund.de>
Subject: Re: Using the additional Eclipse Kernel Trace Plugin
 Views (Control flow, Resources)
Date: Wed, 01 May 2013 10:58:01 +0200
Message-ID: <5180D919.1020208__13562.9955716015$1367398721$gmane$org@stud.fh-dortmund.de>
References: <517F8D02.4090202@stud.fh-dortmund.de>
	<518004F6.5040202@ericsson.com> <51800F67.9040407@voxpopuli.im>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mailout1.fh-dortmund.de ([193.25.16.11])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <andreb@stud.fh-dortmund.de>) id 1UXSrU-0005h9-CK
	for lttng-dev@lists.lttng.org; Wed, 01 May 2013 04:58:04 -0400
In-Reply-To: <51800F67.9040407@voxpopuli.im>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Alexandre Montplaisir <alexmonthy@voxpopuli.im>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hi Alexandre and Matthew,

Thank you both very much for the detailed answer. If I have more 
questions about some Javacode I will ask later .


Best Regards,
Andre

PS: Sorry for the doublepost




Am 30.04.2013 20:37, schrieb Alexandre Montplaisir:
> On 13-04-30 01:52 PM, Matthew Khouzam wrote:
>> Hi Andre,
>> This question seems familiar, I will paste an answer from earlier.
>> On 13-04-30 05:21 AM, Andre Bette wrote:
>>> Hi to everyone,
>>> in my project I am tracing a embedded system with a non linux OS.
>>> Output format is CTF. I really like the two extra views in the Eclipse
>>> Kernel Trace Visualization (Control flow, Resources).
>>>
>>> Is there a simple way to use this two views  with an non linux trace ?
>>> Is there any documentation about the Linux kernel trace format( the
>>> extra info added into the CTF format) or how the
>>> data(e.g. prozesses) is processed in the Eclipse Kernel Trace Plugin
>>> (The idea is to use a "fake" linux trace to use the two extra views )?
>>>
>> I will give a short answer that I am sure Alexandre Montplaisir has expanded on earlier is  YES!
> Yeah my first reply bounced, but you can read it here:
> http://lists.lttng.org/pipermail/lttng-dev/2013-April/020165.html
>
> Cheers,
> Alex
>
>> You need to make a state system with a "state system input" that will emulate the directory structure of the kernel state system.
>>
>> It's not EXTREMELY hard, but I think it will get significantly easier in a couple of months.
>> Great to hear you like the eclipse viewer, fan mail is always appreciated, especially in duplicate!
>>
>> Matthew
>>
>>> Best Regards,
>>> Andre
>>>
>>> _______________________________________________
>>> lttng-dev mailing list
>>> lttng-dev@lists.lttng.org
>>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
