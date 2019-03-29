From: Ravindra Kumar Meena <rmeena840@gmail.com>
Subject: Re: [tracecompass-dev] Question related to LTTng
Date: Fri, 29 Mar 2019 22:40:45 +0530
Message-ID: <CAEWVvOTZgiyiqGY7o_mBvPZ3JKGqc6WFc-+6VbP7oq6MT7qABQ__45624.9074007914$1553882700$gmane$org@mail.gmail.com>
References: <CAEWVvOTEJjw3kYfPfrcW68Ux6fy1g5utoHBpy=o++d71rxddbg@mail.gmail.com>
 <f0d5b7b4-dacc-ca93-10d5-cc3f7c88d320@versatic.net>
 <BN8PR15MB3090BB0C0E9FC7D9865EF2369E580@BN8PR15MB3090.namprd15.prod.outlook.com>
 <CAEWVvOT1EQ9aS3Ao5u-nypV2ZrsDyHHMh9fEguLDgG27w6=gRw@mail.gmail.com>
 <BN8PR15MB30907BD062BC346E35C2B7E09E580@BN8PR15MB3090.namprd15.prod.outlook.com>
 <CAEWVvOTtN_sckmpsXn6w4JkfFo4HYcta_YzwnfBhmZt_OeUJtA@mail.gmail.com>
 <3f170528-e3b4-4b37-b94b-5f8276abb53e@versatic.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8078460827973656890=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 by lists.lttng.org (Postfix) with ESMTPS id 44W7Yg0lGFz1KS1
 for <lttng-dev@lists.lttng.org>; Fri, 29 Mar 2019 13:11:18 -0400 (EDT)
Received: by mail-wr1-x430.google.com with SMTP id r4so3471455wrq.8
 for <lttng-dev@lists.lttng.org>; Fri, 29 Mar 2019 10:11:18 -0700 (PDT)
In-Reply-To: <3f170528-e3b4-4b37-b94b-5f8276abb53e@versatic.net>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: =?UTF-8?Q?Genevi=C3=A8ve_Bastien?= <gbastien@versatic.net>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, "tracecompass-dev@eclipse.org" <tracecompass-dev@eclipse.org>
List-Id: lttng-dev@lists.lttng.org

--===============8078460827973656890==
Content-Type: multipart/alternative; boundary="00000000000048bea005853ec27c"

--00000000000048bea005853ec27c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi developers,

Thanks to all for the sharing information. It would help me a lot in the
completion of the project at my university.

--Ravindra Kumar Meena

On Fri, Mar 29, 2019 at 8:34 PM Genevi=C3=A8ve Bastien <gbastien@versatic.n=
et>
wrote:

> Hi Ravindra,
> On 2019-03-27 2:49 p.m., Ravindra Kumar Meena wrote:
>
> > So you have a user space application that generates a trace. It is
>> virtualized, and you want to open it in trace compass to analyze it.
>>
>
>
>> Yes. That's what I want to do but it has to in real-time manner.
>>
> Trace Compass does not support live traces. It is made for post-mortem
> analyses, so it works only on complete trace. We briefly supported live
> traces a few years back, but that made the code much more complicated, so
> this support was dropped. TraceCompass is not made for trace monitoring!
>
>
>
>> > I would like to know if there is a way to transfer CTF to Trace Compas=
s
>> in a real-time manner using TCP/UDP.
>>
>>
>> >Would scp work? Just asking.
>>
>
>
>> I am supposed to transfer it through only TCP/UDP.
>>
> LTTng does support relaying the data over the network (see
> https://lttng.org/docs/v2.10/#doc-sending-trace-data-over-the-network).
> But Trace Compass does not open traces that are not terminated. The 2.11
> version (not yet released) and master also support session rotation, so y=
ou
> can have traces in chunks of say 1 minutes and whenever a chunk is closed=
,
> it is ready to be opened by Trace Compass. This is as close to live trace
> analysis as you can get.
>
>
>
>> >How can I convert CTF Trace Data to LTTng? Since TraceCompass already
>> understands LTTng Trace Data.
>>
>>
>> >The CTF trace should be openable in Trace Compass. You won't have as
>> many pretty graphs and whatnot, but you can get some basic analyses done
>> with searching and filters. If you want some more advanced analyses, you
>> can code an XML analysis, or use any language you want and parse it to m=
ake
>> a LAMI report. Finally you can make your own analysis (and even commit i=
t
>> to the incubator! =F0=9F=98=89 =F0=9F=98=89 ).
>>
>>
>>     >The information that I want to analyze and display information
> includes CPU usage, IRQ analysis(IRQ Statistics, IRQ Table, IRQ vs Count,
> IRQ vs Time), Linux Kernel(Control Flow, Resources)
>
> With an LTTng kernel trace, you can get all that. Add a UST trace to it
> and you can correlate both traces together.
>
> Cheers,
>
> Genevi=C3=A8ve
>
>

--=20
*Ravindra Kumar Meena*,
B. Tech. Computer Science and Engineering,
Indian Institute of Technology (Indian School of Mines)
<https://www.iitism.ac.in/>, Dhanbad

--00000000000048bea005853ec27c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi developers,</div><div><br></div>Thanks to all for =
the sharing information. It would help me a lot in the completion of the pr=
oject at my university.<div><br></div><div>--Ravindra Kumar Meena</div></di=
v><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On F=
ri, Mar 29, 2019 at 8:34 PM Genevi=C3=A8ve Bastien &lt;<a href=3D"mailto:gb=
astien@versatic.net">gbastien@versatic.net</a>&gt; wrote:<br></div><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px=
 solid rgb(204,204,204);padding-left:1ex">
 =20
   =20
 =20
  <div bgcolor=3D"#FFFFFF">
    <p>Hi Ravindra,<br>
    </p>
    <div class=3D"gmail-m_651565092694176642moz-cite-prefix">On 2019-03-27 =
2:49 p.m., Ravindra Kumar
      Meena wrote:<br>
    </div>
    <blockquote type=3D"cite">
     =20
      <div dir=3D"ltr">
        <div class=3D"gmail_quote">
          <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8=
ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
            <div dir=3D"ltr">
              <div id=3D"gmail-m_651565092694176642m_7752166956455312320gma=
il-m_6403026334017903746divtagdefaultwrapper" style=3D"font-size:12pt;font-=
family:Calibri,Helvetica,sans-serif" dir=3D"ltr">
                <p style=3D"margin-top:0px;margin-bottom:0px"><span style=
=3D"font-size:12pt"><font color=3D"#ff0000">&gt; So
                      you have a user space application that generates a
                      trace. It is virtualized, and you want to open it
                      in trace compass to analyze it.</font></span></p>
              </div>
            </div>
          </blockquote>
          <div>=C2=A0=C2=A0</div>
          <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8=
ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
            <div dir=3D"ltr">
              <div id=3D"gmail-m_651565092694176642m_7752166956455312320gma=
il-m_6403026334017903746divtagdefaultwrapper" style=3D"font-size:12pt;color=
:rgb(0,0,0);font-family:Calibri,Helvetica,sans-serif" dir=3D"ltr">
                <p style=3D"margin-top:0px;margin-bottom:0px">Yes. That&#39=
;s
                  what I want to do but it has to in real-time manner.</p>
              </div>
            </div>
          </blockquote>
        </div>
      </div>
    </blockquote>
    Trace Compass does not support live traces. It is made for
    post-mortem analyses, so it works only on complete trace. We briefly
    supported live traces a few years back, but that made the code much
    more complicated, so this support was dropped. TraceCompass is not
    made for trace monitoring!<br>
    <blockquote type=3D"cite">
      <div dir=3D"ltr">
        <div class=3D"gmail_quote">
          <div>=C2=A0</div>
          <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8=
ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
            <div dir=3D"ltr">
              <div id=3D"gmail-m_651565092694176642m_7752166956455312320gma=
il-m_6403026334017903746divtagdefaultwrapper" style=3D"font-size:12pt;font-=
family:Calibri,Helvetica,sans-serif" dir=3D"ltr">
                <p style=3D"margin-top:0px;margin-bottom:0px"><font color=
=3D"#ff0000">&gt; I would like to know if there
                    is a way to transfer CTF to Trace Compass in a
                    real-time manner using TCP/UDP.</font></p>
                <p style=3D"color:rgb(0,0,0);margin-top:0px;margin-bottom:0=
px"><br>
                </p>
                <p style=3D"margin-top:0px;margin-bottom:0px"><font color=
=3D"#ff0000">&gt;Would scp work? Just asking.</font></p>
              </div>
            </div>
          </blockquote>
          <div>=C2=A0</div>
          <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8=
ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
            <div dir=3D"ltr">
              <div id=3D"gmail-m_651565092694176642m_7752166956455312320gma=
il-m_6403026334017903746divtagdefaultwrapper" style=3D"font-size:12pt;color=
:rgb(0,0,0);font-family:Calibri,Helvetica,sans-serif" dir=3D"ltr">
                <p style=3D"margin-top:0px;margin-bottom:0px">I am
                  supposed to transfer it through only TCP/UDP.</p>
              </div>
            </div>
          </blockquote>
        </div>
      </div>
    </blockquote>
    <p>LTTng does support relaying the data over the network (see
      <a class=3D"gmail-m_651565092694176642moz-txt-link-freetext" href=3D"=
https://lttng.org/docs/v2.10/#doc-sending-trace-data-over-the-network" targ=
et=3D"_blank">https://lttng.org/docs/v2.10/#doc-sending-trace-data-over-the=
-network</a>).
      But Trace Compass does not open traces that are not terminated.
      The 2.11 version (not yet released) and master also support
      session rotation, so you can have traces in chunks of say 1
      minutes and whenever a chunk is closed, it is ready to be opened
      by Trace Compass. This is as close to live trace analysis as you
      can get. <br>
    </p>
    <blockquote type=3D"cite">
      <div dir=3D"ltr">
        <div class=3D"gmail_quote">
          <div>=C2=A0</div>
          <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8=
ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
            <div dir=3D"ltr">
              <div id=3D"gmail-m_651565092694176642m_7752166956455312320gma=
il-m_6403026334017903746divtagdefaultwrapper" style=3D"font-size:12pt;font-=
family:Calibri,Helvetica,sans-serif" dir=3D"ltr">
                <p style=3D"margin-top:0px;margin-bottom:0px"><font color=
=3D"#ff0000">&gt;How can I convert CTF Trace Data
                    to LTTng? Since TraceCompass already understands
                    LTTng Trace Data.</font></p>
                <p style=3D"margin-top:0px;margin-bottom:0px"><font color=
=3D"#ff0000"><br>
                  </font></p>
                <p style=3D"margin-top:0px;margin-bottom:0px"><font color=
=3D"#ff0000">&gt;The CTF trace should be openable
                    in Trace Compass. You won&#39;t have as many pretty
                    graphs and whatnot, but you can get some basic
                    analyses done with searching and filters. If you
                    want some more advanced analyses, you can code an
                    XML analysis, or use any language you want and parse
                    it to make a LAMI report. Finally you can make your
                    own analysis (and even commit it to the incubator!
                    =F0=9F=98=89 =F0=9F=98=89 ).</font></p>
                <p style=3D"color:rgb(0,0,0);margin-top:0px;margin-bottom:0=
px"><br>
                </p>
              </div>
            </div>
          </blockquote>
          <div>=C2=A0 =C2=A0 &gt;<span style=3D"background-color:transparen=
t;color:rgb(0,0,0);font-family:Arial;font-size:12pt;white-space:pre-wrap">T=
he information that I want to analyze and display information includes CPU =
usage, IRQ analysis(IRQ Statistics, IRQ Table, IRQ vs Count, IRQ vs Time), =
Linux Kernel(Control Flow, Resources)</span></div>
        </div>
      </div>
    </blockquote>
    <p>With an LTTng kernel trace, you can get all that. Add a UST trace
      to it and you can correlate both traces together.</p>
    <p>Cheers,</p>
    <p>Genevi=C3=A8ve<br>
    </p>
    <br>
  </div>

</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature"><div dir=3D"ltr"><div><div dir=3D"ltr"><font siz=
e=3D"4"><b>Ravindra Kumar Meena</b></font>,<div><span style=3D"color:rgb(10=
2,102,102)">B. Tech. Computer Science and Engineering,<br></span></div><div=
><span style=3D"color:rgb(102,102,102)"><a href=3D"https://www.iitism.ac.in=
/" style=3D"color:rgb(17,85,204)" target=3D"_blank">Indian Institute of Tec=
hnology (Indian School of Mines)</a>, Dhanbad</span></div></div></div></div=
></div>

--00000000000048bea005853ec27c--

--===============8078460827973656890==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============8078460827973656890==--
