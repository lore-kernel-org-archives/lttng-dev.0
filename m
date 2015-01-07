From: Divya Vyas <dvyas@mvista.com>
Subject: Re: Merge two LTTng CTF traces into one
Date: Wed, 7 Jan 2015 11:54:26 +0530
Message-ID: <CA+=dQ-_CaEvWV6uF+01tZFmfhSoHE0g=OGBKoKNC5cwMaWDSew__37769.4692033858$1420611961$gmane$org@mail.gmail.com>
References: <1431870336.8158578.1419253660346.JavaMail.root@polymtl.ca>
 <549835FE.8090508@ericsson.com> <54985ACE.1000502@ericsson.com>
 <CA+=dQ-_sjNg3jj11Psm+wrKbbyS1Ox1kHZyoFwQ2MSfP+SqvuQ@mail.gmail.com>
 <5499C549.2@ericsson.com> <5499CF78.3090301@versatic.net>
 <CA+=dQ-9zwf=0Qnf8mCwWionoOo-BxRyScb607-0wfoi2hBO8XA@mail.gmail.com>
 <54AAB14E.70004@versatic.net>
 <CA+=dQ--wqUbkbW3MXh-4X1NrJ-qp=8B4dh6ydutgGzEcOXHxUA@mail.gmail.com>
 <CA+=dQ-9ZmQJJKZOcoL6kQX5kSMKDZ9HMS2xkjstMiw-5bz79EQ@mail.gmail.com>
 <CA+=dQ-8oGmyKDfNEfLwu_WLeouu0XXxQVigciVBDV3T6dQJ+pg@mail.gmail.com>
 <54AC0D33.80805@versatic.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1618752866=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <dvyas@mvista.com>) id 1Y8k31-0007CZ-Tf
 for lttng-dev@lists.lttng.org; Wed, 07 Jan 2015 01:24:54 -0500
Received: by mail-wi0-f169.google.com with SMTP id r20so7404386wiv.0
 for <lttng-dev@lists.lttng.org>; Tue, 06 Jan 2015 22:24:46 -0800 (PST)
In-Reply-To: <54AC0D33.80805@versatic.net>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?UTF-8?Q?Genevi=C3=A8ve_Bastien?= <gbastien@versatic.net>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============1618752866==
Content-Type: multipart/alternative; boundary=047d7b86deaed83891050c09fac7

--047d7b86deaed83891050c09fac7
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Genevieve,

My target to is merge the traces of two different machines taken on
different time or same time .

Actually synchronization was not working on different machine so I tried on
same machine.  But now I got it correctly I think so :)

For different time we need to apply offset so that their beginning matches.
I think I need to do this .

I tried applying offset on eclipse luna ( I added linux tools in install
new software)   but I am not getting this option " Apply time offset ".

I tried on tracecompass also, where I am getting time offset option but the
synchronization view is empty . The window is not showing anything. The
tracecompass version is 0.1.0

Is there any other plugin for  synchronization ?

On Tue, Jan 6, 2015 at 9:58 PM, Genevi=C3=A8ve Bastien <gbastien@versatic.n=
et>
wrote:

>  Hi Divya,
>
> I'm bringing this discussion back to lttng-dev, as it may benefit others
> in the future.
>
> You now have the right fields to synchronize traces. It uses packets of
> type TCP and fields seq, ack_seq and flags to match packets.
>
> But what are you trying to achieve exactly? The traces you sent me are
> taken on the same machine at different times. They can never be
> synchronized. Trace synchronization allows you to synchronize traces take=
n
> at the same time on different machines (clocks) so that their events can
> have the same reference clock.
>
> You can apply a time offset to one of the traces so that their beginning
> matches (Right-click on the experiment -> Apply time offset... More
> documentation on this feature is available in the master code). If that's
> what you want. Otherwise, please explain your specific need.
>
> Genevi=C3=A8ve
>
>
>
> On 01/06/2015 01:33 AM, Divya Vyas wrote:
>
>  Hi,
>
>  I am attaching the traces . I tried to synchronize the traces of same
> machine  but still quality is absent .
>
>  I am in urgent need to get these traces synchronized .
>
> On Tue, Jan 6, 2015 at 11:00 AM, Divya Vyas <dvyas@mvista.com> wrote:
>
>>  Hi ,
>>
>>  I tried again the steps.
>>
>> net_dev_queue: { cpu_id =3D 0 }, { skbaddr =3D 18446612135892807424, len=
 =3D
>> 98, name =3D "eth0", network_header =3D ( _nhtype_ip : container =3D 1 )=
,
>> network_fields =3D { nhtype_ip =3D { ihl_version =3D 0x45, tos =3D 0, to=
t_len =3D 84,
>> id =3D 0x560A, frag_off =3D 16384, ttl =3D 64, protocol =3D 0x1, checksu=
m =3D 0xFFF4,
>> saddr =3D 0xAA267D8, daddr =3D 0xAA2678E } }, transport_header =3D ( _th=
type_none
>> : container =3D 0 ), transport_fields =3D { thtype_none =3D { } } }
>>
>> net_dev_queue: { cpu_id =3D 0 }, { skbaddr =3D 18446612135892807424, len=
 =3D
>> 98, name =3D "eth0", network_header =3D ( _nhtype_ip : container =3D 1 )=
,
>> network_fields =3D { nhtype_ip =3D { ihl_version =3D 0x45, tos =3D 0, to=
t_len =3D 84,
>> id =3D 0x560A, frag_off =3D 16384, ttl =3D 64, protocol =3D 0x1, checksu=
m =3D 0xFFF4,
>> saddr =3D 0xAA267D8, daddr =3D 0xAA2678E } }, transport_header =3D ( _th=
type_none
>> : container =3D 0 ), transport_fields =3D { thtype_none =3D { } } }
>>
>>
>>  Is this kind of data should be added in the trace log ?
>>
>>
>>
>> On Tue, Jan 6, 2015 at 3:21 AM, Divya Vyas <dvyas@mvista.com> wrote:
>>
>>> Hi,
>>>
>>> Can you please help me what kind of extra fields will be added in trace
>>> data. Because I think I followed all the steps.
>>>
>>> The branch I was not able to got ,getting some git error. So I
>>> downloaded snapshot from website.
>>>  On Jan 5, 2015 9:14 PM, "Genevi=C3=A8ve Bastien" <gbastien@versatic.ne=
t>
>>> wrote:
>>>
>>>>  Hi Divya,
>>>>
>>>> I looked at your traces and you do not seem to be using the
>>>> 'net_data_experimental' special branch to get the extra fields for
>>>> synchronization. You have the net_dev_queue and netif_receive_skb even=
ts,
>>>> but they do not have the required fields to be able to synchronize. Se=
e the
>>>> section "Obtain synchronizable traces" in
>>>> http://help.eclipse.org/luna/index.jsp?topic=3D%2Forg.eclipse.linuxtoo=
ls.lttng.help%2Fdoc%2FTrace-synchronization.html
>>>> for how to compile with that branch.
>>>>
>>>> Genevi=C3=A8ve
>>>>
>>>>
>>>> On 12/28/2014 12:44 AM, Divya Vyas wrote:
>>>>
>>>>   Hi,
>>>>
>>>>  I am getting Synchronization quality is absent. The workload I am
>>>> using is ssh and scp .
>>>>
>>>>  I have attached the traces . Can you please look at it and give em
>>>> some advise where I am going wrong?
>>>>
>>>>  Thanks,
>>>>  Divya
>>>>
>>>> On Wed, Dec 24, 2014 at 1:54 AM, Genevi=C3=A8ve Bastien <
>>>> gbastien@versatic.net> wrote:
>>>>
>>>>> Hi Divya,
>>>>>
>>>>> If you followed the instructions in the help, then you have compiled
>>>>> LTTng-modules with the right tracepoints enabled on all the machines
>>>>> you
>>>>> want to synchronize. Which method did you choose?
>>>>>
>>>>> Make sure you enabled either net_dev_queue/netif_receive_skb or
>>>>> inet_sock_local_in/inet_sock_local_out on all machines. Also make sur=
e
>>>>> all machines exchange TCP packets during the trace, otherwise there
>>>>> will
>>>>> be nothing to synchronize them on.
>>>>>
>>>>> When you say you are not getting anything, what do you mean? Do you
>>>>> have
>>>>> output in the Synchronization view? If the synchronization was OK, bu=
t
>>>>> nothing was found, you should get a Synchronization Quality of
>>>>> "Absent".
>>>>> If the output is empty, either you have long traces and you didn't ge=
t
>>>>> anything yet (there is no progress bar for the synchronization yet). =
Or
>>>>> you may have gotten an exception.
>>>>>
>>>>> Can you provide us with your traces so we can take a closer look?
>>>>>
>>>>> Genevi=C3=A8ve
>>>>>
>>>>>
>>>>> On 14-12-23 02:40 PM, Matthew Khouzam wrote:
>>>>> > So you have traces with network stuff, I would suggest seeing what
>>>>> > events are enabled in your trace. Maybe you are missing some key
>>>>> events,
>>>>> > maybe the synchronization worked and we're chasing a ghost...
>>>>> >
>>>>> > I am ccing Genevieve Bastien, and Masoume Jabbarifar, the two peopl=
e
>>>>> who
>>>>> > designed and implemented synchronisation.
>>>>> >
>>>>> > I am not as much an expert as I would like to be in that field.
>>>>> >
>>>>> > For offsetting though, it's in tracecompass, the next version of th=
e
>>>>> > Eclipse LTTng viewer
>>>>> >
>>>>> > Here is a link to the page.
>>>>> > http://projects.eclipse.org/projects/tools.tracecompass
>>>>> >
>>>>> > On 14-12-23 12:19 AM, Divya Vyas wrote:
>>>>> >> Hi,
>>>>> >>
>>>>> >> Is there any document which describes how to synchronize the trace=
s
>>>>> on
>>>>> >> same machine as well as different machine ( setting offset also ) =
.
>>>>> >>
>>>>> >> I exported the two trace in experiment and clicked on synchronize
>>>>> >> traces . But not getting anything.
>>>>> >>
>>>>> >> I followed this page
>>>>> >>
>>>>> >>
>>>>> http://help.eclipse.org/luna/index.jsp?topic=3D%2Forg.eclipse.linuxto=
ols.lttng.help%2Fdoc%2FTrace-synchronization.html
>>>>> >>
>>>>> >> Thanks,
>>>>> >> Divya
>>>>> >>
>>>>> >>
>>>>> >>
>>>>> >> On Mon, Dec 22, 2014 at 11:24 PM, Matthew Khouzam
>>>>> >> <matthew.khouzam@ericsson.com <mailto:matthew.khouzam@ericsson.com
>>>>> >>
>>>>> >> wrote:
>>>>> >>
>>>>> >>     Sorry, I was a little hasty in my reply. You can export traces=
,
>>>>> >>     but not
>>>>> >>     experiments yet, this is a feature to expect soon if people
>>>>> want it.
>>>>> >>
>>>>> >>
>>>>> >>     On 14-12-22 10:17 AM, Matthew Khouzam wrote:
>>>>> >>     > Michel has hit the nail on the head there.
>>>>> >>     >
>>>>> >>     > I would just like to add that one can export an experiment i=
n
>>>>> trace
>>>>> >>     > compass. This means that the two traces are shipped in a zip
>>>>> >>     with the
>>>>> >>     > synchronization. You can also apply a constant clock offset =
if
>>>>> >>     network
>>>>> >>     > events are unavailable. If you really really want to make a
>>>>> CTF
>>>>> >>     trace as
>>>>> >>     > an output, perhaps look at the python bound babeltrace?
>>>>> >>     >
>>>>> >>     > BR
>>>>> >>     >
>>>>> >>     > Matthew
>>>>> >>     >
>>>>> >>     >
>>>>> >>     > On 14-12-22 08:07 AM, Michel Dagenais wrote:
>>>>> >>     >> Normally, the two traces are stored separately and they are
>>>>> >>     "merged"
>>>>> >>     >> at display time in TraceCompass. If they were taken on the
>>>>> same
>>>>> >>     host,
>>>>> >>     >> they use the same clock and should be naturally aligned. If
>>>>> >>     they come
>>>>> >>     >> from different hosts and you want very fine symchronization=
,
>>>>> >>     you need
>>>>> >>     >> some communication events from which to synchronize the
>>>>> traces. TCP
>>>>> >>     >> packet send and receive events are typically used. If you
>>>>> want
>>>>> >>     to look
>>>>> >>     >> at two traces simultaneously, it normally implies that the
>>>>> two are
>>>>> >>     >> related, the two nodes communicating through the network.
>>>>> >>     >>
>>>>> >>     >>
>>>>> >>
>>>>>  --------------------------------------------------------------------=
----
>>>>> >>     >>
>>>>> >>     >>     Hi,
>>>>> >>     >>
>>>>> >>     >>     Is there any way to merge the two CTF traces and see th=
em
>>>>> >>     in one
>>>>> >>     >>     with trace synchronization ?
>>>>> >>     >>
>>>>> >>     >>     How it is related to trace synchronization using networ=
k
>>>>> >>     events ?
>>>>> >>     >>
>>>>> >>     >>
>>>>> >>     >>     Thanks,
>>>>> >>     >>     Divya
>>>>> >>     >>
>>>>> >>     >>     _______________________________________________
>>>>> >>     >>     lttng-dev mailing list
>>>>> >>     >>     lttng-dev@lists.lttng.org <mailto:
>>>>> lttng-dev@lists.lttng.org>
>>>>> >>     >>
>>>>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>>>>> >>     >>
>>>>> >>     >>
>>>>> >>     >>
>>>>> >>     >>
>>>>> >>     >> _______________________________________________
>>>>> >>     >> lttng-dev mailing list
>>>>> >>     >> lttng-dev@lists.lttng.org <mailto:lttng-dev@lists.lttng.org=
>
>>>>> >>     >> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>>>>> >>     >
>>>>> >>     > _______________________________________________
>>>>> >>     > lttng-dev mailing list
>>>>> >>     > lttng-dev@lists.lttng.org <mailto:lttng-dev@lists.lttng.org>
>>>>> >>     > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>>>>> >>
>>>>> >>
>>>>> >>     _______________________________________________
>>>>> >>     lttng-dev mailing list
>>>>> >>     lttng-dev@lists.lttng.org <mailto:lttng-dev@lists.lttng.org>
>>>>> >>     http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>>>>> >>
>>>>> >>
>>>>>
>>>>>
>>>>>
>>>>
>>>>
>>
>
>

--047d7b86deaed83891050c09fac7
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div><div><div><div><div><br></div>Hi Genevieve,=
<br><br></div>My target to is merge the traces of two different machines ta=
ken on different time or same time .<br><br></div>Actually synchronization =
was not working on different machine so I tried on same machine.=C2=A0 But =
now I got it correctly I think so :)<br><br></div>For different time we nee=
d to apply offset so that their beginning matches. I think I need to do thi=
s .<br><br></div>I tried applying offset on eclipse luna ( I added linux to=
ols in install new software)=C2=A0=C2=A0 but I am not getting this option &=
quot; Apply time offset &quot;. <br><br></div>I tried on tracecompass also,=
 where I am getting time offset option but the synchronization view is empt=
y . The window is not showing anything. The tracecompass version is 0.1.0<b=
r><br></div>Is there any other plugin for=C2=A0 synchronization ? <br></div=
><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Tue, Jan 6, 2=
015 at 9:58 PM, Genevi=C3=A8ve Bastien <span dir=3D"ltr">&lt;<a href=3D"mai=
lto:gbastien@versatic.net" target=3D"_blank">gbastien@versatic.net</a>&gt;<=
/span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8=
ex;border-left:1px #ccc solid;padding-left:1ex">
 =20
   =20
 =20
  <div bgcolor=3D"#FFFFFF" text=3D"#000000">
    <div>Hi Divya,<br>
      <br>
      I&#39;m bringing this discussion back to lttng-dev, as it may benefit
      others in the future. <br>
      <br>
      You now have the right fields to synchronize traces. It uses
      packets of type TCP and fields seq, ack_seq and flags to match
      packets.<br>
      <br>
      But what are you trying to achieve exactly? The traces you sent me
      are taken on the same machine at different times. They can never
      be synchronized. Trace synchronization allows you to synchronize
      traces taken at the same time on different machines (clocks) so
      that their events can have the same reference clock.<br>
      <br>
      You can apply a time offset to one of the traces so that their
      beginning matches (Right-click on the experiment -&gt; Apply time
      offset... More documentation on this feature is available in the
      master code). If that&#39;s what you want. Otherwise, please explain
      your specific need.<span class=3D"HOEnZb"><font color=3D"#888888"><br=
>
      <br>
      Genevi=C3=A8ve</font></span><div><div class=3D"h5"><br>
      <br>
      <br>
      On 01/06/2015 01:33 AM, Divya Vyas wrote:<br>
    </div></div></div><div><div class=3D"h5">
    <blockquote type=3D"cite">
      <div dir=3D"ltr">
        <div>
          <div>Hi,<br>
            <br>
          </div>
          I am attaching the traces . I tried to synchronize the traces
          of same machine=C2=A0 but still quality is absent . <br>
          <br>
        </div>
        I am in urgent need to get these traces synchronized . <br>
      </div>
      <div class=3D"gmail_extra"><br>
        <div class=3D"gmail_quote">On Tue, Jan 6, 2015 at 11:00 AM, Divya
          Vyas <span dir=3D"ltr">&lt;<a href=3D"mailto:dvyas@mvista.com" ta=
rget=3D"_blank">dvyas@mvista.com</a>&gt;</span>
          wrote:<br>
          <blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bord=
er-left:1px #ccc solid;padding-left:1ex">
            <div dir=3D"ltr">
              <div>
                <div>Hi ,<br>
                  <br>
                </div>
                I tried again the steps.<br>
                <br>
                net_dev_queue: { cpu_id =3D 0 }, { skbaddr =3D
                18446612135892807424, len =3D 98, name =3D &quot;eth0&quot;=
,
                network_header =3D ( _nhtype_ip : container =3D 1 ),
                network_fields =3D { nhtype_ip =3D { ihl_version =3D 0x45, =
tos
                =3D 0, tot_len =3D 84, id =3D 0x560A, frag_off =3D 16384, t=
tl =3D
                64, protocol =3D 0x1, checksum =3D 0xFFF4, saddr =3D
                0xAA267D8, daddr =3D 0xAA2678E } }, transport_header =3D (
                _thtype_none : container =3D 0 ), transport_fields =3D {
                thtype_none =3D { } } }<br>
                <br>
                net_dev_queue: { cpu_id =3D 0 }, { skbaddr =3D
                18446612135892807424, len =3D 98, name =3D &quot;eth0&quot;=
,
                network_header =3D ( _nhtype_ip : container =3D 1 ),
                network_fields =3D { nhtype_ip =3D { ihl_version =3D 0x45, =
tos
                =3D 0, tot_len =3D 84, id =3D 0x560A, frag_off =3D 16384, t=
tl =3D
                64, protocol =3D 0x1, checksum =3D 0xFFF4, saddr =3D
                0xAA267D8, daddr =3D 0xAA2678E } }, transport_header =3D (
                _thtype_none : container =3D 0 ), transport_fields =3D {
                thtype_none =3D { } } }<br>
                <br>
                <br>
              </div>
              Is this kind of data should be added in the trace log ? <br>
              <br>
              <br>
            </div>
            <div>
              <div>
                <div class=3D"gmail_extra"><br>
                  <div class=3D"gmail_quote">On Tue, Jan 6, 2015 at 3:21
                    AM, Divya Vyas <span dir=3D"ltr">&lt;<a href=3D"mailto:=
dvyas@mvista.com" target=3D"_blank">dvyas@mvista.com</a>&gt;</span>
                    wrote:<br>
                    <blockquote class=3D"gmail_quote" style=3D"margin:0 0 0=
 .8ex;border-left:1px #ccc solid;padding-left:1ex">
                      <p dir=3D"ltr">Hi,</p>
                      <p dir=3D"ltr">Can you please help me what kind of
                        extra fields will be added in trace data.
                        Because I think I followed all the steps. </p>
                      <p dir=3D"ltr">The branch I was not able to got
                        ,getting some git error. So I downloaded
                        snapshot from website.</p>
                      <div>
                        <div>
                          <div class=3D"gmail_quote">On Jan 5, 2015 9:14
                            PM, &quot;Genevi=C3=A8ve Bastien&quot; &lt;<a h=
ref=3D"mailto:gbastien@versatic.net" target=3D"_blank">gbastien@versatic.ne=
t</a>&gt;
                            wrote:<br type=3D"attribution">
                            <blockquote class=3D"gmail_quote" style=3D"marg=
in:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
                              <div bgcolor=3D"#FFFFFF" text=3D"#000000">
                                <div>Hi Divya,<br>
                                  <br>
                                  I looked at your traces and you do not
                                  seem to be using the
                                  &#39;net_data_experimental&#39; special b=
ranch
                                  to get the extra fields for
                                  synchronization. You have the
                                  net_dev_queue and netif_receive_skb
                                  events, but they do not have the
                                  required fields to be able to
                                  synchronize. See the section &quot;Obtain
                                  synchronizable traces&quot; in <a href=3D=
"http://help.eclipse.org/luna/index.jsp?topic=3D%2Forg.eclipse.linuxtools.l=
ttng.help%2Fdoc%2FTrace-synchronization.html" target=3D"_blank">http://help=
.eclipse.org/luna/index.jsp?topic=3D%2Forg.eclipse.linuxtools.lttng.help%2F=
doc%2FTrace-synchronization.html</a>
                                  for how to compile with that branch.<br>
                                  <br>
                                  Genevi=C3=A8ve<br>
                                  <br>
                                  <br>
                                  On 12/28/2014 12:44 AM, Divya Vyas
                                  wrote:<br>
                                </div>
                                <blockquote type=3D"cite">
                                  <div dir=3D"ltr">
                                    <div>
                                      <div>
                                        <div>
                                          <div>Hi,<br>
                                            <br>
                                          </div>
                                          I am getting Synchronization
                                          quality is absent. The
                                          workload I am using is ssh and
                                          scp . <br>
                                          <br>
                                        </div>
                                        I have attached the traces . Can
                                        you please look at it and give
                                        em some advise where I am going
                                        wrong? <br>
                                        <br>
                                      </div>
                                      Thanks,<br>
                                    </div>
                                    Divya<br>
                                  </div>
                                  <div class=3D"gmail_extra"><br>
                                    <div class=3D"gmail_quote">On Wed, Dec
                                      24, 2014 at 1:54 AM, Genevi=C3=A8ve
                                      Bastien <span dir=3D"ltr">&lt;<a href=
=3D"mailto:gbastien@versatic.net" target=3D"_blank">gbastien@versatic.net</=
a>&gt;</span>
                                      wrote:<br>
                                      <blockquote class=3D"gmail_quote" sty=
le=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Hi
                                        Divya,<br>
                                        <br>
                                        If you followed the instructions
                                        in the help, then you have
                                        compiled<br>
                                        LTTng-modules with the right
                                        tracepoints enabled on all the
                                        machines you<br>
                                        want to synchronize. Which
                                        method did you choose?<br>
                                        <br>
                                        Make sure you enabled either
                                        net_dev_queue/netif_receive_skb
                                        or<br>
                                        inet_sock_local_in/inet_sock_local_=
out
                                        on all machines. Also make sure<br>
                                        all machines exchange TCP
                                        packets during the trace,
                                        otherwise there will<br>
                                        be nothing to synchronize them
                                        on.<br>
                                        <br>
                                        When you say you are not getting
                                        anything, what do you mean? Do
                                        you have<br>
                                        output in the Synchronization
                                        view? If the synchronization was
                                        OK, but<br>
                                        nothing was found, you should
                                        get a Synchronization Quality of
                                        &quot;Absent&quot;.<br>
                                        If the output is empty, either
                                        you have long traces and you
                                        didn&#39;t get<br>
                                        anything yet (there is no
                                        progress bar for the
                                        synchronization yet). Or<br>
                                        you may have gotten an
                                        exception.<br>
                                        <br>
                                        Can you provide us with your
                                        traces so we can take a closer
                                        look?<br>
                                        <span><font color=3D"#888888"><br>
                                            Genevi=C3=A8ve<br>
                                          </font></span>
                                        <div>
                                          <div><br>
                                            <br>
                                            On 14-12-23 02:40 PM,
                                            Matthew Khouzam wrote:<br>
                                            &gt; So you have traces with
                                            network stuff, I would
                                            suggest seeing what<br>
                                            &gt; events are enabled in
                                            your trace. Maybe you are
                                            missing some key events,<br>
                                            &gt; maybe the
                                            synchronization worked and
                                            we&#39;re chasing a ghost...<br=
>
                                            &gt;<br>
                                            &gt; I am ccing Genevieve
                                            Bastien, and Masoume
                                            Jabbarifar, the two people
                                            who<br>
                                            &gt; designed and
                                            implemented synchronisation.<br=
>
                                            &gt;<br>
                                            &gt; I am not as much an
                                            expert as I would like to be
                                            in that field.<br>
                                            &gt;<br>
                                            &gt; For offsetting though,
                                            it&#39;s in tracecompass, the
                                            next version of the<br>
                                            &gt; Eclipse LTTng viewer<br>
                                            &gt;<br>
                                            &gt; Here is a link to the
                                            page.<br>
                                            &gt; <a href=3D"http://projects=
.eclipse.org/projects/tools.tracecompass" target=3D"_blank">http://projects=
.eclipse.org/projects/tools.tracecompass</a><br>
                                            &gt;<br>
                                            &gt; On 14-12-23 12:19 AM,
                                            Divya Vyas wrote:<br>
                                            &gt;&gt; Hi,<br>
                                            &gt;&gt;<br>
                                            &gt;&gt; Is there any
                                            document which describes how
                                            to synchronize the traces on<br=
>
                                            &gt;&gt; same machine as
                                            well as different machine (
                                            setting offset also ) .<br>
                                            &gt;&gt;<br>
                                            &gt;&gt; I exported the two
                                            trace in experiment and
                                            clicked on synchronize<br>
                                            &gt;&gt; traces . But not
                                            getting anything.<br>
                                            &gt;&gt;<br>
                                            &gt;&gt; I followed this
                                            page<br>
                                            &gt;&gt;<br>
                                            &gt;&gt; <a href=3D"http://help=
.eclipse.org/luna/index.jsp?topic=3D%2Forg.eclipse.linuxtools.lttng.help%2F=
doc%2FTrace-synchronization.html" target=3D"_blank">http://help.eclipse.org=
/luna/index.jsp?topic=3D%2Forg.eclipse.linuxtools.lttng.help%2Fdoc%2FTrace-=
synchronization.html</a><br>
                                            &gt;&gt;<br>
                                            &gt;&gt; Thanks,<br>
                                            &gt;&gt; Divya<br>
                                            &gt;&gt;<br>
                                            &gt;&gt;<br>
                                            &gt;&gt;<br>
                                            &gt;&gt; On Mon, Dec 22,
                                            2014 at 11:24 PM, Matthew
                                            Khouzam<br>
                                            &gt;&gt; &lt;<a href=3D"mailto:=
matthew.khouzam@ericsson.com" target=3D"_blank">matthew.khouzam@ericsson.co=
m</a>
                                            &lt;mailto:<a href=3D"mailto:ma=
tthew.khouzam@ericsson.com" target=3D"_blank">matthew.khouzam@ericsson.com<=
/a>&gt;&gt;<br>
                                            &gt;&gt; wrote:<br>
                                            &gt;&gt;<br>
                                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0Sor=
ry, I was a
                                            little hasty in my reply.
                                            You can export traces,<br>
                                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0but=
 not<br>
                                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0exp=
eriments
                                            yet, this is a feature to
                                            expect soon if people want
                                            it.<br>
                                            &gt;&gt;<br>
                                            &gt;&gt;<br>
                                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0On =
14-12-22
                                            10:17 AM, Matthew Khouzam
                                            wrote:<br>
                                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt=
; Michel has
                                            hit the nail on the head
                                            there.<br>
                                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt=
;<br>
                                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt=
; I would
                                            just like to add that one
                                            can export an experiment in
                                            trace<br>
                                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt=
; compass.
                                            This means that the two
                                            traces are shipped in a zip<br>
                                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0wit=
h the<br>
                                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt=
;
                                            synchronization. You can
                                            also apply a constant clock
                                            offset if<br>
                                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0net=
work<br>
                                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt=
; events are
                                            unavailable. If you really
                                            really want to make a CTF<br>
                                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0tra=
ce as<br>
                                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt=
; an output,
                                            perhaps look at the python
                                            bound babeltrace?<br>
                                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt=
;<br>
                                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt=
; BR<br>
                                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt=
;<br>
                                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt=
; Matthew<br>
                                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt=
;<br>
                                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt=
;<br>
                                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt=
; On
                                            14-12-22 08:07 AM, Michel
                                            Dagenais wrote:<br>
                                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt=
;&gt;
                                            Normally, the two traces are
                                            stored separately and they
                                            are<br>
                                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0&qu=
ot;merged&quot;<br>
                                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt=
;&gt; at
                                            display time in
                                            TraceCompass. If they were
                                            taken on the same<br>
                                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0hos=
t,<br>
                                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt=
;&gt; they
                                            use the same clock and
                                            should be naturally aligned.
                                            If<br>
                                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0the=
y come<br>
                                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt=
;&gt; from
                                            different hosts and you want
                                            very fine symchronization,<br>
                                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0you=
 need<br>
                                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt=
;&gt; some
                                            communication events from
                                            which to synchronize the
                                            traces. TCP<br>
                                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt=
;&gt; packet
                                            send and receive events are
                                            typically used. If you want<br>
                                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0to =
look<br>
                                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt=
;&gt; at two
                                            traces simultaneously, it
                                            normally implies that the
                                            two are<br>
                                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt=
;&gt;
                                            related, the two nodes
                                            communicating through the
                                            network.<br>
                                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt=
;&gt;<br>
                                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt=
;&gt;<br>
                                            &gt;&gt;=C2=A0 =C2=A0
=C2=A0---------------------------------------------------------------------=
---<br>
                                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt=
;&gt;<br>
                                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt=
;&gt;=C2=A0 =C2=A0
                                            =C2=A0Hi,<br>
                                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt=
;&gt;<br>
                                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt=
;&gt;=C2=A0 =C2=A0 =C2=A0Is
                                            there any way to merge the
                                            two CTF traces and see them<br>
                                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0in =
one<br>
                                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt=
;&gt;=C2=A0 =C2=A0
                                            =C2=A0with trace synchronizatio=
n
                                            ?<br>
                                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt=
;&gt;<br>
                                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt=
;&gt;=C2=A0 =C2=A0
                                            =C2=A0How it is related to trac=
e
                                            synchronization using
                                            network<br>
                                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0eve=
nts ?<br>
                                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt=
;&gt;<br>
                                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt=
;&gt;<br>
                                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt=
;&gt;=C2=A0 =C2=A0
                                            =C2=A0Thanks,<br>
                                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt=
;&gt;=C2=A0 =C2=A0
                                            =C2=A0Divya<br>
                                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt=
;&gt;<br>
                                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt=
;&gt;=C2=A0 =C2=A0
                                            =C2=A0_________________________=
______________________<br>
                                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt=
;&gt;=C2=A0 =C2=A0
                                            =C2=A0lttng-dev mailing list<br=
>
                                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt=
;&gt;=C2=A0 =C2=A0 =C2=A0<a href=3D"mailto:lttng-dev@lists.lttng.org" targe=
t=3D"_blank">lttng-dev@lists.lttng.org</a>
                                            &lt;mailto:<a href=3D"mailto:lt=
tng-dev@lists.lttng.org" target=3D"_blank">lttng-dev@lists.lttng.org</a>&gt=
;<br>
                                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt=
;&gt;=C2=A0 =C2=A0 =C2=A0<a href=3D"http://lists.lttng.org/cgi-bin/mailman/=
listinfo/lttng-dev" target=3D"_blank">http://lists.lttng.org/cgi-bin/mailma=
n/listinfo/lttng-dev</a><br>
                                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt=
;&gt;<br>
                                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt=
;&gt;<br>
                                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt=
;&gt;<br>
                                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt=
;&gt;<br>
                                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt=
;&gt;
                                            _______________________________=
________________<br>
                                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt=
;&gt;
                                            lttng-dev mailing list<br>
                                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt=
;&gt; <a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-=
dev@lists.lttng.org</a>
                                            &lt;mailto:<a href=3D"mailto:lt=
tng-dev@lists.lttng.org" target=3D"_blank">lttng-dev@lists.lttng.org</a>&gt=
;<br>
                                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt=
;&gt; <a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev"=
 target=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-de=
v</a><br>
                                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt=
;<br>
                                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt=
;
                                            _______________________________=
________________<br>
                                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt=
; lttng-dev
                                            mailing list<br>
                                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt=
; <a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-dev@=
lists.lttng.org</a>
                                            &lt;mailto:<a href=3D"mailto:lt=
tng-dev@lists.lttng.org" target=3D"_blank">lttng-dev@lists.lttng.org</a>&gt=
;<br>
                                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt=
; <a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" tar=
get=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a=
><br>
                                            &gt;&gt;<br>
                                            &gt;&gt;<br>
                                            &gt;&gt;=C2=A0 =C2=A0
                                            =C2=A0_________________________=
______________________<br>
                                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0ltt=
ng-dev
                                            mailing list<br>
                                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0<a =
href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-dev@lists=
.lttng.org</a>
                                            &lt;mailto:<a href=3D"mailto:lt=
tng-dev@lists.lttng.org" target=3D"_blank">lttng-dev@lists.lttng.org</a>&gt=
;<br>
                                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0<a =
href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" target=
=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a><b=
r>
                                            &gt;&gt;<br>
                                            &gt;&gt;<br>
                                            <br>
                                            <br>
                                          </div>
                                        </div>
                                      </blockquote>
                                    </div>
                                    <br>
                                  </div>
                                </blockquote>
                                <br>
                              </div>
                            </blockquote>
                          </div>
                        </div>
                      </div>
                    </blockquote>
                  </div>
                  <br>
                </div>
              </div>
            </div>
          </blockquote>
        </div>
        <br>
      </div>
    </blockquote>
    <br>
  </div></div></div>

</blockquote></div><br></div>

--047d7b86deaed83891050c09fac7--


--===============1618752866==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1618752866==--
