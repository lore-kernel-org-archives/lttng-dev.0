From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: Error while enabling multiple channel for same
	session
Date: Tue, 5 May 2015 19:13:37 -0400
Message-ID: <CA+jJMxuBBbKarHkCMxGHUWioNeQu-Oa=14mFWP9AXT9k7AJyUA__22788.6650282473$1430867699$gmane$org@mail.gmail.com>
References: <CAG77vrpmzfhZ419CV3zVt83e6B4cMoT-2xA8kvwH=aPaOLwSFQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0766230126=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qg0-f51.google.com ([209.85.192.51])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jeremie.galarneau@gmail.com>) id 1Ypm22-0003uZ-VX
 for lttng-dev@lists.lttng.org; Tue, 05 May 2015 19:13:47 -0400
Received: by qgdy78 with SMTP id y78so89790514qgd.0
 for <lttng-dev@lists.lttng.org>; Tue, 05 May 2015 16:13:37 -0700 (PDT)
In-Reply-To: <CAG77vrpmzfhZ419CV3zVt83e6B4cMoT-2xA8kvwH=aPaOLwSFQ@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: shirish gajera <gajerashirish@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============0766230126==
Content-Type: multipart/alternative; boundary=001a1147ba8c10db6705155dd41a

--001a1147ba8c10db6705155dd41a
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Shirish,

Interesting issue. It seems that the session daemon crashed at some point
during the execution script. Can you launch the session daemon manually in
verbose mode and provide the output along with the version of LTTng being
used?

Use:
$ lttng-sessiond -vvv

Also, can you check if a core dump is being generated?

Regards,
J=C3=A9r=C3=A9mie

On Thu, Apr 30, 2015 at 12:23 PM, shirish gajera <gajerashirish@gmail.com>
wrote:

> Hi,
>
> I want to enable multiple(50) channel for the same session, below is my
> script doing the same.
> Single channel with the same script  is working fine. But, when I tried t=
o
> enable multiple channel for the same session it's giving me error.
>
> Here is what I found
> 1) I have 50 channel in my db files and it's failing at 13th channel
> create command, below is the log
>        ...12 channel creation successful
>        Spawning a session daemon
>        Warning: Could not get lock file /var/run/lttng/lttng-sessiond.lck=
,
> another instance is running.
>        Error: Session daemon died (exit status 1)
>        Spawning a session daemon
>        Warning: Could not get lock file /var/run/lttng/lttng-sessiond.lck=
,
> another instance is running.
>        Error: Session daemon died (exit status 1)
>        1
>        failed!
>
> Let me know if question is not clear.
>
> my lttng script
> --------------------------------------------
> lttng create -o /root/data/tracing --snapshot TEST
> while IFS=3D, read EVENTNAME CHANNELNAME BUFFERSIZE
> do
> lttng enable-channel --userspace --tracefile-size ${BUFFERSIZE}K
> --tracefile-count 1 --overwrite ${CHANNELNAME}
> lttng enable-event -u ${EVENTNAME} --loglevel ERR -c ${CHANNELNAME}
> lttng enable-event -u ${EVENTNAME} --loglevel CRIT -c ${CHANNELNAME}
> done < demo_lttngdb
> lttng start
>
>
> my demo_lttngdb file
> -------------------------------------------
> channel1,channel1,65535
> channel2*,channel2,4096
> channel3*,channel3,4096
> channel4*,channel4,4096
> channel5*,channel5,4096
> channel6*,channel6,4096
> channel7*,channel7,4096
> channel8*,channel8,4096
> channel9*,channel9,8192
> channel10*,channel10,4096
> channel11*,channel11,4096
> channel12*,channel12,4096
> channel13*,channel13,4096
> channel14*,channel14,4096
> channel15*,channel15,4096
> .............
> .............
> .............
> channel48*,channel48,4096
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
>


--=20
J=C3=A9r=C3=A9mie Galarneau
EfficiOS Inc.
http://www.efficios.com

--001a1147ba8c10db6705155dd41a
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Shirish,<div><br></div><div>Interesting issue. It seems=
 that the session daemon crashed at some point during the execution script.=
 Can you launch the session daemon manually in verbose mode and provide the=
 output along with the version of LTTng being used?</div><div><br></div><di=
v>Use:</div><div>$ lttng-sessiond -vvv</div><div><br></div><div>Also, can y=
ou check if a core dump is being generated?</div><div><br></div><div>Regard=
s,</div><div>J=C3=A9r=C3=A9mie</div></div><div class=3D"gmail_extra"><br><d=
iv class=3D"gmail_quote">On Thu, Apr 30, 2015 at 12:23 PM, shirish gajera <=
span dir=3D"ltr">&lt;<a href=3D"mailto:gajerashirish@gmail.com" target=3D"_=
blank">gajerashirish@gmail.com</a>&gt;</span> wrote:<br><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex"><div dir=3D"ltr">Hi,<div><br></div><div>I want to enable mult=
iple(50) channel for the same session, below is my script doing the same.=
=C2=A0</div><div>Single channel with the same script =C2=A0is working fine.=
 But, when I tried to enable multiple channel for the same session it&#39;s=
 giving me error.</div><div><br></div><div>Here is what I found</div><div>1=
) I have 50 channel in my db files and it&#39;s failing at 13th channel cre=
ate command, below is the log</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0...12 ch=
annel creation successful</div><div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0Spawnin=
g a session daemon</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0Warning: Could not =
get lock file /var/run/lttng/lttng-sessiond.lck, another instance is runnin=
g.</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0Error: Session daemon died (exit st=
atus 1)</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0Spawning a session daemon</div=
><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0Warning: Could not get lock file /var/run/=
lttng/lttng-sessiond.lck, another instance is running.</div><div>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0Error: Session daemon died (exit status 1)=C2=A0</div><div=
>=C2=A0 =C2=A0 =C2=A0 =C2=A01</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0failed!<=
/div></div><div><br></div><div>Let me know if question is not clear.</div><=
div><br></div><div>my lttng script<br></div><div><div>---------------------=
-----------------------=C2=A0</div><div><div>lttng create -o /root/data/tra=
cing --snapshot TEST</div><div>while IFS=3D, read EVENTNAME CHANNELNAME BUF=
FERSIZE=C2=A0</div><div>do</div><div><span style=3D"white-space:pre-wrap">	=
</span>lttng enable-channel --userspace --tracefile-size ${BUFFERSIZE}K --t=
racefile-count 1 --overwrite ${CHANNELNAME}</div><div><span style=3D"white-=
space:pre-wrap">	</span>lttng enable-event -u ${EVENTNAME} --loglevel ERR -=
c ${CHANNELNAME}</div><div><span style=3D"white-space:pre-wrap">	</span>ltt=
ng enable-event -u ${EVENTNAME} --loglevel CRIT -c ${CHANNELNAME}</div><div=
>done &lt; demo_lttngdb</div><div><span style=3D"white-space:pre-wrap">	</s=
pan>lttng start</div></div><div><br></div><div><br></div><div>my demo_lttng=
db file</div><div>-------------------------------------------</div><div><di=
v>channel1,channel1,65535</div><div>channel2*,channel2,4096</div><div>chann=
el3*,channel3,4096</div><div>channel4*,channel4,4096</div><div>channel5*,ch=
annel5,4096</div><div>channel6*,channel6,4096</div><div>channel7*,channel7,=
4096</div><div>channel8*,channel8,4096</div><div>channel9*,channel9,8192</d=
iv><div>channel10*,channel10,4096</div><div>channel11*,channel11,4096</div>=
<div>channel12*,channel12,4096</div><div>channel13*,channel13,4096</div><di=
v>channel14*,channel14,4096</div><div>channel15*,channel15,4096</div></div>=
</div><div>.............</div><div>.............<br></div><div>............=
.<br></div><div>channel48*,channel48,4096<br></div></div>
<br>_______________________________________________<br>
lttng-dev mailing list<br>
<a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org</a><=
br>
<a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" targe=
t=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a><=
br>
<br></blockquote></div><br><br clear=3D"all"><div><br></div>-- <br><div cla=
ss=3D"gmail_signature">J=C3=A9r=C3=A9mie Galarneau<br>EfficiOS Inc.<br><a h=
ref=3D"http://www.efficios.com" target=3D"_blank">http://www.efficios.com</=
a></div>
</div>

--001a1147ba8c10db6705155dd41a--


--===============0766230126==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0766230126==--
