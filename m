From: Aravind HT <aravind.ht@gmail.com>
Subject: Re: Relayd trace drops
Date: Mon, 28 Dec 2015 22:54:47 +0530
Message-ID: <CACd+_b5cQ__Gqynic40iXw8UBpdd4cU9H2R=_HEqm_22LxApKw__48635.6279034682$1451323574$gmane$org@mail.gmail.com>
References: <CACd+_b7qEeW1XD1H_0MT4dDqwLv68rfOURfNDRh6SO=xS4k-Og@mail.gmail.com>
 <56672F33.3070808@efficios.com>
 <CACd+_b6xjN8BEcfqypkhGrM2XWwxhW9RmCVgHfN5jmksGmVnPw@mail.gmail.com>
 <CACd+_b46wkEH3jVOfz=SR2eS+ZXuWoL=f81ahNa4uwPNpWTHbw@mail.gmail.com>
 <566B0FEA.7040307@efficios.com>
 <CACd+_b6za+gk_fFhFapz-zRpwO8B31UX6+hMJxcjJsxrKVM5ow@mail.gmail.com>
 <1125287188.233739.1449873787684.JavaMail.zimbra@efficios.com>
 <CACd+_b7X3+Hzi5HYt3KggWMCVNPyhyDb4aK3-Pik98wcb70kCQ@mail.gmail.com>
 <654480294.257124.1450275539752.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0119609768=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <aravind.ht@gmail.com>) id 1aDbXR-0008CE-LO
 for lttng-dev@lists.lttng.org; Mon, 28 Dec 2015 12:24:58 -0500
Received: by mail-lb0-f174.google.com with SMTP id pv2so108579628lbb.1
 for <lttng-dev@lists.lttng.org>; Mon, 28 Dec 2015 09:24:53 -0800 (PST)
In-Reply-To: <654480294.257124.1450275539752.JavaMail.zimbra@efficios.com>
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

--===============0119609768==
Content-Type: multipart/alternative; boundary=089e0122976eed7a4e0527f8943d

--089e0122976eed7a4e0527f8943d
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

Ive not had a chance to try it on 2.6.1 or 2.7.0 yet, will try and let you
know.
However, I was able to come up with a fix for 2.6.0 and I do not see any
such changes on 2.6.1 or 2.7.0, so forwarding you the patch.


diff -Naur ./src/bin/lttng-sessiond/ust-consumer.c
/tmp/LTTNG_BKP_28_12_1/bin/lttng-sessiond/ust-consumer.c
--- ./src/bin/lttng-sessiond/ust-consumer.c 2015-12-28 07:45:34.610430830
-0800
+++ /tmp/LTTNG_BKP_28_12_1/bin/lttng-sessiond/ust-consumer.c 2015-12-28
07:58:18.906918555 -0800
@@ -1,3 +1,4 @@
+
 /*
  * Copyright (C) 2011 - David Goulet <david.goulet@polymtl.ca>
  *
@@ -486,17 +487,48 @@
  ust_reg =3D reg_pid->registry->reg.ust;
  }
  assert(ust_reg);
+/* ust_reg->lock can also have been taken from push_metadata making this
metadata request
+*  wait without sending a response to the consumer which gets stuck on the
recv() call
+*  waiting for a response from sessiond. This metadata request from the
consumer would
+*  have taken the stream->lock, do_sync_metadata() making the
push_metadata wait for the stream->lock to be
+*  released, making the sessiond thread pushing the metadata wait on the
recv() for a
+*  response from the consumer, creating a deadlock. So to avoid this
deadlock, making
+*  the request metadata flow to fail incase if sessiond is already pushing
metadata on
+*  its own. */
+        ret =3D pthread_mutex_trylock(&ust_reg->lock);
+        if(!ret) {
+                ret_push =3D ust_app_push_metadata(ust_reg, socket, 1);
+                pthread_mutex_unlock(&ust_reg->lock);
+                if (ret_push < 0) {
+ ERR("Error Pushing metadata");
+                /* -EPIPE error would be thrown if the
appRegistry->metada_closed was set,
+                *  this could have happened if ust_app_unregister() was
called when there
+                *  was a problem with the sock ( epoll() ) from
thread_manage_apps(). This
+                *  would have made the current func return an error, upon
which, the whole
+                *  thread_manage_consumer would have been killed. To avoid
this, send
+                *  an error back to consumerd and continue buisness as
usual */
+                 if( ret_push =3D=3D -EPIPE ) {
+                        DBG("app metadata was closed, so sending ERR msg
to Consumerd\n");
+                        memset(&msg, 0, sizeof(msg));
+                         msg.cmd_type =3D LTTNG_ERR_UND;
+                        (void) consumer_send_msg(socket, &msg);
+                        ret =3D 0;
+                 } else {
+                        ret =3D -1;
+                 }
+        } else {
+                 DBG("UST Consumer metadata pushed successfully");
+                ret =3D 0;
+         }
+
+        } else {
+                DBG(" ust_reg->lock is taken, cannot push metadata for
this request at present \n");
+                memset(&msg, 0, sizeof(msg));
+                msg.cmd_type =3D LTTNG_ERR_UND;
+                (void) consumer_send_msg(socket, &msg);
+                ret =3D 0;

- pthread_mutex_lock(&ust_reg->lock);
- ret_push =3D ust_app_push_metadata(ust_reg, socket, 1);
- pthread_mutex_unlock(&ust_reg->lock);
- if (ret_push < 0) {
- ERR("Pushing metadata");
- ret =3D -1;
- goto end;
- }
- DBG("UST Consumer metadata pushed successfully");
- ret =3D 0;
+        }

 end:
  rcu_read_unlock();


Regards,
Aravind.

On Wed, Dec 16, 2015 at 7:48 PM, Mathieu Desnoyers <
mathieu.desnoyers@efficios.com> wrote:

>
> ----- On Dec 16, 2015, at 8:02 AM, Aravind HT <aravind.ht@gmail.com>
> wrote:
>
> Hi Mathieu,
> Ive been able to analyze this sessiond - consumerd hang scenario and I se=
e
> that the fix is not available on 2.6.1 or on 2.7.0.
>
>
> Did you actually reproduce the issue with 2.6.1 or 2.7.0 ? Can we get the
> associated backtrace reproduced on those versions ?
>
> Thanks,
>
> Mathieu
>
>
> Root Cause :
>
> The hang is mainly caused because of a race condition for the
> consumer_metadata_socket between the following two flows of code
> Flow 1. do_sync_metadata() -> lttng_ustconsumer_sync_metadat() ->
> lttng_ustconsumer_request_metadata() -> lttncomm_recv_unix_sock() ->
> recvmsg()
>
> and
>
> Flow 2. lttng_consumer_recv_cmd() -> lttng_ust_consumer_recv_cmd() ->
> lttng_ustconsumer_recv_metadata()
>
> Flow 1 above initiates a metadata requests and recvmsg()s for the reply
> from sessiond on the consumer_metadata_socket ( it has taken the
> metadata_socket_lock and the stream->lock ) , but simultaneously this
> socket is being polled from Flow 2. Once in a while Flow 2 gets to receiv=
e
> while Flow 1 just hangs on recvmsg() . Since Flow 1 has taken the
> stream->lock, this then introduces a deadlock at a later stage
> (on_buffer_ready() when the metadata is being flushed. )
>
> Think using the metadata_socket_lock in Flow 2 before attempting to
> receive may address this issue, but is a bit complicated as the message
> would have already been received at the point of using that lock. The oth=
er
> alternative is to remove the complete recv() from Flow 1 and let that be
> taken care by Flow 2.
>
> Please let me know if this has been fixed in the later builds, may be I
> searched it wrong.
>
>
> Regards,
> Aravind.
>
> On Sat, Dec 12, 2015 at 4:13 AM, Mathieu Desnoyers <
> mathieu.desnoyers@efficios.com> wrote:
>
>> Hi,
>>
>> Please upgrade to 2.6.1 or 2.7.0, those are old issues.
>>
>> Thanks,
>>
>> Mathieu
>>
>>
>> ----- On Dec 11, 2015, at 1:42 PM, Aravind HT <aravind.ht@gmail.com>
>> wrote:
>>
>>
>> NPBS understand it, I will continue to investigate this, got a bit side
>> tracked with the sessiond hang issue that I mentioned earlier.
>> Making some progress on that, will update as soon as I find the root
>> cause, it looks like a mutex deadlock between
>> the following threads in the consumerd daemon
>>
>> #1  0x0000000000410b5d in lttcomm_recv_unix_sock (sock=3D26, buf=3Dbuf@e=
ntry=3D0x7f16acca57f0,
>> len=3Dlen@entry=3D4476) at unix.c:175
>> #2  0x000000000041dc96 in lttng_ustconsumer_request_metadata
>> (ctx=3Dctx@entry=3D0x640d10, channel=3D0x7f16980192b0, timer=3Dtimer@ent=
ry=3D0,
>> wait=3Dwait@entry=3D0) at ust-consumer.c:2331
>> #3  0x000000000041ff3c in lttng_ustconsumer_sync_metadata (ctx=3Dctx@ent=
ry=3D0x640d10,
>> metadata=3Dmetadata@entry=3D0x7f169801aa40) at ust-consumer.c:1829
>> #4  0x000000000040eabf in do_sync_metadata (ctx=3D<optimized out>,
>> metadata=3D<optimized out>) at consumer-stream.c:468
>> #5  consumer_stream_sync_metadata (ctx=3Dctx@entry=3D0x640d10, session_i=
d=3D8)
>> at consumer-stream.c:545
>> #6  0x000000000041d316 in lttng_ustconsumer_read_subbuffer
>> (stream=3Dstream@entry=3D0x7f1698018fa0, ctx=3Dctx@entry=3D0x640d10) at
>> ust-consumer.c:2063
>> #7  0x000000000040b613 in lttng_consumer_read_subbuffer
>> (stream=3D0x7f1698018fa0, ctx=3D0x640d10) at consumer.c:3203
>> #8  0x0000000000409608 in consumer_thread_data_poll (data=3D0x640d10) at
>> consumer.c:2557
>> #9  0x00007f16af6a6fe3 in start_thread (arg=3D0x7f16acca7700) at
>> pthread_create.c:312
>> #10 0x00007f16af3dcafd in clone () at
>> ../sysdeps/unix/sysv/linux/x86_64/clone.S:111
>>
>> and
>>
>> consumer_thread_metadata_poll() calling lttng_consumer_read_subbuffer() =
/
>> on_buffer_ready() calling pthread_mutex_lock(stream->lock) and then hang=
ing
>>
>>
>> This again can be reproduced by the same script, just running consecutiv=
e
>> sessions of short duration (<10 seconds) with traces getting captured on=
 a
>> remote node.
>> I hit this every time I run the script.
>>
>> Regards,
>> Aravind.
>>
>>
>>
>> On Fri, Dec 11, 2015 at 11:33 PM, Jonathan Rajotte Julien <
>> Jonathan.rajotte-julien@efficios.com> wrote:
>>
>>> Hi Aravind,
>>>
>>> On 2015-12-11 12:16 PM, Aravind HT wrote:
>>>
>>>> Hi,
>>>>
>>>> Did you get a chance to reproduce the problem with the scripts ? Let m=
e
>>>> know if you need any help running it.
>>>>
>>>
>>> Time is a scarce resource unfortunately. But until I have the time to
>>> look at it you might want to investigate if you are able to reproduce i=
t on
>>> 2.6.1/2.7.0/master on 2 regular (x86_64, ubuntu/debian) VM this would
>>> really help.
>>>
>>> Cheers!
>>>
>>>
>>>> Regards,
>>>> Aravind.
>>>>
>>>>
>>>> On Wed, Dec 9, 2015 at 3:04 PM, Aravind HT <aravind.ht@gmail.com
>>>> <mailto:aravind.ht@gmail.com>> wrote:
>>>>
>>>>     Sorry about that, not sure how it got missed.
>>>>     Here it is.
>>>>
>>>>
>>>>     # This needs a two node set up (1. local current node 2. remote
>>>> node )
>>>>     # relayd runs on the current node where traces are captured from
>>>>     the remote node
>>>>     # remote node runs test applications which generate traces.
>>>>     # the launch_script_RN is executed on the current node and uses
>>>>     ssh  to execute commands on the remote node. So this part may not
>>>>     work in every case and may prompt for a password.
>>>>     # if experiencing problems with ssh , kindly check
>>>>
>>>> http://serverfault.com/questions/241588/how-to-automate-ssh-login-with=
-password
>>>>
>>>>     # =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D    =
   To Run  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
>>>>     launch_script_RN.py self_profile -c /tmp/configFile.txt
>>>>
>>>>
>>>>
>>>>     # configFile.txt is the file which has configuration params that
>>>>     launchScript
>>>>     # needs to configure lttng sessions. Below is an explanation of
>>>>     the different options.
>>>>     # =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D     co=
nfigFile.txt
>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
>>>>
>>>>     [section1]
>>>>     # final out put file path
>>>>     OutputFile =3D /tmp/Final_report.txt
>>>>     # the remote node hostname on which test applications run and the
>>>>     test sessions will be created; this should be something that could
>>>>     be used with ssh. Traces will be transported from this node to the
>>>>     lttng_relayd running on the current node.
>>>>     Node =3D MY_REMOTE_NODE
>>>>     # Sub buffer size to start this with
>>>>     SubBufSize =3D 16k
>>>>     # Sub buffer count
>>>>     SubBufCount =3D 4
>>>>     # per uid buffer
>>>>     BufferScheme =3D --buffers-uid
>>>>     # yes
>>>>     EnableTracing =3D yes
>>>>     # Bit rate of the test applications. Comman seperated example "1,
>>>>     3, 3, 50" sayss 4 test applications producing 1, 3, 3, and 50 Kb/s
>>>>     traces.
>>>>     # So with the below, we just start with 1 test application
>>>>     producing 10 kb/s
>>>>     TestApps =3D 10
>>>>     # session life time in seonds
>>>>     TestTime =3D 10
>>>>     # Max number of successive sessions to configure. if n then n-1
>>>>     sessions are run, ex MaxRun =3D 2 will run 1 session.
>>>>     MaxRun =3D 100
>>>>
>>>>
>>>>     # =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  Pl=
ace the following files under
>>>>     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>>
>>>>     # /tmp on the remote node
>>>>     clean_RemNode_apps.sh
>>>>     report_lttng_script.sh
>>>>
>>>>     # rest of the scripts under /usr/sbin on the current local node on
>>>>     which lttng_realyd runs
>>>>     # Define a trace point MY_TRACE to take a single string arg with
>>>>     LOG_TEST_APP_PROFILING as the provider, compile test lttng_testApp
>>>>     and place it under /usr/sbin of the remote host
>>>>
>>>>     # in launch_script_RN.py change currentNodeIP to the IP address on
>>>>     which relayd is receiving, default ports are used.
>>>>
>>>>     # lttng_relayd is started as
>>>>     /usr/bin/lttng-relayd -o /var/log/lttng-traces -d
>>>>
>>>>     # lttng_sessiond is started as
>>>>     /usr/bin/lttng-sessiond --consumerd32-path
>>>>     /usr/lib/lttng/libexec/lttng-consumerd --consumerd32-libdir
>>>>     /usr/lib/ --consumerd64-path
>>>>     /usr/lib64/lttng/libexec/lttng-consumerd --consumerd64-libdir
>>>>     /usr/lib64/ -b --no-kernel
>>>>
>>>>
>>>>
>>>>
>>>>     Regards,
>>>>     Aravind.
>>>>
>>>>     On Wed, Dec 9, 2015 at 12:57 AM, Jonathan Rajotte Julien
>>>>     <Jonathan.rajotte-julien@efficios.com
>>>>     <mailto:Jonathan.rajotte-julien@efficios.com>> wrote:
>>>>
>>>>         Hi Aravind,
>>>>
>>>>         There is no README in the archive you sent.
>>>>
>>>>         Cheers
>>>>
>>>>         On 2015-12-08 07:51 AM, Aravind HT wrote:
>>>>
>>>>             Hi,
>>>>
>>>>             I am trying to upgrade in parallel, but this issue may
>>>>             still be present after I upgrade or may be temporarily
>>>>             masked. So I need to find the root cause for this and then
>>>>             see if its available on the latest before committing to
>>>>             upgrade.
>>>>
>>>>             There is another issue i'm hitting, the lttng list command
>>>>             hangs after lttng destroy session when running the
>>>> profiling.
>>>>
>>>>             I found that consumerd 64 goes into an infinite loop
>>>>             waiting to flush metadata in
>>>>             lttng_ustconsumer_recv_metadata() :: while
>>>>             (consumer_metadata_cache_flushed(channel, offset + len,
>>>>             timer)) .
>>>>             In consumer_metadata_cache,
>>>>             channel->metadata_stream->endpoint_status is
>>>>             CONSUMER_ENDPOINT_ACTIVE,
>>>>             metadata_stream->ust_metadata_pushed is 0 with offset
>>>>             having some value. This call always returns a 1 from the
>>>>             last else{} block resulting in an infinite loop. Upon
>>>>             searching the forum, I found the same issue being reported
>>>>             here :
>>>> https://www.mail-archive.com/lttng-dev@lists.lttng.org/msg07982.html
>>>>
>>>>             Regards,
>>>>             Aravind.
>>>>
>>>>
>>>>             On Tue, Dec 8, 2015 at 12:43 AM, Jonathan Rajotte
>>>>             <jonathan.r.julien@gmail.com
>>>>             <mailto:jonathan.r.julien@gmail.com>> wrote:
>>>>
>>>>                 Hi Aravind,
>>>>
>>>>                 Did you have the chance to upgrade to 2.6.1.If so
>>>>             where you able
>>>>                 to reproduce?
>>>>
>>>>                 Cheers
>>>>
>>>>                 On Mon, Dec 7, 2015 at 1:07 PM, Aravind HT
>>>>             <aravind.ht@gmail.com <mailto:aravind.ht@gmail.com>>
>>>>                 wrote:
>>>>
>>>>                     Hi,
>>>>
>>>>                     I have attached the complete profiling scripts
>>>>             here, its a bit
>>>>                     shabby, im new to python.
>>>>
>>>>                     There is a README which has the details on how to
>>>>             execute it.
>>>>                     Im using a Yocto 1.6 on x86_64 platforms on both
>>>>             the nodes.
>>>>
>>>>
>>>>                     Running this script when there are other sessions
>>>>             running
>>>>                     seems to reproduce this problem easily.
>>>>                     Please try it and let me know if you have any issu=
es
>>>>                     reproducing the problem.
>>>>
>>>>                     Regards,
>>>>                     Aravind.
>>>>
>>>>                     On Sat, Dec 5, 2015 at 5:23 PM, J=C3=A9r=C3=A9mie =
Galarneau
>>>>                     <jeremie.galarneau@efficios.com
>>>>             <mailto:jeremie.galarneau@efficios.com>
>>>>                     <mailto:jeremie.galarneau@efficios.com
>>>>             <mailto:jeremie.galarneau@efficios.com>>> wrote:
>>>>
>>>>                         On Fri, Dec 4, 2015 at 11:06 PM, Aravind HT
>>>>                         <aravind.ht@gmail.com
>>>>             <mailto:aravind.ht@gmail.com> <mailto:aravind.ht@gmail.com
>>>>
>>>>             <mailto:aravind.ht@gmail.com>>> wrote:
>>>>                         > I am using 2.6.0 .I will try to share the
>>>>             code that I'm
>>>>                         using here in some
>>>>                         > time. If there are any specific fixes that
>>>>             are relevant
>>>>                         to this issue, see
>>>>                         > if you can provide a link to them. I would
>>>>             ideally like
>>>>                         to try them out
>>>>                         > before trying a full upgrade to the latest
>>>>             versions.
>>>>
>>>>                         Hi,
>>>>
>>>>                         Can you provide more information on the
>>>>             system? Which
>>>>                         distribution,
>>>>                         architecture, kernel version?
>>>>
>>>>                         The verbose sessiond logs might help pinpoint
>>>> any
>>>>                         unexpected behaviour
>>>>                         here (are all applications registering as
>>>>             expected?).
>>>>
>>>>                         J=C3=A9r=C3=A9mie
>>>>
>>>>                         >
>>>>                         > On Fri, Dec 4, 2015 at 6:11 PM, J=C3=A9r=C3=
=A9mie
>>>>             Galarneau
>>>>                         > <jeremie.galarneau@efficios.com
>>>>             <mailto:jeremie.galarneau@efficios.com>
>>>>                         <mailto:jeremie.galarneau@efficios.com
>>>>             <mailto:jeremie.galarneau@efficios.com>>> wrote:
>>>>                         >>
>>>>                         >> Hi Aravind,
>>>>                         >>
>>>>                         >> Can't say I have looked at everything you
>>>>             sent yet, but
>>>>                         as a
>>>>                         >> preemptive question, which version are we
>>>>             talking about
>>>>                         here? 2.6.0 or
>>>>                         >> 2.6.1? 2.6.1 contains a lot of relay daemon
>>>>             fixes.
>>>>                         >>
>>>>                         >> Thanks,
>>>>                         >> J=C3=A9r=C3=A9mie
>>>>                         >>
>>>>                         >> On Thu, Dec 3, 2015 at 7:01 AM, Aravind HT
>>>>                         <aravind.ht@gmail.com
>>>>             <mailto:aravind.ht@gmail.com>> wrote:
>>>>                         >> > Hi,
>>>>                         >> >
>>>>                         >> > I am trying to obtain the performance
>>>>             characteristics
>>>>                         of lttng with the
>>>>                         >> > use
>>>>                         >> > of test applications. Traces are being
>>>>             produced on a
>>>>                         local node and
>>>>                         >> > delivered to relayd that is running on a
>>>>             separate
>>>>                         node for storage.
>>>>                         >> >
>>>>                         >> > An lttng session with the test
>>>>             applications producing
>>>>                         an initial bit
>>>>                         >> > rate of
>>>>                         >> > 10 kb/s is started and run for about 30
>>>>             seconds. The
>>>>                         starting sub-buffer
>>>>                         >> > size is kept at 128 kb and sub-buf count
>>>>             at 4. The
>>>>                         session is then
>>>>                         >> > stopped
>>>>                         >> > and destroyed and traces are analyzed to
>>>>             see if there
>>>>                         are any drops.
>>>>                         >> > This is
>>>>                         >> > being done in a loop with every
>>>>             subsequent session
>>>>                         having an increment
>>>>                         >> > of 2
>>>>                         >> > kb/s as long as there are no drops. If
>>>>             there are
>>>>                         drops, I increase the
>>>>                         >> > buffer size by a factor of x2 without
>>>>             incrementing
>>>>                         the bit rate.
>>>>                         >> >
>>>>                         >> > I see trace drops happening consistently
>>>>             with test
>>>>                         apps producing traces
>>>>                         >> > at
>>>>                         >> > less than 40 kb/s, it doesnt seem to help
>>>>             even if I
>>>>                         started with 1mb x 4
>>>>                         >> > sub-buffers.
>>>>                         >> >
>>>>                         >> > Analysis :
>>>>                         >> >
>>>>                         >> > I have attached the lttng_relayd ,
>>>>             lttng_consumerd_64
>>>>                         logs and the
>>>>                         >> > entire
>>>>                         >> > trace directory, hope you will be able to
>>>>             view it.
>>>>                         >> > I have modified lttng_relayd code to dump
>>>>             the traces
>>>>                         being captured in
>>>>                         >> > the
>>>>                         >> > lttng_relayd logs along with debug info.
>>>>                         >> >
>>>>                         >> > Each test app is producing logs in the
>>>>             form of  :
>>>>                         >> > "TraceApp PID - 31940 THID - 31970
>>>>             @threadRate - 1032
>>>>                         b/s appRate - 2079
>>>>                         >> > b/s
>>>>                         >> > threadTraceNum - 9 appTraceNum - 18
>>>>      sleepTime - 192120"
>>>>                         >> >
>>>>                         >> > The test application PID, test
>>>>             application thread id,
>>>>                         thread bit rate,
>>>>                         >> > test
>>>>                         >> > app bit rate, thread trace number and
>>>>             application
>>>>                         trace number s are
>>>>                         >> > part of
>>>>                         >> > the trace. So in the above trace, the
>>>>             thread is
>>>>                         producing at 1 kb/s and
>>>>                         >> > the
>>>>                         >> > whole test app is producing at 2 kb/s.
>>>>                         >> >
>>>>                         >> > If we look at the babeltrace out put, we
>>>>             see that the
>>>>                         Trace with
>>>>                         >> > TraceApp
>>>>                         >> > PID - 31940 appTraceNum 2 is missing ,
>>>>             with 1, 3, 4,
>>>>                         5 and so on being
>>>>                         >> > successfully captured.
>>>>                         >> > I looked at the lttng_relayd logs and
>>>>             found that
>>>>                         trace of "appTraceNum
>>>>                         >> > 2" is
>>>>                         >> > not delivered/generated by the consumerd
>>>>             to the
>>>>                         relayd in sequence with
>>>>                         >> > other traces. To rule out that this is
>>>>             not a test
>>>>                         application problem,
>>>>                         >> > you
>>>>                         >> > can look at line ltttng_relayd log :
>>>>             12778 and see
>>>>                         traces from
>>>>                         >> > appTraceNum -
>>>>                         >> > 1 to appTraceNum - 18 including the
>>>>             appTraceNum 2 are
>>>>                         "re-delivered" by
>>>>                         >> > the
>>>>                         >> > consumerd to the relayd.
>>>>                         >> > Essentially, I see appTraceNum 1 through
>>>>             appTraceNum
>>>>                         18 being delivered
>>>>                         >> > twice, once individually where
>>>>             appTraceNum 2 is
>>>>                         missing and once as a
>>>>                         >> > group
>>>>                         >> > at line 12778 where its present.
>>>>                         >> >
>>>>                         >> >
>>>>                         >> > Request help with
>>>>                         >> > 1. why traces are delivered twice, is it
>>>>             by design or
>>>>                         a genuine problem
>>>>                         >> > ?
>>>>                         >> > 2. how to avoid traces being dropped even
>>>>             though
>>>>                         buffers are
>>>>                         >> > sufficiently
>>>>                         >> > large enough ?
>>>>                         >> >
>>>>                         >> >
>>>>                         >> > Regards,
>>>>                         >> > Aravind.
>>>>                         >> >
>>>>                         >> >
>>>>             _______________________________________________
>>>>                         >> > lttng-dev mailing list
>>>>                         >> > lttng-dev@lists.lttng.org
>>>>             <mailto:lttng-dev@lists.lttng.org>
>>>>                         >> >
>>>>             http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>>>>                         >> >
>>>>                         >>
>>>>                         >>
>>>>                         >>
>>>>                         >> --
>>>>                         >> J=C3=A9r=C3=A9mie Galarneau
>>>>                         >> EfficiOS Inc.
>>>>                         >> http://www.efficios.com
>>>>                         >
>>>>                         >
>>>>
>>>>
>>>>
>>>>                         --
>>>>                         J=C3=A9r=C3=A9mie Galarneau
>>>>                         EfficiOS Inc.
>>>>             http://www.efficios.com
>>>>
>>>>
>>>>
>>>>             _______________________________________________
>>>>                     lttng-dev mailing list
>>>>             lttng-dev@lists.lttng.org
>>>>             <mailto:lttng-dev@lists.lttng.org>
>>>>             <mailto:lttng-dev@lists.lttng.org
>>>>             <mailto:lttng-dev@lists.lttng.org>>
>>>>             http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>>>>
>>>>
>>>>
>>>>
>>>>                 --     Jonathan Rajotte Julien
>>>>
>>>>
>>>>
>>>>
>>>>             _______________________________________________
>>>>             lttng-dev mailing list
>>>>             lttng-dev@lists.lttng.org <mailto:lttng-dev@lists.lttng.or=
g
>>>> >
>>>>             http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>>>>
>>>>
>>>>         --         Jonathan R. Julien
>>>>         Efficios
>>>>
>>>>
>>>>
>>>>
>>> --
>>> Jonathan R. Julien
>>> Efficios
>>>
>>>
>>
>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>>
>>
>> --
>> Mathieu Desnoyers
>> EfficiOS Inc.
>> http://www.efficios.com
>>
>
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
>

--089e0122976eed7a4e0527f8943d
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>Ive not had a chance to try it on 2=
.6.1 or 2.7.0 yet, will try and let you know.</div><div>However, I was able=
 to come up with a fix for 2.6.0 and I do not see any such changes on 2.6.1=
 or 2.7.0, so forwarding you the patch.</div><div><div><br></div><div><br><=
/div><div>diff -Naur ./src/bin/lttng-sessiond/ust-consumer.c /tmp/LTTNG_BKP=
_28_12_1/bin/lttng-sessiond/ust-consumer.c</div><div>--- ./src/bin/lttng-se=
ssiond/ust-consumer.c<span class=3D"" style=3D"white-space:pre">	</span>201=
5-12-28 07:45:34.610430830 -0800</div><div>+++ /tmp/LTTNG_BKP_28_12_1/bin/l=
ttng-sessiond/ust-consumer.c<span class=3D"" style=3D"white-space:pre">	</s=
pan>2015-12-28 07:58:18.906918555 -0800</div><div>@@ -1,3 +1,4 @@</div><div=
>+</div><div>=C2=A0/*</div><div>=C2=A0 * Copyright (C) 2011 - David Goulet =
&lt;<a href=3D"mailto:david.goulet@polymtl.ca">david.goulet@polymtl.ca</a>&=
gt;</div><div>=C2=A0 *</div><div>@@ -486,17 +487,48 @@</div><div>=C2=A0<spa=
n class=3D"" style=3D"white-space:pre">		</span>ust_reg =3D reg_pid-&gt;reg=
istry-&gt;reg.ust;</div><div>=C2=A0<span class=3D"" style=3D"white-space:pr=
e">	</span>}</div><div>=C2=A0<span class=3D"" style=3D"white-space:pre">	</=
span>assert(ust_reg);</div><div>+/* ust_reg-&gt;lock can also have been tak=
en from push_metadata making this metadata request</div><div>+* =C2=A0wait =
without sending a response to the consumer which gets stuck on the recv() c=
all=C2=A0</div><div>+* =C2=A0waiting for a response from sessiond. This met=
adata request from the consumer would=C2=A0</div><div>+* =C2=A0have taken t=
he stream-&gt;lock, do_sync_metadata() making the push_metadata wait for th=
e stream-&gt;lock to be=C2=A0</div><div>+* =C2=A0released, making the sessi=
ond thread pushing the metadata wait on the recv() for a=C2=A0</div><div>+*=
 =C2=A0response from the consumer, creating a deadlock. So to avoid this de=
adlock, making</div><div>+* =C2=A0the request metadata flow to fail incase =
if sessiond is already pushing metadata on=C2=A0</div><div>+* =C2=A0its own=
. */</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D pthread_mutex_trylock(&=
amp;ust_reg-&gt;lock);</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0if(!ret) {</d=
iv><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret_push =
=3D ust_app_push_metadata(ust_reg, socket, 1);</div><div>+ =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pthread_mutex_unlock(&amp;ust_reg-=
&gt;lock);</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0if (ret_push &lt; 0) {</div><div>+<span class=3D"" style=3D"white-space:=
pre">			</span>ERR(&quot;Error Pushing metadata&quot;);</div><div>+<span cl=
ass=3D"" style=3D"white-space:pre">	</span> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0/* -EPIPE error would be thrown if the appRegistry-=
&gt;metada_closed was set,</div><div>+<span class=3D"" style=3D"white-space=
:pre">	</span> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* =C2=
=A0this could have happened if ust_app_unregister() was called when there</=
div><div>+<span class=3D"" style=3D"white-space:pre">	</span> =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* =C2=A0was a problem with the so=
ck ( epoll() ) from thread_manage_apps(). This</div><div>+ =C2=A0 =C2=A0 =
=C2=A0 =C2=A0<span class=3D"" style=3D"white-space:pre">	</span> =C2=A0 =C2=
=A0 =C2=A0 =C2=A0* =C2=A0would have made the current func return an error, =
upon which, the whole</div><div>+<span class=3D"" style=3D"white-space:pre"=
>	</span> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* =C2=A0th=
read_manage_consumer would have been killed. To avoid this, send</div><div>=
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0<span class=3D"" style=3D"white-space:pre">	</=
span> =C2=A0 =C2=A0 =C2=A0 =C2=A0* =C2=A0an error back to consumerd and con=
tinue buisness as usual */</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0<span class=3D"" style=3D"white-space:pre">	</span>if( =
ret_push =3D=3D -EPIPE ) {</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0<span cla=
ss=3D"" style=3D"white-space:pre">	</span> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0DBG(&quot;app metadata was closed, so sending ERR m=
sg to Consumerd\n&quot;);</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0<span class=3D"" style=3D"white-space:pre">	</span> =C2=
=A0 =C2=A0 =C2=A0 =C2=A0memset(&amp;msg, 0, sizeof(msg));</div><div>+ =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0<span class=3D"" style=3D"white-space:pre">	</span>msg.cmd_type =3D L=
TTNG_ERR_UND;</div><div>+<span class=3D"" style=3D"white-space:pre">	</span=
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0(void) consumer_send_msg(socket, &amp;msg);</div><div>+ =C2=A0 =
=C2=A0 =C2=A0 =C2=A0<span class=3D"" style=3D"white-space:pre">	</span> =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D 0;</div><div>+ =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<span class=3D"" sty=
le=3D"white-space:pre">	</span>} else {</div><div>+ =C2=A0 =C2=A0 =C2=A0 =
=C2=A0<span class=3D"" style=3D"white-space:pre">	</span> =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D -1;</div><div>+ =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<span class=3D"" style=3D"white-s=
pace:pre">	</span>}</div><div>+<span class=3D"" style=3D"white-space:pre">	=
</span> =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {</div><div>+ =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<span class=3D"" style=3D"white-space=
:pre">	</span>DBG(&quot;UST Consumer metadata pushed successfully&quot;);</=
div><div>+<span class=3D"" style=3D"white-space:pre">	</span> =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D 0;</div><div>+ =C2=A0 =C2=
=A0 =C2=A0 =C2=A0<span class=3D"" style=3D"white-space:pre">	</span>}</div>=
<div>+</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {</div><div>+ =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DBG(&quot; ust_reg-&gt;lock=
 is taken, cannot push metadata for this request at present \n&quot;);</div=
><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0memset(&amp;=
msg, 0, sizeof(msg));</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0msg.cmd_type =3D LTTNG_ERR_UND;</div><div>+ =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(void) consumer_send_msg(socket, &amp=
;msg);</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0r=
et =3D 0;</div><div>=C2=A0</div><div>-<span class=3D"" style=3D"white-space=
:pre">	</span>pthread_mutex_lock(&amp;ust_reg-&gt;lock);</div><div>-<span c=
lass=3D"" style=3D"white-space:pre">	</span>ret_push =3D ust_app_push_metad=
ata(ust_reg, socket, 1);</div><div>-<span class=3D"" style=3D"white-space:p=
re">	</span>pthread_mutex_unlock(&amp;ust_reg-&gt;lock);</div><div>-<span c=
lass=3D"" style=3D"white-space:pre">	</span>if (ret_push &lt; 0) {</div><di=
v>-<span class=3D"" style=3D"white-space:pre">		</span>ERR(&quot;Pushing me=
tadata&quot;);</div><div>-<span class=3D"" style=3D"white-space:pre">		</sp=
an>ret =3D -1;</div><div>-<span class=3D"" style=3D"white-space:pre">		</sp=
an>goto end;</div><div>-<span class=3D"" style=3D"white-space:pre">	</span>=
}</div><div>-<span class=3D"" style=3D"white-space:pre">	</span>DBG(&quot;U=
ST Consumer metadata pushed successfully&quot;);</div><div>-<span class=3D"=
" style=3D"white-space:pre">	</span>ret =3D 0;</div><div>+ =C2=A0 =C2=A0 =
=C2=A0 =C2=A0}</div><div>=C2=A0</div><div>=C2=A0end:</div><div>=C2=A0<span =
class=3D"" style=3D"white-space:pre">	</span>rcu_read_unlock();</div></div>=
<div><br></div><div><br></div><div>Regards,</div><div>Aravind.</div></div><=
div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Wed, Dec 16, 20=
15 at 7:48 PM, Mathieu Desnoyers <span dir=3D"ltr">&lt;<a href=3D"mailto:ma=
thieu.desnoyers@efficios.com" target=3D"_blank">mathieu.desnoyers@efficios.=
com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div><div style=
=3D"font-family:arial,helvetica,sans-serif;font-size:12pt;color:#000000"><s=
pan class=3D""><div><br></div><span>----- On Dec 16, 2015, at 8:02 AM, Arav=
ind HT &lt;<a href=3D"mailto:aravind.ht@gmail.com" target=3D"_blank">aravin=
d.ht@gmail.com</a>&gt; wrote:<br></span></span><div><span class=3D""><block=
quote style=3D"border-left:2px solid #1010ff;margin-left:5px;padding-left:5=
px;color:#000;font-weight:normal;font-style:normal;text-decoration:none;fon=
t-family:Helvetica,Arial,sans-serif;font-size:12pt"><div dir=3D"ltr">Hi Mat=
hieu,<br><div>Ive been able to analyze this sessiond - consumerd hang scena=
rio and I see that the fix is not available on 2.6.1 or on 2.7.0.</div></di=
v></blockquote><div><br></div></span><div>Did you actually reproduce the is=
sue with 2.6.1 or 2.7.0 ? Can we get the<br></div><div>associated backtrace=
 reproduced on those versions ?<br></div><div><br></div><div>Thanks,<br></d=
iv><div><br></div><div>Mathieu<br></div><div><div class=3D"h5"><div><br></d=
iv><blockquote style=3D"border-left:2px solid #1010ff;margin-left:5px;paddi=
ng-left:5px;color:#000;font-weight:normal;font-style:normal;text-decoration=
:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt"><div dir=3D"lt=
r"><br><div>Root Cause :</div><br><div>The hang is mainly caused because of=
 a race condition for the consumer_metadata_socket between the following tw=
o flows of code</div><div>Flow 1. do_sync_metadata() -&gt; lttng_ustconsume=
r_sync_metadat() -&gt; lttng_ustconsumer_request_metadata() -&gt; lttncomm_=
recv_unix_sock() -&gt; recvmsg()</div><br><div>and</div><br><div>Flow 2. lt=
tng_consumer_recv_cmd() -&gt; lttng_ust_consumer_recv_cmd() -&gt; lttng_ust=
consumer_recv_metadata()</div><br><div>Flow 1 above initiates a metadata re=
quests and recvmsg()s for the reply from sessiond on the=C2=A0consumer_meta=
data_socket=C2=A0( it has taken the metadata_socket_lock and the stream-&gt=
;lock ) , but simultaneously this socket is being polled from Flow 2. Once =
in a while Flow 2 gets to receive while Flow 1 just hangs on recvmsg() . Si=
nce Flow 1 has taken the stream-&gt;lock, this then introduces a deadlock a=
t a later stage (on_buffer_ready() when the metadata is being flushed. )</d=
iv><br><div>Think using the metadata_socket_lock in Flow 2 before attemptin=
g to receive may address this issue, but is a bit complicated as the messag=
e would have already been received at the point of using that lock. The oth=
er alternative is to remove the complete recv() from Flow 1 and let that be=
 taken care by Flow 2.</div><br><div>Please let me know if this has been fi=
xed in the later builds, may be I searched it wrong.</div><br><br><div>Rega=
rds,</div><div>Aravind.</div></div><div class=3D"gmail_extra"><br><div clas=
s=3D"gmail_quote">On Sat, Dec 12, 2015 at 4:13 AM, Mathieu Desnoyers <span =
dir=3D"ltr">&lt;<a href=3D"mailto:mathieu.desnoyers@efficios.com" target=3D=
"_blank">mathieu.desnoyers@efficios.com</a>&gt;</span> wrote:<br><blockquot=
e class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc sol=
id;padding-left:1ex"><div><div style=3D"font-family:arial,helvetica,sans-se=
rif;font-size:12pt;color:#000000"><div>Hi,</div><br><div>Please upgrade to =
2.6.1 or 2.7.0, those are old issues.<br></div><br><div>Thanks,<br></div><b=
r><div>Mathieu<br></div><div><div><br><br><div><span>----- On Dec 11, 2015,=
 at 1:42 PM, Aravind HT &lt;<a href=3D"mailto:aravind.ht@gmail.com" target=
=3D"_blank">aravind.ht@gmail.com</a>&gt; wrote:<br></span></div></div></div=
><div><blockquote style=3D"border-left:2px solid #1010ff;margin-left:5px;pa=
dding-left:5px;color:#000;font-weight:normal;font-style:normal;text-decorat=
ion:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt"><div><div><=
div dir=3D"ltr"><br>NPBS understand it, I will continue to investigate this=
, got a bit side tracked with the sessiond hang issue that I mentioned earl=
ier.=C2=A0<div>Making some progress on that, will update as soon as I find =
the root cause, it looks like a mutex deadlock between=C2=A0<br></div><div>=
<div>the following threads in the consumerd daemon</div><br><div>#1 =C2=A00=
x0000000000410b5d in lttcomm_recv_unix_sock (sock=3D26, buf=3Dbuf@entry=3D0=
x7f16acca57f0, len=3Dlen@entry=3D4476) at unix.c:175<div>#2 =C2=A00x0000000=
00041dc96 in lttng_ustconsumer_request_metadata (ctx=3Dctx@entry=3D0x640d10=
, channel=3D0x7f16980192b0, timer=3Dtimer@entry=3D0, wait=3Dwait@entry=3D0)=
 at ust-consumer.c:2331</div><div>#3 =C2=A00x000000000041ff3c in lttng_ustc=
onsumer_sync_metadata (ctx=3Dctx@entry=3D0x640d10, metadata=3Dmetadata@entr=
y=3D0x7f169801aa40) at ust-consumer.c:1829</div><div>#4 =C2=A00x00000000004=
0eabf in do_sync_metadata (ctx=3D&lt;optimized out&gt;, metadata=3D&lt;opti=
mized out&gt;) at consumer-stream.c:468</div><div>#5 =C2=A0consumer_stream_=
sync_metadata (ctx=3Dctx@entry=3D0x640d10, session_id=3D8) at consumer-stre=
am.c:545</div><div>#6 =C2=A00x000000000041d316 in lttng_ustconsumer_read_su=
bbuffer (stream=3Dstream@entry=3D0x7f1698018fa0, ctx=3Dctx@entry=3D0x640d10=
) at ust-consumer.c:2063</div><div>#7 =C2=A00x000000000040b613 in lttng_con=
sumer_read_subbuffer (stream=3D0x7f1698018fa0, ctx=3D0x640d10) at consumer.=
c:3203</div><div>#8 =C2=A00x0000000000409608 in consumer_thread_data_poll (=
data=3D0x640d10) at consumer.c:2557</div><div>#9 =C2=A00x00007f16af6a6fe3 i=
n start_thread (arg=3D0x7f16acca7700) at pthread_create.c:312</div><div>#10=
 0x00007f16af3dcafd in clone () at ../sysdeps/unix/sysv/linux/x86_64/clone.=
S:111</div></div></div><br><div>and=C2=A0</div><br><div>consumer_thread_met=
adata_poll() calling lttng_consumer_read_subbuffer() / on_buffer_ready() ca=
lling pthread_mutex_lock(stream-&gt;lock) and then hanging</div><div><br><b=
r><div>This again can be reproduced by the same script, just running consec=
utive sessions of short duration (&lt;10 seconds) with traces getting captu=
red on a remote node.</div><div>I hit this every time I run the script.</di=
v><br><div>Regards,</div><div>Aravind.</div><br><div class=3D"gmail_extra">=
<br></div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Fri,=
 Dec 11, 2015 at 11:33 PM, Jonathan Rajotte Julien <span dir=3D"ltr">&lt;<a=
 href=3D"mailto:Jonathan.rajotte-julien@efficios.com" target=3D"_blank">Jon=
athan.rajotte-julien@efficios.com</a>&gt;</span> wrote:<br><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;b=
order-left-color:rgb(204,204,204);border-left-style:solid;padding-left:1ex"=
>Hi Aravind,<span><br>
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
=C2=A0 =C2=A0 Sorry about that, not sure how it got missed.<br>
=C2=A0 =C2=A0 Here it is.<br><br><br>
=C2=A0 =C2=A0 # This needs a two node set up (1. local current node 2. remo=
te node )<br>
=C2=A0 =C2=A0 # relayd runs on the current node where traces are captured f=
rom<br>
=C2=A0 =C2=A0 the remote node<br>
=C2=A0 =C2=A0 # remote node runs test applications which generate traces.<b=
r>
=C2=A0 =C2=A0 # the launch_script_RN is executed on the current node and us=
es<br>
=C2=A0 =C2=A0 ssh=C2=A0 to execute commands on the remote node. So this par=
t may not<br>
=C2=A0 =C2=A0 work in every case and may prompt for a password.<br>
=C2=A0 =C2=A0 # if experiencing problems with ssh , kindly check<br><a href=
=3D"http://serverfault.com/questions/241588/how-to-automate-ssh-login-with-=
password" rel=3D"noreferrer" target=3D"_blank">http://serverfault.com/quest=
ions/241588/how-to-automate-ssh-login-with-password</a><br><br>
=C2=A0 =C2=A0 # =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=C2=A0 =C2=A0 =C2=A0 =C2=A0To Run=C2=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
=C2=A0 =C2=A0 launch_script_RN.py self_profile -c /tmp/configFile.txt<br><b=
r><br><br>
=C2=A0 =C2=A0 # configFile.txt is the file which has configuration params t=
hat<br>
=C2=A0 =C2=A0 launchScript<br>
=C2=A0 =C2=A0 # needs to configure lttng sessions. Below is an explanation =
of<br>
=C2=A0 =C2=A0 the different options.<br>
=C2=A0 =C2=A0 # =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=C2=A0 =C2=A0 =C2=A0configFile.txt =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br><br>
=C2=A0 =C2=A0 [section1]<br>
=C2=A0 =C2=A0 # final out put file path<br>
=C2=A0 =C2=A0 OutputFile =3D /tmp/Final_report.txt<br>
=C2=A0 =C2=A0 # the remote node hostname on which test applications run and=
 the<br>
=C2=A0 =C2=A0 test sessions will be created; this should be something that =
could<br>
=C2=A0 =C2=A0 be used with ssh. Traces will be transported from this node t=
o the<br>
=C2=A0 =C2=A0 lttng_relayd running on the current node.<br>
=C2=A0 =C2=A0 Node =3D MY_REMOTE_NODE<br>
=C2=A0 =C2=A0 # Sub buffer size to start this with<br>
=C2=A0 =C2=A0 SubBufSize =3D 16k<br>
=C2=A0 =C2=A0 # Sub buffer count<br>
=C2=A0 =C2=A0 SubBufCount =3D 4<br>
=C2=A0 =C2=A0 # per uid buffer<br>
=C2=A0 =C2=A0 BufferScheme =3D --buffers-uid<br>
=C2=A0 =C2=A0 # yes<br>
=C2=A0 =C2=A0 EnableTracing =3D yes<br>
=C2=A0 =C2=A0 # Bit rate of the test applications. Comman seperated example=
 &quot;1,<br>
=C2=A0 =C2=A0 3, 3, 50&quot; sayss 4 test applications producing 1, 3, 3, a=
nd 50 Kb/s<br>
=C2=A0 =C2=A0 traces.<br>
=C2=A0 =C2=A0 # So with the below, we just start with 1 test application<br=
>
=C2=A0 =C2=A0 producing 10 kb/s<br>
=C2=A0 =C2=A0 TestApps =3D 10<br>
=C2=A0 =C2=A0 # session life time in seonds<br>
=C2=A0 =C2=A0 TestTime =3D 10<br>
=C2=A0 =C2=A0 # Max number of successive sessions to configure. if n then n=
-1<br>
=C2=A0 =C2=A0 sessions are run, ex MaxRun =3D 2 will run 1 session.<br>
=C2=A0 =C2=A0 MaxRun =3D 100<br><br><br>
=C2=A0 =C2=A0 # =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=C2=A0 Place the following files under<br>
=C2=A0 =C2=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br><br>
=C2=A0 =C2=A0 # /tmp on the remote node<br>
=C2=A0 =C2=A0 clean_RemNode_apps.sh<br>
=C2=A0 =C2=A0 report_lttng_script.sh<br><br>
=C2=A0 =C2=A0 # rest of the scripts under /usr/sbin on the current local no=
de on<br>
=C2=A0 =C2=A0 which lttng_realyd runs<br>
=C2=A0 =C2=A0 # Define a trace point MY_TRACE to take a single string arg w=
ith<br>
=C2=A0 =C2=A0 LOG_TEST_APP_PROFILING as the provider, compile test lttng_te=
stApp<br>
=C2=A0 =C2=A0 and place it under /usr/sbin of the remote host<br><br>
=C2=A0 =C2=A0 # in launch_script_RN.py change currentNodeIP to the IP addre=
ss on<br>
=C2=A0 =C2=A0 which relayd is receiving, default ports are used.<br><br>
=C2=A0 =C2=A0 # lttng_relayd is started as<br>
=C2=A0 =C2=A0 /usr/bin/lttng-relayd -o /var/log/lttng-traces -d<br><br>
=C2=A0 =C2=A0 # lttng_sessiond is started as<br>
=C2=A0 =C2=A0 /usr/bin/lttng-sessiond --consumerd32-path<br>
=C2=A0 =C2=A0 /usr/lib/lttng/libexec/lttng-consumerd --consumerd32-libdir<b=
r>
=C2=A0 =C2=A0 /usr/lib/ --consumerd64-path<br>
=C2=A0 =C2=A0 /usr/lib64/lttng/libexec/lttng-consumerd --consumerd64-libdir=
<br>
=C2=A0 =C2=A0 /usr/lib64/ -b --no-kernel<br><br><br><br><br>
=C2=A0 =C2=A0 Regards,<br>
=C2=A0 =C2=A0 Aravind.<br><br>
=C2=A0 =C2=A0 On Wed, Dec 9, 2015 at 12:57 AM, Jonathan Rajotte Julien<br>
=C2=A0 =C2=A0 &lt;<a href=3D"mailto:Jonathan.rajotte-julien@efficios.com" t=
arget=3D"_blank">Jonathan.rajotte-julien@efficios.com</a><br></div></div><d=
iv><div>
=C2=A0 =C2=A0 &lt;mailto:<a href=3D"mailto:Jonathan.rajotte-julien@efficios=
.com" target=3D"_blank">Jonathan.rajotte-julien@efficios.com</a>&gt;&gt; wr=
ote:<br><br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Hi Aravind,<br><br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 There is no README in the archive you sent.<br>=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Cheers<br><br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 On 2015-12-08 07:51 AM, Aravind HT wrote:<br><b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Hi,<br><br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 I am trying to upgrade in paralle=
l, but this issue may<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 still be present after I upgrade =
or may be temporarily<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 masked. So I need to find the roo=
t cause for this and then<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 see if its available on the lates=
t before committing to<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 upgrade.<br><br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 There is another issue i&#39;m hi=
tting, the lttng list command<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hangs after lttng destroy session=
 when running the profiling.<br><br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 I found that consumerd 64 goes in=
to an infinite loop<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 waiting to flush metadata in<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 lttng_ustconsumer_recv_metadata()=
 :: while<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (consumer_metadata_cache_flushed(=
channel, offset + len,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 timer)) .<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 In consumer_metadata_cache,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 channel-&gt;metadata_stream-&gt;e=
ndpoint_status is<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 CONSUMER_ENDPOINT_ACTIVE,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 metadata_stream-&gt;ust_metadata_=
pushed is 0 with offset<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 having some value. This call alwa=
ys returns a 1 from the<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 last else{} block resulting in an=
 infinite loop. Upon<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 searching the forum, I found the =
same issue being reported<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 here :<br><a href=3D"https://www.=
mail-archive.com/lttng-dev@lists.lttng.org/msg07982.html" rel=3D"noreferrer=
" target=3D"_blank">https://www.mail-archive.com/lttng-dev@lists.lttng.org/=
msg07982.html</a><br><br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Regards,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Aravind.<br><br><br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 On Tue, Dec 8, 2015 at 12:43 AM, =
Jonathan Rajotte<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;<a href=3D"mailto:jonathan.r.=
julien@gmail.com" target=3D"_blank">jonathan.r.julien@gmail.com</a><br></di=
v></div><span>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;mailto:<a href=3D"mailto:jona=
than.r.julien@gmail.com" target=3D"_blank">jonathan.r.julien@gmail.com</a>&=
gt;&gt; wrote:<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Hi Aravind,<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Did you have the ch=
ance to upgrade to 2.6.1.If so<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 where you able<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 to reproduce?<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Cheers<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 On Mon, Dec 7, 2015=
 at 1:07 PM, Aravind HT<br></span>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;<a href=3D"mailto:aravind.ht@=
gmail.com" target=3D"_blank">aravind.ht@gmail.com</a> &lt;mailto:<a href=3D=
"mailto:aravind.ht@gmail.com" target=3D"_blank">aravind.ht@gmail.com</a>&gt=
;&gt;<span><br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 wrote:<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Hi,<b=
r>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 I hav=
e attached the complete profiling scripts<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 here, its a bit<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 shabb=
y, im new to python.<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 There=
 is a README which has the details on how to<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 execute it.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Im us=
ing a Yocto 1.6 on x86_64 platforms on both<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 the nodes.<br>
<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Runni=
ng this script when there are other sessions<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 running<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 seems=
 to reproduce this problem easily.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Pleas=
e try it and let me know if you have any issues<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 repro=
ducing the problem.<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Regar=
ds,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Aravi=
nd.<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 On Sa=
t, Dec 5, 2015 at 5:23 PM, J=C3=A9r=C3=A9mie Galarneau<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;<=
a href=3D"mailto:jeremie.galarneau@efficios.com" target=3D"_blank">jeremie.=
galarneau@efficios.com</a><br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;mailto:<a href=3D"mailto:jere=
mie.galarneau@efficios.com" target=3D"_blank">jeremie.galarneau@efficios.co=
m</a>&gt;<br></span>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;m=
ailto:<a href=3D"mailto:jeremie.galarneau@efficios.com" target=3D"_blank">j=
eremie.galarneau@efficios.com</a><span><br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;mailto:<a href=3D"mailto:jere=
mie.galarneau@efficios.com" target=3D"_blank">jeremie.galarneau@efficios.co=
m</a>&gt;&gt;&gt; wrote:<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 On Fri, Dec 4, 2015 at 11:06 PM, Aravind HT<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &lt;<a href=3D"mailto:aravind.ht@gmail.com" target=3D"_blank">ar=
avind.ht@gmail.com</a><br></span>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;mailto:<a href=3D"mailto:arav=
ind.ht@gmail.com" target=3D"_blank">aravind.ht@gmail.com</a>&gt; &lt;mailto=
:<a href=3D"mailto:aravind.ht@gmail.com" target=3D"_blank">aravind.ht@gmail=
.com</a><div><div><br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;mailto:<a href=3D"mailto:arav=
ind.ht@gmail.com" target=3D"_blank">aravind.ht@gmail.com</a>&gt;&gt;&gt; wr=
ote:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &gt; I am using 2.6.0 .I will try to share the<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 code that I&#39;m<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 using here in some<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &gt; time. If there are any specific fixes that<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 are relevant<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 to this issue, see<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &gt; if you can provide a link to them. I would<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ideally like<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 to try them out<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &gt; before trying a full upgrade to the latest<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 versions.<br><br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 Hi,<br><br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 Can you provide more information on the<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 system? Which<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 distribution,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 architecture, kernel version?<br><br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 The verbose sessiond logs might help pinpoint any<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 unexpected behaviour<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 here (are all applications registering as<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 expected?).<br><br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 J=C3=A9r=C3=A9mie<br><br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &gt; On Fri, Dec 4, 2015 at 6:11 PM, J=C3=A9r=C3=A9mie<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Galarneau<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &gt; &lt;<a href=3D"mailto:jeremie.galarneau@efficios.com" targe=
t=3D"_blank">jeremie.galarneau@efficios.com</a><br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;mailto:<a href=3D"mailto:jere=
mie.galarneau@efficios.com" target=3D"_blank">jeremie.galarneau@efficios.co=
m</a>&gt;<br></div></div>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &lt;mailto:<a href=3D"mailto:jeremie.galarneau@efficios.com" tar=
get=3D"_blank">jeremie.galarneau@efficios.com</a><span><br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;mailto:<a href=3D"mailto:jere=
mie.galarneau@efficios.com" target=3D"_blank">jeremie.galarneau@efficios.co=
m</a>&gt;&gt;&gt; wrote:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &gt;&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &gt;&gt; Hi Aravind,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &gt;&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &gt;&gt; Can&#39;t say I have looked at everything you<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sent yet, but<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 as a<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &gt;&gt; preemptive question, which version are we<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 talking about<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 here? 2.6.0 or<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &gt;&gt; 2.6.1? 2.6.1 contains a lot of relay daemon<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fixes.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &gt;&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &gt;&gt; Thanks,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &gt;&gt; J=C3=A9r=C3=A9mie<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &gt;&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &gt;&gt; On Thu, Dec 3, 2015 at 7:01 AM, Aravind HT<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &lt;<a href=3D"mailto:aravind.ht@gmail.com" target=3D"_blank">ar=
avind.ht@gmail.com</a><br></span><div><div>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;mailto:<a href=3D"mailto:arav=
ind.ht@gmail.com" target=3D"_blank">aravind.ht@gmail.com</a>&gt;&gt; wrote:=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &gt;&gt; &gt; Hi,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &gt;&gt; &gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &gt;&gt; &gt; I am trying to obtain the performance<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 characteristics<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 of lttng with the<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &gt;&gt; &gt; use<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &gt;&gt; &gt; of test applications. Traces are being<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 produced on a<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 local node and<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &gt;&gt; &gt; delivered to relayd that is running on a<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 separate<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 node for storage.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &gt;&gt; &gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &gt;&gt; &gt; An lttng session with the test<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 applications producing<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 an initial bit<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &gt;&gt; &gt; rate of<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &gt;&gt; &gt; 10 kb/s is started and run for about 30<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 seconds. The<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 starting sub-buffer<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &gt;&gt; &gt; size is kept at 128 kb and sub-buf count<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 at 4. The<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 session is then<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &gt;&gt; &gt; stopped<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &gt;&gt; &gt; and destroyed and traces are analyzed to<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 see if there<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 are any drops.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &gt;&gt; &gt; This is<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &gt;&gt; &gt; being done in a loop with every<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 subsequent session<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 having an increment<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &gt;&gt; &gt; of 2<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &gt;&gt; &gt; kb/s as long as there are no drops. If<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 there are<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 drops, I increase the<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &gt;&gt; &gt; buffer size by a factor of x2 without<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 incrementing<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 the bit rate.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &gt;&gt; &gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &gt;&gt; &gt; I see trace drops happening consistently<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 with test<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 apps producing traces<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &gt;&gt; &gt; at<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &gt;&gt; &gt; less than 40 kb/s, it doesnt seem to help<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 even if I<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 started with 1mb x 4<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &gt;&gt; &gt; sub-buffers.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &gt;&gt; &gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &gt;&gt; &gt; Analysis :<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &gt;&gt; &gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &gt;&gt; &gt; I have attached the lttng_relayd ,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 lttng_consumerd_64<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 logs and the<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &gt;&gt; &gt; entire<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &gt;&gt; &gt; trace directory, hope you will be able to<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 view it.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &gt;&gt; &gt; I have modified lttng_relayd code to dump<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 the traces<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 being captured in<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &gt;&gt; &gt; the<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &gt;&gt; &gt; lttng_relayd logs along with debug info.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &gt;&gt; &gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &gt;&gt; &gt; Each test app is producing logs in the<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 form of=C2=A0 :<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &gt;&gt; &gt; &quot;TraceApp PID - 31940 THID - 31970<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 @threadRate - 1032<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 b/s appRate - 2079<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &gt;&gt; &gt; b/s<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &gt;&gt; &gt; threadTraceNum - 9 appTraceNum - 18=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sleepTime - 192120&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &gt;&gt; &gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &gt;&gt; &gt; The test application PID, test<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 application thread id,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 thread bit rate,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &gt;&gt; &gt; test<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &gt;&gt; &gt; app bit rate, thread trace number and<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 application<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 trace number s are<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &gt;&gt; &gt; part of<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &gt;&gt; &gt; the trace. So in the above trace, the<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 thread is<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 producing at 1 kb/s and<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &gt;&gt; &gt; the<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &gt;&gt; &gt; whole test app is producing at 2 kb/s.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &gt;&gt; &gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &gt;&gt; &gt; If we look at the babeltrace out put, we<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 see that the<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 Trace with<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &gt;&gt; &gt; TraceApp<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &gt;&gt; &gt; PID - 31940 appTraceNum 2 is missing ,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 with 1, 3, 4,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 5 and so on being<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &gt;&gt; &gt; successfully captured.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &gt;&gt; &gt; I looked at the lttng_relayd logs and<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 found that<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 trace of &quot;appTraceNum<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &gt;&gt; &gt; 2&quot; is<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &gt;&gt; &gt; not delivered/generated by the consumerd<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 to the<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 relayd in sequence with<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &gt;&gt; &gt; other traces. To rule out that this is<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 not a test<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 application problem,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &gt;&gt; &gt; you<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &gt;&gt; &gt; can look at line ltttng_relayd log :<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 12778 and see<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 traces from<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &gt;&gt; &gt; appTraceNum -<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &gt;&gt; &gt; 1 to appTraceNum - 18 including the<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 appTraceNum 2 are<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &quot;re-delivered&quot; by<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &gt;&gt; &gt; the<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &gt;&gt; &gt; consumerd to the relayd.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &gt;&gt; &gt; Essentially, I see appTraceNum 1 through<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 appTraceNum<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 18 being delivered<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &gt;&gt; &gt; twice, once individually where<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 appTraceNum 2 is<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 missing and once as a<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &gt;&gt; &gt; group<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &gt;&gt; &gt; at line 12778 where its present.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &gt;&gt; &gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &gt;&gt; &gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &gt;&gt; &gt; Request help with<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &gt;&gt; &gt; 1. why traces are delivered twice, is it<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 by design or<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 a genuine problem<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &gt;&gt; &gt; ?<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &gt;&gt; &gt; 2. how to avoid traces being dropped even<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 though<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 buffers are<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &gt;&gt; &gt; sufficiently<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &gt;&gt; &gt; large enough ?<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &gt;&gt; &gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &gt;&gt; &gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &gt;&gt; &gt; Regards,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &gt;&gt; &gt; Aravind.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &gt;&gt; &gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &gt;&gt; &gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 _________________________________=
______________<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &gt;&gt; &gt; lttng-dev mailing list<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &gt;&gt; &gt; <a href=3D"mailto:lttng-dev@lists.lttng.org" targe=
t=3D"_blank">lttng-dev@lists.lttng.org</a><br></div></div><span>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;mailto:<a href=3D"mailto:lttn=
g-dev@lists.lttng.org" target=3D"_blank">lttng-dev@lists.lttng.org</a>&gt;<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &gt;&gt; &gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"http://lists.lttng.org=
/cgi-bin/mailman/listinfo/lttng-dev" rel=3D"noreferrer" target=3D"_blank">h=
ttp://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a><br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &gt;&gt; &gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &gt;&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &gt;&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &gt;&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &gt;&gt; --<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &gt;&gt; J=C3=A9r=C3=A9mie Galarneau<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &gt;&gt; EfficiOS Inc.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &gt;&gt; <a href=3D"http://www.efficios.com" rel=3D"noreferrer" =
target=3D"_blank">http://www.efficios.com</a><br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &gt;<br>
<br>
<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 --<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 J=C3=A9r=C3=A9mie Galarneau<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 EfficiOS Inc.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"http://www.efficios.co=
m" rel=3D"noreferrer" target=3D"_blank">http://www.efficios.com</a><br>
<br>
<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 _________________________________=
______________<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 lttng=
-dev mailing list<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"mailto:lttng-dev@lists=
.lttng.org" target=3D"_blank">lttng-dev@lists.lttng.org</a><br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;mailto:<a href=3D"mailto:lttn=
g-dev@lists.lttng.org" target=3D"_blank">lttng-dev@lists.lttng.org</a>&gt;<=
br></span>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;mailto:<a href=3D"mailto:lttn=
g-dev@lists.lttng.org" target=3D"_blank">lttng-dev@lists.lttng.org</a><span=
><br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;mailto:<a href=3D"mailto:lttn=
g-dev@lists.lttng.org" target=3D"_blank">lttng-dev@lists.lttng.org</a>&gt;&=
gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"http://lists.lttng.org=
/cgi-bin/mailman/listinfo/lttng-dev" rel=3D"noreferrer" target=3D"_blank">h=
ttp://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a><br>
<br>
<br>
<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 --=C2=A0 =C2=A0 =C2=
=A0Jonathan Rajotte Julien<br>
<br>
<br>
<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 _________________________________=
______________<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 lttng-dev mailing list<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"mailto:lttng-dev@lists=
.lttng.org" target=3D"_blank">lttng-dev@lists.lttng.org</a> &lt;mailto:<a h=
ref=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-dev@lists.=
lttng.org</a>&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"http://lists.lttng.org=
/cgi-bin/mailman/listinfo/lttng-dev" rel=3D"noreferrer" target=3D"_blank">h=
ttp://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a><br>
<br>
<br></span>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 --=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Jonathan R.=
 Julien<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Efficios<br><br><br><br></blockquote><div><div>=
<br>
-- <br>
Jonathan R. Julien<br>
Efficios<br><br></div></div></blockquote></div><br></div></div></div><br>__=
_____________________________________________<br>lttng-dev mailing list<br>=
<a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-dev@li=
sts.lttng.org</a><br></div></div><a href=3D"http://lists.lttng.org/cgi-bin/=
mailman/listinfo/lttng-dev" target=3D"_blank">http://lists.lttng.org/cgi-bi=
n/mailman/listinfo/lttng-dev</a><span><span style=3D"color:#888888" color=
=3D"#888888"><br></span></span></blockquote></div><span><span style=3D"colo=
r:#888888" color=3D"#888888"><br><div>-- <br></div><div>Mathieu Desnoyers<b=
r>EfficiOS Inc.<br><a href=3D"http://www.efficios.com" target=3D"_blank">ht=
tp://www.efficios.com</a><br></div></span></span></div></div></blockquote><=
/div></div><br></blockquote></div></div></div><div><div class=3D"h5"><br><d=
iv>-- <br></div><div>Mathieu Desnoyers<br>EfficiOS Inc.<br><a href=3D"http:=
//www.efficios.com" target=3D"_blank">http://www.efficios.com</a></div></di=
v></div></div></div></blockquote></div><br></div>

--089e0122976eed7a4e0527f8943d--


--===============0119609768==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0119609768==--
