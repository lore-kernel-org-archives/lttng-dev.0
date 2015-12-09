From: Aravind HT <aravind.ht@gmail.com>
Subject: Re: Relayd trace drops
Date: Wed, 9 Dec 2015 15:04:59 +0530
Message-ID: <CACd+_b6xjN8BEcfqypkhGrM2XWwxhW9RmCVgHfN5jmksGmVnPw__4421.32408866218$1449653774$gmane$org@mail.gmail.com>
References: <CACd+_b7qEeW1XD1H_0MT4dDqwLv68rfOURfNDRh6SO=xS4k-Og@mail.gmail.com>
 <CA+jJMxsuF+Ywvvhe3L4OqBHTsohyFffPoF4mZWFDqPvBC-P80w@mail.gmail.com>
 <CACd+_b5AGJKWH58Kq3QP8qW8R7Q9JH3fqbEwU=z8pyg5-DL=KQ@mail.gmail.com>
 <CA+jJMxsJReP4ZO2bSJP-rJe+UoJzT09Pix1LhEypbsww_nwrsA@mail.gmail.com>
 <CACd+_b7ScRDo9uL+neOnA2pqVVwexsPsbBd2mBS--yy7Amxbmg@mail.gmail.com>
 <CAF4oYfF2Li4zau0OLE=JZUtGfPZyFT1FciBr7AG1hvzGdeUycA@mail.gmail.com>
 <CACd+_b6byMnZ_oWBqEk44fJOgpVX-oAGMjfh_WV8AV6cKyK9iw@mail.gmail.com>
 <56672F33.3070808@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0411040930=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-lf0-f54.google.com ([209.85.215.54])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <aravind.ht@gmail.com>) id 1a6b9N-0002DK-PX
 for lttng-dev@lists.lttng.org; Wed, 09 Dec 2015 04:35:08 -0500
Received: by lfs39 with SMTP id 39so30275326lfs.3
 for <lttng-dev@lists.lttng.org>; Wed, 09 Dec 2015 01:35:00 -0800 (PST)
In-Reply-To: <56672F33.3070808@efficios.com>
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

--===============0411040930==
Content-Type: multipart/alternative; boundary=001a114020a2d397a5052673cd7a

--001a114020a2d397a5052673cd7a
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Sorry about that, not sure how it got missed.
Here it is.


# This needs a two node set up (1. local current node 2. remote node )
# relayd runs on the current node where traces are captured from the remote
node
# remote node runs test applications which generate traces.
# the launch_script_RN is executed on the current node and uses ssh  to
execute commands on the remote node. So this part may not work in every
case and may prompt for a password.
# if experiencing problems with ssh , kindly check
http://serverfault.com/questions/241588/how-to-automate-ssh-login-with-pass=
word

# =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D       To Run=
        =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
launch_script_RN.py self_profile -c /tmp/configFile.txt



# configFile.txt is the file which has configuration params that
launchScript
# needs to configure lttng sessions. Below is an explanation of the
different options.
# =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D     configFile.=
txt   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D

[section1]
# final out put file path
OutputFile =3D /tmp/Final_report.txt
# the remote node hostname on which test applications run and the test
sessions will be created; this should be something that could be used with
ssh. Traces will be transported from this node to the lttng_relayd running
on the current node.
Node =3D MY_REMOTE_NODE
# Sub buffer size to start this with
SubBufSize =3D 16k
# Sub buffer count
SubBufCount =3D 4
# per uid buffer
BufferScheme =3D --buffers-uid
# yes
EnableTracing =3D yes
# Bit rate of the test applications. Comman seperated example "1, 3, 3, 50"
sayss 4 test applications producing 1, 3, 3, and 50 Kb/s traces.
# So with the below, we just start with 1 test application producing 10 kb/=
s
TestApps =3D 10
# session life time in seonds
TestTime =3D 10
# Max number of successive sessions to configure. if n then n-1 sessions
are run, ex MaxRun =3D 2 will run 1 session.
MaxRun =3D 100


# =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  Place the f=
ollowing files under =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

# /tmp on the remote node
clean_RemNode_apps.sh
report_lttng_script.sh

# rest of the scripts under /usr/sbin on the current local node on which
lttng_realyd runs
# Define a trace point MY_TRACE to take a single string arg with
LOG_TEST_APP_PROFILING as the provider, compile test lttng_testApp and
place it under /usr/sbin of the remote host

# in launch_script_RN.py change currentNodeIP to the IP address on which
relayd is receiving, default ports are used.

# lttng_relayd is started as
/usr/bin/lttng-relayd -o /var/log/lttng-traces -d

# lttng_sessiond is started as
/usr/bin/lttng-sessiond --consumerd32-path
/usr/lib/lttng/libexec/lttng-consumerd --consumerd32-libdir /usr/lib/
--consumerd64-path /usr/lib64/lttng/libexec/lttng-consumerd
--consumerd64-libdir /usr/lib64/ -b --no-kernel




Regards,
Aravind.

On Wed, Dec 9, 2015 at 12:57 AM, Jonathan Rajotte Julien <
Jonathan.rajotte-julien@efficios.com> wrote:

> Hi Aravind,
>
> There is no README in the archive you sent.
>
> Cheers
>
> On 2015-12-08 07:51 AM, Aravind HT wrote:
>
>> Hi,
>>
>> I am trying to upgrade in parallel, but this issue may still be present
>> after I upgrade or may be temporarily masked. So I need to find the root
>> cause for this and then see if its available on the latest before
>> committing to upgrade.
>>
>> There is another issue i'm hitting, the lttng list command hangs after
>> lttng destroy session when running the profiling.
>>
>> I found that consumerd 64 goes into an infinite loop waiting to flush
>> metadata in lttng_ustconsumer_recv_metadata() :: while
>> (consumer_metadata_cache_flushed(channel, offset + len, timer)) .
>> In consumer_metadata_cache, channel->metadata_stream->endpoint_status is
>> CONSUMER_ENDPOINT_ACTIVE, metadata_stream->ust_metadata_pushed is 0 with
>> offset having some value. This call always returns a 1 from the last els=
e{}
>> block resulting in an infinite loop. Upon searching the forum, I found t=
he
>> same issue being reported here :
>> https://www.mail-archive.com/lttng-dev@lists.lttng.org/msg07982.html
>>
>> Regards,
>> Aravind.
>>
>>
>> On Tue, Dec 8, 2015 at 12:43 AM, Jonathan Rajotte <
>> jonathan.r.julien@gmail.com> wrote:
>>
>>     Hi Aravind,
>>
>>     Did you have the chance to upgrade to 2.6.1.If so where you able
>>     to reproduce?
>>
>>     Cheers
>>
>>     On Mon, Dec 7, 2015 at 1:07 PM, Aravind HT <aravind.ht@gmail.com>
>>     wrote:
>>
>>         Hi,
>>
>>         I have attached the complete profiling scripts here, its a bit
>>         shabby, im new to python.
>>
>>         There is a README which has the details on how to execute it.
>>         Im using a Yocto 1.6 on x86_64 platforms on both the nodes.
>>
>>
>>         Running this script when there are other sessions running
>>         seems to reproduce this problem easily.
>>         Please try it and let me know if you have any issues
>>         reproducing the problem.
>>
>>         Regards,
>>         Aravind.
>>
>>         On Sat, Dec 5, 2015 at 5:23 PM, J=C3=A9r=C3=A9mie Galarneau
>>         <jeremie.galarneau@efficios.com
>>         <mailto:jeremie.galarneau@efficios.com>> wrote:
>>
>>             On Fri, Dec 4, 2015 at 11:06 PM, Aravind HT
>>             <aravind.ht@gmail.com <mailto:aravind.ht@gmail.com>> wrote:
>>             > I am using 2.6.0 .I will try to share the code that I'm
>>             using here in some
>>             > time. If there are any specific fixes that are relevant
>>             to this issue, see
>>             > if you can provide a link to them. I would ideally like
>>             to try them out
>>             > before trying a full upgrade to the latest versions.
>>
>>             Hi,
>>
>>             Can you provide more information on the system? Which
>>             distribution,
>>             architecture, kernel version?
>>
>>             The verbose sessiond logs might help pinpoint any
>>             unexpected behaviour
>>             here (are all applications registering as expected?).
>>
>>             J=C3=A9r=C3=A9mie
>>
>>             >
>>             > On Fri, Dec 4, 2015 at 6:11 PM, J=C3=A9r=C3=A9mie Galarnea=
u
>>             > <jeremie.galarneau@efficios.com
>>             <mailto:jeremie.galarneau@efficios.com>> wrote:
>>             >>
>>             >> Hi Aravind,
>>             >>
>>             >> Can't say I have looked at everything you sent yet, but
>>             as a
>>             >> preemptive question, which version are we talking about
>>             here? 2.6.0 or
>>             >> 2.6.1? 2.6.1 contains a lot of relay daemon fixes.
>>             >>
>>             >> Thanks,
>>             >> J=C3=A9r=C3=A9mie
>>             >>
>>             >> On Thu, Dec 3, 2015 at 7:01 AM, Aravind HT
>>             <aravind.ht@gmail.com> wrote:
>>             >> > Hi,
>>             >> >
>>             >> > I am trying to obtain the performance characteristics
>>             of lttng with the
>>             >> > use
>>             >> > of test applications. Traces are being produced on a
>>             local node and
>>             >> > delivered to relayd that is running on a separate
>>             node for storage.
>>             >> >
>>             >> > An lttng session with the test applications producing
>>             an initial bit
>>             >> > rate of
>>             >> > 10 kb/s is started and run for about 30 seconds. The
>>             starting sub-buffer
>>             >> > size is kept at 128 kb and sub-buf count at 4. The
>>             session is then
>>             >> > stopped
>>             >> > and destroyed and traces are analyzed to see if there
>>             are any drops.
>>             >> > This is
>>             >> > being done in a loop with every subsequent session
>>             having an increment
>>             >> > of 2
>>             >> > kb/s as long as there are no drops. If there are
>>             drops, I increase the
>>             >> > buffer size by a factor of x2 without incrementing
>>             the bit rate.
>>             >> >
>>             >> > I see trace drops happening consistently with test
>>             apps producing traces
>>             >> > at
>>             >> > less than 40 kb/s, it doesnt seem to help even if I
>>             started with 1mb x 4
>>             >> > sub-buffers.
>>             >> >
>>             >> > Analysis :
>>             >> >
>>             >> > I have attached the lttng_relayd , lttng_consumerd_64
>>             logs and the
>>             >> > entire
>>             >> > trace directory, hope you will be able to view it.
>>             >> > I have modified lttng_relayd code to dump the traces
>>             being captured in
>>             >> > the
>>             >> > lttng_relayd logs along with debug info.
>>             >> >
>>             >> > Each test app is producing logs in the form of  :
>>             >> > "TraceApp PID - 31940 THID - 31970 @threadRate - 1032
>>             b/s appRate - 2079
>>             >> > b/s
>>             >> > threadTraceNum - 9 appTraceNum - 18  sleepTime - 192120=
"
>>             >> >
>>             >> > The test application PID, test application thread id,
>>             thread bit rate,
>>             >> > test
>>             >> > app bit rate, thread trace number and application
>>             trace number s are
>>             >> > part of
>>             >> > the trace. So in the above trace, the thread is
>>             producing at 1 kb/s and
>>             >> > the
>>             >> > whole test app is producing at 2 kb/s.
>>             >> >
>>             >> > If we look at the babeltrace out put, we see that the
>>             Trace with
>>             >> > TraceApp
>>             >> > PID - 31940 appTraceNum 2 is missing , with 1, 3, 4,
>>             5 and so on being
>>             >> > successfully captured.
>>             >> > I looked at the lttng_relayd logs and found that
>>             trace of "appTraceNum
>>             >> > 2" is
>>             >> > not delivered/generated by the consumerd to the
>>             relayd in sequence with
>>             >> > other traces. To rule out that this is not a test
>>             application problem,
>>             >> > you
>>             >> > can look at line ltttng_relayd log : 12778 and see
>>             traces from
>>             >> > appTraceNum -
>>             >> > 1 to appTraceNum - 18 including the appTraceNum 2 are
>>             "re-delivered" by
>>             >> > the
>>             >> > consumerd to the relayd.
>>             >> > Essentially, I see appTraceNum 1 through appTraceNum
>>             18 being delivered
>>             >> > twice, once individually where appTraceNum 2 is
>>             missing and once as a
>>             >> > group
>>             >> > at line 12778 where its present.
>>             >> >
>>             >> >
>>             >> > Request help with
>>             >> > 1. why traces are delivered twice, is it by design or
>>             a genuine problem
>>             >> > ?
>>             >> > 2. how to avoid traces being dropped even though
>>             buffers are
>>             >> > sufficiently
>>             >> > large enough ?
>>             >> >
>>             >> >
>>             >> > Regards,
>>             >> > Aravind.
>>             >> >
>>             >> > _______________________________________________
>>             >> > lttng-dev mailing list
>>             >> > lttng-dev@lists.lttng.org
>>             >> >
>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>>             >> >
>>             >>
>>             >>
>>             >>
>>             >> --
>>             >> J=C3=A9r=C3=A9mie Galarneau
>>             >> EfficiOS Inc.
>>             >> http://www.efficios.com
>>             >
>>             >
>>
>>
>>
>>             --
>>             J=C3=A9r=C3=A9mie Galarneau
>>             EfficiOS Inc.
>>             http://www.efficios.com
>>
>>
>>
>>         _______________________________________________
>>         lttng-dev mailing list
>>         lttng-dev@lists.lttng.org <mailto:lttng-dev@lists.lttng.org>
>>         http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>>
>>
>>
>>
>>     --     Jonathan Rajotte Julien
>>
>>
>>
>>
>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>>
>
> --
> Jonathan R. Julien
> Efficios
>
>

--001a114020a2d397a5052673cd7a
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Sorry about that, not sure how it got missed.<div>Here it =
is.</div><div><br></div><div><br></div><div><div># This needs a two node se=
t up (1. local current node 2. remote node )</div><div># relayd runs on the=
 current node where traces are captured from the remote node</div><div># re=
mote node runs test applications which generate traces.</div><div># the lau=
nch_script_RN is executed on the current node and uses ssh =C2=A0to execute=
 commands on the remote node. So this part may not work in every case and m=
ay prompt for a password.</div><div># if experiencing problems with ssh , k=
indly check <a href=3D"http://serverfault.com/questions/241588/how-to-autom=
ate-ssh-login-with-password">http://serverfault.com/questions/241588/how-to=
-automate-ssh-login-with-password</a></div><div><br></div><div># =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =C2=A0 =C2=A0 =C2=A0 To=
 Run =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</div><div>launch_script_RN.py=
 self_profile -c /tmp/configFile.txt</div><div><br></div><div><br></div><di=
v><br></div><div># configFile.txt is the file which has configuration param=
s that launchScript</div><div># needs to configure lttng sessions. Below is=
 an explanation of the different options.</div><div># =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =C2=A0 =C2=A0 configFile.txt =C2=A0 =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D</div><div><br></div><div>[section1]</div><div># final out put =
file path</div><div>OutputFile =3D /tmp/Final_report.txt</div><div># the re=
mote node hostname on which test applications run and the test sessions wil=
l be created; this should be something that could be used with ssh. Traces =
will be transported from this node to the lttng_relayd running on the curre=
nt node.</div><div>Node =3D MY_REMOTE_NODE</div><div># Sub buffer size to s=
tart this with</div><div>SubBufSize =3D 16k</div><div># Sub buffer count</d=
iv><div>SubBufCount =3D 4</div><div># per uid buffer</div><div>BufferScheme=
 =3D --buffers-uid</div><div># yes</div><div>EnableTracing =3D yes</div><di=
v># Bit rate of the test applications. Comman seperated example &quot;1, 3,=
 3, 50&quot; sayss 4 test applications producing 1, 3, 3, and 50 Kb/s trace=
s.</div><div># So with the below, we just start with 1 test application pro=
ducing 10 kb/s</div><div>TestApps =3D 10</div><div># session life time in s=
eonds</div><div>TestTime =3D 10</div><div># Max number of successive sessio=
ns to configure. if n then n-1 sessions are run, ex MaxRun =3D 2 will run 1=
 session.</div><div>MaxRun =3D 100</div><div><br></div><div><br></div><div>=
# =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =C2=A0Place =
the following files under =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</di=
v><div><br></div><div># /tmp on the remote node</div><div>clean_RemNode_app=
s.sh</div><div>report_lttng_script.sh</div><div><br></div><div># rest of th=
e scripts under /usr/sbin on the current local node on which lttng_realyd r=
uns</div><div># Define a trace point MY_TRACE to take a single string arg w=
ith LOG_TEST_APP_PROFILING as the provider, compile test lttng_testApp and =
place it under /usr/sbin of the remote host</div><div><br></div><div># in l=
aunch_script_RN.py change currentNodeIP to the IP address on which relayd i=
s receiving, default ports are used.<br></div><div><br></div><div># lttng_r=
elayd is started as</div><div>/usr/bin/lttng-relayd -o /var/log/lttng-trace=
s -d</div><div><br></div><div># lttng_sessiond is started as</div><div>/usr=
/bin/lttng-sessiond --consumerd32-path /usr/lib/lttng/libexec/lttng-consume=
rd --consumerd32-libdir /usr/lib/ --consumerd64-path /usr/lib64/lttng/libex=
ec/lttng-consumerd --consumerd64-libdir /usr/lib64/ -b --no-kernel</div><di=
v><br></div><div><br></div></div><div><br></div><div><br></div><div>Regards=
,</div><div>Aravind.</div></div><div class=3D"gmail_extra"><br><div class=
=3D"gmail_quote">On Wed, Dec 9, 2015 at 12:57 AM, Jonathan Rajotte Julien <=
span dir=3D"ltr">&lt;<a href=3D"mailto:Jonathan.rajotte-julien@efficios.com=
" target=3D"_blank">Jonathan.rajotte-julien@efficios.com</a>&gt;</span> wro=
te:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-=
left:1px #ccc solid;padding-left:1ex">Hi Aravind,<br>
<br>
There is no README in the archive you sent.<br>
<br>
Cheers<span class=3D""><br>
<br>
On 2015-12-08 07:51 AM, Aravind HT wrote:<br>
</span><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-=
left:1px #ccc solid;padding-left:1ex">
Hi,<br>
<br><div><div class=3D"h5">
I am trying to upgrade in parallel, but this issue may still be present aft=
er I upgrade or may be temporarily masked. So I need to find the root cause=
 for this and then see if its available on the latest before committing to =
upgrade.<br>
<br>
There is another issue i&#39;m hitting, the lttng list command hangs after =
lttng destroy session when running the profiling.<br>
<br>
I found that consumerd 64 goes into an infinite loop waiting to flush metad=
ata in lttng_ustconsumer_recv_metadata() :: while (consumer_metadata_cache_=
flushed(channel, offset + len, timer)) .<br>
In consumer_metadata_cache, channel-&gt;metadata_stream-&gt;endpoint_status=
 is CONSUMER_ENDPOINT_ACTIVE, metadata_stream-&gt;ust_metadata_pushed is 0 =
with offset having some value. This call always returns a 1 from the last e=
lse{} block resulting in an infinite loop. Upon searching the forum, I foun=
d the same issue being reported here :<br>
<a href=3D"https://www.mail-archive.com/lttng-dev@lists.lttng.org/msg07982.=
html" rel=3D"noreferrer" target=3D"_blank">https://www.mail-archive.com/ltt=
ng-dev@lists.lttng.org/msg07982.html</a><br>
<br>
Regards,<br>
Aravind.<br>
<br>
<br>
On Tue, Dec 8, 2015 at 12:43 AM, Jonathan Rajotte &lt;<a href=3D"mailto:jon=
athan.r.julien@gmail.com" target=3D"_blank">jonathan.r.julien@gmail.com</a>=
&gt; wrote:<br>
<br>
=C2=A0 =C2=A0 Hi Aravind,<br>
<br>
=C2=A0 =C2=A0 Did you have the chance to upgrade to 2.6.1.If so where you a=
ble<br>
=C2=A0 =C2=A0 to reproduce?<br>
<br>
=C2=A0 =C2=A0 Cheers<br>
<br>
=C2=A0 =C2=A0 On Mon, Dec 7, 2015 at 1:07 PM, Aravind HT &lt;<a href=3D"mai=
lto:aravind.ht@gmail.com" target=3D"_blank">aravind.ht@gmail.com</a>&gt;<br=
>
=C2=A0 =C2=A0 wrote:<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Hi,<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 I have attached the complete profiling scripts =
here, its a bit<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 shabby, im new to python.<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 There is a README which has the details on how =
to execute it.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Im using a Yocto 1.6 on x86_64 platforms on bot=
h the nodes.<br>
<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Running this script when there are other sessio=
ns running<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 seems to reproduce this problem easily.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Please try it and let me know if you have any i=
ssues<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 reproducing the problem.<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Regards,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Aravind.<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 On Sat, Dec 5, 2015 at 5:23 PM, J=C3=A9r=C3=A9m=
ie Galarneau<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;<a href=3D"mailto:jeremie.galarneau@efficio=
s.com" target=3D"_blank">jeremie.galarneau@efficios.com</a><br></div></div>=
<span class=3D"">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;mailto:<a href=3D"mailto:jeremie.galarneau@=
efficios.com" target=3D"_blank">jeremie.galarneau@efficios.com</a>&gt;&gt; =
wrote:<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 On Fri, Dec 4, 2015 at 11:06 PM, =
Aravind HT<br></span><span class=3D"">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;<a href=3D"mailto:aravind.ht@=
gmail.com" target=3D"_blank">aravind.ht@gmail.com</a> &lt;mailto:<a href=3D=
"mailto:aravind.ht@gmail.com" target=3D"_blank">aravind.ht@gmail.com</a>&gt=
;&gt; wrote:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; I am using 2.6.0 .I will try=
 to share the code that I&#39;m<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 using here in some<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; time. If there are any speci=
fic fixes that are relevant<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 to this issue, see<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; if you can provide a link to=
 them. I would ideally like<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 to try them out<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; before trying a full upgrade=
 to the latest versions.<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Hi,<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Can you provide more information =
on the system? Which<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 distribution,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 architecture, kernel version?<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 The verbose sessiond logs might h=
elp pinpoint any<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unexpected behaviour<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 here (are all applications regist=
ering as expected?).<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 J=C3=A9r=C3=A9mie<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; On Fri, Dec 4, 2015 at 6:11 =
PM, J=C3=A9r=C3=A9mie Galarneau<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; &lt;<a href=3D"mailto:jeremi=
e.galarneau@efficios.com" target=3D"_blank">jeremie.galarneau@efficios.com<=
/a><br></span><div><div class=3D"h5">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;mailto:<a href=3D"mailto:jere=
mie.galarneau@efficios.com" target=3D"_blank">jeremie.galarneau@efficios.co=
m</a>&gt;&gt; wrote:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; Hi Aravind,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; Can&#39;t say I have loo=
ked at everything you sent yet, but<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 as a<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; preemptive question, whi=
ch version are we talking about<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 here? 2.6.0 or<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; 2.6.1? 2.6.1 contains a =
lot of relay daemon fixes.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; Thanks,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; J=C3=A9r=C3=A9mie<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; On Thu, Dec 3, 2015 at 7=
:01 AM, Aravind HT<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;<a href=3D"mailto:aravind.ht@=
gmail.com" target=3D"_blank">aravind.ht@gmail.com</a>&gt; wrote:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; &gt; Hi,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; &gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; &gt; I am trying to obta=
in the performance characteristics<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 of lttng with the<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; &gt; use<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; &gt; of test application=
s. Traces are being produced on a<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 local node and<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; &gt; delivered to relayd=
 that is running on a separate<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 node for storage.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; &gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; &gt; An lttng session wi=
th the test applications producing<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 an initial bit<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; &gt; rate of<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; &gt; 10 kb/s is started =
and run for about 30 seconds. The<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 starting sub-buffer<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; &gt; size is kept at 128=
 kb and sub-buf count at 4. The<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 session is then<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; &gt; stopped<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; &gt; and destroyed and t=
races are analyzed to see if there<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 are any drops.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; &gt; This is<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; &gt; being done in a loo=
p with every subsequent session<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 having an increment<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; &gt; of 2<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; &gt; kb/s as long as the=
re are no drops. If there are<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 drops, I increase the<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; &gt; buffer size by a fa=
ctor of x2 without incrementing<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 the bit rate.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; &gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; &gt; I see trace drops h=
appening consistently with test<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 apps producing traces<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; &gt; at<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; &gt; less than 40 kb/s, =
it doesnt seem to help even if I<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 started with 1mb x 4<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; &gt; sub-buffers.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; &gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; &gt; Analysis :<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; &gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; &gt; I have attached the=
 lttng_relayd , lttng_consumerd_64<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 logs and the<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; &gt; entire<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; &gt; trace directory, ho=
pe you will be able to view it.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; &gt; I have modified ltt=
ng_relayd code to dump the traces<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 being captured in<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; &gt; the<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; &gt; lttng_relayd logs a=
long with debug info.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; &gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; &gt; Each test app is pr=
oducing logs in the form of=C2=A0 :<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; &gt; &quot;TraceApp PID =
- 31940 THID - 31970 @threadRate - 1032<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 b/s appRate - 2079<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; &gt; b/s<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; &gt; threadTraceNum - 9 =
appTraceNum - 18=C2=A0 sleepTime - 192120&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; &gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; &gt; The test applicatio=
n PID, test application thread id,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 thread bit rate,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; &gt; test<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; &gt; app bit rate, threa=
d trace number and application<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 trace number s are<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; &gt; part of<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; &gt; the trace. So in th=
e above trace, the thread is<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 producing at 1 kb/s and<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; &gt; the<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; &gt; whole test app is p=
roducing at 2 kb/s.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; &gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; &gt; If we look at the b=
abeltrace out put, we see that the<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Trace with<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; &gt; TraceApp<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; &gt; PID - 31940 appTrac=
eNum 2 is missing , with 1, 3, 4,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 5 and so on being<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; &gt; successfully captur=
ed.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; &gt; I looked at the ltt=
ng_relayd logs and found that<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 trace of &quot;appTraceNum<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; &gt; 2&quot; is<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; &gt; not delivered/gener=
ated by the consumerd to the<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 relayd in sequence with<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; &gt; other traces. To ru=
le out that this is not a test<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 application problem,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; &gt; you<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; &gt; can look at line lt=
ttng_relayd log : 12778 and see<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 traces from<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; &gt; appTraceNum -<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; &gt; 1 to appTraceNum - =
18 including the appTraceNum 2 are<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;re-delivered&quot; by<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; &gt; the<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; &gt; consumerd to the re=
layd.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; &gt; Essentially, I see =
appTraceNum 1 through appTraceNum<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 18 being delivered<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; &gt; twice, once individ=
ually where appTraceNum 2 is<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 missing and once as a<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; &gt; group<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; &gt; at line 12778 where=
 its present.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; &gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; &gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; &gt; Request help with<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; &gt; 1. why traces are d=
elivered twice, is it by design or<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 a genuine problem<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; &gt; ?<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; &gt; 2. how to avoid tra=
ces being dropped even though<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 buffers are<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; &gt; sufficiently<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; &gt; large enough ?<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; &gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; &gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; &gt; Regards,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; &gt; Aravind.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; &gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; &gt; ___________________=
____________________________<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; &gt; lttng-dev mailing l=
ist<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; &gt; <a href=3D"mailto:l=
ttng-dev@lists.lttng.org" target=3D"_blank">lttng-dev@lists.lttng.org</a><b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; &gt; <a href=3D"http://l=
ists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" rel=3D"noreferrer" targe=
t=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a><=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; &gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; --<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; J=C3=A9r=C3=A9mie Galarn=
eau<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; EfficiOS Inc.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; <a href=3D"http://www.ef=
ficios.com" rel=3D"noreferrer" target=3D"_blank">http://www.efficios.com</a=
><br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;<br>
<br>
<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 --<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 J=C3=A9r=C3=A9mie Galarneau<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 EfficiOS Inc.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"http://www.efficios.co=
m" rel=3D"noreferrer" target=3D"_blank">http://www.efficios.com</a><br>
<br>
<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 _______________________________________________=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 lttng-dev mailing list<br></div></div>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"mailto:lttng-dev@lists.lttng.org" ta=
rget=3D"_blank">lttng-dev@lists.lttng.org</a> &lt;mailto:<a href=3D"mailto:=
lttng-dev@lists.lttng.org" target=3D"_blank">lttng-dev@lists.lttng.org</a>&=
gt;<span class=3D""><br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"http://lists.lttng.org/cgi-bin/mailm=
an/listinfo/lttng-dev" rel=3D"noreferrer" target=3D"_blank">http://lists.lt=
tng.org/cgi-bin/mailman/listinfo/lttng-dev</a><br>
<br>
<br>
<br>
<br>
=C2=A0 =C2=A0 --=C2=A0 =C2=A0 =C2=A0Jonathan Rajotte Julien<br>
<br>
<br>
<br>
<br>
_______________________________________________<br>
lttng-dev mailing list<br>
<a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-dev@li=
sts.lttng.org</a><br>
<a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" rel=
=3D"noreferrer" target=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/li=
stinfo/lttng-dev</a><br>
</span></blockquote><span class=3D"HOEnZb"><font color=3D"#888888">
<br>
-- <br>
Jonathan R. Julien<br>
Efficios<br>
<br>
</font></span></blockquote></div><br></div>

--001a114020a2d397a5052673cd7a--


--===============0411040930==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0411040930==--
