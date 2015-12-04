From: Ronan CHAUVIN <ronan.chauvin@parrot.com>
Subject: Re: lttng on aarch64 platform
Date: Fri, 4 Dec 2015 18:52:28 +0100
Message-ID: <5661D2DC.20509__46660.2769251496$1449595886$gmane$org@parrot.com>
References: <5658933A.4060408@parrot.com>
 <1656873418.171234.1448809123603.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.aswsp.com ([193.34.35.150])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <ronan.chauvin@parrot.com>) id 1a4uX0-0002x6-Pp
 for lttng-dev@lists.lttng.org; Fri, 04 Dec 2015 12:52:35 -0500
In-Reply-To: <1656873418.171234.1448809123603.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi Mathieu,

Thank you for your answer. I have investigated the issue.

The trap wasn't the reason why the daemon was exited. The kernel doesn't 
kill the process when an unknow system call is invoked. As you mentioned 
some functionalities will not be available on this kernel version as it 
doesn't have new membarrier system call implementation.

I launched the daemon independently and got the following error:
"Error: URI parse bad hostname localhost for af 2
Segmentation fault
/# boxinit: untracked pid 12292 'lttng-runas' exited"

This behavior comes from the gethostbyname2 function used at 
src/common/uri.c line 119. It seems that this function read the 
/etc/hosts file which was not present on my system.

Everything else works fine.

Thanks for your help,

Ronan

On 11/29/2015 03:58 PM, Mathieu Desnoyers wrote:
> ----- On Nov 27, 2015, at 6:30 PM, Ronan CHAUVIN ronan.chauvin@parrot.com wrote:
>
>> Hello all,
>>
>> I am trying to use lttng 2.7.0 on an aarch64 platform. When I create my
>> session a trap is triggered which indicated that a unknow syscall (389)
>> is called.
>>
>> / # lttng -vvv create mysession
>> DEBUG1 - 02:36:22.271714 [850/850]: Session daemon binary path:
>> /usr/bin/lttng-sessiond (in launch_sessiond() at commands/create.c:668)
>> Spawning a session daemon
>> DEBUG1 - 02:36:24.275751 [850/850]: Session daemon terminated normally
>> (exit status: 1) (in spawn_sessiond() at commands/create.c:606)
>> Error: Session daemon terminated with an error (exit status: 1)
>> Error: Problem occurred while launching session daemon
>> (/usr/bin/lttng-sessiond)
>> Error: Command error
>> DEBUG1 - 02:36:24.275899 [850/850]: Clean exit (in clean_exit() at
>> lttng.c:193)
>>
>> It seems that lttng-sessiond deamon is directly exited. Has anyone
>> already tried on a 3.10 kernel and aarch64 platform?
> Hi Ronan,
>
> That's because your liburcu calls the new membarrier system call, which was
> introduced later than your kernel. The way it works is that if the membarrier
> system call returns -1, errno=ENOSYS, it falls-back to a liburcu implementation
> which does not need the membarrier system call. This question here is: why
> does your kernel trap when an unknown system call is invoked ?
>
> Thanks,
>
> Mathieu
>
>> Thanks in advance,
>>
>> --
>> Ronan CHAUVIN
>> Embedded Software Engineer
>> ASIC & Video team
>> --------------------------------
>> Parrot SA
>> 174, quai de Jemmapes
>> 75010 Paris, France
>> --------------------------------
>> www.parrot.com
>>
>>
>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
