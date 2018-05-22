From: Vlad <vlad@demoninsight.com>
Subject: possible to configure LTTng to use a different CLOCK_*
	? [Re: LTTng Time Stamp Issue]
Date: Tue, 22 May 2018 11:16:20 -0400
Message-ID: <3BE61771-4BA9-4E00-93B5-67ADA3276AC5__39510.90362757$1527002069$gmane$org@demoninsight.com>
References: <BY2PR0501MB21035DCCC28AFAD0D12C0587E3B40@BY2PR0501MB2103.namprd05.prod.outlook.com>
 <CA+jJMxvKyCt4VZ6U0gLu1KGA3S==CPTkTTGErOfXgBgms68xRg@mail.gmail.com>
 <f1311a1d-33d4-4ae0-f9e8-1de1f7f552ed@suse.de>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: multipart/mixed; boundary="===============7942254597946781732=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qt0-x234.google.com (mail-qt0-x234.google.com
 [IPv6:2607:f8b0:400d:c0d::234])
 by lists.lttng.org (Postfix) with ESMTPS id 40qzkd0snRz17dt
 for <lttng-dev@lists.lttng.org>; Tue, 22 May 2018 11:16:24 -0400 (EDT)
Received: by mail-qt0-x234.google.com with SMTP id f1-v6so23889480qtj.6
 for <lttng-dev@lists.lttng.org>; Tue, 22 May 2018 08:16:24 -0700 (PDT)
In-Reply-To: <f1311a1d-33d4-4ae0-f9e8-1de1f7f552ed@suse.de>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Mohamad Gebai <mgebai@suse.de>
Cc: Sai Tujala <Sai.Tujala@mathworks.in>, lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org


--===============7942254597946781732==
Content-Type: multipart/alternative; boundary="Apple-Mail=_D27041AE-0929-44AD-A8D3-7E1208F5565F"


--Apple-Mail=_D27041AE-0929-44AD-A8D3-7E1208F5565F
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=windows-1252

Greetings,

	I have what I hope is a related question:

- my use case is:
	- I use LTTng for userspace events only (at this time);
	- I have the system clock (CLOCK_REALTIME) driven by a PTP =
driver that comes with a NIC (SolarFlare) that slaves the system to an =
externally provided high-grade PTP master;
	- the NIC stamps all arriving IP packets at the hardware level =
and the driver then makes the timestamps available in userspace along =
with each packet;
	- I would like to be able to correlate these timestamps with =
LTTng timestamps on the same system.

- is there a way to configure LTTng to use a user-specified CLOCK_* =
type? I understand that that would de-cohere the timestamps from other =
interesting timestamps (kernel events, etc) but my case above is =
valuable enough that I=92d be willing to forgo everything else.

Thank you in advance,
Vlad

On Apr 20, 2018, at 4:53 PM, Mohamad Gebai <mgebai@suse.de> wrote:

> LTTng uses the monotonic clock [1] to timestamp the event at =
trace-time. The monotonic clock is more appropriate than the real time =
(CLOCK_REALTIME) when you want to timestamp/compare/order certain events =
within the same system relatively to each other.     Using the real time =
clock would cause a problem if say someone (or something, like ntp, or =
kvm in a VM) changed the system's time while tracing.
>=20
> With that being said, the monotonic clock doesn't give you a time that =
is very meaningful as a human (its reference is the system boot). Having =
the timestamps as an actual date and time would be more interesting. =
LTTng stores the real time at the beginning of the     trace and stores =
it in the metadata, which is later used to convert the timestamps from =
monotonic time to real time. If you change the system's real time while =
tracing, it won't have any effect on the timestamps of the recorded =
events.
>=20
> Mohamad
>=20
> [1] https://linux.die.net/man/3/clock_gettime
> [2] =
http://linuxmogeb.blogspot.ca/2013/10/how-does-clockgettime-work.html
>=20
>=20
> On 04/20/2018 11:37 AM, J=E9r=E9mie Galarneau wrote:
>> Hi,
>>=20
>> I'm adding the LTTng mailing list in CC for the benefit of the =
community and so people add to or correct my explanation.
>>=20
>> The CTF specification describes the meaning of those fields:
>> http://diamon.org/ctf/#spec8
>>=20
>> In your case, this means that the timestamps in the trace are =
expressed relative to an arbitrary time set 1524226572435601778 clock =
ticks after 00:00:00 on 1 January 1970.
>>=20
>> To take your specific example:
>> Your clock is running at 1,000,000,000 Hz, meaning the duration of a =
clock tick (period) is of 1 ns.
>>=20
>> The event has occurred at
>> 1524226572435601778 (offset) + 00000003827855360941 (event clock =
value) nanoseconds after UNIX Epoch. That leads us to around Friday, =
April 20, 2018 1:20:00 PM (GMT).
>>=20
>> Regards,
>> J=E9r=E9mie
>>=20
>>=20
>>=20
>> On 20 April 2018 at 11:06, Sai Tujala <Sai.Tujala@mathworks.in> =
wrote:
>> Hi Jeremie,
>>=20
>> =20
>>                 In metadata file of LTTng trace session,  offset from =
Epoch is =931524226572435601778=94 and time stamp of an event in channel =
data files is starting from =9300000003827855360941=94. Can you brief =
about relevance between these two time stamps.
>>=20
>> =20
>> freq =3D 1000000000; /* Frequency, in Hz */
>>=20
>>         /* clock value offset from Epoch is: offset * (1/freq) */
>>=20
>>         offset =3D 1524226572435601778;
>>=20
>> =20
>> =20
>> Thanks & Regards,
>>=20
>> T Sai Kiran
>>=20
>> =20
>>=20
>>=20
>>=20
>> --=20
>> J=E9r=E9mie Galarneau
>> EfficiOS Inc.
>> http://www.efficios.com
>>=20
>>=20
>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>=20
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev


--Apple-Mail=_D27041AE-0929-44AD-A8D3-7E1208F5565F
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=windows-1252

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html =
charset=3Dwindows-1252"></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: =
after-white-space;"><div><div>Greetings,</div><div><br></div><div><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>I have =
what I hope is a related question:</div><div><br></div><div>- my use =
case is:</div><div><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>- I use LTTng for userspace =
events only (at this time);</div><div><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>-&nbsp;I have the system clock =
(CLOCK_REALTIME) driven by a PTP driver that comes with a NIC =
(SolarFlare) that slaves the system to an externally provided high-grade =
PTP master;</div><div><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>-&nbsp;the NIC stamps all =
arriving IP packets at the hardware level and the driver then makes the =
timestamps available in userspace along with each =
packet;</div><div><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>-&nbsp;I would like to be able to =
correlate these timestamps with LTTng timestamps on the same =
system.</div></div><div><br></div><div>- is there a way to configure =
LTTng to use a user-specified CLOCK_* type? I understand that that would =
de-cohere the timestamps from other interesting timestamps (kernel =
events, etc) but my case above is valuable enough that I=92d be willing =
to forgo everything else.</div><div><br></div><div>Thank you in =
advance,</div><div>Vlad</div><br><div><div>On Apr 20, 2018, at 4:53 PM, =
Mohamad Gebai &lt;<a href=3D"mailto:mgebai@suse.de">mgebai@suse.de</a>&gt;=
 wrote:</div><br class=3D"Apple-interchange-newline"><blockquote =
type=3D"cite">
 =20
    <meta http-equiv=3D"Content-Type" content=3D"text/html; =
charset=3Dutf-8">
 =20
  <div text=3D"#000000" bgcolor=3D"#FFFFFF">
    LTTng uses the monotonic clock [1] to timestamp the event at
    trace-time. The monotonic clock is more appropriate than the real
    time (CLOCK_REALTIME) when you want to timestamp/compare/order
    certain events within the same system relatively to each other.
    Using the real time clock would cause a problem if say someone (or
    something, like ntp, or kvm in a VM) changed the system's time while
    tracing.<br>
    <br>
    With that being said, the monotonic clock doesn't give you a time
    that is very meaningful as a human (its reference is the system
    boot). Having the timestamps as an actual date and time would be
    more interesting. LTTng stores the real time at the beginning of the
    trace and stores it in the metadata, which is later used to convert
    the timestamps from monotonic time to real time. If you change the
    system's real time while tracing, it won't have any effect on the
    timestamps of the recorded events.<br>
    <br>
    Mohamad<br>
    <br>
    [1] <a class=3D"moz-txt-link-freetext" =
href=3D"https://linux.die.net/man/3/clock_gettime">https://linux.die.net/m=
an/3/clock_gettime</a><br>
    [2]
    <a class=3D"moz-txt-link-freetext" =
href=3D"http://linuxmogeb.blogspot.ca/2013/10/how-does-clockgettime-work.h=
tml">http://linuxmogeb.blogspot.ca/2013/10/how-does-clockgettime-work.html=
</a><br>
    <br>
    <br>
    <div class=3D"moz-cite-prefix">On 04/20/2018 11:37 AM, J=E9r=E9mie
      Galarneau wrote:<br>
    </div>
    <blockquote type=3D"cite" =
cite=3D"mid:CA+jJMxvKyCt4VZ6U0gLu1KGA3S=3D=3DCPTkTTGErOfXgBgms68xRg@mail.g=
mail.com">
      <div dir=3D"ltr">
        <div>
          <div>
            <div>
              <div>
                <div>
                  <div>Hi,<br>
                    <br>
                  </div>
                  <div>I'm adding the LTTng mailing list in CC for the
                    benefit of the community and so people add to or
                    correct my explanation.<br>
                  </div>
                  <div><br>
                    The CTF specification describes the meaning of those
                    fields:<br>
                    <a href=3D"http://diamon.org/ctf/#spec8" =
moz-do-not-send=3D"true">http://diamon.org/ctf/#spec8</a><br>
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
        J=E9r=E9mie<br>
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
        <div class=3D"gmail_quote">On 20 April 2018 at 11:06, Sai Tujala =
<span dir=3D"ltr">&lt;<a href=3D"mailto:Sai.Tujala@mathworks.in" =
target=3D"_blank" =
moz-do-not-send=3D"true">Sai.Tujala@mathworks.in</a>&gt;</span>
          wrote:<br>
          <blockquote class=3D"gmail_quote" style=3D"margin:0 0 0
            .8ex;border-left:1px #ccc solid;padding-left:1ex">
            <div link=3D"#0563C1" vlink=3D"#954F72" lang=3D"EN-US">
              <div class=3D"m_-293747052095318529WordSection1"><p =
class=3D"MsoNormal">Hi Jeremie,</p><div>&nbsp;<br =
class=3D"webkit-block-placeholder"></div><p =
class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; In metadata file of
                  LTTng trace session, &nbsp;offset from Epoch is
                  =931524226572435601778=94 and time stamp of an event =
in
                  channel data files is starting from
                  =9300000003827855360941=94. Can you brief about =
relevance
                  between these two time stamps. </p><div>&nbsp;<br =
class=3D"webkit-block-placeholder"></div><p class=3D"MsoNormal" =
style=3D"text-indent:.5in">freq =3D
                  1000000000; /* Frequency, in Hz */</p><p =
class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* clock =
value offset from
                  Epoch is: offset * (1/freq) */</p><p =
class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; offset =3D
                  1524226572435601778;</p><div>&nbsp;<br =
class=3D"webkit-block-placeholder"></div><div>&nbsp;<br =
class=3D"webkit-block-placeholder"></div><p class=3D"MsoNormal">Thanks =
&amp; Regards,</p><p class=3D"MsoNormal">T Sai Kiran</p><div>&nbsp;<br =
class=3D"webkit-block-placeholder"></div>
              </div>
            </div>
          </blockquote>
        </div>
        <br>
        <br clear=3D"all">
        <br>
        -- <br>
        <div class=3D"gmail_signature" =
data-smartmail=3D"gmail_signature">J=E9r=E9mie
          Galarneau<br>
          EfficiOS Inc.<br>
          <a href=3D"http://www.efficios.com/" target=3D"_blank" =
moz-do-not-send=3D"true">http://www.efficios.com</a></div>
      </div>
      <br>
      <fieldset class=3D"mimeAttachmentHeader"></fieldset>
      <br>
      <pre wrap=3D"">_______________________________________________
lttng-dev mailing list
<a class=3D"moz-txt-link-abbreviated" =
href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org</a>
<a class=3D"moz-txt-link-freetext" =
href=3D"https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev">https:=
//lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a>
</pre>
    </blockquote>
    <br>
  </div>

_______________________________________________<br>lttng-dev mailing =
list<br><a =
href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org</a><br=
>https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev<br></blockquot=
e></div><br></body></html>=

--Apple-Mail=_D27041AE-0929-44AD-A8D3-7E1208F5565F--

--===============7942254597946781732==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============7942254597946781732==--
