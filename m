From: "Woegerer, Paul" <Paul_Woegerer@mentor.com>
Subject: Re: Ping: Re: [PATCH lttng-ust] Bugfix for
	http://bugs.lttng.org/issues/745
Date: Thu, 10 Jul 2014 16:13:04 +0200
Message-ID: <53BE9F70.5060909__43693.6079561294$1405001653$gmane$org@mentor.com>
References: <1404476512-18305-1-git-send-email-paul_woegerer@mentor.com>
 <53BE8BE1.1000509@mentor.com>
 <1879691854.11749.1404998687774.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Paul_Woegerer@mentor.com>) id 1X5F62-0007Ix-Pz
 for lttng-dev@lists.lttng.org; Thu, 10 Jul 2014 10:13:23 -0400
In-Reply-To: <1879691854.11749.1404998687774.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

On 07/10/2014 03:24 PM, Mathieu Desnoyers wrote:
> ----- Original Message -----
>> From: "Paul Woegerer" <Paul_Woegerer@mentor.com>
>> To: lttng-dev@lists.lttng.org, "mathieu desnoyers" <mathieu.desnoyers@efficios.com>
>> Sent: Thursday, July 10, 2014 8:49:37 AM
>> Subject: Ping: Re: [PATCH lttng-ust] Bugfix for http://bugs.lttng.org/issues/745
>>
>> Hi Mathieu,
>>
>> Since we have no other options currently (see LD_AUDIT discussion) we
>> really should get this merged into master. As said, it's thoroughly
>> tested and should not cause any ill side-effects.
> 
> Hi Paul,
> 
> Sorry about the delayed answer, I was busy implementing a tool that extracts
> UST buffers in the event of a system crash.
> 
> Looking at your patch below, I wonder why you use a semaphore (0, 1) rather
> than a mutex ? I guess you could achieve the same result with a pthread
> mutex ? If so, it would be better, because it makes it easier to understand
> mutex nesting.

Thanks for your feedback.

I will build another variant that uses a mutex instead and run it
through the same test procedure. If that works equally well I sent an
updated patch.

--
Paul

> 
> Thanks,
> 
> Mathieu
> 
>>
>> Many Thanks,
>> Paul
>>
>> On 07/04/2014 02:21 PM, Paul Woegerer wrote:
>>> Since (at least) in the short term LD_AUDIT will not be able to make
>>> sem_wait()
>>> in the static constructor go away I provide the following patch to fix
>>> http://bugs.lttng.org/issues/745.
>>>
>>> It works by making the process of forking mutual exclusive with base
>>> address
>>> statedumping that happens from the ust_listener_thread.
>>>
>>> I have tested this fix with several variations of (constrained) fork bombs
>>> (including tests/regression/ust/daemon from lttng-tools) on x86_64,
>>> ARM(imx6q)
>>> and powerpc(P4080DS). It works reliable. I could not find any issues with
>>> this
>>> approach.
>>>
>>> Paul Woegerer (1):
>>>   Bugfix for #745 deadlock with baddr statedump+fork
>>>
>>>  liblttng-ust/lttng-ust-comm.c | 21 +++++++++++++++++++++
>>>  1 file changed, 21 insertions(+)
>>>
>>
>>
>> --
>> Paul Woegerer, SW Development Engineer
>> Sourcery Analyzer <http://go.mentor.com/sourceryanalyzer>
>> Mentor Graphics, Embedded Software Division
>>
> 


-- 
Paul Woegerer, SW Development Engineer
Sourcery Analyzer <http://go.mentor.com/sourceryanalyzer>
Mentor Graphics, Embedded Software Division
