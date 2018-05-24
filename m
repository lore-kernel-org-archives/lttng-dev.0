From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: possible to configure LTTng to use a different
 CLOCK_* ? [Re: LTTng Time Stamp Issue]
Date: Thu, 24 May 2018 17:53:35 -0400
Message-ID: <CA+jJMxt_9dFKpCa15iX8eNgQdnxPPgA86csuBLc-CmzA8trCsg__40631.3379797668$1527198729$gmane$org@mail.gmail.com>
References: <BY2PR0501MB21035DCCC28AFAD0D12C0587E3B40@BY2PR0501MB2103.namprd05.prod.outlook.com>
 <CA+jJMxvKyCt4VZ6U0gLu1KGA3S==CPTkTTGErOfXgBgms68xRg@mail.gmail.com>
 <f1311a1d-33d4-4ae0-f9e8-1de1f7f552ed@suse.de>
 <3BE61771-4BA9-4E00-93B5-67ADA3276AC5@demoninsight.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7926348921394678223=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 40sNSX6qCSznTm
 for <lttng-dev@lists.lttng.org>; Thu, 24 May 2018 17:54:04 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 41A7D223280
 for <lttng-dev@lists.lttng.org>; Thu, 24 May 2018 17:53:58 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
 by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
 with ESMTP id psLNP9p3Ic7k for <lttng-dev@lists.lttng.org>;
 Thu, 24 May 2018 17:53:57 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 7CDA322326B
 for <lttng-dev@lists.lttng.org>; Thu, 24 May 2018 17:53:57 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
 by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
 with ESMTP id UnJxSx5dhioA for <lttng-dev@lists.lttng.org>;
 Thu, 24 May 2018 17:53:57 -0400 (EDT)
Received: from mail-wm0-f42.google.com (mail-wm0-f42.google.com [74.125.82.42])
 by mail.efficios.com (Postfix) with ESMTPSA id 1CF1D223232
 for <lttng-dev@lists.lttng.org>; Thu, 24 May 2018 17:53:57 -0400 (EDT)
Received: by mail-wm0-f42.google.com with SMTP id x12-v6so29298872wmc.0
 for <lttng-dev@lists.lttng.org>; Thu, 24 May 2018 14:53:57 -0700 (PDT)
In-Reply-To: <3BE61771-4BA9-4E00-93B5-67ADA3276AC5@demoninsight.com>
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

--===============7926348921394678223==
Content-Type: multipart/alternative; boundary="0000000000001d4a90056cfab091"

--0000000000001d4a90056cfab091
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 22 May 2018 at 11:16, Vlad <vlad@demoninsight.com> wrote:

> Greetings,
>
> I have what I hope is a related question:
>
> - my use case is:
> - I use LTTng for userspace events only (at this time);
> - I have the system clock (CLOCK_REALTIME) driven by a PTP driver that
> comes with a NIC (SolarFlare) that slaves the system to an externally
> provided high-grade PTP master;
> - the NIC stamps all arriving IP packets at the hardware level and the
> driver then makes the timestamps available in userspace along with each
> packet;
> - I would like to be able to correlate these timestamps with LTTng
> timestamps on the same system.
>
> - is there a way to configure LTTng to use a user-specified CLOCK_* type?
> I understand that that would de-cohere the timestamps from other
> interesting timestamps (kernel events, etc) but my case above is valuable
> enough that I=E2=80=99d be willing to forgo everything else.
>

Hi Vlad,

lttng-ust's clock plug-in interface seems like a good fit for what you want=
.

Have a look at the example in lttng-ust's source tree:
https://github.com/lttng/lttng-ust/tree/master/doc/examples/clock-override

Thanks!
J=C3=A9r=C3=A9mie


>
> Thank you in advance,
> Vlad
>
> On Apr 20, 2018, at 4:53 PM, Mohamad Gebai <mgebai@suse.de> wrote:
>
> LTTng uses the monotonic clock [1] to timestamp the event at trace-time.
> The monotonic clock is more appropriate than the real time (CLOCK_REALTIM=
E)
> when you want to timestamp/compare/order certain events within the same
> system relatively to each other. Using the real time clock would cause a
> problem if say someone (or something, like ntp, or kvm in a VM) changed t=
he
> system's time while tracing.
>
> With that being said, the monotonic clock doesn't give you a time that is
> very meaningful as a human (its reference is the system boot). Having the
> timestamps as an actual date and time would be more interesting. LTTng
> stores the real time at the beginning of the trace and stores it in the
> metadata, which is later used to convert the timestamps from monotonic ti=
me
> to real time. If you change the system's real time while tracing, it won'=
t
> have any effect on the timestamps of the recorded events.
>
> Mohamad
>
> [1] https://linux.die.net/man/3/clock_gettime
> [2] http://linuxmogeb.blogspot.ca/2013/10/how-does-clockgettime-work.html
>
>
> On 04/20/2018 11:37 AM, J=C3=A9r=C3=A9mie Galarneau wrote:
>
> Hi,
>
> I'm adding the LTTng mailing list in CC for the benefit of the community
> and so people add to or correct my explanation.
>
> The CTF specification describes the meaning of those fields:
> http://diamon.org/ctf/#spec8
>
> In your case, this means that the timestamps in the trace are expressed
> relative to an arbitrary time set 1524226572435601778 clock ticks after
> 00:00:00 on 1 January 1970.
>
> To take your specific example:
> Your clock is running at 1,000,000,000 Hz, meaning the duration of a cloc=
k
> tick (period) is of 1 ns.
>
> The event has occurred at
> 1524226572435601778 (offset) + 00000003827855360941 (event clock value)
> nanoseconds after UNIX Epoch. That leads us to around Friday, April 20,
> 2018 1:20:00 PM (GMT).
>
> Regards,
> J=C3=A9r=C3=A9mie
>
>
>
> On 20 April 2018 at 11:06, Sai Tujala <Sai.Tujala@mathworks.in> wrote:
>
>> Hi Jeremie,
>>
>>
>>                 In metadata file of LTTng trace session,  offset from
>> Epoch is =E2=80=9C1524226572435601778=E2=80=9D and time stamp of an even=
t in channel data
>> files is starting from =E2=80=9C00000003827855360941=E2=80=9D. Can you b=
rief about
>> relevance between these two time stamps.
>>
>>
>> freq =3D 1000000000; /* Frequency, in Hz */
>>
>>         /* clock value offset from Epoch is: offset * (1/freq) */
>>
>>         offset =3D 1524226572435601778;
>>
>>
>>
>> Thanks & Regards,
>>
>> T Sai Kiran
>>
>>
>
>
>
> --
> J=C3=A9r=C3=A9mie Galarneau
> EfficiOS Inc.
> http://www.efficios.com
>
>
> _______________________________________________
> lttng-dev mailing listlttng-dev@lists.lttng.orghttps://lists.lttng.org/cg=
i-bin/mailman/listinfo/lttng-dev
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
>
>


--=20
J=C3=A9r=C3=A9mie Galarneau
EfficiOS Inc.
http://www.efficios.com

--0000000000001d4a90056cfab091
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On 22 May 2018 at 11:16, Vlad <span dir=3D"ltr">&lt;<a href=3D"mailto:v=
lad@demoninsight.com" target=3D"_blank">vlad@demoninsight.com</a>&gt;</span=
> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div style=3D=
"overflow-wrap: break-word;"><div><div>Greetings,</div><div><br></div><div>=
<span class=3D"gmail-m_2645552137873417523Apple-tab-span" style=3D"white-sp=
ace:pre-wrap">	</span>I have what I hope is a related question:</div><div><=
br></div><div>- my use case is:</div><div><span class=3D"gmail-m_2645552137=
873417523Apple-tab-span" style=3D"white-space:pre-wrap">	</span>- I use LTT=
ng for userspace events only (at this time);</div><div><span class=3D"gmail=
-m_2645552137873417523Apple-tab-span" style=3D"white-space:pre-wrap">	</spa=
n>-=C2=A0I have the system clock (CLOCK_REALTIME) driven by a PTP driver th=
at comes with a NIC (SolarFlare) that slaves the system to an externally pr=
ovided high-grade PTP master;</div><div><span class=3D"gmail-m_264555213787=
3417523Apple-tab-span" style=3D"white-space:pre-wrap">	</span>-=C2=A0the NI=
C stamps all arriving IP packets at the hardware level and the driver then =
makes the timestamps available in userspace along with each packet;</div><d=
iv><span class=3D"gmail-m_2645552137873417523Apple-tab-span" style=3D"white=
-space:pre-wrap">	</span>-=C2=A0I would like to be able to correlate these =
timestamps with LTTng timestamps on the same system.</div></div><div><br></=
div><div>- is there a way to configure LTTng to use a user-specified CLOCK_=
* type? I understand that that would de-cohere the timestamps from other in=
teresting timestamps (kernel events, etc) but my case above is valuable eno=
ugh that I=E2=80=99d be willing to forgo everything else.</div></div></bloc=
kquote><div><br></div><div>Hi Vlad,</div><div><br></div><div>lttng-ust&#39;=
s clock plug-in interface seems like a good fit for what you want.</div><di=
v><br></div><div>Have a look at the example in lttng-ust&#39;s source tree:=
<br></div><div><a href=3D"https://github.com/lttng/lttng-ust/tree/master/do=
c/examples/clock-override">https://github.com/lttng/lttng-ust/tree/master/d=
oc/examples/clock-override</a></div><div><br></div><div>Thanks!</div><div>J=
=C3=A9r=C3=A9mie<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex"><div style=3D"overflow-wrap: break-word;"><div><br></div>=
<div>Thank you in advance,</div><div>Vlad</div><br><div><div>On Apr 20, 201=
8, at 4:53 PM, Mohamad Gebai &lt;<a href=3D"mailto:mgebai@suse.de" target=
=3D"_blank">mgebai@suse.de</a>&gt; wrote:</div><br class=3D"gmail-m_2645552=
137873417523Apple-interchange-newline"><blockquote type=3D"cite">
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
    [1] <a class=3D"gmail-m_2645552137873417523moz-txt-link-freetext" href=
=3D"https://linux.die.net/man/3/clock_gettime" target=3D"_blank">https://li=
nux.die.net/man/3/<wbr>clock_gettime</a><br>
    [2]
    <a class=3D"gmail-m_2645552137873417523moz-txt-link-freetext" href=3D"h=
ttp://linuxmogeb.blogspot.ca/2013/10/how-does-clockgettime-work.html" targe=
t=3D"_blank">http://linuxmogeb.blogspot.ca/<wbr>2013/10/how-does-clockgetti=
me-<wbr>work.html</a><br>
    <br>
    <br>
    <div class=3D"gmail-m_2645552137873417523moz-cite-prefix">On 04/20/2018=
 11:37 AM, J=C3=A9r=C3=A9mie
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
              <div class=3D"gmail-m_2645552137873417523m_-29374705209531852=
9WordSection1"><p class=3D"MsoNormal">Hi Jeremie,</p><div>=C2=A0<br class=
=3D"gmail-m_2645552137873417523webkit-block-placeholder"></div><p class=3D"=
MsoNormal">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 In metadata file of
                  LTTng trace session, =C2=A0offset from Epoch is
                  =E2=80=9C1524226572435601778=E2=80=9D and time stamp of a=
n event in
                  channel data files is starting from
                  =E2=80=9C00000003827855360941=E2=80=9D. Can you brief abo=
ut relevance
                  between these two time stamps. </p><div>=C2=A0<br class=
=3D"gmail-m_2645552137873417523webkit-block-placeholder"></div><p class=3D"=
MsoNormal" style=3D"text-indent:0.5in">freq =3D
                  1000000000; /* Frequency, in Hz */</p><p class=3D"MsoNorm=
al">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* clock value offset from
                  Epoch is: offset * (1/freq) */</p><p class=3D"MsoNormal">=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 offset =3D
                  1524226572435601778;</p><div>=C2=A0<br class=3D"gmail-m_2=
645552137873417523webkit-block-placeholder"></div><div>=C2=A0<br class=3D"g=
mail-m_2645552137873417523webkit-block-placeholder"></div><p class=3D"MsoNo=
rmal">Thanks &amp; Regards,</p><p class=3D"MsoNormal">T Sai Kiran</p><div>=
=C2=A0<br class=3D"gmail-m_2645552137873417523webkit-block-placeholder"></d=
iv>
              </div>
            </div>
          </blockquote>
        </div>
        <br>
        <br clear=3D"all">
        <br>
        -- <br>
        <div class=3D"gmail-m_2645552137873417523gmail_signature">J=C3=A9r=
=C3=A9mie
          Galarneau<br>
          EfficiOS Inc.<br>
          <a href=3D"http://www.efficios.com/" target=3D"_blank">http://www=
.efficios.com</a></div>
      </div>
      <br>
      <fieldset class=3D"gmail-m_2645552137873417523mimeAttachmentHeader"><=
/fieldset>
      <br>
      <pre>______________________________<wbr>_________________
lttng-dev mailing list
<a class=3D"gmail-m_2645552137873417523moz-txt-link-abbreviated" href=3D"ma=
ilto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-dev@lists.lttng.org=
</a>
<a class=3D"gmail-m_2645552137873417523moz-txt-link-freetext" href=3D"https=
://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" target=3D"_blank">ht=
tps://lists.lttng.org/cgi-<wbr>bin/mailman/listinfo/lttng-dev</a>
</pre>
    </blockquote>
    <br>
  </div>

______________________________<wbr>_________________<br>lttng-dev mailing l=
ist<br><a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng=
-dev@lists.lttng.org</a><br><a href=3D"https://lists.lttng.org/cgi-bin/mail=
man/listinfo/lttng-dev" target=3D"_blank">https://lists.lttng.org/cgi-<wbr>=
bin/mailman/listinfo/lttng-dev</a><br></blockquote></div><br></div></blockq=
uote></div><br><br clear=3D"all"><br>-- <br><div class=3D"gmail_signature">=
J=C3=A9r=C3=A9mie Galarneau<br>EfficiOS Inc.<br><a href=3D"http://www.effic=
ios.com" target=3D"_blank">http://www.efficios.com</a></div>
</div></div>

--0000000000001d4a90056cfab091--

--===============7926348921394678223==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============7926348921394678223==--
