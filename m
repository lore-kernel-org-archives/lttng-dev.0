From: =?ISO-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: No trace files are generated
Date: Tue, 3 Dec 2013 11:01:05 -0500
Message-ID: <CA+jJMxvPCh9KQhOheWpXU5vbvjPzpC82ZWXVZ3NDQaRtxoiQ2g__49442.1095042073$1386086527$gmane$org@mail.gmail.com>
References: <CANQ0=y-M-NMk8J9_t6dS77XvoEbeurh8e=Jag4OG-UiWJouL9Q@mail.gmail.com>
	<CA+jJMxtLD+TEPMn5i88DCPXw_JyuBwutYpDsukiu8WHZ6UtgKg@mail.gmail.com>
	<CANQ0=y9CZkNcLf17=TYrJ+sjzVYeEpHgikQNA44v+_tRZbU7UA@mail.gmail.com>
	<6CFA219DE9CAD940989B83CA579159F91B43966C59@SGSINEXC014.vestas.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qe0-f46.google.com ([209.85.128.46])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jeremie.galarneau@gmail.com>) id 1VnsPO-00027V-Uo
	for lttng-dev@lists.lttng.org; Tue, 03 Dec 2013 11:01:16 -0500
Received: by mail-qe0-f46.google.com with SMTP id a11so14747426qen.19
	for <lttng-dev@lists.lttng.org>; Tue, 03 Dec 2013 08:01:05 -0800 (PST)
In-Reply-To: <6CFA219DE9CAD940989B83CA579159F91B43966C59@SGSINEXC014.vestas.net>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Manikandan Govindaswamy <magov@vestas.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

CC'ing lttng-dev.

Looking at your logfile:

DEBUG3 [21408/21408]: Looking for a kernel consumer at these
locations: (in spawn_consumerd() at main.c:2105)
DEBUG3 [21408/21408]:   1)
/prj/x86/test/mainctrl-image-dev/packages/tools/lttng/lttng-build-root/lib/=
lttng/libexec/lttng-consumerd
(in spawn_consumerd() at main.c:2106)
DEBUG3 [21408/21408]:   2)
/prj/x86/test/mainctrl-image-dev/packages/tools/lttng/lttng-build-root/lib/=
lttng/libexec/lttng-consumerd
(in spawn_consumerd() at main.c:2107)
DEBUG3 [21408/21408]:   3)  (in spawn_consumerd() at main.c:2108)
DEBUG1 [20605/21409]: [thread] Manage consumer started (in
thread_manage_consumer() at main.c:922)
DEBUG1 [21408/21408]: Could not find any valid consumerd executable
(in spawn_consumerd() at main.c:2119)
PERROR [21408/21408]: kernel start consumer exec: No such file or
directory (in spawn_consumerd() at main.c:2224)
Error: Condition timed out. The consumer thread was never ready. Killing it

The session daemon can't find the consumer daemon executables. You
will have to point the session daemon to them manually using the
--consumerd32-path or --consumerd64-path options (depending on your
architecture).

Regards,
J=E9r=E9mie

On Tue, Dec 3, 2013 at 12:11 AM, Manikandan Govindaswamy
<magov@vestas.com> wrote:
> Hi J=E9r=E9mie,
>
>
>
> Thanks for your mail.
>
>
>
> Please find the attached log for the same.
>
>
>
> And I=92m not putting the lttng-sessiond into background task so it=92s j=
ust
> hang in the terminal, so I=92ll use the other terminal to run the followi=
ng
> commands
>
>
>
> #lttng list =96k
>
>
>
> #lttng enable-event =96k =96a
>
>
>
> #lttng start
>
>
>
> #lttng stop
>
>
>
> :demsg dump
>
> [42866.350645] ring buffer relay-metadata: 0 records written, 0 records
> overrun
>
> [42866.350649] ring buffer relay-metadata, cpu -1: non-consumed data
>
> [42866.350649]   [ 8192 bytes written, 0 bytes read ]
>
> [42866.350651] ring buffer: relay-metadata, cpu -1: 4096 bytes committed
>
> [42866.350652] ring buffer: relay-metadata, cpu -1: 4096 bytes committed
>
> [42866.376269] ring buffer relay-discard, cpu 0: 48658 records written, 0
> records overrun
>
> [42866.376272] ring buffer relay-discard, cpu 0: records were lost. Caused
> by:
>
> [42866.376272]   [ 1087084 buffer full, 0 nest buffer wrap-around, 0 event
> too big ]
>
> [42866.390657] ring buffer relay-discard, cpu 0: non-consumed data
>
> [42866.390657]   [ 1048576 bytes written, 0 bytes read ]
>
> [42866.390659] ring buffer: relay-discard, cpu 0: 262144 bytes committed
>
> [42866.390660] ring buffer: relay-discard, cpu 0: 262144 bytes committed
>
> [42866.390662] ring buffer: relay-discard, cpu 0: 262144 bytes committed
>
> [42866.390663] ring buffer: relay-discard, cpu 0: 262144 bytes committed
>
> [42866.390708] ring buffer relay-discard, cpu 1: 34595 records written, 0
> records overrun
>
> [42866.390709] ring buffer relay-discard, cpu 1: records were lost. Caused
> by:
>
> [42866.390709]   [ 466072 buffer full, 0 nest buffer wrap-around, 0 event
> too big ]
>
> [42866.405004] ring buffer relay-discard, cpu 1: non-consumed data
>
> [42866.405004]   [ 1048576 bytes written, 0 bytes read ]
>
> [42866.405006] ring buffer: relay-discard, cpu 1: 262144 bytes committed
>
> [42866.405007] ring buffer: relay-discard, cpu 1: 262144 bytes committed
>
> [42866.405009] ring buffer: relay-discard, cpu 1: 262144 bytes committed
>
> [42866.405010] ring buffer: relay-discard, cpu 1: 262144 bytes committed
>
>
>
> Regards,
>
> GMK
>
>
>
> On Mon, Dec 2, 2013 at 10:32 PM, J=E9r=E9mie Galarneau
> <jeremie.galarneau@efficios.com> wrote:
>
> Very interesting. Could you give me more information about your platform?
>
> I see that you loaded the kernel modules manually. Launching the
> session-daemon as root will take care of it automatically. In fact,
> this is the recommended approach since it takes care of loading the
> modules in the correct order.
>
> Could you retry to trace the kernel, but this time don't load the
> modules manually and launch the session daemon using this command:
>
> lttng-sessiond -vvv --verbose-consumer >sessiond.log 2>&1
>
> and send me the resulting sessiond.log file along with the output of
> lttng list -k and the dmesg output after stopping tracing.
>
> Please do not edit the logs as it may hide important information.
>
> Thanks,
> J=E9r=E9mie
>
>
> On Mon, Dec 2, 2013 at 7:00 AM, Manikandan G <email@manikandan.co.in> wro=
te:
>> Hi !,
>>
>> I'm using the "Dominus Vobiscum" version of Lttng project and building f=
or
>> my custom Linux x86_64 embedded platform.
>>
>>
>> we are using Linux 3.10.20 venila kernel for our custom Linux image.
>>
>>
>>
>> We able to build the kernel modules and tools for the same and able to
>> port
>> it on target but we dont see any trace file is generated between lttng
>> start
>> and stop.
>>
>> Please find the attached document for the detailed log of all commands a=
nd
>> system response.
>>
>> I tried giving with consumerd path and without the same to lttng-sessiond
>> but the behavior is the same.
>>
>> Please let me know what is the issue in it.
>>
>> Regards,
>> GMK
>
>
> --
> J=E9r=E9mie Galarneau
> EfficiOS Inc.
> http://www.efficios.com
>
>



-- =

J=E9r=E9mie Galarneau
EfficiOS Inc.
http://www.efficios.com
