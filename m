From: "Woegerer, Paul" <Paul_Woegerer@mentor.com>
Subject: Re: [PATCH lttng-ust 0/2] Shared object base address
 tracing
Date: Wed, 13 Nov 2013 11:00:24 +0100
Message-ID: <52834DB8.5030004__25320.4489512884$1384336912$gmane$org@mentor.com>
References: <1384183688-19038-1-git-send-email-paul_woegerer@mentor.com>
	<52828889.6030403@voxpopuli.im>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------040105000004000205010803"
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Paul_Woegerer@mentor.com>) id 1VgXFT-0002ZI-EW
	for lttng-dev@lists.lttng.org; Wed, 13 Nov 2013 05:00:43 -0500
In-Reply-To: <52828889.6030403@voxpopuli.im>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Alexandre Montplaisir <alexmonthy@voxpopuli.im>, mathieu.desnoyers@efficios.com, Matthew Khouzam <matthew.khouzam@ericsson.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--------------040105000004000205010803
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

On 11/12/2013 08:59 PM, Alexandre Montplaisir wrote:
> Hi Paul,
>
> I tried your patches. It seems to work quite well!

Glad to hear that :)

> - The events are called "ust_baddr:push" and "ust_baddr:pop". To be
> consistent with the other wrapper libraries in UST, perhaps they should
> be called "ust_dl:dlopen" and "ust_dl:dlclose" or similar?

I leave this up to Mathieu.
I don't mind changing the names to whatever makes most sense for LTTng.

> - Why does the "statedump" event seem to give many more libs than the
> "push" events? Could we be missing some dlopen's? For example, I traced
> glxgears by preloading liblttng-ust-dl.so: http://pastebin.com/HKVa9a4T

Since ust_baddr:push/pop is based on LD_PRELOAD'ing dlopen/dlclose it
can only tell you what shared libraries were opened/closed during the
time you are actually tracing the application. Whatever is
dlopen'ed/dlclose'ed before the tracing infrastructure that is part of
the userspace application (lttng-ust) is becoming fully functional
therefore cannot be captured as ust_baddr:push/pop events.

For that reason we have the statedump mechanism (*) that complements
shared object tracing by telling us what was happening (in respect to
shared library loading) *before* we started (or before we were able) to
trace calls to dlopen/dlclose. Only the two complementary approaches
combined together give you the full picture of shared library loading.

(*) The statedump mechanism iterates the currently open shared objects
with dl_iterate_phdr (see: http://linux.die.net/man/3/dl_iterate_phdr).

BTW, I get a slight different result when I trace glxgears (see attached
glxgears_baddr.txt). I wonder what the reason is.

> - As Matthew suggested, we could also hijack dlsym(), and with its
> parameters we could match a symbol name to an address. This becomes
> immensely useful when coupled with the ust-cyg-profile instrumentation,
> so we can get information about about function names directly in the
> trace! (but ironically, only for the dlopened libraries, and not the
> main binary). What do you think of this approach?

IMHO, hijacking dlsym() is not helping. The only thing you would know is
that somewhere in your code for some reason the address for some symbol
was requested via dlsym(). This will not help you to get symbol
resolution for ust-cyg-profile instrumentation.

In fact, the solution I present already contains all the information
needed to provide full symbol resolution for any address during the
whole lifetime of the traced application. To prove that I have attached
a dump of our trace viewer that shows all the symbols resolved for a
small forking web server example (traced with ust-cyg-profile and custom
tracepoints + ip context enabled) . See attached server_sample.csv and
server_sample_resolved.csv.

> In any case, it's quite interesting!

Thanks!

--
Paul

>
> Cheers,
> Alexandre
>
>
>
> On 13-11-11 10:28 AM, Paul Woegerer wrote:
>> The following two patches implement https://bugs.lttng.org/issues/474
>>
>> The first patch provides tracing of dlopen/dlclose calls with the use of an
>> LD_PRELOAD library (liblttng-ust-dl.so) using the following events:
>>
>>  ust_baddr:push(void *baddr, const char*sopath, int64_t size, int64_t mtime)
>>  ust_baddr:pop(void *baddr)
>>
>> The second patch adds support for tracing the whole state of currently loaded
>> shared objects at session-enable time. The corresponding events are only
>> emitted into the session that got enabled. The following event is used: 
>>
>>  ust_baddr_statedump (same args as ust_baddr:push)
>>
>>
>> Paul Woegerer (2):
>>   Base-address tracing for dlopen and dlclose
>>   Implement base-address-state tracing
>>
>>  Makefile.am                              |   2 +
>>  configure.ac                             |   2 +
>>  include/Makefile.am                      |   1 +
>>  include/lttng/tracepoint.h               |  12 +--
>>  include/lttng/ust-dl.h                   |  54 ++++++++++++
>>  include/lttng/ust-tracepoint-event.h     |  14 +++
>>  liblttng-ust-baddr/Makefile.am           |  20 +++++
>>  liblttng-ust-baddr/lttng-ust-baddr.c     | 111 ++++++++++++++++++++++++
>>  liblttng-ust-baddr/ust_baddr.c           |  20 +++++
>>  liblttng-ust-baddr/ust_baddr.h           |  66 ++++++++++++++
>>  liblttng-ust-baddr/ust_baddr_statedump.c |  21 +++++
>>  liblttng-ust-baddr/ust_baddr_statedump.h |  60 +++++++++++++
>>  liblttng-ust-dl/Makefile.am              |  17 ++++
>>  liblttng-ust-dl/ustdl.c                  | 144 +++++++++++++++++++++++++++++++
>>  liblttng-ust/lttng-events.c              |  10 +++
>>  liblttng-ust/lttng-tracer-core.h         |   2 +
>>  liblttng-ust/lttng-ust-comm.c            |  52 +++++++++++
>>  17 files changed, 603 insertions(+), 5 deletions(-)
>>  create mode 100644 include/lttng/ust-dl.h
>>  create mode 100644 liblttng-ust-baddr/Makefile.am
>>  create mode 100644 liblttng-ust-baddr/lttng-ust-baddr.c
>>  create mode 100644 liblttng-ust-baddr/ust_baddr.c
>>  create mode 100644 liblttng-ust-baddr/ust_baddr.h
>>  create mode 100644 liblttng-ust-baddr/ust_baddr_statedump.c
>>  create mode 100644 liblttng-ust-baddr/ust_baddr_statedump.h
>>  create mode 100644 liblttng-ust-dl/Makefile.am
>>  create mode 100644 liblttng-ust-dl/ustdl.c
>>


-- 
Paul Woegerer, SW Development Engineer
Sourcery Analyzer <http://go.mentor.com/sourceryanalyzer>
Mentor Graphics, Embedded Software Division


--------------040105000004000205010803
Content-Type: text/plain; charset="UTF-8"; name="glxgears_baddr.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="glxgears_baddr.txt"

pwoegere@atv-pwoegere-l3:~> lttng create
Session auto-20131113-092537 created.
Traces will be written in /home/pwoegere/lttng-traces/auto-20131113-092537
pwoegere@atv-pwoegere-l3:~> lttng enable-event -u -a
All UST events are enabled in channel channel0
pwoegere@atv-pwoegere-l3:~> lttng start
Tracing started for session auto-20131113-092537
pwoegere@atv-pwoegere-l3:~> LD_PRELOAD=liblttng-ust-dl.so /usr/bin/glxgears
Running synchronized to the vertical refresh.  The framerate should be
approximately the same as the monitor refresh rate.
301 frames in 5.0 seconds = 60.060 FPS
XIO:  fatal IO error 11 (Resource temporarily unavailable) on X server ":0"
      after 1515 requests (1515 known processed) with 0 events remaining.
pwoegere@atv-pwoegere-l3:~> lttng stop
Waiting for data availability.
Tracing stopped for session auto-20131113-092537
pwoegere@atv-pwoegere-l3:~> lttng view
Trace directory: /home/pwoegere/lttng-traces/auto-20131113-092537

[warning] Skipping directory 'index' found in trace
[09:27:04.774912693] (+?.?????????) atv-pwoegere-l3.atv.mentorg.com ust_baddr_statedump:soinfo: { cpu_id = 5 }, { baddr = 0x400000, sopath = "/usr/lib64/mesa-demos/xdemos/glxgears", size = 23360, mtime = 1381596745 }
[09:27:04.774922939] (+0.000010246) atv-pwoegere-l3.atv.mentorg.com ust_baddr_statedump:soinfo: { cpu_id = 5 }, { baddr = 0x7FFF8A1DD000, sopath = "[linux-vdso.so.1]", size = 0, mtime = -1 }
[09:27:04.774930406] (+0.000007467) atv-pwoegere-l3.atv.mentorg.com ust_baddr_statedump:soinfo: { cpu_id = 5 }, { baddr = 0x7F8E2AA4E000, sopath = "/home/pwoegere/MGC/lttng2_stack_latest_install/lib64/liblttng-ust-dl.so.0.0.0", size = 21500, mtime = 1384181281 }
[09:27:04.774936424] (+0.000006018) atv-pwoegere-l3.atv.mentorg.com ust_baddr_statedump:soinfo: { cpu_id = 5 }, { baddr = 0x7F8E2A7F0000, sopath = "/usr/lib64/libGL.so.1.2.0", size = 380976, mtime = 1382866191 }
[09:27:04.774940192] (+0.000003768) atv-pwoegere-l3.atv.mentorg.com ust_baddr_statedump:soinfo: { cpu_id = 5 }, { baddr = 0x7F8E2A4F2000, sopath = "/lib64/libm-2.17.so", size = 1109606, mtime = 1379513990 }
[09:27:04.774945488] (+0.000005296) atv-pwoegere-l3.atv.mentorg.com ust_baddr_statedump:soinfo: { cpu_id = 5 }, { baddr = 0x7F8E2A1B6000, sopath = "/usr/lib64/libX11.so.6.3.0", size = 1294064, mtime = 1380577077 }
[09:27:04.774948793] (+0.000003305) atv-pwoegere-l3.atv.mentorg.com ust_baddr_statedump:soinfo: { cpu_id = 5 }, { baddr = 0x7F8E29E08000, sopath = "/lib64/libc-2.17.so", size = 1996294, mtime = 1379513989 }
[09:27:04.774955069] (+0.000006276) atv-pwoegere-l3.atv.mentorg.com ust_baddr_statedump:soinfo: { cpu_id = 5 }, { baddr = 0x7F8E29BBF000, sopath = "/home/pwoegere/MGC/lttng2_stack_latest_install/lib64/liblttng-ust.so.0.0.0", size = 1611934, mtime = 1384181281 }
[09:27:04.774961151] (+0.000006082) atv-pwoegere-l3.atv.mentorg.com ust_baddr_statedump:soinfo: { cpu_id = 5 }, { baddr = 0x7F8E299A5000, sopath = "/home/pwoegere/MGC/lttng2_stack_latest_install/lib64/liblttng-ust-tracepoint.so.0.0.0", size = 138864, mtime = 1384181280 }
[09:27:04.774964667] (+0.000003516) atv-pwoegere-l3.atv.mentorg.com ust_baddr_statedump:soinfo: { cpu_id = 5 }, { baddr = 0x7F8E2979D000, sopath = "/lib64/librt-2.17.so", size = 42706, mtime = 1379513990 }
[09:27:04.774967809] (+0.000003142) atv-pwoegere-l3.atv.mentorg.com ust_baddr_statedump:soinfo: { cpu_id = 5 }, { baddr = 0x7F8E29599000, sopath = "/lib64/libdl-2.17.so", size = 19016, mtime = 1379513990 }
[09:27:04.774973714] (+0.000005905) atv-pwoegere-l3.atv.mentorg.com ust_baddr_statedump:soinfo: { cpu_id = 5 }, { baddr = 0x7F8E29392000, sopath = "/home/pwoegere/MGC/lttng2_stack_latest_install/lib64/liburcu-bp.so.2.0.0", size = 108574, mtime = 1381992197 }
[09:27:04.774979504] (+0.000005790) atv-pwoegere-l3.atv.mentorg.com ust_baddr_statedump:soinfo: { cpu_id = 5 }, { baddr = 0x7F8E2918A000, sopath = "/home/pwoegere/MGC/lttng2_stack_latest_install/lib64/liburcu-cds.so.2.0.0", size = 162940, mtime = 1381992197 }
[09:27:04.774985314] (+0.000005810) atv-pwoegere-l3.atv.mentorg.com ust_baddr_statedump:soinfo: { cpu_id = 5 }, { baddr = 0x7F8E28F86000, sopath = "/home/pwoegere/MGC/lttng2_stack_latest_install/lib64/liburcu-common.so.2.0.0", size = 86456, mtime = 1381992197 }
[09:27:04.774988677] (+0.000003363) atv-pwoegere-l3.atv.mentorg.com ust_baddr_statedump:soinfo: { cpu_id = 5 }, { baddr = 0x7F8E28D6A000, sopath = "/lib64/libpthread-2.17.so", size = 131133, mtime = 1379513990 }
[09:27:04.774992806] (+0.000004129) atv-pwoegere-l3.atv.mentorg.com ust_baddr_statedump:soinfo: { cpu_id = 5 }, { baddr = 0x7F8E28B44000, sopath = "/usr/lib64/libglapi.so.0.0.0", size = 150016, mtime = 1382866195 }
[09:27:04.774996621] (+0.000003815) atv-pwoegere-l3.atv.mentorg.com ust_baddr_statedump:soinfo: { cpu_id = 5 }, { baddr = 0x7F8E28932000, sopath = "/usr/lib64/libXext.so.6.4.0", size = 73864, mtime = 1380578949 }
[09:27:04.775000324] (+0.000003703) atv-pwoegere-l3.atv.mentorg.com ust_baddr_statedump:soinfo: { cpu_id = 5 }, { baddr = 0x7F8E2872F000, sopath = "/usr/lib64/libXdamage.so.1.1.0", size = 10424, mtime = 1380582326 }
[09:27:04.775004059] (+0.000003735) atv-pwoegere-l3.atv.mentorg.com ust_baddr_statedump:soinfo: { cpu_id = 5 }, { baddr = 0x7F8E28529000, sopath = "/usr/lib64/libXfixes.so.3.1.0", size = 22736, mtime = 1380579302 }
[09:27:04.775008109] (+0.000004050) atv-pwoegere-l3.atv.mentorg.com ust_baddr_statedump:soinfo: { cpu_id = 5 }, { baddr = 0x7F8E28327000, sopath = "/usr/lib64/libX11-xcb.so.1.0.0", size = 6160, mtime = 1380577076 }
[09:27:04.775013524] (+0.000005415) atv-pwoegere-l3.atv.mentorg.com ust_baddr_statedump:soinfo: { cpu_id = 5 }, { baddr = 0x7F8E2810F000, sopath = "/usr/lib64/libxcb-glx.so.0.0.0", size = 96464, mtime = 1382344054 }
[09:27:04.775017240] (+0.000003716) atv-pwoegere-l3.atv.mentorg.com ust_baddr_statedump:soinfo: { cpu_id = 5 }, { baddr = 0x7F8E27F0A000, sopath = "/usr/lib64/libxcb-dri2.so.0.0.0", size = 18656, mtime = 1382344054 }
[09:27:04.775022385] (+0.000005145) atv-pwoegere-l3.atv.mentorg.com ust_baddr_statedump:soinfo: { cpu_id = 5 }, { baddr = 0x7F8E27CEA000, sopath = "/usr/lib64/libxcb.so.1.1.0", size = 129920, mtime = 1382344056 }
[09:27:04.775026302] (+0.000003917) atv-pwoegere-l3.atv.mentorg.com ust_baddr_statedump:soinfo: { cpu_id = 5 }, { baddr = 0x7F8E27AE4000, sopath = "/usr/lib64/libXxf86vm.so.1.0.0", size = 22912, mtime = 1380582136 }
[09:27:04.775030152] (+0.000003850) atv-pwoegere-l3.atv.mentorg.com ust_baddr_statedump:soinfo: { cpu_id = 5 }, { baddr = 0x7F8E278D8000, sopath = "/usr/lib64/libdrm.so.2.4.0", size = 47696, mtime = 1382865247 }
[09:27:04.775033421] (+0.000003269) atv-pwoegere-l3.atv.mentorg.com ust_baddr_statedump:soinfo: { cpu_id = 5 }, { baddr = 0x7F8E2AC51000, sopath = "/lib64/ld-2.17.so", size = 163493, mtime = 1379513989 }
[09:27:04.775037205] (+0.000003784) atv-pwoegere-l3.atv.mentorg.com ust_baddr_statedump:soinfo: { cpu_id = 5 }, { baddr = 0x7F8E276D4000, sopath = "/usr/lib64/libXau.so.6.0.0", size = 14640, mtime = 1380536554 }
[09:27:04.775042540] (+0.000005335) atv-pwoegere-l3.atv.mentorg.com ust_baddr_statedump:soinfo: { cpu_id = 5 }, { baddr = 0x7F8E26100000, sopath = "/home/pwoegere/MGC/lttng2_stack_latest_install/lib64/liblttng-ust-baddr.so.0.0.0", size = 77469, mtime = 1384181281 }
[09:27:04.776345452] (+0.001302912) atv-pwoegere-l3.atv.mentorg.com ust_baddr:push: { cpu_id = 4 }, { baddr = 0x7F8E2A7F0000, sopath = "/usr/lib64/libGL.so.1.2.0", size = 380976, mtime = 1382866191 }
[09:27:04.795393509] (+0.019048057) atv-pwoegere-l3.atv.mentorg.com ust_baddr:push: { cpu_id = 4 }, { baddr = 0x7F8E256DD000, sopath = "/usr/lib64/dri/r600_dri.so", size = 6560344, mtime = 1382866182 }
[09:27:04.795397917] (+0.000004408) atv-pwoegere-l3.atv.mentorg.com ust_baddr:pop: { cpu_id = 4 }, { baddr = 0x7F8E2A7F0000 }
pwoegere@atv-pwoegere-l3:~> lttng destroy
Session auto-20131113-092537 destroyed


--------------040105000004000205010803
Content-Type: text/csv; name="server_sample.csv"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="server_sample.csv"

1h 35m 42.232342134s,ust.ust_baddr_statedump:soinfo,CPU 5,baddr=0x400000,sopath=/home/pwoegere/MGC/SA/git-trunk/source/systems/ust/features/com.mentor.embedded.profiler.feature.system.ust.samples/server_sample/server_sample,size=162591,mtime=1384181347,$pid=4489,$procname=server_sample
1h 35m 42.232357497s,ust.ust_baddr_statedump:soinfo,CPU 5,baddr=0x7FFF457FE000,sopath=[linux-vdso.so.1],size=0,mtime=-1,$pid=4489,$procname=server_sample
1h 35m 42.232368742s,ust.ust_baddr_statedump:soinfo,CPU 5,baddr=0x7F7957118000,sopath=/home/pwoegere/MGC/lttng2_stack_latest_install/lib64/liblttng-ust-fork.so.0.0.0,size=20700,mtime=1384181281,$pid=4489,$procname=server_sample
1h 35m 42.232375096s,ust.ust_baddr_statedump:soinfo,CPU 5,baddr=0x7F7956F14000,sopath=/home/pwoegere/MGC/lttng2_stack_latest_install/lib64/liblttng-ust-cyg-profile.so.0.0.0,size=45245,mtime=1384181281,$pid=4489,$procname=server_sample
1h 35m 42.232380789s,ust.ust_baddr_statedump:soinfo,CPU 5,baddr=0x7F7956D11000,sopath=/home/pwoegere/MGC/lttng2_stack_latest_install/lib64/liblttng-ust-dl.so.0.0.0,size=21500,mtime=1384181281,$pid=4489,$procname=server_sample
1h 35m 42.232389337s,ust.ust_baddr_statedump:soinfo,CPU 5,baddr=0x7F7956B0C000,sopath=/home/pwoegere/MGC/SA/git-trunk/source/systems/ust/features/com.mentor.embedded.profiler.feature.system.ust.samples/server_sample/libtrace_requests.so,size=164908,mtime=1384181347,$pid=4489,$procname=server_sample
1h 35m 42.232394982s,ust.ust_baddr_statedump:soinfo,CPU 5,baddr=0x7F79568C3000,sopath=/home/pwoegere/MGC/lttng2_stack_latest_install/lib64/liblttng-ust.so.0.0.0,size=1611934,mtime=1384181281,$pid=4489,$procname=server_sample
1h 35m 42.232398777s,ust.ust_baddr_statedump:soinfo,CPU 5,baddr=0x7F79566BF000,sopath=/lib64/libdl-2.17.so,size=19016,mtime=1379513990,$pid=4489,$procname=server_sample
1h 35m 42.232401855s,ust.ust_baddr_statedump:soinfo,CPU 5,baddr=0x7F7956311000,sopath=/lib64/libc-2.17.so,size=1996294,mtime=1379513989,$pid=4489,$procname=server_sample
1h 35m 42.232407498s,ust.ust_baddr_statedump:soinfo,CPU 5,baddr=0x7F79560F7000,sopath=/home/pwoegere/MGC/lttng2_stack_latest_install/lib64/liblttng-ust-tracepoint.so.0.0.0,size=138864,mtime=1384181280,$pid=4489,$procname=server_sample
1h 35m 42.232410590s,ust.ust_baddr_statedump:soinfo,CPU 5,baddr=0x7F7955EEF000,sopath=/lib64/librt-2.17.so,size=42706,mtime=1379513990,$pid=4489,$procname=server_sample
1h 35m 42.232416073s,ust.ust_baddr_statedump:soinfo,CPU 5,baddr=0x7F7955CE8000,sopath=/home/pwoegere/MGC/lttng2_stack_latest_install/lib64/liburcu-bp.so.2.0.0,size=108574,mtime=1381992197,$pid=4489,$procname=server_sample
1h 35m 42.232421604s,ust.ust_baddr_statedump:soinfo,CPU 5,baddr=0x7F7955AE0000,sopath=/home/pwoegere/MGC/lttng2_stack_latest_install/lib64/liburcu-cds.so.2.0.0,size=162940,mtime=1381992197,$pid=4489,$procname=server_sample
1h 35m 42.232427497s,ust.ust_baddr_statedump:soinfo,CPU 5,baddr=0x7F79558DC000,sopath=/home/pwoegere/MGC/lttng2_stack_latest_install/lib64/liburcu-common.so.2.0.0,size=86456,mtime=1381992197,$pid=4489,$procname=server_sample
1h 35m 42.232430848s,ust.ust_baddr_statedump:soinfo,CPU 5,baddr=0x7F79556C0000,sopath=/lib64/libpthread-2.17.so,size=131133,mtime=1379513990,$pid=4489,$procname=server_sample
1h 35m 42.232433943s,ust.ust_baddr_statedump:soinfo,CPU 5,baddr=0x7F795731B000,sopath=/lib64/ld-2.17.so,size=163493,mtime=1379513989,$pid=4489,$procname=server_sample
1h 35m 42.232438810s,ust.ust_baddr_statedump:soinfo,CPU 5,baddr=0x7F79544B8000,sopath=/home/pwoegere/MGC/lttng2_stack_latest_install/lib64/liblttng-ust-baddr.so.0.0.0,size=77469,mtime=1384181281,$pid=4489,$procname=server_sample
1h 35m 42.232692010s,ust.lttng_ust_cyg_profile:func_entry,CPU 0,addr=0x401E78,call_site=0x7F7956332A15,$pid=4489,$procname=server_sample,trace_context.vtid=4489
1h 35m 42.232697707s,ust.lttng_ust_cyg_profile:func_entry,CPU 0,addr=0x402E52,call_site=0x401ECC,$pid=4489,$procname=server_sample,trace_context.vtid=4489
1h 35m 42.232712279s,ust.lttng_ust_cyg_profile:func_entry,CPU 0,addr=0x402E12,call_site=0x402ECB,$pid=4489,$procname=server_sample,trace_context.vtid=4489
1h 35m 42.232714008s,ust.lttng_ust_cyg_profile:func_exit,CPU 0,addr=0x402E12,call_site=0x402ECB,$pid=4489,$procname=server_sample,trace_context.vtid=4489
1h 35m 42.232715439s,ust.lttng_ust_cyg_profile:func_exit,CPU 0,addr=0x402E52,call_site=0x401ECC,$pid=4489,$procname=server_sample,trace_context.vtid=4489
1h 35m 42.232722715s,ust.lttng_ust_cyg_profile:func_entry,CPU 0,addr=0x402542,call_site=0x402162,$pid=4489,$procname=server_sample,trace_context.vtid=4489
1h 35m 47.990936990s,ust.ust_baddr_statedump:soinfo,CPU 7,baddr=0x400000,sopath=/home/pwoegere/MGC/SA/git-trunk/source/systems/ust/features/com.mentor.embedded.profiler.feature.system.ust.samples/server_sample/server_sample,size=162591,mtime=1384181347,$pid=4583,$procname=server_sample
1h 35m 47.990949418s,ust.ust_baddr_statedump:soinfo,CPU 7,baddr=0x7FFF457FE000,sopath=[linux-vdso.so.1],size=0,mtime=-1,$pid=4583,$procname=server_sample
1h 35m 47.990963601s,ust.ust_baddr_statedump:soinfo,CPU 7,baddr=0x7F7957118000,sopath=/home/pwoegere/MGC/lttng2_stack_latest_install/lib64/liblttng-ust-fork.so.0.0.0,size=20700,mtime=1384181281,$pid=4583,$procname=server_sample
1h 35m 47.990971319s,ust.ust_baddr_statedump:soinfo,CPU 7,baddr=0x7F7956F14000,sopath=/home/pwoegere/MGC/lttng2_stack_latest_install/lib64/liblttng-ust-cyg-profile.so.0.0.0,size=45245,mtime=1384181281,$pid=4583,$procname=server_sample
1h 35m 47.990978454s,ust.ust_baddr_statedump:soinfo,CPU 7,baddr=0x7F7956D11000,sopath=/home/pwoegere/MGC/lttng2_stack_latest_install/lib64/liblttng-ust-dl.so.0.0.0,size=21500,mtime=1384181281,$pid=4583,$procname=server_sample
1h 35m 47.990989415s,ust.ust_baddr_statedump:soinfo,CPU 7,baddr=0x7F7956B0C000,sopath=/home/pwoegere/MGC/SA/git-trunk/source/systems/ust/features/com.mentor.embedded.profiler.feature.system.ust.samples/server_sample/libtrace_requests.so,size=164908,mtime=1384181347,$pid=4583,$procname=server_sample
1h 35m 47.990996861s,ust.ust_baddr_statedump:soinfo,CPU 7,baddr=0x7F79568C3000,sopath=/home/pwoegere/MGC/lttng2_stack_latest_install/lib64/liblttng-ust.so.0.0.0,size=1611934,mtime=1384181281,$pid=4583,$procname=server_sample
1h 35m 47.991007134s,ust.ust_baddr_statedump:soinfo,CPU 7,baddr=0x7F79566BF000,sopath=/lib64/libdl-2.17.so,size=19016,mtime=1379513990,$pid=4583,$procname=server_sample
1h 35m 47.991011156s,ust.ust_baddr_statedump:soinfo,CPU 7,baddr=0x7F7956311000,sopath=/lib64/libc-2.17.so,size=1996294,mtime=1379513989,$pid=4583,$procname=server_sample
1h 35m 47.991018438s,ust.ust_baddr_statedump:soinfo,CPU 7,baddr=0x7F79560F7000,sopath=/home/pwoegere/MGC/lttng2_stack_latest_install/lib64/liblttng-ust-tracepoint.so.0.0.0,size=138864,mtime=1384181280,$pid=4583,$procname=server_sample
1h 35m 47.991022400s,ust.ust_baddr_statedump:soinfo,CPU 7,baddr=0x7F7955EEF000,sopath=/lib64/librt-2.17.so,size=42706,mtime=1379513990,$pid=4583,$procname=server_sample
1h 35m 47.991029267s,ust.ust_baddr_statedump:soinfo,CPU 7,baddr=0x7F7955CE8000,sopath=/home/pwoegere/MGC/lttng2_stack_latest_install/lib64/liburcu-bp.so.2.0.0,size=108574,mtime=1381992197,$pid=4583,$procname=server_sample
1h 35m 47.991036181s,ust.ust_baddr_statedump:soinfo,CPU 7,baddr=0x7F7955AE0000,sopath=/home/pwoegere/MGC/lttng2_stack_latest_install/lib64/liburcu-cds.so.2.0.0,size=162940,mtime=1381992197,$pid=4583,$procname=server_sample
1h 35m 47.991043088s,ust.ust_baddr_statedump:soinfo,CPU 7,baddr=0x7F79558DC000,sopath=/home/pwoegere/MGC/lttng2_stack_latest_install/lib64/liburcu-common.so.2.0.0,size=86456,mtime=1381992197,$pid=4583,$procname=server_sample
1h 35m 47.991047148s,ust.ust_baddr_statedump:soinfo,CPU 7,baddr=0x7F79556C0000,sopath=/lib64/libpthread-2.17.so,size=131133,mtime=1379513990,$pid=4583,$procname=server_sample
1h 35m 47.991050854s,ust.ust_baddr_statedump:soinfo,CPU 7,baddr=0x7F795731B000,sopath=/lib64/ld-2.17.so,size=163493,mtime=1379513989,$pid=4583,$procname=server_sample
1h 35m 47.991059055s,ust.ust_baddr_statedump:soinfo,CPU 7,baddr=0x7F79544B8000,sopath=/home/pwoegere/MGC/lttng2_stack_latest_install/lib64/liblttng-ust-baddr.so.0.0.0,size=77469,mtime=1384181281,$pid=4583,$procname=server_sample
1h 35m 47.991134466s,ust.lttng_ust_cyg_profile:func_entry,CPU 6,addr=0x402375,call_site=0x402769,$pid=4583,$procname=server_sample,trace_context.vtid=4583
1h 35m 47.991165738s,ust.lttng_ust_cyg_profile:func_entry,CPU 6,addr=0x402190,call_site=0x402511,$pid=4583,$procname=server_sample,trace_context.vtid=4583
1h 35m 47.991169619s,ust.server_request:start,CPU 6,url=/run_hello,$pid=4583,$procname=server_sample,trace_context.ip=0x40221E
1h 35m 47.991177452s,ust.lttng_ust_cyg_profile:func_entry,CPU 6,addr=0x402AF2,call_site=0x402299,$pid=4583,$procname=server_sample,trace_context.vtid=4583
1h 35m 47.991180017s,ust.server_request:module_open,CPU 6,soname=run_hello.so,$pid=4583,$procname=server_sample,trace_context.ip=0x402B63
1h 35m 47.991180969s,ust.lttng_ust_cyg_profile:func_entry,CPU 6,addr=0x402E12,call_site=0x402BB0,$pid=4583,$procname=server_sample,trace_context.vtid=4583
1h 35m 47.991182842s,ust.lttng_ust_cyg_profile:func_exit,CPU 6,addr=0x402E12,call_site=0x402BB0,$pid=4583,$procname=server_sample,trace_context.vtid=4583
1h 35m 47.991563919s,ust.ust_baddr:push,CPU 0,baddr=0x7F79542B5000,sopath=/home/pwoegere/MGC/SA/git-trunk/source/systems/ust/features/com.mentor.embedded.profiler.feature.system.ust.samples/server_sample/run_hello.so,size=88660,mtime=1384181347,$pid=4583,$procname=server_sample
1h 35m 47.991571874s,ust.server_request:module_open_success,CPU 0,soname=run_hello.so,$pid=4583,$procname=server_sample,trace_context.ip=0x402C2B
1h 35m 47.991578000s,ust.lttng_ust_cyg_profile:func_entry,CPU 0,addr=0x402E12,call_site=0x402C74,$pid=4583,$procname=server_sample,trace_context.vtid=4583
1h 35m 47.991581609s,ust.lttng_ust_cyg_profile:func_exit,CPU 0,addr=0x402E12,call_site=0x402C74,$pid=4583,$procname=server_sample,trace_context.vtid=4583
1h 35m 47.991582301s,ust.lttng_ust_cyg_profile:func_entry,CPU 0,addr=0x402D72,call_site=0x402C82,$pid=4583,$procname=server_sample,trace_context.vtid=4583
1h 35m 47.991584122s,ust.lttng_ust_cyg_profile:func_exit,CPU 0,addr=0x402D72,call_site=0x402C82,$pid=4583,$procname=server_sample,trace_context.vtid=4583
1h 35m 47.991584539s,ust.lttng_ust_cyg_profile:func_exit,CPU 0,addr=0x402AF2,call_site=0x402299,$pid=4583,$procname=server_sample,trace_context.vtid=4583
1h 35m 47.991630159s,ust.lttng_ust_cyg_profile:func_entry,CPU 0,addr=0x7F79542B6190,call_site=0x402303,$pid=4583,$procname=server_sample,trace_context.vtid=4583
1h 35m 47.991632412s,ust.server_request:send_response,CPU 0,options=,$pid=4583,$procname=server_sample,trace_context.ip=0x7F79542B6222
1h 35m 47.991644261s,ust.server_request:send_response_done,CPU 0,$pid=4583,$procname=server_sample,trace_context.ip=0x7F79542B628F
1h 35m 47.991644766s,ust.lttng_ust_cyg_profile:func_exit,CPU 0,addr=0x7F79542B6190,call_site=0x402303,$pid=4583,$procname=server_sample,trace_context.vtid=4583
1h 35m 47.991645324s,ust.lttng_ust_cyg_profile:func_entry,CPU 0,addr=0x402A98,call_site=0x40230B,$pid=4583,$procname=server_sample,trace_context.vtid=4583
1h 35m 47.991656322s,ust.ust_baddr:pop,CPU 0,baddr=0x7F79542B5000,$pid=4583,$procname=server_sample
1h 35m 47.991683799s,ust.lttng_ust_cyg_profile:func_exit,CPU 0,addr=0x402A98,call_site=0x40230B,$pid=4583,$procname=server_sample,trace_context.vtid=4583
1h 35m 47.991684696s,ust.lttng_ust_cyg_profile:func_exit,CPU 0,addr=0x402190,call_site=0x402511,$pid=4583,$procname=server_sample,trace_context.vtid=4583
1h 35m 47.991685079s,ust.lttng_ust_cyg_profile:func_exit,CPU 0,addr=0x402375,call_site=0x402769,$pid=4583,$procname=server_sample,trace_context.vtid=4583
1h 35m 47.992247329s,ust.lttng_ust_cyg_profile:func_entry,CPU 5,addr=0x40279B,call_site=0x7F7956346450,$pid=4489,$procname=server_sample,trace_context.vtid=4489
1h 35m 47.992267134s,ust.lttng_ust_cyg_profile:func_exit,CPU 5,addr=0x40279B,call_site=0x7F7956346450,$pid=4489,$procname=server_sample,trace_context.vtid=4489
1h 35m 51.762484533s,ust.ust_baddr_statedump:soinfo,CPU 2,baddr=0x400000,sopath=/home/pwoegere/MGC/SA/git-trunk/source/systems/ust/features/com.mentor.embedded.profiler.feature.system.ust.samples/server_sample/server_sample,size=162591,mtime=1384181347,$pid=4669,$procname=server_sample
1h 35m 51.762497943s,ust.ust_baddr_statedump:soinfo,CPU 2,baddr=0x7FFF457FE000,sopath=[linux-vdso.so.1],size=0,mtime=-1,$pid=4669,$procname=server_sample
1h 35m 51.762527960s,ust.ust_baddr_statedump:soinfo,CPU 2,baddr=0x7F7957118000,sopath=/home/pwoegere/MGC/lttng2_stack_latest_install/lib64/liblttng-ust-fork.so.0.0.0,size=20700,mtime=1384181281,$pid=4669,$procname=server_sample
1h 35m 51.762535962s,ust.ust_baddr_statedump:soinfo,CPU 2,baddr=0x7F7956F14000,sopath=/home/pwoegere/MGC/lttng2_stack_latest_install/lib64/liblttng-ust-cyg-profile.so.0.0.0,size=45245,mtime=1384181281,$pid=4669,$procname=server_sample
1h 35m 51.762543161s,ust.ust_baddr_statedump:soinfo,CPU 2,baddr=0x7F7956D11000,sopath=/home/pwoegere/MGC/lttng2_stack_latest_install/lib64/liblttng-ust-dl.so.0.0.0,size=21500,mtime=1384181281,$pid=4669,$procname=server_sample
1h 35m 51.762554347s,ust.ust_baddr_statedump:soinfo,CPU 2,baddr=0x7F7956B0C000,sopath=/home/pwoegere/MGC/SA/git-trunk/source/systems/ust/features/com.mentor.embedded.profiler.feature.system.ust.samples/server_sample/libtrace_requests.so,size=164908,mtime=1384181347,$pid=4669,$procname=server_sample
1h 35m 51.762561783s,ust.ust_baddr_statedump:soinfo,CPU 2,baddr=0x7F79568C3000,sopath=/home/pwoegere/MGC/lttng2_stack_latest_install/lib64/liblttng-ust.so.0.0.0,size=1611934,mtime=1384181281,$pid=4669,$procname=server_sample
1h 35m 51.762566398s,ust.ust_baddr_statedump:soinfo,CPU 2,baddr=0x7F79566BF000,sopath=/lib64/libdl-2.17.so,size=19016,mtime=1379513990,$pid=4669,$procname=server_sample
1h 35m 51.762570124s,ust.ust_baddr_statedump:soinfo,CPU 2,baddr=0x7F7956311000,sopath=/lib64/libc-2.17.so,size=1996294,mtime=1379513989,$pid=4669,$procname=server_sample
1h 35m 51.762577601s,ust.ust_baddr_statedump:soinfo,CPU 2,baddr=0x7F79560F7000,sopath=/home/pwoegere/MGC/lttng2_stack_latest_install/lib64/liblttng-ust-tracepoint.so.0.0.0,size=138864,mtime=1384181280,$pid=4669,$procname=server_sample
1h 35m 51.762581516s,ust.ust_baddr_statedump:soinfo,CPU 2,baddr=0x7F7955EEF000,sopath=/lib64/librt-2.17.so,size=42706,mtime=1379513990,$pid=4669,$procname=server_sample
1h 35m 51.762588688s,ust.ust_baddr_statedump:soinfo,CPU 2,baddr=0x7F7955CE8000,sopath=/home/pwoegere/MGC/lttng2_stack_latest_install/lib64/liburcu-bp.so.2.0.0,size=108574,mtime=1381992197,$pid=4669,$procname=server_sample
1h 35m 51.762595835s,ust.ust_baddr_statedump:soinfo,CPU 2,baddr=0x7F7955AE0000,sopath=/home/pwoegere/MGC/lttng2_stack_latest_install/lib64/liburcu-cds.so.2.0.0,size=162940,mtime=1381992197,$pid=4669,$procname=server_sample
1h 35m 51.762603101s,ust.ust_baddr_statedump:soinfo,CPU 2,baddr=0x7F79558DC000,sopath=/home/pwoegere/MGC/lttng2_stack_latest_install/lib64/liburcu-common.so.2.0.0,size=86456,mtime=1381992197,$pid=4669,$procname=server_sample
1h 35m 51.762607046s,ust.ust_baddr_statedump:soinfo,CPU 2,baddr=0x7F79556C0000,sopath=/lib64/libpthread-2.17.so,size=131133,mtime=1379513990,$pid=4669,$procname=server_sample
1h 35m 51.762610897s,ust.ust_baddr_statedump:soinfo,CPU 2,baddr=0x7F795731B000,sopath=/lib64/ld-2.17.so,size=163493,mtime=1379513989,$pid=4669,$procname=server_sample
1h 35m 51.762619364s,ust.ust_baddr_statedump:soinfo,CPU 2,baddr=0x7F79544B8000,sopath=/home/pwoegere/MGC/lttng2_stack_latest_install/lib64/liblttng-ust-baddr.so.0.0.0,size=77469,mtime=1384181281,$pid=4669,$procname=server_sample
1h 35m 51.762715395s,ust.lttng_ust_cyg_profile:func_entry,CPU 7,addr=0x402375,call_site=0x402769,$pid=4669,$procname=server_sample,trace_context.vtid=4669
1h 35m 51.762752436s,ust.lttng_ust_cyg_profile:func_entry,CPU 7,addr=0x402190,call_site=0x402511,$pid=4669,$procname=server_sample,trace_context.vtid=4669
1h 35m 51.762755854s,ust.server_request:start,CPU 7,url=/run_cmd?/usr/bin/df,$pid=4669,$procname=server_sample,trace_context.ip=0x40221E
1h 35m 51.762764086s,ust.lttng_ust_cyg_profile:func_entry,CPU 7,addr=0x402AF2,call_site=0x402299,$pid=4669,$procname=server_sample,trace_context.vtid=4669
1h 35m 51.762766657s,ust.server_request:module_open,CPU 7,soname=run_cmd.so,$pid=4669,$procname=server_sample,trace_context.ip=0x402B63
1h 35m 51.762767570s,ust.lttng_ust_cyg_profile:func_entry,CPU 7,addr=0x402E12,call_site=0x402BB0,$pid=4669,$procname=server_sample,trace_context.vtid=4669
1h 35m 51.762769237s,ust.lttng_ust_cyg_profile:func_exit,CPU 7,addr=0x402E12,call_site=0x402BB0,$pid=4669,$procname=server_sample,trace_context.vtid=4669
1h 35m 51.763560936s,ust.ust_baddr:push,CPU 0,baddr=0x7F79542B5000,sopath=/home/pwoegere/MGC/SA/git-trunk/source/systems/ust/features/com.mentor.embedded.profiler.feature.system.ust.samples/server_sample/run_cmd.so,size=90326,mtime=1384181347,$pid=4669,$procname=server_sample
1h 35m 51.763568461s,ust.server_request:module_open_success,CPU 0,soname=run_cmd.so,$pid=4669,$procname=server_sample,trace_context.ip=0x402C2B
1h 35m 51.763574005s,ust.lttng_ust_cyg_profile:func_entry,CPU 0,addr=0x402E12,call_site=0x402C74,$pid=4669,$procname=server_sample,trace_context.vtid=4669
1h 35m 51.763577332s,ust.lttng_ust_cyg_profile:func_exit,CPU 0,addr=0x402E12,call_site=0x402C74,$pid=4669,$procname=server_sample,trace_context.vtid=4669
1h 35m 51.763577952s,ust.lttng_ust_cyg_profile:func_entry,CPU 0,addr=0x402D72,call_site=0x402C82,$pid=4669,$procname=server_sample,trace_context.vtid=4669
1h 35m 51.763579463s,ust.lttng_ust_cyg_profile:func_exit,CPU 0,addr=0x402D72,call_site=0x402C82,$pid=4669,$procname=server_sample,trace_context.vtid=4669
1h 35m 51.763579850s,ust.lttng_ust_cyg_profile:func_exit,CPU 0,addr=0x402AF2,call_site=0x402299,$pid=4669,$procname=server_sample,trace_context.vtid=4669
1h 35m 51.763621495s,ust.lttng_ust_cyg_profile:func_entry,CPU 0,addr=0x7F79542B6430,call_site=0x402303,$pid=4669,$procname=server_sample,trace_context.vtid=4669
1h 35m 51.763622343s,ust.server_request:send_response,CPU 0,options=/usr/bin/df,$pid=4669,$procname=server_sample,trace_context.ip=0x7F79542B6494
1h 35m 51.814596840s,ust.ust_baddr_statedump:soinfo,CPU 6,baddr=0x400000,sopath=/home/pwoegere/MGC/SA/git-trunk/source/systems/ust/features/com.mentor.embedded.profiler.feature.system.ust.samples/server_sample/server_sample,size=162591,mtime=1384181347,$pid=4750,$procname=server_sample
1h 35m 51.814607365s,ust.ust_baddr_statedump:soinfo,CPU 6,baddr=0x7FFF457FE000,sopath=[linux-vdso.so.1],size=0,mtime=-1,$pid=4750,$procname=server_sample
1h 35m 51.814620947s,ust.ust_baddr_statedump:soinfo,CPU 6,baddr=0x7F7957118000,sopath=/home/pwoegere/MGC/lttng2_stack_latest_install/lib64/liblttng-ust-fork.so.0.0.0,size=20700,mtime=1384181281,$pid=4750,$procname=server_sample
1h 35m 51.814629113s,ust.ust_baddr_statedump:soinfo,CPU 6,baddr=0x7F7956F14000,sopath=/home/pwoegere/MGC/lttng2_stack_latest_install/lib64/liblttng-ust-cyg-profile.so.0.0.0,size=45245,mtime=1384181281,$pid=4750,$procname=server_sample
1h 35m 51.814636537s,ust.ust_baddr_statedump:soinfo,CPU 6,baddr=0x7F7956D11000,sopath=/home/pwoegere/MGC/lttng2_stack_latest_install/lib64/liblttng-ust-dl.so.0.0.0,size=21500,mtime=1384181281,$pid=4750,$procname=server_sample
1h 35m 51.814646928s,ust.ust_baddr_statedump:soinfo,CPU 6,baddr=0x7F7956B0C000,sopath=/home/pwoegere/MGC/SA/git-trunk/source/systems/ust/features/com.mentor.embedded.profiler.feature.system.ust.samples/server_sample/libtrace_requests.so,size=164908,mtime=1384181347,$pid=4750,$procname=server_sample
1h 35m 51.814654124s,ust.ust_baddr_statedump:soinfo,CPU 6,baddr=0x7F79568C3000,sopath=/home/pwoegere/MGC/lttng2_stack_latest_install/lib64/liblttng-ust.so.0.0.0,size=1611934,mtime=1384181281,$pid=4750,$procname=server_sample
1h 35m 51.814658280s,ust.ust_baddr_statedump:soinfo,CPU 6,baddr=0x7F79566BF000,sopath=/lib64/libdl-2.17.so,size=19016,mtime=1379513990,$pid=4750,$procname=server_sample
1h 35m 51.814662168s,ust.ust_baddr_statedump:soinfo,CPU 6,baddr=0x7F7956311000,sopath=/lib64/libc-2.17.so,size=1996294,mtime=1379513989,$pid=4750,$procname=server_sample
1h 35m 51.814669557s,ust.ust_baddr_statedump:soinfo,CPU 6,baddr=0x7F79560F7000,sopath=/home/pwoegere/MGC/lttng2_stack_latest_install/lib64/liblttng-ust-tracepoint.so.0.0.0,size=138864,mtime=1384181280,$pid=4750,$procname=server_sample
1h 35m 51.814674004s,ust.ust_baddr_statedump:soinfo,CPU 6,baddr=0x7F7955EEF000,sopath=/lib64/librt-2.17.so,size=42706,mtime=1379513990,$pid=4750,$procname=server_sample
1h 35m 51.814680849s,ust.ust_baddr_statedump:soinfo,CPU 6,baddr=0x7F7955CE8000,sopath=/home/pwoegere/MGC/lttng2_stack_latest_install/lib64/liburcu-bp.so.2.0.0,size=108574,mtime=1381992197,$pid=4750,$procname=server_sample
1h 35m 51.814688256s,ust.ust_baddr_statedump:soinfo,CPU 6,baddr=0x7F7955AE0000,sopath=/home/pwoegere/MGC/lttng2_stack_latest_install/lib64/liburcu-cds.so.2.0.0,size=162940,mtime=1381992197,$pid=4750,$procname=server_sample
1h 35m 51.814695041s,ust.ust_baddr_statedump:soinfo,CPU 6,baddr=0x7F79558DC000,sopath=/home/pwoegere/MGC/lttng2_stack_latest_install/lib64/liburcu-common.so.2.0.0,size=86456,mtime=1381992197,$pid=4750,$procname=server_sample
1h 35m 51.814699672s,ust.ust_baddr_statedump:soinfo,CPU 6,baddr=0x7F79556C0000,sopath=/lib64/libpthread-2.17.so,size=131133,mtime=1379513990,$pid=4750,$procname=server_sample
1h 35m 51.814703920s,ust.ust_baddr_statedump:soinfo,CPU 6,baddr=0x7F795731B000,sopath=/lib64/ld-2.17.so,size=163493,mtime=1379513989,$pid=4750,$procname=server_sample
1h 35m 51.814710735s,ust.ust_baddr_statedump:soinfo,CPU 6,baddr=0x7F79544B8000,sopath=/home/pwoegere/MGC/lttng2_stack_latest_install/lib64/liblttng-ust-baddr.so.0.0.0,size=77469,mtime=1384181281,$pid=4750,$procname=server_sample
1h 35m 51.814721766s,ust.ust_baddr_statedump:soinfo,CPU 6,baddr=0x7F79542B5000,sopath=/home/pwoegere/MGC/SA/git-trunk/source/systems/ust/features/com.mentor.embedded.profiler.feature.system.ust.samples/server_sample/run_cmd.so,size=90326,mtime=1384181347,$pid=4750,$procname=server_sample
1h 35m 52.062159384s,ust.ust_baddr_statedump:soinfo,CPU 6,baddr=0x400000,sopath=/usr/bin/df,size=81120,mtime=1359275285,$pid=4750,$procname=server_sample
1h 35m 52.062171222s,ust.ust_baddr_statedump:soinfo,CPU 6,baddr=0x7FFF985FE000,sopath=[linux-vdso.so.1],size=0,mtime=-1,$pid=4750,$procname=server_sample
1h 35m 52.062182205s,ust.ust_baddr_statedump:soinfo,CPU 6,baddr=0x7FD2E3768000,sopath=/home/pwoegere/MGC/lttng2_stack_latest_install/lib64/liblttng-ust-fork.so.0.0.0,size=20700,mtime=1384181281,$pid=4750,$procname=server_sample
1h 35m 52.062188193s,ust.ust_baddr_statedump:soinfo,CPU 6,baddr=0x7FD2E3564000,sopath=/home/pwoegere/MGC/lttng2_stack_latest_install/lib64/liblttng-ust-cyg-profile.so.0.0.0,size=45245,mtime=1384181281,$pid=4750,$procname=server_sample
1h 35m 52.062193818s,ust.ust_baddr_statedump:soinfo,CPU 6,baddr=0x7FD2E3361000,sopath=/home/pwoegere/MGC/lttng2_stack_latest_install/lib64/liblttng-ust-dl.so.0.0.0,size=21500,mtime=1384181281,$pid=4750,$procname=server_sample
1h 35m 52.062197487s,ust.ust_baddr_statedump:soinfo,CPU 6,baddr=0x7FD2E2FB3000,sopath=/lib64/libc-2.17.so,size=1996294,mtime=1379513989,$pid=4750,$procname=server_sample
1h 35m 52.062202944s,ust.ust_baddr_statedump:soinfo,CPU 6,baddr=0x7FD2E2D6A000,sopath=/home/pwoegere/MGC/lttng2_stack_latest_install/lib64/liblttng-ust.so.0.0.0,size=1611934,mtime=1384181281,$pid=4750,$procname=server_sample
1h 35m 52.062208630s,ust.ust_baddr_statedump:soinfo,CPU 6,baddr=0x7FD2E2B50000,sopath=/home/pwoegere/MGC/lttng2_stack_latest_install/lib64/liblttng-ust-tracepoint.so.0.0.0,size=138864,mtime=1384181280,$pid=4750,$procname=server_sample
1h 35m 52.062211928s,ust.ust_baddr_statedump:soinfo,CPU 6,baddr=0x7FD2E2948000,sopath=/lib64/librt-2.17.so,size=42706,mtime=1379513990,$pid=4750,$procname=server_sample
1h 35m 52.062214794s,ust.ust_baddr_statedump:soinfo,CPU 6,baddr=0x7FD2E2744000,sopath=/lib64/libdl-2.17.so,size=19016,mtime=1379513990,$pid=4750,$procname=server_sample
1h 35m 52.062220346s,ust.ust_baddr_statedump:soinfo,CPU 6,baddr=0x7FD2E253D000,sopath=/home/pwoegere/MGC/lttng2_stack_latest_install/lib64/liburcu-bp.so.2.0.0,size=108574,mtime=1381992197,$pid=4750,$procname=server_sample
1h 35m 52.062225720s,ust.ust_baddr_statedump:soinfo,CPU 6,baddr=0x7FD2E2335000,sopath=/home/pwoegere/MGC/lttng2_stack_latest_install/lib64/liburcu-cds.so.2.0.0,size=162940,mtime=1381992197,$pid=4750,$procname=server_sample
1h 35m 52.062231136s,ust.ust_baddr_statedump:soinfo,CPU 6,baddr=0x7FD2E2131000,sopath=/home/pwoegere/MGC/lttng2_stack_latest_install/lib64/liburcu-common.so.2.0.0,size=86456,mtime=1381992197,$pid=4750,$procname=server_sample
1h 35m 52.062234279s,ust.ust_baddr_statedump:soinfo,CPU 6,baddr=0x7FD2E1F15000,sopath=/lib64/libpthread-2.17.so,size=131133,mtime=1379513990,$pid=4750,$procname=server_sample
1h 35m 52.062237238s,ust.ust_baddr_statedump:soinfo,CPU 6,baddr=0x7FD2E396B000,sopath=/lib64/ld-2.17.so,size=163493,mtime=1379513989,$pid=4750,$procname=server_sample
1h 35m 52.062241934s,ust.ust_baddr_statedump:soinfo,CPU 6,baddr=0x7FD2E0D0D000,sopath=/home/pwoegere/MGC/lttng2_stack_latest_install/lib64/liblttng-ust-baddr.so.0.0.0,size=77469,mtime=1384181281,$pid=4750,$procname=server_sample
1h 35m 52.063675099s,ust.lttng_ust_cyg_profile:func_entry,CPU 0,addr=0x40279B,call_site=0x7F7956346450,$pid=4669,$procname=server_sample,trace_context.vtid=4669
1h 35m 52.063691096s,ust.lttng_ust_cyg_profile:func_exit,CPU 0,addr=0x40279B,call_site=0x7F7956346450,$pid=4669,$procname=server_sample,trace_context.vtid=4669
1h 35m 52.063826184s,ust.server_request:send_response_done,CPU 0,$pid=4669,$procname=server_sample,trace_context.ip=0x7F79542B6645
1h 35m 52.063827827s,ust.lttng_ust_cyg_profile:func_exit,CPU 0,addr=0x7F79542B6430,call_site=0x402303,$pid=4669,$procname=server_sample,trace_context.vtid=4669
1h 35m 52.063831771s,ust.lttng_ust_cyg_profile:func_entry,CPU 0,addr=0x402A98,call_site=0x40230B,$pid=4669,$procname=server_sample,trace_context.vtid=4669
1h 35m 52.063844778s,ust.ust_baddr:pop,CPU 0,baddr=0x7F79542B5000,$pid=4669,$procname=server_sample
1h 35m 52.063885313s,ust.lttng_ust_cyg_profile:func_exit,CPU 0,addr=0x402A98,call_site=0x40230B,$pid=4669,$procname=server_sample,trace_context.vtid=4669
1h 35m 52.063886055s,ust.lttng_ust_cyg_profile:func_exit,CPU 0,addr=0x402190,call_site=0x402511,$pid=4669,$procname=server_sample,trace_context.vtid=4669
1h 35m 52.063886477s,ust.lttng_ust_cyg_profile:func_exit,CPU 0,addr=0x402375,call_site=0x402769,$pid=4669,$procname=server_sample,trace_context.vtid=4669
1h 35m 52.064362625s,ust.lttng_ust_cyg_profile:func_entry,CPU 2,addr=0x40279B,call_site=0x7F7956346450,$pid=4489,$procname=server_sample,trace_context.vtid=4489
1h 35m 52.064369779s,ust.lttng_ust_cyg_profile:func_exit,CPU 2,addr=0x40279B,call_site=0x7F7956346450,$pid=4489,$procname=server_sample,trace_context.vtid=4489
1h 36m 00.028400114s,ust.ust_baddr_statedump:soinfo,CPU 0,baddr=0x400000,sopath=/home/pwoegere/MGC/SA/git-trunk/source/systems/ust/features/com.mentor.embedded.profiler.feature.system.ust.samples/server_sample/server_sample,size=162591,mtime=1384181347,$pid=4915,$procname=server_sample
1h 36m 00.028413058s,ust.ust_baddr_statedump:soinfo,CPU 0,baddr=0x7FFF457FE000,sopath=[linux-vdso.so.1],size=0,mtime=-1,$pid=4915,$procname=server_sample
1h 36m 00.028426256s,ust.ust_baddr_statedump:soinfo,CPU 0,baddr=0x7F7957118000,sopath=/home/pwoegere/MGC/lttng2_stack_latest_install/lib64/liblttng-ust-fork.so.0.0.0,size=20700,mtime=1384181281,$pid=4915,$procname=server_sample
1h 36m 00.028433486s,ust.ust_baddr_statedump:soinfo,CPU 0,baddr=0x7F7956F14000,sopath=/home/pwoegere/MGC/lttng2_stack_latest_install/lib64/liblttng-ust-cyg-profile.so.0.0.0,size=45245,mtime=1384181281,$pid=4915,$procname=server_sample
1h 36m 00.028440068s,ust.ust_baddr_statedump:soinfo,CPU 0,baddr=0x7F7956D11000,sopath=/home/pwoegere/MGC/lttng2_stack_latest_install/lib64/liblttng-ust-dl.so.0.0.0,size=21500,mtime=1384181281,$pid=4915,$procname=server_sample
1h 36m 00.028450474s,ust.ust_baddr_statedump:soinfo,CPU 0,baddr=0x7F7956B0C000,sopath=/home/pwoegere/MGC/SA/git-trunk/source/systems/ust/features/com.mentor.embedded.profiler.feature.system.ust.samples/server_sample/libtrace_requests.so,size=164908,mtime=1384181347,$pid=4915,$procname=server_sample
1h 36m 00.028457300s,ust.ust_baddr_statedump:soinfo,CPU 0,baddr=0x7F79568C3000,sopath=/home/pwoegere/MGC/lttng2_stack_latest_install/lib64/liblttng-ust.so.0.0.0,size=1611934,mtime=1384181281,$pid=4915,$procname=server_sample
1h 36m 00.028461479s,ust.ust_baddr_statedump:soinfo,CPU 0,baddr=0x7F79566BF000,sopath=/lib64/libdl-2.17.so,size=19016,mtime=1379513990,$pid=4915,$procname=server_sample
1h 36m 00.028465256s,ust.ust_baddr_statedump:soinfo,CPU 0,baddr=0x7F7956311000,sopath=/lib64/libc-2.17.so,size=1996294,mtime=1379513989,$pid=4915,$procname=server_sample
1h 36m 00.028472156s,ust.ust_baddr_statedump:soinfo,CPU 0,baddr=0x7F79560F7000,sopath=/home/pwoegere/MGC/lttng2_stack_latest_install/lib64/liblttng-ust-tracepoint.so.0.0.0,size=138864,mtime=1384181280,$pid=4915,$procname=server_sample
1h 36m 00.028476006s,ust.ust_baddr_statedump:soinfo,CPU 0,baddr=0x7F7955EEF000,sopath=/lib64/librt-2.17.so,size=42706,mtime=1379513990,$pid=4915,$procname=server_sample
1h 36m 00.028482749s,ust.ust_baddr_statedump:soinfo,CPU 0,baddr=0x7F7955CE8000,sopath=/home/pwoegere/MGC/lttng2_stack_latest_install/lib64/liburcu-bp.so.2.0.0,size=108574,mtime=1381992197,$pid=4915,$procname=server_sample
1h 36m 00.028489415s,ust.ust_baddr_statedump:soinfo,CPU 0,baddr=0x7F7955AE0000,sopath=/home/pwoegere/MGC/lttng2_stack_latest_install/lib64/liburcu-cds.so.2.0.0,size=162940,mtime=1381992197,$pid=4915,$procname=server_sample
1h 36m 00.028496021s,ust.ust_baddr_statedump:soinfo,CPU 0,baddr=0x7F79558DC000,sopath=/home/pwoegere/MGC/lttng2_stack_latest_install/lib64/liburcu-common.so.2.0.0,size=86456,mtime=1381992197,$pid=4915,$procname=server_sample
1h 36m 00.028499819s,ust.ust_baddr_statedump:soinfo,CPU 0,baddr=0x7F79556C0000,sopath=/lib64/libpthread-2.17.so,size=131133,mtime=1379513990,$pid=4915,$procname=server_sample
1h 36m 00.028503427s,ust.ust_baddr_statedump:soinfo,CPU 0,baddr=0x7F795731B000,sopath=/lib64/ld-2.17.so,size=163493,mtime=1379513989,$pid=4915,$procname=server_sample
1h 36m 00.028511061s,ust.ust_baddr_statedump:soinfo,CPU 0,baddr=0x7F79544B8000,sopath=/home/pwoegere/MGC/lttng2_stack_latest_install/lib64/liblttng-ust-baddr.so.0.0.0,size=77469,mtime=1384181281,$pid=4915,$procname=server_sample
1h 36m 00.028551002s,ust.lttng_ust_cyg_profile:func_entry,CPU 7,addr=0x402375,call_site=0x402769,$pid=4915,$procname=server_sample,trace_context.vtid=4915
1h 36m 00.028582597s,ust.lttng_ust_cyg_profile:func_entry,CPU 7,addr=0x402190,call_site=0x402511,$pid=4915,$procname=server_sample,trace_context.vtid=4915
1h 36m 00.028585890s,ust.server_request:start,CPU 7,url=/run_time,$pid=4915,$procname=server_sample,trace_context.ip=0x40221E
1h 36m 00.028594130s,ust.lttng_ust_cyg_profile:func_entry,CPU 7,addr=0x402AF2,call_site=0x402299,$pid=4915,$procname=server_sample,trace_context.vtid=4915
1h 36m 00.028596473s,ust.server_request:module_open,CPU 7,soname=run_time.so,$pid=4915,$procname=server_sample,trace_context.ip=0x402B63
1h 36m 00.028597254s,ust.lttng_ust_cyg_profile:func_entry,CPU 7,addr=0x402E12,call_site=0x402BB0,$pid=4915,$procname=server_sample,trace_context.vtid=4915
1h 36m 00.028598573s,ust.lttng_ust_cyg_profile:func_exit,CPU 7,addr=0x402E12,call_site=0x402BB0,$pid=4915,$procname=server_sample,trace_context.vtid=4915
1h 36m 00.029041911s,ust.ust_baddr:push,CPU 0,baddr=0x7F79542B5000,sopath=/home/pwoegere/MGC/SA/git-trunk/source/systems/ust/features/com.mentor.embedded.profiler.feature.system.ust.samples/server_sample/run_time.so,size=90162,mtime=1384181348,$pid=4915,$procname=server_sample
1h 36m 00.029047219s,ust.server_request:module_open_success,CPU 0,soname=run_time.so,$pid=4915,$procname=server_sample,trace_context.ip=0x402C2B
1h 36m 00.029061773s,ust.lttng_ust_cyg_profile:func_entry,CPU 0,addr=0x402E12,call_site=0x402C74,$pid=4915,$procname=server_sample,trace_context.vtid=4915
1h 36m 00.029065309s,ust.lttng_ust_cyg_profile:func_exit,CPU 0,addr=0x402E12,call_site=0x402C74,$pid=4915,$procname=server_sample,trace_context.vtid=4915
1h 36m 00.029065901s,ust.lttng_ust_cyg_profile:func_entry,CPU 0,addr=0x402D72,call_site=0x402C82,$pid=4915,$procname=server_sample,trace_context.vtid=4915
1h 36m 00.029067739s,ust.lttng_ust_cyg_profile:func_exit,CPU 0,addr=0x402D72,call_site=0x402C82,$pid=4915,$procname=server_sample,trace_context.vtid=4915
1h 36m 00.029068156s,ust.lttng_ust_cyg_profile:func_exit,CPU 0,addr=0x402AF2,call_site=0x402299,$pid=4915,$procname=server_sample,trace_context.vtid=4915
1h 36m 00.029119314s,ust.lttng_ust_cyg_profile:func_entry,CPU 0,addr=0x7F79542B6280,call_site=0x402303,$pid=4915,$procname=server_sample,trace_context.vtid=4915
1h 36m 00.029177510s,ust.server_request:send_response,CPU 0,options=,$pid=4915,$procname=server_sample,trace_context.ip=0x7F79542B634C
1h 36m 00.029192302s,ust.server_request:send_response_done,CPU 0,$pid=4915,$procname=server_sample,trace_context.ip=0x7F79542B63BD
1h 36m 00.029192976s,ust.lttng_ust_cyg_profile:func_exit,CPU 0,addr=0x7F79542B6280,call_site=0x402303,$pid=4915,$procname=server_sample,trace_context.vtid=4915
1h 36m 00.029193606s,ust.lttng_ust_cyg_profile:func_entry,CPU 0,addr=0x402A98,call_site=0x40230B,$pid=4915,$procname=server_sample,trace_context.vtid=4915
1h 36m 00.029196437s,ust.ust_baddr:pop,CPU 0,baddr=0x7F79542B5000,$pid=4915,$procname=server_sample
1h 36m 00.029222113s,ust.lttng_ust_cyg_profile:func_exit,CPU 0,addr=0x402A98,call_site=0x40230B,$pid=4915,$procname=server_sample,trace_context.vtid=4915
1h 36m 00.029222894s,ust.lttng_ust_cyg_profile:func_exit,CPU 0,addr=0x402190,call_site=0x402511,$pid=4915,$procname=server_sample,trace_context.vtid=4915
1h 36m 00.029223284s,ust.lttng_ust_cyg_profile:func_exit,CPU 0,addr=0x402375,call_site=0x402769,$pid=4915,$procname=server_sample,trace_context.vtid=4915
1h 36m 00.029770182s,ust.lttng_ust_cyg_profile:func_entry,CPU 2,addr=0x40279B,call_site=0x7F7956346450,$pid=4489,$procname=server_sample,trace_context.vtid=4489
1h 36m 00.029777599s,ust.lttng_ust_cyg_profile:func_exit,CPU 2,addr=0x40279B,call_site=0x7F7956346450,$pid=4489,$procname=server_sample,trace_context.vtid=4489


--------------040105000004000205010803
Content-Type: text/csv; name="server_sample_resolved.csv"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="server_sample_resolved.csv"

1h 35m 42.232342134s,ust.ust_baddr_statedump:soinfo,CPU 5,baddr=0x400000,sopath=/home/pwoegere/MGC/SA/git-trunk/source/systems/ust/features/com.mentor.embedded.profiler.feature.system.ust.samples/server_sample/server_sample,size=162591,mtime=1384181347,$pid=4489,$procname=server_sample
1h 35m 42.232357497s,ust.ust_baddr_statedump:soinfo,CPU 5,baddr=0x7FFF457FE000,sopath=[linux-vdso.so.1],size=0,mtime=-1,$pid=4489,$procname=server_sample
1h 35m 42.232368742s,ust.ust_baddr_statedump:soinfo,CPU 5,baddr=0x7F7957118000,sopath=/home/pwoegere/MGC/lttng2_stack_latest_install/lib64/liblttng-ust-fork.so.0.0.0,size=20700,mtime=1384181281,$pid=4489,$procname=server_sample
1h 35m 42.232375096s,ust.ust_baddr_statedump:soinfo,CPU 5,baddr=0x7F7956F14000,sopath=/home/pwoegere/MGC/lttng2_stack_latest_install/lib64/liblttng-ust-cyg-profile.so.0.0.0,size=45245,mtime=1384181281,$pid=4489,$procname=server_sample
1h 35m 42.232380789s,ust.ust_baddr_statedump:soinfo,CPU 5,baddr=0x7F7956D11000,sopath=/home/pwoegere/MGC/lttng2_stack_latest_install/lib64/liblttng-ust-dl.so.0.0.0,size=21500,mtime=1384181281,$pid=4489,$procname=server_sample
1h 35m 42.232389337s,ust.ust_baddr_statedump:soinfo,CPU 5,baddr=0x7F7956B0C000,sopath=/home/pwoegere/MGC/SA/git-trunk/source/systems/ust/features/com.mentor.embedded.profiler.feature.system.ust.samples/server_sample/libtrace_requests.so,size=164908,mtime=1384181347,$pid=4489,$procname=server_sample
1h 35m 42.232394982s,ust.ust_baddr_statedump:soinfo,CPU 5,baddr=0x7F79568C3000,sopath=/home/pwoegere/MGC/lttng2_stack_latest_install/lib64/liblttng-ust.so.0.0.0,size=1611934,mtime=1384181281,$pid=4489,$procname=server_sample
1h 35m 42.232398777s,ust.ust_baddr_statedump:soinfo,CPU 5,baddr=0x7F79566BF000,sopath=/lib64/libdl-2.17.so,size=19016,mtime=1379513990,$pid=4489,$procname=server_sample
1h 35m 42.232401855s,ust.ust_baddr_statedump:soinfo,CPU 5,baddr=0x7F7956311000,sopath=/lib64/libc-2.17.so,size=1996294,mtime=1379513989,$pid=4489,$procname=server_sample
1h 35m 42.232407498s,ust.ust_baddr_statedump:soinfo,CPU 5,baddr=0x7F79560F7000,sopath=/home/pwoegere/MGC/lttng2_stack_latest_install/lib64/liblttng-ust-tracepoint.so.0.0.0,size=138864,mtime=1384181280,$pid=4489,$procname=server_sample
1h 35m 42.232410590s,ust.ust_baddr_statedump:soinfo,CPU 5,baddr=0x7F7955EEF000,sopath=/lib64/librt-2.17.so,size=42706,mtime=1379513990,$pid=4489,$procname=server_sample
1h 35m 42.232416073s,ust.ust_baddr_statedump:soinfo,CPU 5,baddr=0x7F7955CE8000,sopath=/home/pwoegere/MGC/lttng2_stack_latest_install/lib64/liburcu-bp.so.2.0.0,size=108574,mtime=1381992197,$pid=4489,$procname=server_sample
1h 35m 42.232421604s,ust.ust_baddr_statedump:soinfo,CPU 5,baddr=0x7F7955AE0000,sopath=/home/pwoegere/MGC/lttng2_stack_latest_install/lib64/liburcu-cds.so.2.0.0,size=162940,mtime=1381992197,$pid=4489,$procname=server_sample
1h 35m 42.232427497s,ust.ust_baddr_statedump:soinfo,CPU 5,baddr=0x7F79558DC000,sopath=/home/pwoegere/MGC/lttng2_stack_latest_install/lib64/liburcu-common.so.2.0.0,size=86456,mtime=1381992197,$pid=4489,$procname=server_sample
1h 35m 42.232430848s,ust.ust_baddr_statedump:soinfo,CPU 5,baddr=0x7F79556C0000,sopath=/lib64/libpthread-2.17.so,size=131133,mtime=1379513990,$pid=4489,$procname=server_sample
1h 35m 42.232433943s,ust.ust_baddr_statedump:soinfo,CPU 5,baddr=0x7F795731B000,sopath=/lib64/ld-2.17.so,size=163493,mtime=1379513989,$pid=4489,$procname=server_sample
1h 35m 42.232438810s,ust.ust_baddr_statedump:soinfo,CPU 5,baddr=0x7F79544B8000,sopath=/home/pwoegere/MGC/lttng2_stack_latest_install/lib64/liblttng-ust-baddr.so.0.0.0,size=77469,mtime=1384181281,$pid=4489,$procname=server_sample
1h 35m 42.232692010s,ust.lttng_ust_cyg_profile:func_entry,CPU 0,addr=main,call_site=__libc_start_main+0xF5,$pid=4489,$procname=server_sample,trace_context.vtid=4489
1h 35m 42.232697707s,ust.lttng_ust_cyg_profile:func_entry,CPU 0,addr=get_self_executable_directory,call_site=main+0x54,$pid=4489,$procname=server_sample,trace_context.vtid=4489
1h 35m 42.232712279s,ust.lttng_ust_cyg_profile:func_entry,CPU 0,addr=xmalloc,call_site=get_self_executable_directory+0x79,$pid=4489,$procname=server_sample,trace_context.vtid=4489
1h 35m 42.232714008s,ust.lttng_ust_cyg_profile:func_exit,CPU 0,addr=xmalloc,call_site=get_self_executable_directory+0x79,$pid=4489,$procname=server_sample,trace_context.vtid=4489
1h 35m 42.232715439s,ust.lttng_ust_cyg_profile:func_exit,CPU 0,addr=get_self_executable_directory,call_site=main+0x54,$pid=4489,$procname=server_sample,trace_context.vtid=4489
1h 35m 42.232722715s,ust.lttng_ust_cyg_profile:func_entry,CPU 0,addr=server_run,call_site=main+0x2EA,$pid=4489,$procname=server_sample,trace_context.vtid=4489
1h 35m 47.990936990s,ust.ust_baddr_statedump:soinfo,CPU 7,baddr=0x400000,sopath=/home/pwoegere/MGC/SA/git-trunk/source/systems/ust/features/com.mentor.embedded.profiler.feature.system.ust.samples/server_sample/server_sample,size=162591,mtime=1384181347,$pid=4583,$procname=server_sample
1h 35m 47.990949418s,ust.ust_baddr_statedump:soinfo,CPU 7,baddr=0x7FFF457FE000,sopath=[linux-vdso.so.1],size=0,mtime=-1,$pid=4583,$procname=server_sample
1h 35m 47.990963601s,ust.ust_baddr_statedump:soinfo,CPU 7,baddr=0x7F7957118000,sopath=/home/pwoegere/MGC/lttng2_stack_latest_install/lib64/liblttng-ust-fork.so.0.0.0,size=20700,mtime=1384181281,$pid=4583,$procname=server_sample
1h 35m 47.990971319s,ust.ust_baddr_statedump:soinfo,CPU 7,baddr=0x7F7956F14000,sopath=/home/pwoegere/MGC/lttng2_stack_latest_install/lib64/liblttng-ust-cyg-profile.so.0.0.0,size=45245,mtime=1384181281,$pid=4583,$procname=server_sample
1h 35m 47.990978454s,ust.ust_baddr_statedump:soinfo,CPU 7,baddr=0x7F7956D11000,sopath=/home/pwoegere/MGC/lttng2_stack_latest_install/lib64/liblttng-ust-dl.so.0.0.0,size=21500,mtime=1384181281,$pid=4583,$procname=server_sample
1h 35m 47.990989415s,ust.ust_baddr_statedump:soinfo,CPU 7,baddr=0x7F7956B0C000,sopath=/home/pwoegere/MGC/SA/git-trunk/source/systems/ust/features/com.mentor.embedded.profiler.feature.system.ust.samples/server_sample/libtrace_requests.so,size=164908,mtime=1384181347,$pid=4583,$procname=server_sample
1h 35m 47.990996861s,ust.ust_baddr_statedump:soinfo,CPU 7,baddr=0x7F79568C3000,sopath=/home/pwoegere/MGC/lttng2_stack_latest_install/lib64/liblttng-ust.so.0.0.0,size=1611934,mtime=1384181281,$pid=4583,$procname=server_sample
1h 35m 47.991007134s,ust.ust_baddr_statedump:soinfo,CPU 7,baddr=0x7F79566BF000,sopath=/lib64/libdl-2.17.so,size=19016,mtime=1379513990,$pid=4583,$procname=server_sample
1h 35m 47.991011156s,ust.ust_baddr_statedump:soinfo,CPU 7,baddr=0x7F7956311000,sopath=/lib64/libc-2.17.so,size=1996294,mtime=1379513989,$pid=4583,$procname=server_sample
1h 35m 47.991018438s,ust.ust_baddr_statedump:soinfo,CPU 7,baddr=0x7F79560F7000,sopath=/home/pwoegere/MGC/lttng2_stack_latest_install/lib64/liblttng-ust-tracepoint.so.0.0.0,size=138864,mtime=1384181280,$pid=4583,$procname=server_sample
1h 35m 47.991022400s,ust.ust_baddr_statedump:soinfo,CPU 7,baddr=0x7F7955EEF000,sopath=/lib64/librt-2.17.so,size=42706,mtime=1379513990,$pid=4583,$procname=server_sample
1h 35m 47.991029267s,ust.ust_baddr_statedump:soinfo,CPU 7,baddr=0x7F7955CE8000,sopath=/home/pwoegere/MGC/lttng2_stack_latest_install/lib64/liburcu-bp.so.2.0.0,size=108574,mtime=1381992197,$pid=4583,$procname=server_sample
1h 35m 47.991036181s,ust.ust_baddr_statedump:soinfo,CPU 7,baddr=0x7F7955AE0000,sopath=/home/pwoegere/MGC/lttng2_stack_latest_install/lib64/liburcu-cds.so.2.0.0,size=162940,mtime=1381992197,$pid=4583,$procname=server_sample
1h 35m 47.991043088s,ust.ust_baddr_statedump:soinfo,CPU 7,baddr=0x7F79558DC000,sopath=/home/pwoegere/MGC/lttng2_stack_latest_install/lib64/liburcu-common.so.2.0.0,size=86456,mtime=1381992197,$pid=4583,$procname=server_sample
1h 35m 47.991047148s,ust.ust_baddr_statedump:soinfo,CPU 7,baddr=0x7F79556C0000,sopath=/lib64/libpthread-2.17.so,size=131133,mtime=1379513990,$pid=4583,$procname=server_sample
1h 35m 47.991050854s,ust.ust_baddr_statedump:soinfo,CPU 7,baddr=0x7F795731B000,sopath=/lib64/ld-2.17.so,size=163493,mtime=1379513989,$pid=4583,$procname=server_sample
1h 35m 47.991059055s,ust.ust_baddr_statedump:soinfo,CPU 7,baddr=0x7F79544B8000,sopath=/home/pwoegere/MGC/lttng2_stack_latest_install/lib64/liblttng-ust-baddr.so.0.0.0,size=77469,mtime=1384181281,$pid=4583,$procname=server_sample
1h 35m 47.991134466s,ust.lttng_ust_cyg_profile:func_entry,CPU 6,addr=handle_connection,call_site=server_run+0x227,$pid=4583,$procname=server_sample,trace_context.vtid=4583
1h 35m 47.991165738s,ust.lttng_ust_cyg_profile:func_entry,CPU 6,addr=handle_get,call_site=handle_connection+0x19C,$pid=4583,$procname=server_sample,trace_context.vtid=4583
1h 35m 47.991169619s,ust.server_request:start,CPU 6,url=/run_hello,$pid=4583,$procname=server_sample,trace_context.ip=handle_get+0x8E
1h 35m 47.991177452s,ust.lttng_ust_cyg_profile:func_entry,CPU 6,addr=module_open,call_site=handle_get+0x109,$pid=4583,$procname=server_sample,trace_context.vtid=4583
1h 35m 47.991180017s,ust.server_request:module_open,CPU 6,soname=run_hello.so,$pid=4583,$procname=server_sample,trace_context.ip=module_open+0x71
1h 35m 47.991180969s,ust.lttng_ust_cyg_profile:func_entry,CPU 6,addr=xmalloc,call_site=module_open+0xBE,$pid=4583,$procname=server_sample,trace_context.vtid=4583
1h 35m 47.991182842s,ust.lttng_ust_cyg_profile:func_exit,CPU 6,addr=xmalloc,call_site=module_open+0xBE,$pid=4583,$procname=server_sample,trace_context.vtid=4583
1h 35m 47.991563919s,ust.ust_baddr:push,CPU 0,baddr=0x7F79542B5000,sopath=/home/pwoegere/MGC/SA/git-trunk/source/systems/ust/features/com.mentor.embedded.profiler.feature.system.ust.samples/server_sample/run_hello.so,size=88660,mtime=1384181347,$pid=4583,$procname=server_sample
1h 35m 47.991571874s,ust.server_request:module_open_success,CPU 0,soname=run_hello.so,$pid=4583,$procname=server_sample,trace_context.ip=module_open+0x139
1h 35m 47.991578000s,ust.lttng_ust_cyg_profile:func_entry,CPU 0,addr=xmalloc,call_site=module_open+0x182,$pid=4583,$procname=server_sample,trace_context.vtid=4583
1h 35m 47.991581609s,ust.lttng_ust_cyg_profile:func_exit,CPU 0,addr=xmalloc,call_site=module_open+0x182,$pid=4583,$procname=server_sample,trace_context.vtid=4583
1h 35m 47.991582301s,ust.lttng_ust_cyg_profile:func_entry,CPU 0,addr=xstrdup,call_site=module_open+0x190,$pid=4583,$procname=server_sample,trace_context.vtid=4583
1h 35m 47.991584122s,ust.lttng_ust_cyg_profile:func_exit,CPU 0,addr=xstrdup,call_site=module_open+0x190,$pid=4583,$procname=server_sample,trace_context.vtid=4583
1h 35m 47.991584539s,ust.lttng_ust_cyg_profile:func_exit,CPU 0,addr=module_open,call_site=handle_get+0x109,$pid=4583,$procname=server_sample,trace_context.vtid=4583
1h 35m 47.991630159s,ust.lttng_ust_cyg_profile:func_entry,CPU 0,addr=module_generate,call_site=handle_get+0x173,$pid=4583,$procname=server_sample,trace_context.vtid=4583
1h 35m 47.991632412s,ust.server_request:send_response,CPU 0,options=,$pid=4583,$procname=server_sample,trace_context.ip=module_generate+0x92
1h 35m 47.991644261s,ust.server_request:send_response_done,CPU 0,$pid=4583,$procname=server_sample,trace_context.ip=module_generate+0xFF
1h 35m 47.991644766s,ust.lttng_ust_cyg_profile:func_exit,CPU 0,addr=module_generate,call_site=handle_get+0x173,$pid=4583,$procname=server_sample,trace_context.vtid=4583
1h 35m 47.991645324s,ust.lttng_ust_cyg_profile:func_entry,CPU 0,addr=module_close,call_site=handle_get+0x17B,$pid=4583,$procname=server_sample,trace_context.vtid=4583
1h 35m 47.991656322s,ust.ust_baddr:pop,CPU 0,baddr=0x7F79542B5000,$pid=4583,$procname=server_sample
1h 35m 47.991683799s,ust.lttng_ust_cyg_profile:func_exit,CPU 0,addr=module_close,call_site=handle_get+0x17B,$pid=4583,$procname=server_sample,trace_context.vtid=4583
1h 35m 47.991684696s,ust.lttng_ust_cyg_profile:func_exit,CPU 0,addr=handle_get,call_site=handle_connection+0x19C,$pid=4583,$procname=server_sample,trace_context.vtid=4583
1h 35m 47.991685079s,ust.lttng_ust_cyg_profile:func_exit,CPU 0,addr=handle_connection,call_site=server_run+0x227,$pid=4583,$procname=server_sample,trace_context.vtid=4583
1h 35m 47.992247329s,ust.lttng_ust_cyg_profile:func_entry,CPU 5,addr=clean_up_child_process,call_site=__restore_rt,$pid=4489,$procname=server_sample,trace_context.vtid=4489
1h 35m 47.992267134s,ust.lttng_ust_cyg_profile:func_exit,CPU 5,addr=clean_up_child_process,call_site=__restore_rt,$pid=4489,$procname=server_sample,trace_context.vtid=4489
1h 35m 51.762484533s,ust.ust_baddr_statedump:soinfo,CPU 2,baddr=0x400000,sopath=/home/pwoegere/MGC/SA/git-trunk/source/systems/ust/features/com.mentor.embedded.profiler.feature.system.ust.samples/server_sample/server_sample,size=162591,mtime=1384181347,$pid=4669,$procname=server_sample
1h 35m 51.762497943s,ust.ust_baddr_statedump:soinfo,CPU 2,baddr=0x7FFF457FE000,sopath=[linux-vdso.so.1],size=0,mtime=-1,$pid=4669,$procname=server_sample
1h 35m 51.762527960s,ust.ust_baddr_statedump:soinfo,CPU 2,baddr=0x7F7957118000,sopath=/home/pwoegere/MGC/lttng2_stack_latest_install/lib64/liblttng-ust-fork.so.0.0.0,size=20700,mtime=1384181281,$pid=4669,$procname=server_sample
1h 35m 51.762535962s,ust.ust_baddr_statedump:soinfo,CPU 2,baddr=0x7F7956F14000,sopath=/home/pwoegere/MGC/lttng2_stack_latest_install/lib64/liblttng-ust-cyg-profile.so.0.0.0,size=45245,mtime=1384181281,$pid=4669,$procname=server_sample
1h 35m 51.762543161s,ust.ust_baddr_statedump:soinfo,CPU 2,baddr=0x7F7956D11000,sopath=/home/pwoegere/MGC/lttng2_stack_latest_install/lib64/liblttng-ust-dl.so.0.0.0,size=21500,mtime=1384181281,$pid=4669,$procname=server_sample
1h 35m 51.762554347s,ust.ust_baddr_statedump:soinfo,CPU 2,baddr=0x7F7956B0C000,sopath=/home/pwoegere/MGC/SA/git-trunk/source/systems/ust/features/com.mentor.embedded.profiler.feature.system.ust.samples/server_sample/libtrace_requests.so,size=164908,mtime=1384181347,$pid=4669,$procname=server_sample
1h 35m 51.762561783s,ust.ust_baddr_statedump:soinfo,CPU 2,baddr=0x7F79568C3000,sopath=/home/pwoegere/MGC/lttng2_stack_latest_install/lib64/liblttng-ust.so.0.0.0,size=1611934,mtime=1384181281,$pid=4669,$procname=server_sample
1h 35m 51.762566398s,ust.ust_baddr_statedump:soinfo,CPU 2,baddr=0x7F79566BF000,sopath=/lib64/libdl-2.17.so,size=19016,mtime=1379513990,$pid=4669,$procname=server_sample
1h 35m 51.762570124s,ust.ust_baddr_statedump:soinfo,CPU 2,baddr=0x7F7956311000,sopath=/lib64/libc-2.17.so,size=1996294,mtime=1379513989,$pid=4669,$procname=server_sample
1h 35m 51.762577601s,ust.ust_baddr_statedump:soinfo,CPU 2,baddr=0x7F79560F7000,sopath=/home/pwoegere/MGC/lttng2_stack_latest_install/lib64/liblttng-ust-tracepoint.so.0.0.0,size=138864,mtime=1384181280,$pid=4669,$procname=server_sample
1h 35m 51.762581516s,ust.ust_baddr_statedump:soinfo,CPU 2,baddr=0x7F7955EEF000,sopath=/lib64/librt-2.17.so,size=42706,mtime=1379513990,$pid=4669,$procname=server_sample
1h 35m 51.762588688s,ust.ust_baddr_statedump:soinfo,CPU 2,baddr=0x7F7955CE8000,sopath=/home/pwoegere/MGC/lttng2_stack_latest_install/lib64/liburcu-bp.so.2.0.0,size=108574,mtime=1381992197,$pid=4669,$procname=server_sample
1h 35m 51.762595835s,ust.ust_baddr_statedump:soinfo,CPU 2,baddr=0x7F7955AE0000,sopath=/home/pwoegere/MGC/lttng2_stack_latest_install/lib64/liburcu-cds.so.2.0.0,size=162940,mtime=1381992197,$pid=4669,$procname=server_sample
1h 35m 51.762603101s,ust.ust_baddr_statedump:soinfo,CPU 2,baddr=0x7F79558DC000,sopath=/home/pwoegere/MGC/lttng2_stack_latest_install/lib64/liburcu-common.so.2.0.0,size=86456,mtime=1381992197,$pid=4669,$procname=server_sample
1h 35m 51.762607046s,ust.ust_baddr_statedump:soinfo,CPU 2,baddr=0x7F79556C0000,sopath=/lib64/libpthread-2.17.so,size=131133,mtime=1379513990,$pid=4669,$procname=server_sample
1h 35m 51.762610897s,ust.ust_baddr_statedump:soinfo,CPU 2,baddr=0x7F795731B000,sopath=/lib64/ld-2.17.so,size=163493,mtime=1379513989,$pid=4669,$procname=server_sample
1h 35m 51.762619364s,ust.ust_baddr_statedump:soinfo,CPU 2,baddr=0x7F79544B8000,sopath=/home/pwoegere/MGC/lttng2_stack_latest_install/lib64/liblttng-ust-baddr.so.0.0.0,size=77469,mtime=1384181281,$pid=4669,$procname=server_sample
1h 35m 51.762715395s,ust.lttng_ust_cyg_profile:func_entry,CPU 7,addr=handle_connection,call_site=server_run+0x227,$pid=4669,$procname=server_sample,trace_context.vtid=4669
1h 35m 51.762752436s,ust.lttng_ust_cyg_profile:func_entry,CPU 7,addr=handle_get,call_site=handle_connection+0x19C,$pid=4669,$procname=server_sample,trace_context.vtid=4669
1h 35m 51.762755854s,ust.server_request:start,CPU 7,url=/run_cmd?/usr/bin/df,$pid=4669,$procname=server_sample,trace_context.ip=handle_get+0x8E
1h 35m 51.762764086s,ust.lttng_ust_cyg_profile:func_entry,CPU 7,addr=module_open,call_site=handle_get+0x109,$pid=4669,$procname=server_sample,trace_context.vtid=4669
1h 35m 51.762766657s,ust.server_request:module_open,CPU 7,soname=run_cmd.so,$pid=4669,$procname=server_sample,trace_context.ip=module_open+0x71
1h 35m 51.762767570s,ust.lttng_ust_cyg_profile:func_entry,CPU 7,addr=xmalloc,call_site=module_open+0xBE,$pid=4669,$procname=server_sample,trace_context.vtid=4669
1h 35m 51.762769237s,ust.lttng_ust_cyg_profile:func_exit,CPU 7,addr=xmalloc,call_site=module_open+0xBE,$pid=4669,$procname=server_sample,trace_context.vtid=4669
1h 35m 51.763560936s,ust.ust_baddr:push,CPU 0,baddr=0x7F79542B5000,sopath=/home/pwoegere/MGC/SA/git-trunk/source/systems/ust/features/com.mentor.embedded.profiler.feature.system.ust.samples/server_sample/run_cmd.so,size=90326,mtime=1384181347,$pid=4669,$procname=server_sample
1h 35m 51.763568461s,ust.server_request:module_open_success,CPU 0,soname=run_cmd.so,$pid=4669,$procname=server_sample,trace_context.ip=module_open+0x139
1h 35m 51.763574005s,ust.lttng_ust_cyg_profile:func_entry,CPU 0,addr=xmalloc,call_site=module_open+0x182,$pid=4669,$procname=server_sample,trace_context.vtid=4669
1h 35m 51.763577332s,ust.lttng_ust_cyg_profile:func_exit,CPU 0,addr=xmalloc,call_site=module_open+0x182,$pid=4669,$procname=server_sample,trace_context.vtid=4669
1h 35m 51.763577952s,ust.lttng_ust_cyg_profile:func_entry,CPU 0,addr=xstrdup,call_site=module_open+0x190,$pid=4669,$procname=server_sample,trace_context.vtid=4669
1h 35m 51.763579463s,ust.lttng_ust_cyg_profile:func_exit,CPU 0,addr=xstrdup,call_site=module_open+0x190,$pid=4669,$procname=server_sample,trace_context.vtid=4669
1h 35m 51.763579850s,ust.lttng_ust_cyg_profile:func_exit,CPU 0,addr=module_open,call_site=handle_get+0x109,$pid=4669,$procname=server_sample,trace_context.vtid=4669
1h 35m 51.763621495s,ust.lttng_ust_cyg_profile:func_entry,CPU 0,addr=module_generate,call_site=handle_get+0x173,$pid=4669,$procname=server_sample,trace_context.vtid=4669
1h 35m 51.763622343s,ust.server_request:send_response,CPU 0,options=/usr/bin/df,$pid=4669,$procname=server_sample,trace_context.ip=module_generate+0x64
1h 35m 51.814596840s,ust.ust_baddr_statedump:soinfo,CPU 6,baddr=0x400000,sopath=/home/pwoegere/MGC/SA/git-trunk/source/systems/ust/features/com.mentor.embedded.profiler.feature.system.ust.samples/server_sample/server_sample,size=162591,mtime=1384181347,$pid=4750,$procname=server_sample
1h 35m 51.814607365s,ust.ust_baddr_statedump:soinfo,CPU 6,baddr=0x7FFF457FE000,sopath=[linux-vdso.so.1],size=0,mtime=-1,$pid=4750,$procname=server_sample
1h 35m 51.814620947s,ust.ust_baddr_statedump:soinfo,CPU 6,baddr=0x7F7957118000,sopath=/home/pwoegere/MGC/lttng2_stack_latest_install/lib64/liblttng-ust-fork.so.0.0.0,size=20700,mtime=1384181281,$pid=4750,$procname=server_sample
1h 35m 51.814629113s,ust.ust_baddr_statedump:soinfo,CPU 6,baddr=0x7F7956F14000,sopath=/home/pwoegere/MGC/lttng2_stack_latest_install/lib64/liblttng-ust-cyg-profile.so.0.0.0,size=45245,mtime=1384181281,$pid=4750,$procname=server_sample
1h 35m 51.814636537s,ust.ust_baddr_statedump:soinfo,CPU 6,baddr=0x7F7956D11000,sopath=/home/pwoegere/MGC/lttng2_stack_latest_install/lib64/liblttng-ust-dl.so.0.0.0,size=21500,mtime=1384181281,$pid=4750,$procname=server_sample
1h 35m 51.814646928s,ust.ust_baddr_statedump:soinfo,CPU 6,baddr=0x7F7956B0C000,sopath=/home/pwoegere/MGC/SA/git-trunk/source/systems/ust/features/com.mentor.embedded.profiler.feature.system.ust.samples/server_sample/libtrace_requests.so,size=164908,mtime=1384181347,$pid=4750,$procname=server_sample
1h 35m 51.814654124s,ust.ust_baddr_statedump:soinfo,CPU 6,baddr=0x7F79568C3000,sopath=/home/pwoegere/MGC/lttng2_stack_latest_install/lib64/liblttng-ust.so.0.0.0,size=1611934,mtime=1384181281,$pid=4750,$procname=server_sample
1h 35m 51.814658280s,ust.ust_baddr_statedump:soinfo,CPU 6,baddr=0x7F79566BF000,sopath=/lib64/libdl-2.17.so,size=19016,mtime=1379513990,$pid=4750,$procname=server_sample
1h 35m 51.814662168s,ust.ust_baddr_statedump:soinfo,CPU 6,baddr=0x7F7956311000,sopath=/lib64/libc-2.17.so,size=1996294,mtime=1379513989,$pid=4750,$procname=server_sample
1h 35m 51.814669557s,ust.ust_baddr_statedump:soinfo,CPU 6,baddr=0x7F79560F7000,sopath=/home/pwoegere/MGC/lttng2_stack_latest_install/lib64/liblttng-ust-tracepoint.so.0.0.0,size=138864,mtime=1384181280,$pid=4750,$procname=server_sample
1h 35m 51.814674004s,ust.ust_baddr_statedump:soinfo,CPU 6,baddr=0x7F7955EEF000,sopath=/lib64/librt-2.17.so,size=42706,mtime=1379513990,$pid=4750,$procname=server_sample
1h 35m 51.814680849s,ust.ust_baddr_statedump:soinfo,CPU 6,baddr=0x7F7955CE8000,sopath=/home/pwoegere/MGC/lttng2_stack_latest_install/lib64/liburcu-bp.so.2.0.0,size=108574,mtime=1381992197,$pid=4750,$procname=server_sample
1h 35m 51.814688256s,ust.ust_baddr_statedump:soinfo,CPU 6,baddr=0x7F7955AE0000,sopath=/home/pwoegere/MGC/lttng2_stack_latest_install/lib64/liburcu-cds.so.2.0.0,size=162940,mtime=1381992197,$pid=4750,$procname=server_sample
1h 35m 51.814695041s,ust.ust_baddr_statedump:soinfo,CPU 6,baddr=0x7F79558DC000,sopath=/home/pwoegere/MGC/lttng2_stack_latest_install/lib64/liburcu-common.so.2.0.0,size=86456,mtime=1381992197,$pid=4750,$procname=server_sample
1h 35m 51.814699672s,ust.ust_baddr_statedump:soinfo,CPU 6,baddr=0x7F79556C0000,sopath=/lib64/libpthread-2.17.so,size=131133,mtime=1379513990,$pid=4750,$procname=server_sample
1h 35m 51.814703920s,ust.ust_baddr_statedump:soinfo,CPU 6,baddr=0x7F795731B000,sopath=/lib64/ld-2.17.so,size=163493,mtime=1379513989,$pid=4750,$procname=server_sample
1h 35m 51.814710735s,ust.ust_baddr_statedump:soinfo,CPU 6,baddr=0x7F79544B8000,sopath=/home/pwoegere/MGC/lttng2_stack_latest_install/lib64/liblttng-ust-baddr.so.0.0.0,size=77469,mtime=1384181281,$pid=4750,$procname=server_sample
1h 35m 51.814721766s,ust.ust_baddr_statedump:soinfo,CPU 6,baddr=0x7F79542B5000,sopath=/home/pwoegere/MGC/SA/git-trunk/source/systems/ust/features/com.mentor.embedded.profiler.feature.system.ust.samples/server_sample/run_cmd.so,size=90326,mtime=1384181347,$pid=4750,$procname=server_sample
1h 35m 52.062159384s,ust.ust_baddr_statedump:soinfo,CPU 6,baddr=0x400000,sopath=/usr/bin/df,size=81120,mtime=1359275285,$pid=4750,$procname=server_sample
1h 35m 52.062171222s,ust.ust_baddr_statedump:soinfo,CPU 6,baddr=0x7FFF985FE000,sopath=[linux-vdso.so.1],size=0,mtime=-1,$pid=4750,$procname=server_sample
1h 35m 52.062182205s,ust.ust_baddr_statedump:soinfo,CPU 6,baddr=0x7FD2E3768000,sopath=/home/pwoegere/MGC/lttng2_stack_latest_install/lib64/liblttng-ust-fork.so.0.0.0,size=20700,mtime=1384181281,$pid=4750,$procname=server_sample
1h 35m 52.062188193s,ust.ust_baddr_statedump:soinfo,CPU 6,baddr=0x7FD2E3564000,sopath=/home/pwoegere/MGC/lttng2_stack_latest_install/lib64/liblttng-ust-cyg-profile.so.0.0.0,size=45245,mtime=1384181281,$pid=4750,$procname=server_sample
1h 35m 52.062193818s,ust.ust_baddr_statedump:soinfo,CPU 6,baddr=0x7FD2E3361000,sopath=/home/pwoegere/MGC/lttng2_stack_latest_install/lib64/liblttng-ust-dl.so.0.0.0,size=21500,mtime=1384181281,$pid=4750,$procname=server_sample
1h 35m 52.062197487s,ust.ust_baddr_statedump:soinfo,CPU 6,baddr=0x7FD2E2FB3000,sopath=/lib64/libc-2.17.so,size=1996294,mtime=1379513989,$pid=4750,$procname=server_sample
1h 35m 52.062202944s,ust.ust_baddr_statedump:soinfo,CPU 6,baddr=0x7F79568C3000,sopath=/home/pwoegere/MGC/lttng2_stack_latest_install/lib64/liblttng-ust.so.0.0.0,size=1611934,mtime=1384181281,$pid=4750,$procname=server_sample
1h 35m 52.062208630s,ust.ust_baddr_statedump:soinfo,CPU 6,baddr=0x7FD2E2B50000,sopath=/home/pwoegere/MGC/lttng2_stack_latest_install/lib64/liblttng-ust-tracepoint.so.0.0.0,size=138864,mtime=1384181280,$pid=4750,$procname=server_sample
1h 35m 52.062211928s,ust.ust_baddr_statedump:soinfo,CPU 6,baddr=0x7FD2E2948000,sopath=/lib64/librt-2.17.so,size=42706,mtime=1379513990,$pid=4750,$procname=server_sample
1h 35m 52.062214794s,ust.ust_baddr_statedump:soinfo,CPU 6,baddr=0x7FD2E2744000,sopath=/lib64/libdl-2.17.so,size=19016,mtime=1379513990,$pid=4750,$procname=server_sample
1h 35m 52.062220346s,ust.ust_baddr_statedump:soinfo,CPU 6,baddr=0x7F7955CE8000,sopath=/home/pwoegere/MGC/lttng2_stack_latest_install/lib64/liburcu-bp.so.2.0.0,size=108574,mtime=1381992197,$pid=4750,$procname=server_sample
1h 35m 52.062225720s,ust.ust_baddr_statedump:soinfo,CPU 6,baddr=0x7FD2E2335000,sopath=/home/pwoegere/MGC/lttng2_stack_latest_install/lib64/liburcu-cds.so.2.0.0,size=162940,mtime=1381992197,$pid=4750,$procname=server_sample
1h 35m 52.062231136s,ust.ust_baddr_statedump:soinfo,CPU 6,baddr=0x7FD2E2131000,sopath=/home/pwoegere/MGC/lttng2_stack_latest_install/lib64/liburcu-common.so.2.0.0,size=86456,mtime=1381992197,$pid=4750,$procname=server_sample
1h 35m 52.062234279s,ust.ust_baddr_statedump:soinfo,CPU 6,baddr=0x7FD2E1F15000,sopath=/lib64/libpthread-2.17.so,size=131133,mtime=1379513990,$pid=4750,$procname=server_sample
1h 35m 52.062237238s,ust.ust_baddr_statedump:soinfo,CPU 6,baddr=0x7FD2E396B000,sopath=/lib64/ld-2.17.so,size=163493,mtime=1379513989,$pid=4750,$procname=server_sample
1h 35m 52.062241934s,ust.ust_baddr_statedump:soinfo,CPU 6,baddr=0x7FD2E0D0D000,sopath=/home/pwoegere/MGC/lttng2_stack_latest_install/lib64/liblttng-ust-baddr.so.0.0.0,size=77469,mtime=1384181281,$pid=4750,$procname=server_sample
1h 35m 52.063675099s,ust.lttng_ust_cyg_profile:func_entry,CPU 0,addr=clean_up_child_process,call_site=__restore_rt,$pid=4669,$procname=server_sample,trace_context.vtid=4669
1h 35m 52.063691096s,ust.lttng_ust_cyg_profile:func_exit,CPU 0,addr=clean_up_child_process,call_site=__restore_rt,$pid=4669,$procname=server_sample,trace_context.vtid=4669
1h 35m 52.063826184s,ust.server_request:send_response_done,CPU 0,$pid=4669,$procname=server_sample,trace_context.ip=module_generate+0x215
1h 35m 52.063827827s,ust.lttng_ust_cyg_profile:func_exit,CPU 0,addr=module_generate,call_site=handle_get+0x173,$pid=4669,$procname=server_sample,trace_context.vtid=4669
1h 35m 52.063831771s,ust.lttng_ust_cyg_profile:func_entry,CPU 0,addr=module_close,call_site=handle_get+0x17B,$pid=4669,$procname=server_sample,trace_context.vtid=4669
1h 35m 52.063844778s,ust.ust_baddr:pop,CPU 0,baddr=0x7F79542B5000,$pid=4669,$procname=server_sample
1h 35m 52.063885313s,ust.lttng_ust_cyg_profile:func_exit,CPU 0,addr=module_close,call_site=handle_get+0x17B,$pid=4669,$procname=server_sample,trace_context.vtid=4669
1h 35m 52.063886055s,ust.lttng_ust_cyg_profile:func_exit,CPU 0,addr=handle_get,call_site=handle_connection+0x19C,$pid=4669,$procname=server_sample,trace_context.vtid=4669
1h 35m 52.063886477s,ust.lttng_ust_cyg_profile:func_exit,CPU 0,addr=handle_connection,call_site=server_run+0x227,$pid=4669,$procname=server_sample,trace_context.vtid=4669
1h 35m 52.064362625s,ust.lttng_ust_cyg_profile:func_entry,CPU 2,addr=clean_up_child_process,call_site=__restore_rt,$pid=4489,$procname=server_sample,trace_context.vtid=4489
1h 35m 52.064369779s,ust.lttng_ust_cyg_profile:func_exit,CPU 2,addr=clean_up_child_process,call_site=__restore_rt,$pid=4489,$procname=server_sample,trace_context.vtid=4489
1h 36m 00.028400114s,ust.ust_baddr_statedump:soinfo,CPU 0,baddr=0x400000,sopath=/home/pwoegere/MGC/SA/git-trunk/source/systems/ust/features/com.mentor.embedded.profiler.feature.system.ust.samples/server_sample/server_sample,size=162591,mtime=1384181347,$pid=4915,$procname=server_sample
1h 36m 00.028413058s,ust.ust_baddr_statedump:soinfo,CPU 0,baddr=0x7FFF457FE000,sopath=[linux-vdso.so.1],size=0,mtime=-1,$pid=4915,$procname=server_sample
1h 36m 00.028426256s,ust.ust_baddr_statedump:soinfo,CPU 0,baddr=0x7F7957118000,sopath=/home/pwoegere/MGC/lttng2_stack_latest_install/lib64/liblttng-ust-fork.so.0.0.0,size=20700,mtime=1384181281,$pid=4915,$procname=server_sample
1h 36m 00.028433486s,ust.ust_baddr_statedump:soinfo,CPU 0,baddr=0x7F7956F14000,sopath=/home/pwoegere/MGC/lttng2_stack_latest_install/lib64/liblttng-ust-cyg-profile.so.0.0.0,size=45245,mtime=1384181281,$pid=4915,$procname=server_sample
1h 36m 00.028440068s,ust.ust_baddr_statedump:soinfo,CPU 0,baddr=0x7F7956D11000,sopath=/home/pwoegere/MGC/lttng2_stack_latest_install/lib64/liblttng-ust-dl.so.0.0.0,size=21500,mtime=1384181281,$pid=4915,$procname=server_sample
1h 36m 00.028450474s,ust.ust_baddr_statedump:soinfo,CPU 0,baddr=0x7F7956B0C000,sopath=/home/pwoegere/MGC/SA/git-trunk/source/systems/ust/features/com.mentor.embedded.profiler.feature.system.ust.samples/server_sample/libtrace_requests.so,size=164908,mtime=1384181347,$pid=4915,$procname=server_sample
1h 36m 00.028457300s,ust.ust_baddr_statedump:soinfo,CPU 0,baddr=0x7F79568C3000,sopath=/home/pwoegere/MGC/lttng2_stack_latest_install/lib64/liblttng-ust.so.0.0.0,size=1611934,mtime=1384181281,$pid=4915,$procname=server_sample
1h 36m 00.028461479s,ust.ust_baddr_statedump:soinfo,CPU 0,baddr=0x7F79566BF000,sopath=/lib64/libdl-2.17.so,size=19016,mtime=1379513990,$pid=4915,$procname=server_sample
1h 36m 00.028465256s,ust.ust_baddr_statedump:soinfo,CPU 0,baddr=0x7F7956311000,sopath=/lib64/libc-2.17.so,size=1996294,mtime=1379513989,$pid=4915,$procname=server_sample
1h 36m 00.028472156s,ust.ust_baddr_statedump:soinfo,CPU 0,baddr=0x7F79560F7000,sopath=/home/pwoegere/MGC/lttng2_stack_latest_install/lib64/liblttng-ust-tracepoint.so.0.0.0,size=138864,mtime=1384181280,$pid=4915,$procname=server_sample
1h 36m 00.028476006s,ust.ust_baddr_statedump:soinfo,CPU 0,baddr=0x7F7955EEF000,sopath=/lib64/librt-2.17.so,size=42706,mtime=1379513990,$pid=4915,$procname=server_sample
1h 36m 00.028482749s,ust.ust_baddr_statedump:soinfo,CPU 0,baddr=0x7F7955CE8000,sopath=/home/pwoegere/MGC/lttng2_stack_latest_install/lib64/liburcu-bp.so.2.0.0,size=108574,mtime=1381992197,$pid=4915,$procname=server_sample
1h 36m 00.028489415s,ust.ust_baddr_statedump:soinfo,CPU 0,baddr=0x7F7955AE0000,sopath=/home/pwoegere/MGC/lttng2_stack_latest_install/lib64/liburcu-cds.so.2.0.0,size=162940,mtime=1381992197,$pid=4915,$procname=server_sample
1h 36m 00.028496021s,ust.ust_baddr_statedump:soinfo,CPU 0,baddr=0x7F79558DC000,sopath=/home/pwoegere/MGC/lttng2_stack_latest_install/lib64/liburcu-common.so.2.0.0,size=86456,mtime=1381992197,$pid=4915,$procname=server_sample
1h 36m 00.028499819s,ust.ust_baddr_statedump:soinfo,CPU 0,baddr=0x7F79556C0000,sopath=/lib64/libpthread-2.17.so,size=131133,mtime=1379513990,$pid=4915,$procname=server_sample
1h 36m 00.028503427s,ust.ust_baddr_statedump:soinfo,CPU 0,baddr=0x7F795731B000,sopath=/lib64/ld-2.17.so,size=163493,mtime=1379513989,$pid=4915,$procname=server_sample
1h 36m 00.028511061s,ust.ust_baddr_statedump:soinfo,CPU 0,baddr=0x7F79544B8000,sopath=/home/pwoegere/MGC/lttng2_stack_latest_install/lib64/liblttng-ust-baddr.so.0.0.0,size=77469,mtime=1384181281,$pid=4915,$procname=server_sample
1h 36m 00.028551002s,ust.lttng_ust_cyg_profile:func_entry,CPU 7,addr=handle_connection,call_site=server_run+0x227,$pid=4915,$procname=server_sample,trace_context.vtid=4915
1h 36m 00.028582597s,ust.lttng_ust_cyg_profile:func_entry,CPU 7,addr=handle_get,call_site=handle_connection+0x19C,$pid=4915,$procname=server_sample,trace_context.vtid=4915
1h 36m 00.028585890s,ust.server_request:start,CPU 7,url=/run_time,$pid=4915,$procname=server_sample,trace_context.ip=handle_get+0x8E
1h 36m 00.028594130s,ust.lttng_ust_cyg_profile:func_entry,CPU 7,addr=module_open,call_site=handle_get+0x109,$pid=4915,$procname=server_sample,trace_context.vtid=4915
1h 36m 00.028596473s,ust.server_request:module_open,CPU 7,soname=run_time.so,$pid=4915,$procname=server_sample,trace_context.ip=module_open+0x71
1h 36m 00.028597254s,ust.lttng_ust_cyg_profile:func_entry,CPU 7,addr=xmalloc,call_site=module_open+0xBE,$pid=4915,$procname=server_sample,trace_context.vtid=4915
1h 36m 00.028598573s,ust.lttng_ust_cyg_profile:func_exit,CPU 7,addr=xmalloc,call_site=module_open+0xBE,$pid=4915,$procname=server_sample,trace_context.vtid=4915
1h 36m 00.029041911s,ust.ust_baddr:push,CPU 0,baddr=0x7F79542B5000,sopath=/home/pwoegere/MGC/SA/git-trunk/source/systems/ust/features/com.mentor.embedded.profiler.feature.system.ust.samples/server_sample/run_time.so,size=90162,mtime=1384181348,$pid=4915,$procname=server_sample
1h 36m 00.029047219s,ust.server_request:module_open_success,CPU 0,soname=run_time.so,$pid=4915,$procname=server_sample,trace_context.ip=module_open+0x139
1h 36m 00.029061773s,ust.lttng_ust_cyg_profile:func_entry,CPU 0,addr=xmalloc,call_site=module_open+0x182,$pid=4915,$procname=server_sample,trace_context.vtid=4915
1h 36m 00.029065309s,ust.lttng_ust_cyg_profile:func_exit,CPU 0,addr=xmalloc,call_site=module_open+0x182,$pid=4915,$procname=server_sample,trace_context.vtid=4915
1h 36m 00.029065901s,ust.lttng_ust_cyg_profile:func_entry,CPU 0,addr=xstrdup,call_site=module_open+0x190,$pid=4915,$procname=server_sample,trace_context.vtid=4915
1h 36m 00.029067739s,ust.lttng_ust_cyg_profile:func_exit,CPU 0,addr=xstrdup,call_site=module_open+0x190,$pid=4915,$procname=server_sample,trace_context.vtid=4915
1h 36m 00.029068156s,ust.lttng_ust_cyg_profile:func_exit,CPU 0,addr=module_open,call_site=handle_get+0x109,$pid=4915,$procname=server_sample,trace_context.vtid=4915
1h 36m 00.029119314s,ust.lttng_ust_cyg_profile:func_entry,CPU 0,addr=module_generate,call_site=handle_get+0x173,$pid=4915,$procname=server_sample,trace_context.vtid=4915
1h 36m 00.029177510s,ust.server_request:send_response,CPU 0,options=,$pid=4915,$procname=server_sample,trace_context.ip=module_generate+0xCC
1h 36m 00.029192302s,ust.server_request:send_response_done,CPU 0,$pid=4915,$procname=server_sample,trace_context.ip=module_generate+0x13D
1h 36m 00.029192976s,ust.lttng_ust_cyg_profile:func_exit,CPU 0,addr=module_generate,call_site=handle_get+0x173,$pid=4915,$procname=server_sample,trace_context.vtid=4915
1h 36m 00.029193606s,ust.lttng_ust_cyg_profile:func_entry,CPU 0,addr=module_close,call_site=handle_get+0x17B,$pid=4915,$procname=server_sample,trace_context.vtid=4915
1h 36m 00.029196437s,ust.ust_baddr:pop,CPU 0,baddr=0x7F79542B5000,$pid=4915,$procname=server_sample
1h 36m 00.029222113s,ust.lttng_ust_cyg_profile:func_exit,CPU 0,addr=module_close,call_site=handle_get+0x17B,$pid=4915,$procname=server_sample,trace_context.vtid=4915
1h 36m 00.029222894s,ust.lttng_ust_cyg_profile:func_exit,CPU 0,addr=handle_get,call_site=handle_connection+0x19C,$pid=4915,$procname=server_sample,trace_context.vtid=4915
1h 36m 00.029223284s,ust.lttng_ust_cyg_profile:func_exit,CPU 0,addr=handle_connection,call_site=server_run+0x227,$pid=4915,$procname=server_sample,trace_context.vtid=4915
1h 36m 00.029770182s,ust.lttng_ust_cyg_profile:func_entry,CPU 2,addr=clean_up_child_process,call_site=__restore_rt,$pid=4489,$procname=server_sample,trace_context.vtid=4489
1h 36m 00.029777599s,ust.lttng_ust_cyg_profile:func_exit,CPU 2,addr=clean_up_child_process,call_site=__restore_rt,$pid=4489,$procname=server_sample,trace_context.vtid=4489


--------------040105000004000205010803
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--------------040105000004000205010803--
