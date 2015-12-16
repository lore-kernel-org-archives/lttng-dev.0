From: Aravind HT <aravind.ht@gmail.com>
Subject: Re: Relayd trace drops
Date: Wed, 16 Dec 2015 18:32:25 +0530
Message-ID: <CACd+_b7X3+Hzi5HYt3KggWMCVNPyhyDb4aK3-Pik98wcb70kCQ__109.805403235619$1450271044$gmane$org@mail.gmail.com>
References: <CACd+_b7qEeW1XD1H_0MT4dDqwLv68rfOURfNDRh6SO=xS4k-Og@mail.gmail.com>
 <CAF4oYfF2Li4zau0OLE=JZUtGfPZyFT1FciBr7AG1hvzGdeUycA@mail.gmail.com>
 <CACd+_b6byMnZ_oWBqEk44fJOgpVX-oAGMjfh_WV8AV6cKyK9iw@mail.gmail.com>
 <56672F33.3070808@efficios.com>
 <CACd+_b6xjN8BEcfqypkhGrM2XWwxhW9RmCVgHfN5jmksGmVnPw@mail.gmail.com>
 <CACd+_b46wkEH3jVOfz=SR2eS+ZXuWoL=f81ahNa4uwPNpWTHbw@mail.gmail.com>
 <566B0FEA.7040307@efficios.com>
 <CACd+_b6za+gk_fFhFapz-zRpwO8B31UX6+hMJxcjJsxrKVM5ow@mail.gmail.com>
 <1125287188.233739.1449873787684.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0838942707=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-lf0-f53.google.com ([209.85.215.53])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <aravind.ht@gmail.com>) id 1a9Bix-000311-DW
 for lttng-dev@lists.lttng.org; Wed, 16 Dec 2015 08:02:40 -0500
Received: by mail-lf0-f53.google.com with SMTP id p203so28922439lfa.0
 for <lttng-dev@lists.lttng.org>; Wed, 16 Dec 2015 05:02:31 -0800 (PST)
In-Reply-To: <1125287188.233739.1449873787684.JavaMail.zimbra@efficios.com>
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

--===============0838942707==
Content-Type: multipart/alternative; boundary=001a114020a28779ac052703842f

--001a114020a28779ac052703842f
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Mathieu,

Ive been able to analyze this sessiond - consumerd hang scenario and I see
that the fix is not available on 2.6.1 or on 2.7.0.

Root Cause :

The hang is mainly caused because of a race condition for the
consumer_metadata_socket between the following two flows of code
Flow 1. do_sync_metadata() -> lttng_ustconsumer_sync_metadat() ->
lttng_ustconsumer_request_metadata() -> lttncomm_recv_unix_sock() ->
recvmsg()

and

Flow 2. lttng_consumer_recv_cmd() -> lttng_ust_consumer_recv_cmd() ->
lttng_ustconsumer_recv_metadata()

Flow 1 above initiates a metadata requests and recvmsg()s for the reply
from sessiond on the consumer_metadata_socket ( it has taken the
metadata_socket_lock and the stream->lock ) , but simultaneously this
socket is being polled from Flow 2. Once in a while Flow 2 gets to receive
while Flow 1 just hangs on recvmsg() . Since Flow 1 has taken the
stream->lock, this then introduces a deadlock at a later stage
(on_buffer_ready() when the metadata is being flushed. )

Think using the metadata_socket_lock in Flow 2 before attempting to receive
may address this issue, but is a bit complicated as the message would have
already been received at the point of using that lock. The other
alternative is to remove the complete recv() from Flow 1 and let that be
taken care by Flow 2.

Please let me know if this has been fixed in the later builds, may be I
searched it wrong.


Regards,
Aravind.

On Sat, Dec 12, 2015 at 4:13 AM, Mathieu Desnoyers <
mathieu.desnoyers@efficios.com> wrote:

> Hi,
>
> Please upgrade to 2.6.1 or 2.7.0, those are old issues.
>
> Thanks,
>
> Mathieu
>
>
> ----- On Dec 11, 2015, at 1:42 PM, Aravind HT <aravind.ht@gmail.com>
> wrote:
>
>
> NPBS understand it, I will continue to investigate this, got a bit side
> tracked with the sessiond hang issue that I mentioned earlier.
> Making some progress on that, will update as soon as I find the root
> cause, it looks like a mutex deadlock between
> the following threads in the consumerd daemon
>
> #1  0x0000000000410b5d in lttcomm_recv_unix_sock (sock=3D26, buf=3Dbuf@en=
try=3D0x7f16acca57f0,
> len=3Dlen@entry=3D4476) at unix.c:175
> #2  0x000000000041dc96 in lttng_ustconsumer_request_metadata (ctx=3Dctx@e=
ntry=3D0x640d10,
> channel=3D0x7f16980192b0, timer=3Dtimer@entry=3D0, wait=3Dwait@entry=3D0)=
 at
> ust-consumer.c:2331
> #3  0x000000000041ff3c in lttng_ustconsumer_sync_metadata (ctx=3Dctx@entr=
y=3D0x640d10,
> metadata=3Dmetadata@entry=3D0x7f169801aa40) at ust-consumer.c:1829
> #4  0x000000000040eabf in do_sync_metadata (ctx=3D<optimized out>,
> metadata=3D<optimized out>) at consumer-stream.c:468
> #5  consumer_stream_sync_metadata (ctx=3Dctx@entry=3D0x640d10, session_id=
=3D8)
> at consumer-stream.c:545
> #6  0x000000000041d316 in lttng_ustconsumer_read_subbuffer
> (stream=3Dstream@entry=3D0x7f1698018fa0, ctx=3Dctx@entry=3D0x640d10) at
> ust-consumer.c:2063
> #7  0x000000000040b613 in lttng_consumer_read_subbuffer
> (stream=3D0x7f1698018fa0, ctx=3D0x640d10) at consumer.c:3203
> #8  0x0000000000409608 in consumer_thread_data_poll (data=3D0x640d10) at
> consumer.c:2557
> #9  0x00007f16af6a6fe3 in start_thread (arg=3D0x7f16acca7700) at
> pthread_create.c:312
> #10 0x00007f16af3dcafd in clone () at
> ../sysdeps/unix/sysv/linux/x86_64/clone.S:111
>
> and
>
> consumer_thread_metadata_poll() calling lttng_consumer_read_subbuffer() /
> on_buffer_ready() calling pthread_mutex_lock(stream->lock) and then hangi=
ng
>
>
> This again can be reproduced by the same script, just running consecutive
> sessions of short duration (<10 seconds) with traces getting captured on =
a
> remote node.
> I hit this every time I run the script.
>
> Regards,
> Aravind.
>
>
>
> On Fri, Dec 11, 2015 at 11:33 PM, Jonathan Rajotte Julien <
> Jonathan.rajotte-julien@efficios.com> wrote:
>
>> Hi Aravind,
>>
>> On 2015-12-11 12:16 PM, Aravind HT wrote:
>>
>>> Hi,
>>>
>>> Did you get a chance to reproduce the problem with the scripts ? Let me
>>> know if you need any help running it.
>>>
>>
>> Time is a scarce resource unfortunately. But until I have the time to
>> look at it you might want to investigate if you are able to reproduce it=
 on
>> 2.6.1/2.7.0/master on 2 regular (x86_64, ubuntu/debian) VM this would
>> really help.
>>
>> Cheers!
>>
>>
>>> Regards,
>>> Aravind.
>>>
>>>
>>> On Wed, Dec 9, 2015 at 3:04 PM, Aravind HT <aravind.ht@gmail.com
>>> <mailto:aravind.ht@gmail.com>> wrote:
>>>
>>>     Sorry about that, not sure how it got missed.
>>>     Here it is.
>>>
>>>
>>>     # This needs a two node set up (1. local current node 2. remote nod=
e
>>> )
>>>     # relayd runs on the current node where traces are captured from
>>>     the remote node
>>>     # remote node runs test applications which generate traces.
>>>     # the launch_script_RN is executed on the current node and uses
>>>     ssh  to execute commands on the remote node. So this part may not
>>>     work in every case and may prompt for a password.
>>>     # if experiencing problems with ssh , kindly check
>>>
>>> http://serverfault.com/questions/241588/how-to-automate-ssh-login-with-=
password
>>>
>>>     # =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D     =
  To Run  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
>>>     launch_script_RN.py self_profile -c /tmp/configFile.txt
>>>
>>>
>>>
>>>     # configFile.txt is the file which has configuration params that
>>>     launchScript
>>>     # needs to configure lttng sessions. Below is an explanation of
>>>     the different options.
>>>     # =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D     con=
figFile.txt
>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
>>>
>>>     [section1]
>>>     # final out put file path
>>>     OutputFile =3D /tmp/Final_report.txt
>>>     # the remote node hostname on which test applications run and the
>>>     test sessions will be created; this should be something that could
>>>     be used with ssh. Traces will be transported from this node to the
>>>     lttng_relayd running on the current node.
>>>     Node =3D MY_REMOTE_NODE
>>>     # Sub buffer size to start this with
>>>     SubBufSize =3D 16k
>>>     # Sub buffer count
>>>     SubBufCount =3D 4
>>>     # per uid buffer
>>>     BufferScheme =3D --buffers-uid
>>>     # yes
>>>     EnableTracing =3D yes
>>>     # Bit rate of the test applications. Comman seperated example "1,
>>>     3, 3, 50" sayss 4 test applications producing 1, 3, 3, and 50 Kb/s
>>>     traces.
>>>     # So with the below, we just start with 1 test application
>>>     producing 10 kb/s
>>>     TestApps =3D 10
>>>     # session life time in seonds
>>>     TestTime =3D 10
>>>     # Max number of successive sessions to configure. if n then n-1
>>>     sessions are run, ex MaxRun =3D 2 will run 1 session.
>>>     MaxRun =3D 100
>>>
>>>
>>>     # =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  Pla=
ce the following files under
>>>     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>
>>>     # /tmp on the remote node
>>>     clean_RemNode_apps.sh
>>>     report_lttng_script.sh
>>>
>>>     # rest of the scripts under /usr/sbin on the current local node on
>>>     which lttng_realyd runs
>>>     # Define a trace point MY_TRACE to take a single string arg with
>>>     LOG_TEST_APP_PROFILING as the provider, compile test lttng_testApp
>>>     and place it under /usr/sbin of the remote host
>>>
>>>     # in launch_script_RN.py change currentNodeIP to the IP address on
>>>     which relayd is receiving, default ports are used.
>>>
>>>     # lttng_relayd is started as
>>>     /usr/bin/lttng-relayd -o /var/log/lttng-traces -d
>>>
>>>     # lttng_sessiond is started as
>>>     /usr/bin/lttng-sessiond --consumerd32-path
>>>     /usr/lib/lttng/libexec/lttng-consumerd --consumerd32-libdir
>>>     /usr/lib/ --consumerd64-path
>>>     /usr/lib64/lttng/libexec/lttng-consumerd --consumerd64-libdir
>>>     /usr/lib64/ -b --no-kernel
>>>
>>>
>>>
>>>
>>>     Regards,
>>>     Aravind.
>>>
>>>     On Wed, Dec 9, 2015 at 12:57 AM, Jonathan Rajotte Julien
>>>     <Jonathan.rajotte-julien@efficios.com
>>>     <mailto:Jonathan.rajotte-julien@efficios.com>> wrote:
>>>
>>>         Hi Aravind,
>>>
>>>         There is no README in the archive you sent.
>>>
>>>         Cheers
>>>
>>>         On 2015-12-08 07:51 AM, Aravind HT wrote:
>>>
>>>             Hi,
>>>
>>>             I am trying to upgrade in parallel, but this issue may
>>>             still be present after I upgrade or may be temporarily
>>>             masked. So I need to find the root cause for this and then
>>>             see if its available on the latest before committing to
>>>             upgrade.
>>>
>>>             There is another issue i'm hitting, the lttng list command
>>>             hangs after lttng destroy session when running the profilin=
g.
>>>
>>>             I found that consumerd 64 goes into an infinite loop
>>>             waiting to flush metadata in
>>>             lttng_ustconsumer_recv_metadata() :: while
>>>             (consumer_metadata_cache_flushed(channel, offset + len,
>>>             timer)) .
>>>             In consumer_metadata_cache,
>>>             channel->metadata_stream->endpoint_status is
>>>             CONSUMER_ENDPOINT_ACTIVE,
>>>             metadata_stream->ust_metadata_pushed is 0 with offset
>>>             having some value. This call always returns a 1 from the
>>>             last else{} block resulting in an infinite loop. Upon
>>>             searching the forum, I found the same issue being reported
>>>             here :
>>>
>>> https://www.mail-archive.com/lttng-dev@lists.lttng.org/msg07982.html
>>>
>>>             Regards,
>>>             Aravind.
>>>
>>>
>>>             On Tue, Dec 8, 2015 at 12:43 AM, Jonathan Rajotte
>>>             <jonathan.r.julien@gmail.com
>>>             <mailto:jonathan.r.julien@gmail.com>> wrote:
>>>
>>>                 Hi Aravind,
>>>
>>>                 Did you have the chance to upgrade to 2.6.1.If so
>>>             where you able
>>>                 to reproduce?
>>>
>>>                 Cheers
>>>
>>>                 On Mon, Dec 7, 2015 at 1:07 PM, Aravind HT
>>>             <aravind.ht@gmail.com <mailto:aravind.ht@gmail.com>>
>>>                 wrote:
>>>
>>>                     Hi,
>>>
>>>                     I have attached the complete profiling scripts
>>>             here, its a bit
>>>                     shabby, im new to python.
>>>
>>>                     There is a README which has the details on how to
>>>             execute it.
>>>                     Im using a Yocto 1.6 on x86_64 platforms on both
>>>             the nodes.
>>>
>>>
>>>                     Running this script when there are other sessions
>>>             running
>>>                     seems to reproduce this problem easily.
>>>                     Please try it and let me know if you have any issue=
s
>>>                     reproducing the problem.
>>>
>>>                     Regards,
>>>                     Aravind.
>>>
>>>                     On Sat, Dec 5, 2015 at 5:23 PM, J=C3=A9r=C3=A9mie G=
alarneau
>>>                     <jeremie.galarneau@efficios.com
>>>             <mailto:jeremie.galarneau@efficios.com>
>>>                     <mailto:jeremie.galarneau@efficios.com
>>>             <mailto:jeremie.galarneau@efficios.com>>> wrote:
>>>
>>>                         On Fri, Dec 4, 2015 at 11:06 PM, Aravind HT
>>>                         <aravind.ht@gmail.com
>>>             <mailto:aravind.ht@gmail.com> <mailto:aravind.ht@gmail.com
>>>
>>>             <mailto:aravind.ht@gmail.com>>> wrote:
>>>                         > I am using 2.6.0 .I will try to share the
>>>             code that I'm
>>>                         using here in some
>>>                         > time. If there are any specific fixes that
>>>             are relevant
>>>                         to this issue, see
>>>                         > if you can provide a link to them. I would
>>>             ideally like
>>>                         to try them out
>>>                         > before trying a full upgrade to the latest
>>>             versions.
>>>
>>>                         Hi,
>>>
>>>                         Can you provide more information on the
>>>             system? Which
>>>                         distribution,
>>>                         architecture, kernel version?
>>>
>>>                         The verbose sessiond logs might help pinpoint a=
ny
>>>                         unexpected behaviour
>>>                         here (are all applications registering as
>>>             expected?).
>>>
>>>                         J=C3=A9r=C3=A9mie
>>>
>>>                         >
>>>                         > On Fri, Dec 4, 2015 at 6:11 PM, J=C3=A9r=C3=
=A9mie
>>>             Galarneau
>>>                         > <jeremie.galarneau@efficios.com
>>>             <mailto:jeremie.galarneau@efficios.com>
>>>                         <mailto:jeremie.galarneau@efficios.com
>>>             <mailto:jeremie.galarneau@efficios.com>>> wrote:
>>>                         >>
>>>                         >> Hi Aravind,
>>>                         >>
>>>                         >> Can't say I have looked at everything you
>>>             sent yet, but
>>>                         as a
>>>                         >> preemptive question, which version are we
>>>             talking about
>>>                         here? 2.6.0 or
>>>                         >> 2.6.1? 2.6.1 contains a lot of relay daemon
>>>             fixes.
>>>                         >>
>>>                         >> Thanks,
>>>                         >> J=C3=A9r=C3=A9mie
>>>                         >>
>>>                         >> On Thu, Dec 3, 2015 at 7:01 AM, Aravind HT
>>>                         <aravind.ht@gmail.com
>>>             <mailto:aravind.ht@gmail.com>> wrote:
>>>                         >> > Hi,
>>>                         >> >
>>>                         >> > I am trying to obtain the performance
>>>             characteristics
>>>                         of lttng with the
>>>                         >> > use
>>>                         >> > of test applications. Traces are being
>>>             produced on a
>>>                         local node and
>>>                         >> > delivered to relayd that is running on a
>>>             separate
>>>                         node for storage.
>>>                         >> >
>>>                         >> > An lttng session with the test
>>>             applications producing
>>>                         an initial bit
>>>                         >> > rate of
>>>                         >> > 10 kb/s is started and run for about 30
>>>             seconds. The
>>>                         starting sub-buffer
>>>                         >> > size is kept at 128 kb and sub-buf count
>>>             at 4. The
>>>                         session is then
>>>                         >> > stopped
>>>                         >> > and destroyed and traces are analyzed to
>>>             see if there
>>>                         are any drops.
>>>                         >> > This is
>>>                         >> > being done in a loop with every
>>>             subsequent session
>>>                         having an increment
>>>                         >> > of 2
>>>                         >> > kb/s as long as there are no drops. If
>>>             there are
>>>                         drops, I increase the
>>>                         >> > buffer size by a factor of x2 without
>>>             incrementing
>>>                         the bit rate.
>>>                         >> >
>>>                         >> > I see trace drops happening consistently
>>>             with test
>>>                         apps producing traces
>>>                         >> > at
>>>                         >> > less than 40 kb/s, it doesnt seem to help
>>>             even if I
>>>                         started with 1mb x 4
>>>                         >> > sub-buffers.
>>>                         >> >
>>>                         >> > Analysis :
>>>                         >> >
>>>                         >> > I have attached the lttng_relayd ,
>>>             lttng_consumerd_64
>>>                         logs and the
>>>                         >> > entire
>>>                         >> > trace directory, hope you will be able to
>>>             view it.
>>>                         >> > I have modified lttng_relayd code to dump
>>>             the traces
>>>                         being captured in
>>>                         >> > the
>>>                         >> > lttng_relayd logs along with debug info.
>>>                         >> >
>>>                         >> > Each test app is producing logs in the
>>>             form of  :
>>>                         >> > "TraceApp PID - 31940 THID - 31970
>>>             @threadRate - 1032
>>>                         b/s appRate - 2079
>>>                         >> > b/s
>>>                         >> > threadTraceNum - 9 appTraceNum - 18
>>>      sleepTime - 192120"
>>>                         >> >
>>>                         >> > The test application PID, test
>>>             application thread id,
>>>                         thread bit rate,
>>>                         >> > test
>>>                         >> > app bit rate, thread trace number and
>>>             application
>>>                         trace number s are
>>>                         >> > part of
>>>                         >> > the trace. So in the above trace, the
>>>             thread is
>>>                         producing at 1 kb/s and
>>>                         >> > the
>>>                         >> > whole test app is producing at 2 kb/s.
>>>                         >> >
>>>                         >> > If we look at the babeltrace out put, we
>>>             see that the
>>>                         Trace with
>>>                         >> > TraceApp
>>>                         >> > PID - 31940 appTraceNum 2 is missing ,
>>>             with 1, 3, 4,
>>>                         5 and so on being
>>>                         >> > successfully captured.
>>>                         >> > I looked at the lttng_relayd logs and
>>>             found that
>>>                         trace of "appTraceNum
>>>                         >> > 2" is
>>>                         >> > not delivered/generated by the consumerd
>>>             to the
>>>                         relayd in sequence with
>>>                         >> > other traces. To rule out that this is
>>>             not a test
>>>                         application problem,
>>>                         >> > you
>>>                         >> > can look at line ltttng_relayd log :
>>>             12778 and see
>>>                         traces from
>>>                         >> > appTraceNum -
>>>                         >> > 1 to appTraceNum - 18 including the
>>>             appTraceNum 2 are
>>>                         "re-delivered" by
>>>                         >> > the
>>>                         >> > consumerd to the relayd.
>>>                         >> > Essentially, I see appTraceNum 1 through
>>>             appTraceNum
>>>                         18 being delivered
>>>                         >> > twice, once individually where
>>>             appTraceNum 2 is
>>>                         missing and once as a
>>>                         >> > group
>>>                         >> > at line 12778 where its present.
>>>                         >> >
>>>                         >> >
>>>                         >> > Request help with
>>>                         >> > 1. why traces are delivered twice, is it
>>>             by design or
>>>                         a genuine problem
>>>                         >> > ?
>>>                         >> > 2. how to avoid traces being dropped even
>>>             though
>>>                         buffers are
>>>                         >> > sufficiently
>>>                         >> > large enough ?
>>>                         >> >
>>>                         >> >
>>>                         >> > Regards,
>>>                         >> > Aravind.
>>>                         >> >
>>>                         >> >
>>>             _______________________________________________
>>>                         >> > lttng-dev mailing list
>>>                         >> > lttng-dev@lists.lttng.org
>>>             <mailto:lttng-dev@lists.lttng.org>
>>>                         >> >
>>>             http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>>>                         >> >
>>>                         >>
>>>                         >>
>>>                         >>
>>>                         >> --
>>>                         >> J=C3=A9r=C3=A9mie Galarneau
>>>                         >> EfficiOS Inc.
>>>                         >> http://www.efficios.com
>>>                         >
>>>                         >
>>>
>>>
>>>
>>>                         --
>>>                         J=C3=A9r=C3=A9mie Galarneau
>>>                         EfficiOS Inc.
>>>             http://www.efficios.com
>>>
>>>
>>>
>>>             _______________________________________________
>>>                     lttng-dev mailing list
>>>             lttng-dev@lists.lttng.org
>>>             <mailto:lttng-dev@lists.lttng.org>
>>>             <mailto:lttng-dev@lists.lttng.org
>>>             <mailto:lttng-dev@lists.lttng.org>>
>>>             http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>>>
>>>
>>>
>>>
>>>                 --     Jonathan Rajotte Julien
>>>
>>>
>>>
>>>
>>>             _______________________________________________
>>>             lttng-dev mailing list
>>>             lttng-dev@lists.lttng.org <mailto:lttng-dev@lists.lttng.org=
>
>>>             http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>>>
>>>
>>>         --         Jonathan R. Julien
>>>         Efficios
>>>
>>>
>>>
>>>
>> --
>> Jonathan R. Julien
>> Efficios
>>
>>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
>

--001a114020a28779ac052703842f
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+SGkgTWF0aGlldSw8ZGl2Pjxicj48L2Rpdj48ZGl2Pkl2ZSBiZWVuIGFi
bGUgdG8gYW5hbHl6ZSB0aGlzIHNlc3Npb25kIC0gY29uc3VtZXJkIGhhbmcgc2NlbmFyaW8gYW5k
IEkgc2VlIHRoYXQgdGhlIGZpeCBpcyBub3QgYXZhaWxhYmxlIG9uIDIuNi4xIG9yIG9uIDIuNy4w
LjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+Um9vdCBDYXVzZSA6PC9kaXY+PGRpdj48YnI+PC9k
aXY+PGRpdj5UaGUgaGFuZyBpcyBtYWlubHkgY2F1c2VkIGJlY2F1c2Ugb2YgYSByYWNlIGNvbmRp
dGlvbiBmb3IgdGhlIGNvbnN1bWVyX21ldGFkYXRhX3NvY2tldCBiZXR3ZWVuIHRoZSBmb2xsb3dp
bmcgdHdvIGZsb3dzIG9mIGNvZGU8L2Rpdj48ZGl2PkZsb3cgMS4gZG9fc3luY19tZXRhZGF0YSgp
IC0mZ3Q7IGx0dG5nX3VzdGNvbnN1bWVyX3N5bmNfbWV0YWRhdCgpIC0mZ3Q7IGx0dG5nX3VzdGNv
bnN1bWVyX3JlcXVlc3RfbWV0YWRhdGEoKSAtJmd0OyBsdHRuY29tbV9yZWN2X3VuaXhfc29jaygp
IC0mZ3Q7IHJlY3Ztc2coKTwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+YW5kPC9kaXY+PGRpdj48
YnI+PC9kaXY+PGRpdj5GbG93IDIuIGx0dG5nX2NvbnN1bWVyX3JlY3ZfY21kKCkgLSZndDsgbHR0
bmdfdXN0X2NvbnN1bWVyX3JlY3ZfY21kKCkgLSZndDsgbHR0bmdfdXN0Y29uc3VtZXJfcmVjdl9t
ZXRhZGF0YSgpPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5GbG93IDEgYWJvdmUgaW5pdGlhdGVz
IGEgbWV0YWRhdGEgcmVxdWVzdHMgYW5kIHJlY3Ztc2coKXMgZm9yIHRoZSByZXBseSBmcm9tIHNl
c3Npb25kIG9uIHRoZcKgY29uc3VtZXJfbWV0YWRhdGFfc29ja2V0wqAoIGl0IGhhcyB0YWtlbiB0
aGUgbWV0YWRhdGFfc29ja2V0X2xvY2sgYW5kIHRoZSBzdHJlYW0tJmd0O2xvY2sgKSAsIGJ1dCBz
aW11bHRhbmVvdXNseSB0aGlzIHNvY2tldCBpcyBiZWluZyBwb2xsZWQgZnJvbSBGbG93IDIuIE9u
Y2UgaW4gYSB3aGlsZSBGbG93IDIgZ2V0cyB0byByZWNlaXZlIHdoaWxlIEZsb3cgMSBqdXN0IGhh
bmdzIG9uIHJlY3Ztc2coKSAuIFNpbmNlIEZsb3cgMSBoYXMgdGFrZW4gdGhlIHN0cmVhbS0mZ3Q7
bG9jaywgdGhpcyB0aGVuIGludHJvZHVjZXMgYSBkZWFkbG9jayBhdCBhIGxhdGVyIHN0YWdlIChv
bl9idWZmZXJfcmVhZHkoKSB3aGVuIHRoZSBtZXRhZGF0YSBpcyBiZWluZyBmbHVzaGVkLiApPC9k
aXY+PGRpdj48YnI+PC9kaXY+PGRpdj5UaGluayB1c2luZyB0aGUgbWV0YWRhdGFfc29ja2V0X2xv
Y2sgaW4gRmxvdyAyIGJlZm9yZSBhdHRlbXB0aW5nIHRvIHJlY2VpdmUgbWF5IGFkZHJlc3MgdGhp
cyBpc3N1ZSwgYnV0IGlzIGEgYml0IGNvbXBsaWNhdGVkIGFzIHRoZSBtZXNzYWdlIHdvdWxkIGhh
dmUgYWxyZWFkeSBiZWVuIHJlY2VpdmVkIGF0IHRoZSBwb2ludCBvZiB1c2luZyB0aGF0IGxvY2su
IFRoZSBvdGhlciBhbHRlcm5hdGl2ZSBpcyB0byByZW1vdmUgdGhlIGNvbXBsZXRlIHJlY3YoKSBm
cm9tIEZsb3cgMSBhbmQgbGV0IHRoYXQgYmUgdGFrZW4gY2FyZSBieSBGbG93IDIuPC9kaXY+PGRp
dj48YnI+PC9kaXY+PGRpdj5QbGVhc2UgbGV0IG1lIGtub3cgaWYgdGhpcyBoYXMgYmVlbiBmaXhl
ZCBpbiB0aGUgbGF0ZXIgYnVpbGRzLCBtYXkgYmUgSSBzZWFyY2hlZCBpdCB3cm9uZy48L2Rpdj48
ZGl2Pjxicj48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PlJlZ2FyZHMsPC9kaXY+PGRpdj5BcmF2
aW5kLjwvZGl2PjwvZGl2PjxkaXYgY2xhc3M9ImdtYWlsX2V4dHJhIj48YnI+PGRpdiBjbGFzcz0i
Z21haWxfcXVvdGUiPk9uIFNhdCwgRGVjIDEyLCAyMDE1IGF0IDQ6MTMgQU0sIE1hdGhpZXUgRGVz
bm95ZXJzIDxzcGFuIGRpcj0ibHRyIj4mbHQ7PGEgaHJlZj0ibWFpbHRvOm1hdGhpZXUuZGVzbm95
ZXJzQGVmZmljaW9zLmNvbSIgdGFyZ2V0PSJfYmxhbmsiPm1hdGhpZXUuZGVzbm95ZXJzQGVmZmlj
aW9zLmNvbTwvYT4mZ3Q7PC9zcGFuPiB3cm90ZTo8YnI+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWls
X3F1b3RlIiBzdHlsZT0ibWFyZ2luOjAgMCAwIC44ZXg7Ym9yZGVyLWxlZnQ6MXB4ICNjY2Mgc29s
aWQ7cGFkZGluZy1sZWZ0OjFleCI+PGRpdj48ZGl2IHN0eWxlPSJmb250LWZhbWlseTphcmlhbCxo
ZWx2ZXRpY2Esc2Fucy1zZXJpZjtmb250LXNpemU6MTJwdDtjb2xvcjojMDAwMDAwIj48ZGl2Pkhp
LDwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+UGxlYXNlIHVwZ3JhZGUgdG8gMi42LjEgb3IgMi43
LjAsIHRob3NlIGFyZSBvbGQgaXNzdWVzLjxicj48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PlRo
YW5rcyw8YnI+PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5NYXRoaWV1PGJyPjwvZGl2PjxkaXY+
PGRpdiBjbGFzcz0iaDUiPjxkaXY+PGJyPjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+PHNwYW4+
LS0tLS0gT24gRGVjIDExLCAyMDE1LCBhdCAxOjQyIFBNLCBBcmF2aW5kIEhUICZsdDs8YSBocmVm
PSJtYWlsdG86YXJhdmluZC5odEBnbWFpbC5jb20iIHRhcmdldD0iX2JsYW5rIj5hcmF2aW5kLmh0
QGdtYWlsLmNvbTwvYT4mZ3Q7IHdyb3RlOjxicj48L3NwYW4+PC9kaXY+PC9kaXY+PC9kaXY+PGRp
dj48YmxvY2txdW90ZSBzdHlsZT0iYm9yZGVyLWxlZnQ6MnB4IHNvbGlkICMxMDEwZmY7bWFyZ2lu
LWxlZnQ6NXB4O3BhZGRpbmctbGVmdDo1cHg7Y29sb3I6IzAwMDtmb250LXdlaWdodDpub3JtYWw7
Zm9udC1zdHlsZTpub3JtYWw7dGV4dC1kZWNvcmF0aW9uOm5vbmU7Zm9udC1mYW1pbHk6SGVsdmV0
aWNhLEFyaWFsLHNhbnMtc2VyaWY7Zm9udC1zaXplOjEycHQiPjxkaXY+PGRpdiBjbGFzcz0iaDUi
PjxkaXYgZGlyPSJsdHIiPjxicj5OUEJTIHVuZGVyc3RhbmQgaXQsIEkgd2lsbCBjb250aW51ZSB0
byBpbnZlc3RpZ2F0ZSB0aGlzLCBnb3QgYSBiaXQgc2lkZSB0cmFja2VkIHdpdGggdGhlIHNlc3Np
b25kIGhhbmcgaXNzdWUgdGhhdCBJIG1lbnRpb25lZCBlYXJsaWVyLsKgPGRpdj5NYWtpbmcgc29t
ZSBwcm9ncmVzcyBvbiB0aGF0LCB3aWxsIHVwZGF0ZSBhcyBzb29uIGFzIEkgZmluZCB0aGUgcm9v
dCBjYXVzZSwgaXQgbG9va3MgbGlrZSBhIG11dGV4IGRlYWRsb2NrIGJldHdlZW7CoDxicj48L2Rp
dj48ZGl2PjxkaXY+dGhlIGZvbGxvd2luZyB0aHJlYWRzIGluIHRoZSBjb25zdW1lcmQgZGFlbW9u
PC9kaXY+PGJyPjxkaXY+IzEgwqAweDAwMDAwMDAwMDA0MTBiNWQgaW4gbHR0Y29tbV9yZWN2X3Vu
aXhfc29jayAoc29jaz0yNiwgYnVmPWJ1ZkBlbnRyeT0weDdmMTZhY2NhNTdmMCwgbGVuPWxlbkBl
bnRyeT00NDc2KSBhdCB1bml4LmM6MTc1PGRpdj4jMiDCoDB4MDAwMDAwMDAwMDQxZGM5NiBpbiBs
dHRuZ191c3Rjb25zdW1lcl9yZXF1ZXN0X21ldGFkYXRhIChjdHg9Y3R4QGVudHJ5PTB4NjQwZDEw
LCBjaGFubmVsPTB4N2YxNjk4MDE5MmIwLCB0aW1lcj10aW1lckBlbnRyeT0wLCB3YWl0PXdhaXRA
ZW50cnk9MCkgYXQgdXN0LWNvbnN1bWVyLmM6MjMzMTwvZGl2PjxkaXY+IzMgwqAweDAwMDAwMDAw
MDA0MWZmM2MgaW4gbHR0bmdfdXN0Y29uc3VtZXJfc3luY19tZXRhZGF0YSAoY3R4PWN0eEBlbnRy
eT0weDY0MGQxMCwgbWV0YWRhdGE9bWV0YWRhdGFAZW50cnk9MHg3ZjE2OTgwMWFhNDApIGF0IHVz
dC1jb25zdW1lci5jOjE4Mjk8L2Rpdj48ZGl2PiM0IMKgMHgwMDAwMDAwMDAwNDBlYWJmIGluIGRv
X3N5bmNfbWV0YWRhdGEgKGN0eD0mbHQ7b3B0aW1pemVkIG91dCZndDssIG1ldGFkYXRhPSZsdDtv
cHRpbWl6ZWQgb3V0Jmd0OykgYXQgY29uc3VtZXItc3RyZWFtLmM6NDY4PC9kaXY+PGRpdj4jNSDC
oGNvbnN1bWVyX3N0cmVhbV9zeW5jX21ldGFkYXRhIChjdHg9Y3R4QGVudHJ5PTB4NjQwZDEwLCBz
ZXNzaW9uX2lkPTgpIGF0IGNvbnN1bWVyLXN0cmVhbS5jOjU0NTwvZGl2PjxkaXY+IzYgwqAweDAw
MDAwMDAwMDA0MWQzMTYgaW4gbHR0bmdfdXN0Y29uc3VtZXJfcmVhZF9zdWJidWZmZXIgKHN0cmVh
bT1zdHJlYW1AZW50cnk9MHg3ZjE2OTgwMThmYTAsIGN0eD1jdHhAZW50cnk9MHg2NDBkMTApIGF0
IHVzdC1jb25zdW1lci5jOjIwNjM8L2Rpdj48ZGl2PiM3IMKgMHgwMDAwMDAwMDAwNDBiNjEzIGlu
IGx0dG5nX2NvbnN1bWVyX3JlYWRfc3ViYnVmZmVyIChzdHJlYW09MHg3ZjE2OTgwMThmYTAsIGN0
eD0weDY0MGQxMCkgYXQgY29uc3VtZXIuYzozMjAzPC9kaXY+PGRpdj4jOCDCoDB4MDAwMDAwMDAw
MDQwOTYwOCBpbiBjb25zdW1lcl90aHJlYWRfZGF0YV9wb2xsIChkYXRhPTB4NjQwZDEwKSBhdCBj
b25zdW1lci5jOjI1NTc8L2Rpdj48ZGl2PiM5IMKgMHgwMDAwN2YxNmFmNmE2ZmUzIGluIHN0YXJ0
X3RocmVhZCAoYXJnPTB4N2YxNmFjY2E3NzAwKSBhdCBwdGhyZWFkX2NyZWF0ZS5jOjMxMjwvZGl2
PjxkaXY+IzEwIDB4MDAwMDdmMTZhZjNkY2FmZCBpbiBjbG9uZSAoKSBhdCAuLi9zeXNkZXBzL3Vu
aXgvc3lzdi9saW51eC94ODZfNjQvY2xvbmUuUzoxMTE8L2Rpdj48L2Rpdj48L2Rpdj48YnI+PGRp
dj5hbmTCoDwvZGl2Pjxicj48ZGl2PmNvbnN1bWVyX3RocmVhZF9tZXRhZGF0YV9wb2xsKCkgY2Fs
bGluZyBsdHRuZ19jb25zdW1lcl9yZWFkX3N1YmJ1ZmZlcigpIC8gb25fYnVmZmVyX3JlYWR5KCkg
Y2FsbGluZyBwdGhyZWFkX211dGV4X2xvY2soc3RyZWFtLSZndDtsb2NrKSBhbmQgdGhlbiBoYW5n
aW5nPC9kaXY+PGRpdj48YnI+PGJyPjxkaXY+VGhpcyBhZ2FpbiBjYW4gYmUgcmVwcm9kdWNlZCBi
eSB0aGUgc2FtZSBzY3JpcHQsIGp1c3QgcnVubmluZyBjb25zZWN1dGl2ZSBzZXNzaW9ucyBvZiBz
aG9ydCBkdXJhdGlvbiAoJmx0OzEwIHNlY29uZHMpIHdpdGggdHJhY2VzIGdldHRpbmcgY2FwdHVy
ZWQgb24gYSByZW1vdGUgbm9kZS48L2Rpdj48ZGl2PkkgaGl0IHRoaXMgZXZlcnkgdGltZSBJIHJ1
biB0aGUgc2NyaXB0LjwvZGl2Pjxicj48ZGl2PlJlZ2FyZHMsPC9kaXY+PGRpdj5BcmF2aW5kLjwv
ZGl2Pjxicj48ZGl2IGNsYXNzPSJnbWFpbF9leHRyYSI+PGJyPjwvZGl2PjxkaXYgY2xhc3M9Imdt
YWlsX2V4dHJhIj48YnI+PGRpdiBjbGFzcz0iZ21haWxfcXVvdGUiPk9uIEZyaSwgRGVjIDExLCAy
MDE1IGF0IDExOjMzIFBNLCBKb25hdGhhbiBSYWpvdHRlIEp1bGllbiA8c3BhbiBkaXI9Imx0ciI+
Jmx0OzxhIGhyZWY9Im1haWx0bzpKb25hdGhhbi5yYWpvdHRlLWp1bGllbkBlZmZpY2lvcy5jb20i
IHRhcmdldD0iX2JsYW5rIj5Kb25hdGhhbi5yYWpvdHRlLWp1bGllbkBlZmZpY2lvcy5jb208L2E+
Jmd0Ozwvc3Bhbj4gd3JvdGU6PGJyPjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5
bGU9Im1hcmdpbjowcHggMHB4IDBweCAwLjhleDtib3JkZXItbGVmdC13aWR0aDoxcHg7Ym9yZGVy
LWxlZnQtY29sb3I6cmdiKDIwNCwyMDQsMjA0KTtib3JkZXItbGVmdC1zdHlsZTpzb2xpZDtwYWRk
aW5nLWxlZnQ6MWV4Ij5IaSBBcmF2aW5kLDxzcGFuPjxicj4NCjxicj4NCk9uIDIwMTUtMTItMTEg
MTI6MTYgUE0sIEFyYXZpbmQgSFQgd3JvdGU6PGJyPg0KPGJsb2NrcXVvdGUgY2xhc3M9ImdtYWls
X3F1b3RlIiBzdHlsZT0ibWFyZ2luOjBweCAwcHggMHB4IDAuOGV4O2JvcmRlci1sZWZ0LXdpZHRo
OjFweDtib3JkZXItbGVmdC1jb2xvcjpyZ2IoMjA0LDIwNCwyMDQpO2JvcmRlci1sZWZ0LXN0eWxl
OnNvbGlkO3BhZGRpbmctbGVmdDoxZXgiPg0KSGksPGJyPg0KPGJyPg0KRGlkIHlvdSBnZXQgYSBj
aGFuY2UgdG8gcmVwcm9kdWNlIHRoZSBwcm9ibGVtIHdpdGggdGhlIHNjcmlwdHMgPyBMZXQgbWUg
a25vdyBpZiB5b3UgbmVlZCBhbnkgaGVscCBydW5uaW5nIGl0Ljxicj4NCjwvYmxvY2txdW90ZT4N
Cjxicj48L3NwYW4+DQpUaW1lIGlzIGEgc2NhcmNlIHJlc291cmNlIHVuZm9ydHVuYXRlbHkuIEJ1
dCB1bnRpbCBJIGhhdmUgdGhlIHRpbWUgdG8gbG9vayBhdCBpdCB5b3UgbWlnaHQgd2FudCB0byBp
bnZlc3RpZ2F0ZSBpZiB5b3UgYXJlIGFibGUgdG8gcmVwcm9kdWNlIGl0IG9uIDIuNi4xLzIuNy4w
L21hc3RlciBvbiAyIHJlZ3VsYXIgKHg4Nl82NCwgdWJ1bnR1L2RlYmlhbikgVk0gdGhpcyB3b3Vs
ZCByZWFsbHkgaGVscC48YnI+DQo8YnI+DQpDaGVlcnMhPGJyPg0KPGJyPg0KPGJsb2NrcXVvdGUg
Y2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjBweCAwcHggMHB4IDAuOGV4O2JvcmRl
ci1sZWZ0LXdpZHRoOjFweDtib3JkZXItbGVmdC1jb2xvcjpyZ2IoMjA0LDIwNCwyMDQpO2JvcmRl
ci1sZWZ0LXN0eWxlOnNvbGlkO3BhZGRpbmctbGVmdDoxZXgiPg0KPGJyPg0KUmVnYXJkcyw8YnI+
DQpBcmF2aW5kLjxkaXY+PGRpdj48YnI+DQo8YnI+DQpPbiBXZWQsIERlYyA5LCAyMDE1IGF0IDM6
MDQgUE0sIEFyYXZpbmQgSFQgJmx0OzxhIGhyZWY9Im1haWx0bzphcmF2aW5kLmh0QGdtYWlsLmNv
bSIgdGFyZ2V0PSJfYmxhbmsiPmFyYXZpbmQuaHRAZ21haWwuY29tPC9hPiAmbHQ7bWFpbHRvOjxh
IGhyZWY9Im1haWx0bzphcmF2aW5kLmh0QGdtYWlsLmNvbSIgdGFyZ2V0PSJfYmxhbmsiPmFyYXZp
bmQuaHRAZ21haWwuY29tPC9hPiZndDsmZ3Q7IHdyb3RlOjxicj4NCjxicj4NCsKgIMKgIFNvcnJ5
IGFib3V0IHRoYXQsIG5vdCBzdXJlIGhvdyBpdCBnb3QgbWlzc2VkLjxicj4NCsKgIMKgIEhlcmUg
aXQgaXMuPGJyPg0KPGJyPg0KPGJyPg0KwqAgwqAgIyBUaGlzIG5lZWRzIGEgdHdvIG5vZGUgc2V0
IHVwICgxLiBsb2NhbCBjdXJyZW50IG5vZGUgMi4gcmVtb3RlIG5vZGUgKTxicj4NCsKgIMKgICMg
cmVsYXlkIHJ1bnMgb24gdGhlIGN1cnJlbnQgbm9kZSB3aGVyZSB0cmFjZXMgYXJlIGNhcHR1cmVk
IGZyb208YnI+DQrCoCDCoCB0aGUgcmVtb3RlIG5vZGU8YnI+DQrCoCDCoCAjIHJlbW90ZSBub2Rl
IHJ1bnMgdGVzdCBhcHBsaWNhdGlvbnMgd2hpY2ggZ2VuZXJhdGUgdHJhY2VzLjxicj4NCsKgIMKg
ICMgdGhlIGxhdW5jaF9zY3JpcHRfUk4gaXMgZXhlY3V0ZWQgb24gdGhlIGN1cnJlbnQgbm9kZSBh
bmQgdXNlczxicj4NCsKgIMKgIHNzaMKgIHRvIGV4ZWN1dGUgY29tbWFuZHMgb24gdGhlIHJlbW90
ZSBub2RlLiBTbyB0aGlzIHBhcnQgbWF5IG5vdDxicj4NCsKgIMKgIHdvcmsgaW4gZXZlcnkgY2Fz
ZSBhbmQgbWF5IHByb21wdCBmb3IgYSBwYXNzd29yZC48YnI+DQrCoCDCoCAjIGlmIGV4cGVyaWVu
Y2luZyBwcm9ibGVtcyB3aXRoIHNzaCAsIGtpbmRseSBjaGVjazxicj4NCsKgIMKgIDxhIGhyZWY9
Imh0dHA6Ly9zZXJ2ZXJmYXVsdC5jb20vcXVlc3Rpb25zLzI0MTU4OC9ob3ctdG8tYXV0b21hdGUt
c3NoLWxvZ2luLXdpdGgtcGFzc3dvcmQiIHJlbD0ibm9yZWZlcnJlciIgdGFyZ2V0PSJfYmxhbmsi
Pmh0dHA6Ly9zZXJ2ZXJmYXVsdC5jb20vcXVlc3Rpb25zLzI0MTU4OC9ob3ctdG8tYXV0b21hdGUt
c3NoLWxvZ2luLXdpdGgtcGFzc3dvcmQ8L2E+PGJyPg0KPGJyPg0KwqAgwqAgIyA9PT09PT09PT09
PT09PT09PT09PcKgIMKgIMKgIMKgVG8gUnVuwqAgPT09PT09PT09PT09PT09PT09PT09PT09PT09
PT08YnI+DQrCoCDCoCBsYXVuY2hfc2NyaXB0X1JOLnB5IHNlbGZfcHJvZmlsZSAtYyAvdG1wL2Nv
bmZpZ0ZpbGUudHh0PGJyPg0KPGJyPg0KPGJyPg0KPGJyPg0KwqAgwqAgIyBjb25maWdGaWxlLnR4
dCBpcyB0aGUgZmlsZSB3aGljaCBoYXMgY29uZmlndXJhdGlvbiBwYXJhbXMgdGhhdDxicj4NCsKg
IMKgIGxhdW5jaFNjcmlwdDxicj4NCsKgIMKgICMgbmVlZHMgdG8gY29uZmlndXJlIGx0dG5nIHNl
c3Npb25zLiBCZWxvdyBpcyBhbiBleHBsYW5hdGlvbiBvZjxicj4NCsKgIMKgIHRoZSBkaWZmZXJl
bnQgb3B0aW9ucy48YnI+DQrCoCDCoCAjID09PT09PT09PT09PT09PT09PT3CoCDCoCDCoGNvbmZp
Z0ZpbGUudHh0ID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PGJyPg0KPGJyPg0KwqAgwqAg
W3NlY3Rpb24xXTxicj4NCsKgIMKgICMgZmluYWwgb3V0IHB1dCBmaWxlIHBhdGg8YnI+DQrCoCDC
oCBPdXRwdXRGaWxlID0gL3RtcC9GaW5hbF9yZXBvcnQudHh0PGJyPg0KwqAgwqAgIyB0aGUgcmVt
b3RlIG5vZGUgaG9zdG5hbWUgb24gd2hpY2ggdGVzdCBhcHBsaWNhdGlvbnMgcnVuIGFuZCB0aGU8
YnI+DQrCoCDCoCB0ZXN0IHNlc3Npb25zIHdpbGwgYmUgY3JlYXRlZDsgdGhpcyBzaG91bGQgYmUg
c29tZXRoaW5nIHRoYXQgY291bGQ8YnI+DQrCoCDCoCBiZSB1c2VkIHdpdGggc3NoLiBUcmFjZXMg
d2lsbCBiZSB0cmFuc3BvcnRlZCBmcm9tIHRoaXMgbm9kZSB0byB0aGU8YnI+DQrCoCDCoCBsdHRu
Z19yZWxheWQgcnVubmluZyBvbiB0aGUgY3VycmVudCBub2RlLjxicj4NCsKgIMKgIE5vZGUgPSBN
WV9SRU1PVEVfTk9ERTxicj4NCsKgIMKgICMgU3ViIGJ1ZmZlciBzaXplIHRvIHN0YXJ0IHRoaXMg
d2l0aDxicj4NCsKgIMKgIFN1YkJ1ZlNpemUgPSAxNms8YnI+DQrCoCDCoCAjIFN1YiBidWZmZXIg
Y291bnQ8YnI+DQrCoCDCoCBTdWJCdWZDb3VudCA9IDQ8YnI+DQrCoCDCoCAjIHBlciB1aWQgYnVm
ZmVyPGJyPg0KwqAgwqAgQnVmZmVyU2NoZW1lID0gLS1idWZmZXJzLXVpZDxicj4NCsKgIMKgICMg
eWVzPGJyPg0KwqAgwqAgRW5hYmxlVHJhY2luZyA9IHllczxicj4NCsKgIMKgICMgQml0IHJhdGUg
b2YgdGhlIHRlc3QgYXBwbGljYXRpb25zLiBDb21tYW4gc2VwZXJhdGVkIGV4YW1wbGUgJnF1b3Q7
MSw8YnI+DQrCoCDCoCAzLCAzLCA1MCZxdW90OyBzYXlzcyA0IHRlc3QgYXBwbGljYXRpb25zIHBy
b2R1Y2luZyAxLCAzLCAzLCBhbmQgNTAgS2Ivczxicj4NCsKgIMKgIHRyYWNlcy48YnI+DQrCoCDC
oCAjIFNvIHdpdGggdGhlIGJlbG93LCB3ZSBqdXN0IHN0YXJ0IHdpdGggMSB0ZXN0IGFwcGxpY2F0
aW9uPGJyPg0KwqAgwqAgcHJvZHVjaW5nIDEwIGtiL3M8YnI+DQrCoCDCoCBUZXN0QXBwcyA9IDEw
PGJyPg0KwqAgwqAgIyBzZXNzaW9uIGxpZmUgdGltZSBpbiBzZW9uZHM8YnI+DQrCoCDCoCBUZXN0
VGltZSA9IDEwPGJyPg0KwqAgwqAgIyBNYXggbnVtYmVyIG9mIHN1Y2Nlc3NpdmUgc2Vzc2lvbnMg
dG8gY29uZmlndXJlLiBpZiBuIHRoZW4gbi0xPGJyPg0KwqAgwqAgc2Vzc2lvbnMgYXJlIHJ1biwg
ZXggTWF4UnVuID0gMiB3aWxsIHJ1biAxIHNlc3Npb24uPGJyPg0KwqAgwqAgTWF4UnVuID0gMTAw
PGJyPg0KPGJyPg0KPGJyPg0KwqAgwqAgIyA9PT09PT09PT09PT09PT09PT09PcKgIFBsYWNlIHRo
ZSBmb2xsb3dpbmcgZmlsZXMgdW5kZXI8YnI+DQrCoCDCoCA9PT09PT09PT09PT09PT08YnI+DQo8
YnI+DQrCoCDCoCAjIC90bXAgb24gdGhlIHJlbW90ZSBub2RlPGJyPg0KwqAgwqAgY2xlYW5fUmVt
Tm9kZV9hcHBzLnNoPGJyPg0KwqAgwqAgcmVwb3J0X2x0dG5nX3NjcmlwdC5zaDxicj4NCjxicj4N
CsKgIMKgICMgcmVzdCBvZiB0aGUgc2NyaXB0cyB1bmRlciAvdXNyL3NiaW4gb24gdGhlIGN1cnJl
bnQgbG9jYWwgbm9kZSBvbjxicj4NCsKgIMKgIHdoaWNoIGx0dG5nX3JlYWx5ZCBydW5zPGJyPg0K
wqAgwqAgIyBEZWZpbmUgYSB0cmFjZSBwb2ludCBNWV9UUkFDRSB0byB0YWtlIGEgc2luZ2xlIHN0
cmluZyBhcmcgd2l0aDxicj4NCsKgIMKgIExPR19URVNUX0FQUF9QUk9GSUxJTkcgYXMgdGhlIHBy
b3ZpZGVyLCBjb21waWxlIHRlc3QgbHR0bmdfdGVzdEFwcDxicj4NCsKgIMKgIGFuZCBwbGFjZSBp
dCB1bmRlciAvdXNyL3NiaW4gb2YgdGhlIHJlbW90ZSBob3N0PGJyPg0KPGJyPg0KwqAgwqAgIyBp
biBsYXVuY2hfc2NyaXB0X1JOLnB5IGNoYW5nZSBjdXJyZW50Tm9kZUlQIHRvIHRoZSBJUCBhZGRy
ZXNzIG9uPGJyPg0KwqAgwqAgd2hpY2ggcmVsYXlkIGlzIHJlY2VpdmluZywgZGVmYXVsdCBwb3J0
cyBhcmUgdXNlZC48YnI+DQo8YnI+DQrCoCDCoCAjIGx0dG5nX3JlbGF5ZCBpcyBzdGFydGVkIGFz
PGJyPg0KwqAgwqAgL3Vzci9iaW4vbHR0bmctcmVsYXlkIC1vIC92YXIvbG9nL2x0dG5nLXRyYWNl
cyAtZDxicj4NCjxicj4NCsKgIMKgICMgbHR0bmdfc2Vzc2lvbmQgaXMgc3RhcnRlZCBhczxicj4N
CsKgIMKgIC91c3IvYmluL2x0dG5nLXNlc3Npb25kIC0tY29uc3VtZXJkMzItcGF0aDxicj4NCsKg
IMKgIC91c3IvbGliL2x0dG5nL2xpYmV4ZWMvbHR0bmctY29uc3VtZXJkIC0tY29uc3VtZXJkMzIt
bGliZGlyPGJyPg0KwqAgwqAgL3Vzci9saWIvIC0tY29uc3VtZXJkNjQtcGF0aDxicj4NCsKgIMKg
IC91c3IvbGliNjQvbHR0bmcvbGliZXhlYy9sdHRuZy1jb25zdW1lcmQgLS1jb25zdW1lcmQ2NC1s
aWJkaXI8YnI+DQrCoCDCoCAvdXNyL2xpYjY0LyAtYiAtLW5vLWtlcm5lbDxicj4NCjxicj4NCjxi
cj4NCjxicj4NCjxicj4NCsKgIMKgIFJlZ2FyZHMsPGJyPg0KwqAgwqAgQXJhdmluZC48YnI+DQo8
YnI+DQrCoCDCoCBPbiBXZWQsIERlYyA5LCAyMDE1IGF0IDEyOjU3IEFNLCBKb25hdGhhbiBSYWpv
dHRlIEp1bGllbjxicj4NCsKgIMKgICZsdDs8YSBocmVmPSJtYWlsdG86Sm9uYXRoYW4ucmFqb3R0
ZS1qdWxpZW5AZWZmaWNpb3MuY29tIiB0YXJnZXQ9Il9ibGFuayI+Sm9uYXRoYW4ucmFqb3R0ZS1q
dWxpZW5AZWZmaWNpb3MuY29tPC9hPjxicj48L2Rpdj48L2Rpdj48ZGl2PjxkaXY+DQrCoCDCoCAm
bHQ7bWFpbHRvOjxhIGhyZWY9Im1haWx0bzpKb25hdGhhbi5yYWpvdHRlLWp1bGllbkBlZmZpY2lv
cy5jb20iIHRhcmdldD0iX2JsYW5rIj5Kb25hdGhhbi5yYWpvdHRlLWp1bGllbkBlZmZpY2lvcy5j
b208L2E+Jmd0OyZndDsgd3JvdGU6PGJyPg0KPGJyPg0KwqAgwqAgwqAgwqAgSGkgQXJhdmluZCw8
YnI+DQo8YnI+DQrCoCDCoCDCoCDCoCBUaGVyZSBpcyBubyBSRUFETUUgaW4gdGhlIGFyY2hpdmUg
eW91IHNlbnQuPGJyPg0KPGJyPg0KwqAgwqAgwqAgwqAgQ2hlZXJzPGJyPg0KPGJyPg0KwqAgwqAg
wqAgwqAgT24gMjAxNS0xMi0wOCAwNzo1MSBBTSwgQXJhdmluZCBIVCB3cm90ZTo8YnI+DQo8YnI+
DQrCoCDCoCDCoCDCoCDCoCDCoCBIaSw8YnI+DQo8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCBJIGFt
IHRyeWluZyB0byB1cGdyYWRlIGluIHBhcmFsbGVsLCBidXQgdGhpcyBpc3N1ZSBtYXk8YnI+DQrC
oCDCoCDCoCDCoCDCoCDCoCBzdGlsbCBiZSBwcmVzZW50IGFmdGVyIEkgdXBncmFkZSBvciBtYXkg
YmUgdGVtcG9yYXJpbHk8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCBtYXNrZWQuIFNvIEkgbmVlZCB0
byBmaW5kIHRoZSByb290IGNhdXNlIGZvciB0aGlzIGFuZCB0aGVuPGJyPg0KwqAgwqAgwqAgwqAg
wqAgwqAgc2VlIGlmIGl0cyBhdmFpbGFibGUgb24gdGhlIGxhdGVzdCBiZWZvcmUgY29tbWl0dGlu
ZyB0bzxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIHVwZ3JhZGUuPGJyPg0KPGJyPg0KwqAgwqAgwqAg
wqAgwqAgwqAgVGhlcmUgaXMgYW5vdGhlciBpc3N1ZSBpJiMzOTttIGhpdHRpbmcsIHRoZSBsdHRu
ZyBsaXN0IGNvbW1hbmQ8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCBoYW5ncyBhZnRlciBsdHRuZyBk
ZXN0cm95IHNlc3Npb24gd2hlbiBydW5uaW5nIHRoZSBwcm9maWxpbmcuPGJyPg0KPGJyPg0KwqAg
wqAgwqAgwqAgwqAgwqAgSSBmb3VuZCB0aGF0IGNvbnN1bWVyZCA2NCBnb2VzIGludG8gYW4gaW5m
aW5pdGUgbG9vcDxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIHdhaXRpbmcgdG8gZmx1c2ggbWV0YWRh
dGEgaW48YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCBsdHRuZ191c3Rjb25zdW1lcl9yZWN2X21ldGFk
YXRhKCkgOjogd2hpbGU8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCAoY29uc3VtZXJfbWV0YWRhdGFf
Y2FjaGVfZmx1c2hlZChjaGFubmVsLCBvZmZzZXQgKyBsZW4sPGJyPg0KwqAgwqAgwqAgwqAgwqAg
wqAgdGltZXIpKSAuPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgSW4gY29uc3VtZXJfbWV0YWRhdGFf
Y2FjaGUsPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgY2hhbm5lbC0mZ3Q7bWV0YWRhdGFfc3RyZWFt
LSZndDtlbmRwb2ludF9zdGF0dXMgaXM8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCBDT05TVU1FUl9F
TkRQT0lOVF9BQ1RJVkUsPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgbWV0YWRhdGFfc3RyZWFtLSZn
dDt1c3RfbWV0YWRhdGFfcHVzaGVkIGlzIDAgd2l0aCBvZmZzZXQ8YnI+DQrCoCDCoCDCoCDCoCDC
oCDCoCBoYXZpbmcgc29tZSB2YWx1ZS4gVGhpcyBjYWxsIGFsd2F5cyByZXR1cm5zIGEgMSBmcm9t
IHRoZTxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIGxhc3QgZWxzZXt9IGJsb2NrIHJlc3VsdGluZyBp
biBhbiBpbmZpbml0ZSBsb29wLiBVcG9uPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgc2VhcmNoaW5n
IHRoZSBmb3J1bSwgSSBmb3VuZCB0aGUgc2FtZSBpc3N1ZSBiZWluZyByZXBvcnRlZDxicj4NCsKg
IMKgIMKgIMKgIMKgIMKgIGhlcmUgOjxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIDxhIGhyZWY9Imh0
dHBzOi8vd3d3Lm1haWwtYXJjaGl2ZS5jb20vbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZy9tc2cw
Nzk4Mi5odG1sIiByZWw9Im5vcmVmZXJyZXIiIHRhcmdldD0iX2JsYW5rIj5odHRwczovL3d3dy5t
YWlsLWFyY2hpdmUuY29tL2x0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcvbXNnMDc5ODIuaHRtbDwv
YT48YnI+DQo8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCBSZWdhcmRzLDxicj4NCsKgIMKgIMKgIMKg
IMKgIMKgIEFyYXZpbmQuPGJyPg0KPGJyPg0KPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgT24gVHVl
LCBEZWMgOCwgMjAxNSBhdCAxMjo0MyBBTSwgSm9uYXRoYW4gUmFqb3R0ZTxicj4NCsKgIMKgIMKg
IMKgIMKgIMKgICZsdDs8YSBocmVmPSJtYWlsdG86am9uYXRoYW4uci5qdWxpZW5AZ21haWwuY29t
IiB0YXJnZXQ9Il9ibGFuayI+am9uYXRoYW4uci5qdWxpZW5AZ21haWwuY29tPC9hPjxicj48L2Rp
dj48L2Rpdj48c3Bhbj4NCsKgIMKgIMKgIMKgIMKgIMKgICZsdDttYWlsdG86PGEgaHJlZj0ibWFp
bHRvOmpvbmF0aGFuLnIuanVsaWVuQGdtYWlsLmNvbSIgdGFyZ2V0PSJfYmxhbmsiPmpvbmF0aGFu
LnIuanVsaWVuQGdtYWlsLmNvbTwvYT4mZ3Q7Jmd0OyB3cm90ZTo8YnI+DQo8YnI+DQrCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCBIaSBBcmF2aW5kLDxicj4NCjxicj4NCsKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIERpZCB5b3UgaGF2ZSB0aGUgY2hhbmNlIHRvIHVwZ3JhZGUgdG8gMi42LjEuSWYgc288
YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCB3aGVyZSB5b3UgYWJsZTxicj4NCsKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIHRvIHJlcHJvZHVjZT88YnI+DQo8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCBDaGVlcnM8YnI+DQo8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBPbiBNb24sIERlYyA3
LCAyMDE1IGF0IDE6MDcgUE0sIEFyYXZpbmQgSFQ8YnI+PC9zcGFuPg0KwqAgwqAgwqAgwqAgwqAg
wqAgJmx0OzxhIGhyZWY9Im1haWx0bzphcmF2aW5kLmh0QGdtYWlsLmNvbSIgdGFyZ2V0PSJfYmxh
bmsiPmFyYXZpbmQuaHRAZ21haWwuY29tPC9hPiAmbHQ7bWFpbHRvOjxhIGhyZWY9Im1haWx0bzph
cmF2aW5kLmh0QGdtYWlsLmNvbSIgdGFyZ2V0PSJfYmxhbmsiPmFyYXZpbmQuaHRAZ21haWwuY29t
PC9hPiZndDsmZ3Q7PHNwYW4+PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgd3JvdGU6PGJy
Pg0KPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgSGksPGJyPg0KPGJyPg0KwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgSSBoYXZlIGF0dGFjaGVkIHRoZSBjb21wbGV0ZSBw
cm9maWxpbmcgc2NyaXB0czxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIGhlcmUsIGl0cyBhIGJpdDxi
cj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHNoYWJieSwgaW0gbmV3IHRvIHB5dGhv
bi48YnI+DQo8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBUaGVyZSBpcyBhIFJF
QURNRSB3aGljaCBoYXMgdGhlIGRldGFpbHMgb24gaG93IHRvPGJyPg0KwqAgwqAgwqAgwqAgwqAg
wqAgZXhlY3V0ZSBpdC48YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBJbSB1c2lu
ZyBhIFlvY3RvIDEuNiBvbiB4ODZfNjQgcGxhdGZvcm1zIG9uIGJvdGg8YnI+DQrCoCDCoCDCoCDC
oCDCoCDCoCB0aGUgbm9kZXMuPGJyPg0KPGJyPg0KPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgUnVubmluZyB0aGlzIHNjcmlwdCB3aGVuIHRoZXJlIGFyZSBvdGhlciBzZXNzaW9u
czxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIHJ1bm5pbmc8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCBzZWVtcyB0byByZXByb2R1Y2UgdGhpcyBwcm9ibGVtIGVhc2lseS48YnI+DQrC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBQbGVhc2UgdHJ5IGl0IGFuZCBsZXQgbWUga25v
dyBpZiB5b3UgaGF2ZSBhbnkgaXNzdWVzPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgcmVwcm9kdWNpbmcgdGhlIHByb2JsZW0uPGJyPg0KPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgUmVnYXJkcyw8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBB
cmF2aW5kLjxicj4NCjxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIE9uIFNhdCwg
RGVjIDUsIDIwMTUgYXQgNToyMyBQTSwgSsOpcsOpbWllIEdhbGFybmVhdTxicj4NCsKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgICZsdDs8YSBocmVmPSJtYWlsdG86amVyZW1pZS5nYWxhcm5l
YXVAZWZmaWNpb3MuY29tIiB0YXJnZXQ9Il9ibGFuayI+amVyZW1pZS5nYWxhcm5lYXVAZWZmaWNp
b3MuY29tPC9hPjxicj4NCsKgIMKgIMKgIMKgIMKgIMKgICZsdDttYWlsdG86PGEgaHJlZj0ibWFp
bHRvOmplcmVtaWUuZ2FsYXJuZWF1QGVmZmljaW9zLmNvbSIgdGFyZ2V0PSJfYmxhbmsiPmplcmVt
aWUuZ2FsYXJuZWF1QGVmZmljaW9zLmNvbTwvYT4mZ3Q7PGJyPjwvc3Bhbj4NCsKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgICZsdDttYWlsdG86PGEgaHJlZj0ibWFpbHRvOmplcmVtaWUuZ2Fs
YXJuZWF1QGVmZmljaW9zLmNvbSIgdGFyZ2V0PSJfYmxhbmsiPmplcmVtaWUuZ2FsYXJuZWF1QGVm
ZmljaW9zLmNvbTwvYT48c3Bhbj48YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCAmbHQ7bWFpbHRvOjxh
IGhyZWY9Im1haWx0bzpqZXJlbWllLmdhbGFybmVhdUBlZmZpY2lvcy5jb20iIHRhcmdldD0iX2Js
YW5rIj5qZXJlbWllLmdhbGFybmVhdUBlZmZpY2lvcy5jb208L2E+Jmd0OyZndDsmZ3Q7IHdyb3Rl
Ojxicj4NCjxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIE9uIEZyaSwg
RGVjIDQsIDIwMTUgYXQgMTE6MDYgUE0sIEFyYXZpbmQgSFQ8YnI+DQrCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCAmbHQ7PGEgaHJlZj0ibWFpbHRvOmFyYXZpbmQuaHRAZ21haWwu
Y29tIiB0YXJnZXQ9Il9ibGFuayI+YXJhdmluZC5odEBnbWFpbC5jb208L2E+PGJyPjwvc3Bhbj4N
CsKgIMKgIMKgIMKgIMKgIMKgICZsdDttYWlsdG86PGEgaHJlZj0ibWFpbHRvOmFyYXZpbmQuaHRA
Z21haWwuY29tIiB0YXJnZXQ9Il9ibGFuayI+YXJhdmluZC5odEBnbWFpbC5jb208L2E+Jmd0OyAm
bHQ7bWFpbHRvOjxhIGhyZWY9Im1haWx0bzphcmF2aW5kLmh0QGdtYWlsLmNvbSIgdGFyZ2V0PSJf
YmxhbmsiPmFyYXZpbmQuaHRAZ21haWwuY29tPC9hPjxkaXY+PGRpdj48YnI+DQrCoCDCoCDCoCDC
oCDCoCDCoCAmbHQ7bWFpbHRvOjxhIGhyZWY9Im1haWx0bzphcmF2aW5kLmh0QGdtYWlsLmNvbSIg
dGFyZ2V0PSJfYmxhbmsiPmFyYXZpbmQuaHRAZ21haWwuY29tPC9hPiZndDsmZ3Q7Jmd0OyB3cm90
ZTo8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAmZ3Q7IEkgYW0gdXNp
bmcgMi42LjAgLkkgd2lsbCB0cnkgdG8gc2hhcmUgdGhlPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAg
Y29kZSB0aGF0IEkmIzM5O208YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCB1c2luZyBoZXJlIGluIHNvbWU8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCAmZ3Q7IHRpbWUuIElmIHRoZXJlIGFyZSBhbnkgc3BlY2lmaWMgZml4ZXMgdGhhdDxicj4N
CsKgIMKgIMKgIMKgIMKgIMKgIGFyZSByZWxldmFudDxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIHRvIHRoaXMgaXNzdWUsIHNlZTxicj4NCsKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgICZndDsgaWYgeW91IGNhbiBwcm92aWRlIGEgbGluayB0byB0aGVt
LiBJIHdvdWxkPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgaWRlYWxseSBsaWtlPGJyPg0KwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgdG8gdHJ5IHRoZW0gb3V0PGJyPg0KwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgJmd0OyBiZWZvcmUgdHJ5aW5nIGEgZnVsbCB1
cGdyYWRlIHRvIHRoZSBsYXRlc3Q8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCB2ZXJzaW9ucy48YnI+
DQo8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBIaSw8YnI+DQo8YnI+
DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBDYW4geW91IHByb3ZpZGUgbW9y
ZSBpbmZvcm1hdGlvbiBvbiB0aGU8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCBzeXN0ZW0/IFdoaWNo
PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgZGlzdHJpYnV0aW9uLDxi
cj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGFyY2hpdGVjdHVyZSwga2Vy
bmVsIHZlcnNpb24/PGJyPg0KPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgVGhlIHZlcmJvc2Ugc2Vzc2lvbmQgbG9ncyBtaWdodCBoZWxwIHBpbnBvaW50IGFueTxicj4N
CsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHVuZXhwZWN0ZWQgYmVoYXZpb3Vy
PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgaGVyZSAoYXJlIGFsbCBh
cHBsaWNhdGlvbnMgcmVnaXN0ZXJpbmcgYXM8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCBleHBlY3Rl
ZD8pLjxicj4NCjxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIErDqXLD
qW1pZTxicj4NCjxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgICZndDs8
YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAmZ3Q7IE9uIEZyaSwgRGVj
IDQsIDIwMTUgYXQgNjoxMSBQTSwgSsOpcsOpbWllPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgR2Fs
YXJuZWF1PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgJmd0OyAmbHQ7
PGEgaHJlZj0ibWFpbHRvOmplcmVtaWUuZ2FsYXJuZWF1QGVmZmljaW9zLmNvbSIgdGFyZ2V0PSJf
YmxhbmsiPmplcmVtaWUuZ2FsYXJuZWF1QGVmZmljaW9zLmNvbTwvYT48YnI+DQrCoCDCoCDCoCDC
oCDCoCDCoCAmbHQ7bWFpbHRvOjxhIGhyZWY9Im1haWx0bzpqZXJlbWllLmdhbGFybmVhdUBlZmZp
Y2lvcy5jb20iIHRhcmdldD0iX2JsYW5rIj5qZXJlbWllLmdhbGFybmVhdUBlZmZpY2lvcy5jb208
L2E+Jmd0Ozxicj48L2Rpdj48L2Rpdj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgICZsdDttYWlsdG86PGEgaHJlZj0ibWFpbHRvOmplcmVtaWUuZ2FsYXJuZWF1QGVmZmljaW9z
LmNvbSIgdGFyZ2V0PSJfYmxhbmsiPmplcmVtaWUuZ2FsYXJuZWF1QGVmZmljaW9zLmNvbTwvYT48
c3Bhbj48YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCAmbHQ7bWFpbHRvOjxhIGhyZWY9Im1haWx0bzpq
ZXJlbWllLmdhbGFybmVhdUBlZmZpY2lvcy5jb20iIHRhcmdldD0iX2JsYW5rIj5qZXJlbWllLmdh
bGFybmVhdUBlZmZpY2lvcy5jb208L2E+Jmd0OyZndDsmZ3Q7IHdyb3RlOjxicj4NCsKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgICZndDsmZ3Q7PGJyPg0KwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgJmd0OyZndDsgSGkgQXJhdmluZCw8YnI+DQrCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAmZ3Q7Jmd0Ozxicj4NCsKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgICZndDsmZ3Q7IENhbiYjMzk7dCBzYXkgSSBoYXZlIGxvb2tlZCBh
dCBldmVyeXRoaW5nIHlvdTxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIHNlbnQgeWV0LCBidXQ8YnI+
DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBhcyBhPGJyPg0KwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgJmd0OyZndDsgcHJlZW1wdGl2ZSBxdWVzdGlvbiwg
d2hpY2ggdmVyc2lvbiBhcmUgd2U8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCB0YWxraW5nIGFib3V0
PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgaGVyZT8gMi42LjAgb3I8
YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAmZ3Q7Jmd0OyAyLjYuMT8g
Mi42LjEgY29udGFpbnMgYSBsb3Qgb2YgcmVsYXkgZGFlbW9uPGJyPg0KwqAgwqAgwqAgwqAgwqAg
wqAgZml4ZXMuPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgJmd0OyZn
dDs8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAmZ3Q7Jmd0OyBUaGFu
a3MsPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgJmd0OyZndDsgSsOp
csOpbWllPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgJmd0OyZndDs8
YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAmZ3Q7Jmd0OyBPbiBUaHUs
IERlYyAzLCAyMDE1IGF0IDc6MDEgQU0sIEFyYXZpbmQgSFQ8YnI+DQrCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCAmbHQ7PGEgaHJlZj0ibWFpbHRvOmFyYXZpbmQuaHRAZ21haWwu
Y29tIiB0YXJnZXQ9Il9ibGFuayI+YXJhdmluZC5odEBnbWFpbC5jb208L2E+PGJyPjwvc3Bhbj48
ZGl2PjxkaXY+DQrCoCDCoCDCoCDCoCDCoCDCoCAmbHQ7bWFpbHRvOjxhIGhyZWY9Im1haWx0bzph
cmF2aW5kLmh0QGdtYWlsLmNvbSIgdGFyZ2V0PSJfYmxhbmsiPmFyYXZpbmQuaHRAZ21haWwuY29t
PC9hPiZndDsmZ3Q7IHdyb3RlOjxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgICZndDsmZ3Q7ICZndDsgSGksPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgJmd0OyZndDsgJmd0Ozxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgICZndDsmZ3Q7ICZndDsgSSBhbSB0cnlpbmcgdG8gb2J0YWluIHRoZSBwZXJmb3JtYW5jZTxi
cj4NCsKgIMKgIMKgIMKgIMKgIMKgIGNoYXJhY3RlcmlzdGljczxicj4NCsKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIG9mIGx0dG5nIHdpdGggdGhlPGJyPg0KwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgJmd0OyZndDsgJmd0OyB1c2U8YnI+DQrCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAmZ3Q7Jmd0OyAmZ3Q7IG9mIHRlc3QgYXBwbGljYXRp
b25zLiBUcmFjZXMgYXJlIGJlaW5nPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgcHJvZHVjZWQgb24g
YTxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGxvY2FsIG5vZGUgYW5k
PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgJmd0OyZndDsgJmd0OyBk
ZWxpdmVyZWQgdG8gcmVsYXlkIHRoYXQgaXMgcnVubmluZyBvbiBhPGJyPg0KwqAgwqAgwqAgwqAg
wqAgwqAgc2VwYXJhdGU8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBu
b2RlIGZvciBzdG9yYWdlLjxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
ICZndDsmZ3Q7ICZndDs8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAm
Z3Q7Jmd0OyAmZ3Q7IEFuIGx0dG5nIHNlc3Npb24gd2l0aCB0aGUgdGVzdDxicj4NCsKgIMKgIMKg
IMKgIMKgIMKgIGFwcGxpY2F0aW9ucyBwcm9kdWNpbmc8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCBhbiBpbml0aWFsIGJpdDxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgICZndDsmZ3Q7ICZndDsgcmF0ZSBvZjxicj4NCsKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgICZndDsmZ3Q7ICZndDsgMTAga2IvcyBpcyBzdGFydGVkIGFu
ZCBydW4gZm9yIGFib3V0IDMwPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgc2Vjb25kcy4gVGhlPGJy
Pg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgc3RhcnRpbmcgc3ViLWJ1ZmZl
cjxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgICZndDsmZ3Q7ICZndDsg
c2l6ZSBpcyBrZXB0IGF0IDEyOCBrYiBhbmQgc3ViLWJ1ZiBjb3VudDxicj4NCsKgIMKgIMKgIMKg
IMKgIMKgIGF0IDQuIFRoZTxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IHNlc3Npb24gaXMgdGhlbjxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
ICZndDsmZ3Q7ICZndDsgc3RvcHBlZDxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgICZndDsmZ3Q7ICZndDsgYW5kIGRlc3Ryb3llZCBhbmQgdHJhY2VzIGFyZSBhbmFseXpl
ZCB0bzxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIHNlZSBpZiB0aGVyZTxicj4NCsKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGFyZSBhbnkgZHJvcHMuPGJyPg0KwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgJmd0OyZndDsgJmd0OyBUaGlzIGlzPGJyPg0KwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgJmd0OyZndDsgJmd0OyBiZWluZyBkb25lIGlu
IGEgbG9vcCB3aXRoIGV2ZXJ5PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgc3Vic2VxdWVudCBzZXNz
aW9uPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgaGF2aW5nIGFuIGlu
Y3JlbWVudDxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgICZndDsmZ3Q7
ICZndDsgb2YgMjxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgICZndDsm
Z3Q7ICZndDsga2IvcyBhcyBsb25nIGFzIHRoZXJlIGFyZSBubyBkcm9wcy4gSWY8YnI+DQrCoCDC
oCDCoCDCoCDCoCDCoCB0aGVyZSBhcmU8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCBkcm9wcywgSSBpbmNyZWFzZSB0aGU8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCAmZ3Q7Jmd0OyAmZ3Q7IGJ1ZmZlciBzaXplIGJ5IGEgZmFjdG9yIG9mIHgy
IHdpdGhvdXQ8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCBpbmNyZW1lbnRpbmc8YnI+DQrCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB0aGUgYml0IHJhdGUuPGJyPg0KwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgJmd0OyZndDsgJmd0Ozxicj4NCsKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgICZndDsmZ3Q7ICZndDsgSSBzZWUgdHJhY2UgZHJvcHMg
aGFwcGVuaW5nIGNvbnNpc3RlbnRseTxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIHdpdGggdGVzdDxi
cj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGFwcHMgcHJvZHVjaW5nIHRy
YWNlczxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgICZndDsmZ3Q7ICZn
dDsgYXQ8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAmZ3Q7Jmd0OyAm
Z3Q7IGxlc3MgdGhhbiA0MCBrYi9zLCBpdCBkb2VzbnQgc2VlbSB0byBoZWxwPGJyPg0KwqAgwqAg
wqAgwqAgwqAgwqAgZXZlbiBpZiBJPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgc3RhcnRlZCB3aXRoIDFtYiB4IDQ8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCAmZ3Q7Jmd0OyAmZ3Q7IHN1Yi1idWZmZXJzLjxicj4NCsKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgICZndDsmZ3Q7ICZndDs8YnI+DQrCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCAmZ3Q7Jmd0OyAmZ3Q7IEFuYWx5c2lzIDo8YnI+DQrCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAmZ3Q7Jmd0OyAmZ3Q7PGJyPg0KwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgJmd0OyZndDsgJmd0OyBJIGhhdmUgYXR0YWNoZWQg
dGhlIGx0dG5nX3JlbGF5ZCAsPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgbHR0bmdfY29uc3VtZXJk
XzY0PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgbG9ncyBhbmQgdGhl
PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgJmd0OyZndDsgJmd0OyBl
bnRpcmU8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAmZ3Q7Jmd0OyAm
Z3Q7IHRyYWNlIGRpcmVjdG9yeSwgaG9wZSB5b3Ugd2lsbCBiZSBhYmxlIHRvPGJyPg0KwqAgwqAg
wqAgwqAgwqAgwqAgdmlldyBpdC48YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCAmZ3Q7Jmd0OyAmZ3Q7IEkgaGF2ZSBtb2RpZmllZCBsdHRuZ19yZWxheWQgY29kZSB0byBk
dW1wPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgdGhlIHRyYWNlczxicj4NCsKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIGJlaW5nIGNhcHR1cmVkIGluPGJyPg0KwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgJmd0OyZndDsgJmd0OyB0aGU8YnI+DQrCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAmZ3Q7Jmd0OyAmZ3Q7IGx0dG5nX3JlbGF5ZCBsb2dz
IGFsb25nIHdpdGggZGVidWcgaW5mby48YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCAmZ3Q7Jmd0OyAmZ3Q7PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgJmd0OyZndDsgJmd0OyBFYWNoIHRlc3QgYXBwIGlzIHByb2R1Y2luZyBsb2dzIGluIHRo
ZTxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIGZvcm0gb2bCoCA6PGJyPg0KwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgJmd0OyZndDsgJmd0OyAmcXVvdDtUcmFjZUFwcCBQSUQgLSAz
MTk0MCBUSElEIC0gMzE5NzA8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCBAdGhyZWFkUmF0ZSAtIDEw
MzI8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBiL3MgYXBwUmF0ZSAt
IDIwNzk8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAmZ3Q7Jmd0OyAm
Z3Q7IGIvczxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgICZndDsmZ3Q7
ICZndDsgdGhyZWFkVHJhY2VOdW0gLSA5IGFwcFRyYWNlTnVtIC0gMTjCoCDCoCDCoCDCoCDCoCDC
oCDCoHNsZWVwVGltZSAtIDE5MjEyMCZxdW90Ozxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgICZndDsmZ3Q7ICZndDs8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCAmZ3Q7Jmd0OyAmZ3Q7IFRoZSB0ZXN0IGFwcGxpY2F0aW9uIFBJRCwgdGVzdDxi
cj4NCsKgIMKgIMKgIMKgIMKgIMKgIGFwcGxpY2F0aW9uIHRocmVhZCBpZCw8YnI+DQrCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB0aHJlYWQgYml0IHJhdGUsPGJyPg0KwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgJmd0OyZndDsgJmd0OyB0ZXN0PGJyPg0KwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgJmd0OyZndDsgJmd0OyBhcHAgYml0IHJh
dGUsIHRocmVhZCB0cmFjZSBudW1iZXIgYW5kPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgYXBwbGlj
YXRpb248YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB0cmFjZSBudW1i
ZXIgcyBhcmU8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAmZ3Q7Jmd0
OyAmZ3Q7IHBhcnQgb2Y8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAm
Z3Q7Jmd0OyAmZ3Q7IHRoZSB0cmFjZS4gU28gaW4gdGhlIGFib3ZlIHRyYWNlLCB0aGU8YnI+DQrC
oCDCoCDCoCDCoCDCoCDCoCB0aHJlYWQgaXM8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCBwcm9kdWNpbmcgYXQgMSBrYi9zIGFuZDxicj4NCsKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgICZndDsmZ3Q7ICZndDsgdGhlPGJyPg0KwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgJmd0OyZndDsgJmd0OyB3aG9sZSB0ZXN0IGFwcCBpcyBwcm9k
dWNpbmcgYXQgMiBrYi9zLjxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
ICZndDsmZ3Q7ICZndDs8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAm
Z3Q7Jmd0OyAmZ3Q7IElmIHdlIGxvb2sgYXQgdGhlIGJhYmVsdHJhY2Ugb3V0IHB1dCwgd2U8YnI+
DQrCoCDCoCDCoCDCoCDCoCDCoCBzZWUgdGhhdCB0aGU8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCBUcmFjZSB3aXRoPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgJmd0OyZndDsgJmd0OyBUcmFjZUFwcDxicj4NCsKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgICZndDsmZ3Q7ICZndDsgUElEIC0gMzE5NDAgYXBwVHJhY2VOdW0g
MiBpcyBtaXNzaW5nICw8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCB3aXRoIDEsIDMsIDQsPGJyPg0K
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgNSBhbmQgc28gb24gYmVpbmc8YnI+
DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAmZ3Q7Jmd0OyAmZ3Q7IHN1Y2Nl
c3NmdWxseSBjYXB0dXJlZC48YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCAmZ3Q7Jmd0OyAmZ3Q7IEkgbG9va2VkIGF0IHRoZSBsdHRuZ19yZWxheWQgbG9ncyBhbmQ8YnI+
DQrCoCDCoCDCoCDCoCDCoCDCoCBmb3VuZCB0aGF0PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgdHJhY2Ugb2YgJnF1b3Q7YXBwVHJhY2VOdW08YnI+DQrCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAmZ3Q7Jmd0OyAmZ3Q7IDImcXVvdDsgaXM8YnI+DQrC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAmZ3Q7Jmd0OyAmZ3Q7IG5vdCBkZWxp
dmVyZWQvZ2VuZXJhdGVkIGJ5IHRoZSBjb25zdW1lcmQ8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCB0
byB0aGU8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCByZWxheWQgaW4g
c2VxdWVuY2Ugd2l0aDxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgICZn
dDsmZ3Q7ICZndDsgb3RoZXIgdHJhY2VzLiBUbyBydWxlIG91dCB0aGF0IHRoaXMgaXM8YnI+DQrC
oCDCoCDCoCDCoCDCoCDCoCBub3QgYSB0ZXN0PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgYXBwbGljYXRpb24gcHJvYmxlbSw8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCAmZ3Q7Jmd0OyAmZ3Q7IHlvdTxicj4NCsKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgICZndDsmZ3Q7ICZndDsgY2FuIGxvb2sgYXQgbGluZSBsdHR0bmdf
cmVsYXlkIGxvZyA6PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgMTI3NzggYW5kIHNlZTxicj4NCsKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHRyYWNlcyBmcm9tPGJyPg0KwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgJmd0OyZndDsgJmd0OyBhcHBUcmFjZU51bSAt
PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgJmd0OyZndDsgJmd0OyAx
IHRvIGFwcFRyYWNlTnVtIC0gMTggaW5jbHVkaW5nIHRoZTxicj4NCsKgIMKgIMKgIMKgIMKgIMKg
IGFwcFRyYWNlTnVtIDIgYXJlPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgJnF1b3Q7cmUtZGVsaXZlcmVkJnF1b3Q7IGJ5PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgJmd0OyZndDsgJmd0OyB0aGU8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCAmZ3Q7Jmd0OyAmZ3Q7IGNvbnN1bWVyZCB0byB0aGUgcmVsYXlkLjxi
cj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgICZndDsmZ3Q7ICZndDsgRXNz
ZW50aWFsbHksIEkgc2VlIGFwcFRyYWNlTnVtIDEgdGhyb3VnaDxicj4NCsKgIMKgIMKgIMKgIMKg
IMKgIGFwcFRyYWNlTnVtPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
MTggYmVpbmcgZGVsaXZlcmVkPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgJmd0OyZndDsgJmd0OyB0d2ljZSwgb25jZSBpbmRpdmlkdWFsbHkgd2hlcmU8YnI+DQrCoCDC
oCDCoCDCoCDCoCDCoCBhcHBUcmFjZU51bSAyIGlzPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgbWlzc2luZyBhbmQgb25jZSBhcyBhPGJyPg0KwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgJmd0OyZndDsgJmd0OyBncm91cDxicj4NCsKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgICZndDsmZ3Q7ICZndDsgYXQgbGluZSAxMjc3OCB3aGVy
ZSBpdHMgcHJlc2VudC48YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAm
Z3Q7Jmd0OyAmZ3Q7PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgJmd0
OyZndDsgJmd0Ozxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgICZndDsm
Z3Q7ICZndDsgUmVxdWVzdCBoZWxwIHdpdGg8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCAmZ3Q7Jmd0OyAmZ3Q7IDEuIHdoeSB0cmFjZXMgYXJlIGRlbGl2ZXJlZCB0d2lj
ZSwgaXMgaXQ8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCBieSBkZXNpZ24gb3I8YnI+DQrCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBhIGdlbnVpbmUgcHJvYmxlbTxicj4NCsKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgICZndDsmZ3Q7ICZndDsgPzxicj4NCsKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgICZndDsmZ3Q7ICZndDsgMi4gaG93IHRvIGF2
b2lkIHRyYWNlcyBiZWluZyBkcm9wcGVkIGV2ZW48YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCB0aG91
Z2g8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBidWZmZXJzIGFyZTxi
cj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgICZndDsmZ3Q7ICZndDsgc3Vm
ZmljaWVudGx5PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgJmd0OyZn
dDsgJmd0OyBsYXJnZSBlbm91Z2ggPzxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgICZndDsmZ3Q7ICZndDs8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCAmZ3Q7Jmd0OyAmZ3Q7PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgJmd0OyZndDsgJmd0OyBSZWdhcmRzLDxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgICZndDsmZ3Q7ICZndDsgQXJhdmluZC48YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCAmZ3Q7Jmd0OyAmZ3Q7PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgJmd0OyZndDsgJmd0Ozxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIF9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fPGJyPg0KwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgJmd0OyZndDsgJmd0OyBsdHRuZy1kZXYgbWFpbGlu
ZyBsaXN0PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgJmd0OyZndDsg
Jmd0OyA8YSBocmVmPSJtYWlsdG86bHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZyIgdGFyZ2V0PSJf
YmxhbmsiPmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmc8L2E+PGJyPjwvZGl2PjwvZGl2PjxzcGFu
Pg0KwqAgwqAgwqAgwqAgwqAgwqAgJmx0O21haWx0bzo8YSBocmVmPSJtYWlsdG86bHR0bmctZGV2
QGxpc3RzLmx0dG5nLm9yZyIgdGFyZ2V0PSJfYmxhbmsiPmx0dG5nLWRldkBsaXN0cy5sdHRuZy5v
cmc8L2E+Jmd0Ozxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgICZndDsm
Z3Q7ICZndDs8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCA8YSBocmVmPSJodHRwOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYiIHJlbD0ibm9yZWZlcnJl
ciIgdGFyZ2V0PSJfYmxhbmsiPmh0dHA6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFu
L2xpc3RpbmZvL2x0dG5nLWRldjwvYT48YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCAmZ3Q7Jmd0OyAmZ3Q7PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgJmd0OyZndDs8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAm
Z3Q7Jmd0Ozxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgICZndDsmZ3Q7
PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgJmd0OyZndDsgLS08YnI+
DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAmZ3Q7Jmd0OyBKw6lyw6ltaWUg
R2FsYXJuZWF1PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgJmd0OyZn
dDsgRWZmaWNpT1MgSW5jLjxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
ICZndDsmZ3Q7IDxhIGhyZWY9Imh0dHA6Ly93d3cuZWZmaWNpb3MuY29tIiByZWw9Im5vcmVmZXJy
ZXIiIHRhcmdldD0iX2JsYW5rIj5odHRwOi8vd3d3LmVmZmljaW9zLmNvbTwvYT48YnI+DQrCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAmZ3Q7PGJyPg0KwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgJmd0Ozxicj4NCjxicj4NCjxicj4NCjxicj4NCsKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIC0tPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgSsOpcsOpbWllIEdhbGFybmVhdTxicj4NCsKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIEVmZmljaU9TIEluYy48YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCA8
YSBocmVmPSJodHRwOi8vd3d3LmVmZmljaW9zLmNvbSIgcmVsPSJub3JlZmVycmVyIiB0YXJnZXQ9
Il9ibGFuayI+aHR0cDovL3d3dy5lZmZpY2lvcy5jb208L2E+PGJyPg0KPGJyPg0KPGJyPg0KPGJy
Pg0KwqAgwqAgwqAgwqAgwqAgwqAgX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX188YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBsdHRuZy1kZXYg
bWFpbGluZyBsaXN0PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgPGEgaHJlZj0ibWFpbHRvOmx0dG5n
LWRldkBsaXN0cy5sdHRuZy5vcmciIHRhcmdldD0iX2JsYW5rIj5sdHRuZy1kZXZAbGlzdHMubHR0
bmcub3JnPC9hPjxicj4NCsKgIMKgIMKgIMKgIMKgIMKgICZsdDttYWlsdG86PGEgaHJlZj0ibWFp
bHRvOmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmciIHRhcmdldD0iX2JsYW5rIj5sdHRuZy1kZXZA
bGlzdHMubHR0bmcub3JnPC9hPiZndDs8YnI+PC9zcGFuPg0KwqAgwqAgwqAgwqAgwqAgwqAgJmx0
O21haWx0bzo8YSBocmVmPSJtYWlsdG86bHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZyIgdGFyZ2V0
PSJfYmxhbmsiPmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmc8L2E+PHNwYW4+PGJyPg0KwqAgwqAg
wqAgwqAgwqAgwqAgJmx0O21haWx0bzo8YSBocmVmPSJtYWlsdG86bHR0bmctZGV2QGxpc3RzLmx0
dG5nLm9yZyIgdGFyZ2V0PSJfYmxhbmsiPmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmc8L2E+Jmd0
OyZndDs8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCA8YSBocmVmPSJodHRwOi8vbGlzdHMubHR0bmcu
b3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYiIHJlbD0ibm9yZWZlcnJlciIg
dGFyZ2V0PSJfYmxhbmsiPmh0dHA6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xp
c3RpbmZvL2x0dG5nLWRldjwvYT48YnI+DQo8YnI+DQo8YnI+DQo8YnI+DQo8YnI+DQrCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCAtLcKgIMKgIMKgSm9uYXRoYW4gUmFqb3R0ZSBKdWxpZW48YnI+DQo8
YnI+DQo8YnI+DQo8YnI+DQo8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCBfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXzxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIGx0
dG5nLWRldiBtYWlsaW5nIGxpc3Q8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCA8YSBocmVmPSJtYWls
dG86bHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZyIgdGFyZ2V0PSJfYmxhbmsiPmx0dG5nLWRldkBs
aXN0cy5sdHRuZy5vcmc8L2E+ICZsdDttYWlsdG86PGEgaHJlZj0ibWFpbHRvOmx0dG5nLWRldkBs
aXN0cy5sdHRuZy5vcmciIHRhcmdldD0iX2JsYW5rIj5sdHRuZy1kZXZAbGlzdHMubHR0bmcub3Jn
PC9hPiZndDs8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCA8YSBocmVmPSJodHRwOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYiIHJlbD0ibm9yZWZlcnJl
ciIgdGFyZ2V0PSJfYmxhbmsiPmh0dHA6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFu
L2xpc3RpbmZvL2x0dG5nLWRldjwvYT48YnI+DQo8YnI+DQo8YnI+PC9zcGFuPg0KwqAgwqAgwqAg
wqAgLS3CoCDCoCDCoCDCoCDCoEpvbmF0aGFuIFIuIEp1bGllbjxicj4NCsKgIMKgIMKgIMKgIEVm
ZmljaW9zPGJyPg0KPGJyPg0KPGJyPg0KPGJyPg0KPC9ibG9ja3F1b3RlPjxkaXY+PGRpdj4NCjxi
cj4NCi0tIDxicj4NCkpvbmF0aGFuIFIuIEp1bGllbjxicj4NCkVmZmljaW9zPGJyPg0KPGJyPg0K
PC9kaXY+PC9kaXY+PC9ibG9ja3F1b3RlPjwvZGl2Pjxicj48L2Rpdj48L2Rpdj48L2Rpdj4NCjxi
cj5fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXzxicj5sdHRu
Zy1kZXYgbWFpbGluZyBsaXN0PGJyPjxhIGhyZWY9Im1haWx0bzpsdHRuZy1kZXZAbGlzdHMubHR0
bmcub3JnIiB0YXJnZXQ9Il9ibGFuayI+bHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZzwvYT48YnI+
PC9kaXY+PC9kaXY+PGEgaHJlZj0iaHR0cDovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxt
YW4vbGlzdGluZm8vbHR0bmctZGV2IiB0YXJnZXQ9Il9ibGFuayI+aHR0cDovL2xpc3RzLmx0dG5n
Lm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2PC9hPjxzcGFuIGNsYXNzPSJI
T0VuWmIiPjxmb250IGNvbG9yPSIjODg4ODg4Ij48YnI+PC9mb250Pjwvc3Bhbj48L2Jsb2NrcXVv
dGU+PC9kaXY+PHNwYW4gY2xhc3M9IkhPRW5aYiI+PGZvbnQgY29sb3I9IiM4ODg4ODgiPjxkaXY+
PGJyPjwvZGl2PjxkaXY+LS0gPGJyPjwvZGl2PjxkaXY+TWF0aGlldSBEZXNub3llcnM8YnI+RWZm
aWNpT1MgSW5jLjxicj48YSBocmVmPSJodHRwOi8vd3d3LmVmZmljaW9zLmNvbSIgdGFyZ2V0PSJf
YmxhbmsiPmh0dHA6Ly93d3cuZWZmaWNpb3MuY29tPC9hPjwvZGl2PjwvZm9udD48L3NwYW4+PC9k
aXY+PC9kaXY+PC9ibG9ja3F1b3RlPjwvZGl2Pjxicj48L2Rpdj4NCg==
--001a114020a28779ac052703842f--


--===============0838942707==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0838942707==--
