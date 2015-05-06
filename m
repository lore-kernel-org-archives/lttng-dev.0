From: shirish gajera <gajerashirish@gmail.com>
Subject: Re: Error while enabling multiple channel for same
	session
Date: Wed, 6 May 2015 13:59:19 -0700
Message-ID: <CAG77vrqF1jF-Lp6cBvVcAwiuQtp-uaemW9PVtPFjg2Tr8_KHxw__15801.8424794593$1430946047$gmane$org@mail.gmail.com>
References: <CAG77vrpmzfhZ419CV3zVt83e6B4cMoT-2xA8kvwH=aPaOLwSFQ@mail.gmail.com>
 <CA+jJMxuBBbKarHkCMxGHUWioNeQu-Oa=14mFWP9AXT9k7AJyUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1378098493=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <gajerashirish@gmail.com>) id 1Yq6Pd-00025e-DV
 for lttng-dev@lists.lttng.org; Wed, 06 May 2015 16:59:33 -0400
Received: by wief7 with SMTP id f7so134374682wie.0
 for <lttng-dev@lists.lttng.org>; Wed, 06 May 2015 13:59:19 -0700 (PDT)
In-Reply-To: <CA+jJMxuBBbKarHkCMxGHUWioNeQu-Oa=14mFWP9AXT9k7AJyUA@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============1378098493==
Content-Type: multipart/alternative; boundary=047d7b5d43f6a0c1dd0515701183

--047d7b5d43f6a0c1dd0515701183
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi J=C3=A9r=C3=A9mie,

Machine where I got the error is already rebooted many times.

When you want me to launch the session daemon after getting error, after
running my script ?

Thanks.
Shirish

On Tue, May 5, 2015 at 4:13 PM, J=C3=A9r=C3=A9mie Galarneau <
jeremie.galarneau@efficios.com> wrote:

> Hi Shirish,
>
> Interesting issue. It seems that the session daemon crashed at some point
> during the execution script. Can you launch the session daemon manually i=
n
> verbose mode and provide the output along with the version of LTTng being
> used?
>
> Use:
> $ lttng-sessiond -vvv
>
> Also, can you check if a core dump is being generated?
>
> Regards,
> J=C3=A9r=C3=A9mie
>
> On Thu, Apr 30, 2015 at 12:23 PM, shirish gajera <gajerashirish@gmail.com=
>
> wrote:
>
>> Hi,
>>
>> I want to enable multiple(50) channel for the same session, below is my
>> script doing the same.
>> Single channel with the same script  is working fine. But, when I tried
>> to enable multiple channel for the same session it's giving me error.
>>
>> Here is what I found
>> 1) I have 50 channel in my db files and it's failing at 13th channel
>> create command, below is the log
>>        ...12 channel creation successful
>>        Spawning a session daemon
>>        Warning: Could not get lock file
>> /var/run/lttng/lttng-sessiond.lck, another instance is running.
>>        Error: Session daemon died (exit status 1)
>>        Spawning a session daemon
>>        Warning: Could not get lock file
>> /var/run/lttng/lttng-sessiond.lck, another instance is running.
>>        Error: Session daemon died (exit status 1)
>>        1
>>        failed!
>>
>> Let me know if question is not clear.
>>
>> my lttng script
>> --------------------------------------------
>> lttng create -o /root/data/tracing --snapshot TEST
>> while IFS=3D, read EVENTNAME CHANNELNAME BUFFERSIZE
>> do
>> lttng enable-channel --userspace --tracefile-size ${BUFFERSIZE}K
>> --tracefile-count 1 --overwrite ${CHANNELNAME}
>> lttng enable-event -u ${EVENTNAME} --loglevel ERR -c ${CHANNELNAME}
>> lttng enable-event -u ${EVENTNAME} --loglevel CRIT -c ${CHANNELNAME}
>> done < demo_lttngdb
>> lttng start
>>
>>
>> my demo_lttngdb file
>> -------------------------------------------
>> channel1,channel1,65535
>> channel2*,channel2,4096
>> channel3*,channel3,4096
>> channel4*,channel4,4096
>> channel5*,channel5,4096
>> channel6*,channel6,4096
>> channel7*,channel7,4096
>> channel8*,channel8,4096
>> channel9*,channel9,8192
>> channel10*,channel10,4096
>> channel11*,channel11,4096
>> channel12*,channel12,4096
>> channel13*,channel13,4096
>> channel14*,channel14,4096
>> channel15*,channel15,4096
>> .............
>> .............
>> .............
>> channel48*,channel48,4096
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
> J=C3=A9r=C3=A9mie Galarneau
> EfficiOS Inc.
> http://www.efficios.com
>

--047d7b5d43f6a0c1dd0515701183
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi=C2=A0<span style=3D"font-size:12.8000001907349px">J=C3=
=A9r=C3=A9mie,</span><div><span style=3D"font-size:12.8000001907349px"><br>=
</span></div><div><span style=3D"font-size:12.8000001907349px">Machine wher=
e I got the error is already rebooted many times.</span></div><div><span st=
yle=3D"font-size:12.8000001907349px"><br></span></div><div><span style=3D"f=
ont-size:12.8000001907349px">When you want me to launch the session daemon =
after getting error, after running my script ?</span><br></div><div><span s=
tyle=3D"font-size:12.8000001907349px"><br></span></div><div><span style=3D"=
font-size:12.8000001907349px">Thanks.</span></div><div><span style=3D"font-=
size:12.8000001907349px">Shirish</span></div></div><div class=3D"gmail_extr=
a"><br><div class=3D"gmail_quote">On Tue, May 5, 2015 at 4:13 PM, J=C3=A9r=
=C3=A9mie Galarneau <span dir=3D"ltr">&lt;<a href=3D"mailto:jeremie.galarne=
au@efficios.com" target=3D"_blank">jeremie.galarneau@efficios.com</a>&gt;</=
span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8e=
x;border-left:1px #ccc solid;padding-left:1ex"><div dir=3D"ltr">Hi Shirish,=
<div><br></div><div>Interesting issue. It seems that the session daemon cra=
shed at some point during the execution script. Can you launch the session =
daemon manually in verbose mode and provide the output along with the versi=
on of LTTng being used?</div><div><br></div><div>Use:</div><div>$ lttng-ses=
siond -vvv</div><div><br></div><div>Also, can you check if a core dump is b=
eing generated?</div><div><br></div><div>Regards,</div><div>J=C3=A9r=C3=A9m=
ie</div></div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote"><di=
v><div class=3D"h5">On Thu, Apr 30, 2015 at 12:23 PM, shirish gajera <span =
dir=3D"ltr">&lt;<a href=3D"mailto:gajerashirish@gmail.com" target=3D"_blank=
">gajerashirish@gmail.com</a>&gt;</span> wrote:<br></div></div><blockquote =
class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid=
;padding-left:1ex"><div><div class=3D"h5"><div dir=3D"ltr">Hi,<div><br></di=
v><div>I want to enable multiple(50) channel for the same session, below is=
 my script doing the same.=C2=A0</div><div>Single channel with the same scr=
ipt =C2=A0is working fine. But, when I tried to enable multiple channel for=
 the same session it&#39;s giving me error.</div><div><br></div><div>Here i=
s what I found</div><div>1) I have 50 channel in my db files and it&#39;s f=
ailing at 13th channel create command, below is the log</div><div>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0...12 channel creation successful</div><div><div>=C2=A0=
 =C2=A0 =C2=A0 =C2=A0Spawning a session daemon</div><div>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0Warning: Could not get lock file /var/run/lttng/lttng-sessiond.lc=
k, another instance is running.</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0Error:=
 Session daemon died (exit status 1)</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0S=
pawning a session daemon</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0Warning: Coul=
d not get lock file /var/run/lttng/lttng-sessiond.lck, another instance is =
running.</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0Error: Session daemon died (e=
xit status 1)=C2=A0</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A01</div><div>=C2=A0=
 =C2=A0 =C2=A0 =C2=A0failed!</div></div><div><br></div><div>Let me know if =
question is not clear.</div><div><br></div><div>my lttng script<br></div><d=
iv><div>--------------------------------------------=C2=A0</div><div><div>l=
ttng create -o /root/data/tracing --snapshot TEST</div><div>while IFS=3D, r=
ead EVENTNAME CHANNELNAME BUFFERSIZE=C2=A0</div><div>do</div><div><span sty=
le=3D"white-space:pre-wrap">	</span>lttng enable-channel --userspace --trac=
efile-size ${BUFFERSIZE}K --tracefile-count 1 --overwrite ${CHANNELNAME}</d=
iv><div><span style=3D"white-space:pre-wrap">	</span>lttng enable-event -u =
${EVENTNAME} --loglevel ERR -c ${CHANNELNAME}</div><div><span style=3D"whit=
e-space:pre-wrap">	</span>lttng enable-event -u ${EVENTNAME} --loglevel CRI=
T -c ${CHANNELNAME}</div><div>done &lt; demo_lttngdb</div><div><span style=
=3D"white-space:pre-wrap">	</span>lttng start</div></div><div><br></div><di=
v><br></div><div>my demo_lttngdb file</div><div>---------------------------=
----------------</div><div><div>channel1,channel1,65535</div><div>channel2*=
,channel2,4096</div><div>channel3*,channel3,4096</div><div>channel4*,channe=
l4,4096</div><div>channel5*,channel5,4096</div><div>channel6*,channel6,4096=
</div><div>channel7*,channel7,4096</div><div>channel8*,channel8,4096</div><=
div>channel9*,channel9,8192</div><div>channel10*,channel10,4096</div><div>c=
hannel11*,channel11,4096</div><div>channel12*,channel12,4096</div><div>chan=
nel13*,channel13,4096</div><div>channel14*,channel14,4096</div><div>channel=
15*,channel15,4096</div></div></div><div>.............</div><div>..........=
...<br></div><div>.............<br></div><div>channel48*,channel48,4096<br>=
</div></div>
<br></div></div>_______________________________________________<br>
lttng-dev mailing list<br>
<a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-dev@li=
sts.lttng.org</a><br>
<a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" targe=
t=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a><=
br>
<br></blockquote></div><span class=3D"HOEnZb"><font color=3D"#888888"><br><=
br clear=3D"all"><div><br></div>-- <br><div>J=C3=A9r=C3=A9mie Galarneau<br>=
EfficiOS Inc.<br><a href=3D"http://www.efficios.com" target=3D"_blank">http=
://www.efficios.com</a></div>
</font></span></div>
</blockquote></div><br></div>

--047d7b5d43f6a0c1dd0515701183--


--===============1378098493==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1378098493==--
