From: =?UTF-8?B?R2VuZXZpw6h2ZSBCYXN0aWVu?= <gbastien@versatic.net>
Subject: Re: Merge two LTTng CTF traces into one
Date: Tue, 06 Jan 2015 11:28:35 -0500
Message-ID: <54AC0D33.80805__25242.9641005167$1420561881$gmane$org@versatic.net>
References: <1431870336.8158578.1419253660346.JavaMail.root@polymtl.ca>
 <549835FE.8090508@ericsson.com> <54985ACE.1000502@ericsson.com>
 <CA+=dQ-_sjNg3jj11Psm+wrKbbyS1Ox1kHZyoFwQ2MSfP+SqvuQ@mail.gmail.com>
 <5499C549.2@ericsson.com> <5499CF78.3090301@versatic.net>
 <CA+=dQ-9zwf=0Qnf8mCwWionoOo-BxRyScb607-0wfoi2hBO8XA@mail.gmail.com>
 <54AAB14E.70004@versatic.net>
 <CA+=dQ--wqUbkbW3MXh-4X1NrJ-qp=8B4dh6ydutgGzEcOXHxUA@mail.gmail.com>
 <CA+=dQ-9ZmQJJKZOcoL6kQX5kSMKDZ9HMS2xkjstMiw-5bz79EQ@mail.gmail.com>
 <CA+=dQ-8oGmyKDfNEfLwu_WLeouu0XXxQVigciVBDV3T6dQJ+pg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0068024285=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mailout.easydns.com ([64.68.201.141])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <gbastien@versatic.net>) id 1Y8Wzm-00031z-Da
 for lttng-dev@lists.lttng.org; Tue, 06 Jan 2015 11:28:41 -0500
In-Reply-To: <CA+=dQ-8oGmyKDfNEfLwu_WLeouu0XXxQVigciVBDV3T6dQJ+pg@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Divya Vyas <dvyas@mvista.com>, "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

This is a multi-part message in MIME format.
--===============0068024285==
Content-Type: multipart/alternative;
 boundary="------------080306080208090207050608"

This is a multi-part message in MIME format.
--------------080306080208090207050608
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by smtp.polymtl.ca id t06GT2iU030959

Hi Divya,

I'm bringing this discussion back to lttng-dev, as it may benefit others=20
in the future.

You now have the right fields to synchronize traces. It uses packets of=20
type TCP and fields seq, ack_seq and flags to match packets.

But what are you trying to achieve exactly? The traces you sent me are=20
taken on the same machine at different times. They can never be=20
synchronized. Trace synchronization allows you to synchronize traces=20
taken at the same time on different machines (clocks) so that their=20
events can have the same reference clock.

You can apply a time offset to one of the traces so that their beginning=20
matches (Right-click on the experiment -> Apply time offset... More=20
documentation on this feature is available in the master code). If=20
that's what you want. Otherwise, please explain your specific need.

Genevi=C3=A8ve


On 01/06/2015 01:33 AM, Divya Vyas wrote:
> Hi,
>
> I am attaching the traces . I tried to synchronize the traces of same=20
> machine  but still quality is absent .
>
> I am in urgent need to get these traces synchronized .
>
> On Tue, Jan 6, 2015 at 11:00 AM, Divya Vyas <dvyas@mvista.com=20
> <mailto:dvyas@mvista.com>> wrote:
>
>     Hi ,
>
>     I tried again the steps.
>
>     net_dev_queue: { cpu_id =3D 0 }, { skbaddr =3D 18446612135892807424=
,
>     len =3D 98, name =3D "eth0", network_header =3D ( _nhtype_ip : cont=
ainer
>     =3D 1 ), network_fields =3D { nhtype_ip =3D { ihl_version =3D 0x45,=
 tos =3D
>     0, tot_len =3D 84, id =3D 0x560A, frag_off =3D 16384, ttl =3D 64, p=
rotocol
>     =3D 0x1, checksum =3D 0xFFF4, saddr =3D 0xAA267D8, daddr =3D 0xAA26=
78E }
>     }, transport_header =3D ( _thtype_none : container =3D 0 ),
>     transport_fields =3D { thtype_none =3D { } } }
>
>     net_dev_queue: { cpu_id =3D 0 }, { skbaddr =3D 18446612135892807424=
,
>     len =3D 98, name =3D "eth0", network_header =3D ( _nhtype_ip : cont=
ainer
>     =3D 1 ), network_fields =3D { nhtype_ip =3D { ihl_version =3D 0x45,=
 tos =3D
>     0, tot_len =3D 84, id =3D 0x560A, frag_off =3D 16384, ttl =3D 64, p=
rotocol
>     =3D 0x1, checksum =3D 0xFFF4, saddr =3D 0xAA267D8, daddr =3D 0xAA26=
78E }
>     }, transport_header =3D ( _thtype_none : container =3D 0 ),
>     transport_fields =3D { thtype_none =3D { } } }
>
>
>     Is this kind of data should be added in the trace log ?
>
>
>
>     On Tue, Jan 6, 2015 at 3:21 AM, Divya Vyas <dvyas@mvista.com
>     <mailto:dvyas@mvista.com>> wrote:
>
>         Hi,
>
>         Can you please help me what kind of extra fields will be added
>         in trace data. Because I think I followed all the steps.
>
>         The branch I was not able to got ,getting some git error. So I
>         downloaded snapshot from website.
>
>         On Jan 5, 2015 9:14 PM, "Genevi=C3=A8ve Bastien"
>         <gbastien@versatic.net <mailto:gbastien@versatic.net>> wrote:
>
>             Hi Divya,
>
>             I looked at your traces and you do not seem to be using
>             the 'net_data_experimental' special branch to get the
>             extra fields for synchronization. You have the
>             net_dev_queue and netif_receive_skb events, but they do
>             not have the required fields to be able to synchronize.
>             See the section "Obtain synchronizable traces" in
>             http://help.eclipse.org/luna/index.jsp?topic=3D%2Forg.eclip=
se.linuxtools.lttng.help%2Fdoc%2FTrace-synchronization.html
>             for how to compile with that branch.
>
>             Genevi=C3=A8ve
>
>
>             On 12/28/2014 12:44 AM, Divya Vyas wrote:
>>             Hi,
>>
>>             I am getting Synchronization quality is absent. The
>>             workload I am using is ssh and scp .
>>
>>             I have attached the traces . Can you please look at it
>>             and give em some advise where I am going wrong?
>>
>>             Thanks,
>>             Divya
>>
>>             On Wed, Dec 24, 2014 at 1:54 AM, Genevi=C3=A8ve Bastien
>>             <gbastien@versatic.net <mailto:gbastien@versatic.net>> wro=
te:
>>
>>                 Hi Divya,
>>
>>                 If you followed the instructions in the help, then
>>                 you have compiled
>>                 LTTng-modules with the right tracepoints enabled on
>>                 all the machines you
>>                 want to synchronize. Which method did you choose?
>>
>>                 Make sure you enabled either
>>                 net_dev_queue/netif_receive_skb or
>>                 inet_sock_local_in/inet_sock_local_out on all
>>                 machines. Also make sure
>>                 all machines exchange TCP packets during the trace,
>>                 otherwise there will
>>                 be nothing to synchronize them on.
>>
>>                 When you say you are not getting anything, what do
>>                 you mean? Do you have
>>                 output in the Synchronization view? If the
>>                 synchronization was OK, but
>>                 nothing was found, you should get a Synchronization
>>                 Quality of "Absent".
>>                 If the output is empty, either you have long traces
>>                 and you didn't get
>>                 anything yet (there is no progress bar for the
>>                 synchronization yet). Or
>>                 you may have gotten an exception.
>>
>>                 Can you provide us with your traces so we can take a
>>                 closer look?
>>
>>                 Genevi=C3=A8ve
>>
>>
>>                 On 14-12-23 02:40 PM, Matthew Khouzam wrote:
>>                 > So you have traces with network stuff, I would
>>                 suggest seeing what
>>                 > events are enabled in your trace. Maybe you are
>>                 missing some key events,
>>                 > maybe the synchronization worked and we're chasing
>>                 a ghost...
>>                 >
>>                 > I am ccing Genevieve Bastien, and Masoume
>>                 Jabbarifar, the two people who
>>                 > designed and implemented synchronisation.
>>                 >
>>                 > I am not as much an expert as I would like to be in
>>                 that field.
>>                 >
>>                 > For offsetting though, it's in tracecompass, the
>>                 next version of the
>>                 > Eclipse LTTng viewer
>>                 >
>>                 > Here is a link to the page.
>>                 > http://projects.eclipse.org/projects/tools.tracecomp=
ass
>>                 >
>>                 > On 14-12-23 12:19 AM, Divya Vyas wrote:
>>                 >> Hi,
>>                 >>
>>                 >> Is there any document which describes how to
>>                 synchronize the traces on
>>                 >> same machine as well as different machine (
>>                 setting offset also ) .
>>                 >>
>>                 >> I exported the two trace in experiment and clicked
>>                 on synchronize
>>                 >> traces . But not getting anything.
>>                 >>
>>                 >> I followed this page
>>                 >>
>>                 >>
>>                 http://help.eclipse.org/luna/index.jsp?topic=3D%2Forg.=
eclipse.linuxtools.lttng.help%2Fdoc%2FTrace-synchronization.html
>>                 >>
>>                 >> Thanks,
>>                 >> Divya
>>                 >>
>>                 >>
>>                 >>
>>                 >> On Mon, Dec 22, 2014 at 11:24 PM, Matthew Khouzam
>>                 >> <matthew.khouzam@ericsson.com
>>                 <mailto:matthew.khouzam@ericsson.com>
>>                 <mailto:matthew.khouzam@ericsson.com
>>                 <mailto:matthew.khouzam@ericsson.com>>>
>>                 >> wrote:
>>                 >>
>>                 >>     Sorry, I was a little hasty in my reply. You
>>                 can export traces,
>>                 >>     but not
>>                 >>     experiments yet, this is a feature to expect
>>                 soon if people want it.
>>                 >>
>>                 >>
>>                 >>     On 14-12-22 10:17 AM, Matthew Khouzam wrote:
>>                 >>     > Michel has hit the nail on the head there.
>>                 >>     >
>>                 >>     > I would just like to add that one can export
>>                 an experiment in trace
>>                 >>     > compass. This means that the two traces are
>>                 shipped in a zip
>>                 >>     with the
>>                 >>     > synchronization. You can also apply a
>>                 constant clock offset if
>>                 >>     network
>>                 >>     > events are unavailable. If you really really
>>                 want to make a CTF
>>                 >>     trace as
>>                 >>     > an output, perhaps look at the python bound
>>                 babeltrace?
>>                 >>     >
>>                 >>     > BR
>>                 >>     >
>>                 >>     > Matthew
>>                 >>     >
>>                 >>     >
>>                 >>     > On 14-12-22 08:07 AM, Michel Dagenais wrote:
>>                 >>     >> Normally, the two traces are stored
>>                 separately and they are
>>                 >>     "merged"
>>                 >>     >> at display time in TraceCompass. If they
>>                 were taken on the same
>>                 >>     host,
>>                 >>     >> they use the same clock and should be
>>                 naturally aligned. If
>>                 >>     they come
>>                 >>     >> from different hosts and you want very fine
>>                 symchronization,
>>                 >>     you need
>>                 >>     >> some communication events from which to
>>                 synchronize the traces. TCP
>>                 >>     >> packet send and receive events are
>>                 typically used. If you want
>>                 >>     to look
>>                 >>     >> at two traces simultaneously, it normally
>>                 implies that the two are
>>                 >>     >> related, the two nodes communicating
>>                 through the network.
>>                 >>     >>
>>                 >>     >>
>>                 >>
>>                  -----------------------------------------------------=
-------------------
>>                 >>     >>
>>                 >>     >>  Hi,
>>                 >>     >>
>>                 >>     >>     Is there any way to merge the two CTF
>>                 traces and see them
>>                 >>     in one
>>                 >>     >>  with trace synchronization ?
>>                 >>     >>
>>                 >>     >>  How it is related to trace synchronization
>>                 using network
>>                 >>     events ?
>>                 >>     >>
>>                 >>     >>
>>                 >>     >>  Thanks,
>>                 >>     >>  Divya
>>                 >>     >>
>>                 >>     >>
>>                  _______________________________________________
>>                 >>     >>  lttng-dev mailing list
>>                 >>     >> lttng-dev@lists.lttng.org
>>                 <mailto:lttng-dev@lists.lttng.org>
>>                 <mailto:lttng-dev@lists.lttng.org
>>                 <mailto:lttng-dev@lists.lttng.org>>
>>                 >>     >>
>>                 http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-=
dev
>>                 >>     >>
>>                 >>     >>
>>                 >>     >>
>>                 >>     >>
>>                 >>     >> ____________________________________________=
___
>>                 >>     >> lttng-dev mailing list
>>                 >>     >> lttng-dev@lists.lttng.org
>>                 <mailto:lttng-dev@lists.lttng.org>
>>                 <mailto:lttng-dev@lists.lttng.org
>>                 <mailto:lttng-dev@lists.lttng.org>>
>>                 >>     >>
>>                 http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-=
dev
>>                 >>     >
>>                 >>     > _____________________________________________=
__
>>                 >>     > lttng-dev mailing list
>>                 >>     > lttng-dev@lists.lttng.org
>>                 <mailto:lttng-dev@lists.lttng.org>
>>                 <mailto:lttng-dev@lists.lttng.org
>>                 <mailto:lttng-dev@lists.lttng.org>>
>>                 >>     >
>>                 http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-=
dev
>>                 >>
>>                 >>
>>                 >>  _______________________________________________
>>                 >>     lttng-dev mailing list
>>                 >> lttng-dev@lists.lttng.org
>>                 <mailto:lttng-dev@lists.lttng.org>
>>                 <mailto:lttng-dev@lists.lttng.org
>>                 <mailto:lttng-dev@lists.lttng.org>>
>>                 >>
>>                 http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-=
dev
>>                 >>
>>                 >>
>>
>>
>>
>
>
>


--------------080306080208090207050608
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by smtp.polymtl.ca id t06GT2iU030959

<html>
  <head>
    <meta content=3D"text/html; charset=3Dutf-8" http-equiv=3D"Content-Ty=
pe">
  </head>
  <body bgcolor=3D"#FFFFFF" text=3D"#000000">
    <div class=3D"moz-cite-prefix">Hi Divya,<br>
      <br>
      I'm bringing this discussion back to lttng-dev, as it may benefit
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
      master code). If that's what you want. Otherwise, please explain
      your specific need.<br>
      <br>
      Genevi=C3=A8ve<br>
      <br>
      <br>
      On 01/06/2015 01:33 AM, Divya Vyas wrote:<br>
    </div>
    <blockquote
cite=3D"mid:CA+=3DdQ-8oGmyKDfNEfLwu_WLeouu0XXxQVigciVBDV3T6dQJ+pg@mail.gm=
ail.com"
      type=3D"cite">
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
          Vyas <span dir=3D"ltr">&lt;<a moz-do-not-send=3D"true"
              href=3D"mailto:dvyas@mvista.com" target=3D"_blank">dvyas@mv=
ista.com</a>&gt;</span>
          wrote:<br>
          <blockquote class=3D"gmail_quote" style=3D"margin:0 0 0
            .8ex;border-left:1px #ccc solid;padding-left:1ex">
            <div dir=3D"ltr">
              <div>
                <div>Hi ,<br>
                  <br>
                </div>
                I tried again the steps.<br>
                <br>
                net_dev_queue: { cpu_id =3D 0 }, { skbaddr =3D
                18446612135892807424, len =3D 98, name =3D "eth0",
                network_header =3D ( _nhtype_ip : container =3D 1 ),
                network_fields =3D { nhtype_ip =3D { ihl_version =3D 0x45=
, tos
                =3D 0, tot_len =3D 84, id =3D 0x560A, frag_off =3D 16384,=
 ttl =3D
                64, protocol =3D 0x1, checksum =3D 0xFFF4, saddr =3D
                0xAA267D8, daddr =3D 0xAA2678E } }, transport_header =3D =
(
                _thtype_none : container =3D 0 ), transport_fields =3D {
                thtype_none =3D { } } }<br>
                <br>
                net_dev_queue: { cpu_id =3D 0 }, { skbaddr =3D
                18446612135892807424, len =3D 98, name =3D "eth0",
                network_header =3D ( _nhtype_ip : container =3D 1 ),
                network_fields =3D { nhtype_ip =3D { ihl_version =3D 0x45=
, tos
                =3D 0, tot_len =3D 84, id =3D 0x560A, frag_off =3D 16384,=
 ttl =3D
                64, protocol =3D 0x1, checksum =3D 0xFFF4, saddr =3D
                0xAA267D8, daddr =3D 0xAA2678E } }, transport_header =3D =
(
                _thtype_none : container =3D 0 ), transport_fields =3D {
                thtype_none =3D { } } }<br>
                <br>
                <br>
              </div>
              Is this kind of data should be added in the trace log ? <br=
>
              <br>
              <br>
            </div>
            <div class=3D"HOEnZb">
              <div class=3D"h5">
                <div class=3D"gmail_extra"><br>
                  <div class=3D"gmail_quote">On Tue, Jan 6, 2015 at 3:21
                    AM, Divya Vyas <span dir=3D"ltr">&lt;<a
                        moz-do-not-send=3D"true"
                        href=3D"mailto:dvyas@mvista.com" target=3D"_blank=
">dvyas@mvista.com</a>&gt;</span>
                    wrote:<br>
                    <blockquote class=3D"gmail_quote" style=3D"margin:0 0=
 0
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
                            PM, "Genevi=C3=A8ve Bastien" &lt;<a
                              moz-do-not-send=3D"true"
                              href=3D"mailto:gbastien@versatic.net"
                              target=3D"_blank">gbastien@versatic.net</a>=
&gt;
                            wrote:<br type=3D"attribution">
                            <blockquote class=3D"gmail_quote"
                              style=3D"margin:0 0 0 .8ex;border-left:1px
                              #ccc solid;padding-left:1ex">
                              <div bgcolor=3D"#FFFFFF" text=3D"#000000">
                                <div>Hi Divya,<br>
                                  <br>
                                  I looked at your traces and you do not
                                  seem to be using the
                                  'net_data_experimental' special branch
                                  to get the extra fields for
                                  synchronization. You have the
                                  net_dev_queue and netif_receive_skb
                                  events, but they do not have the
                                  required fields to be able to
                                  synchronize. See the section "Obtain
                                  synchronizable traces" in <a
                                    moz-do-not-send=3D"true"
href=3D"http://help.eclipse.org/luna/index.jsp?topic=3D%2Forg.eclipse.lin=
uxtools.lttng.help%2Fdoc%2FTrace-synchronization.html"
                                    target=3D"_blank">http://help.eclipse=
.org/luna/index.jsp?topic=3D%2Forg.eclipse.linuxtools.lttng.help%2Fdoc%2F=
Trace-synchronization.html</a>
                                  for how to compile with that branch.<br=
>
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
                                    <div class=3D"gmail_quote">On Wed, De=
c
                                      24, 2014 at 1:54 AM, Genevi=C3=A8ve
                                      Bastien <span dir=3D"ltr">&lt;<a
                                          moz-do-not-send=3D"true"
                                          href=3D"mailto:gbastien@versati=
c.net"
                                          target=3D"_blank">gbastien@vers=
atic.net</a>&gt;</span>
                                      wrote:<br>
                                      <blockquote class=3D"gmail_quote"
                                        style=3D"margin:0 0 0
                                        .8ex;border-left:1px #ccc
                                        solid;padding-left:1ex">Hi
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
                                        inet_sock_local_in/inet_sock_loca=
l_out
                                        on all machines. Also make sure<b=
r>
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
                                        "Absent".<br>
                                        If the output is empty, either
                                        you have long traces and you
                                        didn't get<br>
                                        anything yet (there is no
                                        progress bar for the
                                        synchronization yet). Or<br>
                                        you may have gotten an
                                        exception.<br>
                                        <br>
                                        Can you provide us with your
                                        traces so we can take a closer
                                        look?<br>
                                        <span><font color=3D"#888888"><br=
>
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
                                            we're chasing a ghost...<br>
                                            &gt;<br>
                                            &gt; I am ccing Genevieve
                                            Bastien, and Masoume
                                            Jabbarifar, the two people
                                            who<br>
                                            &gt; designed and
                                            implemented synchronisation.<=
br>
                                            &gt;<br>
                                            &gt; I am not as much an
                                            expert as I would like to be
                                            in that field.<br>
                                            &gt;<br>
                                            &gt; For offsetting though,
                                            it's in tracecompass, the
                                            next version of the<br>
                                            &gt; Eclipse LTTng viewer<br>
                                            &gt;<br>
                                            &gt; Here is a link to the
                                            page.<br>
                                            &gt; <a
                                              moz-do-not-send=3D"true"
                                              href=3D"http://projects.ecl=
ipse.org/projects/tools.tracecompass"
                                              target=3D"_blank">http://pr=
ojects.eclipse.org/projects/tools.tracecompass</a><br>
                                            &gt;<br>
                                            &gt; On 14-12-23 12:19 AM,
                                            Divya Vyas wrote:<br>
                                            &gt;&gt; Hi,<br>
                                            &gt;&gt;<br>
                                            &gt;&gt; Is there any
                                            document which describes how
                                            to synchronize the traces on<=
br>
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
                                            &gt;&gt; <a
                                              moz-do-not-send=3D"true"
href=3D"http://help.eclipse.org/luna/index.jsp?topic=3D%2Forg.eclipse.lin=
uxtools.lttng.help%2Fdoc%2FTrace-synchronization.html"
                                              target=3D"_blank">http://he=
lp.eclipse.org/luna/index.jsp?topic=3D%2Forg.eclipse.linuxtools.lttng.hel=
p%2Fdoc%2FTrace-synchronization.html</a><br>
                                            &gt;&gt;<br>
                                            &gt;&gt; Thanks,<br>
                                            &gt;&gt; Divya<br>
                                            &gt;&gt;<br>
                                            &gt;&gt;<br>
                                            &gt;&gt;<br>
                                            &gt;&gt; On Mon, Dec 22,
                                            2014 at 11:24 PM, Matthew
                                            Khouzam<br>
                                            &gt;&gt; &lt;<a
                                              moz-do-not-send=3D"true"
                                              href=3D"mailto:matthew.khou=
zam@ericsson.com"
                                              target=3D"_blank">matthew.k=
houzam@ericsson.com</a>
                                            &lt;mailto:<a
                                              moz-do-not-send=3D"true"
                                              href=3D"mailto:matthew.khou=
zam@ericsson.com"
                                              target=3D"_blank">matthew.k=
houzam@ericsson.com</a>&gt;&gt;<br>
                                            &gt;&gt; wrote:<br>
                                            &gt;&gt;<br>
                                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0S=
orry, I was a
                                            little hasty in my reply.
                                            You can export traces,<br>
                                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0b=
ut not<br>
                                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0e=
xperiments
                                            yet, this is a feature to
                                            expect soon if people want
                                            it.<br>
                                            &gt;&gt;<br>
                                            &gt;&gt;<br>
                                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0O=
n 14-12-22
                                            10:17 AM, Matthew Khouzam
                                            wrote:<br>
                                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0&=
gt; Michel has
                                            hit the nail on the head
                                            there.<br>
                                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0&=
gt;<br>
                                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0&=
gt; I would
                                            just like to add that one
                                            can export an experiment in
                                            trace<br>
                                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0&=
gt; compass.
                                            This means that the two
                                            traces are shipped in a zip<b=
r>
                                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0w=
ith the<br>
                                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0&=
gt;
                                            synchronization. You can
                                            also apply a constant clock
                                            offset if<br>
                                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0n=
etwork<br>
                                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0&=
gt; events are
                                            unavailable. If you really
                                            really want to make a CTF<br>
                                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0t=
race as<br>
                                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0&=
gt; an output,
                                            perhaps look at the python
                                            bound babeltrace?<br>
                                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0&=
gt;<br>
                                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0&=
gt; BR<br>
                                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0&=
gt;<br>
                                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0&=
gt; Matthew<br>
                                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0&=
gt;<br>
                                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0&=
gt;<br>
                                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0&=
gt; On
                                            14-12-22 08:07 AM, Michel
                                            Dagenais wrote:<br>
                                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0&=
gt;&gt;
                                            Normally, the two traces are
                                            stored separately and they
                                            are<br>
                                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0"=
merged"<br>
                                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0&=
gt;&gt; at
                                            display time in
                                            TraceCompass. If they were
                                            taken on the same<br>
                                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0h=
ost,<br>
                                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0&=
gt;&gt; they
                                            use the same clock and
                                            should be naturally aligned.
                                            If<br>
                                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0t=
hey come<br>
                                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0&=
gt;&gt; from
                                            different hosts and you want
                                            very fine symchronization,<br=
>
                                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0y=
ou need<br>
                                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0&=
gt;&gt; some
                                            communication events from
                                            which to synchronize the
                                            traces. TCP<br>
                                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0&=
gt;&gt; packet
                                            send and receive events are
                                            typically used. If you want<b=
r>
                                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0t=
o look<br>
                                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0&=
gt;&gt; at two
                                            traces simultaneously, it
                                            normally implies that the
                                            two are<br>
                                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0&=
gt;&gt;
                                            related, the two nodes
                                            communicating through the
                                            network.<br>
                                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0&=
gt;&gt;<br>
                                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0&=
gt;&gt;<br>
                                            &gt;&gt;=C2=A0 =C2=A0
=C2=A0-------------------------------------------------------------------=
-----<br>
                                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0&=
gt;&gt;<br>
                                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0&=
gt;&gt;=C2=A0 =C2=A0
                                            =C2=A0Hi,<br>
                                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0&=
gt;&gt;<br>
                                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0&=
gt;&gt;=C2=A0 =C2=A0 =C2=A0Is
                                            there any way to merge the
                                            two CTF traces and see them<b=
r>
                                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0i=
n one<br>
                                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0&=
gt;&gt;=C2=A0 =C2=A0
                                            =C2=A0with trace synchronizat=
ion
                                            ?<br>
                                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0&=
gt;&gt;<br>
                                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0&=
gt;&gt;=C2=A0 =C2=A0
                                            =C2=A0How it is related to tr=
ace
                                            synchronization using
                                            network<br>
                                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0e=
vents ?<br>
                                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0&=
gt;&gt;<br>
                                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0&=
gt;&gt;<br>
                                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0&=
gt;&gt;=C2=A0 =C2=A0
                                            =C2=A0Thanks,<br>
                                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0&=
gt;&gt;=C2=A0 =C2=A0
                                            =C2=A0Divya<br>
                                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0&=
gt;&gt;<br>
                                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0&=
gt;&gt;=C2=A0 =C2=A0
                                            =C2=A0_______________________=
________________________<br>
                                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0&=
gt;&gt;=C2=A0 =C2=A0
                                            =C2=A0lttng-dev mailing list<=
br>
                                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0&=
gt;&gt;=C2=A0 =C2=A0 =C2=A0<a
                                              moz-do-not-send=3D"true"
                                              href=3D"mailto:lttng-dev@li=
sts.lttng.org"
                                              target=3D"_blank">lttng-dev=
@lists.lttng.org</a>
                                            &lt;mailto:<a
                                              moz-do-not-send=3D"true"
                                              href=3D"mailto:lttng-dev@li=
sts.lttng.org"
                                              target=3D"_blank">lttng-dev=
@lists.lttng.org</a>&gt;<br>
                                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0&=
gt;&gt;=C2=A0 =C2=A0 =C2=A0<a
                                              moz-do-not-send=3D"true"
                                              href=3D"http://lists.lttng.=
org/cgi-bin/mailman/listinfo/lttng-dev"
                                              target=3D"_blank">http://li=
sts.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a><br>
                                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0&=
gt;&gt;<br>
                                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0&=
gt;&gt;<br>
                                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0&=
gt;&gt;<br>
                                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0&=
gt;&gt;<br>
                                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0&=
gt;&gt;
                                            _____________________________=
__________________<br>
                                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0&=
gt;&gt;
                                            lttng-dev mailing list<br>
                                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0&=
gt;&gt; <a
                                              moz-do-not-send=3D"true"
                                              href=3D"mailto:lttng-dev@li=
sts.lttng.org"
                                              target=3D"_blank">lttng-dev=
@lists.lttng.org</a>
                                            &lt;mailto:<a
                                              moz-do-not-send=3D"true"
                                              href=3D"mailto:lttng-dev@li=
sts.lttng.org"
                                              target=3D"_blank">lttng-dev=
@lists.lttng.org</a>&gt;<br>
                                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0&=
gt;&gt; <a
                                              moz-do-not-send=3D"true"
                                              href=3D"http://lists.lttng.=
org/cgi-bin/mailman/listinfo/lttng-dev"
                                              target=3D"_blank">http://li=
sts.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a><br>
                                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0&=
gt;<br>
                                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0&=
gt;
                                            _____________________________=
__________________<br>
                                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0&=
gt; lttng-dev
                                            mailing list<br>
                                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0&=
gt; <a
                                              moz-do-not-send=3D"true"
                                              href=3D"mailto:lttng-dev@li=
sts.lttng.org"
                                              target=3D"_blank">lttng-dev=
@lists.lttng.org</a>
                                            &lt;mailto:<a
                                              moz-do-not-send=3D"true"
                                              href=3D"mailto:lttng-dev@li=
sts.lttng.org"
                                              target=3D"_blank">lttng-dev=
@lists.lttng.org</a>&gt;<br>
                                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0&=
gt; <a
                                              moz-do-not-send=3D"true"
                                              href=3D"http://lists.lttng.=
org/cgi-bin/mailman/listinfo/lttng-dev"
                                              target=3D"_blank">http://li=
sts.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a><br>
                                            &gt;&gt;<br>
                                            &gt;&gt;<br>
                                            &gt;&gt;=C2=A0 =C2=A0
                                            =C2=A0_______________________=
________________________<br>
                                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0l=
ttng-dev
                                            mailing list<br>
                                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0<=
a
                                              moz-do-not-send=3D"true"
                                              href=3D"mailto:lttng-dev@li=
sts.lttng.org"
                                              target=3D"_blank">lttng-dev=
@lists.lttng.org</a>
                                            &lt;mailto:<a
                                              moz-do-not-send=3D"true"
                                              href=3D"mailto:lttng-dev@li=
sts.lttng.org"
                                              target=3D"_blank">lttng-dev=
@lists.lttng.org</a>&gt;<br>
                                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0<=
a
                                              moz-do-not-send=3D"true"
                                              href=3D"http://lists.lttng.=
org/cgi-bin/mailman/listinfo/lttng-dev"
                                              target=3D"_blank">http://li=
sts.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a><br>
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
  </body>
</html>

--------------080306080208090207050608--



--===============0068024285==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0068024285==--
