From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-modules] Fix: Remove not used
 PREEMPT_ACTIVE in Linux 4.4
Date: Tue, 2 Feb 2016 20:03:01 +0000 (UTC)
Message-ID: <460882067.10924.1454443381778.JavaMail.zimbra__14814.6085827195$1454443469$gmane$org@efficios.com>
References: <1454417813-19236-1-git-send-email-eu@felipetonello.com>
 <523443816.10171.1454420328647.JavaMail.zimbra@efficios.com>
 <CAGrhNMz9ZOXTtTkMy8hxVQFyk6Kj3uWY2G4Ksfo2zfY5qGc_ow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1aQhAO-0005TK-EP
 for lttng-dev@lists.lttng.org; Tue, 02 Feb 2016 15:03:15 -0500
In-Reply-To: <CAGrhNMz9ZOXTtTkMy8hxVQFyk6Kj3uWY2G4Ksfo2zfY5qGc_ow@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Felipe F. Tonello" <eu@felipetonello.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org



----- On Feb 2, 2016, at 9:22 AM, Felipe F. Tonello eu@felipetonello.com wrote:

> Hi Mathieu,
> 
> On Tue, Feb 2, 2016 at 1:38 PM, Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
>> Hi,
>>
>> In instrumentation/events/lttng-module/sched.h, there are ifdefs
>> checking the kernel version against which lttng-modules is build.
>> Please ensure you don't remove this flag when building against
>> older kernels.
> 
> Actually I just realized that this file is correct already.
> 
>>
>> The mainline/sched.h file should be removed from lttng-modules,
>> it's a leftover of initial porting of instrumentation from the
>> kernel.
> 
> I will send another patch removing this file.

We would need to edit the README file under instrumentation/events too.

Thanks,

Mathieu

> 
> Felipe

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
