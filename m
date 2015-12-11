From: Aravind HT <aravind.ht@gmail.com>
Subject: Re: Relayd trace drops
Date: Sat, 12 Dec 2015 00:12:36 +0530
Message-ID: <CACd+_b6za+gk_fFhFapz-zRpwO8B31UX6+hMJxcjJsxrKVM5ow__37947.636753279$1449859455$gmane$org@mail.gmail.com>
References: <CACd+_b7qEeW1XD1H_0MT4dDqwLv68rfOURfNDRh6SO=xS4k-Og@mail.gmail.com>
 <CA+jJMxsuF+Ywvvhe3L4OqBHTsohyFffPoF4mZWFDqPvBC-P80w@mail.gmail.com>
 <CACd+_b5AGJKWH58Kq3QP8qW8R7Q9JH3fqbEwU=z8pyg5-DL=KQ@mail.gmail.com>
 <CA+jJMxsJReP4ZO2bSJP-rJe+UoJzT09Pix1LhEypbsww_nwrsA@mail.gmail.com>
 <CACd+_b7ScRDo9uL+neOnA2pqVVwexsPsbBd2mBS--yy7Amxbmg@mail.gmail.com>
 <CAF4oYfF2Li4zau0OLE=JZUtGfPZyFT1FciBr7AG1hvzGdeUycA@mail.gmail.com>
 <CACd+_b6byMnZ_oWBqEk44fJOgpVX-oAGMjfh_WV8AV6cKyK9iw@mail.gmail.com>
 <56672F33.3070808@efficios.com>
 <CACd+_b6xjN8BEcfqypkhGrM2XWwxhW9RmCVgHfN5jmksGmVnPw@mail.gmail.com>
 <CACd+_b46wkEH3jVOfz=SR2eS+ZXuWoL=f81ahNa4uwPNpWTHbw@mail.gmail.com>
 <566B0FEA.7040307@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0426025669=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-lf0-f47.google.com ([209.85.215.47])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <aravind.ht@gmail.com>) id 1a7SeQ-0002cX-99
 for lttng-dev@lists.lttng.org; Fri, 11 Dec 2015 13:42:46 -0500
Received: by lfcy184 with SMTP id y184so11660610lfc.1
 for <lttng-dev@lists.lttng.org>; Fri, 11 Dec 2015 10:42:36 -0800 (PST)
In-Reply-To: <566B0FEA.7040307@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Jonathan Rajotte Julien <Jonathan.rajotte-julien@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============0426025669==
Content-Type: multipart/alternative; boundary=001a113f993ae9014e0526a3af73

--001a113f993ae9014e0526a3af73
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

NPBS understand it, I will continue to investigate this, got a bit side
tracked with the sessiond hang issue that I mentioned earlier.
Making some progress on that, will update as soon as I find the root cause,
it looks like a mutex deadlock between
the following threads in the consumerd daemon

#1  0x0000000000410b5d in lttcomm_recv_unix_sock (sock=3D26,
buf=3Dbuf@entry=3D0x7f16acca57f0,
len=3Dlen@entry=3D4476) at unix.c:175
#2  0x000000000041dc96 in lttng_ustconsumer_request_metadata
(ctx=3Dctx@entry=3D0x640d10,
channel=3D0x7f16980192b0, timer=3Dtimer@entry=3D0, wait=3Dwait@entry=3D0) a=
t
ust-consumer.c:2331
#3  0x000000000041ff3c in lttng_ustconsumer_sync_metadata
(ctx=3Dctx@entry=3D0x640d10,
metadata=3Dmetadata@entry=3D0x7f169801aa40) at ust-consumer.c:1829
#4  0x000000000040eabf in do_sync_metadata (ctx=3D<optimized out>,
metadata=3D<optimized out>) at consumer-stream.c:468
#5  consumer_stream_sync_metadata (ctx=3Dctx@entry=3D0x640d10, session_id=
=3D8) at
consumer-stream.c:545
#6  0x000000000041d316 in lttng_ustconsumer_read_subbuffer
(stream=3Dstream@entry=3D0x7f1698018fa0, ctx=3Dctx@entry=3D0x640d10) at
ust-consumer.c:2063
#7  0x000000000040b613 in lttng_consumer_read_subbuffer
(stream=3D0x7f1698018fa0, ctx=3D0x640d10) at consumer.c:3203
#8  0x0000000000409608 in consumer_thread_data_poll (data=3D0x640d10) at
consumer.c:2557
#9  0x00007f16af6a6fe3 in start_thread (arg=3D0x7f16acca7700) at
pthread_create.c:312
#10 0x00007f16af3dcafd in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:111

and

consumer_thread_metadata_poll() calling lttng_consumer_read_subbuffer() /
on_buffer_ready() calling pthread_mutex_lock(stream->lock) and then hanging


This again can be reproduced by the same script, just running consecutive
sessions of short duration (<10 seconds) with traces getting captured on a
remote node.
I hit this every time I run the script.

Regards,
Aravind.



On Fri, Dec 11, 2015 at 11:33 PM, Jonathan Rajotte Julien <
Jonathan.rajotte-julien@efficios.com> wrote:

> Hi Aravind,
>
> On 2015-12-11 12:16 PM, Aravind HT wrote:
>
>> Hi,
>>
>> Did you get a chance to reproduce the problem with the scripts ? Let me
>> know if you need any help running it.
>>
>
> Time is a scarce resource unfortunately. But until I have the time to loo=
k
> at it you might want to investigate if you are able to reproduce it on
> 2.6.1/2.7.0/master on 2 regular (x86_64, ubuntu/debian) VM this would
> really help.
>
> Cheers!
>
>
>> Regards,
>> Aravind.
>>
>>
>> On Wed, Dec 9, 2015 at 3:04 PM, Aravind HT <aravind.ht@gmail.com <mailto=
:
>> aravind.ht@gmail.com>> wrote:
>>
>>     Sorry about that, not sure how it got missed.
>>     Here it is.
>>
>>
>>     # This needs a two node set up (1. local current node 2. remote node=
 )
>>     # relayd runs on the current node where traces are captured from
>>     the remote node
>>     # remote node runs test applications which generate traces.
>>     # the launch_script_RN is executed on the current node and uses
>>     ssh  to execute commands on the remote node. So this part may not
>>     work in every case and may prompt for a password.
>>     # if experiencing problems with ssh , kindly check
>>
>> http://serverfault.com/questions/241588/how-to-automate-ssh-login-with-p=
assword
>>
>>     # =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D      =
 To Run  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
>>     launch_script_RN.py self_profile -c /tmp/configFile.txt
>>
>>
>>
>>     # configFile.txt is the file which has configuration params that
>>     launchScript
>>     # needs to configure lttng sessions. Below is an explanation of
>>     the different options.
>>     # =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D     conf=
igFile.txt =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
>>
>>     [section1]
>>     # final out put file path
>>     OutputFile =3D /tmp/Final_report.txt
>>     # the remote node hostname on which test applications run and the
>>     test sessions will be created; this should be something that could
>>     be used with ssh. Traces will be transported from this node to the
>>     lttng_relayd running on the current node.
>>     Node =3D MY_REMOTE_NODE
>>     # Sub buffer size to start this with
>>     SubBufSize =3D 16k
>>     # Sub buffer count
>>     SubBufCount =3D 4
>>     # per uid buffer
>>     BufferScheme =3D --buffers-uid
>>     # yes
>>     EnableTracing =3D yes
>>     # Bit rate of the test applications. Comman seperated example "1,
>>     3, 3, 50" sayss 4 test applications producing 1, 3, 3, and 50 Kb/s
>>     traces.
>>     # So with the below, we just start with 1 test application
>>     producing 10 kb/s
>>     TestApps =3D 10
>>     # session life time in seonds
>>     TestTime =3D 10
>>     # Max number of successive sessions to configure. if n then n-1
>>     sessions are run, ex MaxRun =3D 2 will run 1 session.
>>     MaxRun =3D 100
>>
>>
>>     # =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  Plac=
e the following files under
>>     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>
>>     # /tmp on the remote node
>>     clean_RemNode_apps.sh
>>     report_lttng_script.sh
>>
>>     # rest of the scripts under /usr/sbin on the current local node on
>>     which lttng_realyd runs
>>     # Define a trace point MY_TRACE to take a single string arg with
>>     LOG_TEST_APP_PROFILING as the provider, compile test lttng_testApp
>>     and place it under /usr/sbin of the remote host
>>
>>     # in launch_script_RN.py change currentNodeIP to the IP address on
>>     which relayd is receiving, default ports are used.
>>
>>     # lttng_relayd is started as
>>     /usr/bin/lttng-relayd -o /var/log/lttng-traces -d
>>
>>     # lttng_sessiond is started as
>>     /usr/bin/lttng-sessiond --consumerd32-path
>>     /usr/lib/lttng/libexec/lttng-consumerd --consumerd32-libdir
>>     /usr/lib/ --consumerd64-path
>>     /usr/lib64/lttng/libexec/lttng-consumerd --consumerd64-libdir
>>     /usr/lib64/ -b --no-kernel
>>
>>
>>
>>
>>     Regards,
>>     Aravind.
>>
>>     On Wed, Dec 9, 2015 at 12:57 AM, Jonathan Rajotte Julien
>>     <Jonathan.rajotte-julien@efficios.com
>>     <mailto:Jonathan.rajotte-julien@efficios.com>> wrote:
>>
>>         Hi Aravind,
>>
>>         There is no README in the archive you sent.
>>
>>         Cheers
>>
>>         On 2015-12-08 07:51 AM, Aravind HT wrote:
>>
>>             Hi,
>>
>>             I am trying to upgrade in parallel, but this issue may
>>             still be present after I upgrade or may be temporarily
>>             masked. So I need to find the root cause for this and then
>>             see if its available on the latest before committing to
>>             upgrade.
>>
>>             There is another issue i'm hitting, the lttng list command
>>             hangs after lttng destroy session when running the profiling=
.
>>
>>             I found that consumerd 64 goes into an infinite loop
>>             waiting to flush metadata in
>>             lttng_ustconsumer_recv_metadata() :: while
>>             (consumer_metadata_cache_flushed(channel, offset + len,
>>             timer)) .
>>             In consumer_metadata_cache,
>>             channel->metadata_stream->endpoint_status is
>>             CONSUMER_ENDPOINT_ACTIVE,
>>             metadata_stream->ust_metadata_pushed is 0 with offset
>>             having some value. This call always returns a 1 from the
>>             last else{} block resulting in an infinite loop. Upon
>>             searching the forum, I found the same issue being reported
>>             here :
>>
>> https://www.mail-archive.com/lttng-dev@lists.lttng.org/msg07982.html
>>
>>             Regards,
>>             Aravind.
>>
>>
>>             On Tue, Dec 8, 2015 at 12:43 AM, Jonathan Rajotte
>>             <jonathan.r.julien@gmail.com
>>             <mailto:jonathan.r.julien@gmail.com>> wrote:
>>
>>                 Hi Aravind,
>>
>>                 Did you have the chance to upgrade to 2.6.1.If so
>>             where you able
>>                 to reproduce?
>>
>>                 Cheers
>>
>>                 On Mon, Dec 7, 2015 at 1:07 PM, Aravind HT
>>             <aravind.ht@gmail.com <mailto:aravind.ht@gmail.com>>
>>                 wrote:
>>
>>                     Hi,
>>
>>                     I have attached the complete profiling scripts
>>             here, its a bit
>>                     shabby, im new to python.
>>
>>                     There is a README which has the details on how to
>>             execute it.
>>                     Im using a Yocto 1.6 on x86_64 platforms on both
>>             the nodes.
>>
>>
>>                     Running this script when there are other sessions
>>             running
>>                     seems to reproduce this problem easily.
>>                     Please try it and let me know if you have any issues
>>                     reproducing the problem.
>>
>>                     Regards,
>>                     Aravind.
>>
>>                     On Sat, Dec 5, 2015 at 5:23 PM, J=C3=A9r=C3=A9mie Ga=
larneau
>>                     <jeremie.galarneau@efficios.com
>>             <mailto:jeremie.galarneau@efficios.com>
>>                     <mailto:jeremie.galarneau@efficios.com
>>             <mailto:jeremie.galarneau@efficios.com>>> wrote:
>>
>>                         On Fri, Dec 4, 2015 at 11:06 PM, Aravind HT
>>                         <aravind.ht@gmail.com
>>             <mailto:aravind.ht@gmail.com> <mailto:aravind.ht@gmail.com
>>
>>             <mailto:aravind.ht@gmail.com>>> wrote:
>>                         > I am using 2.6.0 .I will try to share the
>>             code that I'm
>>                         using here in some
>>                         > time. If there are any specific fixes that
>>             are relevant
>>                         to this issue, see
>>                         > if you can provide a link to them. I would
>>             ideally like
>>                         to try them out
>>                         > before trying a full upgrade to the latest
>>             versions.
>>
>>                         Hi,
>>
>>                         Can you provide more information on the
>>             system? Which
>>                         distribution,
>>                         architecture, kernel version?
>>
>>                         The verbose sessiond logs might help pinpoint an=
y
>>                         unexpected behaviour
>>                         here (are all applications registering as
>>             expected?).
>>
>>                         J=C3=A9r=C3=A9mie
>>
>>                         >
>>                         > On Fri, Dec 4, 2015 at 6:11 PM, J=C3=A9r=C3=A9=
mie
>>             Galarneau
>>                         > <jeremie.galarneau@efficios.com
>>             <mailto:jeremie.galarneau@efficios.com>
>>                         <mailto:jeremie.galarneau@efficios.com
>>             <mailto:jeremie.galarneau@efficios.com>>> wrote:
>>                         >>
>>                         >> Hi Aravind,
>>                         >>
>>                         >> Can't say I have looked at everything you
>>             sent yet, but
>>                         as a
>>                         >> preemptive question, which version are we
>>             talking about
>>                         here? 2.6.0 or
>>                         >> 2.6.1? 2.6.1 contains a lot of relay daemon
>>             fixes.
>>                         >>
>>                         >> Thanks,
>>                         >> J=C3=A9r=C3=A9mie
>>                         >>
>>                         >> On Thu, Dec 3, 2015 at 7:01 AM, Aravind HT
>>                         <aravind.ht@gmail.com
>>             <mailto:aravind.ht@gmail.com>> wrote:
>>                         >> > Hi,
>>                         >> >
>>                         >> > I am trying to obtain the performance
>>             characteristics
>>                         of lttng with the
>>                         >> > use
>>                         >> > of test applications. Traces are being
>>             produced on a
>>                         local node and
>>                         >> > delivered to relayd that is running on a
>>             separate
>>                         node for storage.
>>                         >> >
>>                         >> > An lttng session with the test
>>             applications producing
>>                         an initial bit
>>                         >> > rate of
>>                         >> > 10 kb/s is started and run for about 30
>>             seconds. The
>>                         starting sub-buffer
>>                         >> > size is kept at 128 kb and sub-buf count
>>             at 4. The
>>                         session is then
>>                         >> > stopped
>>                         >> > and destroyed and traces are analyzed to
>>             see if there
>>                         are any drops.
>>                         >> > This is
>>                         >> > being done in a loop with every
>>             subsequent session
>>                         having an increment
>>                         >> > of 2
>>                         >> > kb/s as long as there are no drops. If
>>             there are
>>                         drops, I increase the
>>                         >> > buffer size by a factor of x2 without
>>             incrementing
>>                         the bit rate.
>>                         >> >
>>                         >> > I see trace drops happening consistently
>>             with test
>>                         apps producing traces
>>                         >> > at
>>                         >> > less than 40 kb/s, it doesnt seem to help
>>             even if I
>>                         started with 1mb x 4
>>                         >> > sub-buffers.
>>                         >> >
>>                         >> > Analysis :
>>                         >> >
>>                         >> > I have attached the lttng_relayd ,
>>             lttng_consumerd_64
>>                         logs and the
>>                         >> > entire
>>                         >> > trace directory, hope you will be able to
>>             view it.
>>                         >> > I have modified lttng_relayd code to dump
>>             the traces
>>                         being captured in
>>                         >> > the
>>                         >> > lttng_relayd logs along with debug info.
>>                         >> >
>>                         >> > Each test app is producing logs in the
>>             form of  :
>>                         >> > "TraceApp PID - 31940 THID - 31970
>>             @threadRate - 1032
>>                         b/s appRate - 2079
>>                         >> > b/s
>>                         >> > threadTraceNum - 9 appTraceNum - 18
>>    sleepTime - 192120"
>>                         >> >
>>                         >> > The test application PID, test
>>             application thread id,
>>                         thread bit rate,
>>                         >> > test
>>                         >> > app bit rate, thread trace number and
>>             application
>>                         trace number s are
>>                         >> > part of
>>                         >> > the trace. So in the above trace, the
>>             thread is
>>                         producing at 1 kb/s and
>>                         >> > the
>>                         >> > whole test app is producing at 2 kb/s.
>>                         >> >
>>                         >> > If we look at the babeltrace out put, we
>>             see that the
>>                         Trace with
>>                         >> > TraceApp
>>                         >> > PID - 31940 appTraceNum 2 is missing ,
>>             with 1, 3, 4,
>>                         5 and so on being
>>                         >> > successfully captured.
>>                         >> > I looked at the lttng_relayd logs and
>>             found that
>>                         trace of "appTraceNum
>>                         >> > 2" is
>>                         >> > not delivered/generated by the consumerd
>>             to the
>>                         relayd in sequence with
>>                         >> > other traces. To rule out that this is
>>             not a test
>>                         application problem,
>>                         >> > you
>>                         >> > can look at line ltttng_relayd log :
>>             12778 and see
>>                         traces from
>>                         >> > appTraceNum -
>>                         >> > 1 to appTraceNum - 18 including the
>>             appTraceNum 2 are
>>                         "re-delivered" by
>>                         >> > the
>>                         >> > consumerd to the relayd.
>>                         >> > Essentially, I see appTraceNum 1 through
>>             appTraceNum
>>                         18 being delivered
>>                         >> > twice, once individually where
>>             appTraceNum 2 is
>>                         missing and once as a
>>                         >> > group
>>                         >> > at line 12778 where its present.
>>                         >> >
>>                         >> >
>>                         >> > Request help with
>>                         >> > 1. why traces are delivered twice, is it
>>             by design or
>>                         a genuine problem
>>                         >> > ?
>>                         >> > 2. how to avoid traces being dropped even
>>             though
>>                         buffers are
>>                         >> > sufficiently
>>                         >> > large enough ?
>>                         >> >
>>                         >> >
>>                         >> > Regards,
>>                         >> > Aravind.
>>                         >> >
>>                         >> >
>>             _______________________________________________
>>                         >> > lttng-dev mailing list
>>                         >> > lttng-dev@lists.lttng.org
>>             <mailto:lttng-dev@lists.lttng.org>
>>                         >> >
>>             http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>>                         >> >
>>                         >>
>>                         >>
>>                         >>
>>                         >> --
>>                         >> J=C3=A9r=C3=A9mie Galarneau
>>                         >> EfficiOS Inc.
>>                         >> http://www.efficios.com
>>                         >
>>                         >
>>
>>
>>
>>                         --
>>                         J=C3=A9r=C3=A9mie Galarneau
>>                         EfficiOS Inc.
>>             http://www.efficios.com
>>
>>
>>
>>             _______________________________________________
>>                     lttng-dev mailing list
>>             lttng-dev@lists.lttng.org
>>             <mailto:lttng-dev@lists.lttng.org>
>>             <mailto:lttng-dev@lists.lttng.org
>>             <mailto:lttng-dev@lists.lttng.org>>
>>             http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>>
>>
>>
>>
>>                 --     Jonathan Rajotte Julien
>>
>>
>>
>>
>>             _______________________________________________
>>             lttng-dev mailing list
>>             lttng-dev@lists.lttng.org <mailto:lttng-dev@lists.lttng.org>
>>             http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>>
>>
>>         --         Jonathan R. Julien
>>         Efficios
>>
>>
>>
>>
> --
> Jonathan R. Julien
> Efficios
>
>

--001a113f993ae9014e0526a3af73
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+PGRpdj48YnI+PC9kaXY+TlBCUyB1bmRlcnN0YW5kIGl0LCBJIHdpbGwg
Y29udGludWUgdG8gaW52ZXN0aWdhdGUgdGhpcywgZ290IGEgYml0IHNpZGUgdHJhY2tlZCB3aXRo
IHRoZSBzZXNzaW9uZCBoYW5nIGlzc3VlIHRoYXQgSSBtZW50aW9uZWQgZWFybGllci7CoDxkaXY+
TWFraW5nIHNvbWUgcHJvZ3Jlc3Mgb24gdGhhdCwgd2lsbCB1cGRhdGUgYXMgc29vbiBhcyBJIGZp
bmQgdGhlIHJvb3QgY2F1c2UsIGl0IGxvb2tzIGxpa2UgYSBtdXRleCBkZWFkbG9jayBiZXR3ZWVu
wqA8YnI+PC9kaXY+PGRpdj48ZGl2PnRoZSBmb2xsb3dpbmcgdGhyZWFkcyBpbiB0aGUgY29uc3Vt
ZXJkIGRhZW1vbjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+IzEgwqAweDAwMDAwMDAwMDA0MTBi
NWQgaW4gbHR0Y29tbV9yZWN2X3VuaXhfc29jayAoc29jaz0yNiwgYnVmPWJ1ZkBlbnRyeT0weDdm
MTZhY2NhNTdmMCwgbGVuPWxlbkBlbnRyeT00NDc2KSBhdCB1bml4LmM6MTc1PGRpdj4jMiDCoDB4
MDAwMDAwMDAwMDQxZGM5NiBpbiBsdHRuZ191c3Rjb25zdW1lcl9yZXF1ZXN0X21ldGFkYXRhIChj
dHg9Y3R4QGVudHJ5PTB4NjQwZDEwLCBjaGFubmVsPTB4N2YxNjk4MDE5MmIwLCB0aW1lcj10aW1l
ckBlbnRyeT0wLCB3YWl0PXdhaXRAZW50cnk9MCkgYXQgdXN0LWNvbnN1bWVyLmM6MjMzMTwvZGl2
PjxkaXY+IzMgwqAweDAwMDAwMDAwMDA0MWZmM2MgaW4gbHR0bmdfdXN0Y29uc3VtZXJfc3luY19t
ZXRhZGF0YSAoY3R4PWN0eEBlbnRyeT0weDY0MGQxMCwgbWV0YWRhdGE9bWV0YWRhdGFAZW50cnk9
MHg3ZjE2OTgwMWFhNDApIGF0IHVzdC1jb25zdW1lci5jOjE4Mjk8L2Rpdj48ZGl2PiM0IMKgMHgw
MDAwMDAwMDAwNDBlYWJmIGluIGRvX3N5bmNfbWV0YWRhdGEgKGN0eD0mbHQ7b3B0aW1pemVkIG91
dCZndDssIG1ldGFkYXRhPSZsdDtvcHRpbWl6ZWQgb3V0Jmd0OykgYXQgY29uc3VtZXItc3RyZWFt
LmM6NDY4PC9kaXY+PGRpdj4jNSDCoGNvbnN1bWVyX3N0cmVhbV9zeW5jX21ldGFkYXRhIChjdHg9
Y3R4QGVudHJ5PTB4NjQwZDEwLCBzZXNzaW9uX2lkPTgpIGF0IGNvbnN1bWVyLXN0cmVhbS5jOjU0
NTwvZGl2PjxkaXY+IzYgwqAweDAwMDAwMDAwMDA0MWQzMTYgaW4gbHR0bmdfdXN0Y29uc3VtZXJf
cmVhZF9zdWJidWZmZXIgKHN0cmVhbT1zdHJlYW1AZW50cnk9MHg3ZjE2OTgwMThmYTAsIGN0eD1j
dHhAZW50cnk9MHg2NDBkMTApIGF0IHVzdC1jb25zdW1lci5jOjIwNjM8L2Rpdj48ZGl2PiM3IMKg
MHgwMDAwMDAwMDAwNDBiNjEzIGluIGx0dG5nX2NvbnN1bWVyX3JlYWRfc3ViYnVmZmVyIChzdHJl
YW09MHg3ZjE2OTgwMThmYTAsIGN0eD0weDY0MGQxMCkgYXQgY29uc3VtZXIuYzozMjAzPC9kaXY+
PGRpdj4jOCDCoDB4MDAwMDAwMDAwMDQwOTYwOCBpbiBjb25zdW1lcl90aHJlYWRfZGF0YV9wb2xs
IChkYXRhPTB4NjQwZDEwKSBhdCBjb25zdW1lci5jOjI1NTc8L2Rpdj48ZGl2PiM5IMKgMHgwMDAw
N2YxNmFmNmE2ZmUzIGluIHN0YXJ0X3RocmVhZCAoYXJnPTB4N2YxNmFjY2E3NzAwKSBhdCBwdGhy
ZWFkX2NyZWF0ZS5jOjMxMjwvZGl2PjxkaXY+IzEwIDB4MDAwMDdmMTZhZjNkY2FmZCBpbiBjbG9u
ZSAoKSBhdCAuLi9zeXNkZXBzL3VuaXgvc3lzdi9saW51eC94ODZfNjQvY2xvbmUuUzoxMTE8L2Rp
dj48L2Rpdj48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PmFuZMKgPC9kaXY+PGRpdj48YnI+PC9k
aXY+PGRpdj5jb25zdW1lcl90aHJlYWRfbWV0YWRhdGFfcG9sbCgpIGNhbGxpbmcgbHR0bmdfY29u
c3VtZXJfcmVhZF9zdWJidWZmZXIoKSAvIG9uX2J1ZmZlcl9yZWFkeSgpIGNhbGxpbmcgcHRocmVh
ZF9tdXRleF9sb2NrKHN0cmVhbS0mZ3Q7bG9jaykgYW5kIHRoZW4gaGFuZ2luZzwvZGl2PjxkaXY+
PGRpdj48YnI+PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5UaGlzIGFnYWluIGNhbiBiZSByZXBy
b2R1Y2VkIGJ5IHRoZSBzYW1lIHNjcmlwdCwganVzdCBydW5uaW5nIGNvbnNlY3V0aXZlIHNlc3Np
b25zIG9mIHNob3J0IGR1cmF0aW9uICgmbHQ7MTAgc2Vjb25kcykgd2l0aCB0cmFjZXMgZ2V0dGlu
ZyBjYXB0dXJlZCBvbiBhIHJlbW90ZSBub2RlLjwvZGl2PjxkaXY+SSBoaXQgdGhpcyBldmVyeSB0
aW1lIEkgcnVuIHRoZSBzY3JpcHQuPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5SZWdhcmRzLDwv
ZGl2PjxkaXY+QXJhdmluZC48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9l
eHRyYSI+PGJyPjwvZGl2PjxkaXYgY2xhc3M9ImdtYWlsX2V4dHJhIj48YnI+PGRpdiBjbGFzcz0i
Z21haWxfcXVvdGUiPk9uIEZyaSwgRGVjIDExLCAyMDE1IGF0IDExOjMzIFBNLCBKb25hdGhhbiBS
YWpvdHRlIEp1bGllbiA8c3BhbiBkaXI9Imx0ciI+Jmx0OzxhIGhyZWY9Im1haWx0bzpKb25hdGhh
bi5yYWpvdHRlLWp1bGllbkBlZmZpY2lvcy5jb20iIHRhcmdldD0iX2JsYW5rIj5Kb25hdGhhbi5y
YWpvdHRlLWp1bGllbkBlZmZpY2lvcy5jb208L2E+Jmd0Ozwvc3Bhbj4gd3JvdGU6PGJyPjxibG9j
a3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowcHggMHB4IDBweCAwLjhl
eDtib3JkZXItbGVmdC13aWR0aDoxcHg7Ym9yZGVyLWxlZnQtY29sb3I6cmdiKDIwNCwyMDQsMjA0
KTtib3JkZXItbGVmdC1zdHlsZTpzb2xpZDtwYWRkaW5nLWxlZnQ6MWV4Ij5IaSBBcmF2aW5kLDxz
cGFuIGNsYXNzPSIiPjxicj4NCjxicj4NCk9uIDIwMTUtMTItMTEgMTI6MTYgUE0sIEFyYXZpbmQg
SFQgd3JvdGU6PGJyPg0KPGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFy
Z2luOjBweCAwcHggMHB4IDAuOGV4O2JvcmRlci1sZWZ0LXdpZHRoOjFweDtib3JkZXItbGVmdC1j
b2xvcjpyZ2IoMjA0LDIwNCwyMDQpO2JvcmRlci1sZWZ0LXN0eWxlOnNvbGlkO3BhZGRpbmctbGVm
dDoxZXgiPg0KSGksPGJyPg0KPGJyPg0KRGlkIHlvdSBnZXQgYSBjaGFuY2UgdG8gcmVwcm9kdWNl
IHRoZSBwcm9ibGVtIHdpdGggdGhlIHNjcmlwdHMgPyBMZXQgbWUga25vdyBpZiB5b3UgbmVlZCBh
bnkgaGVscCBydW5uaW5nIGl0Ljxicj4NCjwvYmxvY2txdW90ZT4NCjxicj48L3NwYW4+DQpUaW1l
IGlzIGEgc2NhcmNlIHJlc291cmNlIHVuZm9ydHVuYXRlbHkuIEJ1dCB1bnRpbCBJIGhhdmUgdGhl
IHRpbWUgdG8gbG9vayBhdCBpdCB5b3UgbWlnaHQgd2FudCB0byBpbnZlc3RpZ2F0ZSBpZiB5b3Ug
YXJlIGFibGUgdG8gcmVwcm9kdWNlIGl0IG9uIDIuNi4xLzIuNy4wL21hc3RlciBvbiAyIHJlZ3Vs
YXIgKHg4Nl82NCwgdWJ1bnR1L2RlYmlhbikgVk0gdGhpcyB3b3VsZCByZWFsbHkgaGVscC48YnI+
DQo8YnI+DQpDaGVlcnMhPGJyPg0KPGJyPg0KPGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3Rl
IiBzdHlsZT0ibWFyZ2luOjBweCAwcHggMHB4IDAuOGV4O2JvcmRlci1sZWZ0LXdpZHRoOjFweDti
b3JkZXItbGVmdC1jb2xvcjpyZ2IoMjA0LDIwNCwyMDQpO2JvcmRlci1sZWZ0LXN0eWxlOnNvbGlk
O3BhZGRpbmctbGVmdDoxZXgiPg0KPGJyPg0KUmVnYXJkcyw8YnI+DQpBcmF2aW5kLjxkaXY+PGRp
diBjbGFzcz0iaDUiPjxicj4NCjxicj4NCk9uIFdlZCwgRGVjIDksIDIwMTUgYXQgMzowNCBQTSwg
QXJhdmluZCBIVCAmbHQ7PGEgaHJlZj0ibWFpbHRvOmFyYXZpbmQuaHRAZ21haWwuY29tIiB0YXJn
ZXQ9Il9ibGFuayI+YXJhdmluZC5odEBnbWFpbC5jb208L2E+ICZsdDttYWlsdG86PGEgaHJlZj0i
bWFpbHRvOmFyYXZpbmQuaHRAZ21haWwuY29tIiB0YXJnZXQ9Il9ibGFuayI+YXJhdmluZC5odEBn
bWFpbC5jb208L2E+Jmd0OyZndDsgd3JvdGU6PGJyPg0KPGJyPg0KwqAgwqAgU29ycnkgYWJvdXQg
dGhhdCwgbm90IHN1cmUgaG93IGl0IGdvdCBtaXNzZWQuPGJyPg0KwqAgwqAgSGVyZSBpdCBpcy48
YnI+DQo8YnI+DQo8YnI+DQrCoCDCoCAjIFRoaXMgbmVlZHMgYSB0d28gbm9kZSBzZXQgdXAgKDEu
IGxvY2FsIGN1cnJlbnQgbm9kZSAyLiByZW1vdGUgbm9kZSApPGJyPg0KwqAgwqAgIyByZWxheWQg
cnVucyBvbiB0aGUgY3VycmVudCBub2RlIHdoZXJlIHRyYWNlcyBhcmUgY2FwdHVyZWQgZnJvbTxi
cj4NCsKgIMKgIHRoZSByZW1vdGUgbm9kZTxicj4NCsKgIMKgICMgcmVtb3RlIG5vZGUgcnVucyB0
ZXN0IGFwcGxpY2F0aW9ucyB3aGljaCBnZW5lcmF0ZSB0cmFjZXMuPGJyPg0KwqAgwqAgIyB0aGUg
bGF1bmNoX3NjcmlwdF9STiBpcyBleGVjdXRlZCBvbiB0aGUgY3VycmVudCBub2RlIGFuZCB1c2Vz
PGJyPg0KwqAgwqAgc3NowqAgdG8gZXhlY3V0ZSBjb21tYW5kcyBvbiB0aGUgcmVtb3RlIG5vZGUu
IFNvIHRoaXMgcGFydCBtYXkgbm90PGJyPg0KwqAgwqAgd29yayBpbiBldmVyeSBjYXNlIGFuZCBt
YXkgcHJvbXB0IGZvciBhIHBhc3N3b3JkLjxicj4NCsKgIMKgICMgaWYgZXhwZXJpZW5jaW5nIHBy
b2JsZW1zIHdpdGggc3NoICwga2luZGx5IGNoZWNrPGJyPg0KwqAgwqAgPGEgaHJlZj0iaHR0cDov
L3NlcnZlcmZhdWx0LmNvbS9xdWVzdGlvbnMvMjQxNTg4L2hvdy10by1hdXRvbWF0ZS1zc2gtbG9n
aW4td2l0aC1wYXNzd29yZCIgcmVsPSJub3JlZmVycmVyIiB0YXJnZXQ9Il9ibGFuayI+aHR0cDov
L3NlcnZlcmZhdWx0LmNvbS9xdWVzdGlvbnMvMjQxNTg4L2hvdy10by1hdXRvbWF0ZS1zc2gtbG9n
aW4td2l0aC1wYXNzd29yZDwvYT48YnI+DQo8YnI+DQrCoCDCoCAjID09PT09PT09PT09PT09PT09
PT09wqAgwqAgwqAgwqBUbyBSdW7CoCA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PTxicj4N
CsKgIMKgIGxhdW5jaF9zY3JpcHRfUk4ucHkgc2VsZl9wcm9maWxlIC1jIC90bXAvY29uZmlnRmls
ZS50eHQ8YnI+DQo8YnI+DQo8YnI+DQo8YnI+DQrCoCDCoCAjIGNvbmZpZ0ZpbGUudHh0IGlzIHRo
ZSBmaWxlIHdoaWNoIGhhcyBjb25maWd1cmF0aW9uIHBhcmFtcyB0aGF0PGJyPg0KwqAgwqAgbGF1
bmNoU2NyaXB0PGJyPg0KwqAgwqAgIyBuZWVkcyB0byBjb25maWd1cmUgbHR0bmcgc2Vzc2lvbnMu
IEJlbG93IGlzIGFuIGV4cGxhbmF0aW9uIG9mPGJyPg0KwqAgwqAgdGhlIGRpZmZlcmVudCBvcHRp
b25zLjxicj4NCsKgIMKgICMgPT09PT09PT09PT09PT09PT09PcKgIMKgIMKgY29uZmlnRmlsZS50
eHQgPT09PT09PT09PT09PT09PT09PT09PT09PT09PT08YnI+DQo8YnI+DQrCoCDCoCBbc2VjdGlv
bjFdPGJyPg0KwqAgwqAgIyBmaW5hbCBvdXQgcHV0IGZpbGUgcGF0aDxicj4NCsKgIMKgIE91dHB1
dEZpbGUgPSAvdG1wL0ZpbmFsX3JlcG9ydC50eHQ8YnI+DQrCoCDCoCAjIHRoZSByZW1vdGUgbm9k
ZSBob3N0bmFtZSBvbiB3aGljaCB0ZXN0IGFwcGxpY2F0aW9ucyBydW4gYW5kIHRoZTxicj4NCsKg
IMKgIHRlc3Qgc2Vzc2lvbnMgd2lsbCBiZSBjcmVhdGVkOyB0aGlzIHNob3VsZCBiZSBzb21ldGhp
bmcgdGhhdCBjb3VsZDxicj4NCsKgIMKgIGJlIHVzZWQgd2l0aCBzc2guIFRyYWNlcyB3aWxsIGJl
IHRyYW5zcG9ydGVkIGZyb20gdGhpcyBub2RlIHRvIHRoZTxicj4NCsKgIMKgIGx0dG5nX3JlbGF5
ZCBydW5uaW5nIG9uIHRoZSBjdXJyZW50IG5vZGUuPGJyPg0KwqAgwqAgTm9kZSA9IE1ZX1JFTU9U
RV9OT0RFPGJyPg0KwqAgwqAgIyBTdWIgYnVmZmVyIHNpemUgdG8gc3RhcnQgdGhpcyB3aXRoPGJy
Pg0KwqAgwqAgU3ViQnVmU2l6ZSA9IDE2azxicj4NCsKgIMKgICMgU3ViIGJ1ZmZlciBjb3VudDxi
cj4NCsKgIMKgIFN1YkJ1ZkNvdW50ID0gNDxicj4NCsKgIMKgICMgcGVyIHVpZCBidWZmZXI8YnI+
DQrCoCDCoCBCdWZmZXJTY2hlbWUgPSAtLWJ1ZmZlcnMtdWlkPGJyPg0KwqAgwqAgIyB5ZXM8YnI+
DQrCoCDCoCBFbmFibGVUcmFjaW5nID0geWVzPGJyPg0KwqAgwqAgIyBCaXQgcmF0ZSBvZiB0aGUg
dGVzdCBhcHBsaWNhdGlvbnMuIENvbW1hbiBzZXBlcmF0ZWQgZXhhbXBsZSAmcXVvdDsxLDxicj4N
CsKgIMKgIDMsIDMsIDUwJnF1b3Q7IHNheXNzIDQgdGVzdCBhcHBsaWNhdGlvbnMgcHJvZHVjaW5n
IDEsIDMsIDMsIGFuZCA1MCBLYi9zPGJyPg0KwqAgwqAgdHJhY2VzLjxicj4NCsKgIMKgICMgU28g
d2l0aCB0aGUgYmVsb3csIHdlIGp1c3Qgc3RhcnQgd2l0aCAxIHRlc3QgYXBwbGljYXRpb248YnI+
DQrCoCDCoCBwcm9kdWNpbmcgMTAga2Ivczxicj4NCsKgIMKgIFRlc3RBcHBzID0gMTA8YnI+DQrC
oCDCoCAjIHNlc3Npb24gbGlmZSB0aW1lIGluIHNlb25kczxicj4NCsKgIMKgIFRlc3RUaW1lID0g
MTA8YnI+DQrCoCDCoCAjIE1heCBudW1iZXIgb2Ygc3VjY2Vzc2l2ZSBzZXNzaW9ucyB0byBjb25m
aWd1cmUuIGlmIG4gdGhlbiBuLTE8YnI+DQrCoCDCoCBzZXNzaW9ucyBhcmUgcnVuLCBleCBNYXhS
dW4gPSAyIHdpbGwgcnVuIDEgc2Vzc2lvbi48YnI+DQrCoCDCoCBNYXhSdW4gPSAxMDA8YnI+DQo8
YnI+DQo8YnI+DQrCoCDCoCAjID09PT09PT09PT09PT09PT09PT09wqAgUGxhY2UgdGhlIGZvbGxv
d2luZyBmaWxlcyB1bmRlcjxicj4NCsKgIMKgID09PT09PT09PT09PT09PTxicj4NCjxicj4NCsKg
IMKgICMgL3RtcCBvbiB0aGUgcmVtb3RlIG5vZGU8YnI+DQrCoCDCoCBjbGVhbl9SZW1Ob2RlX2Fw
cHMuc2g8YnI+DQrCoCDCoCByZXBvcnRfbHR0bmdfc2NyaXB0LnNoPGJyPg0KPGJyPg0KwqAgwqAg
IyByZXN0IG9mIHRoZSBzY3JpcHRzIHVuZGVyIC91c3Ivc2JpbiBvbiB0aGUgY3VycmVudCBsb2Nh
bCBub2RlIG9uPGJyPg0KwqAgwqAgd2hpY2ggbHR0bmdfcmVhbHlkIHJ1bnM8YnI+DQrCoCDCoCAj
IERlZmluZSBhIHRyYWNlIHBvaW50IE1ZX1RSQUNFIHRvIHRha2UgYSBzaW5nbGUgc3RyaW5nIGFy
ZyB3aXRoPGJyPg0KwqAgwqAgTE9HX1RFU1RfQVBQX1BST0ZJTElORyBhcyB0aGUgcHJvdmlkZXIs
IGNvbXBpbGUgdGVzdCBsdHRuZ190ZXN0QXBwPGJyPg0KwqAgwqAgYW5kIHBsYWNlIGl0IHVuZGVy
IC91c3Ivc2JpbiBvZiB0aGUgcmVtb3RlIGhvc3Q8YnI+DQo8YnI+DQrCoCDCoCAjIGluIGxhdW5j
aF9zY3JpcHRfUk4ucHkgY2hhbmdlIGN1cnJlbnROb2RlSVAgdG8gdGhlIElQIGFkZHJlc3Mgb248
YnI+DQrCoCDCoCB3aGljaCByZWxheWQgaXMgcmVjZWl2aW5nLCBkZWZhdWx0IHBvcnRzIGFyZSB1
c2VkLjxicj4NCjxicj4NCsKgIMKgICMgbHR0bmdfcmVsYXlkIGlzIHN0YXJ0ZWQgYXM8YnI+DQrC
oCDCoCAvdXNyL2Jpbi9sdHRuZy1yZWxheWQgLW8gL3Zhci9sb2cvbHR0bmctdHJhY2VzIC1kPGJy
Pg0KPGJyPg0KwqAgwqAgIyBsdHRuZ19zZXNzaW9uZCBpcyBzdGFydGVkIGFzPGJyPg0KwqAgwqAg
L3Vzci9iaW4vbHR0bmctc2Vzc2lvbmQgLS1jb25zdW1lcmQzMi1wYXRoPGJyPg0KwqAgwqAgL3Vz
ci9saWIvbHR0bmcvbGliZXhlYy9sdHRuZy1jb25zdW1lcmQgLS1jb25zdW1lcmQzMi1saWJkaXI8
YnI+DQrCoCDCoCAvdXNyL2xpYi8gLS1jb25zdW1lcmQ2NC1wYXRoPGJyPg0KwqAgwqAgL3Vzci9s
aWI2NC9sdHRuZy9saWJleGVjL2x0dG5nLWNvbnN1bWVyZCAtLWNvbnN1bWVyZDY0LWxpYmRpcjxi
cj4NCsKgIMKgIC91c3IvbGliNjQvIC1iIC0tbm8ta2VybmVsPGJyPg0KPGJyPg0KPGJyPg0KPGJy
Pg0KPGJyPg0KwqAgwqAgUmVnYXJkcyw8YnI+DQrCoCDCoCBBcmF2aW5kLjxicj4NCjxicj4NCsKg
IMKgIE9uIFdlZCwgRGVjIDksIDIwMTUgYXQgMTI6NTcgQU0sIEpvbmF0aGFuIFJham90dGUgSnVs
aWVuPGJyPg0KwqAgwqAgJmx0OzxhIGhyZWY9Im1haWx0bzpKb25hdGhhbi5yYWpvdHRlLWp1bGll
bkBlZmZpY2lvcy5jb20iIHRhcmdldD0iX2JsYW5rIj5Kb25hdGhhbi5yYWpvdHRlLWp1bGllbkBl
ZmZpY2lvcy5jb208L2E+PGJyPjwvZGl2PjwvZGl2PjxkaXY+PGRpdiBjbGFzcz0iaDUiPg0KwqAg
wqAgJmx0O21haWx0bzo8YSBocmVmPSJtYWlsdG86Sm9uYXRoYW4ucmFqb3R0ZS1qdWxpZW5AZWZm
aWNpb3MuY29tIiB0YXJnZXQ9Il9ibGFuayI+Sm9uYXRoYW4ucmFqb3R0ZS1qdWxpZW5AZWZmaWNp
b3MuY29tPC9hPiZndDsmZ3Q7IHdyb3RlOjxicj4NCjxicj4NCsKgIMKgIMKgIMKgIEhpIEFyYXZp
bmQsPGJyPg0KPGJyPg0KwqAgwqAgwqAgwqAgVGhlcmUgaXMgbm8gUkVBRE1FIGluIHRoZSBhcmNo
aXZlIHlvdSBzZW50Ljxicj4NCjxicj4NCsKgIMKgIMKgIMKgIENoZWVyczxicj4NCjxicj4NCsKg
IMKgIMKgIMKgIE9uIDIwMTUtMTItMDggMDc6NTEgQU0sIEFyYXZpbmQgSFQgd3JvdGU6PGJyPg0K
PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgSGksPGJyPg0KPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAg
SSBhbSB0cnlpbmcgdG8gdXBncmFkZSBpbiBwYXJhbGxlbCwgYnV0IHRoaXMgaXNzdWUgbWF5PGJy
Pg0KwqAgwqAgwqAgwqAgwqAgwqAgc3RpbGwgYmUgcHJlc2VudCBhZnRlciBJIHVwZ3JhZGUgb3Ig
bWF5IGJlIHRlbXBvcmFyaWx5PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgbWFza2VkLiBTbyBJIG5l
ZWQgdG8gZmluZCB0aGUgcm9vdCBjYXVzZSBmb3IgdGhpcyBhbmQgdGhlbjxicj4NCsKgIMKgIMKg
IMKgIMKgIMKgIHNlZSBpZiBpdHMgYXZhaWxhYmxlIG9uIHRoZSBsYXRlc3QgYmVmb3JlIGNvbW1p
dHRpbmcgdG88YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCB1cGdyYWRlLjxicj4NCjxicj4NCsKgIMKg
IMKgIMKgIMKgIMKgIFRoZXJlIGlzIGFub3RoZXIgaXNzdWUgaSYjMzk7bSBoaXR0aW5nLCB0aGUg
bHR0bmcgbGlzdCBjb21tYW5kPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgaGFuZ3MgYWZ0ZXIgbHR0
bmcgZGVzdHJveSBzZXNzaW9uIHdoZW4gcnVubmluZyB0aGUgcHJvZmlsaW5nLjxicj4NCjxicj4N
CsKgIMKgIMKgIMKgIMKgIMKgIEkgZm91bmQgdGhhdCBjb25zdW1lcmQgNjQgZ29lcyBpbnRvIGFu
IGluZmluaXRlIGxvb3A8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCB3YWl0aW5nIHRvIGZsdXNoIG1l
dGFkYXRhIGluPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgbHR0bmdfdXN0Y29uc3VtZXJfcmVjdl9t
ZXRhZGF0YSgpIDo6IHdoaWxlPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgKGNvbnN1bWVyX21ldGFk
YXRhX2NhY2hlX2ZsdXNoZWQoY2hhbm5lbCwgb2Zmc2V0ICsgbGVuLDxicj4NCsKgIMKgIMKgIMKg
IMKgIMKgIHRpbWVyKSkgLjxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIEluIGNvbnN1bWVyX21ldGFk
YXRhX2NhY2hlLDxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIGNoYW5uZWwtJmd0O21ldGFkYXRhX3N0
cmVhbS0mZ3Q7ZW5kcG9pbnRfc3RhdHVzIGlzPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgQ09OU1VN
RVJfRU5EUE9JTlRfQUNUSVZFLDxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIG1ldGFkYXRhX3N0cmVh
bS0mZ3Q7dXN0X21ldGFkYXRhX3B1c2hlZCBpcyAwIHdpdGggb2Zmc2V0PGJyPg0KwqAgwqAgwqAg
wqAgwqAgwqAgaGF2aW5nIHNvbWUgdmFsdWUuIFRoaXMgY2FsbCBhbHdheXMgcmV0dXJucyBhIDEg
ZnJvbSB0aGU8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCBsYXN0IGVsc2V7fSBibG9jayByZXN1bHRp
bmcgaW4gYW4gaW5maW5pdGUgbG9vcC4gVXBvbjxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIHNlYXJj
aGluZyB0aGUgZm9ydW0sIEkgZm91bmQgdGhlIHNhbWUgaXNzdWUgYmVpbmcgcmVwb3J0ZWQ8YnI+
DQrCoCDCoCDCoCDCoCDCoCDCoCBoZXJlIDo8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCA8YSBocmVm
PSJodHRwczovL3d3dy5tYWlsLWFyY2hpdmUuY29tL2x0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcv
bXNnMDc5ODIuaHRtbCIgcmVsPSJub3JlZmVycmVyIiB0YXJnZXQ9Il9ibGFuayI+aHR0cHM6Ly93
d3cubWFpbC1hcmNoaXZlLmNvbS9sdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnL21zZzA3OTgyLmh0
bWw8L2E+PGJyPg0KPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgUmVnYXJkcyw8YnI+DQrCoCDCoCDC
oCDCoCDCoCDCoCBBcmF2aW5kLjxicj4NCjxicj4NCjxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIE9u
IFR1ZSwgRGVjIDgsIDIwMTUgYXQgMTI6NDMgQU0sIEpvbmF0aGFuIFJham90dGU8YnI+DQrCoCDC
oCDCoCDCoCDCoCDCoCAmbHQ7PGEgaHJlZj0ibWFpbHRvOmpvbmF0aGFuLnIuanVsaWVuQGdtYWls
LmNvbSIgdGFyZ2V0PSJfYmxhbmsiPmpvbmF0aGFuLnIuanVsaWVuQGdtYWlsLmNvbTwvYT48YnI+
PC9kaXY+PC9kaXY+PHNwYW4gY2xhc3M9IiI+DQrCoCDCoCDCoCDCoCDCoCDCoCAmbHQ7bWFpbHRv
OjxhIGhyZWY9Im1haWx0bzpqb25hdGhhbi5yLmp1bGllbkBnbWFpbC5jb20iIHRhcmdldD0iX2Js
YW5rIj5qb25hdGhhbi5yLmp1bGllbkBnbWFpbC5jb208L2E+Jmd0OyZndDsgd3JvdGU6PGJyPg0K
PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgSGkgQXJhdmluZCw8YnI+DQo8YnI+DQrCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCBEaWQgeW91IGhhdmUgdGhlIGNoYW5jZSB0byB1cGdyYWRlIHRv
IDIuNi4xLklmIHNvPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgd2hlcmUgeW91IGFibGU8YnI+DQrC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB0byByZXByb2R1Y2U/PGJyPg0KPGJyPg0KwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgQ2hlZXJzPGJyPg0KPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
T24gTW9uLCBEZWMgNywgMjAxNSBhdCAxOjA3IFBNLCBBcmF2aW5kIEhUPGJyPjwvc3Bhbj4NCsKg
IMKgIMKgIMKgIMKgIMKgICZsdDs8YSBocmVmPSJtYWlsdG86YXJhdmluZC5odEBnbWFpbC5jb20i
IHRhcmdldD0iX2JsYW5rIj5hcmF2aW5kLmh0QGdtYWlsLmNvbTwvYT4gJmx0O21haWx0bzo8YSBo
cmVmPSJtYWlsdG86YXJhdmluZC5odEBnbWFpbC5jb20iIHRhcmdldD0iX2JsYW5rIj5hcmF2aW5k
Lmh0QGdtYWlsLmNvbTwvYT4mZ3Q7Jmd0OzxzcGFuIGNsYXNzPSIiPjxicj4NCsKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIHdyb3RlOjxicj4NCjxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIEhpLDxicj4NCjxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIEkgaGF2ZSBh
dHRhY2hlZCB0aGUgY29tcGxldGUgcHJvZmlsaW5nIHNjcmlwdHM8YnI+DQrCoCDCoCDCoCDCoCDC
oCDCoCBoZXJlLCBpdHMgYSBiaXQ8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBz
aGFiYnksIGltIG5ldyB0byBweXRob24uPGJyPg0KPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgVGhlcmUgaXMgYSBSRUFETUUgd2hpY2ggaGFzIHRoZSBkZXRhaWxzIG9uIGhvdyB0
bzxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIGV4ZWN1dGUgaXQuPGJyPg0KwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgSW0gdXNpbmcgYSBZb2N0byAxLjYgb24geDg2XzY0IHBsYXRmb3JtcyBv
biBib3RoPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgdGhlIG5vZGVzLjxicj4NCjxicj4NCjxicj4N
CsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFJ1bm5pbmcgdGhpcyBzY3JpcHQgd2hlbiB0
aGVyZSBhcmUgb3RoZXIgc2Vzc2lvbnM8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCBydW5uaW5nPGJy
Pg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgc2VlbXMgdG8gcmVwcm9kdWNlIHRoaXMg
cHJvYmxlbSBlYXNpbHkuPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgUGxlYXNl
IHRyeSBpdCBhbmQgbGV0IG1lIGtub3cgaWYgeW91IGhhdmUgYW55IGlzc3Vlczxicj4NCsKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHJlcHJvZHVjaW5nIHRoZSBwcm9ibGVtLjxicj4NCjxi
cj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFJlZ2FyZHMsPGJyPg0KwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgQXJhdmluZC48YnI+DQo8YnI+DQrCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCBPbiBTYXQsIERlYyA1LCAyMDE1IGF0IDU6MjMgUE0sIErDqXLDqW1pZSBH
YWxhcm5lYXU8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAmbHQ7PGEgaHJlZj0i
bWFpbHRvOmplcmVtaWUuZ2FsYXJuZWF1QGVmZmljaW9zLmNvbSIgdGFyZ2V0PSJfYmxhbmsiPmpl
cmVtaWUuZ2FsYXJuZWF1QGVmZmljaW9zLmNvbTwvYT48YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCAm
bHQ7bWFpbHRvOjxhIGhyZWY9Im1haWx0bzpqZXJlbWllLmdhbGFybmVhdUBlZmZpY2lvcy5jb20i
IHRhcmdldD0iX2JsYW5rIj5qZXJlbWllLmdhbGFybmVhdUBlZmZpY2lvcy5jb208L2E+Jmd0Ozxi
cj48L3NwYW4+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAmbHQ7bWFpbHRvOjxhIGhy
ZWY9Im1haWx0bzpqZXJlbWllLmdhbGFybmVhdUBlZmZpY2lvcy5jb20iIHRhcmdldD0iX2JsYW5r
Ij5qZXJlbWllLmdhbGFybmVhdUBlZmZpY2lvcy5jb208L2E+PHNwYW4gY2xhc3M9IiI+PGJyPg0K
wqAgwqAgwqAgwqAgwqAgwqAgJmx0O21haWx0bzo8YSBocmVmPSJtYWlsdG86amVyZW1pZS5nYWxh
cm5lYXVAZWZmaWNpb3MuY29tIiB0YXJnZXQ9Il9ibGFuayI+amVyZW1pZS5nYWxhcm5lYXVAZWZm
aWNpb3MuY29tPC9hPiZndDsmZ3Q7Jmd0OyB3cm90ZTo8YnI+DQo8YnI+DQrCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBPbiBGcmksIERlYyA0LCAyMDE1IGF0IDExOjA2IFBNLCBB
cmF2aW5kIEhUPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgJmx0Ozxh
IGhyZWY9Im1haWx0bzphcmF2aW5kLmh0QGdtYWlsLmNvbSIgdGFyZ2V0PSJfYmxhbmsiPmFyYXZp
bmQuaHRAZ21haWwuY29tPC9hPjxicj48L3NwYW4+DQrCoCDCoCDCoCDCoCDCoCDCoCAmbHQ7bWFp
bHRvOjxhIGhyZWY9Im1haWx0bzphcmF2aW5kLmh0QGdtYWlsLmNvbSIgdGFyZ2V0PSJfYmxhbmsi
PmFyYXZpbmQuaHRAZ21haWwuY29tPC9hPiZndDsgJmx0O21haWx0bzo8YSBocmVmPSJtYWlsdG86
YXJhdmluZC5odEBnbWFpbC5jb20iIHRhcmdldD0iX2JsYW5rIj5hcmF2aW5kLmh0QGdtYWlsLmNv
bTwvYT48ZGl2PjxkaXYgY2xhc3M9Img1Ij48YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCAmbHQ7bWFp
bHRvOjxhIGhyZWY9Im1haWx0bzphcmF2aW5kLmh0QGdtYWlsLmNvbSIgdGFyZ2V0PSJfYmxhbmsi
PmFyYXZpbmQuaHRAZ21haWwuY29tPC9hPiZndDsmZ3Q7Jmd0OyB3cm90ZTo8YnI+DQrCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAmZ3Q7IEkgYW0gdXNpbmcgMi42LjAgLkkgd2ls
bCB0cnkgdG8gc2hhcmUgdGhlPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgY29kZSB0aGF0IEkmIzM5
O208YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB1c2luZyBoZXJlIGlu
IHNvbWU8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAmZ3Q7IHRpbWUu
IElmIHRoZXJlIGFyZSBhbnkgc3BlY2lmaWMgZml4ZXMgdGhhdDxicj4NCsKgIMKgIMKgIMKgIMKg
IMKgIGFyZSByZWxldmFudDxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IHRvIHRoaXMgaXNzdWUsIHNlZTxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgICZndDsgaWYgeW91IGNhbiBwcm92aWRlIGEgbGluayB0byB0aGVtLiBJIHdvdWxkPGJyPg0K
wqAgwqAgwqAgwqAgwqAgwqAgaWRlYWxseSBsaWtlPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgdG8gdHJ5IHRoZW0gb3V0PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgJmd0OyBiZWZvcmUgdHJ5aW5nIGEgZnVsbCB1cGdyYWRlIHRvIHRoZSBs
YXRlc3Q8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCB2ZXJzaW9ucy48YnI+DQo8YnI+DQrCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBIaSw8YnI+DQo8YnI+DQrCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBDYW4geW91IHByb3ZpZGUgbW9yZSBpbmZvcm1hdGlvbiBv
biB0aGU8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCBzeXN0ZW0/IFdoaWNoPGJyPg0KwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgZGlzdHJpYnV0aW9uLDxicj4NCsKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGFyY2hpdGVjdHVyZSwga2VybmVsIHZlcnNpb24/PGJy
Pg0KPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgVGhlIHZlcmJvc2Ug
c2Vzc2lvbmQgbG9ncyBtaWdodCBoZWxwIHBpbnBvaW50IGFueTxicj4NCsKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIHVuZXhwZWN0ZWQgYmVoYXZpb3VyPGJyPg0KwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgaGVyZSAoYXJlIGFsbCBhcHBsaWNhdGlvbnMgcmVn
aXN0ZXJpbmcgYXM8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCBleHBlY3RlZD8pLjxicj4NCjxicj4N
CsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIErDqXLDqW1pZTxicj4NCjxicj4N
CsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgICZndDs8YnI+DQrCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAmZ3Q7IE9uIEZyaSwgRGVjIDQsIDIwMTUgYXQgNjox
MSBQTSwgSsOpcsOpbWllPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgR2FsYXJuZWF1PGJyPg0KwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgJmd0OyAmbHQ7PGEgaHJlZj0ibWFpbHRv
OmplcmVtaWUuZ2FsYXJuZWF1QGVmZmljaW9zLmNvbSIgdGFyZ2V0PSJfYmxhbmsiPmplcmVtaWUu
Z2FsYXJuZWF1QGVmZmljaW9zLmNvbTwvYT48YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCAmbHQ7bWFp
bHRvOjxhIGhyZWY9Im1haWx0bzpqZXJlbWllLmdhbGFybmVhdUBlZmZpY2lvcy5jb20iIHRhcmdl
dD0iX2JsYW5rIj5qZXJlbWllLmdhbGFybmVhdUBlZmZpY2lvcy5jb208L2E+Jmd0Ozxicj48L2Rp
dj48L2Rpdj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgICZsdDttYWlsdG86
PGEgaHJlZj0ibWFpbHRvOmplcmVtaWUuZ2FsYXJuZWF1QGVmZmljaW9zLmNvbSIgdGFyZ2V0PSJf
YmxhbmsiPmplcmVtaWUuZ2FsYXJuZWF1QGVmZmljaW9zLmNvbTwvYT48c3BhbiBjbGFzcz0iIj48
YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCAmbHQ7bWFpbHRvOjxhIGhyZWY9Im1haWx0bzpqZXJlbWll
LmdhbGFybmVhdUBlZmZpY2lvcy5jb20iIHRhcmdldD0iX2JsYW5rIj5qZXJlbWllLmdhbGFybmVh
dUBlZmZpY2lvcy5jb208L2E+Jmd0OyZndDsmZ3Q7IHdyb3RlOjxicj4NCsKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgICZndDsmZ3Q7PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgJmd0OyZndDsgSGkgQXJhdmluZCw8YnI+DQrCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCAmZ3Q7Jmd0Ozxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgICZndDsmZ3Q7IENhbiYjMzk7dCBzYXkgSSBoYXZlIGxvb2tlZCBhdCBldmVy
eXRoaW5nIHlvdTxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIHNlbnQgeWV0LCBidXQ8YnI+DQrCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBhcyBhPGJyPg0KwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgJmd0OyZndDsgcHJlZW1wdGl2ZSBxdWVzdGlvbiwgd2hpY2gg
dmVyc2lvbiBhcmUgd2U8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCB0YWxraW5nIGFib3V0PGJyPg0K
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgaGVyZT8gMi42LjAgb3I8YnI+DQrC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAmZ3Q7Jmd0OyAyLjYuMT8gMi42LjEg
Y29udGFpbnMgYSBsb3Qgb2YgcmVsYXkgZGFlbW9uPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgZml4
ZXMuPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgJmd0OyZndDs8YnI+
DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAmZ3Q7Jmd0OyBUaGFua3MsPGJy
Pg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgJmd0OyZndDsgSsOpcsOpbWll
PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgJmd0OyZndDs8YnI+DQrC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAmZ3Q7Jmd0OyBPbiBUaHUsIERlYyAz
LCAyMDE1IGF0IDc6MDEgQU0sIEFyYXZpbmQgSFQ8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCAmbHQ7PGEgaHJlZj0ibWFpbHRvOmFyYXZpbmQuaHRAZ21haWwuY29tIiB0
YXJnZXQ9Il9ibGFuayI+YXJhdmluZC5odEBnbWFpbC5jb208L2E+PGJyPjwvc3Bhbj48ZGl2Pjxk
aXYgY2xhc3M9Img1Ij4NCsKgIMKgIMKgIMKgIMKgIMKgICZsdDttYWlsdG86PGEgaHJlZj0ibWFp
bHRvOmFyYXZpbmQuaHRAZ21haWwuY29tIiB0YXJnZXQ9Il9ibGFuayI+YXJhdmluZC5odEBnbWFp
bC5jb208L2E+Jmd0OyZndDsgd3JvdGU6PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgJmd0OyZndDsgJmd0OyBIaSw8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCAmZ3Q7Jmd0OyAmZ3Q7PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgJmd0OyZndDsgJmd0OyBJIGFtIHRyeWluZyB0byBvYnRhaW4gdGhlIHBlcmZvcm1h
bmNlPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgY2hhcmFjdGVyaXN0aWNzPGJyPg0KwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgb2YgbHR0bmcgd2l0aCB0aGU8YnI+DQrCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAmZ3Q7Jmd0OyAmZ3Q7IHVzZTxicj4NCsKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgICZndDsmZ3Q7ICZndDsgb2YgdGVzdCBhcHBs
aWNhdGlvbnMuIFRyYWNlcyBhcmUgYmVpbmc8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCBwcm9kdWNl
ZCBvbiBhPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgbG9jYWwgbm9k
ZSBhbmQ8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAmZ3Q7Jmd0OyAm
Z3Q7IGRlbGl2ZXJlZCB0byByZWxheWQgdGhhdCBpcyBydW5uaW5nIG9uIGE8YnI+DQrCoCDCoCDC
oCDCoCDCoCDCoCBzZXBhcmF0ZTxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIG5vZGUgZm9yIHN0b3JhZ2UuPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgJmd0OyZndDsgJmd0Ozxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgICZndDsmZ3Q7ICZndDsgQW4gbHR0bmcgc2Vzc2lvbiB3aXRoIHRoZSB0ZXN0PGJyPg0KwqAg
wqAgwqAgwqAgwqAgwqAgYXBwbGljYXRpb25zIHByb2R1Y2luZzxicj4NCsKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIGFuIGluaXRpYWwgYml0PGJyPg0KwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgJmd0OyZndDsgJmd0OyByYXRlIG9mPGJyPg0KwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgJmd0OyZndDsgJmd0OyAxMCBrYi9zIGlzIHN0YXJ0
ZWQgYW5kIHJ1biBmb3IgYWJvdXQgMzA8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCBzZWNvbmRzLiBU
aGU8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBzdGFydGluZyBzdWIt
YnVmZmVyPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgJmd0OyZndDsg
Jmd0OyBzaXplIGlzIGtlcHQgYXQgMTI4IGtiIGFuZCBzdWItYnVmIGNvdW50PGJyPg0KwqAgwqAg
wqAgwqAgwqAgwqAgYXQgNC4gVGhlPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgc2Vzc2lvbiBpcyB0aGVuPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgJmd0OyZndDsgJmd0OyBzdG9wcGVkPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgJmd0OyZndDsgJmd0OyBhbmQgZGVzdHJveWVkIGFuZCB0cmFjZXMgYXJlIGFu
YWx5emVkIHRvPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgc2VlIGlmIHRoZXJlPGJyPg0KwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgYXJlIGFueSBkcm9wcy48YnI+DQrCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAmZ3Q7Jmd0OyAmZ3Q7IFRoaXMgaXM8YnI+DQrC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAmZ3Q7Jmd0OyAmZ3Q7IGJlaW5nIGRv
bmUgaW4gYSBsb29wIHdpdGggZXZlcnk8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCBzdWJzZXF1ZW50
IHNlc3Npb248YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBoYXZpbmcg
YW4gaW5jcmVtZW50PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgJmd0
OyZndDsgJmd0OyBvZiAyPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
Jmd0OyZndDsgJmd0OyBrYi9zIGFzIGxvbmcgYXMgdGhlcmUgYXJlIG5vIGRyb3BzLiBJZjxicj4N
CsKgIMKgIMKgIMKgIMKgIMKgIHRoZXJlIGFyZTxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIGRyb3BzLCBJIGluY3JlYXNlIHRoZTxicj4NCsKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgICZndDsmZ3Q7ICZndDsgYnVmZmVyIHNpemUgYnkgYSBmYWN0b3Ig
b2YgeDIgd2l0aG91dDxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIGluY3JlbWVudGluZzxicj4NCsKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHRoZSBiaXQgcmF0ZS48YnI+DQrCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAmZ3Q7Jmd0OyAmZ3Q7PGJyPg0KwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgJmd0OyZndDsgJmd0OyBJIHNlZSB0cmFjZSBk
cm9wcyBoYXBwZW5pbmcgY29uc2lzdGVudGx5PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgd2l0aCB0
ZXN0PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgYXBwcyBwcm9kdWNp
bmcgdHJhY2VzPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgJmd0OyZn
dDsgJmd0OyBhdDxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgICZndDsm
Z3Q7ICZndDsgbGVzcyB0aGFuIDQwIGtiL3MsIGl0IGRvZXNudCBzZWVtIHRvIGhlbHA8YnI+DQrC
oCDCoCDCoCDCoCDCoCDCoCBldmVuIGlmIEk8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCBzdGFydGVkIHdpdGggMW1iIHggNDxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgICZndDsmZ3Q7ICZndDsgc3ViLWJ1ZmZlcnMuPGJyPg0KwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgJmd0OyZndDsgJmd0Ozxicj4NCsKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgICZndDsmZ3Q7ICZndDsgQW5hbHlzaXMgOjxicj4NCsKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgICZndDsmZ3Q7ICZndDs8YnI+DQrCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAmZ3Q7Jmd0OyAmZ3Q7IEkgaGF2ZSBhdHRh
Y2hlZCB0aGUgbHR0bmdfcmVsYXlkICw8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCBsdHRuZ19jb25z
dW1lcmRfNjQ8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBsb2dzIGFu
ZCB0aGU8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAmZ3Q7Jmd0OyAm
Z3Q7IGVudGlyZTxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgICZndDsm
Z3Q7ICZndDsgdHJhY2UgZGlyZWN0b3J5LCBob3BlIHlvdSB3aWxsIGJlIGFibGUgdG88YnI+DQrC
oCDCoCDCoCDCoCDCoCDCoCB2aWV3IGl0Ljxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgICZndDsmZ3Q7ICZndDsgSSBoYXZlIG1vZGlmaWVkIGx0dG5nX3JlbGF5ZCBjb2Rl
IHRvIGR1bXA8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCB0aGUgdHJhY2VzPGJyPg0KwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgYmVpbmcgY2FwdHVyZWQgaW48YnI+DQrCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAmZ3Q7Jmd0OyAmZ3Q7IHRoZTxicj4NCsKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgICZndDsmZ3Q7ICZndDsgbHR0bmdfcmVsYXlk
IGxvZ3MgYWxvbmcgd2l0aCBkZWJ1ZyBpbmZvLjxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgICZndDsmZ3Q7ICZndDs8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCAmZ3Q7Jmd0OyAmZ3Q7IEVhY2ggdGVzdCBhcHAgaXMgcHJvZHVjaW5nIGxvZ3Mg
aW4gdGhlPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgZm9ybSBvZsKgIDo8YnI+DQrCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAmZ3Q7Jmd0OyAmZ3Q7ICZxdW90O1RyYWNlQXBwIFBJ
RCAtIDMxOTQwIFRISUQgLSAzMTk3MDxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIEB0aHJlYWRSYXRl
IC0gMTAzMjxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGIvcyBhcHBS
YXRlIC0gMjA3OTxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgICZndDsm
Z3Q7ICZndDsgYi9zPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgJmd0
OyZndDsgJmd0OyB0aHJlYWRUcmFjZU51bSAtIDkgYXBwVHJhY2VOdW0gLSAxOMKgIMKgIMKgIMKg
IMKgIMKgIMKgc2xlZXBUaW1lIC0gMTkyMTIwJnF1b3Q7PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgJmd0OyZndDsgJmd0Ozxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgICZndDsmZ3Q7ICZndDsgVGhlIHRlc3QgYXBwbGljYXRpb24gUElELCB0
ZXN0PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgYXBwbGljYXRpb24gdGhyZWFkIGlkLDxicj4NCsKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHRocmVhZCBiaXQgcmF0ZSw8YnI+DQrC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAmZ3Q7Jmd0OyAmZ3Q7IHRlc3Q8YnI+
DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAmZ3Q7Jmd0OyAmZ3Q7IGFwcCBi
aXQgcmF0ZSwgdGhyZWFkIHRyYWNlIG51bWJlciBhbmQ8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCBh
cHBsaWNhdGlvbjxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHRyYWNl
IG51bWJlciBzIGFyZTxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgICZn
dDsmZ3Q7ICZndDsgcGFydCBvZjxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgICZndDsmZ3Q7ICZndDsgdGhlIHRyYWNlLiBTbyBpbiB0aGUgYWJvdmUgdHJhY2UsIHRoZTxi
cj4NCsKgIMKgIMKgIMKgIMKgIMKgIHRocmVhZCBpczxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIHByb2R1Y2luZyBhdCAxIGtiL3MgYW5kPGJyPg0KwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgJmd0OyZndDsgJmd0OyB0aGU8YnI+DQrCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAmZ3Q7Jmd0OyAmZ3Q7IHdob2xlIHRlc3QgYXBwIGlz
IHByb2R1Y2luZyBhdCAyIGtiL3MuPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgJmd0OyZndDsgJmd0Ozxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgICZndDsmZ3Q7ICZndDsgSWYgd2UgbG9vayBhdCB0aGUgYmFiZWx0cmFjZSBvdXQgcHV0LCB3
ZTxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIHNlZSB0aGF0IHRoZTxicj4NCsKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIFRyYWNlIHdpdGg8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCAmZ3Q7Jmd0OyAmZ3Q7IFRyYWNlQXBwPGJyPg0KwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgJmd0OyZndDsgJmd0OyBQSUQgLSAzMTk0MCBhcHBUcmFj
ZU51bSAyIGlzIG1pc3NpbmcgLDxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIHdpdGggMSwgMywgNCw8
YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCA1IGFuZCBzbyBvbiBiZWlu
Zzxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgICZndDsmZ3Q7ICZndDsg
c3VjY2Vzc2Z1bGx5IGNhcHR1cmVkLjxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgICZndDsmZ3Q7ICZndDsgSSBsb29rZWQgYXQgdGhlIGx0dG5nX3JlbGF5ZCBsb2dzIGFu
ZDxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIGZvdW5kIHRoYXQ8YnI+DQrCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCB0cmFjZSBvZiAmcXVvdDthcHBUcmFjZU51bTxicj4NCsKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgICZndDsmZ3Q7ICZndDsgMiZxdW90OyBpczxi
cj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgICZndDsmZ3Q7ICZndDsgbm90
IGRlbGl2ZXJlZC9nZW5lcmF0ZWQgYnkgdGhlIGNvbnN1bWVyZDxicj4NCsKgIMKgIMKgIMKgIMKg
IMKgIHRvIHRoZTxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHJlbGF5
ZCBpbiBzZXF1ZW5jZSB3aXRoPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgJmd0OyZndDsgJmd0OyBvdGhlciB0cmFjZXMuIFRvIHJ1bGUgb3V0IHRoYXQgdGhpcyBpczxi
cj4NCsKgIMKgIMKgIMKgIMKgIMKgIG5vdCBhIHRlc3Q8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCBhcHBsaWNhdGlvbiBwcm9ibGVtLDxicj4NCsKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgICZndDsmZ3Q7ICZndDsgeW91PGJyPg0KwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgJmd0OyZndDsgJmd0OyBjYW4gbG9vayBhdCBsaW5lIGx0
dHRuZ19yZWxheWQgbG9nIDo8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCAxMjc3OCBhbmQgc2VlPGJy
Pg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgdHJhY2VzIGZyb208YnI+DQrC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAmZ3Q7Jmd0OyAmZ3Q7IGFwcFRyYWNl
TnVtIC08YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAmZ3Q7Jmd0OyAm
Z3Q7IDEgdG8gYXBwVHJhY2VOdW0gLSAxOCBpbmNsdWRpbmcgdGhlPGJyPg0KwqAgwqAgwqAgwqAg
wqAgwqAgYXBwVHJhY2VOdW0gMiBhcmU8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCAmcXVvdDtyZS1kZWxpdmVyZWQmcXVvdDsgYnk8YnI+DQrCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCAmZ3Q7Jmd0OyAmZ3Q7IHRoZTxicj4NCsKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgICZndDsmZ3Q7ICZndDsgY29uc3VtZXJkIHRvIHRoZSByZWxh
eWQuPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgJmd0OyZndDsgJmd0
OyBFc3NlbnRpYWxseSwgSSBzZWUgYXBwVHJhY2VOdW0gMSB0aHJvdWdoPGJyPg0KwqAgwqAgwqAg
wqAgwqAgwqAgYXBwVHJhY2VOdW08YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCAxOCBiZWluZyBkZWxpdmVyZWQ8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCAmZ3Q7Jmd0OyAmZ3Q7IHR3aWNlLCBvbmNlIGluZGl2aWR1YWxseSB3aGVyZTxicj4N
CsKgIMKgIMKgIMKgIMKgIMKgIGFwcFRyYWNlTnVtIDIgaXM8YnI+DQrCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCBtaXNzaW5nIGFuZCBvbmNlIGFzIGE8YnI+DQrCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAmZ3Q7Jmd0OyAmZ3Q7IGdyb3VwPGJyPg0KwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgJmd0OyZndDsgJmd0OyBhdCBsaW5lIDEyNzc4
IHdoZXJlIGl0cyBwcmVzZW50Ljxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgICZndDsmZ3Q7ICZndDs8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCAmZ3Q7Jmd0OyAmZ3Q7PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
Jmd0OyZndDsgJmd0OyBSZXF1ZXN0IGhlbHAgd2l0aDxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgICZndDsmZ3Q7ICZndDsgMS4gd2h5IHRyYWNlcyBhcmUgZGVsaXZlcmVk
IHR3aWNlLCBpcyBpdDxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIGJ5IGRlc2lnbiBvcjxicj4NCsKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGEgZ2VudWluZSBwcm9ibGVtPGJyPg0K
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgJmd0OyZndDsgJmd0OyA/PGJyPg0K
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgJmd0OyZndDsgJmd0OyAyLiBob3cg
dG8gYXZvaWQgdHJhY2VzIGJlaW5nIGRyb3BwZWQgZXZlbjxicj4NCsKgIMKgIMKgIMKgIMKgIMKg
IHRob3VnaDxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGJ1ZmZlcnMg
YXJlPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgJmd0OyZndDsgJmd0
OyBzdWZmaWNpZW50bHk8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAm
Z3Q7Jmd0OyAmZ3Q7IGxhcmdlIGVub3VnaCA/PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgJmd0OyZndDsgJmd0Ozxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgICZndDsmZ3Q7ICZndDs8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCAmZ3Q7Jmd0OyAmZ3Q7IFJlZ2FyZHMsPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgJmd0OyZndDsgJmd0OyBBcmF2aW5kLjxicj4NCsKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgICZndDsmZ3Q7ICZndDs8YnI+DQrCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCAmZ3Q7Jmd0OyAmZ3Q7PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAg
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX188YnI+DQrCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAmZ3Q7Jmd0OyAmZ3Q7IGx0dG5nLWRldiBt
YWlsaW5nIGxpc3Q8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAmZ3Q7
Jmd0OyAmZ3Q7IDxhIGhyZWY9Im1haWx0bzpsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnIiB0YXJn
ZXQ9Il9ibGFuayI+bHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZzwvYT48YnI+PC9kaXY+PC9kaXY+
PHNwYW4gY2xhc3M9IiI+DQrCoCDCoCDCoCDCoCDCoCDCoCAmbHQ7bWFpbHRvOjxhIGhyZWY9Im1h
aWx0bzpsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnIiB0YXJnZXQ9Il9ibGFuayI+bHR0bmctZGV2
QGxpc3RzLmx0dG5nLm9yZzwvYT4mZ3Q7PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgJmd0OyZndDsgJmd0Ozxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIDxhIGhyZWY9Imh0
dHA6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldiIg
cmVsPSJub3JlZmVycmVyIiB0YXJnZXQ9Il9ibGFuayI+aHR0cDovL2xpc3RzLmx0dG5nLm9yZy9j
Z2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2PC9hPjxicj4NCsKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgICZndDsmZ3Q7ICZndDs8YnI+DQrCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCAmZ3Q7Jmd0Ozxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgICZndDsmZ3Q7PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgJmd0OyZndDs8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAm
Z3Q7Jmd0OyAtLTxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgICZndDsm
Z3Q7IErDqXLDqW1pZSBHYWxhcm5lYXU8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCAmZ3Q7Jmd0OyBFZmZpY2lPUyBJbmMuPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgJmd0OyZndDsgPGEgaHJlZj0iaHR0cDovL3d3dy5lZmZpY2lvcy5jb20i
IHJlbD0ibm9yZWZlcnJlciIgdGFyZ2V0PSJfYmxhbmsiPmh0dHA6Ly93d3cuZWZmaWNpb3MuY29t
PC9hPjxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgICZndDs8YnI+DQrC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAmZ3Q7PGJyPg0KPGJyPg0KPGJyPg0K
PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgLS08YnI+DQrCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBKw6lyw6ltaWUgR2FsYXJuZWF1PGJyPg0KwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgRWZmaWNpT1MgSW5jLjxicj4NCsKgIMKg
IMKgIMKgIMKgIMKgIDxhIGhyZWY9Imh0dHA6Ly93d3cuZWZmaWNpb3MuY29tIiByZWw9Im5vcmVm
ZXJyZXIiIHRhcmdldD0iX2JsYW5rIj5odHRwOi8vd3d3LmVmZmljaW9zLmNvbTwvYT48YnI+DQo8
YnI+DQo8YnI+DQo8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCBfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXzxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIGx0dG5nLWRldiBtYWlsaW5nIGxpc3Q8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCA8YSBocmVm
PSJtYWlsdG86bHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZyIgdGFyZ2V0PSJfYmxhbmsiPmx0dG5n
LWRldkBsaXN0cy5sdHRuZy5vcmc8L2E+PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgJmx0O21haWx0
bzo8YSBocmVmPSJtYWlsdG86bHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZyIgdGFyZ2V0PSJfYmxh
bmsiPmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmc8L2E+Jmd0Ozxicj48L3NwYW4+DQrCoCDCoCDC
oCDCoCDCoCDCoCAmbHQ7bWFpbHRvOjxhIGhyZWY9Im1haWx0bzpsdHRuZy1kZXZAbGlzdHMubHR0
bmcub3JnIiB0YXJnZXQ9Il9ibGFuayI+bHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZzwvYT48c3Bh
biBjbGFzcz0iIj48YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCAmbHQ7bWFpbHRvOjxhIGhyZWY9Im1h
aWx0bzpsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnIiB0YXJnZXQ9Il9ibGFuayI+bHR0bmctZGV2
QGxpc3RzLmx0dG5nLm9yZzwvYT4mZ3Q7Jmd0Ozxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIDxhIGhy
ZWY9Imh0dHA6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5n
LWRldiIgcmVsPSJub3JlZmVycmVyIiB0YXJnZXQ9Il9ibGFuayI+aHR0cDovL2xpc3RzLmx0dG5n
Lm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2PC9hPjxicj4NCjxicj4NCjxi
cj4NCjxicj4NCjxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIC0twqAgwqAgwqBKb25hdGhh
biBSYWpvdHRlIEp1bGllbjxicj4NCjxicj4NCjxicj4NCjxicj4NCjxicj4NCsKgIMKgIMKgIMKg
IMKgIMKgIF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fPGJy
Pg0KwqAgwqAgwqAgwqAgwqAgwqAgbHR0bmctZGV2IG1haWxpbmcgbGlzdDxicj4NCsKgIMKgIMKg
IMKgIMKgIMKgIDxhIGhyZWY9Im1haWx0bzpsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnIiB0YXJn
ZXQ9Il9ibGFuayI+bHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZzwvYT4gJmx0O21haWx0bzo8YSBo
cmVmPSJtYWlsdG86bHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZyIgdGFyZ2V0PSJfYmxhbmsiPmx0
dG5nLWRldkBsaXN0cy5sdHRuZy5vcmc8L2E+Jmd0Ozxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIDxh
IGhyZWY9Imh0dHA6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0
dG5nLWRldiIgcmVsPSJub3JlZmVycmVyIiB0YXJnZXQ9Il9ibGFuayI+aHR0cDovL2xpc3RzLmx0
dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2PC9hPjxicj4NCjxicj4N
Cjxicj48L3NwYW4+DQrCoCDCoCDCoCDCoCAtLcKgIMKgIMKgIMKgIMKgSm9uYXRoYW4gUi4gSnVs
aWVuPGJyPg0KwqAgwqAgwqAgwqAgRWZmaWNpb3M8YnI+DQo8YnI+DQo8YnI+DQo8YnI+DQo8L2Js
b2NrcXVvdGU+PGRpdiBjbGFzcz0iIj48ZGl2IGNsYXNzPSJoNSI+DQo8YnI+DQotLSA8YnI+DQpK
b25hdGhhbiBSLiBKdWxpZW48YnI+DQpFZmZpY2lvczxicj4NCjxicj4NCjwvZGl2PjwvZGl2Pjwv
YmxvY2txdW90ZT48L2Rpdj48YnI+PC9kaXY+PC9kaXY+PC9kaXY+DQo=
--001a113f993ae9014e0526a3af73--


--===============0426025669==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0426025669==--
