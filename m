From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: possible to configure LTTng to use a different
 CLOCK_* ? [Re: LTTng Time Stamp Issue]
Date: Thu, 24 May 2018 18:03:43 -0400
Message-ID: <CA+jJMxsFKXJotyaezrq7cecya5vbRgMGGhT24wMcEE6+TWZm+w__14837.98772465$1527199337$gmane$org@mail.gmail.com>
References: <BY2PR0501MB21035DCCC28AFAD0D12C0587E3B40@BY2PR0501MB2103.namprd05.prod.outlook.com>
 <CA+jJMxvKyCt4VZ6U0gLu1KGA3S==CPTkTTGErOfXgBgms68xRg@mail.gmail.com>
 <f1311a1d-33d4-4ae0-f9e8-1de1f7f552ed@suse.de>
 <3BE61771-4BA9-4E00-93B5-67ADA3276AC5@demoninsight.com>
 <CA+jJMxt_9dFKpCa15iX8eNgQdnxPPgA86csuBLc-CmzA8trCsg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4828922500876736741=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 40sNhF2GzlznVn
 for <lttng-dev@lists.lttng.org>; Thu, 24 May 2018 18:04:12 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 8B058223565
 for <lttng-dev@lists.lttng.org>; Thu, 24 May 2018 18:04:06 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
 by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
 with ESMTP id PiIwoR7sk7qj for <lttng-dev@lists.lttng.org>;
 Thu, 24 May 2018 18:04:05 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id CA8E3223555
 for <lttng-dev@lists.lttng.org>; Thu, 24 May 2018 18:04:05 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
 by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
 with ESMTP id JGmgHFZ-hpKe for <lttng-dev@lists.lttng.org>;
 Thu, 24 May 2018 18:04:05 -0400 (EDT)
Received: from mail-wr0-f180.google.com (mail-wr0-f180.google.com
 [209.85.128.180])
 by mail.efficios.com (Postfix) with ESMTPSA id 6870522352D
 for <lttng-dev@lists.lttng.org>; Thu, 24 May 2018 18:04:05 -0400 (EDT)
Received: by mail-wr0-f180.google.com with SMTP id j1-v6so5781393wrm.1
 for <lttng-dev@lists.lttng.org>; Thu, 24 May 2018 15:04:05 -0700 (PDT)
In-Reply-To: <CA+jJMxt_9dFKpCa15iX8eNgQdnxPPgA86csuBLc-CmzA8trCsg@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Vlad <vlad@demoninsight.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, Sai Tujala <Sai.Tujala@mathworks.in>
List-Id: lttng-dev@lists.lttng.org

--===============4828922500876736741==
Content-Type: multipart/alternative; boundary="000000000000601cbe056cfad483"

--000000000000601cbe056cfad483
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Just realized my e-mail client didn't show Jonathan's response. Sorry!

J=C3=A9r=C3=A9mie

On 24 May 2018 at 17:53, J=C3=A9r=C3=A9mie Galarneau <jeremie.galarneau@eff=
icios.com>
wrote:

>
>
> On 22 May 2018 at 11:16, Vlad <vlad@demoninsight.com> wrote:
>
>> Greetings,
>>
>> I have what I hope is a related question:
>>
>> - my use case is:
>> - I use LTTng for userspace events only (at this time);
>> - I have the system clock (CLOCK_REALTIME) driven by a PTP driver that
>> comes with a NIC (SolarFlare) that slaves the system to an externally
>> provided high-grade PTP master;
>> - the NIC stamps all arriving IP packets at the hardware level and the
>> driver then makes the timestamps available in userspace along with each
>> packet;
>> - I would like to be able to correlate these timestamps with LTTng
>> timestamps on the same system.
>>
>> - is there a way to configure LTTng to use a user-specified CLOCK_* type=
?
>> I understand that that would de-cohere the timestamps from other
>> interesting timestamps (kernel events, etc) but my case above is valuabl=
e
>> enough that I=E2=80=99d be willing to forgo everything else.
>>
>
> Hi Vlad,
>
> lttng-ust's clock plug-in interface seems like a good fit for what you
> want.
>
> Have a look at the example in lttng-ust's source tree:
> https://github.com/lttng/lttng-ust/tree/master/doc/examples/clock-overrid=
e
>
> Thanks!
> J=C3=A9r=C3=A9mie
>
>
>>
>> Thank you in advance,
>> Vlad
>>
>> On Apr 20, 2018, at 4:53 PM, Mohamad Gebai <mgebai@suse.de> wrote:
>>
>> LTTng uses the monotonic clock [1] to timestamp the event at trace-time.
>> The monotonic clock is more appropriate than the real time (CLOCK_REALTI=
ME)
>> when you want to timestamp/compare/order certain events within the same
>> system relatively to each other. Using the real time clock would cause a
>> problem if say someone (or something, like ntp, or kvm in a VM) changed =
the
>> system's time while tracing.
>>
>> With that being said, the monotonic clock doesn't give you a time that i=
s
>> very meaningful as a human (its reference is the system boot). Having th=
e
>> timestamps as an actual date and time would be more interesting. LTTng
>> stores the real time at the beginning of the trace and stores it in the
>> metadata, which is later used to convert the timestamps from monotonic t=
ime
>> to real time. If you change the system's real time while tracing, it won=
't
>> have any effect on the timestamps of the recorded events.
>>
>> Mohamad
>>
>> [1] https://linux.die.net/man/3/clock_gettime
>> [2] http://linuxmogeb.blogspot.ca/2013/10/how-does-clockgettime-work.htm=
l
>>
>>
>> On 04/20/2018 11:37 AM, J=C3=A9r=C3=A9mie Galarneau wrote:
>>
>> Hi,
>>
>> I'm adding the LTTng mailing list in CC for the benefit of the community
>> and so people add to or correct my explanation.
>>
>> The CTF specification describes the meaning of those fields:
>> http://diamon.org/ctf/#spec8
>>
>> In your case, this means that the timestamps in the trace are expressed
>> relative to an arbitrary time set 1524226572435601778 clock ticks after
>> 00:00:00 on 1 January 1970.
>>
>> To take your specific example:
>> Your clock is running at 1,000,000,000 Hz, meaning the duration of a
>> clock tick (period) is of 1 ns.
>>
>> The event has occurred at
>> 1524226572435601778 (offset) + 00000003827855360941 (event clock value)
>> nanoseconds after UNIX Epoch. That leads us to around Friday, April 20,
>> 2018 1:20:00 PM (GMT).
>>
>> Regards,
>> J=C3=A9r=C3=A9mie
>>
>>
>>
>> On 20 April 2018 at 11:06, Sai Tujala <Sai.Tujala@mathworks.in> wrote:
>>
>>> Hi Jeremie,
>>>
>>>
>>>                 In metadata file of LTTng trace session,  offset from
>>> Epoch is =E2=80=9C1524226572435601778=E2=80=9D and time stamp of an eve=
nt in channel data
>>> files is starting from =E2=80=9C00000003827855360941=E2=80=9D. Can you =
brief about
>>> relevance between these two time stamps.
>>>
>>>
>>> freq =3D 1000000000; /* Frequency, in Hz */
>>>
>>>         /* clock value offset from Epoch is: offset * (1/freq) */
>>>
>>>         offset =3D 1524226572435601778;
>>>
>>>
>>>
>>> Thanks & Regards,
>>>
>>> T Sai Kiran
>>>
>>>
>>
>>
>>
>> --
>> J=C3=A9r=C3=A9mie Galarneau
>> EfficiOS Inc.
>> http://www.efficios.com
>>
>>
>> _______________________________________________
>> lttng-dev mailing listlttng-dev@lists.lttng.orghttps://lists.lttng.org/c=
gi-bin/mailman/listinfo/lttng-dev
>>
>>
>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>>
>>
>>
>
>
> --
> J=C3=A9r=C3=A9mie Galarneau
> EfficiOS Inc.
> http://www.efficios.com
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
>


--=20
J=C3=A9r=C3=A9mie Galarneau
EfficiOS Inc.
http://www.efficios.com

--000000000000601cbe056cfad483
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Just realized my e-mail client didn&#39;t show Jonath=
an&#39;s response. Sorry!</div><div><br></div><div>J=C3=A9r=C3=A9mie<br></d=
iv><div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On 24 May=
 2018 at 17:53, J=C3=A9r=C3=A9mie Galarneau <span dir=3D"ltr">&lt;<a href=
=3D"mailto:jeremie.galarneau@efficios.com" target=3D"_blank">jeremie.galarn=
eau@efficios.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote"=
 style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><d=
iv dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quote=
"><span class=3D"">On 22 May 2018 at 11:16, Vlad <span dir=3D"ltr">&lt;<a h=
ref=3D"mailto:vlad@demoninsight.com" target=3D"_blank">vlad@demoninsight.co=
m</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
"><div><div><div>Greetings,</div><div><br></div><div><span class=3D"m_-9020=
594725317779918gmail-m_2645552137873417523Apple-tab-span" style=3D"white-sp=
ace:pre-wrap">	</span>I have what I hope is a related question:</div><div><=
br></div><div>- my use case is:</div><div><span class=3D"m_-902059472531777=
9918gmail-m_2645552137873417523Apple-tab-span" style=3D"white-space:pre-wra=
p">	</span>- I use LTTng for userspace events only (at this time);</div><di=
v><span class=3D"m_-9020594725317779918gmail-m_2645552137873417523Apple-tab=
-span" style=3D"white-space:pre-wrap">	</span>-=C2=A0I have the system cloc=
k (CLOCK_REALTIME) driven by a PTP driver that comes with a NIC (SolarFlare=
) that slaves the system to an externally provided high-grade PTP master;</=
div><div><span class=3D"m_-9020594725317779918gmail-m_2645552137873417523Ap=
ple-tab-span" style=3D"white-space:pre-wrap">	</span>-=C2=A0the NIC stamps =
all arriving IP packets at the hardware level and the driver then makes the=
 timestamps available in userspace along with each packet;</div><div><span =
class=3D"m_-9020594725317779918gmail-m_2645552137873417523Apple-tab-span" s=
tyle=3D"white-space:pre-wrap">	</span>-=C2=A0I would like to be able to cor=
relate these timestamps with LTTng timestamps on the same system.</div></di=
v><div><br></div><div>- is there a way to configure LTTng to use a user-spe=
cified CLOCK_* type? I understand that that would de-cohere the timestamps =
from other interesting timestamps (kernel events, etc) but my case above is=
 valuable enough that I=E2=80=99d be willing to forgo everything else.</div=
></div></blockquote><div><br></div></span><div>Hi Vlad,</div><div><br></div=
><div>lttng-ust&#39;s clock plug-in interface seems like a good fit for wha=
t you want.</div><div><br></div><div>Have a look at the example in lttng-us=
t&#39;s source tree:<br></div><div><a href=3D"https://github.com/lttng/lttn=
g-ust/tree/master/doc/examples/clock-override" target=3D"_blank">https://gi=
thub.com/lttng/<wbr>lttng-ust/tree/master/doc/<wbr>examples/clock-override<=
/a></div><div><br></div><div>Thanks!</div><span class=3D"HOEnZb"><font colo=
r=3D"#888888"><div>J=C3=A9r=C3=A9mie<br></div></font></span><div><div class=
=3D"h5"><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">=
<div><div><br></div><div>Thank you in advance,</div><div>Vlad</div><br><div=
><div>On Apr 20, 2018, at 4:53 PM, Mohamad Gebai &lt;<a href=3D"mailto:mgeb=
ai@suse.de" target=3D"_blank">mgebai@suse.de</a>&gt; wrote:</div><br class=
=3D"m_-9020594725317779918gmail-m_2645552137873417523Apple-interchange-newl=
ine"><blockquote type=3D"cite">
 =20
   =20
 =20
  <div bgcolor=3D"#FFFFFF">
    LTTng uses the monotonic clock [1] to timestamp the event at
    trace-time. The monotonic clock is more appropriate than the real
    time (CLOCK_REALTIME) when you want to timestamp/compare/order
    certain events within the same system relatively to each other.
    Using the real time clock would cause a problem if say someone (or
    something, like ntp, or kvm in a VM) changed the system&#39;s time whil=
e
    tracing.<br>
    <br>
    With that being said, the monotonic clock doesn&#39;t give you a time
    that is very meaningful as a human (its reference is the system
    boot). Having the timestamps as an actual date and time would be
    more interesting. LTTng stores the real time at the beginning of the
    trace and stores it in the metadata, which is later used to convert
    the timestamps from monotonic time to real time. If you change the
    system&#39;s real time while tracing, it won&#39;t have any effect on t=
he
    timestamps of the recorded events.<br>
    <br>
    Mohamad<br>
    <br>
    [1] <a class=3D"m_-9020594725317779918gmail-m_2645552137873417523moz-tx=
t-link-freetext" href=3D"https://linux.die.net/man/3/clock_gettime" target=
=3D"_blank">https://linux.die.net/man/3/cl<wbr>ock_gettime</a><br>
    [2]
    <a class=3D"m_-9020594725317779918gmail-m_2645552137873417523moz-txt-li=
nk-freetext" href=3D"http://linuxmogeb.blogspot.ca/2013/10/how-does-clockge=
ttime-work.html" target=3D"_blank">http://linuxmogeb.blogspot.ca/<wbr>2013/=
10/how-does-clockgettime-<wbr>work.html</a><br>
    <br>
    <br>
    <div class=3D"m_-9020594725317779918gmail-m_2645552137873417523moz-cite=
-prefix">On 04/20/2018 11:37 AM, J=C3=A9r=C3=A9mie
      Galarneau wrote:<br>
    </div>
    <blockquote type=3D"cite">
      <div dir=3D"ltr">
        <div>
          <div>
            <div>
              <div>
                <div>
                  <div>Hi,<br>
                    <br>
                  </div>
                  <div>I&#39;m adding the LTTng mailing list in CC for the
                    benefit of the community and so people add to or
                    correct my explanation.<br>
                  </div>
                  <div><br>
                    The CTF specification describes the meaning of those
                    fields:<br>
                    <a href=3D"http://diamon.org/ctf/#spec8" target=3D"_bla=
nk">http://diamon.org/ctf/#spec8</a><br>
                    <br>
                  </div>
                  In your case, this means that the timestamps in the
                  trace are expressed relative to an arbitrary time set
                  1524226572435601778 clock ticks after 00:00:00 on 1
                  January 1970.<br>
                  <br>
                </div>
                To take your specific example:<br>
              </div>
              Your clock is running at 1,000,000,000 Hz, meaning the
              duration of a clock tick (period) is of 1 ns.<br>
              <br>
            </div>
            The event has occurred at<br>
          </div>
          1524226572435601778 (offset) + 00000003827855360941 (event
          clock value) nanoseconds after UNIX Epoch. That leads us to
          around Friday, April 20, 2018 1:20:00 PM (GMT).<br>
          <br>
        </div>
        <div>Regards,<br>
        </div>
        J=C3=A9r=C3=A9mie<br>
        <div><br>
          <div>
            <div>
              <div>
                <div><br>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
      <div class=3D"gmail_extra"><br>
        <div class=3D"gmail_quote">On 20 April 2018 at 11:06, Sai Tujala <s=
pan dir=3D"ltr">&lt;<a href=3D"mailto:Sai.Tujala@mathworks.in" target=3D"_b=
lank">Sai.Tujala@mathworks.in</a>&gt;</span>
          wrote:<br>
          <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8=
ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
            <div lang=3D"EN-US">
              <div class=3D"m_-9020594725317779918gmail-m_26455521378734175=
23m_-293747052095318529WordSection1"><p class=3D"MsoNormal">Hi Jeremie,</p>=
<div>=C2=A0<br class=3D"m_-9020594725317779918gmail-m_2645552137873417523we=
bkit-block-placeholder"></div><p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 In me=
tadata file of
                  LTTng trace session, =C2=A0offset from Epoch is
                  =E2=80=9C1524226572435601778=E2=80=9D and time stamp of a=
n event in
                  channel data files is starting from
                  =E2=80=9C00000003827855360941=E2=80=9D. Can you brief abo=
ut relevance
                  between these two time stamps. </p><div>=C2=A0<br class=
=3D"m_-9020594725317779918gmail-m_2645552137873417523webkit-block-placehold=
er"></div><p class=3D"MsoNormal" style=3D"text-indent:0.5in">freq =3D
                  1000000000; /* Frequency, in Hz */</p><p class=3D"MsoNorm=
al">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* clock value offset from
                  Epoch is: offset * (1/freq) */</p><p class=3D"MsoNormal">=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 offset =3D
                  1524226572435601778;</p><div>=C2=A0<br class=3D"m_-902059=
4725317779918gmail-m_2645552137873417523webkit-block-placeholder"></div><di=
v>=C2=A0<br class=3D"m_-9020594725317779918gmail-m_2645552137873417523webki=
t-block-placeholder"></div><p class=3D"MsoNormal">Thanks &amp; Regards,</p>=
<p class=3D"MsoNormal">T Sai Kiran</p><div>=C2=A0<br class=3D"m_-9020594725=
317779918gmail-m_2645552137873417523webkit-block-placeholder"></div>
              </div>
            </div>
          </blockquote>
        </div>
        <br>
        <br clear=3D"all">
        <br>
        -- <br>
        <div class=3D"m_-9020594725317779918gmail-m_2645552137873417523gmai=
l_signature">J=C3=A9r=C3=A9mie
          Galarneau<br>
          EfficiOS Inc.<br>
          <a href=3D"http://www.efficios.com/" target=3D"_blank">http://www=
.efficios.com</a></div>
      </div>
      <br>
      <fieldset class=3D"m_-9020594725317779918gmail-m_2645552137873417523m=
imeAttachmentHeader"></fieldset>
      <br>
      <pre>______________________________<wbr>_________________
lttng-dev mailing list
<a class=3D"m_-9020594725317779918gmail-m_2645552137873417523moz-txt-link-a=
bbreviated" href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">ltt=
ng-dev@lists.lttng.org</a>
<a class=3D"m_-9020594725317779918gmail-m_2645552137873417523moz-txt-link-f=
reetext" href=3D"https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev=
" target=3D"_blank">https://lists.lttng.org/cgi-bi<wbr>n/mailman/listinfo/l=
ttng-dev</a>
</pre>
    </blockquote>
    <br>
  </div>

______________________________<wbr>_________________<br>lttng-dev mailing l=
ist<br><a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng=
-dev@lists.lttng.org</a><br><a href=3D"https://lists.lttng.org/cgi-bin/mail=
man/listinfo/lttng-dev" target=3D"_blank">https://lists.lttng.org/cgi-bi<wb=
r>n/mailman/listinfo/lttng-dev</a><br></blockquote></div><br></div></blockq=
uote></div></div></div><div><div class=3D"h5"><br><br clear=3D"all"><br>-- =
<br><div class=3D"m_-9020594725317779918gmail_signature">J=C3=A9r=C3=A9mie =
Galarneau<br>EfficiOS Inc.<br><a href=3D"http://www.efficios.com" target=3D=
"_blank">http://www.efficios.com</a></div>
</div></div></div></div>
<br>______________________________<wbr>_________________<br>
lttng-dev mailing list<br>
<a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org</a><=
br>
<a href=3D"https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" rel=
=3D"noreferrer" target=3D"_blank">https://lists.lttng.org/cgi-<wbr>bin/mail=
man/listinfo/lttng-dev</a><br>
<br></blockquote></div><br><br clear=3D"all"><br>-- <br><div class=3D"gmail=
_signature" data-smartmail=3D"gmail_signature">J=C3=A9r=C3=A9mie Galarneau<=
br>EfficiOS Inc.<br><a href=3D"http://www.efficios.com" target=3D"_blank">h=
ttp://www.efficios.com</a></div>
</div></div></div>

--000000000000601cbe056cfad483--

--===============4828922500876736741==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============4828922500876736741==--
