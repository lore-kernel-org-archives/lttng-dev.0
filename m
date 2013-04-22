From: Matthew Khouzam <matthew.khouzam@ericsson.com>
Subject: Re: [RFC PATCH 0/2] babeltrace legacy LTT 2.6 converter
Date: Mon, 22 Apr 2013 11:51:33 -0400
Message-ID: <51755C85.3070803__37715.3207934045$1366645986$gmane$org@ericsson.com>
References: <cover.1366364119.git.jan.glauber@gmail.com>
	<51715CCB.90009@ericsson.com> <20130422125536.GA8755@hal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from usevmg21.ericsson.net ([198.24.6.65])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <matthew.khouzam@ericsson.com>) id 1UUJ2c-0008Ic-5q
	for lttng-dev@lists.lttng.org; Mon, 22 Apr 2013 11:52:30 -0400
In-Reply-To: <20130422125536.GA8755@hal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Jan Glauber <jan.glauber@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org


On 13-04-22 08:55 AM, Jan Glauber wrote:
> On Fri, Apr 19, 2013 at 11:03:39AM -0400, Matthew Khouzam wrote:
>> Hi Jan,
>>
>> I have a few questions about the patch:
>> Does it handle lost events?
>> I think we would need to bring in a state system for this
> Hi Matthew,
>
> Not sure what you mean there. I thought lost events are not recorded so there is
> nothing to convert. What I do convert is the events_lost counter of LTT. The
> value is copied to the events_discarded of LTTng. At least that looked reasonable
> to me. Can you elaborate why we would need a state machine there?

In lttv, the control flow view and company needs a state system. The
events in lttng 0.x and 2.0 are slightly different, so we won't see
stuff like the current TID and file statuses. I'm just giving you the
heads up that it may be not so trivial to get the info. The best thing
to do IMO is look up events in LTTng 2.0 and try to match the ones you
have in babeltrace to them.
That way, it will work with lttv and eclipse.

I honestly feel I am being unclear, don't hesitate to ask for more
precisions.
>
>> Is there a reason lttng2.0 is not working for you? kernel? install base?
>> other?
> The reason is that we have multiple install bases and some are on LTT with no
> option of upgrading them to LTTng.
>
>> Do you want just a list of the events or analysis on the trace later on.
> We would like to analyse traces from different sources with Eclipse and
> especially using the CTF classes.
>
>> Can you post an example of a converted trace?
> Sure, here's a short snapshot of the converted trace viewed with babeltrace,
> somewhere in the middle of a not too spectacular trace but at least with events
> from some different components:
>
> [10:42:48.534746510] (+0.000001741) none kernel_syscall_entry: { cpu_id = 1 }, { ip = 716048728, syscall_id = 263 }
> [10:42:48.534748034] (+0.000001524) none fs_pollfd: { cpu_id = 0 }, { fd = 27 }
> [10:42:48.534748132] (+0.000000098) none kernel_syscall_exit: { cpu_id = 1 }, { ret = 0 }
> [10:42:48.534751362] (+0.000003230) none fs_pollfd: { cpu_id = 0 }, { fd = 28 }
> [10:42:48.534754469] (+0.000003107) none fs_pollfd: { cpu_id = 0 }, { fd = 29 }
> [10:42:48.534757482] (+0.000003013) none fs_pollfd: { cpu_id = 0 }, { fd = 20 }
> [10:42:48.534761354] (+0.000003872) none fs_pollfd: { cpu_id = 0 }, { fd = 22 }
> [10:42:48.534764045] (+0.000002691) none fs_pollfd: { cpu_id = 0 }, { fd = 30 }
> [10:42:48.534767272] (+0.000003227) none fs_pollfd: { cpu_id = 0 }, { fd = 31 }
> [10:42:48.534770512] (+0.000003240) none fs_pollfd: { cpu_id = 0 }, { fd = 32 }
> [10:42:48.534774102] (+0.000003590) none fs_pollfd: { cpu_id = 0 }, { fd = 33 }
> [10:42:48.534777510] (+0.000003408) none fs_pollfd: { cpu_id = 0 }, { fd = 35 }
> [10:42:48.534781767] (+0.000004257) none fs_pollfd: { cpu_id = 0 }, { fd = 36 }
> [10:42:48.534785282] (+0.000003515) none fs_pollfd: { cpu_id = 0 }, { fd = 37 }
> [10:42:48.534788669] (+0.000003387) none fs_pollfd: { cpu_id = 0 }, { fd = 34 }
> [10:42:48.534791977] (+0.000003308) none fs_pollfd: { cpu_id = 0 }, { fd = 38 }
> [10:42:48.534795069] (+0.000003092) none fs_pollfd: { cpu_id = 0 }, { fd = 39 }
> [10:42:48.534798194] (+0.000003125) none fs_pollfd: { cpu_id = 0 }, { fd = 40 }
> [10:42:48.534801197] (+0.000003003) none fs_pollfd: { cpu_id = 0 }, { fd = 41 }
> [10:42:48.534804389] (+0.000003192) none fs_pollfd: { cpu_id = 0 }, { fd = 42 }
> [10:42:48.534807827] (+0.000003438) none fs_pollfd: { cpu_id = 0 }, { fd = 43 }
> [10:42:48.534811137] (+0.000003310) none fs_pollfd: { cpu_id = 0 }, { fd = 44 }
> [10:42:48.534814215] (+0.000003078) none fs_pollfd: { cpu_id = 0 }, { fd = 45 }
> [10:42:48.534817354] (+0.000003139) none fs_pollfd: { cpu_id = 0 }, { fd = 46 }
> [10:42:48.534820489] (+0.000003135) none fs_pollfd: { cpu_id = 0 }, { fd = 47 }
> [10:42:48.534823479] (+0.000002990) none fs_pollfd: { cpu_id = 0 }, { fd = 48 }
> [10:42:48.534826875] (+0.000003396) none fs_pollfd: { cpu_id = 0 }, { fd = 49 }
> [10:42:48.534830315] (+0.000003440) none fs_pollfd: { cpu_id = 0 }, { fd = 50 }
> [10:42:48.534834449] (+0.000004134) none fs_pollfd: { cpu_id = 0 }, { fd = 51 }
> [10:42:48.534837717] (+0.000003268) none fs_pollfd: { cpu_id = 0 }, { fd = 52 }
> [10:42:48.534841064] (+0.000003347) none fs_pollfd: { cpu_id = 0 }, { fd = 53 }
> [10:42:48.534844754] (+0.000003690) none fs_pollfd: { cpu_id = 0 }, { fd = 54 }
> [10:42:48.534849177] (+0.000004423) none fs_pollfd: { cpu_id = 0 }, { fd = 55 }
> [10:42:48.534892997] (+0.000043820) none mm_page_free: { cpu_id = 0 }, { pfn = 158205, order = 0 }
> [10:42:48.534993555] (+0.000100558) none kernel_syscall_entry: { cpu_id = 1 }, { ip = 716868028, syscall_id = 296 }
> [10:42:48.535000284] (+0.000006729) none net_socket_recvmsg: { cpu_id = 0 }, { sock = 0xB5F324E0, msg = 0x983FFF74, size = 2048, flags = 1073741888, ret = 660 }
> [10:42:48.535011094] (+0.000010810) none net_socket_sendmsg: { cpu_id = 1 }, { sock = 0xB5CE8B20, msg = 0xB6031F74, size = 463, ret = 463 }
> [10:42:48.535013404] (+0.000002310) none kernel_syscall_exit: { cpu_id = 1 }, { ret = 463 }
> [10:42:48.535202519] (+0.000189115) none net_socket_recvmsg: { cpu_id = 0 }, { sock = 0xB5F324E0, msg = 0x983FFF74, size = 2048, flags = 1073741888, ret = -11 }
> [10:42:48.535231537] (+0.000029018) none kernel_sched_try_wakeup: { cpu_id = 1 }, { pid = 68, cpu_id = 1, state = 256 }
> [10:42:48.535243069] (+0.000011532) none kernel_sched_schedule: { cpu_id = 1 }, { prev_pid = 1, next_pid = 68, prev_state = 0 }
> [10:42:48.535258092] (+0.000015023) none fs_pollfd: { cpu_id = 1 }, { fd = 5 }
> [10:42:48.535264639] (+0.000006547) none fs_pollfd: { cpu_id = 1 }, { fd = 9 }
> [10:42:48.535269929] (+0.000005290) none kernel_syscall_exit: { cpu_id = 1 }, { ret = 1 }
> [10:42:48.535278789] (+0.000008860) none kernel_syscall_entry: { cpu_id = 1 }, { ip = 717849364, syscall_id = 3 }
> [10:42:48.535299225] (+0.000020436) none fs_read: { cpu_id = 1 }, { count = 1, fd = 9 }
> [10:42:48.535300645] (+0.000001420) none kernel_syscall_exit: { cpu_id = 1 }, { ret = 0 }
> [10:42:48.535306709] (+0.000006064) none kernel_syscall_entry: { cpu_id = 1 }, { ip = 717837844, syscall_id = 240 }
> [10:42:48.535309234] (+0.000002525) none fs_ioctl: { cpu_id = 0 }, { fd = 4, cmd = 1075866368, arg = 745629032 }
> [10:42:48.535324412] (+0.000015178) none kernel_sched_migrate_task: { cpu_id = 1 }, { pid = 67, state = 256, dest_cpu = 0 }
> [10:42:48.535331534] (+0.000007122) none kernel_syscall_exit: { cpu_id = 1 }, { ret = 1 }
> [10:42:48.535335210] (+0.000003676) none kernel_syscall_entry: { cpu_id = 1 }, { ip = 718693652, syscall_id = 168 }
>
> Regards,
> Jan
>
>> Thanks
>> Matthew
>>
>>
>> On 13-04-19 06:20 AM, Jan Glauber wrote:
>>> Hi list,
>>>
>>> I've written a converter that can read LTT's 2.6 trace format and convert it
>>> to a CTF trace format. This was discussed before on the list:
>>>
>>> http://lists.lttng.org/pipermail/lttng-dev/2011-June/015995.html
>>>
>>> and I roughly followed the guidance given by Mathieu there. Roughly because
>>> I did not create plugins but followed the approach of babeltrace-log.
>>>
>>> How it works:
>>> - babeltrace legacy converter gets a directory containing a LTT 2.6 trace
>>>   and a target directory where it will create the converted trace
>>> - it scans the metadata_N files and creates a CTF which fits the old trace data
>>> - it scans all trace files and creates CTF headers but copies the trace data
>>> - empty files which contain only headers are not copied
>>>
>>> Is there any interest in picking up this code for babeltrace (or is it just
>>> too obscure :) ?
>>>
>>> Best regards,
>>>
>>> Jan Glauber
>>> Harman Becker Automotive GmbH
>>> System Profiling & Optimizing Team
>>>
>>> Jan Glauber (2):
>>>   Resurrect LTT type parser
>>>   babeltrace legacy LTT 2.6 -> CTF 1.8 converter
>>>
>>>  converter/babeltrace-legacy.c        | 1184 ++++++++++++++++++++++++++++++++++
>>>  converter/ltt-type-parser.c          |  303 +++++++++
>>>  include/babeltrace/ltt-type-parser.h |   17 +
>>>  3 files changed, 1504 insertions(+)
>>>  create mode 100644 converter/babeltrace-legacy.c
>>>  create mode 100644 converter/ltt-type-parser.c
>>>  create mode 100644 include/babeltrace/ltt-type-parser.h
>>>
>>
>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
