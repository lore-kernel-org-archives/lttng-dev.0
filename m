From: Anand Neeli <anand.neeli@gmail.com>
Subject: Re: sessiond and consumerd for 32 and 64 bit apps
Date: Wed, 8 Oct 2014 18:24:55 +0530
Message-ID: <CAM5kDqwSE4960TeRDg8tJdV_q=7-_3YttR1A8YPwQQYcus5LXA__38941.5562306114$1412772945$gmane$org@mail.gmail.com>
References: <48CF5AC71E61DB46B70D0F388054EFFD5A23A757@VAL-E-01.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0726019959=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <anand.neeli@gmail.com>) id 1Xbqlh-0006sf-A3
 for lttng-dev@lists.lttng.org; Wed, 08 Oct 2014 08:55:04 -0400
Received: by mail-wi0-f172.google.com with SMTP id n3so10483022wiv.5
 for <lttng-dev@lists.lttng.org>; Wed, 08 Oct 2014 05:54:55 -0700 (PDT)
In-Reply-To: <48CF5AC71E61DB46B70D0F388054EFFD5A23A757@VAL-E-01.valcartier.drdc-rddc.gc.ca>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============0726019959==
Content-Type: multipart/alternative; boundary=001a11c24c4491fb4d0504e8d247

--001a11c24c4491fb4d0504e8d247
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

Yes the problem looks to be with relay daemon. Tracing for 32-bit and
64-bit works fine when written to local storage.
Is there any known issue for this? or is there any work around for this.
I will update this thread with logs of relayd with -vvv option.


Thanks,
Anand Neeli

On Wed, Oct 8, 2014 at 12:56 AM, Thibault, Daniel <
Daniel.Thibault@drdc-rddc.gc.ca> wrote:

>    One other thing: try the same test without using lttng-relayd, that is
> to say, write the test trace to local storage.  If that trace captures bo=
th
> 32- and 64-bit events, the problem is with your relay daemon.
>
> Daniel U. Thibault
> Protection des syst=C3=A8mes et contremesures (PSC) | Systems Protection =
&
> Countermeasures (SPC)
> Cyber s=C3=A9curit=C3=A9 pour les missions essentielles (CME) | Mission C=
ritical
> Cyber Security (MCCS)
> RDDC - Centre de recherches de Valcartier | DRDC - Valcartier Research
> Centre
> 2459 route de la Bravoure
> Qu=C3=A9bec QC  G3J 1X5
> CANADA
> Vox : (418) 844-4000 x4245
> Fax : (418) 844-4538
> NAC : 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
> Gouvernement du Canada | Government of Canada <
> http://www.valcartier.drdc-rddc.gc.ca/>
>

--001a11c24c4491fb4d0504e8d247
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Daniel,<div><br></div><div>Yes the problem looks to be =
with relay daemon. Tracing for 32-bit and 64-bit works fine when written to=
 local storage.</div><div>Is there any known issue for this? or is there an=
y work around for this.</div><div>I will update this thread with logs of re=
layd with -vvv option.</div><div><br></div><div><br></div><div>Thanks,</div=
><div>Anand Neeli=C2=A0</div></div><div class=3D"gmail_extra"><br><div clas=
s=3D"gmail_quote">On Wed, Oct 8, 2014 at 12:56 AM, Thibault, Daniel <span d=
ir=3D"ltr">&lt;<a href=3D"mailto:Daniel.Thibault@drdc-rddc.gc.ca" target=3D=
"_blank">Daniel.Thibault@drdc-rddc.gc.ca</a>&gt;</span> wrote:<br><blockquo=
te class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc so=
lid;padding-left:1ex">=C2=A0 =C2=A0One other thing: try the same test witho=
ut using lttng-relayd, that is to say, write the test trace to local storag=
e.=C2=A0 If that trace captures both 32- and 64-bit events, the problem is =
with your relay daemon.<br>
<div class=3D"HOEnZb"><div class=3D"h5"><br>
Daniel U. Thibault<br>
Protection des syst=C3=A8mes et contremesures (PSC) | Systems Protection &a=
mp; Countermeasures (SPC)<br>
Cyber s=C3=A9curit=C3=A9 pour les missions essentielles (CME) | Mission Cri=
tical Cyber Security (MCCS)<br>
RDDC - Centre de recherches de Valcartier | DRDC - Valcartier Research Cent=
re<br>
2459 route de la Bravoure<br>
Qu=C3=A9bec QC=C2=A0 G3J 1X5<br>
CANADA<br>
Vox : (418) 844-4000 x4245<br>
Fax : (418) 844-4538<br>
NAC : 918V QSDJ &lt;<a href=3D"http://www.travelgis.com/map.asp?addr=3D918V=
%20QSDJ" target=3D"_blank">http://www.travelgis.com/map.asp?addr=3D918V%20Q=
SDJ</a>&gt;<br>
Gouvernement du Canada | Government of Canada &lt;<a href=3D"http://www.val=
cartier.drdc-rddc.gc.ca/" target=3D"_blank">http://www.valcartier.drdc-rddc=
.gc.ca/</a>&gt;<br>
</div></div></blockquote></div><br></div>

--001a11c24c4491fb4d0504e8d247--


--===============0726019959==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0726019959==--
