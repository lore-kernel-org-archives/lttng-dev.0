From: Alexandre Montplaisir <alexmonthy@voxpopuli.im>
Subject: Re: lttng fails to install on Ubunti 14.04
Date: Fri, 05 Jun 2015 16:13:42 +0200
Message-ID: <5571AE96.8020101__11016.3469137207$1433513697$gmane$org@voxpopuli.im>
References: <92BAB684D31DCD4A8F623A7EE7FD8C06013FEEB2@041-DB3MPN1-092.041d.mgd.msft.net>,
 <557184CB.3090706@voxpopuli.im>
 <D381217948BF4C45AF756AFC995BEB9F1C4921F7@eusaamb103.ericsson.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.181])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <alexmonthy@voxpopuli.im>) id 1Z0sNZ-0003Qh-9t
 for lttng-dev@lists.lttng.org; Fri, 05 Jun 2015 10:13:51 -0400
In-Reply-To: <D381217948BF4C45AF756AFC995BEB9F1C4921F7@eusaamb103.ericsson.se>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?windows-1252?Q?Marc-Andr=E9_Laperle?= <marc-andre.laperle@ericsson.com>
Cc: SMITH Peter T <peter.t.smith@alstom.com>, "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Yikes, good point, there was Yet Another Workaround that was added to =

the daily PPA package, but not the -stable one.

I've pushed an update to cover for that too. Make sure you use the =

package with "pack24" in its version number. And let us know if you get =

other errors!

Just FYI, we will set up some CI jobs in the following months to test =

these packages and hopefully catch the failures early.

Cheers,
Alexandre


On 2015-06-05 02:58 PM, Marc-Andr=E9 Laperle wrote:
> I tried to use the PPA yesterday and it failed too. Maybe for a different=
 reason though.
>
> Marc-Andre
> ________________________________________
> From: Alexandre Montplaisir [alexmonthy@voxpopuli.im]
> Sent: Friday, 05 June 2015 7:15 AM
> To: SMITH Peter T
> Cc: lttng-dev@lists.lttng.org
> Subject: Re: [lttng-dev] lttng fails to install on Ubunti 14.04
>
> Hi,
>
> This is a recurring problem, unfortunately. The distribution updates
> their kernel by backporting patches from later upstream kernel versions,
> which can sometimes break the internal "APIs" used by lttng-modules.
> However they will not update the lttng-modules package for a given
> version of the distro, so even if we fix it in lttng-modules upstream,
> the default distribution package will not have the fix.
>
> What I would suggest is to use the Ubuntu PPA to install lttng-modules,
> if you can.
> See https://launchpad.net/~lttng/+archive/ubuntu/ppa , as well as the
> instructions on that page.
>
> I remember that particular kmem.h problem was fixed upstream, so the PPA
> package should have that fix. But let us know if you hit another problem!
>
> Cheers,
> Alexandre
>
>
> On 2015-06-05 12:22 PM, SMITH Peter T wrote:
>> I am attempting to install LLTng on Ubuntu 14.04 with the following kern=
el.
>>
>> Linux user-VirtualBox 3.13.0-53-generic #89-Ubuntu SMP Wed May 20 10:34:=
39 UTC 2015 x86_64 x86_64 x86_64 GNU/Linux
>>
>> I have followed the generic installation procedure i.e.
>> sudo apt-get install lttng-tools
>> sudo apt-get install lttng-modules-dkms
>> sudo apt-get install liblttng-ust-dev
>> The installation fails at the second step i.e. the modules.
>>
>> Below is the make.log
>> DKMS make.log for lttng-modules-2.4.0 for kernel 3.13.0-53-generic (x86_=
64)
>> Fri Jun  5 11:17:48 BST 2015
>> make: Entering directory `/usr/src/linux-headers-3.13.0-53-generic'
>>     CC [M]  /var/lib/dkms/lttng-modules/2.4.0/build/lttng-ring-buffer-cl=
ient-discard.o
>>     CC [M]  /var/lib/dkms/lttng-modules/2.4.0/build/lttng-ring-buffer-cl=
ient-overwrite.o
>>     CC [M]  /var/lib/dkms/lttng-modules/2.4.0/build/lttng-ring-buffer-me=
tadata-client.o
>>     CC [M]  /var/lib/dkms/lttng-modules/2.4.0/build/lttng-ring-buffer-cl=
ient-mmap-discard.o
>>     CC [M]  /var/lib/dkms/lttng-modules/2.4.0/build/lttng-ring-buffer-cl=
ient-mmap-overwrite.o
>>     CC [M]  /var/lib/dkms/lttng-modules/2.4.0/build/lttng-ring-buffer-me=
tadata-mmap-client.o
>>     CC [M]  /var/lib/dkms/lttng-modules/2.4.0/build/lttng-statedump-impl=
.o
>>     CC [M]  /var/lib/dkms/lttng-modules/2.4.0/build/wrapper/irqdesc.o
>>     CC [M]  /var/lib/dkms/lttng-modules/2.4.0/build/wrapper/fdtable.o
>>     CC [M]  /var/lib/dkms/lttng-modules/2.4.0/build/lttng-events.o
>>     CC [M]  /var/lib/dkms/lttng-modules/2.4.0/build/lttng-abi.o
>>     CC [M]  /var/lib/dkms/lttng-modules/2.4.0/build/lttng-probes.o
>>     CC [M]  /var/lib/dkms/lttng-modules/2.4.0/build/lttng-context.o
>>     CC [M]  /var/lib/dkms/lttng-modules/2.4.0/build/lttng-context-pid.o
>>     CC [M]  /var/lib/dkms/lttng-modules/2.4.0/build/lttng-context-procna=
me.o
>>     CC [M]  /var/lib/dkms/lttng-modules/2.4.0/build/lttng-context-prio.o
>>     CC [M]  /var/lib/dkms/lttng-modules/2.4.0/build/lttng-context-nice.o
>>     CC [M]  /var/lib/dkms/lttng-modules/2.4.0/build/lttng-context-vpid.o
>>     CC [M]  /var/lib/dkms/lttng-modules/2.4.0/build/lttng-context-tid.o
>>     CC [M]  /var/lib/dkms/lttng-modules/2.4.0/build/lttng-context-vtid.o
>>     CC [M]  /var/lib/dkms/lttng-modules/2.4.0/build/lttng-context-ppid.o
>>     CC [M]  /var/lib/dkms/lttng-modules/2.4.0/build/lttng-context-vppid.o
>>     CC [M]  /var/lib/dkms/lttng-modules/2.4.0/build/lttng-calibrate.o
>>     CC [M]  /var/lib/dkms/lttng-modules/2.4.0/build/lttng-context-hostna=
me.o
>>     CC [M]  /var/lib/dkms/lttng-modules/2.4.0/build/wrapper/random.o
>>     CC [M]  /var/lib/dkms/lttng-modules/2.4.0/build/lttng-syscalls.o
>>     CC [M]  /var/lib/dkms/lttng-modules/2.4.0/build/probes/lttng-probe-u=
ser.o
>>     CC [M]  /var/lib/dkms/lttng-modules/2.4.0/build/lttng-context-perf-c=
ounters.o
>>     LD [M]  /var/lib/dkms/lttng-modules/2.4.0/build/lttng-tracer.o
>>     LD [M]  /var/lib/dkms/lttng-modules/2.4.0/build/lttng-statedump.o
>>     CC [M]  /var/lib/dkms/lttng-modules/2.4.0/build/lib/ringbuffer/ring_=
buffer_backend.o
>>     CC [M]  /var/lib/dkms/lttng-modules/2.4.0/build/lib/ringbuffer/ring_=
buffer_frontend.o
>>     CC [M]  /var/lib/dkms/lttng-modules/2.4.0/build/lib/ringbuffer/ring_=
buffer_iterator.o
>>     CC [M]  /var/lib/dkms/lttng-modules/2.4.0/build/lib/ringbuffer/ring_=
buffer_vfs.o
>>     CC [M]  /var/lib/dkms/lttng-modules/2.4.0/build/lib/ringbuffer/ring_=
buffer_splice.o
>>     CC [M]  /var/lib/dkms/lttng-modules/2.4.0/build/lib/ringbuffer/ring_=
buffer_mmap.o
>>     CC [M]  /var/lib/dkms/lttng-modules/2.4.0/build/lib/prio_heap/lttng_=
prio_heap.o
>>    CC [M]  /var/lib/dkms/lttng-modules/2.4.0/build/lib/../wrapper/splice=
.o
>>     LD [M]  /var/lib/dkms/lttng-modules/2.4.0/build/lib/lttng-lib-ring-b=
uffer.o
>> /var/lib/dkms/lttng-modules/2.4.0/build/probes/Makefile:30: File /usr/sr=
c/linux-headers-3.13.0-53-generic/virt/kvm/iodev.h not found. Probe "kvm" x=
86-specific is disabled. Use full kernel source tree to enable it.
>> /var/lib/dkms/lttng-modules/2.4.0/build/probes/Makefile:142: Files /usr/=
src/linux-headers-3.13.0-53-generic/fs/btrfs/*.h not found. Probe "btrfs" i=
s disabled. Use full kernel source tree to enable it.
>> /var/lib/dkms/lttng-modules/2.4.0/build/probes/Makefile:158: Files /usr/=
src/linux-headers-3.13.0-53-generic/fs/ext4/*.h not found. Probe "ext4" is =
disabled. Use full kernel source tree to enable it.
>>     CC [M]  /var/lib/dkms/lttng-modules/2.4.0/build/probes/lttng-types.o
>>     CC [M]  /var/lib/dkms/lttng-modules/2.4.0/build/probes/lttng-probe-s=
ched.o
>>     CC [M]  /var/lib/dkms/lttng-modules/2.4.0/build/probes/lttng-probe-i=
rq.o
>>     CC [M]  /var/lib/dkms/lttng-modules/2.4.0/build/probes/lttng-probe-t=
imer.o
>>     CC [M]  /var/lib/dkms/lttng-modules/2.4.0/build/probes/lttng-probe-k=
mem.o
>> In file included from /var/lib/dkms/lttng-modules/2.4.0/build/probes/../=
instrumentation/events/lttng-module/../../../probes/define_trace.h:148:0,
>>                    from /var/lib/dkms/lttng-modules/2.4.0/build/probes/.=
./instrumentation/events/lttng-module/kmem.h:380,
>>                    from /var/lib/dkms/lttng-modules/2.4.0/build/probes/l=
ttng-probe-kmem.c:41:
>> /var/lib/dkms/lttng-modules/2.4.0/build/probes/../instrumentation/events=
/lttng-module/../../../probes/lttng-events.h:151:6: error: conflicting type=
s for 'trace_mm_page_alloc_extfrag'
>> void trace_##_name(_proto);
>>         ^
>> /var/lib/dkms/lttng-modules/2.4.0/build/probes/../instrumentation/events=
/lttng-module/../../../probes/lttng-events.h:47:2: note: in expansion of ma=
cro 'DEFINE_EVENT_MAP'
>>     DEFINE_EVENT_MAP(map, name, map, PARAMS(proto), PARAMS(args))
>>     ^
>> /var/lib/dkms/lttng-modules/2.4.0/build/probes/../instrumentation/events=
/lttng-module/../../../probes/lttng-events.h:89:2: note: in expansion of ma=
cro 'TRACE_EVENT_MAP'
>>     TRACE_EVENT_MAP(name, name,    \
>>     ^
>> /var/lib/dkms/lttng-modules/2.4.0/build/probes/../instrumentation/events=
/lttng-module/../../../probes/../instrumentation/events/lttng-module/kmem.h=
:291:1: note: in expansion of macro 'TRACE_EVENT'
>> TRACE_EVENT(mm_page_alloc_extfrag,
>> ^
>> In file included from include/linux/module.h:18:0,
>>                    from /var/lib/dkms/lttng-modules/2.4.0/build/probes/l=
ttng-probe-kmem.c:24:
>> include/linux/tracepoint.h:168:21: note: previous definition of 'trace_m=
m_page_alloc_extfrag' was here
>>     static inline void trace_##name(proto)    \
>>                        ^
>> include/linux/tracepoint.h:265:3: note: in expansion of macro '__DECLARE=
_TRACE'
>>      __DECLARE_TRACE(name, PARAMS(proto), PARAMS(args), 1, \
>>      ^
>> include/linux/tracepoint.h:399:2: note: in expansion of macro 'DECLARE_T=
RACE'
>>     DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
>>     ^
>> include/trace/events/kmem.h:267:1: note: in expansion of macro 'TRACE_EV=
ENT'
>> TRACE_EVENT(mm_page_alloc_extfrag,
>> ^
>> make[2]: *** [/var/lib/dkms/lttng-modules/2.4.0/build/probes/lttng-probe=
-kmem.o] Error 1
>> make[1]: *** [/var/lib/dkms/lttng-modules/2.4.0/build/probes] Error 2
>> make: *** [_module_/var/lib/dkms/lttng-modules/2.4.0/build] Error 2
>> make: Leaving directory `/usr/src/linux-headers-3.13.0-53-generic'
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>> ________________________________
>> CONFIDENTIALITY : This e-mail and any attachments are confidential and m=
ay be privileged. If you are not a named recipient, please notify the sende=
r immediately and do not disclose the contents to another person, use it fo=
r any purpose or store or copy the information in any medium.
>>
>>
>>
>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
