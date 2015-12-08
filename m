From: Aravind HT <aravind.ht@gmail.com>
Subject: Re: Relayd trace drops
Date: Tue, 8 Dec 2015 18:21:07 +0530
Message-ID: <CACd+_b6byMnZ_oWBqEk44fJOgpVX-oAGMjfh_WV8AV6cKyK9iw__3713.74817700616$1449579131$gmane$org@mail.gmail.com>
References: <CACd+_b7qEeW1XD1H_0MT4dDqwLv68rfOURfNDRh6SO=xS4k-Og@mail.gmail.com>
 <CA+jJMxsuF+Ywvvhe3L4OqBHTsohyFffPoF4mZWFDqPvBC-P80w@mail.gmail.com>
 <CACd+_b5AGJKWH58Kq3QP8qW8R7Q9JH3fqbEwU=z8pyg5-DL=KQ@mail.gmail.com>
 <CA+jJMxsJReP4ZO2bSJP-rJe+UoJzT09Pix1LhEypbsww_nwrsA@mail.gmail.com>
 <CACd+_b7ScRDo9uL+neOnA2pqVVwexsPsbBd2mBS--yy7Amxbmg@mail.gmail.com>
 <CAF4oYfF2Li4zau0OLE=JZUtGfPZyFT1FciBr7AG1hvzGdeUycA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1998854943=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-lb0-f179.google.com ([209.85.217.179])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <aravind.ht@gmail.com>) id 1a6Hjd-0004hV-2u
 for lttng-dev@lists.lttng.org; Tue, 08 Dec 2015 07:51:17 -0500
Received: by lbpu9 with SMTP id u9so10362376lbp.2
 for <lttng-dev@lists.lttng.org>; Tue, 08 Dec 2015 04:51:07 -0800 (PST)
In-Reply-To: <CAF4oYfF2Li4zau0OLE=JZUtGfPZyFT1FciBr7AG1hvzGdeUycA@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Jonathan Rajotte <jonathan.r.julien@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============1998854943==
Content-Type: multipart/alternative; boundary=047d7b3a88885feb840526626d15

--047d7b3a88885feb840526626d15
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

I am trying to upgrade in parallel, but this issue may still be present
after I upgrade or may be temporarily masked. So I need to find the root
cause for this and then see if its available on the latest before
committing to upgrade.

There is another issue i'm hitting, the lttng list command hangs after
lttng destroy session when running the profiling.

I found that consumerd 64 goes into an infinite loop waiting to flush
metadata in lttng_ustconsumer_recv_metadata() :: while
(consumer_metadata_cache_flushed(channel, offset + len, timer)) .
In consumer_metadata_cache, channel->metadata_stream->endpoint_status
is CONSUMER_ENDPOINT_ACTIVE, metadata_stream->ust_metadata_pushed is 0 with
offset having some value. This call always returns a 1 from the last else{}
block resulting in an infinite loop. Upon searching the forum, I found the
same issue being reported here :
 https://www.mail-archive.com/lttng-dev@lists.lttng.org/msg07982.html

Regards,
Aravind.


On Tue, Dec 8, 2015 at 12:43 AM, Jonathan Rajotte <
jonathan.r.julien@gmail.com> wrote:

> Hi Aravind,
>
> Did you have the chance to upgrade to 2.6.1.If so where you able to
> reproduce?
>
> Cheers
>
> On Mon, Dec 7, 2015 at 1:07 PM, Aravind HT <aravind.ht@gmail.com> wrote:
>
>> Hi,
>>
>> I have attached the complete profiling scripts here, its a bit shabby, i=
m
>> new to python.
>>
>> There is a README which has the details on how to execute it.
>> Im using a Yocto 1.6 on x86_64 platforms on both the nodes.
>>
>>
>> Running this script when there are other sessions running seems to
>> reproduce this problem easily.
>> Please try it and let me know if you have any issues reproducing the
>> problem.
>>
>> Regards,
>> Aravind.
>>
>> On Sat, Dec 5, 2015 at 5:23 PM, J=C3=A9r=C3=A9mie Galarneau <
>> jeremie.galarneau@efficios.com> wrote:
>>
>>> On Fri, Dec 4, 2015 at 11:06 PM, Aravind HT <aravind.ht@gmail.com>
>>> wrote:
>>> > I am using 2.6.0 .I will try to share the code that I'm using here in
>>> some
>>> > time. If there are any specific fixes that are relevant to this issue=
,
>>> see
>>> > if you can provide a link to them. I would ideally like to try them o=
ut
>>> > before trying a full upgrade to the latest versions.
>>>
>>> Hi,
>>>
>>> Can you provide more information on the system? Which distribution,
>>> architecture, kernel version?
>>>
>>> The verbose sessiond logs might help pinpoint any unexpected behaviour
>>> here (are all applications registering as expected?).
>>>
>>> J=C3=A9r=C3=A9mie
>>>
>>> >
>>> > On Fri, Dec 4, 2015 at 6:11 PM, J=C3=A9r=C3=A9mie Galarneau
>>> > <jeremie.galarneau@efficios.com> wrote:
>>> >>
>>> >> Hi Aravind,
>>> >>
>>> >> Can't say I have looked at everything you sent yet, but as a
>>> >> preemptive question, which version are we talking about here? 2.6.0 =
or
>>> >> 2.6.1? 2.6.1 contains a lot of relay daemon fixes.
>>> >>
>>> >> Thanks,
>>> >> J=C3=A9r=C3=A9mie
>>> >>
>>> >> On Thu, Dec 3, 2015 at 7:01 AM, Aravind HT <aravind.ht@gmail.com>
>>> wrote:
>>> >> > Hi,
>>> >> >
>>> >> > I am trying to obtain the performance characteristics of lttng wit=
h
>>> the
>>> >> > use
>>> >> > of test applications. Traces are being produced on a local node an=
d
>>> >> > delivered to relayd that is running on a separate node for storage=
.
>>> >> >
>>> >> > An lttng session with the test applications producing an initial b=
it
>>> >> > rate of
>>> >> > 10 kb/s is started and run for about 30 seconds. The starting
>>> sub-buffer
>>> >> > size is kept at 128 kb and sub-buf count at 4. The session is then
>>> >> > stopped
>>> >> > and destroyed and traces are analyzed to see if there are any drop=
s.
>>> >> > This is
>>> >> > being done in a loop with every subsequent session having an
>>> increment
>>> >> > of 2
>>> >> > kb/s as long as there are no drops. If there are drops, I increase
>>> the
>>> >> > buffer size by a factor of x2 without incrementing the bit rate.
>>> >> >
>>> >> > I see trace drops happening consistently with test apps producing
>>> traces
>>> >> > at
>>> >> > less than 40 kb/s, it doesnt seem to help even if I started with
>>> 1mb x 4
>>> >> > sub-buffers.
>>> >> >
>>> >> > Analysis :
>>> >> >
>>> >> > I have attached the lttng_relayd , lttng_consumerd_64 logs and the
>>> >> > entire
>>> >> > trace directory, hope you will be able to view it.
>>> >> > I have modified lttng_relayd code to dump the traces being capture=
d
>>> in
>>> >> > the
>>> >> > lttng_relayd logs along with debug info.
>>> >> >
>>> >> > Each test app is producing logs in the form of  :
>>> >> > "TraceApp PID - 31940 THID - 31970 @threadRate - 1032 b/s appRate =
-
>>> 2079
>>> >> > b/s
>>> >> > threadTraceNum - 9 appTraceNum - 18  sleepTime - 192120"
>>> >> >
>>> >> > The test application PID, test application thread id, thread bit
>>> rate,
>>> >> > test
>>> >> > app bit rate, thread trace number and application trace number s a=
re
>>> >> > part of
>>> >> > the trace. So in the above trace, the thread is producing at 1 kb/=
s
>>> and
>>> >> > the
>>> >> > whole test app is producing at 2 kb/s.
>>> >> >
>>> >> > If we look at the babeltrace out put, we see that the Trace with
>>> >> > TraceApp
>>> >> > PID - 31940 appTraceNum 2 is missing , with 1, 3, 4, 5 and so on
>>> being
>>> >> > successfully captured.
>>> >> > I looked at the lttng_relayd logs and found that trace of
>>> "appTraceNum
>>> >> > 2" is
>>> >> > not delivered/generated by the consumerd to the relayd in sequence
>>> with
>>> >> > other traces. To rule out that this is not a test application
>>> problem,
>>> >> > you
>>> >> > can look at line ltttng_relayd log : 12778 and see traces from
>>> >> > appTraceNum -
>>> >> > 1 to appTraceNum - 18 including the appTraceNum 2 are
>>> "re-delivered" by
>>> >> > the
>>> >> > consumerd to the relayd.
>>> >> > Essentially, I see appTraceNum 1 through appTraceNum 18 being
>>> delivered
>>> >> > twice, once individually where appTraceNum 2 is missing and once a=
s
>>> a
>>> >> > group
>>> >> > at line 12778 where its present.
>>> >> >
>>> >> >
>>> >> > Request help with
>>> >> > 1. why traces are delivered twice, is it by design or a genuine
>>> problem
>>> >> > ?
>>> >> > 2. how to avoid traces being dropped even though buffers are
>>> >> > sufficiently
>>> >> > large enough ?
>>> >> >
>>> >> >
>>> >> > Regards,
>>> >> > Aravind.
>>> >> >
>>> >> > _______________________________________________
>>> >> > lttng-dev mailing list
>>> >> > lttng-dev@lists.lttng.org
>>> >> > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>>> >> >
>>> >>
>>> >>
>>> >>
>>> >> --
>>> >> J=C3=A9r=C3=A9mie Galarneau
>>> >> EfficiOS Inc.
>>> >> http://www.efficios.com
>>> >
>>> >
>>>
>>>
>>>
>>> --
>>> J=C3=A9r=C3=A9mie Galarneau
>>> EfficiOS Inc.
>>> http://www.efficios.com
>>>
>>
>>
>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>>
>>
>
>
> --
> Jonathan Rajotte Julien
>
>

--047d7b3a88885feb840526626d15
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><div><br></div><div>I am trying to upgrade i=
n parallel, but this issue may still be present after I upgrade or may be t=
emporarily masked. So I need to find the root cause for this and then see i=
f its available on the latest before committing to upgrade.</div><div><br><=
/div><div>There is another issue i&#39;m hitting, the lttng list command ha=
ngs after lttng destroy session when running the profiling.=C2=A0</div><div=
><br></div><div>I found that consumerd 64 goes into an infinite loop waitin=
g to flush metadata in=C2=A0lttng_ustconsumer_recv_metadata() :: while (con=
sumer_metadata_cache_flushed(channel, offset + len, timer)) .</div><div>In =
consumer_metadata_cache,=C2=A0channel-&gt;metadata_stream-&gt;endpoint_stat=
us is=C2=A0CONSUMER_ENDPOINT_ACTIVE, metadata_stream-&gt;ust_metadata_pushe=
d is 0 with offset having some value. This call always returns a 1 from the=
 last else{} block resulting in an infinite loop. Upon searching the forum,=
 I found the same issue being reported here :</div><div><span style=3D"colo=
r:rgb(0,0,0);font-family:sans-serif;font-size:12.7px;line-height:19.05px">=
=C2=A0</span><a href=3D"https://www.mail-archive.com/lttng-dev@lists.lttng.=
org/msg07982.html" class=3D"" title=3D"https://www.mail-archive.com/lttng-d=
ev@lists.lttng.org/msg07982.html" rel=3D"nofollow" style=3D"color:rgb(51,10=
2,187);padding:0px 16px 0px 0px;font-family:sans-serif;font-size:12.7px;lin=
e-height:19.05px;background-image:url(&quot;lock_icon.gif&quot;);background=
-repeat:no-repeat">https://www.mail-archive.com/lttng-dev@lists.lttng.org/m=
sg07982.html</a><br></div><div><br></div><div>Regards,</div><div>Aravind.</=
div><div><br></div></div><div class=3D"gmail_extra"><br><div class=3D"gmail=
_quote">On Tue, Dec 8, 2015 at 12:43 AM, Jonathan Rajotte <span dir=3D"ltr"=
>&lt;<a href=3D"mailto:jonathan.r.julien@gmail.com" target=3D"_blank">jonat=
han.r.julien@gmail.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_=
quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1=
ex"><div dir=3D"ltr">Hi Aravind,<div><br></div><div>Did you have the chance=
 to upgrade to 2.6.1.If so where you able to reproduce?</div><div><br></div=
><div>Cheers</div></div><div class=3D"gmail_extra"><div><div class=3D"h5"><=
br><div class=3D"gmail_quote">On Mon, Dec 7, 2015 at 1:07 PM, Aravind HT <s=
pan dir=3D"ltr">&lt;<a href=3D"mailto:aravind.ht@gmail.com" target=3D"_blan=
k">aravind.ht@gmail.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail=
_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:=
1ex"><div dir=3D"ltr">Hi,<div><br></div><div>I have attached the complete p=
rofiling scripts here, its a bit shabby, im new to python.</div><div><br></=
div><div>There is a README which has the details on how to execute it.=C2=
=A0</div><div>Im using a Yocto 1.6 on x86_64 platforms on both the nodes.=
=C2=A0</div><div><br></div><div><br></div><div>Running this script when the=
re are other sessions running seems to reproduce this problem easily.</div>=
<div>Please try it and let me know if you have any issues reproducing the p=
roblem.<br></div><div><br></div><div>Regards,</div><div>Aravind.</div></div=
><div><div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Sat=
, Dec 5, 2015 at 5:23 PM, J=C3=A9r=C3=A9mie Galarneau <span dir=3D"ltr">&lt=
;<a href=3D"mailto:jeremie.galarneau@efficios.com" target=3D"_blank">jeremi=
e.galarneau@efficios.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmai=
l_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left=
:1ex"><span>On Fri, Dec 4, 2015 at 11:06 PM, Aravind HT &lt;<a href=3D"mail=
to:aravind.ht@gmail.com" target=3D"_blank">aravind.ht@gmail.com</a>&gt; wro=
te:<br>
&gt; I am using 2.6.0 .I will try to share the code that I&#39;m using here=
 in some<br>
&gt; time. If there are any specific fixes that are relevant to this issue,=
 see<br>
&gt; if you can provide a link to them. I would ideally like to try them ou=
t<br>
&gt; before trying a full upgrade to the latest versions.<br>
<br>
</span>Hi,<br>
<br>
Can you provide more information on the system? Which distribution,<br>
architecture, kernel version?<br>
<br>
The verbose sessiond logs might help pinpoint any unexpected behaviour<br>
here (are all applications registering as expected?).<br>
<span><font color=3D"#888888"><br>
J=C3=A9r=C3=A9mie<br>
</font></span><div><div><br>
&gt;<br>
&gt; On Fri, Dec 4, 2015 at 6:11 PM, J=C3=A9r=C3=A9mie Galarneau<br>
&gt; &lt;<a href=3D"mailto:jeremie.galarneau@efficios.com" target=3D"_blank=
">jeremie.galarneau@efficios.com</a>&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt; Hi Aravind,<br>
&gt;&gt;<br>
&gt;&gt; Can&#39;t say I have looked at everything you sent yet, but as a<b=
r>
&gt;&gt; preemptive question, which version are we talking about here? 2.6.=
0 or<br>
&gt;&gt; 2.6.1? 2.6.1 contains a lot of relay daemon fixes.<br>
&gt;&gt;<br>
&gt;&gt; Thanks,<br>
&gt;&gt; J=C3=A9r=C3=A9mie<br>
&gt;&gt;<br>
&gt;&gt; On Thu, Dec 3, 2015 at 7:01 AM, Aravind HT &lt;<a href=3D"mailto:a=
ravind.ht@gmail.com" target=3D"_blank">aravind.ht@gmail.com</a>&gt; wrote:<=
br>
&gt;&gt; &gt; Hi,<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; I am trying to obtain the performance characteristics of lttn=
g with the<br>
&gt;&gt; &gt; use<br>
&gt;&gt; &gt; of test applications. Traces are being produced on a local no=
de and<br>
&gt;&gt; &gt; delivered to relayd that is running on a separate node for st=
orage.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; An lttng session with the test applications producing an init=
ial bit<br>
&gt;&gt; &gt; rate of<br>
&gt;&gt; &gt; 10 kb/s is started and run for about 30 seconds. The starting=
 sub-buffer<br>
&gt;&gt; &gt; size is kept at 128 kb and sub-buf count at 4. The session is=
 then<br>
&gt;&gt; &gt; stopped<br>
&gt;&gt; &gt; and destroyed and traces are analyzed to see if there are any=
 drops.<br>
&gt;&gt; &gt; This is<br>
&gt;&gt; &gt; being done in a loop with every subsequent session having an =
increment<br>
&gt;&gt; &gt; of 2<br>
&gt;&gt; &gt; kb/s as long as there are no drops. If there are drops, I inc=
rease the<br>
&gt;&gt; &gt; buffer size by a factor of x2 without incrementing the bit ra=
te.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; I see trace drops happening consistently with test apps produ=
cing traces<br>
&gt;&gt; &gt; at<br>
&gt;&gt; &gt; less than 40 kb/s, it doesnt seem to help even if I started w=
ith 1mb x 4<br>
&gt;&gt; &gt; sub-buffers.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Analysis :<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; I have attached the lttng_relayd , lttng_consumerd_64 logs an=
d the<br>
&gt;&gt; &gt; entire<br>
&gt;&gt; &gt; trace directory, hope you will be able to view it.<br>
&gt;&gt; &gt; I have modified lttng_relayd code to dump the traces being ca=
ptured in<br>
&gt;&gt; &gt; the<br>
&gt;&gt; &gt; lttng_relayd logs along with debug info.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Each test app is producing logs in the form of=C2=A0 :<br>
&gt;&gt; &gt; &quot;TraceApp PID - 31940 THID - 31970 @threadRate - 1032 b/=
s appRate - 2079<br>
&gt;&gt; &gt; b/s<br>
&gt;&gt; &gt; threadTraceNum - 9 appTraceNum - 18=C2=A0 sleepTime - 192120&=
quot;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; The test application PID, test application thread id, thread =
bit rate,<br>
&gt;&gt; &gt; test<br>
&gt;&gt; &gt; app bit rate, thread trace number and application trace numbe=
r s are<br>
&gt;&gt; &gt; part of<br>
&gt;&gt; &gt; the trace. So in the above trace, the thread is producing at =
1 kb/s and<br>
&gt;&gt; &gt; the<br>
&gt;&gt; &gt; whole test app is producing at 2 kb/s.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; If we look at the babeltrace out put, we see that the Trace w=
ith<br>
&gt;&gt; &gt; TraceApp<br>
&gt;&gt; &gt; PID - 31940 appTraceNum 2 is missing , with 1, 3, 4, 5 and so=
 on being<br>
&gt;&gt; &gt; successfully captured.<br>
&gt;&gt; &gt; I looked at the lttng_relayd logs and found that trace of &qu=
ot;appTraceNum<br>
&gt;&gt; &gt; 2&quot; is<br>
&gt;&gt; &gt; not delivered/generated by the consumerd to the relayd in seq=
uence with<br>
&gt;&gt; &gt; other traces. To rule out that this is not a test application=
 problem,<br>
&gt;&gt; &gt; you<br>
&gt;&gt; &gt; can look at line ltttng_relayd log : 12778 and see traces fro=
m<br>
&gt;&gt; &gt; appTraceNum -<br>
&gt;&gt; &gt; 1 to appTraceNum - 18 including the appTraceNum 2 are &quot;r=
e-delivered&quot; by<br>
&gt;&gt; &gt; the<br>
&gt;&gt; &gt; consumerd to the relayd.<br>
&gt;&gt; &gt; Essentially, I see appTraceNum 1 through appTraceNum 18 being=
 delivered<br>
&gt;&gt; &gt; twice, once individually where appTraceNum 2 is missing and o=
nce as a<br>
&gt;&gt; &gt; group<br>
&gt;&gt; &gt; at line 12778 where its present.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Request help with<br>
&gt;&gt; &gt; 1. why traces are delivered twice, is it by design or a genui=
ne problem<br>
&gt;&gt; &gt; ?<br>
&gt;&gt; &gt; 2. how to avoid traces being dropped even though buffers are<=
br>
&gt;&gt; &gt; sufficiently<br>
&gt;&gt; &gt; large enough ?<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Regards,<br>
&gt;&gt; &gt; Aravind.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; _______________________________________________<br>
&gt;&gt; &gt; lttng-dev mailing list<br>
&gt;&gt; &gt; <a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank=
">lttng-dev@lists.lttng.org</a><br>
&gt;&gt; &gt; <a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lt=
tng-dev" rel=3D"noreferrer" target=3D"_blank">http://lists.lttng.org/cgi-bi=
n/mailman/listinfo/lttng-dev</a><br>
&gt;&gt; &gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; --<br>
&gt;&gt; J=C3=A9r=C3=A9mie Galarneau<br>
&gt;&gt; EfficiOS Inc.<br>
&gt;&gt; <a href=3D"http://www.efficios.com" rel=3D"noreferrer" target=3D"_=
blank">http://www.efficios.com</a><br>
&gt;<br>
&gt;<br>
<br>
<br>
<br>
--<br>
J=C3=A9r=C3=A9mie Galarneau<br>
EfficiOS Inc.<br>
<a href=3D"http://www.efficios.com" rel=3D"noreferrer" target=3D"_blank">ht=
tp://www.efficios.com</a><br>
</div></div></blockquote></div><br></div>
</div></div><br>_______________________________________________<br>
lttng-dev mailing list<br>
<a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-dev@li=
sts.lttng.org</a><br>
<a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" rel=
=3D"noreferrer" target=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/li=
stinfo/lttng-dev</a><br>
<br></blockquote></div><br><br clear=3D"all"><div><br></div>-- <br></div></=
div><div><div dir=3D"ltr"><div><div dir=3D"ltr">Jonathan Rajotte Julien<div=
><br></div></div></div></div></div>
</div>
</blockquote></div><br></div>

--047d7b3a88885feb840526626d15--


--===============1998854943==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1998854943==--
