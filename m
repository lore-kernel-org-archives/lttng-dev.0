From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Relayd trace drops
Date: Wed, 30 Dec 2015 02:05:38 +0000 (UTC)
Message-ID: <1521366980.305833.1451441138158.JavaMail.zimbra__30172.6132318892$1451441235$gmane$org@efficios.com>
References: <CACd+_b7qEeW1XD1H_0MT4dDqwLv68rfOURfNDRh6SO=xS4k-Og@mail.gmail.com>
 <CACd+_b46wkEH3jVOfz=SR2eS+ZXuWoL=f81ahNa4uwPNpWTHbw@mail.gmail.com>
 <566B0FEA.7040307@efficios.com>
 <CACd+_b6za+gk_fFhFapz-zRpwO8B31UX6+hMJxcjJsxrKVM5ow@mail.gmail.com>
 <1125287188.233739.1449873787684.JavaMail.zimbra@efficios.com>
 <CACd+_b7X3+Hzi5HYt3KggWMCVNPyhyDb4aK3-Pik98wcb70kCQ@mail.gmail.com>
 <654480294.257124.1450275539752.JavaMail.zimbra@efficios.com>
 <CACd+_b5cQ__Gqynic40iXw8UBpdd4cU9H2R=_HEqm_22LxApKw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1035773522=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1aE695-0000rm-9F
 for lttng-dev@lists.lttng.org; Tue, 29 Dec 2015 21:05:51 -0500
In-Reply-To: <CACd+_b5cQ__Gqynic40iXw8UBpdd4cU9H2R=_HEqm_22LxApKw@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Aravind HT <aravind.ht@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============1035773522==
Content-Type: multipart/alternative;
	boundary="----=_Part_305832_1687954410.1451441138156"

------=_Part_305832_1687954410.1451441138156
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Aravind,=20

You may want to have a look at this commit, which appears=20
in 2.6.1 too:=20

commit c585821bc78955b3d747fcd733aa1d2b81a3258e=20
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>=20
Date: Wed Aug 19 14:44:59 2015 -0700=20

Fix: sessiond vs consumerd push/get metadata deadlock=20

We need to unlock the registry while we push metadata to break a=20
circular dependency between the consumerd metadata lock and the sessiond=20
registry lock. Indeed, pushing metadata to the consumerd awaits that it=20
gets pushed all the way to relayd, but doing so requires grabbing the=20
metadata lock. If a concurrent metadata request is being performed by=20
consumerd, this can try to grab the registry lock on the sessiond while=20
holding the metadata lock on the consumer daemon. Those push and pull=20
schemes are performed on two different bidirectionnal communication=20
sockets.=20

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>=20
Signed-off-by: J=C3=A9r=C3=A9mie Galarneau <jeremie.galarneau@efficios.com>=
=20

Happy new year! By the way, everyone at EfficiOS is on vacation until Janua=
ry 4th=20
(that includes me). ;-)=20

Mathieu=20

----- On Dec 28, 2015, at 12:24 PM, Aravind HT <aravind.ht@gmail.com> wrote=
:=20

> Hi,
> Ive not had a chance to try it on 2.6.1 or 2.7.0 yet, will try and let yo=
u know.
> However, I was able to come up with a fix for 2.6.0 and I do not see any =
such
> changes on 2.6.1 or 2.7.0, so forwarding you the patch.

> diff -Naur ./src/bin/lttng-sessiond/ust-consumer.c
> /tmp/LTTNG_BKP_28_12_1/bin/lttng-sessiond/ust-consumer.c
> --- ./src/bin/lttng-sessiond/ust-consumer.c 2015-12-28 07:45:34.610430830=
 -0800
> +++ /tmp/LTTNG_BKP_28_12_1/bin/lttng-sessiond/ust-consumer.c 2015-12-28
> 07:58:18.906918555 -0800
> @@ -1,3 +1,4 @@
> +
> /*
> * Copyright (C) 2011 - David Goulet < david.goulet@polymtl.ca >
> *
> @@ -486,17 +487,48 @@
> ust_reg =3D reg_pid->registry->reg.ust;
> }
> assert(ust_reg);
> +/* ust_reg->lock can also have been taken from push_metadata making this
> metadata request
> +* wait without sending a response to the consumer which gets stuck on th=
e
> recv() call
> +* waiting for a response from sessiond. This metadata request from the c=
onsumer
> would
> +* have taken the stream->lock, do_sync_metadata() making the push_metada=
ta wait
> for the stream->lock to be
> +* released, making the sessiond thread pushing the metadata wait on the =
recv()
> for a
> +* response from the consumer, creating a deadlock. So to avoid this dead=
lock,
> making
> +* the request metadata flow to fail incase if sessiond is already pushin=
g
> metadata on
> +* its own. */
> + ret =3D pthread_mutex_trylock(&ust_reg->lock);
> + if(!ret) {
> + ret_push =3D ust_app_push_metadata(ust_reg, socket, 1);
> + pthread_mutex_unlock(&ust_reg->lock);
> + if (ret_push < 0) {
> + ERR("Error Pushing metadata");
> + /* -EPIPE error would be thrown if the appRegistry->metada_closed was s=
et,
> + * this could have happened if ust_app_unregister() was called when ther=
e
> + * was a problem with the sock ( epoll() ) from thread_manage_apps(). Th=
is
> + * would have made the current func return an error, upon which, the who=
le
> + * thread_manage_consumer would have been killed. To avoid this, send
> + * an error back to consumerd and continue buisness as usual */
> + if( ret_push =3D=3D -EPIPE ) {
> + DBG("app metadata was closed, so sending ERR msg to Consumerd\n");
> + memset(&msg, 0, sizeof(msg));
> + msg.cmd_type =3D LTTNG_ERR_UND;
> + (void) consumer_send_msg(socket, &msg);
> + ret =3D 0;
> + } else {
> + ret =3D -1;
> + }
> + } else {
> + DBG("UST Consumer metadata pushed successfully");
> + ret =3D 0;
> + }
> +
> + } else {
> + DBG(" ust_reg->lock is taken, cannot push metadata for this request at =
present
> \n");
> + memset(&msg, 0, sizeof(msg));
> + msg.cmd_type =3D LTTNG_ERR_UND;
> + (void) consumer_send_msg(socket, &msg);
> + ret =3D 0;
> - pthread_mutex_lock(&ust_reg->lock);
> - ret_push =3D ust_app_push_metadata(ust_reg, socket, 1);
> - pthread_mutex_unlock(&ust_reg->lock);
> - if (ret_push < 0) {
> - ERR("Pushing metadata");
> - ret =3D -1;
> - goto end;
> - }
> - DBG("UST Consumer metadata pushed successfully");
> - ret =3D 0;
> + }
> end:
> rcu_read_unlock();

> Regards,
> Aravind.

> On Wed, Dec 16, 2015 at 7:48 PM, Mathieu Desnoyers <
> mathieu.desnoyers@efficios.com > wrote:

>> ----- On Dec 16, 2015, at 8:02 AM, Aravind HT < aravind.ht@gmail.com > w=
rote:

>>> Hi Mathieu,
>>> Ive been able to analyze this sessiond - consumerd hang scenario and I =
see that
>>> the fix is not available on 2.6.1 or on 2.7.0.

>> Did you actually reproduce the issue with 2.6.1 or 2.7.0 ? Can we get th=
e
>> associated backtrace reproduced on those versions ?

>> Thanks,

>> Mathieu

>>> Root Cause :

>>> The hang is mainly caused because of a race condition for the
>>> consumer_metadata_socket between the following two flows of code
>>> Flow 1. do_sync_metadata() -> lttng_ustconsumer_sync_metadat() ->
>>> lttng_ustconsumer_request_metadata() -> lttncomm_recv_unix_sock() -> re=
cvmsg()

>>> and

>>> Flow 2. lttng_consumer_recv_cmd() -> lttng_ust_consumer_recv_cmd() ->
>>> lttng_ustconsumer_recv_metadata()

>>> Flow 1 above initiates a metadata requests and recvmsg()s for the reply=
 from
>>> sessiond on the consumer_metadata_socket ( it has taken the
>>> metadata_socket_lock and the stream->lock ) , but simultaneously this s=
ocket is
>>> being polled from Flow 2. Once in a while Flow 2 gets to receive while =
Flow 1
>>> just hangs on recvmsg() . Since Flow 1 has taken the stream->lock, this=
 then
>>> introduces a deadlock at a later stage (on_buffer_ready() when the meta=
data is
>>> being flushed. )

>>> Think using the metadata_socket_lock in Flow 2 before attempting to rec=
eive may
>>> address this issue, but is a bit complicated as the message would have =
already
>>> been received at the point of using that lock. The other alternative is=
 to
>>> remove the complete recv() from Flow 1 and let that be taken care by Fl=
ow 2.

>>> Please let me know if this has been fixed in the later builds, may be I=
 searched
>>> it wrong.

>>> Regards,
>>> Aravind.

>>> On Sat, Dec 12, 2015 at 4:13 AM, Mathieu Desnoyers <
>>> mathieu.desnoyers@efficios.com > wrote:

>>>> Hi,

>>>> Please upgrade to 2.6.1 or 2.7.0, those are old issues.

>>>> Thanks,

>>>> Mathieu

>>>> ----- On Dec 11, 2015, at 1:42 PM, Aravind HT < aravind.ht@gmail.com >=
 wrote:

>>>>> NPBS understand it, I will continue to investigate this, got a bit si=
de tracked
>>>>> with the sessiond hang issue that I mentioned earlier.
>>>>> Making some progress on that, will update as soon as I find the root =
cause, it
>>>>> looks like a mutex deadlock between
>>>>> the following threads in the consumerd daemon

>>>>> #1 0x0000000000410b5d in lttcomm_recv_unix_sock (sock=3D26,
>>>>> buf=3Dbuf@entry=3D0x7f16acca57f0, len=3Dlen@entry=3D4476) at unix.c:1=
75
>>>>> #2 0x000000000041dc96 in lttng_ustconsumer_request_metadata
>>>>> (ctx=3Dctx@entry=3D0x640d10, channel=3D0x7f16980192b0, timer=3Dtimer@=
entry=3D0,
>>>>> wait=3Dwait@entry=3D0) at ust-consumer.c:2331
>>>>> #3 0x000000000041ff3c in lttng_ustconsumer_sync_metadata
>>>>> (ctx=3Dctx@entry=3D0x640d10, metadata=3Dmetadata@entry=3D0x7f169801aa=
40) at
>>>>> ust-consumer.c:1829
>>>>> #4 0x000000000040eabf in do_sync_metadata (ctx=3D<optimized out>,
>>>>> metadata=3D<optimized out>) at consumer-stream.c:468
>>>>> #5 consumer_stream_sync_metadata (ctx=3Dctx@entry=3D0x640d10, session=
_id=3D8) at
>>>>> consumer-stream.c:545
>>>>> #6 0x000000000041d316 in lttng_ustconsumer_read_subbuffer
>>>>> (stream=3Dstream@entry=3D0x7f1698018fa0, ctx=3Dctx@entry=3D0x640d10) =
at
>>>>> ust-consumer.c:2063
>>>>> #7 0x000000000040b613 in lttng_consumer_read_subbuffer (stream=3D0x7f=
1698018fa0,
>>>>> ctx=3D0x640d10) at consumer.c:3203
>>>>> #8 0x0000000000409608 in consumer_thread_data_poll (data=3D0x640d10) =
at
>>>>> consumer.c:2557
>>>>> #9 0x00007f16af6a6fe3 in start_thread (arg=3D0x7f16acca7700) at
>>>>> pthread_create.c:312
>>>>> #10 0x00007f16af3dcafd in clone () at
>>>>> ../sysdeps/unix/sysv/linux/x86_64/clone.S:111

>>>>> and

>>>>> consumer_thread_metadata_poll() calling lttng_consumer_read_subbuffer=
() /
>>>>> on_buffer_ready() calling pthread_mutex_lock(stream->lock) and then h=
anging

>>>>> This again can be reproduced by the same script, just running consecu=
tive
>>>>> sessions of short duration (<10 seconds) with traces getting captured=
 on a
>>>>> remote node.
>>>>> I hit this every time I run the script.

>>>>> Regards,
>>>>> Aravind.

>>>>> On Fri, Dec 11, 2015 at 11:33 PM, Jonathan Rajotte Julien <
>>>>> Jonathan.rajotte-julien@efficios.com > wrote:

>>>>>> Hi Aravind,

>>>>>> On 2015-12-11 12:16 PM, Aravind HT wrote:

>>>>>>> Hi,

>>>>>>> Did you get a chance to reproduce the problem with the scripts ? Le=
t me know if
>>>>>>> you need any help running it.

>>>>>> Time is a scarce resource unfortunately. But until I have the time t=
o look at it
>>>>>> you might want to investigate if you are able to reproduce it on
>>>>>> 2.6.1/2.7.0/master on 2 regular (x86_64, ubuntu/debian) VM this woul=
d really
>>>>>> help.

>>>>>> Cheers!

>>>>>>> Regards,
>>>>>>> Aravind.

>>>>>>> On Wed, Dec 9, 2015 at 3:04 PM, Aravind HT < aravind.ht@gmail.com <=
mailto:
>>>>>>> aravind.ht@gmail.com >> wrote:

>>>>>>> Sorry about that, not sure how it got missed.
>>>>>>> Here it is.

>>>>>>> # This needs a two node set up (1. local current node 2. remote nod=
e )
>>>>>>> # relayd runs on the current node where traces are captured from
>>>>>>> the remote node
>>>>>>> # remote node runs test applications which generate traces.
>>>>>>> # the launch_script_RN is executed on the current node and uses
>>>>>>> ssh to execute commands on the remote node. So this part may not
>>>>>>> work in every case and may prompt for a password.
>>>>>>> # if experiencing problems with ssh , kindly check
>>>>>>> http://serverfault.com/questions/241588/how-to-automate-ssh-login-w=
ith-password

>>>>>>> # =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D To R=
un =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
>>>>>>> launch_script_RN.py self_profile -c /tmp/configFile.txt

>>>>>>> # configFile.txt is the file which has configuration params that
>>>>>>> launchScript
>>>>>>> # needs to configure lttng sessions. Below is an explanation of
>>>>>>> the different options.
>>>>>>> # =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D configF=
ile.txt =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D

>>>>>>> [section1]
>>>>>>> # final out put file path
>>>>>>> OutputFile =3D /tmp/Final_report.txt
>>>>>>> # the remote node hostname on which test applications run and the
>>>>>>> test sessions will be created; this should be something that could
>>>>>>> be used with ssh. Traces will be transported from this node to the
>>>>>>> lttng_relayd running on the current node.
>>>>>>> Node =3D MY_REMOTE_NODE
>>>>>>> # Sub buffer size to start this with
>>>>>>> SubBufSize =3D 16k
>>>>>>> # Sub buffer count
>>>>>>> SubBufCount =3D 4
>>>>>>> # per uid buffer
>>>>>>> BufferScheme =3D --buffers-uid
>>>>>>> # yes
>>>>>>> EnableTracing =3D yes
>>>>>>> # Bit rate of the test applications. Comman seperated example "1,
>>>>>>> 3, 3, 50" sayss 4 test applications producing 1, 3, 3, and 50 Kb/s
>>>>>>> traces.
>>>>>>> # So with the below, we just start with 1 test application
>>>>>>> producing 10 kb/s
>>>>>>> TestApps =3D 10
>>>>>>> # session life time in seonds
>>>>>>> TestTime =3D 10
>>>>>>> # Max number of successive sessions to configure. if n then n-1
>>>>>>> sessions are run, ex MaxRun =3D 2 will run 1 session.
>>>>>>> MaxRun =3D 100

>>>>>>> # =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Plac=
e the following files under
>>>>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

>>>>>>> # /tmp on the remote node
>>>>>>> clean_RemNode_apps.sh
>>>>>>> report_lttng_script.sh

>>>>>>> # rest of the scripts under /usr/sbin on the current local node on
>>>>>>> which lttng_realyd runs
>>>>>>> # Define a trace point MY_TRACE to take a single string arg with
>>>>>>> LOG_TEST_APP_PROFILING as the provider, compile test lttng_testApp
>>>>>>> and place it under /usr/sbin of the remote host

>>>>>>> # in launch_script_RN.py change currentNodeIP to the IP address on
>>>>>>> which relayd is receiving, default ports are used.

>>>>>>> # lttng_relayd is started as
>>>>>>> /usr/bin/lttng-relayd -o /var/log/lttng-traces -d

>>>>>>> # lttng_sessiond is started as
>>>>>>> /usr/bin/lttng-sessiond --consumerd32-path
>>>>>>> /usr/lib/lttng/libexec/lttng-consumerd --consumerd32-libdir
>>>>>>> /usr/lib/ --consumerd64-path
>>>>>>> /usr/lib64/lttng/libexec/lttng-consumerd --consumerd64-libdir
>>>>>>> /usr/lib64/ -b --no-kernel

>>>>>>> Regards,
>>>>>>> Aravind.

>>>>>>> On Wed, Dec 9, 2015 at 12:57 AM, Jonathan Rajotte Julien
>>>>>>> < Jonathan.rajotte-julien@efficios.com
>>>>>>> <mailto: Jonathan.rajotte-julien@efficios.com >> wrote:

>>>>>>> Hi Aravind,

>>>>>>> There is no README in the archive you sent.

>>>>>>> Cheers

>>>>>>> On 2015-12-08 07:51 AM, Aravind HT wrote:

>>>>>>> Hi,

>>>>>>> I am trying to upgrade in parallel, but this issue may
>>>>>>> still be present after I upgrade or may be temporarily
>>>>>>> masked. So I need to find the root cause for this and then
>>>>>>> see if its available on the latest before committing to
>>>>>>> upgrade.

>>>>>>> There is another issue i'm hitting, the lttng list command
>>>>>>> hangs after lttng destroy session when running the profiling.

>>>>>>> I found that consumerd 64 goes into an infinite loop
>>>>>>> waiting to flush metadata in
>>>>>>> lttng_ustconsumer_recv_metadata() :: while
>>>>>>> (consumer_metadata_cache_flushed(channel, offset + len,
>>>>>>> timer)) .
>>>>>>> In consumer_metadata_cache,
>>>>>>> channel->metadata_stream->endpoint_status is
>>>>>>> CONSUMER_ENDPOINT_ACTIVE,
>>>>>>> metadata_stream->ust_metadata_pushed is 0 with offset
>>>>>>> having some value. This call always returns a 1 from the
>>>>>>> last else{} block resulting in an infinite loop. Upon
>>>>>>> searching the forum, I found the same issue being reported
>>>>>>> here :
>>>>>>> https://www.mail-archive.com/lttng-dev@lists.lttng.org/msg07982.htm=
l

>>>>>>> Regards,
>>>>>>> Aravind.

>>>>>>> On Tue, Dec 8, 2015 at 12:43 AM, Jonathan Rajotte
>>>>>>> < jonathan.r.julien@gmail.com
>>>>>>> <mailto: jonathan.r.julien@gmail.com >> wrote:

>>>>>>> Hi Aravind,

>>>>>>> Did you have the chance to upgrade to 2.6.1.If so
>>>>>>> where you able
>>>>>>> to reproduce?

>>>>>>> Cheers

>>>>>>> On Mon, Dec 7, 2015 at 1:07 PM, Aravind HT
>>>>>>> < aravind.ht@gmail.com <mailto: aravind.ht@gmail.com >>
>>>>>>> wrote:

>>>>>>> Hi,

>>>>>>> I have attached the complete profiling scripts
>>>>>>> here, its a bit
>>>>>>> shabby, im new to python.

>>>>>>> There is a README which has the details on how to
>>>>>>> execute it.
>>>>>>> Im using a Yocto 1.6 on x86_64 platforms on both
>>>>>>> the nodes.

>>>>>>> Running this script when there are other sessions
>>>>>>> running
>>>>>>> seems to reproduce this problem easily.
>>>>>>> Please try it and let me know if you have any issues
>>>>>>> reproducing the problem.

>>>>>>> Regards,
>>>>>>> Aravind.

>>>>>>> On Sat, Dec 5, 2015 at 5:23 PM, J=C3=A9r=C3=A9mie Galarneau
>>>>>>> < jeremie.galarneau@efficios.com
>>>>>>> <mailto: jeremie.galarneau@efficios.com >
>>>>>>> <mailto: jeremie.galarneau@efficios.com
>>>>>>> <mailto: jeremie.galarneau@efficios.com >>> wrote:

>>>>>>> On Fri, Dec 4, 2015 at 11:06 PM, Aravind HT
>>>>>>> < aravind.ht@gmail.com
>>>>>>> <mailto: aravind.ht@gmail.com > <mailto: aravind.ht@gmail.com

>>>>>>> <mailto: aravind.ht@gmail.com >>> wrote:
>>>>>>> > I am using 2.6.0 .I will try to share the
>>>>>>> code that I'm
>>>>>>> using here in some
>>>>>>> > time. If there are any specific fixes that
>>>>>>> are relevant
>>>>>>> to this issue, see
>>>>>>> > if you can provide a link to them. I would
>>>>>>> ideally like
>>>>>>> to try them out
>>>>>>> > before trying a full upgrade to the latest
>>>>>>> versions.

>>>>>>> Hi,

>>>>>>> Can you provide more information on the
>>>>>>> system? Which
>>>>>>> distribution,
>>>>>>> architecture, kernel version?

>>>>>>> The verbose sessiond logs might help pinpoint any
>>>>>>> unexpected behaviour
>>>>>>> here (are all applications registering as
>>>>>>> expected?).

>>>>>>> J=C3=A9r=C3=A9mie


>>>>>>> > On Fri, Dec 4, 2015 at 6:11 PM, J=C3=A9r=C3=A9mie
>>>>>>> Galarneau
>>>>>>> > < jeremie.galarneau@efficios.com
>>>>>>> <mailto: jeremie.galarneau@efficios.com >
>>>>>>> <mailto: jeremie.galarneau@efficios.com
>>>>>>> <mailto: jeremie.galarneau@efficios.com >>> wrote:

>>>>>>> >> Hi Aravind,

>>>>>>> >> Can't say I have looked at everything you
>>>>>>> sent yet, but
>>>>>>> as a
>>>>>>> >> preemptive question, which version are we
>>>>>>> talking about
>>>>>>> here? 2.6.0 or
>>>>>>> >> 2.6.1? 2.6.1 contains a lot of relay daemon
>>>>>>> fixes.

>>>>>>> >> Thanks,
>>>>>>> >> J=C3=A9r=C3=A9mie

>>>>>>> >> On Thu, Dec 3, 2015 at 7:01 AM, Aravind HT
>>>>>>> < aravind.ht@gmail.com
>>>>>>> <mailto: aravind.ht@gmail.com >> wrote:
>>>>>>> >> > Hi,

>>>>>>> >> > I am trying to obtain the performance
>>>>>>> characteristics
>>>>>>> of lttng with the
>>>>>>> >> > use
>>>>>>> >> > of test applications. Traces are being
>>>>>>> produced on a
>>>>>>> local node and
>>>>>>> >> > delivered to relayd that is running on a
>>>>>>> separate
>>>>>>> node for storage.

>>>>>>> >> > An lttng session with the test
>>>>>>> applications producing
>>>>>>> an initial bit
>>>>>>> >> > rate of
>>>>>>> >> > 10 kb/s is started and run for about 30
>>>>>>> seconds. The
>>>>>>> starting sub-buffer
>>>>>>> >> > size is kept at 128 kb and sub-buf count
>>>>>>> at 4. The
>>>>>>> session is then
>>>>>>> >> > stopped
>>>>>>> >> > and destroyed and traces are analyzed to
>>>>>>> see if there
>>>>>>> are any drops.
>>>>>>> >> > This is
>>>>>>> >> > being done in a loop with every
>>>>>>> subsequent session
>>>>>>> having an increment
>>>>>>> >> > of 2
>>>>>>> >> > kb/s as long as there are no drops. If
>>>>>>> there are
>>>>>>> drops, I increase the
>>>>>>> >> > buffer size by a factor of x2 without
>>>>>>> incrementing
>>>>>>> the bit rate.

>>>>>>> >> > I see trace drops happening consistently
>>>>>>> with test
>>>>>>> apps producing traces
>>>>>>> >> > at
>>>>>>> >> > less than 40 kb/s, it doesnt seem to help
>>>>>>> even if I
>>>>>>> started with 1mb x 4
>>>>>>> >> > sub-buffers.

>>>>>>> >> > Analysis :

>>>>>>> >> > I have attached the lttng_relayd ,
>>>>>>> lttng_consumerd_64
>>>>>>> logs and the
>>>>>>> >> > entire
>>>>>>> >> > trace directory, hope you will be able to
>>>>>>> view it.
>>>>>>> >> > I have modified lttng_relayd code to dump
>>>>>>> the traces
>>>>>>> being captured in
>>>>>>> >> > the
>>>>>>> >> > lttng_relayd logs along with debug info.

>>>>>>> >> > Each test app is producing logs in the
>>>>>>> form of :
>>>>>>> >> > "TraceApp PID - 31940 THID - 31970
>>>>>>> @threadRate - 1032
>>>>>>> b/s appRate - 2079
>>>>>>> >> > b/s
>>>>>>> >> > threadTraceNum - 9 appTraceNum - 18 sleepTime - 192120"

>>>>>>> >> > The test application PID, test
>>>>>>> application thread id,
>>>>>>> thread bit rate,
>>>>>>> >> > test
>>>>>>> >> > app bit rate, thread trace number and
>>>>>>> application
>>>>>>> trace number s are
>>>>>>> >> > part of
>>>>>>> >> > the trace. So in the above trace, the
>>>>>>> thread is
>>>>>>> producing at 1 kb/s and
>>>>>>> >> > the
>>>>>>> >> > whole test app is producing at 2 kb/s.

>>>>>>> >> > If we look at the babeltrace out put, we
>>>>>>> see that the
>>>>>>> Trace with
>>>>>>> >> > TraceApp
>>>>>>> >> > PID - 31940 appTraceNum 2 is missing ,
>>>>>>> with 1, 3, 4,
>>>>>>> 5 and so on being
>>>>>>> >> > successfully captured.
>>>>>>> >> > I looked at the lttng_relayd logs and
>>>>>>> found that
>>>>>>> trace of "appTraceNum
>>>>>>> >> > 2" is
>>>>>>> >> > not delivered/generated by the consumerd
>>>>>>> to the
>>>>>>> relayd in sequence with
>>>>>>> >> > other traces. To rule out that this is
>>>>>>> not a test
>>>>>>> application problem,
>>>>>>> >> > you
>>>>>>> >> > can look at line ltttng_relayd log :
>>>>>>> 12778 and see
>>>>>>> traces from
>>>>>>> >> > appTraceNum -
>>>>>>> >> > 1 to appTraceNum - 18 including the
>>>>>>> appTraceNum 2 are
>>>>>>> "re-delivered" by
>>>>>>> >> > the
>>>>>>> >> > consumerd to the relayd.
>>>>>>> >> > Essentially, I see appTraceNum 1 through
>>>>>>> appTraceNum
>>>>>>> 18 being delivered
>>>>>>> >> > twice, once individually where
>>>>>>> appTraceNum 2 is
>>>>>>> missing and once as a
>>>>>>> >> > group
>>>>>>> >> > at line 12778 where its present.


>>>>>>> >> > Request help with
>>>>>>> >> > 1. why traces are delivered twice, is it
>>>>>>> by design or
>>>>>>> a genuine problem
>>>>>>> >> > ?
>>>>>>> >> > 2. how to avoid traces being dropped even
>>>>>>> though
>>>>>>> buffers are
>>>>>>> >> > sufficiently
>>>>>>> >> > large enough ?


>>>>>>> >> > Regards,
>>>>>>> >> > Aravind.


>>>>>>> _______________________________________________
>>>>>>> >> > lttng-dev mailing list
>>>>>>> >> > lttng-dev@lists.lttng.org
>>>>>>> <mailto: lttng-dev@lists.lttng.org >

>>>>>>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev




>>>>>>> >> --
>>>>>>> >> J=C3=A9r=C3=A9mie Galarneau
>>>>>>> >> EfficiOS Inc.
>>>>>>> >> http://www.efficios.com



>>>>>>> --
>>>>>>> J=C3=A9r=C3=A9mie Galarneau
>>>>>>> EfficiOS Inc.
>>>>>>> http://www.efficios.com

>>>>>>> _______________________________________________
>>>>>>> lttng-dev mailing list
>>>>>>> lttng-dev@lists.lttng.org
>>>>>>> <mailto: lttng-dev@lists.lttng.org >
>>>>>>> <mailto: lttng-dev@lists.lttng.org
>>>>>>> <mailto: lttng-dev@lists.lttng.org >>
>>>>>>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

>>>>>>> -- Jonathan Rajotte Julien

>>>>>>> _______________________________________________
>>>>>>> lttng-dev mailing list
>>>>>>> lttng-dev@lists.lttng.org <mailto: lttng-dev@lists.lttng.org >
>>>>>>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

>>>>>>> -- Jonathan R. Julien
>>>>>>> Efficios

>>>>>> --
>>>>>> Jonathan R. Julien
>>>>>> Efficios

>>>>> _______________________________________________
>>>>> lttng-dev mailing list
>>>>> lttng-dev@lists.lttng.org
>>>>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

>>>> --
>>>> Mathieu Desnoyers
>>>> EfficiOS Inc.
>>>> http://www.efficios.com

>> --
>> Mathieu Desnoyers
>> EfficiOS Inc.
>> http://www.efficios.com

--=20
Mathieu Desnoyers=20
EfficiOS Inc.=20
http://www.efficios.com=20

------=_Part_305832_1687954410.1451441138156
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div>Hi Aravind,<br></div><div><br data-mce-bogu=
s=3D"1"></div><div>You may want to have a look at this commit, which appear=
s<br data-mce-bogus=3D"1"></div><div>in 2.6.1 too:<br data-mce-bogus=3D"1">=
</div><div><br data-mce-bogus=3D"1"></div><div>commit c585821bc78955b3d747f=
cd733aa1d2b81a3258e<br>Author: Mathieu Desnoyers &lt;mathieu.desnoyers@effi=
cios.com&gt;<br>Date:&nbsp;&nbsp; Wed Aug 19 14:44:59 2015 -0700<br><br>&nb=
sp;&nbsp;&nbsp; Fix: sessiond vs consumerd push/get metadata deadlock<br>&n=
bsp;&nbsp; &nbsp;<br>&nbsp;&nbsp;&nbsp; We need to unlock the registry whil=
e we push metadata to break a<br>&nbsp;&nbsp;&nbsp; circular dependency bet=
ween the consumerd metadata lock and the sessiond<br>&nbsp;&nbsp;&nbsp; reg=
istry lock. Indeed, pushing metadata to the consumerd awaits that it<br>&nb=
sp;&nbsp;&nbsp; gets pushed all the way to relayd, but doing so requires gr=
abbing the<br>&nbsp;&nbsp;&nbsp; metadata lock. If a concurrent metadata re=
quest is being performed by<br>&nbsp;&nbsp;&nbsp; consumerd, this can try t=
o grab the registry lock on the sessiond while<br>&nbsp;&nbsp;&nbsp; holdin=
g the metadata lock on the consumer daemon. Those push and pull<br>&nbsp;&n=
bsp;&nbsp; schemes are performed on two different bidirectionnal communicat=
ion<br>&nbsp;&nbsp;&nbsp; sockets.<br>&nbsp;&nbsp; &nbsp;<br>&nbsp;&nbsp;&n=
bsp; Signed-off-by: Mathieu Desnoyers &lt;mathieu.desnoyers@efficios.com&gt=
;<br>&nbsp;&nbsp;&nbsp; Signed-off-by: J=C3=A9r=C3=A9mie Galarneau &lt;jere=
mie.galarneau@efficios.com&gt;<br></div><div><br></div><div>Happy new year!=
 By the way, everyone at EfficiOS is on vacation until January 4th</div><di=
v>(that includes me). ;-)<br data-mce-bogus=3D"1"></div><div><br data-mce-b=
ogus=3D"1"></div><div>Mathieu<br data-mce-bogus=3D"1"></div><div><br data-m=
ce-bogus=3D"1"></div><span id=3D"zwchr" data-marker=3D"__DIVIDER__">----- O=
n Dec 28, 2015, at 12:24 PM, Aravind HT &lt;aravind.ht@gmail.com&gt; wrote:=
<br></span><div data-marker=3D"__QUOTED_TEXT__"><blockquote style=3D"border=
-left:2px solid #1010FF;margin-left:5px;padding-left:5px;color:#000;font-we=
ight:normal;font-style:normal;text-decoration:none;font-family:Helvetica,Ar=
ial,sans-serif;font-size:12pt;"><div dir=3D"ltr">Hi,<br><div>Ive not had a =
chance to try it on 2.6.1 or 2.7.0 yet, will try and let you know.</div><di=
v>However, I was able to come up with a fix for 2.6.0 and I do not see any =
such changes on 2.6.1 or 2.7.0, so forwarding you the patch.</div><div><br>=
<br><div>diff -Naur ./src/bin/lttng-sessiond/ust-consumer.c /tmp/LTTNG_BKP_=
28_12_1/bin/lttng-sessiond/ust-consumer.c</div><div>--- ./src/bin/lttng-ses=
siond/ust-consumer.c<span class=3D"" style=3D"white-space:pre">=09</span>20=
15-12-28 07:45:34.610430830 -0800</div><div>+++ /tmp/LTTNG_BKP_28_12_1/bin/=
lttng-sessiond/ust-consumer.c<span class=3D"" style=3D"white-space:pre">=09=
</span>2015-12-28 07:58:18.906918555 -0800</div><div>@@ -1,3 +1,4 @@</div><=
div>+</div><div>&nbsp;/*</div><div>&nbsp; * Copyright (C) 2011 - David Goul=
et &lt;<a href=3D"mailto:david.goulet@polymtl.ca" target=3D"_blank">david.g=
oulet@polymtl.ca</a>&gt;</div><div>&nbsp; *</div><div>@@ -486,17 +487,48 @@=
</div><div>&nbsp;<span class=3D"" style=3D"white-space:pre">=09=09</span>us=
t_reg =3D reg_pid-&gt;registry-&gt;reg.ust;</div><div>&nbsp;<span class=3D"=
" style=3D"white-space:pre">=09</span>}</div><div>&nbsp;<span class=3D"" st=
yle=3D"white-space:pre">=09</span>assert(ust_reg);</div><div>+/* ust_reg-&g=
t;lock can also have been taken from push_metadata making this metadata req=
uest</div><div>+* &nbsp;wait without sending a response to the consumer whi=
ch gets stuck on the recv() call&nbsp;</div><div>+* &nbsp;waiting for a res=
ponse from sessiond. This metadata request from the consumer would&nbsp;</d=
iv><div>+* &nbsp;have taken the stream-&gt;lock, do_sync_metadata() making =
the push_metadata wait for the stream-&gt;lock to be&nbsp;</div><div>+* &nb=
sp;released, making the sessiond thread pushing the metadata wait on the re=
cv() for a&nbsp;</div><div>+* &nbsp;response from the consumer, creating a =
deadlock. So to avoid this deadlock, making</div><div>+* &nbsp;the request =
metadata flow to fail incase if sessiond is already pushing metadata on&nbs=
p;</div><div>+* &nbsp;its own. */</div><div>+ &nbsp; &nbsp; &nbsp; &nbsp;re=
t =3D pthread_mutex_trylock(&amp;ust_reg-&gt;lock);</div><div>+ &nbsp; &nbs=
p; &nbsp; &nbsp;if(!ret) {</div><div>+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp;ret_push =3D ust_app_push_metadata(ust_reg, socket, 1);<=
/div><div>+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;pthread_=
mutex_unlock(&amp;ust_reg-&gt;lock);</div><div>+ &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp;if (ret_push &lt; 0) {</div><div>+<span class=
=3D"" style=3D"white-space:pre">=09=09=09</span>ERR("Error Pushing metadata=
");</div><div>+<span class=3D"" style=3D"white-space:pre">=09</span> &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;/* -EPIPE error would be t=
hrown if the appRegistry-&gt;metada_closed was set,</div><div>+<span class=
=3D"" style=3D"white-space:pre">=09</span> &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp;* &nbsp;this could have happened if ust_app_unregist=
er() was called when there</div><div>+<span class=3D"" style=3D"white-space=
:pre">=09</span> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;* &=
nbsp;was a problem with the sock ( epoll() ) from thread_manage_apps(). Thi=
s</div><div>+ &nbsp; &nbsp; &nbsp; &nbsp;<span class=3D"" style=3D"white-sp=
ace:pre">=09</span> &nbsp; &nbsp; &nbsp; &nbsp;* &nbsp;would have made the =
current func return an error, upon which, the whole</div><div>+<span class=
=3D"" style=3D"white-space:pre">=09</span> &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp;* &nbsp;thread_manage_consumer would have been kille=
d. To avoid this, send</div><div>+ &nbsp; &nbsp; &nbsp; &nbsp;<span class=
=3D"" style=3D"white-space:pre">=09</span> &nbsp; &nbsp; &nbsp; &nbsp;* &nb=
sp;an error back to consumerd and continue buisness as usual */</div><div>+=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<span class=3D"" st=
yle=3D"white-space:pre">=09</span>if( ret_push =3D=3D -EPIPE ) {</div><div>=
+ &nbsp; &nbsp; &nbsp; &nbsp;<span class=3D"" style=3D"white-space:pre">=09=
</span> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;DBG("app met=
adata was closed, so sending ERR msg to Consumerd\n");</div><div>+ &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<span class=3D"" style=3D"wh=
ite-space:pre">=09</span> &nbsp; &nbsp; &nbsp; &nbsp;memset(&amp;msg, 0, si=
zeof(msg));</div><div>+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp;<span class=3D"" style=3D"white-space:pre">=
=09</span>msg.cmd_type =3D LTTNG_ERR_UND;</div><div>+<span class=3D"" style=
=3D"white-space:pre">=09</span> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(void) consumer_send_msg(socket, &a=
mp;msg);</div><div>+ &nbsp; &nbsp; &nbsp; &nbsp;<span class=3D"" style=3D"w=
hite-space:pre">=09</span> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp;ret =3D 0;</div><div>+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp;<span class=3D"" style=3D"white-space:pre">=09</span>} else {</di=
v><div>+ &nbsp; &nbsp; &nbsp; &nbsp;<span class=3D"" style=3D"white-space:p=
re">=09</span> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;ret =
=3D -1;</div><div>+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
<span class=3D"" style=3D"white-space:pre">=09</span>}</div><div>+<span cla=
ss=3D"" style=3D"white-space:pre">=09</span> &nbsp; &nbsp; &nbsp; &nbsp;} e=
lse {</div><div>+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<s=
pan class=3D"" style=3D"white-space:pre">=09</span>DBG("UST Consumer metada=
ta pushed successfully");</div><div>+<span class=3D"" style=3D"white-space:=
pre">=09</span> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;ret =
=3D 0;</div><div>+ &nbsp; &nbsp; &nbsp; &nbsp;<span class=3D"" style=3D"whi=
te-space:pre">=09</span>}</div><div>+</div><div>+ &nbsp; &nbsp; &nbsp; &nbs=
p;} else {</div><div>+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp;DBG(" ust_reg-&gt;lock is taken, cannot push metadata for this request a=
t present \n");</div><div>+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp;memset(&amp;msg, 0, sizeof(msg));</div><div>+ &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;msg.cmd_type =3D LTTNG_ERR_UND;</div><div=
>+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(void) consumer_s=
end_msg(socket, &amp;msg);</div><div>+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp;ret =3D 0;</div><div>&nbsp;</div><div>-<span class=3D"" =
style=3D"white-space:pre">=09</span>pthread_mutex_lock(&amp;ust_reg-&gt;loc=
k);</div><div>-<span class=3D"" style=3D"white-space:pre">=09</span>ret_pus=
h =3D ust_app_push_metadata(ust_reg, socket, 1);</div><div>-<span class=3D"=
" style=3D"white-space:pre">=09</span>pthread_mutex_unlock(&amp;ust_reg-&gt=
;lock);</div><div>-<span class=3D"" style=3D"white-space:pre">=09</span>if =
(ret_push &lt; 0) {</div><div>-<span class=3D"" style=3D"white-space:pre">=
=09=09</span>ERR("Pushing metadata");</div><div>-<span class=3D"" style=3D"=
white-space:pre">=09=09</span>ret =3D -1;</div><div>-<span class=3D"" style=
=3D"white-space:pre">=09=09</span>goto end;</div><div>-<span class=3D"" sty=
le=3D"white-space:pre">=09</span>}</div><div>-<span class=3D"" style=3D"whi=
te-space:pre">=09</span>DBG("UST Consumer metadata pushed successfully");</=
div><div>-<span class=3D"" style=3D"white-space:pre">=09</span>ret =3D 0;</=
div><div>+ &nbsp; &nbsp; &nbsp; &nbsp;}</div><div>&nbsp;</div><div>&nbsp;en=
d:</div><div>&nbsp;<span class=3D"" style=3D"white-space:pre">=09</span>rcu=
_read_unlock();</div></div><br><br><div>Regards,</div><div>Aravind.</div></=
div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Wed, Dec 1=
6, 2015 at 7:48 PM, Mathieu Desnoyers <span dir=3D"ltr">&lt;<a href=3D"mail=
to:mathieu.desnoyers@efficios.com" target=3D"_blank">mathieu.desnoyers@effi=
cios.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div><di=
v style=3D"font-family:arial,helvetica,sans-serif;font-size:12pt;color:#000=
000"><span class=3D""><br><span>----- On Dec 16, 2015, at 8:02 AM, Aravind =
HT &lt;<a href=3D"mailto:aravind.ht@gmail.com" target=3D"_blank">aravind.ht=
@gmail.com</a>&gt; wrote:<br></span></span><div><span class=3D""><blockquot=
e style=3D"border-left:2px solid #1010ff;margin-left:5px;padding-left:5px;c=
olor:#000;font-weight:normal;font-style:normal;text-decoration:none;font-fa=
mily:Helvetica,Arial,sans-serif;font-size:12pt"><div dir=3D"ltr">Hi Mathieu=
,<br><div>Ive been able to analyze this sessiond - consumerd hang scenario =
and I see that the fix is not available on 2.6.1 or on 2.7.0.</div></div></=
blockquote><br></span><div>Did you actually reproduce the issue with 2.6.1 =
or 2.7.0 ? Can we get the<br></div><div>associated backtrace reproduced on =
those versions ?<br></div><br><div>Thanks,<br></div><br><div>Mathieu<br></d=
iv><div><div class=3D"h5"><br><blockquote style=3D"border-left:2px solid #1=
010ff;margin-left:5px;padding-left:5px;color:#000;font-weight:normal;font-s=
tyle:normal;text-decoration:none;font-family:Helvetica,Arial,sans-serif;fon=
t-size:12pt"><div dir=3D"ltr"><br><div>Root Cause :</div><br><div>The hang =
is mainly caused because of a race condition for the consumer_metadata_sock=
et between the following two flows of code</div><div>Flow 1. do_sync_metada=
ta() -&gt; lttng_ustconsumer_sync_metadat() -&gt; lttng_ustconsumer_request=
_metadata() -&gt; lttncomm_recv_unix_sock() -&gt; recvmsg()</div><br><div>a=
nd</div><br><div>Flow 2. lttng_consumer_recv_cmd() -&gt; lttng_ust_consumer=
_recv_cmd() -&gt; lttng_ustconsumer_recv_metadata()</div><br><div>Flow 1 ab=
ove initiates a metadata requests and recvmsg()s for the reply from session=
d on the&nbsp;consumer_metadata_socket&nbsp;( it has taken the metadata_soc=
ket_lock and the stream-&gt;lock ) , but simultaneously this socket is bein=
g polled from Flow 2. Once in a while Flow 2 gets to receive while Flow 1 j=
ust hangs on recvmsg() . Since Flow 1 has taken the stream-&gt;lock, this t=
hen introduces a deadlock at a later stage (on_buffer_ready() when the meta=
data is being flushed. )</div><br><div>Think using the metadata_socket_lock=
 in Flow 2 before attempting to receive may address this issue, but is a bi=
t complicated as the message would have already been received at the point =
of using that lock. The other alternative is to remove the complete recv() =
from Flow 1 and let that be taken care by Flow 2.</div><br><div>Please let =
me know if this has been fixed in the later builds, may be I searched it wr=
ong.</div><br><br><div>Regards,</div><div>Aravind.</div></div><div class=3D=
"gmail_extra"><br><div class=3D"gmail_quote">On Sat, Dec 12, 2015 at 4:13 A=
M, Mathieu Desnoyers <span dir=3D"ltr">&lt;<a href=3D"mailto:mathieu.desnoy=
ers@efficios.com" target=3D"_blank">mathieu.desnoyers@efficios.com</a>&gt;<=
/span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8=
ex;border-left:1px #ccc solid;padding-left:1ex"><div><div style=3D"font-fam=
ily:arial,helvetica,sans-serif;font-size:12pt;color:#000000"><div>Hi,</div>=
<br><div>Please upgrade to 2.6.1 or 2.7.0, those are old issues.<br></div><=
br><div>Thanks,<br></div><br><div>Mathieu<br></div><div><div><br><br><div><=
span>----- On Dec 11, 2015, at 1:42 PM, Aravind HT &lt;<a href=3D"mailto:ar=
avind.ht@gmail.com" target=3D"_blank">aravind.ht@gmail.com</a>&gt; wrote:<b=
r></span></div></div></div><div><blockquote style=3D"border-left:2px solid =
#1010ff;margin-left:5px;padding-left:5px;color:#000;font-weight:normal;font=
-style:normal;text-decoration:none;font-family:Helvetica,Arial,sans-serif;f=
ont-size:12pt"><div><div><div dir=3D"ltr"><br>NPBS understand it, I will co=
ntinue to investigate this, got a bit side tracked with the sessiond hang i=
ssue that I mentioned earlier.&nbsp;<div>Making some progress on that, will=
 update as soon as I find the root cause, it looks like a mutex deadlock be=
tween&nbsp;<br></div><div><div>the following threads in the consumerd daemo=
n</div><br><div>#1 &nbsp;0x0000000000410b5d in lttcomm_recv_unix_sock (sock=
=3D26, buf=3Dbuf@entry=3D0x7f16acca57f0, len=3Dlen@entry=3D4476) at unix.c:=
175<div>#2 &nbsp;0x000000000041dc96 in lttng_ustconsumer_request_metadata (=
ctx=3Dctx@entry=3D0x640d10, channel=3D0x7f16980192b0, timer=3Dtimer@entry=
=3D0, wait=3Dwait@entry=3D0) at ust-consumer.c:2331</div><div>#3 &nbsp;0x00=
0000000041ff3c in lttng_ustconsumer_sync_metadata (ctx=3Dctx@entry=3D0x640d=
10, metadata=3Dmetadata@entry=3D0x7f169801aa40) at ust-consumer.c:1829</div=
><div>#4 &nbsp;0x000000000040eabf in do_sync_metadata (ctx=3D&lt;optimized =
out&gt;, metadata=3D&lt;optimized out&gt;) at consumer-stream.c:468</div><d=
iv>#5 &nbsp;consumer_stream_sync_metadata (ctx=3Dctx@entry=3D0x640d10, sess=
ion_id=3D8) at consumer-stream.c:545</div><div>#6 &nbsp;0x000000000041d316 =
in lttng_ustconsumer_read_subbuffer (stream=3Dstream@entry=3D0x7f1698018fa0=
, ctx=3Dctx@entry=3D0x640d10) at ust-consumer.c:2063</div><div>#7 &nbsp;0x0=
00000000040b613 in lttng_consumer_read_subbuffer (stream=3D0x7f1698018fa0, =
ctx=3D0x640d10) at consumer.c:3203</div><div>#8 &nbsp;0x0000000000409608 in=
 consumer_thread_data_poll (data=3D0x640d10) at consumer.c:2557</div><div>#=
9 &nbsp;0x00007f16af6a6fe3 in start_thread (arg=3D0x7f16acca7700) at pthrea=
d_create.c:312</div><div>#10 0x00007f16af3dcafd in clone () at ../sysdeps/u=
nix/sysv/linux/x86_64/clone.S:111</div></div></div><br><div>and&nbsp;</div>=
<br><div>consumer_thread_metadata_poll() calling lttng_consumer_read_subbuf=
fer() / on_buffer_ready() calling pthread_mutex_lock(stream-&gt;lock) and t=
hen hanging</div><div><br><br><div>This again can be reproduced by the same=
 script, just running consecutive sessions of short duration (&lt;10 second=
s) with traces getting captured on a remote node.</div><div>I hit this ever=
y time I run the script.</div><br><div>Regards,</div><div>Aravind.</div><br=
><div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra"><br><div c=
lass=3D"gmail_quote">On Fri, Dec 11, 2015 at 11:33 PM, Jonathan Rajotte Jul=
ien <span dir=3D"ltr">&lt;<a href=3D"mailto:Jonathan.rajotte-julien@efficio=
s.com" target=3D"_blank">Jonathan.rajotte-julien@efficios.com</a>&gt;</span=
> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left-width:1px;border-left-color:rgb(204,204,204);border-left-s=
tyle:solid;padding-left:1ex">Hi Aravind,<span><br>
<br>
On 2015-12-11 12:16 PM, Aravind HT wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;p=
adding-left:1ex">
Hi,<br><br>
Did you get a chance to reproduce the problem with the scripts ? Let me kno=
w if you need any help running it.<br></blockquote>
<br></span>
Time is a scarce resource unfortunately. But until I have the time to look =
at it you might want to investigate if you are able to reproduce it on 2.6.=
1/2.7.0/master on 2 regular (x86_64, ubuntu/debian) VM this would really he=
lp.<br><br>
Cheers!<br><br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left-width:1px;border-left-color:rgb(204,204,204);border-lef=
t-style:solid;padding-left:1ex"><br>
Regards,<br>
Aravind.<div><div><br><br>
On Wed, Dec 9, 2015 at 3:04 PM, Aravind HT &lt;<a href=3D"mailto:aravind.ht=
@gmail.com" target=3D"_blank">aravind.ht@gmail.com</a> &lt;mailto:<a href=
=3D"mailto:aravind.ht@gmail.com" target=3D"_blank">aravind.ht@gmail.com</a>=
&gt;&gt; wrote:<br><br>
&nbsp; &nbsp; Sorry about that, not sure how it got missed.<br>
&nbsp; &nbsp; Here it is.<br><br><br>
&nbsp; &nbsp; # This needs a two node set up (1. local current node 2. remo=
te node )<br>
&nbsp; &nbsp; # relayd runs on the current node where traces are captured f=
rom<br>
&nbsp; &nbsp; the remote node<br>
&nbsp; &nbsp; # remote node runs test applications which generate traces.<b=
r>
&nbsp; &nbsp; # the launch_script_RN is executed on the current node and us=
es<br>
&nbsp; &nbsp; ssh&nbsp; to execute commands on the remote node. So this par=
t may not<br>
&nbsp; &nbsp; work in every case and may prompt for a password.<br>
&nbsp; &nbsp; # if experiencing problems with ssh , kindly check<br><a href=
=3D"http://serverfault.com/questions/241588/how-to-automate-ssh-login-with-=
password" rel=3D"noreferrer" target=3D"_blank">http://serverfault.com/quest=
ions/241588/how-to-automate-ssh-login-with-password</a><br><br>
&nbsp; &nbsp; # =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D&nbsp; &nbsp; &nbsp; &nbsp;To Run&nbsp; =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
&nbsp; &nbsp; launch_script_RN.py self_profile -c /tmp/configFile.txt<br><b=
r><br><br>
&nbsp; &nbsp; # configFile.txt is the file which has configuration params t=
hat<br>
&nbsp; &nbsp; launchScript<br>
&nbsp; &nbsp; # needs to configure lttng sessions. Below is an explanation =
of<br>
&nbsp; &nbsp; the different options.<br>
&nbsp; &nbsp; # =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D&n=
bsp; &nbsp; &nbsp;configFile.txt =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br><br>
&nbsp; &nbsp; [section1]<br>
&nbsp; &nbsp; # final out put file path<br>
&nbsp; &nbsp; OutputFile =3D /tmp/Final_report.txt<br>
&nbsp; &nbsp; # the remote node hostname on which test applications run and=
 the<br>
&nbsp; &nbsp; test sessions will be created; this should be something that =
could<br>
&nbsp; &nbsp; be used with ssh. Traces will be transported from this node t=
o the<br>
&nbsp; &nbsp; lttng_relayd running on the current node.<br>
&nbsp; &nbsp; Node =3D MY_REMOTE_NODE<br>
&nbsp; &nbsp; # Sub buffer size to start this with<br>
&nbsp; &nbsp; SubBufSize =3D 16k<br>
&nbsp; &nbsp; # Sub buffer count<br>
&nbsp; &nbsp; SubBufCount =3D 4<br>
&nbsp; &nbsp; # per uid buffer<br>
&nbsp; &nbsp; BufferScheme =3D --buffers-uid<br>
&nbsp; &nbsp; # yes<br>
&nbsp; &nbsp; EnableTracing =3D yes<br>
&nbsp; &nbsp; # Bit rate of the test applications. Comman seperated example=
 "1,<br>
&nbsp; &nbsp; 3, 3, 50" sayss 4 test applications producing 1, 3, 3, and 50=
 Kb/s<br>
&nbsp; &nbsp; traces.<br>
&nbsp; &nbsp; # So with the below, we just start with 1 test application<br=
>
&nbsp; &nbsp; producing 10 kb/s<br>
&nbsp; &nbsp; TestApps =3D 10<br>
&nbsp; &nbsp; # session life time in seonds<br>
&nbsp; &nbsp; TestTime =3D 10<br>
&nbsp; &nbsp; # Max number of successive sessions to configure. if n then n=
-1<br>
&nbsp; &nbsp; sessions are run, ex MaxRun =3D 2 will run 1 session.<br>
&nbsp; &nbsp; MaxRun =3D 100<br><br><br>
&nbsp; &nbsp; # =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D&nbsp; Place the following files under<br>
&nbsp; &nbsp; =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br><br>
&nbsp; &nbsp; # /tmp on the remote node<br>
&nbsp; &nbsp; clean_RemNode_apps.sh<br>
&nbsp; &nbsp; report_lttng_script.sh<br><br>
&nbsp; &nbsp; # rest of the scripts under /usr/sbin on the current local no=
de on<br>
&nbsp; &nbsp; which lttng_realyd runs<br>
&nbsp; &nbsp; # Define a trace point MY_TRACE to take a single string arg w=
ith<br>
&nbsp; &nbsp; LOG_TEST_APP_PROFILING as the provider, compile test lttng_te=
stApp<br>
&nbsp; &nbsp; and place it under /usr/sbin of the remote host<br><br>
&nbsp; &nbsp; # in launch_script_RN.py change currentNodeIP to the IP addre=
ss on<br>
&nbsp; &nbsp; which relayd is receiving, default ports are used.<br><br>
&nbsp; &nbsp; # lttng_relayd is started as<br>
&nbsp; &nbsp; /usr/bin/lttng-relayd -o /var/log/lttng-traces -d<br><br>
&nbsp; &nbsp; # lttng_sessiond is started as<br>
&nbsp; &nbsp; /usr/bin/lttng-sessiond --consumerd32-path<br>
&nbsp; &nbsp; /usr/lib/lttng/libexec/lttng-consumerd --consumerd32-libdir<b=
r>
&nbsp; &nbsp; /usr/lib/ --consumerd64-path<br>
&nbsp; &nbsp; /usr/lib64/lttng/libexec/lttng-consumerd --consumerd64-libdir=
<br>
&nbsp; &nbsp; /usr/lib64/ -b --no-kernel<br><br><br><br><br>
&nbsp; &nbsp; Regards,<br>
&nbsp; &nbsp; Aravind.<br><br>
&nbsp; &nbsp; On Wed, Dec 9, 2015 at 12:57 AM, Jonathan Rajotte Julien<br>
&nbsp; &nbsp; &lt;<a href=3D"mailto:Jonathan.rajotte-julien@efficios.com" t=
arget=3D"_blank">Jonathan.rajotte-julien@efficios.com</a><br></div></div><d=
iv><div>
&nbsp; &nbsp; &lt;mailto:<a href=3D"mailto:Jonathan.rajotte-julien@efficios=
.com" target=3D"_blank">Jonathan.rajotte-julien@efficios.com</a>&gt;&gt; wr=
ote:<br><br>
&nbsp; &nbsp; &nbsp; &nbsp; Hi Aravind,<br><br>
&nbsp; &nbsp; &nbsp; &nbsp; There is no README in the archive you sent.<br>=
<br>
&nbsp; &nbsp; &nbsp; &nbsp; Cheers<br><br>
&nbsp; &nbsp; &nbsp; &nbsp; On 2015-12-08 07:51 AM, Aravind HT wrote:<br><b=
r>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Hi,<br><br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; I am trying to upgrade in paralle=
l, but this issue may<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; still be present after I upgrade =
or may be temporarily<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; masked. So I need to find the roo=
t cause for this and then<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; see if its available on the lates=
t before committing to<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; upgrade.<br><br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; There is another issue i'm hittin=
g, the lttng list command<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; hangs after lttng destroy session=
 when running the profiling.<br><br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; I found that consumerd 64 goes in=
to an infinite loop<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; waiting to flush metadata in<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; lttng_ustconsumer_recv_metadata()=
 :: while<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (consumer_metadata_cache_flushed(=
channel, offset + len,<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; timer)) .<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; In consumer_metadata_cache,<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; channel-&gt;metadata_stream-&gt;e=
ndpoint_status is<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; CONSUMER_ENDPOINT_ACTIVE,<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; metadata_stream-&gt;ust_metadata_=
pushed is 0 with offset<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; having some value. This call alwa=
ys returns a 1 from the<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; last else{} block resulting in an=
 infinite loop. Upon<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; searching the forum, I found the =
same issue being reported<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; here :<br><a href=3D"https://www.=
mail-archive.com/lttng-dev@lists.lttng.org/msg07982.html" rel=3D"noreferrer=
" target=3D"_blank">https://www.mail-archive.com/lttng-dev@lists.lttng.org/=
msg07982.html</a><br><br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Regards,<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Aravind.<br><br><br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; On Tue, Dec 8, 2015 at 12:43 AM, =
Jonathan Rajotte<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &lt;<a href=3D"mailto:jonathan.r.=
julien@gmail.com" target=3D"_blank">jonathan.r.julien@gmail.com</a><br></di=
v></div><span>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &lt;mailto:<a href=3D"mailto:jona=
than.r.julien@gmail.com" target=3D"_blank">jonathan.r.julien@gmail.com</a>&=
gt;&gt; wrote:<br>
<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Hi Aravind,<br>
<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Did you have the ch=
ance to upgrade to 2.6.1.If so<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; where you able<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; to reproduce?<br>
<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Cheers<br>
<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; On Mon, Dec 7, 2015=
 at 1:07 PM, Aravind HT<br></span>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &lt;<a href=3D"mailto:aravind.ht@=
gmail.com" target=3D"_blank">aravind.ht@gmail.com</a> &lt;mailto:<a href=3D=
"mailto:aravind.ht@gmail.com" target=3D"_blank">aravind.ht@gmail.com</a>&gt=
;&gt;<span><br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; wrote:<br>
<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Hi,<b=
r>
<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; I hav=
e attached the complete profiling scripts<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; here, its a bit<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; shabb=
y, im new to python.<br>
<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; There=
 is a README which has the details on how to<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; execute it.<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Im us=
ing a Yocto 1.6 on x86_64 platforms on both<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; the nodes.<br>
<br>
<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Runni=
ng this script when there are other sessions<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; running<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; seems=
 to reproduce this problem easily.<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Pleas=
e try it and let me know if you have any issues<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; repro=
ducing the problem.<br>
<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Regar=
ds,<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Aravi=
nd.<br>
<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; On Sa=
t, Dec 5, 2015 at 5:23 PM, J=C3=A9r=C3=A9mie Galarneau<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &lt;<=
a href=3D"mailto:jeremie.galarneau@efficios.com" target=3D"_blank">jeremie.=
galarneau@efficios.com</a><br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &lt;mailto:<a href=3D"mailto:jere=
mie.galarneau@efficios.com" target=3D"_blank">jeremie.galarneau@efficios.co=
m</a>&gt;<br></span>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &lt;m=
ailto:<a href=3D"mailto:jeremie.galarneau@efficios.com" target=3D"_blank">j=
eremie.galarneau@efficios.com</a><span><br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &lt;mailto:<a href=3D"mailto:jere=
mie.galarneau@efficios.com" target=3D"_blank">jeremie.galarneau@efficios.co=
m</a>&gt;&gt;&gt; wrote:<br>
<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; On Fri, Dec 4, 2015 at 11:06 PM, Aravind HT<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &lt;<a href=3D"mailto:aravind.ht@gmail.com" target=3D"_blank">arav=
ind.ht@gmail.com</a><br></span>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &lt;mailto:<a href=3D"mailto:arav=
ind.ht@gmail.com" target=3D"_blank">aravind.ht@gmail.com</a>&gt; &lt;mailto=
:<a href=3D"mailto:aravind.ht@gmail.com" target=3D"_blank">aravind.ht@gmail=
.com</a><div><div><br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &lt;mailto:<a href=3D"mailto:arav=
ind.ht@gmail.com" target=3D"_blank">aravind.ht@gmail.com</a>&gt;&gt;&gt; wr=
ote:<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &gt; I am using 2.6.0 .I will try to share the<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; code that I'm<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; using here in some<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &gt; time. If there are any specific fixes that<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; are relevant<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; to this issue, see<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &gt; if you can provide a link to them. I would<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ideally like<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; to try them out<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &gt; before trying a full upgrade to the latest<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; versions.<br><br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; Hi,<br><br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; Can you provide more information on the<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; system? Which<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; distribution,<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; architecture, kernel version?<br><br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; The verbose sessiond logs might help pinpoint any<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; unexpected behaviour<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; here (are all applications registering as<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; expected?).<br><br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; J=C3=A9r=C3=A9mie<br><br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &gt;<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &gt; On Fri, Dec 4, 2015 at 6:11 PM, J=C3=A9r=C3=A9mie<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Galarneau<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &gt; &lt;<a href=3D"mailto:jeremie.galarneau@efficios.com" target=
=3D"_blank">jeremie.galarneau@efficios.com</a><br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &lt;mailto:<a href=3D"mailto:jere=
mie.galarneau@efficios.com" target=3D"_blank">jeremie.galarneau@efficios.co=
m</a>&gt;<br></div></div>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &lt;mailto:<a href=3D"mailto:jeremie.galarneau@efficios.com" targe=
t=3D"_blank">jeremie.galarneau@efficios.com</a><span><br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &lt;mailto:<a href=3D"mailto:jere=
mie.galarneau@efficios.com" target=3D"_blank">jeremie.galarneau@efficios.co=
m</a>&gt;&gt;&gt; wrote:<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &gt;&gt;<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &gt;&gt; Hi Aravind,<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &gt;&gt;<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &gt;&gt; Can't say I have looked at everything you<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; sent yet, but<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; as a<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &gt;&gt; preemptive question, which version are we<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; talking about<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; here? 2.6.0 or<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &gt;&gt; 2.6.1? 2.6.1 contains a lot of relay daemon<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; fixes.<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &gt;&gt;<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &gt;&gt; Thanks,<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &gt;&gt; J=C3=A9r=C3=A9mie<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &gt;&gt;<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &gt;&gt; On Thu, Dec 3, 2015 at 7:01 AM, Aravind HT<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &lt;<a href=3D"mailto:aravind.ht@gmail.com" target=3D"_blank">arav=
ind.ht@gmail.com</a><br></span><div><div>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &lt;mailto:<a href=3D"mailto:arav=
ind.ht@gmail.com" target=3D"_blank">aravind.ht@gmail.com</a>&gt;&gt; wrote:=
<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &gt;&gt; &gt; Hi,<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &gt;&gt; &gt;<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &gt;&gt; &gt; I am trying to obtain the performance<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; characteristics<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; of lttng with the<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &gt;&gt; &gt; use<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &gt;&gt; &gt; of test applications. Traces are being<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; produced on a<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; local node and<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &gt;&gt; &gt; delivered to relayd that is running on a<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; separate<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; node for storage.<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &gt;&gt; &gt;<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &gt;&gt; &gt; An lttng session with the test<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; applications producing<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; an initial bit<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &gt;&gt; &gt; rate of<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &gt;&gt; &gt; 10 kb/s is started and run for about 30<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; seconds. The<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; starting sub-buffer<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &gt;&gt; &gt; size is kept at 128 kb and sub-buf count<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; at 4. The<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; session is then<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &gt;&gt; &gt; stopped<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &gt;&gt; &gt; and destroyed and traces are analyzed to<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; see if there<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; are any drops.<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &gt;&gt; &gt; This is<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &gt;&gt; &gt; being done in a loop with every<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; subsequent session<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; having an increment<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &gt;&gt; &gt; of 2<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &gt;&gt; &gt; kb/s as long as there are no drops. If<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; there are<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; drops, I increase the<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &gt;&gt; &gt; buffer size by a factor of x2 without<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; incrementing<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; the bit rate.<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &gt;&gt; &gt;<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &gt;&gt; &gt; I see trace drops happening consistently<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; with test<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; apps producing traces<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &gt;&gt; &gt; at<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &gt;&gt; &gt; less than 40 kb/s, it doesnt seem to help<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; even if I<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; started with 1mb x 4<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &gt;&gt; &gt; sub-buffers.<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &gt;&gt; &gt;<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &gt;&gt; &gt; Analysis :<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &gt;&gt; &gt;<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &gt;&gt; &gt; I have attached the lttng_relayd ,<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; lttng_consumerd_64<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; logs and the<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &gt;&gt; &gt; entire<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &gt;&gt; &gt; trace directory, hope you will be able to<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; view it.<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &gt;&gt; &gt; I have modified lttng_relayd code to dump<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; the traces<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; being captured in<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &gt;&gt; &gt; the<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &gt;&gt; &gt; lttng_relayd logs along with debug info.<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &gt;&gt; &gt;<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &gt;&gt; &gt; Each test app is producing logs in the<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; form of&nbsp; :<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &gt;&gt; &gt; "TraceApp PID - 31940 THID - 31970<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; @threadRate - 1032<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; b/s appRate - 2079<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &gt;&gt; &gt; b/s<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &gt;&gt; &gt; threadTraceNum - 9 appTraceNum - 18&nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp;sleepTime - 192120"<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &gt;&gt; &gt;<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &gt;&gt; &gt; The test application PID, test<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; application thread id,<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; thread bit rate,<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &gt;&gt; &gt; test<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &gt;&gt; &gt; app bit rate, thread trace number and<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; application<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; trace number s are<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &gt;&gt; &gt; part of<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &gt;&gt; &gt; the trace. So in the above trace, the<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; thread is<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; producing at 1 kb/s and<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &gt;&gt; &gt; the<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &gt;&gt; &gt; whole test app is producing at 2 kb/s.<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &gt;&gt; &gt;<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &gt;&gt; &gt; If we look at the babeltrace out put, we<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; see that the<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; Trace with<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &gt;&gt; &gt; TraceApp<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &gt;&gt; &gt; PID - 31940 appTraceNum 2 is missing ,<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; with 1, 3, 4,<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; 5 and so on being<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &gt;&gt; &gt; successfully captured.<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &gt;&gt; &gt; I looked at the lttng_relayd logs and<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; found that<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; trace of "appTraceNum<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &gt;&gt; &gt; 2" is<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &gt;&gt; &gt; not delivered/generated by the consumerd<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; to the<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; relayd in sequence with<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &gt;&gt; &gt; other traces. To rule out that this is<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; not a test<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; application problem,<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &gt;&gt; &gt; you<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &gt;&gt; &gt; can look at line ltttng_relayd log :<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 12778 and see<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; traces from<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &gt;&gt; &gt; appTraceNum -<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &gt;&gt; &gt; 1 to appTraceNum - 18 including the<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; appTraceNum 2 are<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; "re-delivered" by<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &gt;&gt; &gt; the<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &gt;&gt; &gt; consumerd to the relayd.<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &gt;&gt; &gt; Essentially, I see appTraceNum 1 through<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; appTraceNum<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; 18 being delivered<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &gt;&gt; &gt; twice, once individually where<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; appTraceNum 2 is<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; missing and once as a<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &gt;&gt; &gt; group<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &gt;&gt; &gt; at line 12778 where its present.<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &gt;&gt; &gt;<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &gt;&gt; &gt;<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &gt;&gt; &gt; Request help with<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &gt;&gt; &gt; 1. why traces are delivered twice, is it<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; by design or<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; a genuine problem<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &gt;&gt; &gt; ?<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &gt;&gt; &gt; 2. how to avoid traces being dropped even<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; though<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; buffers are<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &gt;&gt; &gt; sufficiently<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &gt;&gt; &gt; large enough ?<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &gt;&gt; &gt;<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &gt;&gt; &gt;<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &gt;&gt; &gt; Regards,<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &gt;&gt; &gt; Aravind.<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &gt;&gt; &gt;<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &gt;&gt; &gt;<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; _________________________________=
______________<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &gt;&gt; &gt; lttng-dev mailing list<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &gt;&gt; &gt; <a href=3D"mailto:lttng-dev@lists.lttng.org" target=
=3D"_blank">lttng-dev@lists.lttng.org</a><br></div></div><span>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &lt;mailto:<a href=3D"mailto:lttn=
g-dev@lists.lttng.org" target=3D"_blank">lttng-dev@lists.lttng.org</a>&gt;<=
br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &gt;&gt; &gt;<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <a href=3D"http://lists.lttng.org=
/cgi-bin/mailman/listinfo/lttng-dev" rel=3D"noreferrer" target=3D"_blank">h=
ttp://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a><br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &gt;&gt; &gt;<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &gt;&gt;<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &gt;&gt;<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &gt;&gt;<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &gt;&gt; --<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &gt;&gt; J=C3=A9r=C3=A9mie Galarneau<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &gt;&gt; EfficiOS Inc.<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &gt;&gt; <a href=3D"http://www.efficios.com" rel=3D"noreferrer" ta=
rget=3D"_blank">http://www.efficios.com</a><br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &gt;<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &gt;<br>
<br>
<br>
<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; --<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; J=C3=A9r=C3=A9mie Galarneau<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; EfficiOS Inc.<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <a href=3D"http://www.efficios.co=
m" rel=3D"noreferrer" target=3D"_blank">http://www.efficios.com</a><br>
<br>
<br>
<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; _________________________________=
______________<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; lttng=
-dev mailing list<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <a href=3D"mailto:lttng-dev@lists=
.lttng.org" target=3D"_blank">lttng-dev@lists.lttng.org</a><br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &lt;mailto:<a href=3D"mailto:lttn=
g-dev@lists.lttng.org" target=3D"_blank">lttng-dev@lists.lttng.org</a>&gt;<=
br></span>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &lt;mailto:<a href=3D"mailto:lttn=
g-dev@lists.lttng.org" target=3D"_blank">lttng-dev@lists.lttng.org</a><span=
><br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &lt;mailto:<a href=3D"mailto:lttn=
g-dev@lists.lttng.org" target=3D"_blank">lttng-dev@lists.lttng.org</a>&gt;&=
gt;<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <a href=3D"http://lists.lttng.org=
/cgi-bin/mailman/listinfo/lttng-dev" rel=3D"noreferrer" target=3D"_blank">h=
ttp://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a><br>
<br>
<br>
<br>
<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; --&nbsp; &nbsp; &nb=
sp;Jonathan Rajotte Julien<br>
<br>
<br>
<br>
<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; _________________________________=
______________<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; lttng-dev mailing list<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <a href=3D"mailto:lttng-dev@lists=
.lttng.org" target=3D"_blank">lttng-dev@lists.lttng.org</a> &lt;mailto:<a h=
ref=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-dev@lists.=
lttng.org</a>&gt;<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <a href=3D"http://lists.lttng.org=
/cgi-bin/mailman/listinfo/lttng-dev" rel=3D"noreferrer" target=3D"_blank">h=
ttp://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a><br>
<br>
<br></span>
&nbsp; &nbsp; &nbsp; &nbsp; --&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Jonathan R.=
 Julien<br>
&nbsp; &nbsp; &nbsp; &nbsp; Efficios<br><br><br><br></blockquote><div><div>=
<br>
-- <br>
Jonathan R. Julien<br>
Efficios<br><br></div></div></blockquote></div><br></div></div></div><br>__=
_____________________________________________<br>lttng-dev mailing list<br>=
<a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-dev@li=
sts.lttng.org</a><br></div></div><a href=3D"http://lists.lttng.org/cgi-bin/=
mailman/listinfo/lttng-dev" target=3D"_blank">http://lists.lttng.org/cgi-bi=
n/mailman/listinfo/lttng-dev</a><span><span style=3D"color:#888888"><br></s=
pan></span></blockquote></div><span><span style=3D"color:#888888"><br><div>=
-- <br></div><div>Mathieu Desnoyers<br>EfficiOS Inc.<br><a href=3D"http://w=
ww.efficios.com" target=3D"_blank">http://www.efficios.com</a><br></div></s=
pan></span></div></div></blockquote></div></div><br></blockquote></div></di=
v></div><div><div class=3D"h5"><br><div>-- <br></div><div>Mathieu Desnoyers=
<br>EfficiOS Inc.<br><a href=3D"http://www.efficios.com" target=3D"_blank">=
http://www.efficios.com</a><br data-mce-bogus=3D"1"></div></div></div></div=
></div></blockquote></div></div><br></blockquote></div><br><div data-marker=
=3D"__SIG_POST__">-- <br></div><div>Mathieu Desnoyers<br>EfficiOS Inc.<br>h=
ttp://www.efficios.com</div></div></body></html>
------=_Part_305832_1687954410.1451441138156--


--===============1035773522==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1035773522==--
